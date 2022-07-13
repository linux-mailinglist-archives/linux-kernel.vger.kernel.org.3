Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049C7573F51
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 00:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbiGMWCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 18:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236695AbiGMWCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 18:02:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6416E31218;
        Wed, 13 Jul 2022 15:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657749742; x=1689285742;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gGvJNd5q1RgNBOGjBEIWuNiOgQWHlE5yi0J/lVCRD5s=;
  b=0CPeyWv+ljsgkrVC6p1j4efsipCfJAFt6XfqLFPYaI8SLXk1oFPGXrwY
   ZXSNH99Wv3+zoVTY3+7iGxBf8ipmkdlI2uj8zDAsRSot1fUPa5a78FjPn
   lhrzVBpiBBQkxeDhB/1LYRzKLTqTp8gepckhUP59HPB8erbfYKzNaC0FJ
   z4APEdcffCygopIk17llYi86IO0sZ+Ugz1I+kxQpOaU8kUBLGvLPyTYYI
   Gngj7UYYIla64sZzdnWFcNQffW8WrZ+ZP/vBz1k9ijoJytwPT8mNQROoM
   Q4Hyb+v3cs/rGg4reIsSGb+miP1Absrlfr4z0A9Oa5EBlC30Y3DOpxgWE
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="164635994"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jul 2022 15:02:17 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 13 Jul 2022 15:02:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 13 Jul 2022 15:02:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZV+5ReFC81532hBG98r/pNlRw+seqYSi7sVQR75CDPSYW6iIuJmiUBFbkaJdhAoSlY5T6vIuFXaNKoGv4FZRAaYOco5aKFtAydgUQsVdWxqJnXus6b55R5QH0NwMrXzJmWI5RRcnqwr1jAhSPHNx/VrqjVc2pYTUiresDuDCWGg56S9XuOhrre/5uTWHJBNKZQs9pOHIiFkGrTFMzuSlk2kt8gQupm+vmgWAyscNAx2VQbd2a5I33VoNnoMHA3ScBnlrndbesgbZsCAb5U++ag5RpJO0yUfBu5iwgfrsdCgy8mI6FJ6BZ0Sk8RwCImZADxpMO7db00XJCYWVFiPraQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGvJNd5q1RgNBOGjBEIWuNiOgQWHlE5yi0J/lVCRD5s=;
 b=KIgw2qRjQ284qu+J8ohqQGBDe3PCJcdDUdd/ThXRpWbZJU8hFGWCXW9Nh7tsUUMmRs7jAtwz6RaRXfW1Ykh91PahG2KQUM8ro5vYCqX1wLffU2BPh8z8NZeSsMoYuywsTcYrToCsw1YvR0JJkm4sEDJfYl9EnCgpxahpRBiVSwYT6zoPx0dYyHia1PG5Xe7rOKHUHvoNAuHHsIi8dvjmM0E4OXpVB5xoB2XNW/qllv8gMCzHs/6HyxuWEQ4AzYt4j40/u18sHZzyRzRtVpahDH3cfZOfVOPOHf7aywG1JYkCR3YM3p0UUXZuZD4NIO3FzG58Qxh9iDCdCqfdu3pZ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGvJNd5q1RgNBOGjBEIWuNiOgQWHlE5yi0J/lVCRD5s=;
 b=d3tEeeR3H/dr/t47aasGfs0LMZpfaqtUgGKxmLoKFueovJm0K8FP9fScg4Ph7nqbfa7Sg0L7j5Oh/XcznnuXHgNUyepaprKX47WU5kFkrUynLzTFItiTzs22IkY0uXOCeDEjPwYG2qFjJh32EVbq/3jv8PD/mo8gIXUmKv34oXg=
