Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99968595CE8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbiHPNMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235674AbiHPNML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:12:11 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB8AB2842
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:12:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuorFwCeLB++6JZymCJc9QXY3u7/niAGKQpYsZkmXx2yM1KzjyqtyeMfMGXTTS2snqNv+DxSPcBH/sBKc/dNe+aybia6VJjjX14e+6CrCbWJRwrUXQhR5bQXSNPtgkUySL4OQYdWVUpcVimy1r4pt1UA+/2gluj0M+lLkYHBIfwOyKHaf7tju9rS4WZhPLLhbrqeSTtIsDfkyym1FBckPbCQ3sc1/5mc1oA14SJTScFbhdg+0Eb2apOMtg9hbfc+sRRzsPLbGwIG1zPAXgElgHhCH5SkY0X4OvbSwVUQuzpO99vVRHiB7j42+mTYwOQsHv0UCbSSiUTiqjwu4DDqfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAKFEKL+NU2As8zMtVxKk8x09SLwKBATMH9/eaYsWPs=;
 b=oDYnnT7iKCm/KtIghs+T7U0KE8Kcnyl9IaEP7Li/tDORVJW9TiEv8fkmWakGA5ZiIS/q7bsjVqBx2E5VkK5zeK7CLBLWmOFXoW894AAcMORP94HnKhlBBGbGsi29uImCsmOWoDcuCuNK6QO/JKf1kpw/LNr3/O+mgtpfx8TPn1MGABIN2YSyBFQa9espnJMMLqEUtP95nub03OO7M30TFBhzDH/rFdNQ+oER+JBlthhW4GF1mqlHhjHy2Rmg+QCRN7g2eEV7J6aCqtW4u/WotoPkwYwa1rIQnFDX0CgSVhCjbxSoIw7wqXXahPo8ms12lknwHwN89+WNsVQWl7tnVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAKFEKL+NU2As8zMtVxKk8x09SLwKBATMH9/eaYsWPs=;
 b=HyEXLCbJBKSX6Nn8Bec1LHJhoT4eLsXuUsQvkcNN95AGWqPQzS8HE/GQDGWqxEwuvPS8vKx6gQNxCHByzVCCIHz0Ag7SVSFFtBCC1sNfLSoSx90q7EmMQp0xVy5SOP7SoY5NXcRjW9H89ABItlxM5t36l9KOxm9TKzD3uKv3g11VZBnu01sIAg1aNhTludvVSQ2fH3MTPB4k2ecJznIU1Yxrj2ad5OUNJNAg/YliZujyTUAbVkUud+ioajJ4iy3SaeZCX4KrBrnEbWF4TRuVNZbUaVRvpnusNh7PXSymx8U8cSQe7oc74IDiNihzY3wV7u0Ko5hPcHIXDsPunp1nMQ==
Received: from DM5PR12MB4663.namprd12.prod.outlook.com (2603:10b6:4:a9::26) by
 BN6PR12MB1490.namprd12.prod.outlook.com (2603:10b6:405:f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.17; Tue, 16 Aug 2022 13:12:08 +0000
Received: from DM5PR12MB4663.namprd12.prod.outlook.com
 ([fe80::b4ab:4d63:1cdd:b051]) by DM5PR12MB4663.namprd12.prod.outlook.com
 ([fe80::b4ab:4d63:1cdd:b051%4]) with mapi id 15.20.5504.025; Tue, 16 Aug 2022
 13:12:08 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Ira Weiny <ira.weiny@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] nvmet-tcp: Don't kmap() pages which can't come from
 HIGHMEM
Thread-Topic: [RFC PATCH] nvmet-tcp: Don't kmap() pages which can't come from
 HIGHMEM
