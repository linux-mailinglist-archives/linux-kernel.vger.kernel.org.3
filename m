Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601304C8CF5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 14:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbiCANvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 08:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiCANvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 08:51:49 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE72DF7C;
        Tue,  1 Mar 2022 05:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646142666; x=1677678666;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=iLYKDmcif3c+cu4GBloAu3W2aNZ+/hzQTOjsVx83nOU=;
  b=aFh47xBtJ4d7Sk04TYR25SMv5P4wAaZYdTvxpixY3+BZZs4zmDu8/oOp
   x9HbkC0Z3YqQhtg4HnnMBktHe4iFBGADK5x/23V2/v+7aUPYCTVXI6wgk
   G5o2P1hUDAYZ4k0pcZGVBb7bnbmI5dpG+LpKiBLtPAzlAOTXpFoAiwLMC
   lj+Fa5+IHlaEnA4s5ssps4FTTEWT+Z0alNpa22Z1Vbbj/MIhfp2oos7a7
   /7g8fdn4FWhQHSUZphOMR+R4YprKudVg7O576R0gMfFkeJLFqhIXgFXnA
   c10giSgJVpyHK7CHGPjf+Tubu5zJXwu7tjhjkC8vept/pIrl/ckzRQBmQ
   A==;
X-IronPort-AV: E=Sophos;i="5.90,146,1643698800"; 
   d="scan'208";a="164037743"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Mar 2022 06:51:05 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 1 Mar 2022 06:51:05 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 1 Mar 2022 06:51:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQ4z9fM2AH5w+/f4I4E15W5xAZgyMo8kU9WcybtSQXPm+TnhPQ1/gNt9lPcw/1UpJ7JVVpv7mhg7RWg5ttodASfsCOJNGduzNKolIr6AxZQFdHqp6r54Jc6E7/VP/3r+UZCr5pKi73b6DDFbSl9YzPffleg5UhUQ5arpmkGAkjnnmar2Z1Bbuv2yRmtsVjLmsakDHyiawSdgRW/TZPhLYkXkxlQzw+7os/Qlp/x4Cs6AaUunoQtZVhLaFDjR09H8FMuVWgJqBIxHtkJsH//BGvtcfsHrbsyiwlgh3bCsHAAo+A/ZhpvRSj0ZcuODJNY9dg4N+Cq0B7c0O1bEczMjEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLYKDmcif3c+cu4GBloAu3W2aNZ+/hzQTOjsVx83nOU=;
 b=FJdj3At13wa7UBW7tR1HNyccT8m01EIOHxa58C/4Txuyv1YBqpnP254iv/VuDDMgUEg9bnluRHlmIkoErRL3a7tNSEtPQrLM+O9FVFuLfUXQ7OC5goO2YiBOEGzgREQ679cKgV0UdkG0ZBx66Fxal7k3038JuhujAl97ou6JuW6888LuQmTIY85rO1yHkesdN58+IdfkYbrbDOjdVQNNeAYemqL3nQsW0FRZwnJhr+7Ey/rq6m2LzkiaS3NVfzhclHyDV9fxHypMep8vOLiAiP1vUMYaBrPbvcFPGC9xC1NvSbqOXE7uS5nfoe0ryMoJ/ORmRm+WpszIpN5NyrFHlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLYKDmcif3c+cu4GBloAu3W2aNZ+/hzQTOjsVx83nOU=;
 b=F7fQettJqMdUpdtL/QTeZaetge2xo7QZCfh0Mf31iAInbarxviM6nQzA+K+X/Dk+zrKVTPX8ymVIuRKB96c+FT8VV1rIDOVSIpcz2ahJEgZnkjX74XCL0XH8areA8qJWINJ2iorgxmgutqw6T65iOTjlU5hA4QDzpOlk8x/9qvw=
Received: from BL1PR11MB5384.namprd11.prod.outlook.com (2603:10b6:208:311::14)
 by DM5PR11MB1451.namprd11.prod.outlook.com (2603:10b6:4:11::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Tue, 1 Mar
 2022 13:51:03 +0000
Received: from BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::11a5:42e0:3f3d:fcdc]) by BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::11a5:42e0:3f3d:fcdc%9]) with mapi id 15.20.5038.014; Tue, 1 Mar 2022
 13:51:02 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <linmq006@gmail.com>, <mchehab@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <hverkuil-cisco@xs4all.nl>,
        <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] media: atmel: atmel-isc: Fix PM disable depth
 imbalance in atmel_isc_probe
