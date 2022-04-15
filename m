Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5125025DB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 08:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244258AbiDOGuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 02:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350398AbiDOGuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 02:50:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F93B0A60
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 23:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650005254; x=1681541254;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RcXVd5I123Sn99h3u1tdFYe/w5H+lAg05ViR17uZ1rA=;
  b=Ay4U+nnEO1siwJOpQ3llHIakU92BAu5HycKhRaUI/E9U+VgokPG+FiSJ
   9zapPW8ZGSRIuPsyXDsTNlzUkxpQSbQM04GjxGVFYwpzxKv/3ehWq6Zz2
   rVBBPd5WQN5daLwRaUrVs8mAUVJIOawZ07q3seDgFZL3o6upBfnnI/ACS
   prReFFw4d/frxTMQcfxc4HyHlMhpj7NczhDGzNWoSkFcXhp8oS2aMHNDO
   j4h2aAZpqoU4H5JLEaqgZnduR2l7SKiv6KXwnmdRD0xZcMjf6YcP32Hxy
   Hwr/H3M87TFC1r4Ag6vvKZjSTd4xKK0088DlgFUTLM9v8B5pZyqDdf55q
   g==;
X-IronPort-AV: E=Sophos;i="5.90,261,1643698800"; 
   d="scan'208";a="152731196"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Apr 2022 23:47:33 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 14 Apr 2022 23:47:32 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 14 Apr 2022 23:47:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oa7PB54MUumYvPg2fe4t2BdUbduhVXYRAwZxQRFM/jp7pKqy4Kv/NN2Ykf4YNaqkiDWxkTl79Xb9fXq80BgpavQrP/VkF0Er2/mJDtNMQD8Z+/LcwS1SHhIxqzC8GBcS34kvx81La0HnvM3wu1ieVdBZmQ2MNQN2hgCdHVtQ/IQYWDHezVkSvXrW2QE02TQz64W1N41agOQC0eLLoU1aKm2FD4E5oGd/Ll31KXtdY4POOvcjy71JPNmEydzuHl9ivr4TAAXlYVzg+aODDXHqXoK2/67oN/vSaltJMZb9RMWmGHKUYphwJweZ/6SN6IwnJ4XFxjUuBoXwYXjS0eGPKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RcXVd5I123Sn99h3u1tdFYe/w5H+lAg05ViR17uZ1rA=;
 b=kTfyZFFRcfN8fNmK52rR0F7eKQzZBgGpnO74wl3jE+mCfwYuMAEXaLhw6y/BFrWMx5rSyoU6Hk6LdTiWr/rGmK7eth/f0c/q1eHROQBpi5h2pnVd8uyXOcmRnyb3Y4jDdKPhbVcqp2JuRqwXcztS2k1R8PxxqqUkQyJwkVRGrlgsdRGXrqxcnOsGS8Egtw+aYDluNGyTPPKSycmtf86h73bJh1McADYHhpwiB+JWlvSo/r96rVwsMRIXjFKB4JfJdqyunrDhTu8PlRfIU3l+f6lyxeIdKgmnWiFMmio1WpxRsbX31vvc4cUKbo2FgaAQ3vvD6ynbewwq/WnXcZTpJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcXVd5I123Sn99h3u1tdFYe/w5H+lAg05ViR17uZ1rA=;
 b=As6bD6O3631XkO2GMis/DyEScna6ggoey6tuCm2vUNjEAKfmYC0tR2TLp6dadOsWKwAt4+ViHq3VVGk6nxl3KfUXBbowKT1ujm0ZNSj8+F5yrwhPH04NZo2Bkoh096dm+1SZNSmR3PE9gkT1YFRV5Ycgm9zu/EXOrvxs7GgNR3g=
