Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CFF51F4A8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 08:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235547AbiEIGk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 02:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbiEIGcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:32:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480C718543F;
        Sun,  8 May 2022 23:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652077707; x=1683613707;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IiHjHuLHuUlt2Kt199MK66Hdquv2YlKIfu3aK+D9TCA=;
  b=l7Z7jXjGFLlyYWa+3zrY4/4wMhqnmrdycchJARpXUo7evE8IWm6GZ3dp
   lOTziCJBREI1wC4sBg2TUAJy+bVND1tTYSG8A0oUv2E1afebgS7nDrZh3
   de1lcND59AlW1m4j/Fr+PUyowph9rD56ildIsh0vJMAGLgt3bjRVzL1Tx
   EvoA2UdgKqG07LGJoETVvZid1k0A5xN4bDRTg5hSmFllpAkbNUvgot0au
   ifvMjQv4MlJ9yttVQ8BOxEpeKcyxVDlEBy7NB4h68ZKC1hUG8DuiejAqC
   ooGNoAnvKjFxR/mfLq7VB8jl84yFGMECCuTNbKd2MuE5MGRVvshkfe77N
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="94979956"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 May 2022 23:27:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 8 May 2022 23:27:22 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Sun, 8 May 2022 23:27:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jt2pfBYXEtaRN8dM/j4IoCjtMlJGgeDP/3F8DkR8KGQHG5nMhFzMUX1hWiNh9NLwcQovmUlAmTopukNUzred6nrF2T+YPM0y/J5ix8uF+3ydnNnV1lxP1Bx94yUpUU3u1wtL0fcemp2nHQDTYo2rIy3kJ2sSEalxs15/kE+2f1oJyU55QAW52IjSYjMLgq1EuanHb/suzgIaz8Bf6akeZLHfbILpGtNyMZV08cTrvbvGutHoEd44xkkJw6EGvzNf6mYP7hmIWPH9qhw9Y8gGTkOf4rL2nWjibceF+XpsTXbURgSvRXD07p/rCEZd7hhxURfc3hNiHVRc9VkOKYjQwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IiHjHuLHuUlt2Kt199MK66Hdquv2YlKIfu3aK+D9TCA=;
 b=MFwU99kdNZRdCWP39C+2mSqQr/iHSRRB1V6n0gow3NWJ+ye/CzzDnvLZehl1y9Gi/WZplJVwpJkX6Q+DOIeLi4muDXKCp7znsXpaSjvMsrWO7eDlTtEGl2afR2pVcnD6c21fLNy8LFU3ZdScdtrGvzKMT/QVfxtNTTPbqKIeHtnTkJrI7U8Ti08/063CrBdlNg19G+SG+gZdFoIouyVtRXRjsoeF0dHeFyQJhivmkgcnwdqBO8WscaKMNnFyQge9o/gbJeN3gs/8nIsnvTiTD02MGYvUN4+wURTlJS78IW6mp2eMxfuzGDYzdosmUHoqwR4Df1xDZmmfKdwfwQRN6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiHjHuLHuUlt2Kt199MK66Hdquv2YlKIfu3aK+D9TCA=;
 b=GRqUXk0xmyuyEChWF5/tSxTDSxxPEaB1OcUa63RyLQq8Rdqx3Z2WrZHr8B7h5+hEWKXW1uzY13QI4hHzTaDTBcwBBJmsfiWzF9L0inQ24e+UyySeQKcpkrBhdppcV33sivGvsqnjq1jOqjpe5UEufpcq7A7O76kUe6IBmH8xkvs=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:95::10)
 by BL0PR11MB3299.namprd11.prod.outlook.com (2603:10b6:208:6f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Mon, 9 May
 2022 06:27:17 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::e906:3e8d:4741:c0f0]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::e906:3e8d:4741:c0f0%6]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 06:27:17 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <michael@walle.cc>, <Kavyasree.Kotagiri@microchip.com>,
        <Nicolas.Ferre@microchip.com>