Thread-Topic: [PATCH v2] media: atmel: atmel-isc: Fix PM disable depth
 imbalance in atmel_isc_probe
Thread-Index: AQHYLTyv2eV9YsEfvUCD0pCSaw20wKyqjEgA
Date:   Tue, 1 Mar 2022 13:51:02 +0000
Message-ID: <4661c8c3-8975-d1f5-9728-f7d1d585437e@microchip.com>
References: <20220105111056.4662-1-linmq006@gmail.com>
 <20220301071859.24285-1-linmq006@gmail.com>
In-Reply-To: <20220301071859.24285-1-linmq006@gmail.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e993cbdd-7e40-4e56-8769-08d9fb8a865d
x-ms-traffictypediagnostic: DM5PR11MB1451:EE_
x-microsoft-antispam-prvs: <DM5PR11MB1451CDBF58598D211033FD19E8029@DM5PR11MB1451.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dycLAIr+kQ2Z9x/aCuANIuvxXW1mQewZtnq1da6o21qRVCKVRkvKOmJqsL1nvd0VfUmxak/BQNPLt5HVUC1hOMqs1V8/wQ7q1yugGRnPfaVGmABil2uSwobQODHam6XRzK1z24KT6ENstxZK9jeRg+kFd30BfJ93LIYYe/4Nv6f/aRYyLAdwIRalUu1MT/rOdxQIrcxRt1bzdVFoAzGGskD9AI9RlqOyC74poTZwcoLsT/rRrWgP9btSpXW06U3JQqtBsF5BSNIGD+8+r4mC+TM+lT3yrr7EQkXhKIaeFAMlh+fBUz5A7hURhTsDX5DVYvXj1/cpm2aCYSBa/PB5a0A9tlrSemjyrQQMeF+9zMufOxQjLHpfHdeL4cshHsw8WGMoYrxidP6U4HQqYsPNRR9hf5vLs0jlOfN/+CkqvOVU3nEEJJZ8t1K7fbfgGOFuKVaKlMAhE2nJLYEATDhIy6qxcsBiPGlc51yfApjWn1aJCvFm1jZV5FriJSCbfMTJ10Z3/8ui3v1Dtgkw8RXx0+EqMJLlrl5t/XttlBpVd4emjFuAB8W6dzQsDqqDQ9OmneXhIVl2f33u2nBFKEE5Gz6hO1opfy8nwplWczZixCOwUT+HMVbKPPsZJQE41BGmeAMnlyTG2Un/Jmy4MZ0nOFyfLwQsVJj7kkxkx+qNcZzTRi8x16BxRnIueUghG+aBbXvVj7vheHsR8Xf13sMF1SZf3mWNdcqiAff2kzL3WJ6LGPYW9sAnfD3oOWCj1y7dCSiujmbpnG9Dv9SnAA4Cxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5384.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(8936002)(6512007)(71200400001)(66446008)(91956017)(31696002)(86362001)(76116006)(66946007)(66476007)(6486002)(8676002)(66556008)(64756008)(508600001)(5660300002)(6506007)(53546011)(38070700005)(186003)(38100700002)(110136005)(26005)(36756003)(2906002)(31686004)(2616005)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHNtNytsamlYVC94akZTdmtkZkJvSFNlajA2L1BKRTM3eG5vbEF2WkZpcExy?=
 =?utf-8?B?MFY2SHdtb2poVjNncFMzWmplMldyY3FhY0NyOVdrYmhxSy90QzV4S3IzQm5W?=
 =?utf-8?B?M1crYmQwWjJoTENHQUgwdU82U2w5TkJkQ0U2eSsyYTFGTFVzRW4wWDljUEYy?=
 =?utf-8?B?RmwxWFpxVnhDSHdnVkR2Rjc0cmJ2eFg1SE9BZVhKb0ZEazA2N2hCMDNKS2NG?=
 =?utf-8?B?UFc4aVVRTEQxeXBKUC9NZjVwT2tNVEpwcEpJa01ScEJYQlBhcEpjMkhNczhD?=
 =?utf-8?B?akY0VmkzU1Nxa1JWVE1aclppeVJ0dzQveEdaV3R6RDhRRSs1NWZPSlVWZXZo?=
 =?utf-8?B?Yk1uUzFBT0hOMzNWZ0FCSWVqK2pYeGEreUg5VUYya3ZXMGdXUEZ5N0V5M2lL?=
 =?utf-8?B?OXJ1LzBIV1lxdVRaZHBLUHpPd3AyUWg1cWxFL3NEeGs2TEoreE0weHhpYTBG?=
 =?utf-8?B?SVQ4ZnUzU0Fzb1RGVHdYdGQyM3U5aXhlYjZONmtqOEhJWUxTZ2tXMyt2WkNC?=
 =?utf-8?B?QWpkWFp5ZExYakVaWC95Mmt5aVF5TElSQm50aHBCS0YxbFpCZ1VLazA4RzVF?=
 =?utf-8?B?bWhvLzd1aWRwNDZONEhXalozU2Y5NHQ0SUxXZzZqd1NwQTBOL0RGV0dFREEv?=
 =?utf-8?B?RndzOGx6cUU1aGVSeGtXZGplNlNHTG1MSjJoNU04OUtZN09sRzlvSzhWcFVF?=
 =?utf-8?B?T1dEK2FoL3pLQXVqY3FoQlFhOW9IV2pvK0lLOG1FdW5MTUJwNGNlZXFHajlu?=
 =?utf-8?B?eHNYOFpTa0ZMd01manp1L2dEMkFaYjJNTlBUWkg4ZDZPVHh4NEhQY2ZUay92?=
 =?utf-8?B?dGN1SE1KOWJTSGd3SDYzdkcycUltSWM3TEtKWlZSMWE1MURGbEk2TW9ZeEFv?=
 =?utf-8?B?bkhQR2tjMktMRnV5aVVIRlYyMFhmeTFNRW9hc0NwZWFTM0EvTC9tQUlZWTdm?=
 =?utf-8?B?SHdEdXJYR2dpSnlWV2t1VWZDUW4yTEEvV1lnSW10MjdoS21BWmp0ZUJOR0F3?=
 =?utf-8?B?UWJ6MUpsOE1td0FrdXkzUWNtY08rd0VqWkE2UEsrZVVFVG1kV2I3TmlyQzVz?=
 =?utf-8?B?VnNwZkxZSnFCVFFwSFNISGdGNk1oRGhZczNVaHJRNUpNeWlPQmg5dzBxMnFh?=
 =?utf-8?B?aG1rOSt3R0lsK2Jhd1RuQVUvYXVUMDJDb3dqWUhsT0srYlg4VXQ1WUIyOTY0?=
 =?utf-8?B?NENhTG5kODYwN2pBQXJ2MU93LzRQUlVJR1ZJbklvUVVTQzY0MTBvN1JTWUhx?=
 =?utf-8?B?b2lLUm8wN0tLS0dBbGttMGtSTWxaMDEwaGNSYUNiRllRQlpPelA1Nkg3VXBV?=
 =?utf-8?B?K0xJWGxCM3lpNUtsdy9SR3VxaHBqaS9sdm0xL203Y2E3bmR4U0RDbWYrcURu?=
 =?utf-8?B?ckVXK0lrRS81MU5FMHg4VUpheld6Q1NIOUhVbUZ5RG94M0EwajltNldhNVpX?=
 =?utf-8?B?cG9La3lUc2Zod21TcGtsYVV0UzVrYnhMbUd3U1Fub3F2bDl0ZHU3eVI3MnI1?=
 =?utf-8?B?MXV3elhFeDREbXZqb1cyZWcvWEtZbXJLV2g2NG10UXZvODJXSVpOODcwdDU2?=
 =?utf-8?B?ZW1jT3g0dUFmU0VFaHFaWjJwSXA4bnVNZmhDbmJwV2FRMWN0TW5aQUFaWWtR?=
 =?utf-8?B?RDU0SGdSWXV1UWszRGdsYlVWWE9XTzljc0tZQ0xVWGF3bXlmQ3p3blpRUHcv?=
 =?utf-8?B?bU16MzB1ajIweThZZCtkN05xa3FaTk9VTllmZHU0Rmo5TEhieEpCWlJ4bjM4?=
 =?utf-8?B?TEh1Z2NXclJBc09aNDNLb3N6ZDdHcWtWSXRsODBiYlFrenRZSk9JaGwxbGpD?=
 =?utf-8?B?NGEyNlJvcFJKWEo3K1NOQXV0VC9nSHVuNURnRkZFV20ycWlrdUlIOXVlR3BV?=
 =?utf-8?B?Qko3RXBIVzIvUXQycnJxbkpPZTllRkhUV2lZUmJEalpsNm9XaDVFOU1UNkti?=
 =?utf-8?B?YkxjeW9HQnNCQjZOR21BOTIzQm9EcWdxa21mckZWakxVbDJIdzEyd0E1MnR1?=
 =?utf-8?B?endJYTVBK3dLY3pzbzdEOE9OUnJUNzh3TFpnZ3B4azhIMVVKR3h6K09UcFR3?=
 =?utf-8?B?bXdXdXpSbkR3LzJ3RGNHeEx0c3RPMmRHZ3ZHcVFyRk5vK2JCTXNqZzA4cUhV?=
 =?utf-8?B?U0IrY3RIM3NJNmVObnFtZmVQR3pjd3ZoMnM0WER4ZVMwWTJYTDdLUSt2eWU4?=
 =?utf-8?B?ZitMd0tmdmQrcjhMSDZkVTFQR0hlOTZLLzlqREdqSEwvandOcjcxNkt1bi83?=
 =?utf-8?B?NzdlNE5QWFp4dllGckpyamIzRzlnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <081DFDBDC635ED42974B090937032BCE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5384.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e993cbdd-7e40-4e56-8769-08d9fb8a865d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 13:51:02.7502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hstIabNjFu1Y/7yHOZcknVtHfXSrRQhFuitCUetKxlDTp2aDNL6d+B8yaH7DqzW7ZeuErdsTbhO+1HjA3a6dhcLkRssahR77Rrhvm2o5Jc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1451
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8xLzIyIDk6MTggQU0sIE1pYW9xaWFuIExpbiB3cm90ZToNCj4gVGhlIHBtX3J1bnRpbWVf
ZW5hYmxlIHdpbGwgaW5jcmVhc2UgcG93ZXIgZGlzYWJsZSBkZXB0aC4NCj4gSWYgdGhlIHByb2Jl
IGZhaWxzLCB3ZSBzaG91bGQgdXNlIHBtX3J1bnRpbWVfZGlzYWJsZSgpIHRvIGJhbGFuY2UNCj4g
cG1fcnVudGltZV9lbmFibGUoKS4NCj4gDQo+IEZpeGVzOiAwYTBlMjY1ICgibWVkaWE6IGF0bWVs
OiBhdG1lbC1pc2M6IHNwbGl0IGRyaXZlciBpbnRvIGRyaXZlciBiYXNlIGFuZCBpc2MiKQ0KPiBT
aWduZWQtb2ZmLWJ5OiBNaWFvcWlhbiBMaW4gPGxpbm1xMDA2QGdtYWlsLmNvbT4NCj4gLS0tDQo+
IGNoYW5nZXMgaW4gdjI6DQo+IC0gcmVtb3ZlIHVudXNlZCBsYWJlbC4NCj4gLS0tDQo+ICAgZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1lbC1zYW1hNWQyLWlzYy5jIHwgMiArKw0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLXNhbWE1ZDItaXNjLmMgYi9kcml2ZXJzL21l
ZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLXNhbWE1ZDItaXNjLmMNCj4gaW5kZXggMWIyMDYzY2Nl
MGY3Li43ZjFlYmJiMjU0MzcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0v
YXRtZWwvYXRtZWwtc2FtYTVkMi1pc2MuYw0KPiArKysgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3Jt
L2F0bWVsL2F0bWVsLXNhbWE1ZDItaXNjLmMNCj4gQEAgLTU1OSw2ICs1NTksOCBAQCBzdGF0aWMg
aW50IGF0bWVsX2lzY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgIGNs
ZWFudXBfc3ViZGV2Og0KPiAgICAgICAgICBpc2Nfc3ViZGV2X2NsZWFudXAoaXNjKTsNCj4gDQo+
ICsgICAgICAgcG1fcnVudGltZV9kaXNhYmxlKGRldik7DQo+ICsNCg0KSGVsbG8gTWlhb3FpYW4g
TGluICwNCg0KQ291bGQgeW91IHBsZWFzZSBwZXJmb3JtIHRoZSBzYW1lIGNoYW5nZSAob3Igc2lt
aWxhcikgaW4gDQphdG1lbC1zYW1hN2c1LWlzYyAsIGFzIHRoZSBzYW1hN2c1IElTQyB3aWxsIHBl
cmZvcm0gdGhlIHNhbWUgYW5kIGhhcyB0aGUgDQpzYW1lIGJ1Zy4NCg0KVGhhbmsgeW91IGZvciB0
aGUgcGF0Y2gsDQpFdWdlbg0KDQo+ICAgdW5yZWdpc3Rlcl92NGwyX2RldmljZToNCj4gICAgICAg
ICAgdjRsMl9kZXZpY2VfdW5yZWdpc3RlcigmaXNjLT52NGwyX2Rldik7DQo+IA0KPiAtLQ0KPiAy
LjE3LjENCj4gDQoNCg==