Received: from DM8PR11MB5687.namprd11.prod.outlook.com (2603:10b6:8:22::7) by
 SN6PR11MB3277.namprd11.prod.outlook.com (2603:10b6:805:c4::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.29; Fri, 15 Apr 2022 06:47:26 +0000
Received: from DM8PR11MB5687.namprd11.prod.outlook.com
 ([fe80::e18a:23c1:abed:64a0]) by DM8PR11MB5687.namprd11.prod.outlook.com
 ([fe80::e18a:23c1:abed:64a0%6]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 06:47:26 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <cgel.zte@gmail.com>
CC:     <arnd@arndb.de>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Claudiu.Beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <lv.ruyi@zte.com.cn>,
        <zealci@zte.com.cn>
Subject: Re: [PATCH] misc: atmel-ssc: fix error check return value of
 platform_get_irq()
Thread-Topic: [PATCH] misc: atmel-ssc: fix error check return value of
 platform_get_irq()
Thread-Index: AQHYTxlu8VR/JW9JuEKdM313DUN0tKzwiyIA
Date:   Fri, 15 Apr 2022 06:47:26 +0000
Message-ID: <413afa94-5b9c-02e5-a735-db1b26f06722@microchip.com>
References: <20220413093222.2538066-1-lv.ruyi@zte.com.cn>
In-Reply-To: <20220413093222.2538066-1-lv.ruyi@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8d93701-3b09-475c-371e-08da1eabcdeb
x-ms-traffictypediagnostic: SN6PR11MB3277:EE_
x-microsoft-antispam-prvs: <SN6PR11MB32779D7BD4CE620640CBEE6BE7EE9@SN6PR11MB3277.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zmdenrU7wP8nu9B33k7AiqnD1Twkq3HU47RTV3syllXtPLvtECYk/rC3FpTq0j4rz6OwKobCUR8YkHy48s03VoyebKe62UQEhP8h6z5f8hMnwl89WA4qWr2o9zfKilsS7k4ssRz1B1FoWzEzoMe3T2n3K7Z4IWYtc36EsZJiOPOr1nNrrqgMlMmJj+AkNvTedYbl2zfMQBNKIeJhOjJxXwd3HrQVIXtqTt1debpHCi4Z8QxNxn54TvTbv+dL5Le/4n93IIJQPbzplzsSilGj2XOvY9TN2wmtkqx7kPWVSloY0tx5sI+kCyPSgGzxNlZNLauT5cwBQuH/1LDFcC4Sifl+oBQY52IhTd2G/H8uZv6yJSWa4saq0r8/hnU+TYfucq1R5mSICcXkGMcB3F9zgbF0RVzSXrLiexftYIRM+sTDJF1fbzMa6bdKTdqN+xQkLjOQC0Aflusxa80GdCxzW3562ZXeLt3raZ8QUWni6l8zicuBx/dMcIGpTh7yAYTy9uXQEN2nCIf4FePKBbswZKJ4DGQr+VaW6b/FVtGPCz6MS2oFejyt44SMML/GzXA9vqhBA0j3Ao+5IOkuCSUh1DrSxUG5mELqbK48rqjl2TtvrlsrEaZVAzyRQqKOM8xK+sYnDaW6ndY0wbJQmIx7plKj2QGQzJ1/xRcPr5K9JN0AWGTbVI8fEoGehAPQRGbPU/v9lyiL2V9HhBFtOop4UnkQ98vBj7SjHDM4+RXx5RI9H1C09d5SHFZQ9aaVgguPzWYRoWvdz3UxmKO/MU6CYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5687.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(71200400001)(31696002)(86362001)(31686004)(4744005)(83380400001)(66446008)(4326008)(66946007)(66556008)(76116006)(8676002)(64756008)(91956017)(508600001)(6486002)(54906003)(6916009)(2616005)(186003)(36756003)(38070700005)(316002)(66476007)(6512007)(53546011)(5660300002)(6506007)(2906002)(122000001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2c4TWluSitkY2dDTE1hbFRUYmpPblhMQ2xhZGpYQlN0RitGaGhwRm9HMDM2?=
 =?utf-8?B?bmpQQnh4UTk4MGdYQXBmdVJSSER4U1BzaDIzc2lhSm1SYW1maFhuUkVKdGlw?=
 =?utf-8?B?N0Y4WnZLZmVXalRwdld6R0xxNEtxUE8zajVHZjlSbW1kNy84TS81WWY4Sjlo?=
 =?utf-8?B?R2NXZHRONlN2dHhTQ01KeXVzbEVhK25OTW1zN09QdVJIeEllRXFnMk5JaDYx?=
 =?utf-8?B?MStoZFArRFRBK1pmbHhIRnZhZnljN1UycEFNQkg5THByaTRrdGtrZkIyeERE?=
 =?utf-8?B?d2V6Y1hmYW90RVZKd3JUQXJKQU55bEhiMGxHY3BwaTdOcWU4MzVsWmdnOTJQ?=
 =?utf-8?B?bVg3QlV4WDNiMFBDeEpzL0s4YnlXOC9GNXVVQXZLbXo3MXduNFNkbkZtWTBo?=
 =?utf-8?B?SjFrTHRhaHBEZWhhNlA5TEFzcHdNcCtUTFdSUDNIN3A3dXdMM1NCaHgrQ2Y5?=
 =?utf-8?B?WC8rTTFBblAxRWRhSXNtdjQ3Wm9lM0FHaWI0RjA5bUl0VE05L3hlZW1vaVZE?=
 =?utf-8?B?UG1IN0ExS1kxbVVSOTZUcHVWVGV2ZjZEOFBGZkdJZTZHOFkwWTlGNXU5MTJi?=
 =?utf-8?B?Mm5EcHFGZXZISlcydkpQbHlKSzhoTHFQYU1BSmdJUmVhaFBub3hzVFdKeTl5?=
 =?utf-8?B?M1pZczVnbTBncG1ZMW1sSGpsd3FHVHZrK0VNbHVMb0YvRk1leC9ZWDVZN1Rt?=
 =?utf-8?B?N2d4WGtEdmV5L3VhUjJYam80K1pFbXhjZ1I1ZllscDJCVTB5Z1ZXaWFEb1pa?=
 =?utf-8?B?OWM5T3lsRkkrMFZ1WlNYclE3bnU4UDY2MUJHdmxLWHJLUGFnYk42UkpFYTdS?=
 =?utf-8?B?bUJSMWttaW5ISGV1SFVhNklSZXUvcU1DRFpJc2g0TUJ5Y3pVZUpSZW0vUFlM?=
 =?utf-8?B?dnhaR2xJU2pEL2VkUldMVU5ZWkhCakNFZ2tLS3R2MlVhWDFDNkxkN0h3OFlo?=
 =?utf-8?B?dkhkUTJSUm9VajNJbisza2puZnhrWlV4bGZmTXY1eGRTYVhmSGtjVXdZdTFS?=
 =?utf-8?B?NVJaVEZDOHNUZ0RzM0x2QlNYRHZVc1QrcHA5UEhpekRMTkkzb0xZOFZ4eXVh?=
 =?utf-8?B?U0M5NlhMTVlwQmtZOEl1QVdHVFJMb2FPdXJBN1lUclRVWThMZTdlamtHdzZh?=
 =?utf-8?B?NGRKVVdlYUJLRmU3bzAvZGxmeGczQVg4YzF6YVh3TC9CbjNNSG5EZFhOY0Yz?=
 =?utf-8?B?ZW1yZnErY0owRktZU25LNk40Z3FmcThXcERyeGJ4dzlKVm5GaXFhSFovN1ht?=
 =?utf-8?B?YkdUcjNPbG0vbGdmL2IvTUExeXBCaEI1UmtMWFRab0lmRHc0Y0d6akFVUjFk?=
 =?utf-8?B?U1dMQlFSbGpseUMyMUxRemwzc0g1a0dicllkU1ZPcThnanQzTmw3a2VWbm9k?=
 =?utf-8?B?Y3VKWUlvSmxEUnJveUp5dVFDVmJOZElIREpGWG1OVEZiUitGZWVFNW5udU5K?=
 =?utf-8?B?MW1kejZSSkhtRXhnUVduTUtnN1BmbW95NjZIN2ZjL2ZIZHh6dnR5SWFKK1Jm?=
 =?utf-8?B?RU1QbnkrSE1uOGpmTFdKMmlJOFBmZndTbGVhYzI5MU5LVlJDSmNxZ3orMWFm?=
 =?utf-8?B?bSt4bUU4NFVqd1JyT2pUN09jVlBKQmZsaU9yMzVIeXhOdGV2eEpHT0pKU3h6?=
 =?utf-8?B?SExRMnN4ZmQ0dzVhOXVQdXg4WmtONWxwQXNsdXptSXZ0VndDaXJ2UmdLcDhG?=
 =?utf-8?B?UUVaMFl2Q25VT1BkaS9OL3NIVnZOLzlSL2VBUzJuNm9FTGlIaWlYY1Nydmd5?=
 =?utf-8?B?V3FPbzRwSW1VYXRCUEhaVVdVcEwxbVhTYnN3OTdjZW95K2JaNmN2TEtqb3FK?=
 =?utf-8?B?OWNtZkFDR0hMUEpYakI4TjRKY0RpWGNCdXBaLzgxWWg1Q1gwTm5BMmxscG1M?=
 =?utf-8?B?YlJZQlZQNCt6b2w0UDZza1lYTnRwakZpemo2SWtyZlUwMWlnV0QrWWVmUW5x?=
 =?utf-8?B?YmpPcWc0SHNWNUFlOXpWRzFiL3NQN1VXaFpGVWNWemg1NnBsY2VPbWE2T0Nj?=
 =?utf-8?B?MnpnVDJVQ3Z1TkYxTW9vREk0UWdNblNvQnlaMDZZbzVzcjlhNkkwMXhIVE1q?=
 =?utf-8?B?Z2JER0ptZnNvS3RUd3IzVytUK3FzWWZIVlFZK0NwamR1bHhvdzlHVFBoUUhv?=
 =?utf-8?B?Qmp1Tm9zNzJoL3hjUlZqUitvemRMWVdqdXRTRWpmOGhudjQ0dHFxOVhINUJt?=
 =?utf-8?B?bDdyaVp5Uy9UM1F2TXBIWGxZdHk3UExoMTBYK0lwaGFnNFRsZlhiWEVnSlBk?=
 =?utf-8?B?UGx3Ri9teFA4d0FjcUNVSG5VUVo3bmM2L3ZZN1ZZeVAzQnFLQmNzcVFtMnBU?=
 =?utf-8?B?RjhvVm5XbjZKNGdOQkJvenpNbWxRU0xZc1MxY093OUFIejJCWkNEUlQ3emFJ?=
 =?utf-8?Q?d0sEBR6I3ZLoaw2IIWWMN+KFm6zSJD4agu+8fCa0h+vXO?=
x-ms-exchange-antispam-messagedata-1: vkVImQw+uhbVPUc1Ku23Z4Y2VLVTlzXz908=
Content-Type: text/plain; charset="utf-8"
Content-ID: <06C25FFB2CE3264B894D536081CB3D70@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5687.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d93701-3b09-475c-371e-08da1eabcdeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 06:47:26.8550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4E4m3d7pUIQ0cRMw3mTREfxvJntY/EJ42mZY5gHZzmtrE0L7d6C4+umklnjKQ9idAfsEavXSqR2vIvjlLr1PWTxzHyNL9xpZ8bQD/fNNOq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3277
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTMuMDQuMjAyMiAxMjozMiwgY2dlbC56dGVAZ21haWwuY29tIHdyb3RlOg0KPiBFWFRFUk5B
TCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlv
dSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEZyb206IEx2IFJ1eWkgPGx2LnJ1eWlA
enRlLmNvbS5jbj4NCj4gDQo+IHBsYXRmb3JtX2dldF9pcnEoKSByZXR1cm4gbmVnYXRpdmUgdmFs
dWUgb24gZmFpbHVyZSwgc28gbnVsbCBjaGVjayBvZg0KPiBzc2MtPmlycSBpcyBpbmNvcnJlY3Qu
IEZpeCBpdCBieSBjb21wYXJpbmcgd2hldGhlciBpdCBpcyBsZXNzIHRoYW4gemVyby4NCj4gDQo+
IFJlcG9ydGVkLWJ5OiBaZWFsIFJvYm90IDx6ZWFsY2lAenRlLmNvbS5jbj4NCj4gU2lnbmVkLW9m
Zi1ieTogTHYgUnV5aSA8bHYucnV5aUB6dGUuY29tLmNuPg0KDQpSZXZpZXdlZC1ieTogQ29kcmlu
IENpdWJvdGFyaXUgPGNvZHJpbi5jaXVib3Rhcml1QG1pY3JvY2hpcC5jb20+DQoNClRoYW5rcyEN
Cg==