Received: from BN7PR11MB2657.namprd11.prod.outlook.com (2603:10b6:406:b1::19)
 by BN6PR11MB4146.namprd11.prod.outlook.com (2603:10b6:405:7e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 13 Jul
 2022 22:02:13 +0000
Received: from BN7PR11MB2657.namprd11.prod.outlook.com
 ([fe80::f144:ccd5:302c:6903]) by BN7PR11MB2657.namprd11.prod.outlook.com
 ([fe80::f144:ccd5:302c:6903%6]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 22:02:13 +0000
From:   <Ryan.Wanner@microchip.com>
To:     <robh@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <broonie@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <lgirdwood@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] ASoC: dt-bindings: atmel-i2s: Convert to json-schema
Thread-Topic: [PATCH] ASoC: dt-bindings: atmel-i2s: Convert to json-schema
Thread-Index: AQHYlwQ86QK2ngefTEqOuKnsHM9owg==
Date:   Wed, 13 Jul 2022 22:02:13 +0000
Message-ID: <9f94f0cb-a8d4-e5dd-0e98-e8773c04ce20@microchip.com>
References: <20220713162538.139115-1-Ryan.Wanner@microchip.com>
 <1657739327.994394.246143.nullmailer@robh.at.kernel.org>
In-Reply-To: <1657739327.994394.246143.nullmailer@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f857896-31df-44a6-2c67-08da651b57aa
x-ms-traffictypediagnostic: BN6PR11MB4146:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t4FB86E5+wjwaigMYopsciAu2QapsM24Ce9VtgK4l6T4te/Rk5agHXeIfQCtevDZPwlQV9nXxSizcjc05X3RRNIZbXAlQJMguc5TF7jmKG2ocwpwMi4OOARwGPSibqZnACUc8IDseM6v94f8oZwyLEPTYyWragdI3iLsVAheJB54qlp2HUxSEEr8bI0pdOS3xiwcpGPbiB5g4MK/Sp9Vi9T4jwSHu6uLKIZrQQOitP/B5xvcSjEIWtrutRyM3SZpBo4x3WrdcorebGWqAwgcalXOnD5WGmmddSD9LJuEF/pjpnHh9b1ojAat2jLF6L7jMFaTGa+74ZZ3xwxko/VxpeZS47PJfCCqHRd/RE06gU0REFo3X14KCIkrqY3dhh61q8nG5HvemgaEVHcfl+Fq5YbHYO5P78TwjnSc7VDavriojy9ziR2+KPYivbK5Yu3UJINStJKvBDw+UtlOPuHRbkS2ljtHDk236FdSh2uQb+1mUWU0iSuqH4I/pnjO8mz8r4Cq2Dgc0yjonzCnvBZ8ULLj0RktCx27z5dVq04k89ibdZEWxxF1CLZxZM0x4Yo6C2S5n4nLdBUtoX8EjXn9jaT1QyC6SoS/sph3e2nJQZ5nONCv0yQr6sBV+Q3tvGVPiXVi78UbzPS4ej48qL6dYpplxhcTMdVQrKQsZsmzx/jC/dJ562ryonZWiHBI4/7bsNXBDgpgUa6L6YuHWRVrO+yXgErgyKmdAEJLUwNAXMpF3/2151L+x2OE8ZyQTWGBQZKHQbn4jUGF0EIA8gGHRDtFpeqsdNtKQAfByNo+CysZd+EZJt022shnViTijF3dNh0DIaX/uLbkTGNmQOB+SK7cVrh6Y4vHCtRQSf7KtcXviybg7kUU+qaeWxCKuVG5kC5vk5v2KbeKqe7rFM0AkBK09MsebuzZtpnCiTb2iq0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(396003)(39860400002)(366004)(346002)(83380400001)(2616005)(122000001)(86362001)(31696002)(38070700005)(8936002)(5660300002)(478600001)(38100700002)(7416002)(2906002)(41300700001)(966005)(6916009)(54906003)(71200400001)(316002)(6486002)(64756008)(66446008)(8676002)(91956017)(31686004)(76116006)(66556008)(4326008)(186003)(66946007)(53546011)(6512007)(66476007)(26005)(36756003)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXJWVFFDWTNraUwvQ0hRQ2NQRTg4ZVFHYUxkWFhhUXE2UHF6Y3p6UGVVbkZv?=
 =?utf-8?B?RGZLSUw3ZUFGZ2VPQkt1TXlhMHpSSzd6eTNoVGVNN0xqcjVKUWM1dHpQYm83?=
 =?utf-8?B?ZklHRE1PNzE1RDFSWkVtaDBRbVNReVNvOEVDY1BudGtxV1ZJSWZhYXh5WkpK?=
 =?utf-8?B?N0o1cklEK09CZ25IU0kvVVhDeXJWZ2V2Wkw2NUdnaDJFYzRjbEQ3am1UYUpZ?=
 =?utf-8?B?SkpJUlFyVG55VlV0SmtvWUhGTytjaVVFcjBLbVR6TlU4WXZlWExRYTJsMzNB?=
 =?utf-8?B?ajZpR3hLa053djFmcjYwTjdoTXlXQTVtRXdzNklHQVg0ckNZNE44UFlmdDBr?=
 =?utf-8?B?Q3dFRWpOcFdUV2NUWW9DQjVKMHZzWnpuaXZ0R1UvRHRFM1VUYUMycmcwLzRk?=
 =?utf-8?B?NytydTJsSUNFUUNLVTZNWTA5aUtHYzVNY1NDMzNqb1NUMys0Vk1RVHVmWHNW?=
 =?utf-8?B?eW1UcWVrckFCL3ZRa28zRDdUbkE4Q09hNklxeEplRVhULzB1ano2VXdqTjJR?=
 =?utf-8?B?dUg0MXFWNWVhZ1JIams3dTRDUWczNVdWOXJ4ckV1VTB6MlU2RE15M2poTEIz?=
 =?utf-8?B?YmpnYkRCOE94cUpud3NnQnVyeXlBTnhxcUx2b01aWWpZN2dlSDlFZmN3UHJ4?=
 =?utf-8?B?T2hxQzQvYkJwTE5OUytuRlpHRUdldjR1ZDVESDNPSWZwU2JVSUF5Ny92RGZL?=
 =?utf-8?B?ZkdRcWtrcjlnVHRrWDZOQmVMbjV2bmJSdXhRbnZhTW5DSFFMZXZ1VWJSMmNp?=
 =?utf-8?B?ZUh0aGpkVkhtWTVmSTYvUjBOQ1hid0Q1Vi8yekZvdDVISEV4aGI0QzNkUjkv?=
 =?utf-8?B?WEdLU25Oa1FIK3ZUWnhXNnZ4UFRWK3lmSTc5ZitPaENYU0xqTXFINGJqbURt?=
 =?utf-8?B?YkNlU2JkOFBvSjJaZUZsYzRyck43bjVuaDB3T1p2QTNMeGYyZ1h1M0FFa0ZS?=
 =?utf-8?B?Sm9DMzlTNGI4MVh4NHUzSVRzZFc2TUNCTzNocUM2WXJiRUVRaEE3U2dHZVRI?=
 =?utf-8?B?RytaQU45ZFBheS9sWEVwaGdaMTZ4TTFiK3NZR0dtYzc0OTcreGxTZjJaSzJu?=
 =?utf-8?B?YmM5VHJMV0QvUGhqV0k0VlpPdm1aR09LOThpWCtSS0VlbnBrRExBbDZWL3Ir?=
 =?utf-8?B?SnpCZUwzTTZoMkJzalpseXllZUQ1SUU1NkpydGdBOExaY3U3bjZSalVxblla?=
 =?utf-8?B?cUxoMnVKby91dlRzZzR2cVF5MEJDSnc5RWc2Qnk5U2c4d3RPb2pSdi9uNGZu?=
 =?utf-8?B?WnFlSVE0ZXNFK0VxdUJ3MDZOQmJGcFZPeHkwRllCb3NMZXlPTW8yeG5ISEl1?=
 =?utf-8?B?WVhiUUlySTEwVHZDZFVvNkErVG4rVk16TlhCZXo3b3RGMXhkMEpDeC8renlO?=
 =?utf-8?B?VkNSYkdTS29jYmpESlFJY3czc08xajlNQlFsTVl5QTAwRnJRNzhvTzJ4SGFy?=
 =?utf-8?B?OHAxUUVsZUkxSFJNaDNDYkhORW5NWDAyb09TVHdvVTBOb0xxZGZlWkRrcThi?=
 =?utf-8?B?NkRBWUdvbTlPU0xQeE9leFJFTUJWemlhY1ZaWTR4NUpFWkZxd1Jma3ZyNEQy?=
 =?utf-8?B?UWpCVE8yK0dVNHAwb0ppOG1qM3VuT08zSUtDZ2IzU1BMQUwxL1pLUXd3YTNH?=
 =?utf-8?B?aVdQU1l2dWZOSUZVZUhTRTY3OTcwNG5TdXRzaERoR0E2WmtlWk5pTWpFTEI5?=
 =?utf-8?B?RTIyZEVzL1c3QW5BbDd0UDFxTkVkK0pwN09qb1BGTFpoWlk1aFM2MXptTmdt?=
 =?utf-8?B?bnNWZEFrL295aUtZN2tHUTdPSVdZdHRBbHVDZXRMckU1Q1VjR2FmQWNJRlR4?=
 =?utf-8?B?NTdDTFcycm9yaHB0ZXdwNitqU1dGekxPT1lvbTNZOHBvRTdjMk95c3libHMw?=
 =?utf-8?B?ZEZ1Yy93Wm54cGFJQi8xS3ZFZEp6b3FLQUk1UmRDT05idGUzWlp3OFVlMklw?=
 =?utf-8?B?bGp1V1RNQURpQm5jY2Z5ckFSK2lPdUhTaE1sSG1aN1NkaXZIUW9lU2RQWXRT?=
 =?utf-8?B?Q05VK3o4NGJhdENFODJlL2dUa1E3bE8yWjNtTzl5MlV5VzNJVnFWdTlIZE1i?=
 =?utf-8?B?SnEranFvL1NDR0hGT1c1V1I4YkNvU3ozMCtpbXNLTmVhbGMvQ09NSDJaQnQv?=
 =?utf-8?Q?7ya2UlvA8R5TgumM0JUNBRENH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F2485E6FB4BD6449416CBDF881A35BC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f857896-31df-44a6-2c67-08da651b57aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 22:02:13.5326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q5C4jvkZ/9JShrMIn+zRw/8uEPBCO6VcP4pu0ItCPXUs/jTZAtFOr2WqbQKYMEELHBJjcIAR4eIpVj04LdbLgAXrRzsfdlFo3N4AcM2R7Ys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4146
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8xMy8yMiAxMjowOCwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gV2VkLCAxMyBKdWwgMjAyMiAwOToyNTozOCAtMDcw
MCwgUnlhbi5XYW5uZXJAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IEZyb206IFJ5YW4gV2FubmVy
IDxSeWFuLldhbm5lckBtaWNyb2NoaXAuY29tPg0KPj4NCj4+IENvbnZlcnQgYXRtZWwgaTJzIGRl
dmljZXRyZWUgYmluZGluZyB0byBqc29uLXNjaGVtYS4NCj4+IENoYW5nZSBmaWxlIG5hbWUgdG8g
bWF0Y2gganNvbi1zY2hlbWEgbmFtaW5nLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFJ5YW4gV2Fu
bmVyIDxSeWFuLldhbm5lckBtaWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+PiAgLi4uL2JpbmRpbmdz
L3NvdW5kL2F0bWVsLHNhbWE1ZDItaTJzLnlhbWwgICAgIHwgODMgKysrKysrKysrKysrKysrKysr
Kw0KPj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL2F0bWVsLWkycy50eHQgICB8IDQ2
IC0tLS0tLS0tLS0NCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDgzIGluc2VydGlvbnMoKyksIDQ2IGRl
bGV0aW9ucygtKQ0KPj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3Mvc291bmQvYXRtZWwsc2FtYTVkMi1pMnMueWFtbA0KPj4gIGRlbGV0ZSBtb2Rl
IDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvYXRtZWwtaTJz
LnR4dA0KPj4NCj4gDQo+IFJ1bm5pbmcgJ21ha2UgZHRic19jaGVjaycgd2l0aCB0aGUgc2NoZW1h
IGluIHRoaXMgcGF0Y2ggZ2l2ZXMgdGhlDQo+IGZvbGxvd2luZyB3YXJuaW5ncy4gQ29uc2lkZXIg
aWYgdGhleSBhcmUgZXhwZWN0ZWQgb3IgdGhlIHNjaGVtYSBpcw0KPiBpbmNvcnJlY3QuIFRoZXNl
IG1heSBub3QgYmUgbmV3IHdhcm5pbmdzLg0KPiANCj4gTm90ZSB0aGF0IGl0IGlzIG5vdCB5ZXQg
YSByZXF1aXJlbWVudCB0byBoYXZlIDAgd2FybmluZ3MgZm9yIGR0YnNfY2hlY2suDQo+IFRoaXMg
d2lsbCBjaGFuZ2UgaW4gdGhlIGZ1dHVyZS4NCj4gDQo+IEZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBo
ZXJlOiBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3BhdGNoLw0KPiANCj4gDQpUaGUgd2Fy
bmluZyBpcyBmaXhlZCB3aXRoIHRoaXMgcGF0Y2g6IA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGludXgtYXJtLWtlcm5lbC8yMDIyMDcwNzIxNTgxMi4xOTMwMDgtMS1SeWFuLldhbm5lckBtaWNy
b2NoaXAuY29tLyANCkkgZGlkIG5vdCB0aGluayB0aGlzIHN0cmljdGx5IGRlcGVuZGVkIG9uIHRo
aXMgcGF0Y2ggYmVjYXVzZSBpdCBkb2VzIG5vdCANCmNoYW5nZSB0aGluZ3Mgb24gdGhpcyBmaWxl
Lg0KDQo+IGkyc0BmYzA0YzAwMDogJ2Fzc2lnbmVkLXBhcnJlbnRzJyBkb2VzIG5vdCBtYXRjaCBh
bnkgb2YgdGhlIHJlZ2V4ZXM6ICdwaW5jdHJsLVswLTldKycNCj4gICAgICAgICBhcmNoL2FybS9i
b290L2R0cy9hdDkxLWtpemJveDMtaHMuZHRiDQo+ICAgICAgICAgYXJjaC9hcm0vYm9vdC9kdHMv
YXQ5MS1zYW1hNWQyN19zb20xX2VrLmR0Yg0KPiAgICAgICAgIGFyY2gvYXJtL2Jvb3QvZHRzL2F0
OTEtc2FtYTVkMjdfd2xzb20xX2VrLmR0Yg0KPiAgICAgICAgIGFyY2gvYXJtL2Jvb3QvZHRzL2F0
OTEtc2FtYTVkMl9pY3AuZHRiDQo+ICAgICAgICAgYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW1h
NWQyX3B0Y19lay5kdGINCj4gICAgICAgICBhcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbWE1ZDJf
eHBsYWluZWQuZHRiDQo+IA0KDQo=