Thread-Index: AQHYsVEedeiw0ct5d0K1OQCxtBxFsK2xgPEA
Date:   Tue, 16 Aug 2022 13:12:08 +0000
Message-ID: <3e8a0bb1-4c69-93d2-71f9-81bb8466cb14@nvidia.com>
References: <20220816091808.23236-1-fmdefrancesco@gmail.com>
In-Reply-To: <20220816091808.23236-1-fmdefrancesco@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c236f3b-77d7-4272-11d8-08da7f88ec63
x-ms-traffictypediagnostic: BN6PR12MB1490:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dmvYcIX/z2ImMLCAymdNepK9tHfpj56x7ghCNWg9NYeyR8kWyH9+f7mLQQ+SUjjl02+PM/TX3hKe0cUrcY/yBNRG1Weh5f/Zscq2rRpLYS9nXvLTWi3ZU+uRtr52TUXbrw5+i3ch9YB7NqCg6cQ53esZs9gRiu+Bxg2+AYWo2dH4gfeMxZUhnDI07mLFwotbJdBg6AqExP+72w6Ss36HK2Pcjb4CGO4NDXaHFCRKyMbInnuKUJSHbtgVsb8He5k/ExFSSTVB9l3pzlVfmhP0JbYnUlOSQ0Aog6hhPXlcKnLxjhHa62/n/GkMwqr2YsMWqgKtjjPr7yq7UWe57XwJ/b75LiskFOJUkix92X0NWrOkrqcUSFHAaS4WCXxXhfXxVBLoNLzi1Fz96w6ZYyLQpI6HV1XhW0VqgRglesKfPI23D/h+ygEjnrWgerRogIJGnXDh0lrgZYAo6UZdXjuuwSex5I4TLIheqDOa6J9t76t9HgC3n1JKlaYBAlT3HrDnTTgPZBjbTBAGvIxCiP5DF6R8hAle41QUYCNPrDqNbcGQAW0h5iRH2pGMrZ1/aQMXuQfZb3AiDeKIKA4dvzOWdfa5qpQa/9kiPAVHTZbS7c5H5FqYZ6siWOfgETp31IHNMLqz1LCW9a0/UZ+KDE2EXvt+eP+bWfE6xQYVinXReKm3JK22O8uACGx+hWMnyuKSpR5yhGVsCLsEsfisGpXxs6oxMHAuIa6AeMklNClB7urjHd8VDDa7ExS47+otIoMHcJRw4cUPkSUmkz945F1ouXqNR7K7AnWp6A52q8OReul2/9u6nrQbQRU86RW1QPBlMXWqBZfW9FvJDzpUjJhym/WAVOE5uQ2Y5PZ8ZR3MGo05h/b1NqF+/kjn1r5pV/WD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB4663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(186003)(38070700005)(2616005)(38100700002)(76116006)(66946007)(83380400001)(122000001)(5660300002)(91956017)(8936002)(4326008)(71200400001)(53546011)(41300700001)(66446008)(66556008)(66476007)(8676002)(64756008)(478600001)(2906002)(86362001)(6512007)(6486002)(6506007)(316002)(6916009)(54906003)(31696002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkJiQkc2SUFYK0lsY010NEtXK3FCYVU1dUlhS25JcW82b25PQU5OaGpVeVU4?=
 =?utf-8?B?VHhQYWw3K0hEZXl0QkNXTG1jZjk5ZTZtVVdnTzBnQkdCWTZuaTA2YUl6S0N2?=
 =?utf-8?B?UUNWNjg3REdCODJtKyt0MEhBWXRCZkY1bnhHenY1eGJnamhTNFFuS1U1bkZ1?=
 =?utf-8?B?K21xRitpRGUzaXFRa3JUL3E3YkZLT2p6dFRIeSsxOWxhbjJiR3pHVWdZME9y?=
 =?utf-8?B?QkREMVBsR2V3RW8xbXdkT2xqZ0dFaUUyNElUbURGNit1U2JXbG5BOWU4Zzl3?=
 =?utf-8?B?SW92dmNqd2FhT000U2Y3RmJuclpCZ0JvMGZ1a1piZ1NBMnYxN2MwQmNSTHRo?=
 =?utf-8?B?ZzB3L0cycHpGZmRVWEI1YmVqU3hROTgzbzBrcEhDa0NyazZiYWNrWnJSSjJZ?=
 =?utf-8?B?VGliYXJqa2wzTmxlS0xZTGlCbXJVeE1PT3ZleUJqQlNXL3BpU3VCOFRDZGdO?=
 =?utf-8?B?Wm1jYzVwbFZtOEJmbEMyUHJhOUdQeHRFYWxSazA1UzI2TGZOQ0x4QjJRRk0x?=
 =?utf-8?B?WnZVWTdSOFRZQldsRThjMjhySHdITFpxbExYTStnK0NPVi9pY0J4ajl1Vjgz?=
 =?utf-8?B?VWJWczdqQzZCS2U3YTMyMEZ4M1hzK2pESE1CbXMxWlpnTGpEVG1DeEwwajBm?=
 =?utf-8?B?emcyOHNpNVJzUUI3eVptelVyMTVBalBXTkM3Sm1UQ3hZWUpWaUpjTkJZRnVi?=
 =?utf-8?B?MFJFUXhUdWVvVm1TcDduWE1LenFaUlV3Y000VnZhWGxqdWJ5R0UvNWJwR3I4?=
 =?utf-8?B?ZzZmR2p3a3RyMkJJKzdVdWdJTFlRby9vYmZnWGxnUUZMRjFsL29mLzIzdDdO?=
 =?utf-8?B?RGRMNkE5SlB4bWlvMUJGNDBKKzU3T3ZIaUdqcGN4Z0UrckJHV2FYVzBCSFdI?=
 =?utf-8?B?dlRFbTI3cXRzaURxVFFLQXRFWloxUDhDUDNtLzVhOS9yemNuVnJreStURTV1?=
 =?utf-8?B?NmorT2IyNkpMN3J4VWRHQ2Evc3ZRV1VTSUtvdUV4c0xNaDdMcG5rZGMrcTMv?=
 =?utf-8?B?U1A3amhXOUQrSjdRaEFmWFBrS3RodEp1bXhBbjF6YTB2SXM0VjU5NXkyVEZ0?=
 =?utf-8?B?cjBma2lEclZvQ0F0SVBVbDgra2VVT3dDbnlwSm5YSDdjNTNpV1UzUWxRdFFn?=
 =?utf-8?B?TlRLaGdZY1VxMWozeW1BRUdDWi9pR25QanBDZXptZVVIeklKdWxrYXROV1ZJ?=
 =?utf-8?B?UC9WeEhzaU11V1Ztd2x6Z3NqdHRrRzBMT0pJN3Q3RmpBbVUzcFNaaUtWVUdX?=
 =?utf-8?B?c3JwQnl3cCswaFBGeGJjVUNxMURBQ2E5d1RRTUxqVWtBenZJUDBnM2pUb0NR?=
 =?utf-8?B?Smk0Q3RWUFdNNnU5WWMvdzlRUHgrOTY3TGJQRmk1OVEyVGtCZ0JGNnVMRWVH?=
 =?utf-8?B?TFNleUo2dHNUTUpvZjZlSWxla2tyTHR2K1c3ODR5SVlzUXZBcUd0Z1RhbTdv?=
 =?utf-8?B?UUVPVjV0Ynl3WCtVYXBKRVFWeitmVmFzYlgreXpSM3h2aUpqUHQ2bDlFV255?=
 =?utf-8?B?S1BKTS8zSXhBZEFpb1U1YmdTZ3VHOXV4dnQ3amZVZEkzV0g3Z2FDeGY4bkpO?=
 =?utf-8?B?bThraTNaRFpzYlJtR3NVZnlra3VrckI4bWxBZCtqc3ZmYTkzQTFCVXVhNWxl?=
 =?utf-8?B?a1BRVzNOUS9IdmNMN3RXdWN3WUwrbEhxbnFCWFZRVTY4L1lmVU4yYjlQajA1?=
 =?utf-8?B?bnJSRGNTeDdnSUlmdWdpNkhsWXIwZjc4RWJnWlB0bVkzTlRldjErMERXd0Ey?=
 =?utf-8?B?aWhRSTRSV1hoVGg1Rkc1MlRhSjBXaVhKMy9xeXVDaGxwcFdVL0NwRzI2clFQ?=
 =?utf-8?B?c090ZVR0WnpmaHZnWDNXL1NoekNRYmVGUUNuSWU4VVBQbWR0bDZZUG9vcllV?=
 =?utf-8?B?Rk4rOFUralI2UG1ZQnNFQ05sNy9IbkkzUEhrK1c4S3NTN0Y2aUJNOFkxOVB6?=
 =?utf-8?B?a1lkQzhDR1dTNityUFFkUkFObFU0TFVocW93N0NyZ1VwYVRIT1F2c2MyOTNT?=
 =?utf-8?B?SWx4bTI4RW5Ndyt6MWRHSGdkNFhrT3ZKTjBZSlBKaVdiTC9jbFNFMHNrVnh2?=
 =?utf-8?B?RDNiNjZscnJPbTN4QmNadWZBZzEwZVdjWVQ2UDFoU0JLWWNxWmt1VmQyNmZh?=
 =?utf-8?B?d2w2ZDJXSUUydURmU0VWTUE4U29zV240UE5LeVFLU3VteUc0aTNYc3NPOG5U?=
 =?utf-8?B?R1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6BB9F29863965045B8D60339A85DA682@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c236f3b-77d7-4272-11d8-08da7f88ec63
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 13:12:08.4073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A69EfAl8qO+zAzgKUJ5UB8vkBEY9V805z+3KFJLJqsWNmcDQnBxqw3EWFhlTpm4MOy2nGcHuIToYB+/fepSErA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1490
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RmFiaW8sDQoNCk9uIDgvMTYvMjIgMDI6MTgsIEZhYmlvIE0uIERlIEZyYW5jZXNjbyB3cm90ZToN
Cj4ga21hcCgpIGlzIGJlaW5nIGRlcHJlY2F0ZWQgaW4gZmF2b3Igb2Yga21hcF9sb2NhbF9wYWdl
KCkuDQo+IA0KPiBUaGVyZSBhcmUgdHdvIG1haW4gcHJvYmxlbXMgd2l0aCBrbWFwKCk6ICgxKSBJ
dCBjb21lcyB3aXRoIGFuIG92ZXJoZWFkIGFzDQo+IG1hcHBpbmcgc3BhY2UgaXMgcmVzdHJpY3Rl
ZCBhbmQgcHJvdGVjdGVkIGJ5IGEgZ2xvYmFsIGxvY2sgZm9yDQo+IHN5bmNocm9uaXphdGlvbiBh
bmQgKDIpIGl0IGFsc28gcmVxdWlyZXMgZ2xvYmFsIFRMQiBpbnZhbGlkYXRpb24gd2hlbiB0aGUN
Cj4ga21hcOKAmXMgcG9vbCB3cmFwcyBhbmQgaXQgbWlnaHQgYmxvY2sgd2hlbiB0aGUgbWFwcGlu
ZyBzcGFjZSBpcyBmdWxseQ0KPiB1dGlsaXplZCB1bnRpbCBhIHNsb3QgYmVjb21lcyBhdmFpbGFi
bGUuDQo+IA0KDQpzbyBJIGJlbGlldmUgdGhpcyBzaG91bGQgZ2l2ZSB1cyBiZXR0ZXIgcGVyZm9y
bWFuY2UgdW5kZXIgaGVhdnkNCndvcmtsb2FkID8NCg0KPiBXaXRoIGttYXBfbG9jYWxfcGFnZSgp
IHRoZSBtYXBwaW5ncyBhcmUgcGVyIHRocmVhZCwgQ1BVIGxvY2FsLCBjYW4gdGFrZQ0KPiBwYWdl
IGZhdWx0cywgYW5kIGNhbiBiZSBjYWxsZWQgZnJvbSBhbnkgY29udGV4dCAoaW5jbHVkaW5nIGlu
dGVycnVwdHMpLg0KPiBJdCBpcyBmYXN0ZXIgdGhhbiBrbWFwKCkgaW4ga2VybmVscyB3aXRoIEhJ
R0hNRU0gZW5hYmxlZC4gRnVydGhlcm1vcmUsDQo+IHRoZSB0YXNrcyBjYW4gYmUgcHJlZW1wdGVk
IGFuZCwgd2hlbiB0aGV5IGFyZSBzY2hlZHVsZWQgdG8gcnVuIGFnYWluLCB0aGUNCj4ga2VybmVs
IHZpcnR1YWwgYWRkcmVzc2VzIGFyZSByZXN0b3JlZCBhbmQgYXJlIHN0aWxsIHZhbGlkLg0KPiAN
Cj4gSG93ZXZlciwgdGhlcmUgaXMgYSBodWdlIGNvbnN0cmFpbnQgd2hpY2ggbWlnaHQgYmxvY2sg
c29tZSBjb252ZXJzaW9ucw0KPiB0byBrbWFwX2xvY2FsX3BhZ2UoKTogdGhlIGtlcm5lbCB2aXJ0
dWFsIGFkZHJlc3MgY2Fubm90IGJlIGhhbmRlZCBhY3Jvc3MNCj4gZGlmZmVyZW50IHRocmVhZHMu
IElyYSBtYWRlIG1lIG5vdGljZSB0aGF0IHRoZSBrbWFwKCkgYW5kIGt1bm1hcCgpIGluIHRoaXMN
Cj4gZHJpdmVyIGhhcHBlbiBpbiB0d28gZGlmZmVyZW50IHdvcmtxdWV1ZXMuIFRoZXJlZm9yZSwg
a3VubWFwX2xvY2FsKCkgd2lsbA0KPiB0cnkgdG8gdW5tYXAgYW4gaW52YWxpZCBhZGRyZXNzLg0K
PiANCj4gTGV0IG1lIGV4cGxhaW4gd2h5IEknbSBzZW5kaW5nIGFuIFJGQy4gV2hlbiBJIGhpdCB0
aGUgYWJvdmUgbWVudGlvbmVkDQo+IGlzc3VlcyBJIHRyaWVkIHRvIHJlZmFjdG9yIHRoZSBjb2Rl
IGluIHdheXMgd2hlcmUgbWFwcGluZyBhbmQgdW5tYXBwaW5nDQo+IGhhcHBlbiBpbiBhIHNpbmds
ZSB0aHJlYWQgKHRvIG5vdCBicmVhayB0aGUgcnVsZXMgb2YgdGhyZWFkcyBsb2NhbGl0eSkuDQo+
IA0KPiBIb3dldmVyLCB3aGlsZSByZWFkaW5nIHRoaXMgY29kZSBhZ2FpbiBJIHRoaW5rIEkgbm90
aWNlZCBhbiBpbXBvcnRhbnQNCj4gcHJlcmVxdWlzaXRlIHdoaWNoIG1heSBsZWFkIHRvIGEgc2lt
cGxlciBzb2x1dGlvbi4uLiBJZiBJJ20gbm90IHdyb25nLCBpdA0KPiBsb29rcyBsaWtlIHRoZSBw
YWdlcyBhcmUgYWxsb2NhdGVkIGluIG52bWV0X3RjcF9tYXBfZGF0YSgpLCB1c2luZyB0aGUNCj4g
R0ZQX0tFUk5FTCBmbGFnLg0KPiANCj4gVGhpcyB3b3VsZCBhc3N1cmUgdGhhdCB0aG9zZSBwYWdl
cyBfY2Fubm90XyBjb21lIGZyb20gSElHSE1FTS4gSWYgSSdtIG5vdA0KPiBtaXNzaW5nIHNvbWV0
aGluZyAoYWdhaW4hKSwgYSBwbGFpbiBwYWdlX2FkZHJlc3MoKSBjb3VsZCByZXBsYWNlIHRoZSBr
bWFwKCkNCj4gb2Ygc2dfcGFnZShzZyk7IGZ1cnRoZXJtb3JlLCB3ZSBzaG91bGRuJ3QgbmVlZCB0
aGUgdW5tYXBwaW5ncyBhbnkgbG9uZ2VyLg0KPiANCj4gVW5mb3J0dW5hdGVseSwgSSBkb24ndCBr
bm93IHRoaXMgcHJvdG9jb2wgYW5kIEknbSBub3Qgc28gZXhwZXJpZW5jZWQgd2l0aA0KPiBrZXJu
ZWwgZGV2ZWxvcG1lbnQgdG8gYmUgYWJsZSB0byB1bmRlcnN0YW5kIHRoaXMgY29kZSBwcm9wZXJs
eS4NCj4gDQo+IFRoZXJlZm9yZSwgSSBoYXZlIHR3byBxdWVzdGlvbnM6IGFtIEkgcmlnaHQgYWJv
dXQgdGhpbmtpbmcgdGhhdCB0aGUgcGFnZXMNCj4gbWFwcGVkIGluIG52bWV0X3RjcF9tYXBfcGR1
X2lvdmVjKCkgYXJlIGFsbG9jYXRlZCB3aXRoIEdGUF9LRVJORUw/IElmIHNvLA0KPiBjYW4gYW55
b25lIHdpdGggbW9yZSBrbm93bGVkZ2UgdGhhbiBtaW5lIHBsZWFzZSBzYXkgaWYgbXkgY2hhbmdl
cyBtYWtlIGFueQ0KPiBzZW5zZT8NCj4gDQo+IFN1Z2dlc3RlZC1ieTogSXJhIFdlaW55IDxpcmEu
d2VpbnlAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBGYWJpbyBNLiBEZSBGcmFuY2VzY28g
PGZtZGVmcmFuY2VzY29AZ21haWwuY29tPg0KDQpUaGFua3MgYSBsb3QgZm9yIGRldGFpbGVkIGV4
cGxhbmF0aW9uLg0KDQpRdWljayBxdWVzdGlvbiB3aGF0IGtpbmQgb2YgcGVyZm9ybWFuY2UgYmVu
ZWZpdHMgeW91IGhhdmUgc2VlbiB3aXRoDQp0aGlzIGNoYW5nZSA/IHdlIG5lZWQgdG8gZG9jdW1l
bnQgdGhlIHBlcmZvcm1hbmNlIG51bWJlcnMgc2luY2UgY29tbWl0DQpsb2cgbWVudGlvbnMgaGVy
ZSB0aGF0IGttYXBfbG9jYV9wYWdlKCkgaXMgZmFzdGVyIHRoYW4ga21hcCgpLg0KDQpJbiBjYXNl
IHlvdSBhcmUgbm90IGF3YXJlIHBsZWFzZSBoYXZlIGEgbG9vayBhdCB0aGUgYmxrdGVzdHMgdG8g
Y3JlYXRlDQphIHNpbXBsZSBsb29wYmFjayBzZXRwdSB3aXRoIG52bWUtbG9vcCB0cmFuc3BvcnQu
DQoNCi1jaw0KDQoNCg==
