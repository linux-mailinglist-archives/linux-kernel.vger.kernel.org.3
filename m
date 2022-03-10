Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E694D41BB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 08:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240065AbiCJHYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 02:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240061AbiCJHYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 02:24:02 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549755A0BF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 23:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646896982; x=1678432982;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vk2VhqCi1n/0owAL+W5ht+VgvEhHML0zE6N5taKsKZU=;
  b=Ay5lDs1BYLfos2MAt05kZFF2D6sHHQaorH1XvP/yWSIQhT+zD6kBVBKb
   WyGiq1XXEUzEIxiWOoJWJJF1AqWidO8la1Jd8TGZ0M1sj/S2qjpndLT4f
   OFaxxTZbq+bbNNwcEqpBm8tTz7IGuLPijg0tpQpIkt/ThI4GctvcjCuNM
   Mtwe57BjPb2rzqaZ0k7QDeCa/pOkMwtbocL7coi2Kikv7pmw6OFkIINPG
   GF3UYOh1jiCh4J1cmE7WF/Th6Co7kotSZijvXZooUJLi17MoAMeFozkA0
   F2ahRhf9qRwpnLqdniI8bZB2cvqFaoHIiJc2G2cV2Z7r1qVL9G+ngHCBy
   g==;
X-IronPort-AV: E=Sophos;i="5.90,169,1643698800"; 
   d="scan'208";a="155931820"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Mar 2022 00:23:01 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 10 Mar 2022 00:22:59 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 10 Mar 2022 00:22:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dk6UZgp4NAeRqlxn6KepCgZpspykNKbETafHJWIRAhpWDqzmhn3JwvEpqJbj/xHkRnpb0XhkEMeop1P5pv3u8aj3nAS7i5npGHztQXO6ngHyneWlrPaS8yXKBWTUBz3MtyV01u9jVSfxq2sZ6Htuf6qYHE2BKTPRVSqJ1Mq1StbbOSVnxFCU1khsmg6hrJSVPpOGhGeUI/FqQ27FVhi4SWZFpg7x6hgm7ulHGZrChI/kpOmdJAZBa8teyGpk2uAhIZPUcvSOJrK7h1xyTDntc7b+VzZbSlUimUNtH9X1lUIfSj2Sw3QJ2QlhEuU9T5fsn18RgahJ7VFnZOYtP3ZLnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2VhqCi1n/0owAL+W5ht+VgvEhHML0zE6N5taKsKZU=;
 b=oJaJhdateu23yIbNH6enNh/p8JdkDez8Ma7DeYwKdNtbA4GpgGY7HCKtcMQ5UxLZy1XwLb/UrI4TpW8fMLjjcGPFMlr4Yh33qTBhGGC1ksQAj5JkKmxnAbYAQQh6jpFykJhrA+eY+Ow27RTkIdzbMTPIMEaTLgraMEJLO6X2Ymw7OyoO/yz2RyFOybvueqZBDzFh5k2OxkF3PrnYQNMbBbJkSPIghZEyovlHoo92KjD1VgFHIwYBej+7xzyZcze4i2cmkhk3PxLH6sDDqi1yt1f44LYwxA9bKjTzVYb8aeX76GqfKpZs1T3gPdgjKC6wdv65Kc9vLlCyaRmixRFYFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2VhqCi1n/0owAL+W5ht+VgvEhHML0zE6N5taKsKZU=;
 b=XSlyR8c8E/G4u6wWsOvizUa99VhTHy9buuLzPqe0dErUJ6Hbe+0FQFOpdboCOZciGMTGyQIwMcbcBH+IQdfZpp5KrtUne/8X+mKqJjFF5gZtkHgytCuQxt6FQL2hzBP3nSMMsrsioQ646jM5XV8TjkXUI5xFYfpEKs/QAOucgUE=
