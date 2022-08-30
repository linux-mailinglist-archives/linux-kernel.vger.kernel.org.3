Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEC45A6432
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiH3M5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiH3M5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:57:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76459192B1;
        Tue, 30 Aug 2022 05:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661864221; x=1693400221;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=K8myMJoIcDphjvEuLAYXkIaSrYLfQTOpYQG5Sxh7nW8=;
  b=DigX0G+FPOpYh5W17z9FaqEKOwqinNhI+T/NiNHwYqGeTNQxiMyZ3wNr
   1hJ55vk+PsIF7WIJEoj5qzvtz3fD2j98O5gFd1CtwJTZU4IH9oB8CH139
   Hg2OqH9msqtw/RT7Jz1GZ0JKME7nlwQv2zEUqu/wYtpgVEzhnfJpBDH18
   fH98h3Rb9Rw3SwP7gbR5Eunu3WXPdgfFgv3RaaMqeIZngCn1IF7jn2jmx
   IaEhFLekpwSpjMkQcjbxqP97I+VxTaNFxhbn/R2cmqudvecDoJf0E+kwo
   eD2WaQd3WE0KfLKhfKTWCnGTu5jsZ20shigQJHVA96piQajux6Zp1hIPb
   g==;
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="174803477"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2022 05:56:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 30 Aug 2022 05:56:41 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 30 Aug 2022 05:56:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpzfD/BKHDFPYPI9v98xjvjCmhfUX+OIL1355OG+J5Icdspc3iwoI5IxULwJN2uXmKCTtRNPx0rM8IlGDuic69y3nI+rprPnKQTkjEb6va4RObDaN+RCLojvqhKSIQkmLrfil4uVVKBono2NgEm6TjuYsda+5dSMfS6Dau+xBqCjvpJRW9Ja7uxjW4WiRc8iHfKfZI2Fdl6coFPAPGJp+Q8Uk27221HDNWVYw+8W8RPaUYQ8g/d3RKaeqAcTSFTiVGmmz6dTCTs3KyC5z/n76/zNLux2lcrtsispb5HW3ZjiJneo/+iiPBq8puIzyw2YdrYvHW66eeajYC1YAAZmhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8myMJoIcDphjvEuLAYXkIaSrYLfQTOpYQG5Sxh7nW8=;
 b=ciamJFSOenF+zKuIvKj/wNqanR/h1WYQDUnZk126k/lnJgszccoTnCB2yipbQ52xAPNkg4syIAswFk0kQj8JYtGcD/u+VpI9jROavIJZnMj18deKUM3jgl1nyEP6IevPK2ynb8VXVMppWTcsMvqHYx11ln8yuH+0JGnAHFrL9HM/gV45AQiY1dhvuKHy9OGAd8pEcoZy2z2Mvs0x3Ou4rzyGZHGFsjnJX03kJ+wOrQYzKTRZev5U9fU6ACwU3jCS0fSQKm+fjEULrilQVaZ9QFMxLTwjvIiFIsU1inodW8OKK8Q0CfwGX0YDGktw2a9wrC/m840sUVGBJ8sw1cwzLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8myMJoIcDphjvEuLAYXkIaSrYLfQTOpYQG5Sxh7nW8=;
 b=C9a4DdYCzR2fhm7p0o7th1HBQvVvRX2x/ETx7Z7N/NXT8FXnCFUKqnsa5s++3PXxlBwhOPOV27miV0dXaIomZK5OItADc1BrmDwc2V8TCV2FK7lOG4YiczKDtqu70qo+2Aoxce3yd/9Ikz2JLNaoFDbdTvmSCfAkn51lqArCjw4=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BYAPR11MB3669.namprd11.prod.outlook.com (2603:10b6:a03:f7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 12:56:34 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 12:56:34 +0000
From:   <Conor.Dooley@microchip.com>
To:     <ben.dooks@sifive.com>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <greentime.hu@sifive.com>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>
Subject: Re: [RESEND PATCH] dt-bindings: sifive-ccache: fix cache level for l3
 cache
Thread-Topic: [RESEND PATCH] dt-bindings: sifive-ccache: fix cache level for
 l3 cache
Thread-Index: AQHYvG9DsO2L31s8JEW+tF32qWQ5gq3HZuqA
Date:   Tue, 30 Aug 2022 12:56:34 +0000
Message-ID: <b810d354-18f3-9ae0-6310-57d9e36f4f9b@microchip.com>
References: <20220829062202.3287-1-zong.li@sifive.com>
 <20220830125133.1698781-1-ben.dooks@sifive.com>
In-Reply-To: <20220830125133.1698781-1-ben.dooks@sifive.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8878bbe2-88e1-4e57-d201-08da8a871170
x-ms-traffictypediagnostic: BYAPR11MB3669:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /u44FTj8rrkDZQv7IJ+FY5OhUwdTuMrrHgDXUJIdsEi/Oy/9uDxgF0MSgHwL+10ptr9Ezeu/Pro+36Chy36mE4FHgN3bdYVeZ0NgG0KSXLYyicp2FNwQxzVNL/Ckl4yvxqnE9q3mzsYCkD0Q2kmRw4jDTQmjeHDA0genkfTyxrGS8hzB8zGKHuB+mXUs42G2OKLtMo0wgQu7y4MshgXBvmluSIEInI1vffktomMi455rMf7NmZlm31sItrsio8w5dxvk2hsX2jNAp3O6zb7SODA/TAwZ1aF2v8qMA9MxTTqIh2/W+T3ztcura9mACWns0dBBPBMaxAgnraHeMTUOHccTd03rS3ggiZOSggK57lHWig0AJQEXXTDiErrdsLkN7xwzUuc1q4/fcASeytDNll3vXQ0p9LzYWq2H/ScxmIR8dHePwPL/rPEIz4fMv+51T1yNtno5kw3npc2rHXsAfsV6F4vvX2/D+18Oa1MNK4VYD5q3Wo6nvFcUOz+GoNJ8pZqUitgT/Ucgov+KyeIu3oWOYbCfRKWXsH574ck6vvl7H04ZOY7L1FkQMNyr1UsUOKERh7Svi6q3FK72Q42RhKSSK1V/6VXpN5tUMo7CL/7Gr3pndDHgZEwHayfovuD3m7Rn1WZEbCIVPo48NPAAkhxjBWAZ5MkM8T45k4A8uBo2cPRr2JRnl1hqKDZTJW421J+4oJlJXR4eBcG6aiqYhHD+bg/aoLntmkdVCzX1J/5wfrrrsi6XfgvbWdVhZF34K8LndeQiECBF0iIyPEa1WZKIaLWZJS/6QhYE7EAH7KJXP9gdZTz91wS7DTLjcXmhoDxgN6bkrWy0Y38haOiYdZCQhQMfSzopWhsBq9RrsqQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(376002)(39860400002)(396003)(346002)(2906002)(2616005)(186003)(316002)(71200400001)(36756003)(31686004)(26005)(53546011)(6506007)(6512007)(83380400001)(4744005)(66476007)(86362001)(921005)(31696002)(122000001)(38070700005)(76116006)(5660300002)(6486002)(478600001)(7416002)(8936002)(38100700002)(91956017)(110136005)(41300700001)(66556008)(64756008)(66946007)(8676002)(66446008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3Vqc1owK1M4UHB6UkJlWm1uZmpmK3FxWkpDT2Z4WG5sNCtBWGhXT2ZWelJK?=
 =?utf-8?B?M2M1eDh3cUk3Q1kvTXkxRHkwK3RQTW85VEVJbk14b04rQTA2dDZzc2Fma1pU?=
 =?utf-8?B?OHFsK2E5MmMwZVJwcE95eWtuYi9ESVVPY3M5ZXZzMVhLbFJObWpHN21nbHoz?=
 =?utf-8?B?VGVteDFXcGtIOVRPcGFUVm5PSTRBSVBUd2Q4VDdYZmpLVVJCT0FoV3VpVjB3?=
 =?utf-8?B?UmFSWEhWaDc3QzFmbm9FRTZzZDkrUlN0T0JYT2NnL3kwZG9uaGd2amkwVzFk?=
 =?utf-8?B?WE1QS3BoVUVqYkFhYmtLbHRiU3AySnI3TkhweXo1elNicGRUZjZPUjBieFk3?=
 =?utf-8?B?bEtkcE9jRldLNTB5Z1E4YUNraWp0dnpPZ1VLWDFnWm5IVFA3Wm5KamhzY0RU?=
 =?utf-8?B?WmExV3FJTmZXUTBWS2licWtuV0dRamljeTFtQXdoQTViTjFWa2tsQWFjbXFO?=
 =?utf-8?B?Z2ZNV0s5R1FsSmxxUytub3JmYWJrVGdUTGxETWo5emo1VUNBbkxxdjl2V2p6?=
 =?utf-8?B?enl1aXJHdXRsYnRWTWsydUNNMHBIcXNUeHVOYmM1aFZidnBObWdsYUZ4YnE2?=
 =?utf-8?B?T0E2enB2dFQycnIwSHlLUlNDU0g0NnNnMVpVSVpvaVZrajR2Und3V0hKY3ls?=
 =?utf-8?B?MjVmZ05CS1YycWFwRndlMTljV3libUdPc0xlQjFiZ1lZY2ExNEkzZlROV3RQ?=
 =?utf-8?B?NUhYNXU4bEhtOWhsYituYTZsUVhYcmJhQzQ0Z0tiRk52MEZyaEwxaEFGMFdC?=
 =?utf-8?B?a1hiWGVmWUVrQk9DOGVUQzlsM2Q0UzcxdWVYSHk4NkJUL254TEdYNzAyYVJ2?=
 =?utf-8?B?ekxpZ3gweGJOWEdnNExHdm5kTVpJN0FmclQ4TFUycmd0OVNpV3YwUmI2QXRn?=
 =?utf-8?B?czhCek03L0JTckRtTWpZYkVzQ1dnYy9aVDhEZWZmRHo0R0hnUjVJaXQwM3Zz?=
 =?utf-8?B?R0c4QnBvZ1krRklJNjl1VnY3bTA1Z2xYNWJlWmFId09KeEFITStlQWswQTB1?=
 =?utf-8?B?c3RLc2g4YnF6VVF1MnU3U3F6Ukc2L0RndzVLeGtFRCtYSHVQMEJlcEF0aDhX?=
 =?utf-8?B?UjBVOVlkaUpZYVMxUUNIYzlQOGZSM3Rzc0tqa0xhaFdiWWtjUFk4UmU4d1Ji?=
 =?utf-8?B?WjFpR3VCZVc0cnRGUnVXdUlkRW1zWGpYckRwd1pRVVZBK2lSU0JxQmpQd24y?=
 =?utf-8?B?ZjYzUjVPendzWVhXUytrMlhDb003MUFQeHZkRDgrd29JQzhBOElyR29OS3E4?=
 =?utf-8?B?ZDdoWDJ4VlcvWE5VbW1FZDRPTCtKeGd6UGdvMTUzd3N2aEhnTWFXWEx1RGd3?=
 =?utf-8?B?WEd6Z0kxQXptcXVKbitYck03YmFoSUZaRGtmaytrWm9HQlNVdEJBUENFNzY5?=
 =?utf-8?B?U21nZzBGT1FvVDN3Kyt2cXBYL0pMQTlEbG56a0xqMHNXMFdXZlVsbVptZUhq?=
 =?utf-8?B?b1g1Z3dhOXRMMXM4ZW9weFp0V05WOUpYejRkb2JFTWEzby94MUtQTUtBWlFZ?=
 =?utf-8?B?dVlxTVY2RHVtR3NWTXlWUlBRcXZSWlE1Uzk0Unp0QktudmZ6Umt1SDQ5Q05V?=
 =?utf-8?B?M0VrZ3dzNTZXUlJMZ0UzRlpudE81Rm9VaWphNFJVWkU2WHlkdTFEci95TEpJ?=
 =?utf-8?B?dnhPME9KeUdKUGRhNS9tUnF4Y0l2YlJHczBkOGZUak8xVHpqbzJPTGlHWHdx?=
 =?utf-8?B?ZDlGY3RwTXhYZlAxelRHRDhzd0xrdEJxMHlHR01MS0tiNXprVVIzQmJERVY4?=
 =?utf-8?B?YzMvNjNHYTZTbXZKUDFKemtCdTQvL2doSi90aUZhWm50eHVIbVNRendOUTZ5?=
 =?utf-8?B?TGVQZ1UzTG9QMThxK3phYUt4N1hNNmhxQlFyVnVEYkFVcUZoU2p5aGJDY3Bh?=
 =?utf-8?B?YTIyMURCU3h3MDNvdSt3Rk80dm9FMHpBRXh3SWxJT29OdWRMZGR3dnIvZTJh?=
 =?utf-8?B?cXBqSlNwUHAxdDErakdGN3BtR1BqdHNaM3E5ZDRVTDM0cnJMOTcvTlRLakpY?=
 =?utf-8?B?dllvdEZTV3h2aVVIYklLNFpJUXN2cjZFT29HY1kvUFAyQkRiQldnSTJ3Qklm?=
 =?utf-8?B?b0w5cStRbkROVHQxMzdvMmVUdUV1RFRkdEdnSDFuL2MxOE0zcldibzd0bG92?=
 =?utf-8?Q?mTTqu9daMPyUcopIPuxtGSdv9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D58B960C92BA7440861CDF99D463503F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8878bbe2-88e1-4e57-d201-08da8a871170
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 12:56:34.3545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1WqZWkji30XQl8rxTyuXOMClfhJd+6tyiaBgClJEa9/SrmV3PBoNNd9d/sHTMevedm3LFgWSd97FNYYYH8cp84CvBTfZCEMPyQOxE1Zdu+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3669
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAvMDgvMjAyMiAxMzo1MSwgQmVuIERvb2tzIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDog
RG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFdpdGggbmV3ZXIgY29yZXMgc3VjaCBhcyB0aGUgcDU1
MCwgdGhlIFNpRml2ZSBjb21wb3NhYmxlIGNhY2hlIGNhbiBiZQ0KPiBhIGxldmVsIDMgY2FjaGUu
IFVwZGF0ZSB0aGUgY2FjaGUgbGV2ZWwgdG8gYmUgb25lIG9mIDIgb3IgMy4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEJlbiBEb29rcyA8YmVuLmRvb2tzQHNpZml2ZS5jb20+DQo+IC0tLQ0KPiAgIERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yaXNjdi9zaWZpdmUtY2NhY2hlLnlhbWwg
fCAyICstDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jp
c2N2L3NpZml2ZS1jY2FjaGUueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9yaXNjdi9zaWZpdmUtY2NhY2hlLnlhbWwNCj4gaW5kZXggMWE2NGE1Mzg0ZTM2Li42MTkwZGVi
NjU0NTUgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9y
aXNjdi9zaWZpdmUtY2NhY2hlLnlhbWwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3Jpc2N2L3NpZml2ZS1jY2FjaGUueWFtbA0KPiBAQCAtNDUsNyArNDUsNyBAQCBw
cm9wZXJ0aWVzOg0KPiAgICAgICBjb25zdDogNjQNCj4gDQo+ICAgICBjYWNoZS1sZXZlbDoNCj4g
LSAgICBjb25zdDogMg0KPiArICAgIGVudW06IFsyLCAzXQ0KDQpEbyB3ZSB3YW50IHRvIGVuZm9y
Y2UgdGhlIGNhY2hlIGxldmVsIGxpa2Ugd2UgY3VycmVudGx5IGRvIGZvcg0KaW50ZXJydXB0cyBh
bmQgY2FjaGUtc2V0cz8NCg0KDQo=
