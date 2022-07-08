Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A355056C0DC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238301AbiGHSEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 14:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbiGHSEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 14:04:00 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCCB7B35A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 11:03:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFHuoObfRynuK2w8VUj4Cn6OCDTIo1xJWCSAYyRbE4L27WspQj520QmzoHZu0SW1ukKYQBahSwRlMUTBDqBPiP9pNCd7oaOGERwoaGxcc+QKLME1A5vP7Dq7stw+9tX6TG4+cpyuZ2Kk4MVn2iMwc7miu9TQ7b+BepaDjZkzw1xB8aJT6mhAa9qEN7dpYotAG1hdA7Dd4RFaStZe/4rt0IoDpmn7W2VagnRVzaDaOaKiRJT+IGy0VQFz7AF+5FW/99BsAgP/z+9LmEWRSMrQwgJG97nsdWdcs4pg5Y5IRF4XboFnmPubleajeCTE3VID4B3IwjKjzDtlqoI5tnvNGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vQFuujF4G2j5lrGU8WUdO6LBJuOthE17bQpgSAfTDY=;
 b=asBv4EhIqpi+QFRxxK3CJaygrEfdjkJWJQw4jLahEIdOQfYN4MBkgxJTLLMXfRuxNVCPOCTERzCvsf7mhLLszVQaY+E6qVv6oCUkJZrKOv1/KtGXuiq3Im4EwwD9hA1YsMCXc8MZY4chcxJr5vErorfWAqCrPTukP2jMq2i62fNwGGTHlUdsWW+dVdLaHlVLcaVIJ8CpA0IM7AbYluAAq9rD55DcQJPIXZ9H2sxqoKizIjAixkZjcYs0JIzsbW8YnJK7GEgcTBvdEJx0gBVcfAFWO7BV95/UpIGrFfoAN9gcSNj2JyEpjMgPjR0V3UKi8q5cD/LCTNjDPewc3zpO+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vQFuujF4G2j5lrGU8WUdO6LBJuOthE17bQpgSAfTDY=;
 b=tDuHZamiyfF9N5adR/Mxuvv2qSZyfRY+lR7v0/r5hV+czKcknhAzE+ljIvl65gsG/Jtc8m69zgKSaYrjYcye7qgiXW4wgWOBhIpuV1LB3Any2xbbwj0mQl9V8BcFfJEemYEFZqYPMODyrES7HawqnnQVOV0w7zWFrERgl9Akwpc=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BN8PR05MB6660.namprd05.prod.outlook.com (2603:10b6:408:4f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.14; Fri, 8 Jul
 2022 18:03:53 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f%6]) with mapi id 15.20.5417.021; Fri, 8 Jul 2022
 18:03:53 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] x86/mm/tlb: ignore f->new_tlb_gen when zero
Thread-Topic: [PATCH] x86/mm/tlb: ignore f->new_tlb_gen when zero
Thread-Index: AQHYkqF/mvVmWIh+yUS8DjEvdZIjBK10WcwAgAA7bICAABxnAIAAAeOAgAACVoCAAA8OAA==
Date:   Fri, 8 Jul 2022 18:03:53 +0000
Message-ID: <A4BA2F87-EAE8-4026-9624-00290FBE6108@vmware.com>
References: <20220708003053.158480-1-namit@vmware.com>
 <b573a9c6-2ee0-20dc-1f28-84d3a81d40a2@redhat.com>
 <283d7660-000a-81af-1d6b-4fdedcb6dfd8@intel.com>
 <A604C6DA-5E5D-43F1-B63F-EF9D145CACCE@vmware.com>
 <a486ad3f-8fb6-c37b-9e7e-c6ba1a841b57@intel.com>
 <3276DF39-328E-497A-9EF4-A2A348C19D92@vmware.com>