Received: from DM8PR11MB5687.namprd11.prod.outlook.com (2603:10b6:8:22::7) by
 PH0PR11MB5127.namprd11.prod.outlook.com (2603:10b6:510:3c::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.22; Thu, 10 Mar 2022 07:22:54 +0000
Received: from DM8PR11MB5687.namprd11.prod.outlook.com
 ([fe80::fc32:96a4:933f:194f]) by DM8PR11MB5687.namprd11.prod.outlook.com
 ([fe80::fc32:96a4:933f:194f%4]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 07:22:54 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <jiapeng.chong@linux.alibaba.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Claudiu.Beznea@microchip.com>,
        <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <abaci@linux.alibaba.com>
Subject: Re: [PATCH] ASoC: atmel: mchp-pdmc: Remove unnecessary print function
 dev_err()
Thread-Topic: [PATCH] ASoC: atmel: mchp-pdmc: Remove unnecessary print
 function dev_err()
Thread-Index: AQHYNBTzZK1DwBTY6E+w5f3j7YLTKKy4NyYA
Date:   Thu, 10 Mar 2022 07:22:54 +0000
Message-ID: <a5f62008-c1a6-b88e-fd50-8a1789a97610@microchip.com>
References: <20220310002221.125448-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20220310002221.125448-1-jiapeng.chong@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92137561-5dcf-482f-c486-08da0266cb6a
x-ms-traffictypediagnostic: PH0PR11MB5127:EE_
x-microsoft-antispam-prvs: <PH0PR11MB51278502E7DFEF8FEA5B29D8E70B9@PH0PR11MB5127.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UcpYRDIuNFDF4mJ8kOEqLXOAW8MO84nN/9vmcGoVfRNar9TxJs1a9GVdYjnNPU2AjWBQ2S/r1g+4DNHlFersk7rAyoBznzXeYbPJO/B3oHIrU+w0jBNqp5+TH2obJeYbwwI3809AUx6aiKyaN1gh0l2vdpWM/Eeltwz4egOS9b/WVoP8LtO32hbQ4MFK3bogiJNklcKB/NlMe9wQNxW7k3SnjyOdyNRCa/qIUIO/pRPm6FwFk+kpBHwVTPEvuT1b6o2lpwgj2WrH15YJtGveO81oe38Yarh4anqPxtNlBr5p/ymzM/iCm7zddJs7jhar7HW30OiZrvE3a20YRxtK3YGnkFyZs5DE1+SclD5clkccrbBgq1PJ6u1d6OmCEnzZ0n4UgRTRbJEtgDTBod2Tmux8Btj3EKKIV2mPDeaJM+NeT9mEzJLhFMybOno/LlpG3HCMqAxXEbw4XZcHZPiIMJzv8uwPky+w7MpG3xQVaznTTOLPgXbTIanwB+EI8Dt2qtJ9xGeq3n8fmaZi0XYa8RPCurebTF9B0ba3fpRoV64TS+QaCb3fuTOS8l09NbHloAgQeyZ0PNP09qlZfR1rHsJRTiW+HT/CdNwJ2pbch+ZxPa1pZjuUVla4d0IMMMkVPcHosiKfLkaXmbSDydRtN3X9I3NDAH5+ymdGdEMdSQQoOxiLnI7BtMra/Au6h788G3Xwp3bt1M3PkZ9EqAkzaeahCeMubFQmdXTTDeieRmWwXUjOCx1MUuZy3UvXmkjOHqy2RcWJA+Ibvwzjm7eanQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5687.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(6506007)(38100700002)(66946007)(76116006)(91956017)(186003)(26005)(8676002)(66556008)(66476007)(4744005)(66446008)(64756008)(6512007)(2906002)(38070700005)(31686004)(122000001)(508600001)(2616005)(53546011)(5660300002)(8936002)(4326008)(71200400001)(7416002)(6486002)(6916009)(54906003)(316002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckNsV0k4VkNhVVZvNFRzY3YwdjdiYk16alhCZlg1VzdYZFY1YTdEb2xjS3Nx?=
 =?utf-8?B?MUFrbkkydysvVkl0cDZ6NHYwSTJmTGIwMnFyem1TQmozQnhzTWtiRmdsS0N4?=
 =?utf-8?B?RlZPRER2ai9WYUs3WER5blovRVRTZThndnJveVZSUjU0Qi9CcHJLOGw3c1pa?=
 =?utf-8?B?d1RKZkNqQ1k4Vk9Ob1ZJem5KWWV2eTlwUEV5ZFFXVUpaVTQzb3lsa2FWWDlj?=
 =?utf-8?B?dmU4WUtVNnpBeTlzd1J3VTdlVWUySWI3U3ZpYWZzRytxa1I2OUJHemJjUHRn?=
 =?utf-8?B?M1NTNzQzY0hodk8xMEtSeHQ3UXJXaWRhOHE5RG9aWGtFZzVhRUlVV2lqZEFa?=
 =?utf-8?B?RGx4SmNHUzVuTEJ5ZW5NdEJhbFpWdzd6NEhkQUNsL3JDeWNKSW43ZWszZEpi?=
 =?utf-8?B?ZXdRZ20wYkNpc0NIaHNkdzFEZVVFdUdvc1Foa2JNSURRQStxNHZGbE9MZ05N?=
 =?utf-8?B?QVk2cFFzck5POXcwTWxEUmtWYUtLekhnY1lwMDd5RlBwUjdieUR4Nm1wcTM4?=
 =?utf-8?B?Qm11WVJUcDluenJCYW1zUmx2RGdnTm8rUEtGelBXODlvbHk3eExSWHRNOEFv?=
 =?utf-8?B?d2pwTy8relhYWjZPbUpQRUI0b09LenRVODJYTGw4elRkN0J5RnpzbTJHdk5R?=
 =?utf-8?B?SjJnWld3QzlxdWdxVzZ1TktQVFZubGp3bkRob1BKS2F1Tis2R2h3S0gwWlIy?=
 =?utf-8?B?SFZBUnNGYkRSRU9NZlZoM0ZlV2JFeTlOd2VibEZkV09jeVFmL3pnQmVsd3hM?=
 =?utf-8?B?aEx4WW1HUEdJZGhBUHFNaVVqMXZoampSenJKclF0V0NPOW94VGxEUFpsVzJT?=
 =?utf-8?B?ZnJuajNPVDFHTjVpVHJrWE9qekhrZTUwT28xekNSMVlZT0Mrb08yMGlQNUdT?=
 =?utf-8?B?TFkvdlQ1UW9DVWJWMmEyVUI2Rkx3QVdvU1YzQWlUai9FcmdDUjdYbmhETThj?=
 =?utf-8?B?dFNFSjFJMTJoOVlWd2xnNUtjOWdVOWhpRDRtTlN6SVBhT3VtS1VrOUpqWW1W?=
 =?utf-8?B?R0h0ejRnYTVaUGQ5TXp6VjU2eCt2SlU0SlV6TStKamNRMGNkMDJQdWM4UWEx?=
 =?utf-8?B?bFM2RDV3S0FBUm84dWxQNStzb0E3RVJOLzk1VzJBRkZrR1BYTVNuU0dwb09x?=
 =?utf-8?B?N3NaN21XTVpIZjJPam5xSnd4ekNMY3BxWGhkYWx1MkhzRVh0QWxHczZkc3gw?=
 =?utf-8?B?YVJ3LzVidTUweDJQZGZMYXB0elNqTVVMWTN6WVUwL2lDNHh4K1R4elI5RnQ2?=
 =?utf-8?B?WTZoOFRseGYxVFp6MXpSbVM1V3pMKzh4a2g2NlR5V0JiWjV6aW1zZUEvYjJT?=
 =?utf-8?B?b2pwZTVqSUlSRnZMRnNETjBTekJlUUNVTktNMTJUVGNYTmZ4WDY2TUVJNWdv?=
 =?utf-8?B?cWdCWVpMSFpOM3RkL0I0NXR4cVdWbGtJdDlQQVhWSldwalFoaTV3MC9uZHpu?=
 =?utf-8?B?UDgwcVFKd0ZGTE9HV0t4bTBKRHpYUktNRGdZb2RuOStFaHFWVGxuUmF2cGY0?=
 =?utf-8?B?VkNQYk5icWgxWTVBUjBaLzhac2dRWVIzdG9KaGNNMWZKc3Q4T0dhM3p4WkxZ?=
 =?utf-8?B?ekg2SU1Yc2Z5WEpYUHJJcXE1M0k1Tk1hcUZOK3hIV2xpREJtY0xuUVE0TWZy?=
 =?utf-8?B?Q2ZHUjBxb2poQnFWelRBeVBTQVN2L1RRTnl4OXZYNVVtbTFNc2wwMTdLMXJU?=
 =?utf-8?B?SndxUFQzOWtLNXBLZWR5eUROWXdCVDNmZjA5SUx6STZ6UlVUakxiN0xyTW5Z?=
 =?utf-8?B?RW0xc2NlMlRrZDVvUVBVT05BUGxoRkhZRTFlNXVpdjV2akFqRmVFaEdyV1dq?=
 =?utf-8?B?Nk43alIwd0d0UFl2N2xNb0pyYWIvazM1ZTlsWXlkZFdPSmlVM0tqdHdITVdW?=
 =?utf-8?B?aDVhc0k4a0Y1REVBQm5LUERSQ3BicTMzTjNIM0k1UmI2UXQwdVBZTXlBd0JU?=
 =?utf-8?B?d1ZRMlpBOHVLOU9MSWRxSDR5YlRXY0wvRnBPWVN6c1FTSng0MVhCdmhBNE9o?=
 =?utf-8?B?RGwwRkdleEpnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D14851B694E22B41894810D859874C8B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5687.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92137561-5dcf-482f-c486-08da0266cb6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 07:22:54.8412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: omKZPwSwNLWEvu8t70AtPQeJTGzSdSNClL3Kj5rhHpunEoNnOmwfQP45G5mbofbAH8Z7McjwQgzPjKCcsqsgvKZqTJy4zX2cVOqL8E5X7Oo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5127
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAuMDMuMjAyMiAwMjoyMiwgSmlhcGVuZyBDaG9uZyB3cm90ZToNCj4gZGlmZiAtLWdpdCBh
L3NvdW5kL3NvYy9hdG1lbC9tY2hwLXBkbWMuYyBiL3NvdW5kL3NvYy9hdG1lbC9tY2hwLXBkbWMu
Yw0KPiBpbmRleCBjNDQ2MzZmNjIwN2QuLjJiNDhiZDM0MzRjNyAxMDA2NDQNCj4gLS0tIGEvc291
bmQvc29jL2F0bWVsL21jaHAtcGRtYy5jDQo+ICsrKyBiL3NvdW5kL3NvYy9hdG1lbC9tY2hwLXBk
bWMuYw0KPiBAQCAtOTg4LDcgKzk4OCw2IEBAIHN0YXRpYyBpbnQgbWNocF9wZG1jX3Byb2JlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+IA0KPiAgICAgICAgICBpcnEgPSBwbGF0Zm9y
bV9nZXRfaXJxKHBkZXYsIDApOw0KPiAgICAgICAgICBpZiAoaXJxIDwgMCkgew0KPiAtICAgICAg
ICAgICAgICAgZGV2X2VycihkZXYsICJmYWlsZWQgdG8gZ2V0IGlycTogJWRcbiIsIGlycSk7DQo+
ICAgICAgICAgICAgICAgICAgcmV0dXJuIGlycTsNCj4gICAgICAgICAgfQ0KDQpUaGUgYnJhY2Vz
IHNob3VsZCBhbHNvIGJlIHJlbW92ZWQuIFdpdGggdGhhdCBhZGRyZXNzZWQsIHlvdSBjYW4gYWRk
Og0KDQpSZXZpZXdlZC1ieTogQ29kcmluIENpdWJvdGFyaXUgPGNvZHJpbi5jaXVib3Rhcml1QG1p
Y3JvY2hpcC5jb20+DQoNClRoYW5rcyENCg==
