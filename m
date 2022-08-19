Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89E359945B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 07:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245488AbiHSFU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 01:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiHSFU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 01:20:27 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2050.outbound.protection.outlook.com [40.107.113.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEAC52479
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 22:20:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIRLqyDRoIiyBQeNoyYVRD7haZ2Kr5+fOzNJUFEpGwyVyzplVzuExmDZllKSH3Kfs/YsFqe1wBskoee42+Vm8ozZs6HH/wePEq2nS0LusgcXMOp7HssAl3ksC+tK4fNX5qynt3DCctV9GqgmRpV1lm63xfzeGUY3ySo73a2zMHCkv7k+e+4bWZMwOx+WKUc5BIPBbUCLVkPLAo0Nhx49Yfew5+TKY5KD9Cn/oPN4CAYXfZ1sNK45yMrqEPILDTeZZpQtb+EcRUoyNOVF4+gvDh+sGnwt9zu7TB53Zc8p5NykxTBll+PXvyQCNO9ra/A9/Z+LCh+keeiI57G6myfCQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUn/Mt23AeGbgaOBkEELZoNnfpkpKIZlDxl5q+colRI=;
 b=NRoUskEsqv1W77rhXyO23TUwBVHpShoiBXNzt46Theh+7ztR368nC29c9fsE/WRyL4fIFlDO8nzTj753+ywfNjimkyfC9WQbFv7IlGWE2mhegaG4siF8DKcIflsUl7BjijA0Gz3lQdnvUFWAX5RYxOGPARVFEqTsVCYFZF4mge7ZRHOY8J+maz+4mjRJPJXATEFF2TDjdae7rXfRqHh51H0aRDR/5LMrkmd4PUJgfvJ8Iq3O7EWP0BuS72hyDnuMfMIgg+ayVXy1+SP6GJuNrlUPctH523BpnQXXeOTY06/K8UY2drmZntRdemwyn1mwUa/XZvzkJkbmlIsv2+pcag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUn/Mt23AeGbgaOBkEELZoNnfpkpKIZlDxl5q+colRI=;
 b=hZyPTX+MMYZhjne0is01DoddF5dwiYPSXJLzFuCw88zGMHqWpYRY8SxxlReMd3aZZvTiiZc59+GqHoEAmBXuq8SMMYklxjMsJxqlbHlK4TDk3qvyOebH7JH/sZ9u6fHrM3/WrOSpfaHZCJ2Jkwl3yIImZF8RiAqFoc2vOwGikXc=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYYPR01MB7880.jpnprd01.prod.outlook.com (2603:1096:400:112::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Fri, 19 Aug
 2022 05:20:24 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a%6]) with mapi id 15.20.5546.016; Fri, 19 Aug 2022
 05:20:23 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] mm, hwpoison: fix page refcnt leaking in
 try_memory_failure_hugetlb()
Thread-Topic: [PATCH 1/6] mm, hwpoison: fix page refcnt leaking in
 try_memory_failure_hugetlb()
Thread-Index: AQHYswKKFCDHUyBzfEWWAxSjDSXnHa21sKaA
Date:   Fri, 19 Aug 2022 05:20:23 +0000
Message-ID: <20220819052003.GA613144@hori.linux.bs1.fc.nec.co.jp>
References: <20220818130016.45313-1-linmiaohe@huawei.com>
 <20220818130016.45313-2-linmiaohe@huawei.com>