CC:     <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <alexandre.belloni@bootlin.com>, <Tudor.Ambarus@microchip.com>,
        <Horatiu.Vultur@microchip.com>
Subject: Re: [PATCH v4 13/13] ARM: dts: kswitch-d10: enable networking
Thread-Topic: [PATCH v4 13/13] ARM: dts: kswitch-d10: enable networking
Thread-Index: AQHYY23UXiRy75AIoka0/qUnKZt4Zw==
Date:   Mon, 9 May 2022 06:27:17 +0000
Message-ID: <b8343fc3-3ea6-12e2-576f-2c5a39897a1d@microchip.com>
References: <20220502224127.2604333-1-michael@walle.cc>
 <20220502224127.2604333-14-michael@walle.cc>
In-Reply-To: <20220502224127.2604333-14-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b28fe540-4bae-4a58-5319-08da3184f6de
x-ms-traffictypediagnostic: BL0PR11MB3299:EE_
x-microsoft-antispam-prvs: <BL0PR11MB32993048ED454E3E8D7E610187C69@BL0PR11MB3299.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wddFUBqLzD0CIadmpTprwzZsuLkLZbqFB0dDOsFMJvC6Nsv8Q9BTfS/4Fc/w1h+pGPGGOz+/JMMgIWnAEogYhttwAYnidetqdS/5ymXb4fxw0f3TCoNB0NoJDiMWGDPwUotxAWpBsUQe6J2zwjgtWkgyuYPG/0KExsF+hDBSSqD5GM9rUe2jF6hDRe+9wpPg9C2i5SpD8rMuZwEj8st348dUnQbuHkqMdVtF66qk3pReYhJg8NffgmuV9136F0TYH4dXbjhEPGJmIanITqHA6A6hgjDo09ST5MGPPol6IiR9EfgjkKUfs2TROUVb/iS5J6NG4zLh2yd0ppG6RJsVXVmWlvDGEH+huOSyKfabYKa8aVWv2i3xqtnVkfktLtwsweRRgPDYa0F6T4cemnFriSm9q8Ie3sVqa1+tlIPQLmqKuWYGTxoObUISKEpqm6/A+rUYDiz0N9bPIpMryyAOC4BzRFsv9G8en7j57mdGzC1jT0XzyUxifXp+kZ0P5sHksBJNjr7NKm8xMLTmVYd4PqV/DwVehvMZNS6ZPvDyWFrjMJmcQT90s2K9Q6vJprM1CUPfOQjGD8UuykZE2AVT44kqf0SS39ZXi/GCtUZS9TZUb9J5ujpaLRUglzf/Zg8ASuRwgAPb6IUpSBUk9QBFr38zQcJ7J0DacIsTdpU5iL/Y1HKlUWzUTEnspcI9czjIq3BwJFj742j6r8BWRLEfywHS4MpetftpU5ZYX31sO6zZD3sV3zZIvV5Gl/Vg7cwnrqeyMwH4NmVkspzFAxQYjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(6512007)(2906002)(76116006)(91956017)(4326008)(64756008)(66446008)(36756003)(8676002)(8936002)(71200400001)(86362001)(5660300002)(66556008)(66476007)(53546011)(26005)(2616005)(31686004)(31696002)(66946007)(107886003)(6486002)(508600001)(38100700002)(38070700005)(54906003)(122000001)(110136005)(186003)(316002)(6636002)(83380400001)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkdGTFZBRHk4WkZjVFRoTnFsQ3FuRXA5em9PQ2RaWnh5Mng0NlYwMUNpR2ly?=
 =?utf-8?B?dGozbWgzM3dvbTRBcTRaMFptdnNCeE5kVzdmTS9FNVN5dzR0RGJGNjh1SHFS?=
 =?utf-8?B?U1dnbVhjamVZU1dUZmgvUkNEMEVoSXRObzdlZ3BSeUF6Y2RMVXFGWnlISFpn?=
 =?utf-8?B?S0s1dDZDeVZqcHh4empIUUdueUdQdEhJT2VLMmVid0hlOVJKV1NaS2lybHlX?=
 =?utf-8?B?WkdlWC9vOHJraUxLVkhWeXJPMWhiWk8xWWZacng0SlFmV3RDbllRanhBOTJP?=
 =?utf-8?B?RDR1RVpxY05hSXBhb2lKNDQ2Y3VmMHMrL2xHR3pWN2l1UVorc2JVTzdvRGNO?=
 =?utf-8?B?ZzJTTVF5bE1ueGlvMTU4eHlId2VSaWtJb01nbGpreEhweHdiRm1PSjhINnlS?=
 =?utf-8?B?RVI2YzJWMm1pMEszNUxLbzQ5amdmc0hlZ1pjd0cva1cwZ3MxSGxKRENpeGNw?=
 =?utf-8?B?dFhOMDBlVCtIL0RwVnVNR2UwL1F1R1lSRC93a2xkbHhrT0xlbVh6S3JNQ2xN?=
 =?utf-8?B?RlZIWUcrOVM0SW1tQVh0Y25VK3BFbE9BUk40RkxZMVRQR1J6N0JwaVVUM0hr?=
 =?utf-8?B?alMwNFlheXJJY2FLTXpQbG9xeXgxYWM3U0t5bjQ2SnQvSXZJaGFaM2JwVith?=
 =?utf-8?B?elpHeHpENTN3KzYrQlpYckNCT1hScHR5Qjl4SXdHRmJNRVozT28rYjZnK09m?=
 =?utf-8?B?UjBqRGJtMGxLaytPQ2Y4TFR1S2QwRVZ2VkhKVnltdmNkMUNEYk9FMlJXbUUv?=
 =?utf-8?B?T05QeXN5VmFHeFZacWtVc2FPa1NGQ2dwUlpCajM2L29wWVlTNk9OY1BFUlgw?=
 =?utf-8?B?R1VhTDc5RHdQY2hoNHkvYVViRXVWK2RkeEdzRGVwemZRa3ZWQVhrckZoRWxw?=
 =?utf-8?B?MW1kNEpzeTJZd2cvT3dlZXhRUVdVaTQyUHRMSzVwbCtiUzgzalIyUkQ2c1JT?=
 =?utf-8?B?V0NyVGJLekprZHFDM3B4ZkFnYVl2M0tERk9NRjdsMEhvVXp0dkphQzR1ai9o?=
 =?utf-8?B?b1N2QjRHU1lCOUVFamozQTZTSEw1SHJCaEpsWVA0UjRKU0ZORys5eVlKWi94?=
 =?utf-8?B?S1Fsc1JmVzZ1a2d4L1hSZHprTjJxcERzd3E5dU02dUJtK003SlgxV3Ivb0p4?=
 =?utf-8?B?NUMwVWR6R1gxWkg0MFdXOVVxVTM2L3JSRFJwTDY5NUcvMW40VldLZXBBcFNP?=
 =?utf-8?B?bDN3RXJpZnlZMWNWKzZQRFBONGFDM1BKVFluZEV4aFk0dlJKT25EQnUvYlFS?=
 =?utf-8?B?aDRzd2sydjFBYjArY2VHN0ZzdlM0N3F2Uzg3K25sRmhCdE9BZ2pCUERyWm9J?=
 =?utf-8?B?Tzd5R2p1T2RsTUNkWHRkY3I1cS91T3lCc1p5YkNTMG16RkxldjFTU1o1ZkU5?=
 =?utf-8?B?T25DZjRLN1pXUUlhaHg1MlFQdFRrNlEwbHY4WGVPaW9qT09vTjdFRFFvY2VY?=
 =?utf-8?B?dVZNN2Z3VWdEcWRyU3lmMjlxb0VWZDBtWHVGKzd2NnFrc0pjVkZZTFp0ekZQ?=
 =?utf-8?B?dDcybm84eUttYWJkUkVzMlVKc2YvbXAxb2prcmhnMFcyMFpKNlpsZTNhK1hv?=
 =?utf-8?B?ZlNYeFhaTGJ2RnZmWVJGSUFrei9UUXkvRzBaSmVmb3J2MnJaUU4xT3R2Z0M1?=
 =?utf-8?B?NkVhREZzS1lya3NtQTJnZkordjNhcXNOd1dOSGVVdFhRT0tsRDI1T0wrc0Z6?=
 =?utf-8?B?elI0dmxLTitVK1c4R1V1K0pkNkJjRWIvY0hOY1owNHM0WTFWZmZrak5zenE2?=
 =?utf-8?B?Z2FJSTZuVmFNbEY2L29LSVBiNVppT0RsOTdoRittaGFHeEs1YlBIWTVhUm02?=
 =?utf-8?B?WEdneU1KMVdFa2Z0R1JsK3VIOHcrZDR3djhYaUlIOUVnbmFkRG90R2dPTEJj?=
 =?utf-8?B?TFhEVWtFKy96OWx0Yzl3L0RDeVBCTUV4S2xWK3UrTitJU25zblF0ZEtvNmNm?=
 =?utf-8?B?OW9sdFBJZDlJaXFiQ0JIMHptYm1KdjdVbkl1RHBBNzErbUhGZHlEVGpBOEJE?=
 =?utf-8?B?R1RleU11aGp4S0J3bU5JTmxFMmdqUkI2L3BrZkRyZnp0K1Y3NEhma2JDRVFG?=
 =?utf-8?B?cFlMS0VIU3RZT2puRFZXeUlFRVJMNWxkSDlKS2h4eVprUTg2WlJUNC9Yc1lW?=
 =?utf-8?B?MWZCdnNKZ2tmVmF5YUFVSy84RUZ2eE5GYnVFRCtRaXphUlNnbW1ZVkl3SktG?=
 =?utf-8?B?MGFnemIrV1lpRHBKY0JYdkREZGkrdDZjMENEZ1Y5Z0s5Z2ZralRhOVpVdE9k?=
 =?utf-8?B?WC9CcnBwaUEwVUVUNFBGQlFUdnVEVnVkTSt5S1ozR0dOZWlES056bDNFYlVU?=
 =?utf-8?B?WkN5Mk9yWkhHbXNhTklaeXk4WmhUZzhWMllGeGM0NGo3eU1HUHBiNlB1eXFV?=
 =?utf-8?Q?79Z+Jy7W97f8IWlY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <123980261DA357469A4A43EB521BCF52@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b28fe540-4bae-4a58-5319-08da3184f6de
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 06:27:17.3244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hdiXQTaeXjmhaRZd0BX2/n8mt0OWk9hiCa3XMfg5pF2XEsYclGQ6TjoaoLASrZuhHfB/lm9jEgzz7jg8142ighuuLjWDESJE+0CSKM7WA5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3299
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDMuMDUuMjAyMiAwMTo0MSwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBFbmFibGUgYWxsIHRoZSBuZWNlc3NhcnkgbmV0
d29yayByZWxhdGVkIG5vZGVzLCB3aXJlIHRoZSBwaW5jdHJsDQo+IGNvbmZpZ3VyYXRpb25zLCBh
ZGQgdGhlIFBIWXMgYW5kIGNvbm5lY3QgdGhlbSB0byB0aGUgY29ycmVzcG9uZGluZw0KPiBuZXR3
b3JrIHBvcnRzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBXYWxsZSA8bWljaGFlbEB3
YWxsZS5jYz4NCg0KUmV2aWV3ZWQtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBt
aWNyb2NoaXAuY29tPg0KDQoNCj4gLS0tDQo+ICAuLi5sYW45NjZ4LWtvbnRyb24ta3N3aXRjaC1k
MTAtbW10LTZnLTJncy5kdHMgfCAxNiArKysNCj4gIC4uLi9sYW45NjZ4LWtvbnRyb24ta3N3aXRj
aC1kMTAtbW10LThnLmR0cyAgICB8IDI2ICsrKysrDQo+ICAuLi4vZHRzL2xhbjk2Nngta29udHJv
bi1rc3dpdGNoLWQxMC1tbXQuZHRzaSAgfCA5NyArKysrKysrKysrKysrKysrKysrDQo+ICAzIGZp
bGVzIGNoYW5nZWQsIDEzOSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9h
cm0vYm9vdC9kdHMvbGFuOTY2eC1rb250cm9uLWtzd2l0Y2gtZDEwLW1tdC02Zy0yZ3MuZHRzIGIv
YXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC1rb250cm9uLWtzd2l0Y2gtZDEwLW1tdC02Zy0yZ3Mu
ZHRzDQo+IGluZGV4IDdiMTJjYmUxMWM1OC4uMGY1NTVlYjQ1YmRhIDEwMDY0NA0KPiAtLS0gYS9h
cmNoL2FybS9ib290L2R0cy9sYW45NjZ4LWtvbnRyb24ta3N3aXRjaC1kMTAtbW10LTZnLTJncy5k
dHMNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC1rb250cm9uLWtzd2l0Y2gtZDEw
LW1tdC02Zy0yZ3MuZHRzDQo+IEBAIC03NiwzICs3NiwxOSBAQCBmYzRfYl9waW5zOiBmYzQtYi1p
MmMtcGlucyB7DQo+ICAgICAgICAgICAgICAgICBmdW5jdGlvbiA9ICJmYzRfYiI7DQo+ICAgICAg
ICAgfTsNCj4gIH07DQo+ICsNCj4gKyZwb3J0MiB7DQo+ICsgICAgICAgcGh5cyA9IDwmc2VyZGVz
IDIgU0VSREVTNkcoMCk+Ow0KPiArICAgICAgIHNmcCA9IDwmc2ZwMD47DQo+ICsgICAgICAgbWFu
YWdlZCA9ICJpbi1iYW5kLXN0YXR1cyI7DQo+ICsgICAgICAgcGh5LW1vZGUgPSAic2dtaWkiOw0K
PiArICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4gK307DQo+ICsNCj4gKyZwb3J0MyB7DQo+ICsg
ICAgICAgcGh5cyA9IDwmc2VyZGVzIDMgU0VSREVTNkcoMSk+Ow0KPiArICAgICAgIHNmcCA9IDwm
c2ZwMT47DQo+ICsgICAgICAgbWFuYWdlZCA9ICJpbi1iYW5kLXN0YXR1cyI7DQo+ICsgICAgICAg
cGh5LW1vZGUgPSAic2dtaWkiOw0KPiArICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4gK307DQo+
IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LWtvbnRyb24ta3N3aXRjaC1k
MTAtbW10LThnLmR0cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2Nngta29udHJvbi1rc3dpdGNo
LWQxMC1tbXQtOGcuZHRzDQo+IGluZGV4IDRiMzVmNmM0NmU3Zi4uNWZlZWY5YTU5YTc5IDEwMDY0
NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LWtvbnRyb24ta3N3aXRjaC1kMTAt
bW10LThnLmR0cw0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LWtvbnRyb24ta3N3
aXRjaC1kMTAtbW10LThnLmR0cw0KPiBAQCAtMTEsMyArMTEsMjkgQEAgLyB7DQo+ICAgICAgICAg
Y29tcGF0aWJsZSA9ICJrb250cm9uLGtzd2l0Y2gtZDEwLW1tdC04ZyIsICJrb250cm9uLHMxOTIx
IiwNCj4gICAgICAgICAgICAgICAgICAgICAgIm1pY3JvY2hpcCxsYW45NjY4IiwgIm1pY3JvY2hp
cCxsYW45NjYiOw0KPiAgfTsNCj4gKw0KPiArJm1kaW8wIHsNCj4gKyAgICAgICBwaHkyOiBldGhl
cm5ldC1waHlAMyB7DQo+ICsgICAgICAgICAgICAgICByZWcgPSA8Mz47DQo+ICsgICAgICAgfTsN
Cj4gKw0KPiArICAgICAgIHBoeTM6IGV0aGVybmV0LXBoeUA0IHsNCj4gKyAgICAgICAgICAgICAg
IHJlZyA9IDw0PjsNCj4gKyAgICAgICB9Ow0KPiArfTsNCj4gKw0KPiArJnBvcnQyIHsNCj4gKyAg
ICAgICBwaHlzID0gPCZzZXJkZXMgMiBTRVJERVM2RygwKT47DQo+ICsgICAgICAgcGh5LWhhbmRs
ZSA9IDwmcGh5Mj47DQo+ICsgICAgICAgcGh5LW1vZGUgPSAic2dtaWkiOw0KPiArICAgICAgIG1h
bmFnZWQgPSAiaW4tYmFuZC1zdGF0dXMiOw0KPiArICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4g
K307DQo+ICsNCj4gKyZwb3J0MyB7DQo+ICsgICAgICAgcGh5cyA9IDwmc2VyZGVzIDMgU0VSREVT
NkcoMSk+Ow0KPiArICAgICAgIHBoeS1oYW5kbGUgPSA8JnBoeTM+Ow0KPiArICAgICAgIHBoeS1t
b2RlID0gInNnbWlpIjsNCj4gKyAgICAgICBtYW5hZ2VkID0gImluLWJhbmQtc3RhdHVzIjsNCj4g
KyAgICAgICBzdGF0dXMgPSAib2theSI7DQo+ICt9Ow0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0v
Ym9vdC9kdHMvbGFuOTY2eC1rb250cm9uLWtzd2l0Y2gtZDEwLW1tdC5kdHNpIGIvYXJjaC9hcm0v
Ym9vdC9kdHMvbGFuOTY2eC1rb250cm9uLWtzd2l0Y2gtZDEwLW1tdC5kdHNpDQo+IGluZGV4IDRj
MWViYjRhYTViMC4uNGNhYjFiM2IzYjI5IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0
cy9sYW45NjZ4LWtvbnRyb24ta3N3aXRjaC1kMTAtbW10LmR0c2kNCj4gKysrIGIvYXJjaC9hcm0v
Ym9vdC9kdHMvbGFuOTY2eC1rb250cm9uLWtzd2l0Y2gtZDEwLW1tdC5kdHNpDQo+IEBAIC01LDYg
KzUsNyBAQA0KPiANCj4gIC9kdHMtdjEvOw0KPiAgI2luY2x1ZGUgImxhbjk2NnguZHRzaSINCj4g
KyNpbmNsdWRlICJkdC1iaW5kaW5ncy9waHkvcGh5LWxhbjk2Nngtc2VyZGVzLmgiDQo+IA0KPiAg
LyB7DQo+ICAgICAgICAgYWxpYXNlcyB7DQo+IEBAIC01Miw2ICs1MywxMiBAQCBmYzNfYl9waW5z
OiBmYzMtYi1waW5zIHsNCj4gICAgICAgICAgICAgICAgIGZ1bmN0aW9uID0gImZjM19iIjsNCj4g
ICAgICAgICB9Ow0KPiANCj4gKyAgICAgICBtaWltX2NfcGluczogbWlpbS1jLXBpbnMgew0KPiAr
ICAgICAgICAgICAgICAgLyogTURDLCBNRElPICovDQo+ICsgICAgICAgICAgICAgICBwaW5zID0g
IkdQSU9fNTkiLCAiR1BJT182MCI7DQo+ICsgICAgICAgICAgICAgICBmdW5jdGlvbiA9ICJtaWlt
X2MiOw0KPiArICAgICAgIH07DQo+ICsNCj4gICAgICAgICBzZ3Bpb19hX3BpbnM6IHNncGlvLWEt
cGlucyB7DQo+ICAgICAgICAgICAgICAgICAvKiBTQ0ssIEQwLCBEMSAqLw0KPiAgICAgICAgICAg
ICAgICAgcGlucyA9ICJHUElPXzMyIiwgIkdQSU9fMzMiLCAiR1BJT18zNCI7DQo+IEBAIC03MSw2
ICs3OCw5MiBAQCB1c2FydDBfcGluczogdXNhcnQwLXBpbnMgew0KPiAgICAgICAgIH07DQo+ICB9
Ow0KPiANCj4gKyZtZGlvMCB7DQo+ICsgICAgICAgcGluY3RybC0wID0gPCZtaWltX2NfcGlucz47
DQo+ICsgICAgICAgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gKyAgICAgICByZXNldC1n
cGlvcyA9IDwmZ3BpbyAyOSBHUElPX0FDVElWRV9MT1c+Ow0KPiArICAgICAgIGNsb2NrLWZyZXF1
ZW5jeSA9IDwyNTAwMDAwPjsNCj4gKyAgICAgICBzdGF0dXMgPSAib2theSI7DQo+ICsNCj4gKyAg
ICAgICBwaHk0OiBldGhlcm5ldC1waHlANSB7DQo+ICsgICAgICAgICAgICAgICByZWcgPSA8NT47
DQo+ICsgICAgICAgICAgICAgICBjb21hLW1vZGUtZ3Bpb3MgPSA8JmdwaW8gMzcgR1BJT19BQ1RJ
VkVfSElHSD47DQo+ICsgICAgICAgfTsNCj4gKw0KPiArICAgICAgIHBoeTU6IGV0aGVybmV0LXBo
eUA2IHsNCj4gKyAgICAgICAgICAgICAgIHJlZyA9IDw2PjsNCj4gKyAgICAgICAgICAgICAgIGNv
bWEtbW9kZS1ncGlvcyA9IDwmZ3BpbyAzNyBHUElPX0FDVElWRV9ISUdIPjsNCj4gKyAgICAgICB9
Ow0KPiArDQo+ICsgICAgICAgcGh5NjogZXRoZXJuZXQtcGh5QDcgew0KPiArICAgICAgICAgICAg
ICAgcmVnID0gPDc+Ow0KPiArICAgICAgICAgICAgICAgY29tYS1tb2RlLWdwaW9zID0gPCZncGlv
IDM3IEdQSU9fQUNUSVZFX0hJR0g+Ow0KPiArICAgICAgIH07DQo+ICsNCj4gKyAgICAgICBwaHk3
OiBldGhlcm5ldC1waHlAOCB7DQo+ICsgICAgICAgICAgICAgICByZWcgPSA8OD47DQo+ICsgICAg
ICAgICAgICAgICBjb21hLW1vZGUtZ3Bpb3MgPSA8JmdwaW8gMzcgR1BJT19BQ1RJVkVfSElHSD47
DQo+ICsgICAgICAgfTsNCj4gK307DQo+ICsNCj4gKyZtZGlvMSB7DQo+ICsgICAgICAgc3RhdHVz
ID0gIm9rYXkiOw0KPiArfTsNCj4gKw0KPiArJnBoeTAgew0KPiArICAgICAgIHN0YXR1cyA9ICJv
a2F5IjsNCj4gK307DQo+ICsNCj4gKyZwaHkxIHsNCj4gKyAgICAgICBzdGF0dXMgPSAib2theSI7
DQo+ICt9Ow0KPiArDQo+ICsmcG9ydDAgew0KPiArICAgICAgIHBoeXMgPSA8JnNlcmRlcyAwIENV
KDApPjsNCj4gKyAgICAgICBwaHktaGFuZGxlID0gPCZwaHkwPjsNCj4gKyAgICAgICBwaHktbW9k
ZSA9ICJnbWlpIjsNCj4gKyAgICAgICBzdGF0dXMgPSAib2theSI7DQo+ICt9Ow0KPiArDQo+ICsm
cG9ydDEgew0KPiArICAgICAgIHBoeXMgPSA8JnNlcmRlcyAxIENVKDEpPjsNCj4gKyAgICAgICBw
aHktaGFuZGxlID0gPCZwaHkxPjsNCj4gKyAgICAgICBwaHktbW9kZSA9ICJnbWlpIjsNCj4gKyAg
ICAgICBzdGF0dXMgPSAib2theSI7DQo+ICt9Ow0KPiArDQo+ICsmcG9ydDQgew0KPiArICAgICAg
IHBoeXMgPSA8JnNlcmRlcyA0IFNFUkRFUzZHKDIpPjsNCj4gKyAgICAgICBwaHktaGFuZGxlID0g
PCZwaHk0PjsNCj4gKyAgICAgICBwaHktbW9kZSA9ICJxc2dtaWkiOw0KPiArICAgICAgIHN0YXR1
cyA9ICJva2F5IjsNCj4gK307DQo+ICsNCj4gKyZwb3J0NSB7DQo+ICsgICAgICAgcGh5cyA9IDwm
c2VyZGVzIDUgU0VSREVTNkcoMik+Ow0KPiArICAgICAgIHBoeS1oYW5kbGUgPSA8JnBoeTU+Ow0K
PiArICAgICAgIHBoeS1tb2RlID0gInFzZ21paSI7DQo+ICsgICAgICAgc3RhdHVzID0gIm9rYXki
Ow0KPiArfTsNCj4gKw0KPiArJnBvcnQ2IHsNCj4gKyAgICAgICBwaHlzID0gPCZzZXJkZXMgNiBT
RVJERVM2RygyKT47DQo+ICsgICAgICAgcGh5LWhhbmRsZSA9IDwmcGh5Nj47DQo+ICsgICAgICAg
cGh5LW1vZGUgPSAicXNnbWlpIjsNCj4gKyAgICAgICBzdGF0dXMgPSAib2theSI7DQo+ICt9Ow0K
PiArDQo+ICsmcG9ydDcgew0KPiArICAgICAgIHBoeXMgPSA8JnNlcmRlcyA3IFNFUkRFUzZHKDIp
PjsNCj4gKyAgICAgICBwaHktaGFuZGxlID0gPCZwaHk3PjsNCj4gKyAgICAgICBwaHktbW9kZSA9
ICJxc2dtaWkiOw0KPiArICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4gK307DQo+ICsNCj4gKyZz
ZXJkZXMgew0KPiArICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4gK307DQo+ICsNCj4gICZzZ3Bp
byB7DQo+ICAgICAgICAgcGluY3RybC0wID0gPCZzZ3Bpb19hX3BpbnM+LCA8JnNncGlvX2JfcGlu
cz47DQo+ICAgICAgICAgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gQEAgLTg4LDYgKzE4
MSwxMCBAQCBzZ3Bpb19vdXQ6IGdwaW9AMSB7DQo+ICAgICAgICAgfTsNCj4gIH07DQo+IA0KPiAr
JnN3aXRjaCB7DQo+ICsgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiArfTsNCj4gKw0KPiAgJndh
dGNoZG9nIHsNCj4gICAgICAgICBzdGF0dXMgPSAib2theSI7DQo+ICB9Ow0KPiAtLQ0KPiAyLjMw
LjINCj4gDQoNCg==
