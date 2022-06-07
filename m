Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0185E53F918
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239016AbiFGJIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239038AbiFGJIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:08:06 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8CD66C86
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 02:07:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdoYx8xOc2hLxLsV+HYS+px5ITAw1w76AfB3CxzVz9+y2Sym/7aVZNAmLq+Hb5WqFULoQ2Eb7ZlxssB6B3Tw6kYaqlw2uxgvGYBTTqrHbEowsLfwMqyOHQ7lN0lsKVGjNBWPxnI3z42PoHm3ZL2lQA0me2G20Y+rWHESUsctS5ilRL9iwh0wjMbs6ek/aHa6lpvkB9q9u9J96FpivGwj26dI0f3xps8pab23sT1ULjRAYVaK27m7b/2JuMZuOz6FUTkpWVtqfJ/vLB0DVvgEV0/Z+G96ar9xTMOuKam97lO+scGfL81muT/C3J/ffMuT6ftUz8nOtN7/XxNkXAhrgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPWEA0IB6UFSwn3nxR1dpd3ne6XN39pvYnHRc5KSkv0=;
 b=HrSvJKr7c+LerYjen0mOw1LOzyZJeZAQAPmfFy6/M8SzaPRF58eN+epURzYqdy/LlrvuBxzWkwqIrWQIaJvGSFtUbMO+rgVk7SzWHW0ocs4LRBu0DN5bOw7cddn5PfFdcSVwSi64EgeWOY6uDKxhXsmjx8LSgbid77/JAwwu0YIZrg4100IX1HwFS4UQ8/aAfh6bZ9Qb9avafhSvUvXCQEJ5WHAhEgvkqX6V/J1cpXnVh0Eb0odUJuofTU8thYHa7WprsKhvVMV/cu52QRse9R7KMD+Ppd+VajGeLCX/F5hPVa3AarL5otktJkTPdIE+GU7EMwrg0+5Q+NmHuCaMBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPWEA0IB6UFSwn3nxR1dpd3ne6XN39pvYnHRc5KSkv0=;
 b=sYEyASylGi7tjcvY4XX6azgvzQEDi7IWe8cswQB0lwkiDWaxQmcZr4xqYPDW80VF7uxRixEtnA1nZPPS3c1QjmHILPjcOHc/6gkZY4BgWyBgjSGBZE+lKZ56n/AS16A3eDj5JdoAyyFespUfkiLTfFN204p+sISFgx6PdHZLUmw=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by DM6PR05MB6139.namprd05.prod.outlook.com (2603:10b6:5:11d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.11; Tue, 7 Jun
 2022 09:07:57 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f%7]) with mapi id 15.20.5332.010; Tue, 7 Jun 2022
 09:07:57 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH v2] x86/mm/tlb: avoid reading mm_tlb_gen when possible
Thread-Topic: [PATCH v2] x86/mm/tlb: avoid reading mm_tlb_gen when possible
Thread-Index: AQHYec9uAfeIW9W+8EGZiduiI0Vqa61C2csAgAAFQICAAMl9AA==
Date:   Tue, 7 Jun 2022 09:07:57 +0000
Message-ID: <5B1920FB-B949-4F3D-8F08-A76F8974F1B2@vmware.com>
References: <20220606180123.2485171-1-namit@vmware.com>
 <234e853b-0c35-45de-b40d-2058976e49e0@www.fastmail.com>
 <A0D7A6ED-4B5C-4CA5-95B0-580F1F0EC364@vmware.com>
