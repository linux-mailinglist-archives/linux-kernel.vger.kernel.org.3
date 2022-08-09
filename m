Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2A258E198
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 23:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiHIVLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 17:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiHIVK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 17:10:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C273D587;
        Tue,  9 Aug 2022 14:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660079454; x=1691615454;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LjfbprQhLIVBSHHIY5HatDm6Qk8pHtPsTYi4oGGz8CQ=;
  b=Z3k6iyIKC+oZp/ksZUE+Ey9CRG4UvNFhSJykuGFMIPshyN5fuj8xsODA
   Bp/M1WPdpJQMS1O4l4it0cwBclAoaEM0DAtHJ091nBkiYuiVhK752knEn
   sJouEboHue0BUjGEDY5VkBpZz89m7wUh5BgMDdmyPvvV+hL8eNYCfULIz
   l0VG7rwWLeQ4YALjUnaq6JVimESF0/+KBzm3H4viAVR7jseK8frQyyujJ
   1xTdyyEk1DOtgxBxT/gmeAYT/AMcHt3f5Ow0OB3gD2/ouAXowJ29Pfe0D
   /CPtjVspc6N+tthGrtDbPAaBgQBki4Nk5Tc/IAo/ArrKOmk/FWxx2WUXK
   A==;
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="171701164"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Aug 2022 14:10:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 9 Aug 2022 14:10:51 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 9 Aug 2022 14:10:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkbvAqpqPW1bGkYr5ssB0CiiOHbcWulHA7XxaYOcQNnWrysdrBhGqFeUZeROATKjvakFUwF0PYaXyOYDhE1qxR1fFWktTB/73Of3OFglAYNo9rrusLAXbWY1GsY7B4L0/MlYuDWf1b4yIrga1gV6iWX1xcVbkXm+sJPzGKiQm7yg2/2qGes4NChnqDKUrkWCeQogdVjUvUsKQFxcE6mNnNnFn0dQocM1AvZbwnSAbsY92AbOycPpNgmeMXblLhHhY1W/daBT+GP0UNn/djmy9Zd2IpSSwo8BidDf0cTwzykUond0f08DjkzOTekqRpEnvIHaePpOJ5iTZDUjbq/UuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjfbprQhLIVBSHHIY5HatDm6Qk8pHtPsTYi4oGGz8CQ=;
 b=CzYpSVYHUMFltVfsHij/1DL2qv28n424N73UaHHIK1yV+duOSRhgrPFu1R8LIvia7Rv7e9I6qJx8Us/iqq7zFiww6ftNJnF7nH4eht97Qv5RVbR6BRhbJzK+6SXJxsAD8bsIlVLQyYPYgGudPOrGIcfQp3qFcKQlnV1tH1QxHcPdZhjJVYnnZl6PSaH02wpz5HN85DH1ZXQkioRp5KEBlrPbdnaGH7Yq3uWGNz/i9KUUDoJnMX925goqAnAzHS3hrA4oPTr65c8uZmdokM/HfGEUvTzw7302dHRuWeJThJNSUQd1zHBIxNjxb+K/w6P3jaK/AmPye9MEOxJGjDjzzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjfbprQhLIVBSHHIY5HatDm6Qk8pHtPsTYi4oGGz8CQ=;
 b=hrd+NpmkauvT7jL+p6oDx3OzT8roLzhPkTvb0GBj2X8nJHpkXh7SfOtDY8lVJF3j76xypqR156J/rGbjUcn1IEUWw2ndTZiLoxIcUT/nKUGovIT9GKSvYPFuPCNLI3Q+y0tzZFWjoiLxd5RsxIPcXgtE9qzDwYh3WkJD/XCzj3g=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CY4PR1101MB2293.namprd11.prod.outlook.com (2603:10b6:910:22::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 9 Aug
 2022 21:10:46 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 21:10:46 +0000
From:   <Conor.Dooley@microchip.com>
To:     <xianting.tian@linux.alibaba.com>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <anup@brainfault.org>, <heiko@sntech.de>, <guoren@kernel.org>,
        <mick@ics.forth.gr>, <alexandre.ghiti@canonical.com>,
        <bhe@redhat.com>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
        <corbet@lwn.net>, <Conor.Dooley@microchip.com>
CC:     <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <crash-utility@redhat.com>, <huanyi.xj@alibaba-inc.com>,
        <heinrich.schuchardt@canonical.com>, <k-hagio-ab@nec.com>,
        <hschauhan@nulltrace.org>, <yixun.lan@gmail.com>
Subject: Re: [PATCH V5 1/6] RISC-V: use __smp_processor_id() instead of
 smp_processor_id()
Thread-Topic: [PATCH V5 1/6] RISC-V: use __smp_processor_id() instead of
 smp_processor_id()
Thread-Index: AQHYpmofx68ajylNiUmd0swDoyrKZq2nHCaA
Date:   Tue, 9 Aug 2022 21:10:46 +0000
Message-ID: <4a3c8f81-6b4a-4cfc-5098-959fab87ac44@microchip.com>
References: <20220802121818.2201268-1-xianting.tian@linux.alibaba.com>
 <20220802121818.2201268-2-xianting.tian@linux.alibaba.com>
In-Reply-To: <20220802121818.2201268-2-xianting.tian@linux.alibaba.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0eed9c1f-99bd-413f-f2c3-08da7a4ba096
x-ms-traffictypediagnostic: CY4PR1101MB2293:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fCxAINMjNVxpiuj+E5jl0L1tVKyYEtmMonzmo9SP0RQD7FJslo92A2XsEakvqmZSK+VshQkA8o7OaBNFsdTjueIZLsKzA3hHXu47O9VdCO5SWnnJmnWlp+qmeycG0DQF8E/otfpHXwQNGB4EQPM2Rxzo5fI5Zm4EX/N+9vni2mrbSdSuXIBgaQZ45Gprn9UH4BQuY7a3+UjZKca2xYFVBRDe6QpkAc10QlPe4zNGIR42FIf9+FKcE1vCNjMMoqecKbOh+DL7sEAi5BIGUIhzHeEIwG/UKyV2SsT+H7qZz+dYouHkPTBtsZgwP+fyAW9il7VitdRFyfckEmgkUcHDq1DpEZ7pdP7mrybz+4vVi1k6byNLBTfs3edckDdsWKAZwFMKHx6GhDVkhMU9rYPchi+7juLQrEsWR7VH8DXQQG8OAjwExvva5q4s3FEL3IQW09TZMKSXXcjNGUC1XvWfnM35d4/FYxocRCx/S8ntlcwXd1U7TMDddLJvxh56Tn3tQesKkph6TGNpfZLtYNJlUeu8Ljk2Db0GsWT+yx1ckheYmeC9kVlUOTcjctAYqMQW0Hr39U74vT2+DkJQ+bXl9pMBDyWaFIqnvuPx/tFe2piUNKRjIg/QWxyxgc036xJfDYRkcLSS2kK2I3EzgqwEHNbFgyHFX39mG7JmbGfJOcx1FxTTrVikF84fEfoCaXEYvH/W5waXVV2wR//9h/kO67Mt+MiAmDXSqfbpn9qPUiRhCXtga70npEH9++MaP7r3jzO+B38MFZnQ3pmjhSW3BF9oFNaqVqn+8XP4wMPKeBFib3jBD9nExVo3S8zPimzB1WLsE3nTrdhsfbqIp7mXv7D0iYVReCogfE3nZ5vt+N+5Dn+SZAfBqLUuJQCWwRzfyvMgVZCa9ZSHpiQPacpZLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(346002)(39860400002)(376002)(396003)(478600001)(2906002)(38100700002)(6486002)(66946007)(4326008)(8936002)(66446008)(91956017)(921005)(31686004)(66556008)(66476007)(76116006)(7416002)(38070700005)(5660300002)(122000001)(53546011)(86362001)(186003)(6512007)(71200400001)(6506007)(26005)(2616005)(41300700001)(54906003)(316002)(64756008)(31696002)(110136005)(8676002)(36756003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Uk1LUHZvTUNaRUtQdDRTK2p4WW5oRUZsQnJZNlB6UWt6bnlEYVFSZkNPRzkz?=
 =?utf-8?B?U1RhaDVaMlVNQ3NCaFNaT25sc0t1NkdNU2xnWGlyTGJoUlBGWjAvSk5MeHhv?=
 =?utf-8?B?MzJJOGs2bndLVDQ4elN0bElHSWV0SDk2LzVWODNBN21aNHY2WUJJTWdUYW1y?=
 =?utf-8?B?a3J0UGE2Mis5QWlHZG0vSnNWNmJCUHdDSkRjTlh1ZVZ4bHdXK3ZwcWJqTHhm?=
 =?utf-8?B?eitLU09peEFmdVBxdHA0K3pTY3M0SERlZnVFZ3dsTnJ5ZTI4Y1BXUERQYUJt?=
 =?utf-8?B?QnF0cExUS2oxc1g4eHhJRjFXNkZxY25WV1NJV0lHUEE3bXlRYnkxUTJLUVVI?=
 =?utf-8?B?RzFzeENrSEFRQXUrVzB2ekVhem1MckhGTDRoeE80b1k2eEdHWDVmcTE4d1Zo?=
 =?utf-8?B?QUg2K2Fxc3M2dk5TOGNzY2xrT3JmZG0rc0tTems0aEFaVFNJVTZCekZmT0pu?=
 =?utf-8?B?TlRKbE9UaDZvOERjTVhDSWpZY0VSU0NUL3AxLzVpb0xHWUY0b1ZEZ1NDRGhQ?=
 =?utf-8?B?Q2k0alJud3lZUjMzZVpYOWtaTnNISVovOHJ3SHUxazFNME5iM1Z6bUw2QjFx?=
 =?utf-8?B?R0g5cUJjTTRJQTRacXk0TVkxcnovRG9kR2hMbGswYSs1WERZWGRiWFJsMzVa?=
 =?utf-8?B?RzhqMXpsWDhnZW83aHJrT2grcmtLaUNOOG9TT09lN25xQ2pVV0ZBaFkza0FU?=
 =?utf-8?B?cjVCWmd6TlRNM3haNWxjRldKK29kN2VYUXlkS0ZaUGZPOEs5anp4ekQ4ODBH?=
 =?utf-8?B?MitSakNKQUVpcklnY1FhZ1RPdGU4MEpPQXpqN2ZzSVkrOFZQZURnc21hZ2J3?=
 =?utf-8?B?b2UvaTJwVkIxejBtTzFta0k5UVp0dkV0c2xMWkYvYllpelRLTUR3dDdQeEc2?=
 =?utf-8?B?a0tVRlh3OU5md1F5eVZZa0EyUmpvNDhOMjh6QjlWUkZmcGZqOGd3MnVFVGw5?=
 =?utf-8?B?OUNUdHFGVVdtcEtrVVJpWEdDTnNtdk9mc05ERGZwZDg2WktydDRvTlZEanhz?=
 =?utf-8?B?V2xtWjY1ZVhZbno2cldFYmdUdWhxMmMwaVdrRnYzMkZveUZTbk12Szd6YjFE?=
 =?utf-8?B?dStsWEpkR3hDdHRzUHZveWdrSW92QUpFVkxQTWpLZGhRV3h4TkNyRndqZHV6?=
 =?utf-8?B?RlFRN3F3c2RnbHowbnBwNWs4OUR2MzhBRmgxVEpmV2RtbkZlVkpsVFpOTmxt?=
 =?utf-8?B?eEN6cDBhNkwvMjViTGNEbm40a2IxNDBXSWFhUC9BdmlVWEZ3Q0dFeEh6RkZx?=
 =?utf-8?B?eVVIdXk4MzNJL3g3ajU5eGRtRTBuRWJyMFhpTVkweno5MVhtM3Y3c1ZHaFhW?=
 =?utf-8?B?TmF0WlNkd3ZzcUZqYVRsd1gzQi9iNUQvbG9Fc2Y2WlhSbEpZdEd2dTlSWk5n?=
 =?utf-8?B?aENwUEwyWjJaSEFiYUt5VGFLejdDSlNsTHV5ZDRyLzNJc1FYSC91WURXbWdR?=
 =?utf-8?B?SGpYdVJuWFpBOWZxVkJZWW1wcHppMTJ2M1JMekhPTXlPSDVha1M2eFRpWTZo?=
 =?utf-8?B?eWcvSktBeHNWNWY5NXdJeUlVWUt1dVNBQWE3WHEwTlBza0hhalNySS9XQnJT?=
 =?utf-8?B?Y3p3ankzQU1YeWxNN0R5cVBjUldBWERJQWgyOXE3L2FwT21MTy9XTFBuQmkw?=
 =?utf-8?B?MzhKNmthc1dDalVuR3czUWFKdkJnMVNWT05WbXNSYm5XTFVNOU4xME1zbTRW?=
 =?utf-8?B?ZnBMemovZFdFREZkWHMyMURHemxnejkwWGdlWlJBOG16VFBZci9LVUF4Rm5W?=
 =?utf-8?B?RjBCQW9FTWI2SVl0QUtSVkVXTVh5cjN5VCt6V0hyNVdCdXBpdVBXYzg3aGNS?=
 =?utf-8?B?dG0rTFJOTlB1U2VuM0Vmd2cxRmptbWVoc1VrRXBHZWxSak0yYklJby9WQ2w4?=
 =?utf-8?B?b29RSnpXbUpUMUxxMzlUMTFEbFZieVp6YnRtMklyTVMyMEp5WHdyWnpYdC9a?=
 =?utf-8?B?UjEvczhGb2pycjFjYjJSbUViWkk4a01YTUxKckFlNWVuY3Rud3Nld2NPQld5?=
 =?utf-8?B?dENFWEpIak95NWIvSjE1M1g4Tm1QcWhRVzJLRWJkZ3JNT3dZOXl4QmpZNkJY?=
 =?utf-8?B?NXAwa0FkN1M4OHI5cTdMajVOUjNXQ2txV0dmZEpKdXhSZVphWXNySUYwNGls?=
 =?utf-8?Q?rJLqXwR649WjzFMxZ/DxuBnv3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBB387BA053DB04AA7A26ED5C50FD5D5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eed9c1f-99bd-413f-f2c3-08da7a4ba096
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 21:10:46.1104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tg/hzpn6CCkO8n2jOU5led7dr1MoPN+O1SUqOnWGfahJor74GqD4kGM59e3SUaScMcXT/l/h9yNur5tYE+kZrhjWQ9Zqn0nxurDnUOQKmh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2293
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDIvMDgvMjAyMiAxMzoxOCwgWGlhbnRpbmcgVGlhbiB3cm90ZToNCj4gW1BBVENIIFY1IDEv
Nl0gUklTQy1WOiB1c2UgX19zbXBfcHJvY2Vzc29yX2lkKCkgaW5zdGVhZCBvZiBzbXBfcHJvY2Vz
c29yX2lkKCkNCg0KRldJVyB0aGlzIHN1YmplY3QgaXMgdmVyeSBub24gc3BlY2lmaWMgLSAgaXRz
IG5vdCBlYXN5IHRvIHRlbGwgd2hhdA0KaXQncyBhYm91dC4gSG93IGFib3V0IHNvbWV0aGluZyBz
b21ldGhpbmcgbGlrZToNCg0KUklTQy1WOiBrZXhlYzogZml4IHVzZSBvZiBzbXBfcHJvY2Vzc29y
X2lkKCkgaW4gcHJlZW1wdGlibGUgY29udGV4dA0KDQoNCj4gVXNlIF9fc21wX3Byb2Nlc3Nvcl9p
ZCgpIHRvIGF2b2lkIGNoZWNrIHRoZSBwcmVlbXB0aW9uIGNvbnRleHQgd2hlbg0KPiBDT05GSUdf
REVCVUdfUFJFRU1QVCBlbmFibGVkLCBhcyB3ZSB3aWxsIGVudGVyIGNyYXNoIGtlcm5lbCBhbmQg
bm8NCj4gcmV0dXJuLg0KPiANCj4gV2l0aG91dCB0aGUgcGF0Y2gsDQo+IFsgIDEwMy43ODEwNDRd
IHN5c3JxOiBUcmlnZ2VyIGEgY3Jhc2gNCj4gWyAgMTAzLjc4NDYyNV0gS2VybmVsIHBhbmljIC0g
bm90IHN5bmNpbmc6IHN5c3JxIHRyaWdnZXJlZCBjcmFzaA0KPiBbICAxMDMuODM3NjM0XSBDUFUx
OiBvZmYNCj4gWyAgMTAzLjg4OTY2OF0gQ1BVMjogb2ZmDQo+IFsgIDEwMy45MzM0NzldIENQVTM6
IG9mZg0KPiBbICAxMDMuOTM5NDI0XSBTdGFydGluZyBjcmFzaGR1bXAga2VybmVsLi4uDQo+IFsg
IDEwMy45NDM0NDJdIEJVRzogdXNpbmcgc21wX3Byb2Nlc3Nvcl9pZCgpIGluIHByZWVtcHRpYmxl
IFswMDAwMDAwMF0gY29kZTogc2gvMzQ2DQo+IFsgIDEwMy45NTA4ODRdIGNhbGxlciBpcyBkZWJ1
Z19zbXBfcHJvY2Vzc29yX2lkKzB4MWMvMHgyNg0KPiBbICAxMDMuOTU2MDUxXSBDUFU6IDAgUElE
OiAzNDYgQ29tbTogc2ggS2R1bXA6IGxvYWRlZCBOb3QgdGFpbnRlZCA1LjEwLjExMy0wMDAwMi1n
Y2UwM2YwM2JmNGVjLWRpcnR5ICMxNDkNCj4gWyAgMTAzLjk2NTM1NV0gQ2FsbCBUcmFjZToNCj4g
WyAgMTAzLjk2NzgwNV0gWzxmZmZmZmZlMDAwMjAzNzJhPl0gd2Fsa19zdGFja2ZyYW1lKzB4MC8w
eGEyDQo+IFsgIDEwMy45NzMyMDZdIFs8ZmZmZmZmZTAwMGJjZjFmND5dIHNob3dfc3RhY2srMHgz
Mi8weDNlDQo+IFsgIDEwMy45NzgyNThdIFs8ZmZmZmZmZTAwMGJkMzgyYT5dIGR1bXBfc3RhY2tf
bHZsKzB4NzIvMHg4ZQ0KPiBbICAxMDMuOTgzNjU1XSBbPGZmZmZmZmUwMDBiZDM4NWE+XSBkdW1w
X3N0YWNrKzB4MTQvMHgxYw0KPiBbICAxMDMuOTg4NzA1XSBbPGZmZmZmZmUwMDBiZGM4ZmU+XSBj
aGVja19wcmVlbXB0aW9uX2Rpc2FibGVkKzB4OWUvMHhhYQ0KPiBbICAxMDMuOTk1MDU3XSBbPGZm
ZmZmZmUwMDBiZGM5MjY+XSBkZWJ1Z19zbXBfcHJvY2Vzc29yX2lkKzB4MWMvMHgyNg0KPiBbICAx
MDQuMDAxMTUwXSBbPGZmZmZmZmUwMDAyMDZjNjQ+XSBtYWNoaW5lX2tleGVjKzB4MjIvMHhkMA0K
PiBbICAxMDQuMDA2NDYzXSBbPGZmZmZmZmUwMDAyOTFhN2U+XSBfX2NyYXNoX2tleGVjKzB4NmEv
MHhhNA0KPiBbICAxMDQuMDExNzc0XSBbPGZmZmZmZmUwMDBiY2YzZmE+XSBwYW5pYysweGZjLzB4
MmIwDQo+IFsgIDEwNC4wMTY0ODBdIFs8ZmZmZmZmZTAwMDY1NmNhND5dIHN5c3JxX3Jlc2V0X3Nl
cV9wYXJhbV9zZXQrMHgwLzB4NzANCj4gWyAgMTA0LjAyMjc0NV0gWzxmZmZmZmZlMDAwNjU3MzEw
Pl0gX19oYW5kbGVfc3lzcnErMHg4Yy8weDE1NA0KPiBbICAxMDQuMDI4MjI5XSBbPGZmZmZmZmUw
MDA2NTc3ZTg+XSB3cml0ZV9zeXNycV90cmlnZ2VyKzB4NWEvMHg2YQ0KPiBbICAxMDQuMDM0MDYx
XSBbPGZmZmZmZmUwMDAzZDkwZTA+XSBwcm9jX3JlZ193cml0ZSsweDU4LzB4ZDQNCj4gWyAgMTA0
LjAzOTQ1OV0gWzxmZmZmZmZlMDAwMzZjZmY0Pl0gdmZzX3dyaXRlKzB4N2UvMHgyNTQNCj4gWyAg
MTA0LjA0NDUwOV0gWzxmZmZmZmZlMDAwMzZkMmY2Pl0ga3N5c193cml0ZSsweDU4LzB4YmUNCj4g
WyAgMTA0LjA0OTU1OF0gWzxmZmZmZmZlMDAwMzZkMzZhPl0gc3lzX3dyaXRlKzB4ZS8weDE2DQo+
IFsgIDEwNC4wNTQ0MzRdIFs8ZmZmZmZmZTAwMDIwMWI5YT5dIHJldF9mcm9tX3N5c2NhbGwrMHgw
LzB4Mg0KPiBbICAxMDQuMDY3ODYzXSBXaWxsIGNhbGwgbmV3IGtlcm5lbCBhdCBlY2MwMDAwMCBm
cm9tIGhhcnQgaWQgMA0KPiBbICAxMDQuMDc0OTM5XSBGRFQgaW1hZ2UgYXQgZmM1ZWUwMDANCj4g
WyAgMTA0LjA3OTUyM10gQnllLi4uDQo+IA0KPiBXaXRoIHRoZSBwYXRjaCB3ZSBjYW4gZ290IGNs
ZWFyIG91dHB1dCwNCj4gWyAgIDY3Ljc0MDU1M10gc3lzcnE6IFRyaWdnZXIgYSBjcmFzaA0KPiBb
ICAgNjcuNzQ0MTY2XSBLZXJuZWwgcGFuaWMgLSBub3Qgc3luY2luZzogc3lzcnEgdHJpZ2dlcmVk
IGNyYXNoDQo+IFsgICA2Ny44MDkxMjNdIENQVTE6IG9mZg0KPiBbICAgNjcuODY1MjEwXSBDUFUy
OiBvZmYNCj4gWyAgIDY3LjkwOTA3NV0gQ1BVMzogb2ZmDQo+IFsgICA2Ny45MTkxMjNdIFN0YXJ0
aW5nIGNyYXNoZHVtcCBrZXJuZWwuLi4NCj4gWyAgIDY3LjkyNDkwMF0gV2lsbCBjYWxsIG5ldyBr
ZXJuZWwgYXQgZWNjMDAwMDAgZnJvbSBoYXJ0IGlkIDANCj4gWyAgIDY3LjkzMjA0NV0gRkRUIGlt
YWdlIGF0IGZjNWVlMDAwDQo+IFsgICA2Ny45MzU1NjBdIEJ5ZS4uLg0KPiANCj4gRml4ZXM6IDBl
MTA1ZjFkMDAzNyAoInJpc2N2OiB1c2UgaGFydCBpZCBpbnN0ZWFkIG9mIGNwdSBpZCBvbiBtYWNo
aW5lX2tleGVjIikNCj4gUmV2aWV3ZWQtYnk6IEd1byBSZW4gPGd1b3JlbkBrZXJuZWwub3JnPg0K
PiBSZXZpZXdlZC1ieTogSGVpa28gU3R1ZWJuZXIgPGhlaWtvQHNudGVjaC5kZT4NCj4gUmV2aWV3
ZWQtYnk6IEF0aXNoIFBhdHJhIDxhdGlzaHBAcml2b3NpbmMuY29tPg0KPiBTaWduZWQtb2ZmLWJ5
OiBYaWFudGluZyBUaWFuIDx4aWFudGluZy50aWFuQGxpbnV4LmFsaWJhYmEuY29tPg0KPiAtLS0N
Cj4gIGFyY2gvcmlzY3Yva2VybmVsL21hY2hpbmVfa2V4ZWMuYyB8IDIgKy0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2FyY2gvcmlzY3Yva2VybmVsL21hY2hpbmVfa2V4ZWMuYyBiL2FyY2gvcmlzY3Yva2VybmVsL21h
Y2hpbmVfa2V4ZWMuYw0KPiBpbmRleCBkZjhlMjQ1NTkwMzUuLjg2ZDFiNWY5ZGZiNSAxMDA2NDQN
Cj4gLS0tIGEvYXJjaC9yaXNjdi9rZXJuZWwvbWFjaGluZV9rZXhlYy5jDQo+ICsrKyBiL2FyY2gv
cmlzY3Yva2VybmVsL21hY2hpbmVfa2V4ZWMuYw0KPiBAQCAtMTcxLDcgKzE3MSw3IEBAIG1hY2hp
bmVfa2V4ZWMoc3RydWN0IGtpbWFnZSAqaW1hZ2UpDQo+ICAJc3RydWN0IGtpbWFnZV9hcmNoICpp
bnRlcm5hbCA9ICZpbWFnZS0+YXJjaDsNCj4gIAl1bnNpZ25lZCBsb25nIGp1bXBfYWRkciA9ICh1
bnNpZ25lZCBsb25nKSBpbWFnZS0+c3RhcnQ7DQo+ICAJdW5zaWduZWQgbG9uZyBmaXJzdF9pbmRf
ZW50cnkgPSAodW5zaWduZWQgbG9uZykgJmltYWdlLT5oZWFkOw0KPiAtCXVuc2lnbmVkIGxvbmcg
dGhpc19jcHVfaWQgPSBzbXBfcHJvY2Vzc29yX2lkKCk7DQo+ICsJdW5zaWduZWQgbG9uZyB0aGlz
X2NwdV9pZCA9IF9fc21wX3Byb2Nlc3Nvcl9pZCgpOw0KPiAgCXVuc2lnbmVkIGxvbmcgdGhpc19o
YXJ0X2lkID0gY3B1aWRfdG9faGFydGlkX21hcCh0aGlzX2NwdV9pZCk7DQo+ICAJdW5zaWduZWQg
bG9uZyBmZHRfYWRkciA9IGludGVybmFsLT5mZHRfYWRkcjsNCj4gIAl2b2lkICpjb250cm9sX2Nv
ZGVfYnVmZmVyID0gcGFnZV9hZGRyZXNzKGltYWdlLT5jb250cm9sX2NvZGVfcGFnZSk7DQo=
