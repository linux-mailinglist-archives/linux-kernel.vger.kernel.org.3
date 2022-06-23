Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FD7557657
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiFWJJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiFWJJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:09:21 -0400
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2100.outbound.protection.outlook.com [40.107.127.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9557C34B92;
        Thu, 23 Jun 2022 02:09:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEZPlZ2bA+Wl5Rla98LZ2r+H3weZKZw5TlENFnZbXo9/DzbUxbOJDDfR+iNA0S+I2hCO99TjN/MPQMgdAHqKHjh0n+1OgzwlFNPqPDvY8dHv61bzTYhxem/N3PjWib1lUKi0Frffk0rWxSp93xaBKTMcAhNmUmvmXBmk9lLSOKUmXRF2YpP8vLWyPNi/BDTHWbp/7UsGfgu5SHq1OVUIEyF1OIU9pb7Yg2oUg4KGa40/jJJL4TloHCOYFc1BM4u4fhrfYjFvKcjldHIFbGiu5p/hyPOiFBdlDSCp56qD1tNVvB29fwHJ6uxNexzyT327QvEp1qRYXOkHUmWVU98NRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bROjtPNvxbCshYgUE+96A/VozorzJZ1IEedpfqeV/50=;
 b=F7mnxO/6HwKawhRSzxxtVy9EQE2dduu+AqlxIbj3VAVhKnoe6KBFAMzYmM5CKEwo0ceWxGhH3eem0+d4MMkgtCfndb5AXvDGuBeFh+dncSEJIpkDJmxasdavbfaHDspcdhERdTDPuNKFvXk29GVodk/dRv6g/6JRiynwJeezDYuyf6jEBwHKVW4KCUGW1PnlZ1w24DVjM0t9/u8BjUWPd+0sEX43ELYCoL+jftfKD1+QZ5WcEacFImhEER/tVX+YuRGOkIr3x2vB55MRVYA3XL3wY1i0sbOdiKeR4rQoMiztgTpiqSMhFuhgjE+EVL7a8E8JbFyyk4BYffh2CHd66A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bROjtPNvxbCshYgUE+96A/VozorzJZ1IEedpfqeV/50=;
 b=zrLCfXlS8YCxPu2BgfIbo4LxYNqs4+pCoSX+s9HtaI/+A+U7juTUUqYjNx+W6WzmoI12NCemzzUX0fQZJNrESCqh/s2v2BVTEeGs0Yk2vmLUKGA0TnC+UaLbC4vU9Hbdn2cALDB17cS7aJ4sUzD2iLEtdlHk48/evlRY1hctMy4=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by FR3P281MB1999.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:35::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.9; Thu, 23 Jun
 2022 09:09:16 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2812:f9e5:c7e5:166e]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2812:f9e5:c7e5:166e%7]) with mapi id 15.20.5373.016; Thu, 23 Jun 2022
 09:09:16 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "agross@kernel.org" <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "bgoswami@codeaurora.org" <bgoswami@codeaurora.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "cw00.choi@samsung.com" <cw00.choi@samsung.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "michael@walle.cc" <michael@walle.cc>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "maz@kernel.org" <maz@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "mani@kernel.org" <mani@kernel.org>,
        "cristian.ciocaltea@gmail.com" <cristian.ciocaltea@gmail.com>,
        "wens@csie.org" <wens@csie.org>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "rjones@gateworks.com" <rjones@gateworks.com>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
        "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
        "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>,
        "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
        "samuel@sholland.org" <samuel@sholland.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-actions@lists.infradead.org" 
        <linux-actions@lists.infradead.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 33/49] mfd: rohm-bd718x7: drop useless mask_invert flag on
 irqchip
Thread-Topic: [PATCH 33/49] mfd: rohm-bd718x7: drop useless mask_invert flag
 on irqchip
Thread-Index: AQHYhW4txlpa/ieXUkuLKIbprH44/61ctvQA
Date:   Thu, 23 Jun 2022 09:09:16 +0000
Message-ID: <704886e7-7aa0-ca57-2ce9-a86d9cde4a4b@fi.rohmeurope.com>
References: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com>
 <20220620200644.1961936-34-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220620200644.1961936-34-aidanmacdonald.0x0@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d1ac59a-9dbe-4b4a-dd35-08da54f80c56