In-Reply-To: <A0D7A6ED-4B5C-4CA5-95B0-580F1F0EC364@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 107aab66-7eaa-41fa-f92b-08da486536c1
x-ms-traffictypediagnostic: DM6PR05MB6139:EE_
x-microsoft-antispam-prvs: <DM6PR05MB613941C74BA8DA8828F28088D0A59@DM6PR05MB6139.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yvENIEJUh8sepbAQwm2HgLiZUsl5j8h02yNMlIGAvN05OcROgrTe0Z92Zj+m/VuVhP6D6vvOe3ZBLfxc5S5FBcsOWW0A2gHRRfaNAi8NE/fSoKevIqoaW43w09pO2Fz/41JQs8A1dUg1qQI55SZ4JCVzHUM031Gt11HKmG9avBYbBa/niEUvCF87tVv3/c054Dn9kF3qgwnAk18J3Bt0thS5SQTRC2ubSBht1aMplI/PkX20WFpi/faFjcxJeFdoHtnPA+ptJfH9mWYYs3GFLZYVHsKo4IV5IyneSo03vacYyB/EqivHIJpRkjjaZc0fXs2l9UJjaVxMy5NhadFhwBPbdldrGMaExwgMJ/eSyE+K/4vXs4gg+KbdRghaDk3AlBfiojQT6UdTEUzkS0qHpjjIqWSdb5q2MQx9xBxDTy6PaK4Fnn08CGVh+CYfSw7hrHaR7q9YkUDah8xFkik/fX7bYUKRIjrjZvmp5pbTzZuVixS4WtvZSOQaBUIgpqWIteL5BMXrqgc3DDiWmb9CtFeAnWffRDoeqCZIEwBOjo2QPkAMuSAZWEQDdwdghBTMXzOKZSWCpjyc6ZF2wMSRZT/JG39kbWUV/ii6IdeqPosi66DtgsogpBQ0Lxi6y8acA0li2CjfT8eMs9cq8rT0feCtK2hC7Tb3MbioBEH+XiG+9jcLbC+nvkuUVRdc5YOYgr19Rb7U5FQQMKsdUq3715pR0MqKNOcxRTuA7EKnu/T22A4LkJ4ziId/HO6vMblX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(6506007)(4326008)(66476007)(66556008)(64756008)(53546011)(66446008)(8676002)(66946007)(76116006)(5660300002)(33656002)(8936002)(2616005)(38070700005)(508600001)(122000001)(2906002)(36756003)(38100700002)(66574015)(316002)(26005)(6512007)(6486002)(83380400001)(6916009)(54906003)(186003)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3dBSjhLbW5nOUtlTFlxUktsWkFoQTJlaEM4Y2VIUHBvQ29VRVlWYnN2RUxz?=
 =?utf-8?B?Q1UxMS9KYUhvaHZTelY5SWJWT2JQVkhKT3RiTmhPRnkrSFRCcUJpUFBZcjdW?=
 =?utf-8?B?bGViZStiUnNLRUI3ZnB6d0tVSlZWdkJBV2o1VDBSLzNoeWc4Uk50WlZBVFgv?=
 =?utf-8?B?TWZDVUJFSzFsSXB5aU4rak90WVpwalYxNGVXdStITms5OE1TZk5jOFdtVmNJ?=
 =?utf-8?B?M3czVHg4OE9rMWZVNmpGVExvQWtKQUZCVk1qZHdaaitIMVYwa2JHbUhJdzdE?=
 =?utf-8?B?dEMyM3ZFMmloWVlZVGFac3g1Y1EyRlZXVUEyM3N0elVIdFVWalpoMHdLM3kw?=
 =?utf-8?B?Mnl3NElBdUdYOVJ2dGtzQU1FSDNOVmJuQndKcGVSbk83a2VEVmdwclJrRW10?=
 =?utf-8?B?TDM1ZmpNRHN5ZmNGbUFyQXUvbUZobVdsM0ZuVXFrakVabXRtNGkzS0p3WlBh?=
 =?utf-8?B?d2J5YWJwLy80UExHdEFLV0NyaG1NZlNrMEhXbUw2MGplSjJ6K2NMRFBrSWtP?=
 =?utf-8?B?Rk03S2xQWkZncHRYMTFtMG94R0JOOWZGOFpra0x1eXFkamhNRkdmSy8rSzhP?=
 =?utf-8?B?NVN2WVpQekJZcnY5WUFCUHhkKzVOREUyOU5vRCt2UmRkZ1IxOGhQR3VvUGJ4?=
 =?utf-8?B?ekZWT1NhWWJWQi9oUzNIMzdTSlRoYzFPOXhPRzY5RFVaanVGNWdFNXhpQ3lQ?=
 =?utf-8?B?T1dJL0xESEp6c0kxNVNsa0tvYnN3T1JROWs1VHh1aTloYzNGd1lzZWp6b0hT?=
 =?utf-8?B?dGRXYm52OXdTUnRPNW1xejhpMGM1ekd3amZWUG9sQlVZUlVtQk9pQ3laMUQv?=
 =?utf-8?B?K3RyV0ROWmFjNDJocHIwSlREMEVyTCt5KzRDRUJTbHYyTm9tL2p6ZGU5L0My?=
 =?utf-8?B?REpvQzR6RWU1K251eEJBaG14bEs4di9NejRnRVJZcTBKRlZUN3VUYWhpbTJz?=
 =?utf-8?B?MDh6R3ozV1FuYzIzdGRVa2dKdzBMVndXQTJkdkE2NFpUNGtoREczcXg0bjlu?=
 =?utf-8?B?QXkrbDZ3WVVjdWp5cGdobGpxSG42MWEvc2h5eEFoQ1FzWnhXV2E4NFlyTUV4?=
 =?utf-8?B?bXNXNzZkU2RBWHRJYWdpV0tDMm91cTMxOTR0dTVLR0QxM2t2ejRBMUpQV2tF?=
 =?utf-8?B?bUtrOTlBODEzSkMzbFh2SDgzaE9LZFI2V05GU05wQ0o3cjAxbzYvZG1XeWxu?=
 =?utf-8?B?RU5KK1RZOHA1UTFjUllBL1hIN2hiMXNramhidTRoN0NkRDZzVXl3UjRWOEdY?=
 =?utf-8?B?dmcvN3p3cmJVTXY1Y1Q0NkNMZXB4SjNrYWNsbXJ1OU9LTVBQTUNBWDQzNkZs?=
 =?utf-8?B?Y2VYUjRGc29pUXB6MGs0ODd1UWxYMHhKNmlmb1FZem5XcTBiWXRqTlpqOVRs?=
 =?utf-8?B?Vk53bmhoREROOVBpMWh6TnlqaEcrc0VoMmF1UDBVOXIvZjZxV0tuaDd6eHJU?=
 =?utf-8?B?WHhOTE9vdWRlbHBMVlVML3RzRElxWGhJbHdGOG92Y2JWcE03WS9XZ1NMZ1U4?=
 =?utf-8?B?clVONzhud2JwWFhVTk1tcVk0ZGFnaFZkaXArYUxrbE93Si9CbFJGQWNmeXlB?=
 =?utf-8?B?ckVlMGgwNUEzb2IyVnVFcXZaTnJ2OGQzZkU2czMwcjZVWkFCRU1ZMTNIaFJm?=
 =?utf-8?B?b1I3eE81TFpXV3NSeUJJSVc3SVM3TFNodEFzOUJBaWttRDVCZHFpRXduTnlD?=
 =?utf-8?B?UDNVVW9Tdm9Rdk5KU2pJTndleUcvRUdybGVCbDV1QXAwR3dUZTZOL1VxbFUv?=
 =?utf-8?B?QmNOaHoweWNvVW1haFZUZVphM2pFOFZSaFFPWTQ2TkFHclQyVlI3WmlQNEs0?=
 =?utf-8?B?ZVpnYlpncFZnQWRZSWxHV1JIMW9ESFJ4VDUyTitiemFUcy92WS9wd2VrMVJV?=
 =?utf-8?B?Wm9BdUJUTWFVOXBRRVE2cXFINDJ4VmVvakVJRitTdHg4MjJLS2syYmFYdXJC?=
 =?utf-8?B?RFdSWENKc0ZMamwyWXRPTEpkRmNrdFBsY0JGcnROWS9OMlFMODY0KzRMNVgw?=
 =?utf-8?B?ZWRHWmVJV3ZQbmp0SGpseGgzOXlCemM1Rk0wYWV1eVpoTU1PMmNnYnZJRXVL?=
 =?utf-8?B?YU5RWDBONUl3VHpvZXJqUjQvMXV1aWFMWVR2M3JoWmdzdUt3MTVpN1dySWx3?=
 =?utf-8?B?ZUJDb3Y4TDNoWFdoM1BxUXlQTWFvQU1lQ0xBeUlLWEkwb0tONm5pUWFzblRz?=
 =?utf-8?B?a1VyMHlmczFpd3hzaXNleStnK0R0SE1NWUhzeGl0NWs3Wmh5a3IweHpCL2dx?=
 =?utf-8?B?blRHbFBPLy9SSjBPUmp1dlA1bkpYWXV4WjYxUmNPdzlhYlpYTjVyUE1EdXVJ?=
 =?utf-8?B?bVNMazZZSjlpeURoVEt6Q3BKSzZaR3RaWFNLK2RSMG9kYmFiSDVLQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46985CF05DEE5C49BDBAC08B138265E0@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 107aab66-7eaa-41fa-f92b-08da486536c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 09:07:57.3300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: odMyGSTXstO3MKa3KiOtMqoyqNKSz4n/nYz5Mymi8DgrjW9C9BWOfEvZaKzkEA8jEtqfLmJhpR062fpyYhHBpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB6139
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gSnVuIDYsIDIwMjIsIGF0IDI6MDYgUE0sIE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+
IHdyb3RlOg0KDQo+IE9uIEp1biA2LCAyMDIyLCBhdCAxOjQ4IFBNLCBBbmR5IEx1dG9taXJza2kg
PGx1dG9Aa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPj4g4pqgIEV4dGVybmFsIEVtYWlsDQo+PiAN
Cj4+IE9uIE1vbiwgSnVuIDYsIDIwMjIsIGF0IDExOjAxIEFNLCBOYWRhdiBBbWl0IHdyb3RlOg0K
Pj4+IEZyb206IE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+DQo+Pj4gDQo+Pj4gT24gZXh0
cmVtZSBUTEIgc2hvb3Rkb3duIHN0b3JtcywgdGhlIG1tJ3MgdGxiX2dlbiBjYWNoZWxpbmUgaXMg
aGlnaGx5DQo+Pj4gY29udGVuZGVkIGFuZCByZWFkaW5nIGl0IHNob3VsZCAoYXJndWFibHkpIGJl
IGF2b2lkZWQgYXMgbXVjaCBhcw0KPj4+IHBvc3NpYmxlLg0KPj4+IA0KPj4+IEN1cnJlbnRseSwg
Zmx1c2hfdGxiX2Z1bmMoKSByZWFkcyB0aGUgbW0ncyB0bGJfZ2VuIHVuY29uZGl0aW9uYWxseSwN
Cj4+PiBldmVuIHdoZW4gaXQgaXMgbm90IG5lY2Vzc2FyeSAoZS5nLiwgdGhlIG1tIHdhcyBhbHJl
YWR5IHN3aXRjaGVkKS4NCj4+PiBUaGlzIGlzIHdhc3RlZnVsLg0KPj4+IA0KPj4+IE1vcmVvdmVy
LCBvbmUgb2YgdGhlIGV4aXN0aW5nIG9wdGltaXphdGlvbnMgaXMgdG8gcmVhZCBtbSdzIHRsYl9n
ZW4gdG8NCj4+PiBzZWUgaWYgdGhlcmUgYXJlIGFkZGl0aW9uYWwgaW4tZmxpZ2h0IFRMQiBpbnZh
bGlkYXRpb25zIGFuZCBmbHVzaCB0aGUNCj4+PiBlbnRpcmUgVExCIGluIHN1Y2ggYSBjYXNlLiBI
b3dldmVyLCBpZiB0aGUgcmVxdWVzdCdzIHRsYl9nZW4gd2FzIGFscmVhZHkNCj4+PiBmbHVzaGVk
LCB0aGUgYmVuZWZpdCBvZiBjaGVja2luZyB0aGUgbW0ncyB0bGJfZ2VuIGlzIGxpa2VseSB0byBi
ZSBvZmZzZXQNCj4+PiBieSB0aGUgb3ZlcmhlYWQgb2YgdGhlIGNoZWNrIGl0c2VsZi4NCj4+PiAN
Cj4+PiBSdW5uaW5nIHdpbGwtaXQtc2NhbGUgd2l0aCB0bGJfZmx1c2gxX3RocmVhZHMgc2hvdyBh
IGNvbnNpZGVyYWJsZQ0KPj4+IGJlbmVmaXQgb24gNTYtY29yZSBTa3lsYWtlICh1cCB0byArMjQl
KToNCj4+IA0KPj4gQWNrZWQtYnk6IEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJuZWwub3JnPg0K
Pj4gDQo+PiBCdXQuLi4NCj4+IA0KPj4gSSdtIHN1c3BpY2lvdXMgdGhhdCB0aGUgYW5hbHlzaXMg
aXMgbWlzc2luZyBzb21ldGhpbmcuIFVuZGVyIHRoaXMga2luZCBvZiB3b3JrbG9hZCwgdGhlcmUg
YXJlIGEgd2hvbGUgYnVuY2ggb2YgZmx1c2hlcyBiZWluZyBpbml0aWF0ZWQsIHByZXN1bWFibHkg
aW4gcGFyYWxsZWwuIEVhY2ggZmx1c2ggZG9lcyBhbiBSTVcgb24gbW1fdGxiX2dlbiAod2hpY2gg
d2lsbCBtYWtlIHRoZSBjYWNoZWxpbmUgZXhjbHVzaXZlIG9uIHRoZSBpbml0aWF0aW5nIENQVSku
IEFuZCBlYWNoIGZsdXNoIHNlbmRzIG91dCBhbiBJUEksIGFuZCB0aGUgSVBJIGhhbmRsZXIgcmVh
ZHMgbW1fdGxiX2dlbiAod2hpY2ggbWFrZXMgdGhlIGNhY2hlbGluZSBzaGFyZWQpIHdoZW4gaXQg
dXBkYXRlcyB0aGUgbG9jYWwgdGxiX2dlbi4gU28geW91J3JlIGRvaW5nIChhdCBsZWFzdCEpIGFu
IEUtPlMgYW5kIFMtPkUgdHJhbnNpdGlvbiBwZXIgZmx1c2guIFlvdXIgcGF0Y2ggZG9lc24ndCBj
aGFuZ2UgdGhpcy4NCj4+IA0KPj4gQnV0IHlvdXIgcGF0Y2ggZG9lcyBhZGQgYSB3aG9sZSBuZXcg
Y2FzZSBpbiB3aGljaCB0aGUgSVBJIGhhbmRsZXIgc2ltcGx5IGRvZXNuJ3QgZmx1c2ghIEkgdGhp
bmsgaXQgdGFrZXMgZWl0aGVyIHF1aXRlIGEgYml0IG9mIHJhY2luZyBvciBhIHdlbGwtdGltZWQg
Y29udGV4dCBzd2l0Y2ggdG8gaGl0IHRoYXQgY2FzZSwgYnV0LCBpZiB5b3UgaGl0IGl0LCB0aGVu
IHlvdSBza2lwIGEgZmx1c2ggYW5kIHlvdSBza2lwIHRoZSByZWFkIG9mIG1tX3RsYl9nZW4uDQo+
PiANCj4+IEhhdmUgeW91IHRlc3RlZCB3aGF0IGhhcHBlbnMgaWYgeW91IGRvIHNvbWV0aGluZyBs
aWtlIHlvdXIgcGF0Y2ggYnV0IHlvdSBhbHNvIG1ha2UgdGhlIG1tX3RsYl9nZW4gcmVhZCB1bmNv
bmRpdGlvbmFsPyBJJ20gY3VyaW91cyBpZiB0aGVyZSdzIG1vcmUgdG8gdGhlIHN0b3J5IHRoYW4g
eW91J3JlIHNlZWluZy4NCj4+IA0KPj4gWW91IGNvdWxkIGFsc28gY29udGVtcGxhdGUgYSBzb21l
d2hhdCBldmlsIGhhY2sgaW4gd2hpY2ggeW91IGRvbid0IHJlYWQgbW1fdGxiX2dlbiBldmVuIGlm
IHlvdSAqZG8qIGZsdXNoIGFuZCBpbnN0ZWFkIHVzZSBmLT5uZXdfdGxiX2dlbi4gVGhhdCB3b3Vs
ZCBwb3RlbnRpYWxseSBkbyBhIGJpdCBvZiBleHRyYSBmbHVzaGluZyBidXQgd291bGQgYXZvaWQg
dGhlIGZsdXNoIHBhdGggY2F1c2luZyB0aGUgRS0+UyB0cmFuc2l0aW9uLiAoV2hpY2ggbWF5IGJl
IG9mIGR1YmlvdXMgdmFsdWUgZm9yIHJlYWwgd29ya2xvYWRzLCBzaW5jZSBJIGRvbid0IHRoaW5r
IHRoZXJlJ3MgYSBjcmVkaWJsZSB3YXkgdG8gYXZvaWQgaGF2aW5nIGNvbnRleHQgc3dpdGNoZXMg
cmVhZCBtbV90bGJfZ2VuLikNCj4gDQo+IFRoYW5rcyBBbmR5LiBJIHN0aWxsIHRoaW5rIHRoYXQg
dGhlIHBlcmZvcm1hbmNlIGNvbWVzIGZyb20gc2F2aW5nIGNhY2hlDQo+IGFjY2Vzc2VzLCB3aGlj
aCBhcmUgc2tpcHBlZCBpbiBjZXJ0YWluIGNhc2VzIGluIHRoaXMgd29ya2xvYWQuIEkgd291bGQg
bm90ZQ0KPiB0aGF0IHRoaXMgcGF0Y2ggY29tZXMgZnJvbSBtZSBwcm9maWxpbmcgd2lsbC1pdC1z
Y2FsZSwgYWZ0ZXIgRGF2ZSBjb21wbGFpbmVkDQo+IHRoYXQgSSBydWluZWQgdGhlIHBlcmZvcm1h
bmNlIGluIHNvbWUgb3RoZXIgcGF0Y2guIFNvIHRoaXMgaXMgbm90IGEgcmFuZG9tDQo+IOKAnEkg
dHJpZWQgc29tZXRoaW5nIGFuZCBpdOKAmXMgYmV0dGVy4oCdLg0KPiANCj4gSSB2YWd1ZWx5IHJl
bWVtYmVyIHByb2ZpbGluZyB0aGUgbnVtYmVyIG9mIGNhY2hlLVtzb21ldGhpbmddIGFuZCBzZWVp
bmcgYW4NCj4gZWZmZWN0LCBhbmQgSSBjYW5ub3QgZXhwbGFpbiBzdWNoIHBlcmZvcm1hbmNlIGlt
cHJvdmVtZW50IGJ5IGp1c3Qgc2tpcHBpbmcgYQ0KPiBmbHVzaC4gQnV0Li4uDQo+IA0KPiBIYXZp
bmcgc2FpZCBhbGwgb2YgdGhhdCwgSSB3aWxsIHJ1biBhdCBsZWFzdCB0aGUgZmlyc3QgZXhwZXJp
bWVudCB0aGF0IHlvdQ0KPiBhc2tlZCBmb3IuIEkgd2FzIGNvbnNpZGVyaW5nIHNraXBwaW5nIHJl
YWRpbmcgbW1fdGxiX2dlbiBjb21wbGV0ZWx5LCBidXQgZm9yDQo+IHRoZSByZWFzb25zIHRoYXQg
eW91IG1lbnRpb25lZCBjb25zaWRlcmVkIGl0IGFzIHNvbWV0aGluZyB0aGF0IG1pZ2h0DQo+IGlu
dHJvZHVjZSBwZXJmb3JtYW5jZSByZWdyZXNzaW9uIGZvciB3b3JrbG9hZHMgdGhhdCBhcmUgbW9y
ZSBpbXBvcnRhbnQgdGhhbg0KPiB3aWxsLWl0LXNjYWxlLg0KPiANCj4gSSB3b3VsZCBhbHNvIGFk
bWl0IHRoYXQgSSBhbSBub3Qgc3VyZSBob3cgdG8gY29tcGxldGVseSBwcmV2ZW50IHNwZWN1bGF0
aXZlDQo+IHJlYWQgb2YgbW0tPnRsYl9nZW4uIEkgZ3Vlc3MgYSBzZXJpYWxpemluZyBpbnN0cnVj
dGlvbiBpcyBvdXQgb2YgdGhlDQo+IHF1ZXN0aW9uLCBzbyB0aGlzIG9wdGltaXphdGlvbiBpcyBh
IGJlc3QtZWZmb3J0Lg0KDQpIZXJlIGFyZSB0aGUgcmVzdWx0cyBvZiBteSBydW5zLiBOb3RlIHRo
YXQgdGhlc2UgcmVzdWx0cyBhcmUgbm90IGNvbXBhcmFibGUNCnRvIHRoZSBvbmVzIGJlZm9yZS4g
VGhpcyB0aW1lIEkgaGFkIGFuIG9sZGVyIG1hY2hpbmUgKEhhc3dlbGwpIGFuZCB0aGUNCmNvbmZp
Z3VyYXRpb24gaXMgc2xpZ2h0bHkgZGlmZmVyZW50IChJSVJDIHRoZSBwcmV2aW91cyBydW4gd2Fz
IHdpdGggUFRJDQpkaXNhYmxlZCBhbmQgbm93IGl0IGlzIGVuYWJsZWQ7IGFyZ3VhYmx5IHRoaXMg
aXMgbGVzcyBmYXZvcmFibGUgZm9yIHRoaXMNCnBhdGNoLCBzaW5jZSB0aGUgY2FjaGUtZWZmZWN0
IHBhcnQgb2YgdGhlIG92ZXJhbGwgVExCIHNob290ZG93biBpcyBzbWFsbGVyKS4NCg0KQXMgeW91
IG5vdGVkLCBBbmR5LCB0aGVyZSBhcmUgdHdvIHRoaW5ncyAtIHJlbGF0ZWQgaW4gbXkgbWluZCAt
IHRoYXQgdGhlDQpwYXRjaCBkb2VzLiBJdCByZXR1cm5zIGVhcmx5IHdpdGggbm8gZmx1c2ggaWYg
Zi0+bmV3X3RsYl9nZW48PWxvY2FsX3RsYl9nZW4NCmFuZCBpdCB0cmllcyB0byBhdm9pZCB0b3Vj
aGluZyBtbS0+dGxiX2dlbiB0byBtaW5pbWl6ZSBjYWNoZSBlZmZlY3RzLg0KDQpZb3UgYXNrZWQg
dG8gcnVuIGV4cGVyaW1lbnRzIHRoYXQgc2VwYXJhdGUgdGhlIGVmZmVjdC4NCg0KCQkJCW5vIGVh
cmx5IHJldHVybgkJZWFybHkgcmV0dXJuCQkNCiAgIDUuMTguMQkrcGF0Y2gJCXRvdWNoIG1tLT50
bGJfZ2VuCW5vIG1tLT50bGJfZ2VuIFsqXQ0KDQoxICAxNTk1MDQJMTU5NzA1CQkxNTkyODQJCQkx
NTk0OTkNCjUgIDMyNjcyNQkzMjA0NDAJCTMyMzYyOQkJCTMwMzE5NQ0KMTAgNDg5ODQxCTQ5NzY3
OAkJNDk4NjAxCQkJNDQyOTc2DQoxNSA1NTIyODIJNTc2MTQ4CQk1NzAzMzcJCQk1MDM3MDkNCjIw
IDU4ODMzMwk2Mjg5NjAJCTYxOTM0MgkJCTU1MTc4OQ0KMjUgNjM3MzE5CTY3NTYzMwkJNjU5OTg1
CQkJNTkxNTc1DQozMCA2NDMzNzIJNjkxNTgxCQk2NzA1OTkJCQk2MTMwMTcNCjM1IDY3NzI1OQk3
MDYxNTcJCTY4OTYyNAkJCTY0Njg3Mw0KNDAgNjU5MzA5CTcyODA3OAkJNzE2NzE4CQkJNjU1MzY0
DQo0NSA2NzA5ODUJNzM1MzQ2CQk2OTY1NTgJCQk2NjU1MDANCg0KWypdIG1tLT50bGJfZ2VuIMOu
cyBjb21wbGV0ZWx5IHJlbW92ZSBmcm9tIGZsdXNoX3RsYl9mdW5jKCkgaW4gdGhpcyBzZXR1cA0K
DQpOb3csIGNsZWFybHkgdGhpcyBleHBlcmltZW50IGlzIGxpbWl0ZWQsIGFuZCBJIGRpZCBub3Qg
bWVhc3VyZSB0aGUgbnVtYmVyIG9mDQpUTEIgc2hvb3Rkb3ducywgbnVtYmVyIG9mIGNhY2hlLW1p
c3NlcywgZXRjLg0KDQpIYXZpbmcgc2FpZCB0aGF0LCB0aGUgY29uY2x1c2lvbnMgSSBnZXQgdG86
DQoxLiBUaGUgcGVyZm9ybWFuY2UgYmVuZWZpdCBhcHBlYXJzIHRvIGNvbWUgZnJvbSBib3RoIHRo
ZSBlYXJseSByZXR1cm4gYW5kDQogICBhdm9pZGluZyB0b3VjaGluZyBtbS0+dGxiX2dlbi4NCjIu
IEV2ZW4gaW4gdGhpcyBzZXR1cCwgeW91ciBvcHRpbWl6YXRpb24gKEFuZHkpIG9mIGNoZWNraW5n
IG1tLT50bGJfZ2VuLA0KICAgcGF5cyBvZmYuIFJlbW92aW5nIG1tLT50bGJfZ2VuIGNvbXBsZXRl
bHkgZnJvbSBmbHVzaF90bGJfZnVuYyBpcyBiYWQuDQoNCk5vdywgaWYgeW91IGFzayBtZSBob3cg
dGhpcyB3aG9sZSB0aGluZyBjYW4gYmUgZnVydGhlciBpbXByb3ZlZCwgdGhlbiBJDQp3b3VsZCBz
YXkgdGhhdCBwZXJoYXBzIG9uIHJlbW90ZSBjb3JlcyBpdCBpcyBiZXN0IHRvIGRvIHRoZSBhY3R1
YWwgVExCIGZsdXNoDQphZnRlciB3ZSB3ZW50IG92ZXIgdGhlIFRMQiBzaG9vdGRvd24gZW50cmll
cyBhbmQgZmlndXJlZCBvdXQgaWYgd2UgaGF2ZQ0KbXVsdGlwbGUgb3V0c3RhbmRpbmcgVExCIHNo
b290ZG93bnMgYW5kIHdoYXQgdGhlIG5ldyBnZW5lcmF0aW9uIGlzICh1c2luZw0KbWF4IG9mIGYt
Pm5ld190bGJfZ2VuOyB3aXRob3V0IHRvdWNoaW5nIG1tLT50bGJfZ2VuKS4gSXQgY2FuIGJlIGRv
bmUgYnkNCmFkZGluZyBhIHN0YWdlIGluIGZsdXNoX3NtcF9jYWxsX2Z1bmN0aW9uX3F1ZXVlKCks
IGJ1dCBpdCBtaWdodCBzbGlnaHRseQ0KYnJlYWsgdGhlIGFic3RyYWN0aW9uIGxheWVycy4NCg0K
SGF2aW5nIHNhaWQgYWxsIG9mIHRoYXQsIEkgdGhpbmsgdGhhdCB0aGUgcGVyZm9ybWFuY2UgaW1w
cm92ZW1lbnQgaXMNCmNvbnNpZGVyYWJsZSBldmVuIGluIHRoaXMgY29uZmlnICh3aGljaCBJIHJl
bWluZCwgaXMgbGVzcyBmYXZvcmFibGUgZm9yIHRoZQ0KYmVuY2htYXJrKS4=