In-Reply-To: <20220818130016.45313-2-linmiaohe@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ab162a1-382c-46cc-d3fa-08da81a284a1
x-ms-traffictypediagnostic: TYYPR01MB7880:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mcc8TOwfeAn+AP880rZ1d+ZTXcxK6T+Wrt8J/r90bGocOuo4aOXACiTvvy1IxL9a+QWBzVYIDpe+r5IoLS3GTf19osjhhm1aLeAmEtEXc7wB0fYA1afMw/QPsmOhtqypwFbLcp9awYap7iNdQIdodfvr5x5s12tfoRkS8tyJnM/rQjBRvvcdfKYv94gDKJ9XybYYoeqF8xDl4l7R0Xuf0dWMlKhMcoFybo4SArlMgqsRpIHO1Y9KhF5SfRPgwR/PX+VJ1vM8ZH5TY0Q5X6SmSMI1Dwx0QKAhlFgZVcgGQcleFemriMKje/mcbtOy69T6aELnFoiW7poY1mnzguZ0rpzCN6/qnwSaYgdUGqHmk1MQjOe59297Rpv5pT3zt7K6bWIy1JBFhaCa19JGrvzw91g0keVhsy26nnAUvO3/T4IrKMN8IOQF9DI12vg1ccyAZZJsvL+OalVioOn6m+SD3ISxNNvelaHIvIxaOQFoXwUdYi4+pcTdswWtah3KFpddTqEAw/E7d4rtHSi43yUutUb1JNrh3+xutt/S8qmiYs35CuSgdshF5HNoMP8eEA8Nl02nXfmRaZRGv250BLvdi5Cdm4a0QLUucC1hEjQtgjYW4KmdBlpXTnwsHc85vTuwXL5rtS8bNlUoVdSqJPfHQI5zvbWXZAGI6NJFEn6R92R0iVAfzZ8WmYICWGpzMYCm5jI2lL69ib+ju/tnWXHZqQ/3xbuw84yAU8Ka/2rA5tdu4gGLpn5z2X6viopEq0Ew8Ylx41FE66HciY/5c1im4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(4326008)(83380400001)(38070700005)(186003)(38100700002)(8936002)(82960400001)(1076003)(2906002)(86362001)(122000001)(64756008)(76116006)(66476007)(66946007)(66446008)(66556008)(5660300002)(8676002)(54906003)(55236004)(316002)(71200400001)(6486002)(6916009)(33656002)(41300700001)(9686003)(478600001)(6512007)(6506007)(26005)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTFvWkV2ckNnU0E0ZTJGVnVleUhHdlNWR215N2xaOXorSzZiNzZJT1R6MTRv?=
 =?utf-8?B?QmorZVFZUlhaVitRN1dEd09LR2pkUnZZdmVVV01nWXFrd1JpRDZEQTdKSzYy?=
 =?utf-8?B?VURXc09NcGdHTVhiWVB0S2h3WmJnS1F1SDlObWh2U1p3aCtDM0ZZNkhnVXhl?=
 =?utf-8?B?K0dFMTlIMU9qTVZzQUd3aHJaRXZ4V3lzYXVnbTc5UTA1L25rakFqZXlWOWZh?=
 =?utf-8?B?N3BYZzR4NHRCcDZzRCsveS82ei9IL2pGcWlUQ2s3VFppYTBzMHJZMDVTOU54?=
 =?utf-8?B?bVRuS3pxV3NXZThPNHpHejgwL00rWDdSQ3l2WmRzUE91eXpVV3EzMXdTdkx2?=
 =?utf-8?B?SlpyeEd2dWFXeFJZVzRBSFVueGF0dkZZei8xQTlURGNGRm9wcGtBNStNbjUv?=
 =?utf-8?B?RHd3M3lxVFNXR1NSQVRxLzVsOEROZFJCRFJOT3FxdHd5L0RwcHNCY0VKZFFJ?=
 =?utf-8?B?TWJ0eUJ3c0hGb0N4UE1UMnB3aVU1OVFFT01PSXJBMkRuTnJlWDV3bmZqdnEy?=
 =?utf-8?B?VHQ3cXJMWXpnekR4NW0rSkpHY0ZqVVA0bkZ2YTQzdnZvYXJuU21wV3JQNzZi?=
 =?utf-8?B?cDlHbDZqMThEM2FYVjF1alFCakVtdEtnc1BxaGxRWm54UEY4S2dVa3c1NkVF?=
 =?utf-8?B?QTFRZkNIOFlnNThoRHA1U1ZpRzdRNVRRZVJxME9ZNlRpYi84SnlPR0pmcnlK?=
 =?utf-8?B?bkJxU2tBWTlYZFpHb0RWRCtmejBod3Y3dlBaVjQ3bUgvSHZGNTRoeWRUT3FV?=
 =?utf-8?B?MjBnelg2aWgyZHhTRWFCdWN2SFE5WmxrTGdlQk1vdzRNKzZldlZXZWVwYWxR?=
 =?utf-8?B?eU9wcTdKYlpwdnd0ZHo5TERtN1BBdmFlb3BIajFxNzFITUdZOGhkbmlIM3lK?=
 =?utf-8?B?dkNqMk9SUHdVT0tiRFRtSlk3SnVyT2tmR0dvcDBEQzV1aUxrWENnaCt1d2FL?=
 =?utf-8?B?WjA1M2JRakdrdk5jYkN4cUszaVlYbElCaUdvNldqWkxldGdoRGZoamdoSVpK?=
 =?utf-8?B?aWRtS2sydXJKZG1MR0crUTV1VUwrUjhjNFhJV091UmIzRGQvSytNVkVUT2VS?=
 =?utf-8?B?N0FKcCt6MUlWOElPdG5LMzZWcTk5MmJ0VEFvdEdqZVZLVVo4elIyeFM4UHNu?=
 =?utf-8?B?WFg5bzFybkxRRGxtc0NuYldYa1NJSyswTGNNWHZGaEF1eGczWXNnYlRCTjhL?=
 =?utf-8?B?QkFacC9taGJNc3U2N0lQZVBzcUlpdDZEdGhtSUJEME0rU3FiaUtLVVUwbFRs?=
 =?utf-8?B?VTAzbzdYcURnajFOckdCZjlFS2Z0TGFscFBPMCttN0ttNTA2QWtkU2xibEhh?=
 =?utf-8?B?a2dmanFSd1RYckpQS0RGSzJUVDJxVEE3UTVXVDNVRE1VT2UraU1aMzJ2RFho?=
 =?utf-8?B?U3dNVWNpUTU2N2lLQ3ZwU2M2Vnd2NlpNYVhaeW4zYmxPR05EWFlONWpBTUha?=
 =?utf-8?B?c3NJSnhaSVJnMzI3bWhibU5CUWhzc2c4RDd2OXhSaC8xN1IrTXljWi94NnBZ?=
 =?utf-8?B?SW4vOXdpZnlTMmhkOFY2MlFwMlNEbHE5OXF3MjNKeU1pUGFLdlJ5RitKdjFD?=
 =?utf-8?B?a1pscHVFN29idS9zT0hMUFlCblhMSEFyYURWZTVteXpyMTAxK3QySG96cmlB?=
 =?utf-8?B?dlgyd3JyV3JwQmF5YS9CWVljYXU4V0g0cnhjY1l4NmFZWmFmQm1sZFUvRFBL?=
 =?utf-8?B?eldwV1RXelZMNWptTzNiT3dRR3NXNUszc3F5UkJGTU1ZQkxKZ0FwWlZDa1Y2?=
 =?utf-8?B?WWFjQ0d5QlgzZ21DblJ2eTBNQ3RXaDMvSTNHNDlGUC9Mb25MdXliZkpibDN4?=
 =?utf-8?B?dHBNWGNvQkVwbENZYzJFN0s5dVNUektMRW0yRnozY05mNkwwUXl1dmxDem9Q?=
 =?utf-8?B?NThYTFI3UTN4S2xjQm9ET0p1ZHVZTDhiTDVHUjM3NzVoVGh6c3A4M1dEdTlT?=
 =?utf-8?B?K0htemcxaXJFVExtcTFVTjN1NHJEVGNvY0JhM3NrcHhIRVhYMUpMeHQ0Qkhv?=
 =?utf-8?B?b1duWGJpRklHQVJ6blVWUzI0OEZ0THZwOTVWQkFpenA5MnZoV1RUa0pmOE53?=
 =?utf-8?B?RUpyWHZiMlJ2SjhxOUJmR1kvNmtUVnEyVEZ2ZlBRRHJYMGI4RldVTXRiN0Qz?=
 =?utf-8?B?S3lScERGbkhydXE3aXQwQTFqTTdkejJjWURncXh0RFVDck9jUHkvUXNqdVY4?=
 =?utf-8?B?V0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B69B50587F10F46ACAF9E2E4743345C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab162a1-382c-46cc-d3fa-08da81a284a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 05:20:23.5603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d8NCxXeL4eE2lWS1Gflbs/FuhwNvVX/95+dfBlG6H1P+ROmQUrni7/Bi7PqKicUykaMISomsIrnQ/KzlEiJcbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7880
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBBdWcgMTgsIDIwMjIgYXQgMDk6MDA6MTFQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gV2hlbiBod3BvaXNvbl9maWx0ZXIoKSByZWZ1c2VzIHRvIGh3cG9pc29uIGEgaHVnZXRs
YiBwYWdlLCB0aGUgcmVmY250IG9mDQo+IHRoZSBwYWdlIHdvdWxkIGhhdmUgYmVlbiBpbmNyZW1l
bnRlZCBpZiByZXMgPT0gMS4gVXNpbmcgcHV0X3BhZ2UoKSB0byBmaXgNCj4gdGhlIHJlZmNudCBs
ZWFraW5nIGluIHRoaXMgY2FzZS4NCj4gDQo+IEZpeGVzOiA0MDVjZTA1MTIzNmMgKCJtbS9od3Bv
aXNvbjogZml4IHJhY2UgYmV0d2VlbiBodWdldGxiIGZyZWUvZGVtb3Rpb24gYW5kIG1lbW9yeV9m
YWlsdXJlX2h1Z2V0bGIoKSIpDQo+IFNpZ25lZC1vZmYtYnk6IE1pYW9oZSBMaW4gPGxpbm1pYW9o
ZUBodWF3ZWkuY29tPg0KDQpMb29rcyBnb29kIHRvIG1lLCB0aGFuayB5b3UuDQoNCkFja2VkLWJ5
OiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg0KDQo+IC0tLQ0KPiAg
bW0vbWVtb3J5LWZhaWx1cmUuYyB8IDYgKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21tL21lbW9yeS1m
YWlsdXJlLmMgYi9tbS9tZW1vcnktZmFpbHVyZS5jDQo+IGluZGV4IGU0OGY2ZjZhMjU5ZC4uMjI4
NDBjZDVmZTU5IDEwMDY0NA0KPiAtLS0gYS9tbS9tZW1vcnktZmFpbHVyZS5jDQo+ICsrKyBiL21t
L21lbW9yeS1mYWlsdXJlLmMNCj4gQEAgLTE4NjAsOCArMTg2MCwxMCBAQCBzdGF0aWMgaW50IHRy
eV9tZW1vcnlfZmFpbHVyZV9odWdldGxiKHVuc2lnbmVkIGxvbmcgcGZuLCBpbnQgZmxhZ3MsIGlu
dCAqaHVnZXRsYg0KPiAgDQo+ICAJaWYgKGh3cG9pc29uX2ZpbHRlcihwKSkgew0KPiAgCQlodWdl
dGxiX2NsZWFyX3BhZ2VfaHdwb2lzb24oaGVhZCk7DQo+IC0JCXJlcyA9IC1FT1BOT1RTVVBQOw0K
PiAtCQlnb3RvIG91dDsNCj4gKwkJdW5sb2NrX3BhZ2UoaGVhZCk7DQo+ICsJCWlmIChyZXMgPT0g
MSkNCj4gKwkJCXB1dF9wYWdlKGhlYWQpOw0KPiArCQlyZXR1cm4gLUVPUE5PVFNVUFA7DQo+ICAJ
fQ0KPiAgDQo+ICAJLyoNCj4gLS0gDQo+IDIuMjMuMA==