x-ms-traffictypediagnostic: FR3P281MB1999:EE_
x-microsoft-antispam-prvs: <FR3P281MB199973DFC3FE049661429EC5ADB59@FR3P281MB1999.DEUP281.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L980SZH5MRNw3t/d6cYj0jHIB6PbgJ4lQSh8uyb0mblzmG4VK4kmqCJaRG8yYGpFtO9hPCgoha4n+2y2NMEAK/7Ae1nqb0AgZu0byJ9fG5fq9eioEvLv0EaGd0yfx4wyhYdkWsn3cSqkmh1HJ4UJ1ZRNneb/vwORWsSpFdXU1u6C+yeRx81VsCVxyFGxBbBD3K+LWZdpFVbtRChSFDsVakVbcaae9eFvXd3g0gOE9tQxlqIXr0Ub7JYtnveXdYiK3rDio3PYck4qtxI5HFG4uQKXcUTXLZ+P52zDN7XiQfAo2hVAALDvMhTngMlTPbcax5ujnGRZ0xFNs5hDIXiT5LoEVSCHqGDTjjQTJWAFyiIO8MabDfubOamdujUjeasPn2M/7Gk4pTiGECbV8cGURPVR0vw+vp54XkXwaS6ehnbwxPRdzDlZT7/DHJlbf2TfROK2mxnbt8Zq4K1oYESb3CQMNE9CfD8R06c4Mw3ih+CnCj5uwsZGWRjxflkKYTqtqagwKhH4OMRsGs8Zq2s6JYKTamrjyFKQSuV49ZdAFBmhRc2gA0t62a5RVQXx7NMOvwg4/jEsJt85SXxE1VOYXyj6Sp5BZOvq5R3O5NnjYcqO5Staj+jf5+lyddu/y/PssbiLygJhO3GptCHPwSG2NV2QqKYEYo5Xl4/QzlUfCvKZ75Q9CwDY4grY3z9cVLm3HytwWY1qdua+3GQkCWqVHkGWx52YbwiUMGMwG2IaNq/sfhS/OW5CBQBaOfgvjOS6T+CgmPLh81fZetxLcP3GJSR7mMQhsp7dv6Dhd2GY9mxfDujZ6fqHqygEMy+idaxyZZoWLsGcXXzWeWN2BIU9CA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39850400004)(366004)(396003)(136003)(31696002)(4744005)(86362001)(316002)(4326008)(122000001)(8676002)(91956017)(66556008)(83380400001)(38070700005)(2616005)(66476007)(76116006)(66446008)(2906002)(66946007)(38100700002)(71200400001)(64756008)(6486002)(41300700001)(31686004)(53546011)(8936002)(478600001)(54906003)(26005)(5660300002)(7416002)(110136005)(7406005)(186003)(6506007)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmFxVDl1NWZVdE5GajRuT1JtSjVjYUtKWC84Q2dQSmNsQlFPQzd0UFR2VVJI?=
 =?utf-8?B?REtDRElIZFZvZFZzcTAxUWZrRjN3clhKaWZkeEcrLzI0M3BZcDNkWUhnZU92?=
 =?utf-8?B?Zmp5RU1rcGF4MmxBZDY0d2l3VFNXbkxaL1ExdWZjcXg1OVpjOWpaRkd5aHhZ?=
 =?utf-8?B?VkxrdXpTQ2lrZ3JXblpVbUdZUDhDcktHbHAwdk04VzZlTHcvUW9pOElGbTJE?=
 =?utf-8?B?cHQwREgrRzZMMTFKQjJPWFVlQy9TcUdaRkl5OUR4NDFUblNFZUFKZnBKUDBW?=
 =?utf-8?B?MFR0MFMybDZiNTBDYzdqZVF6WTRxd21OYmswc0c4QUN1cDdBV3NjZmZhMXJz?=
 =?utf-8?B?aHpPU29Ld0E4ZWUwUW9PNjRRS3dsL3hsK2xlL2xBU2NpWkMxUXVHRHI2aUN4?=
 =?utf-8?B?TXNBcXdIbUs2MWg3QjBNd2pLQlZoK25SMUpVUjZXcWp3S2VVVEpqU01Ld0V2?=
 =?utf-8?B?NzFtcnVmMkxibDRBSmE3citSYWJmdzhLbEk1NERZVGZoWGFDTGwxbFU1RnhK?=
 =?utf-8?B?aU1RaHQ2d2pLWElaVnFsMjNRUitNMytvSFRIOHkvVzIxOGxBcXVUR0Y0Ykgx?=
 =?utf-8?B?VGFpSThDTXhNY1I4aGxGSVBDQjFYM3E2UnZlNmU1c01jMEhJWG9FbVJyblda?=
 =?utf-8?B?Vm5KOVVYd2g5N2NDcUxCdURodEc2WXc2RjdveGlWVHlMeVUrRmZEdFU3K3Jp?=
 =?utf-8?B?TGxweE9mQmxWNFk0UGduZk5YbW9FT3JGU3FaV2xObXRnTzVKK3NTL2RDZUsv?=
 =?utf-8?B?T2RsckUxdlFEeE5xSEFrbGxNZ1FMcXQ3OVJYbVExQmFCdlJ3OUFNRGZ4ajdi?=
 =?utf-8?B?TzlUdjNHZHJaRmNaTEZyRXE0cTNjVEphSnJGWEpjMyt1NDRrY2lRYThBbEhi?=
 =?utf-8?B?UThZR3Y1d1lVdUpwSDR0OEJvcWVOOWFYa01UVExOQzlMU285WDlZSGUwWmVB?=
 =?utf-8?B?QWhCOWRjeWw5YU50NVNnSmlGZlc5L1liYXQrVy9ZQzN1MWsrRU5BcldheVBm?=
 =?utf-8?B?MmRKTVM2UUhrQmZzNUxVa2htaUxGUTVQQlFwUmJ6S01WRnBLSlJjalRmd0N1?=
 =?utf-8?B?c0hUWUVNcGxYejIwcU04bmNFYTl6MDVtTnAyMFFaT1EyM0VhNFNTUURtRWdB?=
 =?utf-8?B?WUZFUWtnVWNNN0RqYWRpTm11dmwzdmtLanNTUWtGUGNpK1kzbkNmRXluMjhI?=
 =?utf-8?B?STltNVh3Umg2Vm9mOS84cGZ4Q0hVQmgyQmtzZEpoUW41WitGL2pNTVU3STJQ?=
 =?utf-8?B?alFza3JNdmsrQWIrM0Z6Y3dISzNscnRXQ0o1M09aV0xnS2xEZFdVRGI1c29B?=
 =?utf-8?B?ZmFZWXk1dG5KclQ1eWY5YXNLcHN4WGVMWUI2NnRsTEZFVDJMeHFFUDJGcUpI?=
 =?utf-8?B?M1dlZExibHVieFdmVytDbmVBYU0rSUJ1eERqT2JKUVkxbExvdXpuM1ZxQkx0?=
 =?utf-8?B?c0QzMlZuRnZmdlptUCtIdXExbUFDUzBwVzVBd082QnNPQ1FOQzVyRVNEOVNV?=
 =?utf-8?B?Tkw5dGh5NkZCcFRIYm5OQzVhckZLOFpiK1UzNk8rV1JBQUsrQ0RyZEtaN1o4?=
 =?utf-8?B?aVovRVZack1PcFlKU3BPWHlvd2dzTFVMSTdnRjR4U1VySzF6bzFEcjhqSy85?=
 =?utf-8?B?SFJYMHNrM1lXWFQ1alljYVJRSHFHZVJCT0xNU1cwTEZYZ3VVVXJnR2IvTFFL?=
 =?utf-8?B?Tm14c2pmOE9neksxTGV6NUQ5ZWVRQmdXN3czMDJmRWxCTnk0MStnUHQ3MTB6?=
 =?utf-8?B?ZW1YcWlFMkxlQzVLR2sxQ2w5RXQyZzY5ZzNRRW9CY2NNaFVteGxQM3RQclJK?=
 =?utf-8?B?ZzBaWnVUZHR5bXhmbWhiTVExYnVVUEUvRTR5K1ZxdXZqMWNGUURicWZ0aG1E?=
 =?utf-8?B?VUszSlFXeHVwc0lraTRZZUxSMllLU0RycHQvY3JITVJpWUV5Wi9FVUU0TDZ4?=
 =?utf-8?B?eTFQUjNGWXUwYlk2RmsraEJqS3BaOXhVYzNQZlA5Vi9JTXlQM1g3Vk9HUmFH?=
 =?utf-8?B?NStFcEhqdTZjOGJnUlBXNUVIaHFycGkyVmR3N3dRa1pOVFRWN2N6SitXWFYr?=
 =?utf-8?B?eWd0YkdRRGxUYzVsOTBYYzdDWTRucHFmeDdjbk42WE1idW1TZ1Y1S3VIVGxy?=
 =?utf-8?B?RjR1eCtyR21oU1ZyTWhrdnN4RWJxWTlrV01KQVltWFZJY01tRW0vWkx5a3B3?=
 =?utf-8?B?RkdSMTdQQ2dVSWsvVDdyZVVEcnFaRExTWVhOQno1Zmt6d0taYTVnWG13cGNV?=
 =?utf-8?B?NUZZYVBvK3JCOWV0TDlDUDluN1JudUIrT3c4Rm5YcnZockRicG5KK3pSVGZX?=
 =?utf-8?B?SS9MZG5WNFBzWXVpSGgvdTdCWk02MTV1VmhaZkhNT1Vkc2NvZWVmeDhaa2tm?=
 =?utf-8?Q?kxhouR65edNpPllVjit13OWpzwif0KVg8f9LE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5375516193A4B4D881BFC12927198E2@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1ac59a-9dbe-4b4a-dd35-08da54f80c56
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2022 09:09:16.1519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gfGoLqka8tVtRJgEaGh8Z1fVVowHagMU9yykzNWZtfPwyw0mY6i/p+5jSVvOQVwpw0ab+8F1EtrL5I9j44yzEwv3DDY1gWaRX82z0/fZ/ryebAklnPm4q4+p3dCYWfVk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB1999
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8yMC8yMiAyMzowNiwgQWlkYW4gTWFjRG9uYWxkIHdyb3RlOg0KPiBUaGVyZSdzIG5vIG5l
ZWQgdG8gc2V0IHRoZSBmbGFnIGV4cGxpY2l0bHkgdG8gZmFsc2UsIHNpbmNlIHRoYXQNCj4gaXMg
dGhlIGRlZmF1bHQgdmFsdWUgZnJvbSB6ZXJvIGluaXRpYWxpemF0aW9uLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogQWlkYW4gTWFjRG9uYWxkIDxhaWRhbm1hY2RvbmFsZC4weDBAZ21haWwuY29tPg0K
PiAtLS0NCj4gICBkcml2ZXJzL21mZC9yb2htLWJkNzE4eDcuYyB8IDEgLQ0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZmQvcm9o
bS1iZDcxOHg3LmMgYi9kcml2ZXJzL21mZC9yb2htLWJkNzE4eDcuYw0KPiBpbmRleCBiZmQ4MWY3
OGJlYWUuLmFkNmMwOTcxYTk5NyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tZmQvcm9obS1iZDcx
OHg3LmMNCj4gKysrIGIvZHJpdmVycy9tZmQvcm9obS1iZDcxOHg3LmMNCj4gQEAgLTcwLDcgKzcw
LDYgQEAgc3RhdGljIHN0cnVjdCByZWdtYXBfaXJxX2NoaXAgYmQ3MTh4eF9pcnFfY2hpcCA9IHsN
Cj4gICAJLm1hc2tfYmFzZSA9IEJENzE4WFhfUkVHX01JUlEsDQo+ICAgCS5hY2tfYmFzZSA9IEJE
NzE4WFhfUkVHX0lSUSwNCj4gICAJLmluaXRfYWNrX21hc2tlZCA9IHRydWUsDQo+IC0JLm1hc2tf
aW52ZXJ0ID0gZmFsc2UsDQo+ICAgfTsNCj4gICANCj4gICBzdGF0aWMgY29uc3Qgc3RydWN0IHJl
Z21hcF9yYW5nZSBwbWljX3N0YXR1c19yYW5nZSA9IHsNCg0KUmV2aWV3ZWQtYnk6IE1hdHRpIFZh
aXR0aW5lbiA8bWF6emllc2FjY291bnRAZ21haWwuY29tPg0KDQotLSANClRoZSBMaW51eCBLZXJu
ZWwgZ3V5IGF0IFJPSE0gU2VtaWNvbmR1Y3RvcnMNCg0KTWF0dGkgVmFpdHRpbmVuLCBMaW51eCBk
ZXZpY2UgZHJpdmVycw0KUk9ITSBTZW1pY29uZHVjdG9ycywgRmlubGFuZCBTV0RDDQpLaXZpaGFy
anVubGVua2tpIDFFDQo5MDIyMCBPVUxVDQpGSU5MQU5EDQoNCn5+IHRoaXMgeWVhciBpcyB0aGUg
eWVhciBvZiBhIHNpZ25hdHVyZSB3cml0ZXJzIGJsb2NrIH5+DQo=
