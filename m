Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD134DCF63
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiCQUd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiCQUd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:33:57 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0563C18D996
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:32:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zz5AMTN2CVMEuyPZ/Ivi0cfiyvyOd6OAFISlMcry5u9HMFHYcxHaCwByPwAkGNGUJexa/RxvveoSW7gxxhX0JNy/HVVx/Aq67NdkUdVBQXFUNwTh0FpW60CZnWAT7Za/G4xNJK5cpq3587Jd2fybJ8Q+49erol6RIqAH0JtWJyxsC+1rcTiHbW/62rYt4Pt8Vo9ICNkuy3WaHz3lXHshVhG0EB3P52vWU6DEfhP7Sp9OvV3t8YGQMwz1FEFo1hbAV6nxmtQp9J0SaptVs+juZa8Ce3fzPfQtlYvYYHfx9Hlcxq930WBSeDRjiAygB3uxSCGZ33RknzFtfBKUc8tajQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OD16AFYwQ90yZeDQZrbjki5X4GIv7Wygo8bAoQBGYZo=;
 b=Y88RuN/W2G0ugaR/O8O1iXbwYyueEaE9y2gaR0/4j562KK8ghDdwoGlSOmUL7wX+3mXV0NcqpMhbp5MNtonN3gYmVeSUTA+3CnlBTp/+hQoaa3CKJvvMOkeb3sV2PYsHkACYLBwWI72qd7aktLj79r+yXoEmOH9NX6d/E3Ps0LxtHxdadop/Kl9pay0v21kp9hFqoYaJe616VM0CAt36KQzGWxuWEyYIBdVANCDRbHfXXxdb54lvoGHkWy55p8DZdFrZCKQmrbbAyTgh49zD5SCoasvzmf26HdVOjYEIjiqTIZ1iAf+b4m7lEp7mZGbyJngxbCUZYdldbLeyXwoaYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OD16AFYwQ90yZeDQZrbjki5X4GIv7Wygo8bAoQBGYZo=;
 b=pLsUB5SEqOw96YsmHM7bbNKcRr+K/hAwJv4Oz2FyhNcEBF8tazMZeqssiTa5v3su9qVODiAg9274iRQdVBDgdrORKHjKoGUQeR0RED8V6p9/8TjsdtI3a92mGMENi1b1FOFjtuAWEC7HOY8VozuB1aNFIjpxO/dlcDeSRSLK/9o=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BY3PR05MB8114.namprd05.prod.outlook.com (2603:10b6:a03:369::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.7; Thu, 17 Mar
 2022 20:32:35 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::6061:706:1081:df8b]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::6061:706:1081:df8b%7]) with mapi id 15.20.5102.007; Thu, 17 Mar 2022
 20:32:35 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     kernel test robot <oliver.sang@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "zhengjun.xing@linux.intel.com" <zhengjun.xing@linux.intel.com>,
        "fengwei.yin@intel.com" <fengwei.yin@intel.com>
Subject: Re: [x86/mm/tlb] 6035152d8e: will-it-scale.per_thread_ops -13.2%
 regression
Thread-Topic: [x86/mm/tlb] 6035152d8e: will-it-scale.per_thread_ops -13.2%
 regression
Thread-Index: AQHYOi5EArGolB6T3UOsBVoO+LEc5qzD7r8AgAACZwCAABbBAA==
Date:   Thu, 17 Mar 2022 20:32:35 +0000
Message-ID: <DC37F01B-A80F-4839-B4FB-C21F64943E64@vmware.com>
References: <20220317090415.GE735@xsang-OptiPlex-9020>
 <c85ae95a-6603-ca0d-a653-b3f2f7069e20@intel.com>
 <3B958B13-75F0-4B81-B8CF-99CD140436EB@vmware.com>
 <96f9b880-876f-bf4d-8eb0-9ae8bbc8df6d@intel.com>