In-Reply-To: <3276DF39-328E-497A-9EF4-A2A348C19D92@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a2ff804-3cf8-4f8a-f70e-08da610c37d7
x-ms-traffictypediagnostic: BN8PR05MB6660:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nhV/k8nTeWJi2tYAV8dlTOci77o2nwJzZDDuQ3JHL3nsI3HzIWooTkYIMADCor+Nd8T5iA3rKcLoEoymxSZgQneFqBQo7+91lmZwXJtC9OQyflQiDDOfe4uEnIeGUuKWnSkN4tKni+ZVzZQ9KumTkTFRXCcFid/C2yRfEi78LMfxGXDnpiXJ3bjOZIW5VGnbzqSdQiUVhDUkOsDazXOSBUor+HfXLPj1ez/KrF2t7L5MgvOBI74f1GlD02CoDDpAdyBnrHhk61rGSDts2PN4lxnO/rNPWdK6HoVhntTUk4mkm2C9qGGIABp4D5xwJzYJlKf04cP50PVVpn/rUORrE5TzxpfkUm9w1MOkO9DbrqNPpcZdNd4ecENMlSaUNCRxltd5MULXOCey/Zm8SXjW5219iuAoISIadBZbzFF5PmJeGxvZKjfq0znz9DS5mgxd3Se14a3RFfWRKdDQdl8NojcBbc+37ny7h313c99KFmlWBsI/Dh6LHFViaTij8TnFTmoiNQQHtgFUM2Yj/M3wiGM9mPyxj4sJBwcj0eGICo3LPB5odoGVA4L0OhN6/I+5TLuUKPgN70Uvkc48Ilfk7hdWdWkGjmPPQZlks5YdU/3Cbjw7VcmpGLpMHmtYbtLUX2SRLxb2XGqcyqoz3uhAa1OUENcIIr+tcV8haHEaweJPi7gY6FbhFmDDhrQoob7DJQDbrU/i/76YYmAN92Lxoxg7MEibPhqERpB9Nwkfub/Q3w9vYzWbY81eHlLD9/QX1712AJpjRTKOUM6WLuFuWP9tV5gZLsmu/zeBj6wNjSacnuNebaBlSZuny6eGAhKtgdynVm40T7CKUYlON4vsn1uhmxnixFt8vE10r5E9ubotwuOXdb3b/6sTYkpPBmBT1BpELczTLAV5YcG7PXJFsg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(54906003)(6916009)(8936002)(66476007)(316002)(38100700002)(66446008)(122000001)(478600001)(41300700001)(36756003)(53546011)(33656002)(45080400002)(6506007)(6486002)(6512007)(38070700005)(26005)(64756008)(71200400001)(5660300002)(7416002)(2906002)(76116006)(4326008)(86362001)(66946007)(8676002)(2616005)(83380400001)(66556008)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTZLeUxoK3lOa08rTWhZTjNtNE83UjV6UkFoazVaVUNHWTRjVWwvdWpuUTNX?=
 =?utf-8?B?d2t2ckducnd3cTFmSU01c0hTMlBRMzdtUUVZY3dxaFBveHcxeG44dkozeFFk?=
 =?utf-8?B?NmtMN3JOQ0E3bXpsUVZiV3pKbFcxY0VXOFFKZDY3b0wra3FLU0NtNUV3Mlkv?=
 =?utf-8?B?eTVXN2FENkpJQ1ptK3R1aXpBRjZVK0tHdTIweWluV2s2Y1BOVXJyOGE3S3Fv?=
 =?utf-8?B?eXF4VlNSMzc3SnE2dVZiZW1sNUhmaVN6UWFxU0hXclM5ZHpRdVdOWWdpeGp5?=
 =?utf-8?B?ajdPV1ZFTTcyK3QyMEg1QlM1NGt3d2lpc3d2YzBQSnFiWG5SMkcrWVNydjhV?=
 =?utf-8?B?RXk2U2F1Um92ZjJtUzVrRGFKWEg4YW1tNTNzWXdEWkRJKyt6UXdOVlZKQmVr?=
 =?utf-8?B?V0ZVZDg3RkdFSDFiWjdCdERuWWp2N2hKZ0kvSTY0Qk5lQmlHRzFwak1DelFt?=
 =?utf-8?B?SCtwUC83QmZjYVcxODJlMEpjYTFyUjZITlpBa1ZyejNIS1crWG5qN3Y0MmZG?=
 =?utf-8?B?amxpVFBkU1dOMVdTbVZtbkxaN2tmcTN1d2hObVEzdDJmVW5FZWJGT0xRRjcx?=
 =?utf-8?B?SytzRzZQV0xrWVhmYTZhTS8rYVMzVHRaMlRSV2ltVTVDVkREVkN4ZmR1LzRm?=
 =?utf-8?B?eFdIbnJGNWEwbFExaC9aSjV1eEYwUEg5VmpCRTY4NnBpdE1BYWo5NjJ0N2lm?=
 =?utf-8?B?S1lMNG5yQ05WeXVVNGRSSGF0emlYU1h1Z0pWeHBhREE5dVhrZUZTOEdyTjIx?=
 =?utf-8?B?N3JzSUZEbnpDVjZrcVh3a1RsNFFyNVBLNHpnUUptR25Ka1pkcjdzbVBKSFFw?=
 =?utf-8?B?THFUTDdRc0hYNGczMDlEZWptOUMvdnpzRmdxeW1RWlVRaG5xRTEvR0NDY1N1?=
 =?utf-8?B?UXNPcTJocGhQYjhkLzF4T0NtV24rRXpGUmM1aTNwYUNrNlA4VHIvMVh0aGdl?=
 =?utf-8?B?eXUxMGlPR3U3Wm1kUkRHN1RuVTBLa1Q4VG9CbE1UTlJkM2c5cE9HSUxvWHFn?=
 =?utf-8?B?eXlwM2c0dityaXJpMVg2UHgyOHhOQktkV05QZVBoWFl3bk9MNnprUkx6ZEhS?=
 =?utf-8?B?dVFoWkxLdGxVTGhYZzErOTdhcDBQd1lFNVRGQkRjajJBL0hNelQ2S2NIY21Y?=
 =?utf-8?B?Zjl6bWZYUnh5b0VDUUtvbTk2Qk5xL0JqelNuM3dGakNCakxyUUpEOU16OGg1?=
 =?utf-8?B?Z3c3NUQ3YlJJZW9TN0lad0lWUm1ZVmlmdUxZN0s5UkZFSHpzbCtUdGFrSEY5?=
 =?utf-8?B?NHJXdElVeFFaOGxDMzlFdGN4ditDVWJGcXNFcnRHQnRBdHU0ZUJzY2JCZkRQ?=
 =?utf-8?B?OVcyYUFFR3NoRmFKWWJkYlZsUzhLcUhwWE1sWGRKYWlPWll1d2lHdTUxcFBl?=
 =?utf-8?B?UE9Ta0J5ZWJoeUs3eVkrZDRpTWZMY3VQTitqb0tWYTNUL256dUp6QkxJZHhP?=
 =?utf-8?B?RmpkdWtZRFVlY0svUkl0Uysxb0ZLL3ZSQzNuYmM5WXFSeTQ4MHJZdkxDRDF5?=
 =?utf-8?B?dUE5VGpPQzNxdVpaV3NEOHpyOWxocEdoRElXbmhMUDUyc2RnalVCV0tPTUFQ?=
 =?utf-8?B?UWdxZG8xeVRjWVp4THdJRFE3eWthd0pFZjk1NUZuRnJJU2lLaTJtLzhiWk1O?=
 =?utf-8?B?WVVBNkJ4cU9BZnNvYmd4YXdEYmJqc0VycHh1amY2QlpibEY1L2U4eUpnVUs5?=
 =?utf-8?B?THV1T0lKM3lCcUlvdWlkQTVENm04YnFCdHVRTmdCYm52dk1ac0NyQmNmWUNV?=
 =?utf-8?B?VmpGdlJrMVhsUktiM1pTcm9DOTI1YjBkR2xHMk9OVDkvb3ZUanY1WW0rcG9N?=
 =?utf-8?B?cE5qVm5KMW4rT2ZrbTB4dWVqelRWeE1xUFl6TjJzOXdVUWtFU3NKekVMQ3ZH?=
 =?utf-8?B?bkMrMDZ4d0ozeXVXakVXTDdrK2NEckIxeTZQU1hGYkV5RWZGdWJzNUlHdWkw?=
 =?utf-8?B?YzJmR2FacXdpNVc4elNUa3lNV0MwUkt3TE5NVEVwb0luRUlZOW5kUitKUXBD?=
 =?utf-8?B?MWd3MFRibjhTbWd3NkorSmZORXBXTG1TZEp0Q0pFZ09jeVNQaWFQcEI4bk1l?=
 =?utf-8?B?WnBkRXI0RTQ0eXFoRVVCOS9hQ3dPWDJCRmZZcERTMkduUmFyQ2JFQkxvL0ZE?=
 =?utf-8?Q?0nCEMguiFt7gPjfI5osUxV7aZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33F4480638C2784CB55AD661FB56B640@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2ff804-3cf8-4f8a-f70e-08da610c37d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 18:03:53.0592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MU5WpNdNCXjqlV8f3xN8tWEovK1OE8JVwgXzjY05Z+vLp03aW7xXBz+ibVhgZZRxB7IEhO2NKyWVrJ9WWsJNJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR05MB6660
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gSnVsIDgsIDIwMjIsIGF0IDEwOjA5IEFNLCBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29t
PiB3cm90ZToNCg0KPiBPbiBKdWwgOCwgMjAyMiwgYXQgMTA6MDEgQU0sIERhdmUgSGFuc2VuIDxk
YXZlLmhhbnNlbkBpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4+IOKaoCBFeHRlcm5hbCBFbWFpbA0K
Pj4gDQo+PiBPbiA3LzgvMjIgMDk6NTQsIE5hZGF2IEFtaXQgd3JvdGU6DQo+Pj4gU2luY2UgdGhl
IGJ1ZyB3YXMgbm90IGR1cmluZyBNQURWX0RPTlRORUVEIHRoZXJlIGlzIG5vIHJlYXNvbiBmb3Ig
dGhlDQo+Pj4gcmVzdWx0cyB0byBiZSBhbnkgZGlmZmVyZW50Lg0KPj4+IA0KPj4+IEZhbW91cyBs
YXN0IHdvcmRzPw0KPj4gDQo+PiBDb25zaWRlcmluZyB0aGF0IHlvdXIgcGF0Y2ggYnJva2UgdGhl
IGtlcm5lbCBhIHdheSB0aGF0IHN1cnByaXNlZCB1cw0KPj4gYWxsLCBJIHRoaW5rIGNhdXRpb24g
aXMgd2FycmFudGVkLiAgUmUtcnVubmluZyBhIG1pY3JvYmVuY2htYXJrIHRoYXQNCj4+IHRha2Vz
IGZpdmUgbWludXRlcyBhbmQgc3RyZXNzZXMgdGhpbmdzIGEgYml0IGlzIHRoZSBsZWFzdCB5b3Ug
Y2FuIGRvLCBJDQo+PiB0aGluay4NCj4gDQo+IEkgd2lsbCBzZW5kIGl0IGxhdGVyIHRvZGF5LiBJ
IHdhcyBqdXN0IHBvaW50aW5nIHRoYXQgdGhlIGZhaWxpbmcgY29kZS1wYXRoDQo+IGlzIGRpZmZl
cmVudCB0aGFuIHRoZSBvbmUgSSBtZWFzdXJlZC4NCg0KSXQgd2lsbCB0YWtlIHNvbWUgbW9yZSB0
aW1lLCBzaW5jZSA1LjE5IGRvZXMgbm90IHdhbnQgdG8gYm9vdCBvbiBteSBtYWNoaW5lLA0KYW5k
IHJlc3VsdHMgZnJvbSBWTXMgYXJlIG1lYW5pbmdsZXNzIGZvciB0aGlzIHBhdGNoLiBJIHdvdWxk
IGxvb2sgaW50byB0aGlzDQp1bnJlbGF0ZWQgZmFpbHVyZSwgdW5sZXNzIHlvdSB3YW50IHJlc3Vs
dHMgZnJvbSA1LjE4Lg0KDQpbICAgIDYuMzAzOTQ1XSAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0t
LS0tLS0tLS0tLS0NClsgICAgNi4zMDkyMDldIGtlcm5lbCBCVUcgYXQgYXJjaC94ODYva2VybmVs
L2FwaWMvYXBpYy5jOjE1OTghDQpbICAgIDYuMzE1NTM3XSBpbnZhbGlkIG9wY29kZTogMDAwMCBb
IzFdIFBSRUVNUFQgU01QIFBUSQ0KWyAgICA2LjMyMTI3NV0gQ1BVOiAwIFBJRDogMCBDb21tOiBz
d2FwcGVyLzAgTm90IHRhaW50ZWQgNS4xOS4wLXJjNFRMQisgIzUNClsgICAgNi4zMjg3NjBdIEhh
cmR3YXJlIG5hbWU6IERlbGwgSW5jLiBQb3dlckVkZ2UgUjYzMC8wQ05DSlcsIEJJT1MgMi45LjEg
MTIvMDQvMjAxOA0KWyAgICA2LjMzNzIzNl0gUklQOiAwMDEwOnNldHVwX2xvY2FsX0FQSUMrMHgz
MWUvMHgzMzANClsgICAgNi4zNDI2ODZdIENvZGU6IDAxIDBmIDg1IDA1IGZmIGZmIGZmIDg1IGQy
IDdmIDJiIDQ4IDhiIDA1IGFhIDM3IDRmIDAxIGJlIDAwIDA3IDAxIDAwIGJmIDUwIDAzIDAwIDAw
IDQ4IDhiIDQwIDEwIGU4IDM3IDk5IGZiIDAwIGU5IDA0IGZmIGZmIGZmIDwwZj4gMGIgZTggNWIg
MmQgYmUgMDAgZTkgYmEgNjQgYjggMA0KWyAgICA2LjM2MzgxOF0gUlNQOiAwMDAwOmZmZmZmZmZm
ODI2MDNlODggRUZMQUdTOiAwMDAxMDI0Ng0KWyAgICA2LjM2OTc1Ml0gUkFYOiAwMDAwMDAwMDAw
MDAwMDAwIFJCWDogMDAwMDAwMDAwMDAwMDAwMCBSQ1g6IDAwMDAwMDAwMDAwMDAwMDANClsgICAg
Ni4zNzc4MjBdIFJEWDogMDAwMDAwMDAwMDAwMDAwMCBSU0k6IDAwMDAwMDAwZmZmZmZlZmYgUkRJ
OiAwMDAwMDAwMDAwMDAwMDIwDQpbICAgIDYuMzg1ODg4XSBSQlA6IDAwMDAwMDAwMDAwMDAwMDAg
UjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogZmZmZmZmZmY4MjYwM2RhOA0KWyAgICA2LjM5Mzk1
Nl0gUjEwOiAwMDAwMDAwMDAwMDAwMDAxIFIxMTogMDAwMDAwMDAwMDAwMDAwMSBSMTI6IDAwMDAw
MDAwMDAwMDAwMzENClsgICAgNi40MDIwMjRdIFIxMzogMDAwMDAwMDAwMDAwMDAwMCBSMTQ6IGZm
ZmZmZmZmODI2MTMxMTggUjE1OiAwMDAwMDAwMDAwMDAwMDAwDQpbICAgIDYuNDEwMDkxXSBGUzog
IDAwMDAwMDAwMDAwMDAwMDAoMDAwMCkgR1M6ZmZmZjg4OWZmZjYwMDAwMCgwMDAwKSBrbmxHUzow
MDAwMDAwMDAwMDAwMDAwDQpbICAgIDYuNDE5MjUwXSBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAw
MDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzDQpbICAgIDYuNDI1NzY1XSBDUjI6IGZmZmY4OGMwN2Zm
ZmYwMDAgQ1IzOiAwMDAwMDAwMDAyNjBjMDAxIENSNDogMDAwMDAwMDAwMDA2MDZmMA0KWyAgICA2
LjQzMzgyNl0gQ2FsbCBUcmFjZToNClsgICAgNi40MzY2NDZdICA8VEFTSz4NClsgICAgNi40Mzkw
NzddICA/IF9wcmludGsrMHg1My8weDZhDQpbICAgIDYuNDQyNzc3XSAgYXBpY19pbnRyX21vZGVf
aW5pdCsweGQyLzB4ZjENClsgICAgNi40NDc0NDhdICB4ODZfbGF0ZV90aW1lX2luaXQrMHgxYi8w
eDJiDQpbICAgIDYuNDUyMDE5XSAgc3RhcnRfa2VybmVsKzB4NWQ4LzB4Njk0DQpbICAgIDYuNDU2
MTk0XSAgc2Vjb25kYXJ5X3N0YXJ0dXBfNjRfbm9fdmVyaWZ5KzB4Y2UvMHhkYg0KWyAgICA2LjQ2
MTkzM10gIDwvVEFTSz4NClsgICAgNi40NjQ0NjNdIE1vZHVsZXMgbGlua2VkIGluOg0KWyAgICA2
LjQ2Nzk3OV0gLS0tWyBlbmQgdHJhY2UgMDAwMDAwMDAwMDAwMDAwMCBdLS0tDQpbICAgIDYuNDcz
MjQzXSBSSVA6IDAwMTA6c2V0dXBfbG9jYWxfQVBJQysweDMxZS8weDMzMA0KWyAgICA2LjQ3ODcw
NF0gQ29kZTogMDEgMGYgODUgMDUgZmYgZmYgZmYgODUgZDIgN2YgMmIgNDggOGIgMDUgYWEgMzcg
NGYgMDEgYmUgMDAgMDcgMDEgMDAgYmYgNTAgMDMgMDAgMDAgNDggOGIgNDAgMTAgZTggMzcgOTkg
ZmIgMDAgZTkgMDQgZmYgZmYgZmYgPDBmPiAwYiBlOCA1YiAyZCBiZSAwMCBlOSBiYSA2NCBiOCAw
DQpbICAgIDYuNDk5ODY1XSBSU1A6IDAwMDA6ZmZmZmZmZmY4MjYwM2U4OCBFRkxBR1M6IDAwMDEw
MjQ2DQpbICAgIDYuNTA1ODAzXSBSQVg6IDAwMDAwMDAwMDAwMDAwMDAgUkJYOiAwMDAwMDAwMDAw
MDAwMDAwIFJDWDogMDAwMDAwMDAwMDAwMDAwMA0KWyAgICA2LjUxMzg4N10gUkRYOiAwMDAwMDAw
MDAwMDAwMDAwIFJTSTogMDAwMDAwMDBmZmZmZmVmZiBSREk6IDAwMDAwMDAwMDAwMDAwMjANClsg
ICAgNi41MjE5NjldIFJCUDogMDAwMDAwMDAwMDAwMDAwMCBSMDg6IDAwMDAwMDAwMDAwMDAwMDAg
UjA5OiBmZmZmZmZmZjgyNjAzZGE4DQpbICAgIDYuNTMwMDUzXSBSMTA6IDAwMDAwMDAwMDAwMDAw
MDEgUjExOiAwMDAwMDAwMDAwMDAwMDAxIFIxMjogMDAwMDAwMDAwMDAwMDAzMQ0KWyAgICA2LjUz
ODEzNl0gUjEzOiAwMDAwMDAwMDAwMDAwMDAwIFIxNDogZmZmZmZmZmY4MjYxMzExOCBSMTU6IDAw
MDAwMDAwMDAwMDAwMDANClsgICAgNi41NDYyMThdIEZTOiAgMDAwMDAwMDAwMDAwMDAwMCgwMDAw
KSBHUzpmZmZmODg5ZmZmNjAwMDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDANClsgICAg
Ni41NTUzOTFdIENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAw
MzMNClsgICAgNi41NjE5MTldIENSMjogZmZmZjg4YzA3ZmZmZjAwMCBDUjM6IDAwMDAwMDAwMDI2
MGMwMDEgQ1I0OiAwMDAwMDAwMDAwMDYwNmYwDQpbICAgIDYuNTcwMDAzXSBLZXJuZWwgcGFuaWMg
LSBub3Qgc3luY2luZzogQXR0ZW1wdGVkIHRvIGtpbGwgdGhlIGlkbGUgdGFzayENClsgICAgNi41
Nzc1OTFdIC0tLVsgZW5kIEtlcm5lbCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBBdHRlbXB0ZWQgdG8g
a2lsbCB0aGUgaWRsZSB0YXNrISBdLS0t