In-Reply-To: <96f9b880-876f-bf4d-8eb0-9ae8bbc8df6d@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34da9b42-b94e-4524-7e05-08da0855454a
x-ms-traffictypediagnostic: BY3PR05MB8114:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <BY3PR05MB811462A8299A1AFEB7CA288DD0129@BY3PR05MB8114.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L9UYSncVmakuxE14nUwqjqd0zxM9P69F33V/BdoYrBqYn9K8q9vNGBQ0AWWqYa+82SL8GNBp/iUpDMku++yX3AxSKkaz3fVqqnD/219H0f1qqfOotXYHhoyvgh+kEDcUm9SXpHkUWnoIvDbv5l7YHfYztpk4lvwtuven87T85xP4KEQObLjzeJCzfvDD2t52cxXO+k+Fr9sQZhb/OJBE0JsPeHpCmEL6I8SDlSvPk7v0mnEhPIG7fxkRIBMW1DT+GmSVTp+3ab/IlmNj+lIxArJCdcDpR/zX4gC/1Pf0nzPgaFAVe40A+QrnqRdlN27eCasvqS7IS4CKWsa8QTD2I0rOZxWorMJptFiuO4LccJ/J2Lqi8Tz0WSCQ+lpyER0gtPesPpbhjctq9WNQz/zwXnldQWVUurtfcoqnX2Z/EFKM/GOF2SOHjBKL6MsANtOhUwLhmfvaJUZfc9bvMbqzmplH33eV7oaiR3hgvcGdtoAR+fBoJfX3uJJhJ2Kb4FKsJjNF+ruKcZjI4uLtf2vSW+URDqGx7hyOSHxxsh7165GhezkqV6qYeTs1W+/jX7c+M0ms+g4oJl76nrZ6KMkSKYP/uEiHSAmFSvq5EG0NQfv66L0ZsiCwSmsKGWPh4311hl0T9xS2XmsX2F822tQFZqB+dffuXX7ewW/ANxJ/SYGlGse0+fElXCnGb1OiBeFznXd8ykYKidHamnK6uUwN8FuzuiJzeXzwwHaW16m6Mc38j6xKFtN09hRp/FFZODoS/M6Qu203lMMs3hx6vakQcfjbRoATZEOfNIekLwXVtjt1zw1dhTs2Jtb9Ai83fo6bdonzI5WJx+hyWpJ0dGmjDFnUymb55uXhNQs+ja1OQNc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(8676002)(5660300002)(86362001)(38100700002)(38070700005)(4326008)(6512007)(6916009)(54906003)(76116006)(66946007)(2906002)(53546011)(316002)(83380400001)(64756008)(508600001)(66556008)(8936002)(6506007)(26005)(186003)(7416002)(2616005)(66476007)(71200400001)(6486002)(966005)(122000001)(33656002)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ME1tMEEwU0IxQkNERlowNWlkVmNTemFSWkt1dVZvTXBONWhiV0NuTkJJV0Vj?=
 =?utf-8?B?a21ScGxGNkhBcjJIWWVOdHFmVHlSVTNYZkE3aWZIMVh0dW0zbXVtOUIwMkNz?=
 =?utf-8?B?ZkVxQjFzeE4xWEswSmZCUFFEczJvWXNJVG84VVJYZkd0Z2JuR3VpL2JzQmsw?=
 =?utf-8?B?bmdvZGtxeUE2QnRIVnVwUEllK1AzSHpGY0ZHZDd4SHloZkJ0OWxNUVVnRFJF?=
 =?utf-8?B?R0h3bEtGSEx3bWZSY2lyRFAvUEp3bjlEQVY4dC9lVEoxcjN3WEhzZUFsaVpu?=
 =?utf-8?B?SG5DV2F5TGYya2RaSVhUcTlpZGM1a2NvUTZzeEF5MU9XcDlHdzN2dWkrUHEx?=
 =?utf-8?B?aVZpeW5ZVjk1TkIrdU82ZnlJdjVKVC8rWVBjbUo4bUY1L0VvRk1EYnBtZUp2?=
 =?utf-8?B?WEJBbjZLb2dJbFVzVW93L1d1MFUzUk4rbFZqc2gxYTJJcDZRRjdobGRLbzJy?=
 =?utf-8?B?RVBUWkJqU0VwbzhwZUppV2tCZno4b0kxcWMyblE4eXhLZlN2VUlkTlA3SVZO?=
 =?utf-8?B?dlhkK1JlOTA5Z1lyb0RsR3VQa2YzU3JQbUppT2JSZ2RKQUdvYWNHSmFab3o4?=
 =?utf-8?B?Q1dVKy9kVFJNV3gwVmoxSVQxb29hb0hhcnhQU2R5K24ycjQ1UHpCeFNxK2lO?=
 =?utf-8?B?ZmlHMmtpamxFUFQreEQrMFAxMnRxVWZ6U0JWOEpqa2p5Mjh0Vk5aM0tCYzA4?=
 =?utf-8?B?TEh0RitkdW4rZkdXckUvYUtFODhZU25SZFc0ZkFaUGZ5UnAzbFF6Z3BuSkVB?=
 =?utf-8?B?eVlmZ0VndFJmT0NNdzI4RkNFNFpjczdKWjJHVnVQaWxFZWpwV1BOTzI0MGpF?=
 =?utf-8?B?YTY1S0s0bHArMS9aa2lkaFZHMEExZVY0UklyTFVLMTU1MDFQK1ArWXBDS1RC?=
 =?utf-8?B?UFBJZHdBQmpHbnJSQXNycmFyMDlnaXZmeEdjOWdMTklVaWJISmw5TUsyRXNn?=
 =?utf-8?B?QWJVUXMxTzh2VGVBemZWNHpCR3A0a0RsU2lxYlowYStrbHZITk96S2pFS1Ry?=
 =?utf-8?B?KytqNnh2T3FMS1c0STBNa3J6TGhOMWlWVU00bjBjaEpua1U5bUJud3VLTCtz?=
 =?utf-8?B?UytqNmFRZ3AxTm5SY1Q2YWRiOWNNV05Dc0hNNkFuakdRRUF5Tnd5dThwL3pK?=
 =?utf-8?B?VFJWdHdrNGhqNnE2b09QRjNMdVE2bzNGVHZoQm5VSDcramFiaSsySnc1TXB1?=
 =?utf-8?B?K1Z0N042Wm9VSWIrNHh0R0lrVmtnYWlOM0dQZnVYN2dPZnVBa0cyT3ZzemNW?=
 =?utf-8?B?cmg5YXErbmk1TzcyVFNjVXNncFR5OG1JdFEwVjJUOS81YXRDS0tKR0syeWFm?=
 =?utf-8?B?WWlibS9wTDhwZnhTcXZvRmp2VVI1dmxsb3M2dWplR1o4TEtkaVl2d2g1M1lu?=
 =?utf-8?B?MTFTZ0dDd1NTMXNCN1hLNi9kZGZIeVRQcll6d2NDYlZqaXJESlYyZ2lrc2ky?=
 =?utf-8?B?ejZwU1Y5S1QvNVh1S0tBZmg1N1g0M1VkUkdXMCtvQlJhR01ETWhxL0FFdDZl?=
 =?utf-8?B?VXpaUndXTG9oZmh1eUhKdUFWampkQ25tMXMzeGJxaXpiVFJhRndjOWFoNEE2?=
 =?utf-8?B?dFNWN1RkNGtZV05UOWhEdTllTjVJMlBMZ3I5Rlk5KzF2WnFYdDEvbEdPN0Yy?=
 =?utf-8?B?K0FLd0Z3M25qVmd0TXR4NTFoSlVGZVdLRXpQNTlXbDE1REVua3ZJckJpQUlp?=
 =?utf-8?B?V2xLS1k0MitKVzZ2djg1RGtHcWRLVXNtUU1kcHBXMHV4VHpEbjBJbno1UUpN?=
 =?utf-8?B?VmJqWmtFRjRiWXRNcHhZQWlqVnpuZXByT2RtOWM5dFZzcHo3SHJLckpCZ0Ro?=
 =?utf-8?B?NmZWYWlHaTVURzRiS0p1RVE3cmsyZTdOT0Fac3d1MHB5ZDFmMll6eHF0RFJz?=
 =?utf-8?B?RXQzMjBlczA3V3F2eFl0bUVhVUM3ZnFYUm9TanpxcTJqbGpTSUVDYktsTmtN?=
 =?utf-8?Q?pdQc3SHG990SF7lFmV+EjFiwE+RsBAo3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11423083927B7F4A876537BABA46AB80@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34da9b42-b94e-4524-7e05-08da0855454a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 20:32:35.2674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CzAtAtXvIUwdfiz7qyh2uEmU+xWEAgZMJqPzBXXV4e/jpyZlaOlGfQWECRa4gcFUOfuHM67R5LvSc7vVfVE23Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR05MB8114
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTWFyIDE3LCAyMDIyLCBhdCAxMjoxMSBQTSwgRGF2ZSBIYW5zZW4gPGRhdmUuaGFu
c2VuQGludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiAzLzE3LzIyIDEyOjAyLCBOYWRhdiBBbWl0
IHdyb3RlOg0KPj4+IFRoaXMgbmV3ICJlYXJseSBsYXp5IGNoZWNrIiBiZWhhdmlvciBjb3VsZCB0
aGVvcmV0aWNhbGx5IHdvcmsgYm90aCB3YXlzLg0KPj4+IElmIHRocmVhZHMgdGVuZGVkIHRvIGJl
IHdha2luZyB1cCBmcm9tIGlkbGUgd2hlbiBUTEIgZmx1c2hlcyB3ZXJlIGJlaW5nDQo+Pj4gc2Vu
dCwgdGhpcyB3b3VsZCB0ZW5kIHRvIHJlZHVjZSB0aGUgbnVtYmVyIG9mIElQSXMuICBCdXQsIHNp
bmNlIHRoZXkNCj4+PiB0ZW5kIHRvIGJlIGdvaW5nIHRvIHNsZWVwIGl0IGluY3JlYXNlcyB0aGUg
bnVtYmVyIG9mIElQSXMuDQo+Pj4gDQo+Pj4gQW55Ym9keSBoYXZlIGEgYmV0dGVyIHRoZW9yeT8g
IEkgdGhpbmsgd2Ugc2hvdWxkIHByb2JhYmx5IHJldmVydCB0aGUgY29tbWl0Lg0KPj4gDQo+PiBM
ZXTigJlzIGdldCBiYWNrIHRvIHRoZSBtb3RpdmF0aW9uIGJlaGluZCB0aGlzIHBhdGNoLg0KPj4g
DQo+PiBPcmlnaW5hbGx5IHdlIGhhZCBhbiBpbmRpcmVjdCBicmFuY2ggdGhhdCBvbiBzeXN0ZW0g
d2hpY2ggYXJlDQo+PiB2dWxuZXJhYmxlIHRvIFNwZWN0cmUgdjIgdHJhbnNsYXRlcyBpbnRvIGEg
cmV0cG9saW5lLg0KPj4gDQo+PiBTbyBJIHdvdWxkIG5vdCBwYXJhcGhyYXNlIHRoaXMgcGF0Y2gg
cHVycG9zZSBhcyDigJxlYXJseSBsYXp5IGNoZWNr4oCdDQo+PiBidXQgaW5zdGVhZCDigJxtb3Jl
IGVmZmljaWVudCBsYXp5IGNoZWNr4oCdLiBUaGVyZSBpcyB2ZXJ5IGxpdHRsZSBjb2RlDQo+PiB0
aGF0IHdhcyBleGVjdXRlZCBiZXR3ZWVuIHRoZSBjYWxsIHRvIG9uX2VhY2hfY3B1X2NvbmRfbWFz
aygpIGFuZA0KPj4gdGhlIGFjdHVhbCBjaGVjayBvZiB0bGJfaXNfbm90X2xhenkoKS4gU28gd2hh
dCBpdCBzZWVtcyB0byBoYXBwZW4NCj4+IGluIHRoaXMgdGVzdC1jYXNlIC0gYWNjb3JkaW5nIHRv
IHdoYXQgeW91IHNheSAtIGlzIHRoYXQgKnNsb3dlcioNCj4+IGNoZWNrcyBvZiBpcy1sYXp5IGFs
bG93cyB0byBzZW5kIGZld2VyIElQSXMgc2luY2Ugc29tZSBjb3JlcyBnbw0KPj4gaW50byBpZGxl
LXN0YXRlLg0KPj4gDQo+PiBXYXMgdGhpcyB0ZXN0IHJ1biB3aXRoIHJldHBvbGluZXM/IElmIHRo
ZXJlIGlzIGEgZGlmZmVyZW5jZSBpbg0KPj4gcGVyZm9ybWFuY2Ugd2l0aG91dCByZXRwb2xpbmUg
LSBJIGFtIHByb2JhYmx5IHdyb25nLg0KPiANCj4gTm9wZSwgbm8gcmV0cG9saW5lczoNCg0KRXJy
Li4NCg0KPiANCj4+IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L3Z1bG5lcmFiaWxpdGllcy9zcGVj
dHJlX3YyOk1pdGlnYXRpb246IEVuaGFuY2VkIElCUlMsIElCUEI6IGNvbmRpdGlvbmFsLCBSU0Ig
ZmlsbGluZw0KPiANCj4gd2hpY2ggaXMgdGhlIHNhbWUgc2l0dWF0aW9uIGFzIHRoZSAiWGVvbiBQ
bGF0aW51bSA4MzU4IiB3aGljaCBmb3VuZCB0aGlzDQo+IGluIDBkYXkuDQo+IA0KPiBNYXliZSB0
aGUgaW5jcmVhc2VkIElQSXMgd2l0aCB0aGlzIGFwcHJvYWNoIGVuZCB1cCBiZWluZyBhIHdhc2gg
d2l0aCB0aGUNCj4gcmVkdWNlZCByZXRwb2xpbmUgb3ZlcmhlYWQuDQo+IA0KPiBEaWQgeW91IGhh
dmUgYW55IHNwZWNpZmljIHBlcmZvcm1hbmNlIG51bWJlcnMgdGhhdCBzaG93IHRoZSBiZW5lZml0
IG9uDQo+IHJldHBvbGluZSBzeXN0ZW1zPw0KDQpJIGhhZCBwcm9maWxlZCB0aGlzIHRoaW5nIHRv
IGRlYXRoIGF0IHRoZSB0aW1lLiBJIGRvbuKAmXQgaGF2ZSB0aGUgbnVtYmVycw0Kd2l0aCBtZSBu
b3cgdGhvdWdoLiBJIGRpZCBub3QgcnVuIHdpbGwtaXQtc2NhbGUgYnV0IGEgc2ltaWxhciBiZW5j
aG1hcmsNCnRoYXQgSSB3cm90ZS4NCg0KQW5vdGhlciBwb3NzaWJsZSByZWFzb24gaXMgdGhhdCBw
ZXJoYXBzIHdpdGggdGhpcyBwYXRjaCBhbG9uZSwgd2l0aG91dA0Kc3Vic2VxdWVudCBwYXRjaGVz
IHdlIGdldCBzb21lIG5lZ2F0aXZlIGltcGFjdC4gSSBkbyBub3QgaGF2ZSBhIGdvb2QNCmV4cGxh
bmF0aW9uLCBidXQgY2FuIHdlIHJ1bGUgdGhpcyBvbmUgb3V0Pw0KDQpDYW4geW91IHBsZWFzZSBj
bGFyaWZ5IGhvdyB0aGUgYm90IHdvcmtzIC0gZGlkIGl0IG5vdGljZSBhIHBlcmZvcm1hbmNlDQpy
ZWdyZXNzaW9uIGFuZCB0aGVuIHN0YXJ0ZWQgYmlzZWN0aW5nLCBvciBkaWQgaXQganVzdCBjaGVj
ayBvbmUgcGF0Y2gNCmF0IGEgdGltZT8NCg0KSSBhc2sgYmVjYXVzZSBJIGdvdCBhIGRpZmZlcmVu
dCByZXBvcnQgZnJvbSB0aGUgcmVwb3J0IHRoYXQgYQ0Kc3Vic2VxdWVudCBwYXRjaCAoIng4Ni9t
bS90bGI6IFByaXZhdGl6ZSBjcHVfdGxic3RhdGXigJ0pIG1hZGUgYQ0KMjMuMyUgaW1wcm92ZW1l
bnQgWzFdIGZvciBhIHZlcnkgc2ltaWxhciAoeWV0IGRpZmZlcmVudCkgdGVzdC4NCg0KV2l0aG91
dCBhIGdvb2QgZXhwbGFuYXRpb24sIG15IGtuZWUtamVyayByZWFjdGlvbiBpcyB0aGF0IHRoaXMg
c2VlbXMNCmFzIGEgcGF0aG9sb2dpY2FsIGNhc2UuIEkgZG8gbm90IGV4cGVjdCBwZXJmb3JtYW5j
ZSBpbXByb3ZlbWVudCB3aXRob3V0DQpyZXRwb2xpbmVzLCBhbmQgcGVyaGFwcyB0aGUgZmV3IGN5
Y2xlcyBpbiB3aGljaCB0aGUgdGVzdCBvZiBpcy1sYXp5DQppcyBwZXJmb3JtZWQgZWFybGllciBt
YXR0ZXIuDQoNCknigJltIG5vdCBtYXJyaWVkIHRvIHRoaXMgcGF0Y2gsIGJ1dCBiZWZvcmUgYSBy
ZXZlcnQgaXQgd291bGQgYmUgZ29vZA0KdG8ga25vdyB3aHkgaXQgZXZlbiBtYXR0ZXJzLiBJIHdv
bmRlciB3aGV0aGVyIHlvdSBjYW4gY29uZmlybSB0aGF0DQpyZXZlcnRpbmcgdGhlIHBhdGNoICh3
aXRob3V0IHRoZSByZXN0IG9mIHRoZSBzZXJpZXMpIGV2ZW4gaGVscHMuIElmDQppdCBkb2VzLCBJ
4oCZbGwgdHJ5IHRvIHJ1biBzb21lIHRlc3RzIHRvIHVuZGVyc3RhbmQgd2hhdCB0aGUgaGVjayBp
cw0KZ29pbmcgb24uDQoNClsxXSBodHRwczovL2xpc3RzLm9mb25vLm9yZy9oeXBlcmtpdHR5L2xp
c3QvbGtwQGxpc3RzLjAxLm9yZy90aHJlYWQvVVRDN0RWWlg0TzVES1QyV1VUV0JUQ1ZRNlc1UUxH
RkEvDQoNCg0K
