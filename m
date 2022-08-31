Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B365A83F9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiHaREC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHaRD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:03:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BED3B49;
        Wed, 31 Aug 2022 10:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661965436; x=1693501436;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Zhr1IOEE1Uwxo26lV/4RnhIlALPcI5Ls3AbciC4Mx/w=;
  b=xxzBDIRO0pmgoD8n3lA/5GHMlJKs+dYS2DXppgdI+RrYZ+gU3H3+nz6G
   QKQ4FJtrmlBk8LlH4vZbK8f3uF/BP/aTipogloygyB4MD1pA7Pqp56dml
   LPMMf+JQWVKj7KRXQMa/zgi7Q1xC/wuGBVsGI6xPERwagbw/t8oaboMbw
   uArAvdPPzmMDx8yZeLwlG11LzSLvgZ+iCoaBc6AWRcpARpT2Un5MRyYzA
   tZEDbZoKEHRe4r3ZsBviNOxKjseOvM53928sPKbCXBiQL75ZPxUk/mcZ6
   q8jHp46pj2EXgEFIQwqc0B1F0wlviH9/UnvzT3KiGA3ScxcDYdQdG+M3Z
   w==;
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="171818486"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Aug 2022 10:03:55 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 31 Aug 2022 10:03:55 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 31 Aug 2022 10:03:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOIRr13AHLYAMF823YCU04QP5h8Z8zLQP+a381j7klVYv1+Sr0/jOJM5a55kSN45YM1oIcHF91QrFvF1l+5PESVH8XHfPSsXzUcF7fcQAEGc9lit7vzutVK21PsIXqKCwPJcVgQIViiCkPwIp2+7JOU5R3eSe5HgvKHHFkm6uLoemvxRc2j611XD60xszmDpZTr4EAX+rTZxmpBPdDR4TMtQWPy/V0EBwqjSziJU5zaRVKLFAlMlZFswh7/oRPF4F6CeyQKS/DzD6PlMNXSSdTwZ53JFEySQKfc2l7tsHC/YNwJxbBXrWGsMbVOMT2bhSABSwwNsY2ClTBd7WyK0ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zhr1IOEE1Uwxo26lV/4RnhIlALPcI5Ls3AbciC4Mx/w=;
 b=E7i/sB7Z/HBBgexFXI6dEwvssPfF/xiXF846smKkJKuBltC6ZLc8e8AvYTA9J9wfYeSkQ8lXlk9RUOfBQQkwwtlzCimigVyK05h2u5FzjECFS1wbEWSVp8DsOPnkLiMq+doITbYJv+x0BnAAwE/QzAl232Dtl1e2RsCmmxVNPWKs4rQjtCu5+lBUBc7SU74TkUspVTC8kYwYpZNy5R7zssfzLB0GiVdIHBvToKTtwNz4An6tXGnJMZYXJxtRwAjDHNKCAw8weue7hlHgyAGc1hwWOkKIV70fRx41Ac5LsyWG92aLr6AptAFbZKRAMKEg600hrdN9yLsP4JOy9JQWsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zhr1IOEE1Uwxo26lV/4RnhIlALPcI5Ls3AbciC4Mx/w=;
 b=l5r3SrQaAcB+Fm+/QZiCYHUOvZGFM1hRVvdJKBqJeiGyIDNBXBWdQb7gSL87sG/F6FOvww5ufVMxo1Zy+o+WL5oWsDhoiOAWS+CiEoW2LD7pCMIP9ZmykbIswKyqLfizYej+9TyQLIZk8iWb1dNpZUFBSGYi8Mit2psmPQCDiVQ=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SJ0PR11MB5581.namprd11.prod.outlook.com (2603:10b6:a03:305::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 17:03:53 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 17:03:53 +0000
From:   <Conor.Dooley@microchip.com>
To:     <sboyd@kernel.org>, <Daire.McNamara@microchip.com>
CC:     <paul.walmsley@sifive.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <mturquette@baylibre.com>,
        <Claudiu.Beznea@microchip.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <nathan@kernel.org>
Subject: Re: [PATCH v4 01/13] clk: microchip: mpfs: fix clk_cfg array bounds
 violation
Thread-Topic: [PATCH v4 01/13] clk: microchip: mpfs: fix clk_cfg array bounds
 violation
Thread-Index: AQHYvG98o22tTG+7mU6lxnNYP43gca3JPmyA
Date:   Wed, 31 Aug 2022 17:03:53 +0000
Message-ID: <a0bcd9fb-d79f-c774-29f9-9fd184827b98@microchip.com>
References: <20220830125110.2372514-1-conor.dooley@microchip.com>
 <20220830125249.2373416-1-conor.dooley@microchip.com>
In-Reply-To: <20220830125249.2373416-1-conor.dooley@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 282c8a35-a455-451e-5be2-08da8b72c8a4
x-ms-traffictypediagnostic: SJ0PR11MB5581:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QvHHztrtcSPRvxEnTI+IMq4FZAr0Dru29odj5D/iwTxJGyy3YMroqr3UAJFvY3Bhm3nY4OFx3a+T9VgplPkIqmSOXC0+DvBrW3PMipcTNPwXRvb1BD5v2InvhEDLq5rLC2rgQAK1lCiTUlRzO6EEgiRmiVPSYIi0V2Dy24JlozbtxyiBuclsJqWQY4dZLrUrxwdw/V08qYsHcxtAqTkO1LfqFSYx+m1dsrPd8nUAzzU6r5oVCWiyP1fZUFqApY18bxjQJfYFSkrwBquywPcKW/4eFbRv8SUnIywMJMesLesMi7RshmM4czOHDIkXQ88l/DLZoeqVVnTScxidhu5CBV8N99Pi6/EeZyvHC5CRcQ5nvJr1uoTuLDAgxaxKXHhIX6pOHDJj9LMbIqRBpm+Bk+K1/p6MxhJRF68K5FsVT/kKwmYXekuBoIBG338ROQu1Q6KlieSMcHXF+JkToif/lGw+rQt66j0tWlTBvYmAbiWo2Lg36wgl8CzxTyNCTEUk8Gcy5KiII6oPLX68KW77IXGdbd6RB6SoAYmjR+t8tq+a9W8Flk7xhVs0dxDseqvhqDFXX3eLLjTCo774mLlnCdorWoA2S9Hm1J1YoTA9ZJAJ3qIVDyfXa1e4d8gOs7K5IenGTxDiOTIbANC5ORZRYb3XeaUeaiV6+jgbwen8/IdFaE/15ReDnMFUX9FOopUmQ+8a/WCgykQSI7mpmZ434816SkXSzHZKE2rq/gMo/q6hAAf2CdTaC8Vzpeq5b7luJk8FQnbu7FmOaNZ0aKShZrlkb2AJLwv/hiNffRkwAldNaCGFUEkuJJu1XHX4JUTT+YY2e6LYfo/LwlGwO659Pw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(376002)(346002)(366004)(396003)(4326008)(64756008)(8676002)(478600001)(6486002)(66446008)(66476007)(91956017)(66556008)(66946007)(76116006)(2616005)(53546011)(86362001)(31696002)(2906002)(6512007)(26005)(38070700005)(6506007)(8936002)(41300700001)(45080400002)(5660300002)(7416002)(83380400001)(38100700002)(316002)(6636002)(186003)(71200400001)(54906003)(36756003)(110136005)(122000001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1BRU1RXbDhHVnNmTE01UVRuaktCUld1d0ZUUnRYakJ0RnZkYmhyWnNMMDgr?=
 =?utf-8?B?MjFyZ1ZpL2FhUnlTTnU4RCsweW44V3UzWC9JZVFEVjdYS09mWE4xdDQ2STdM?=
 =?utf-8?B?UUZ2UWcvMmRoVUFrajBPcWFaT1lKNy95QVF3cGF5MFIxRzdCdXpDUEM4S3Vx?=
 =?utf-8?B?QkxTQUdubTYzYk92bFhtNW94QWJZbUlGMG9ETUlDVUVIYUcvY3B4SXRjMVdF?=
 =?utf-8?B?MTZaR1RtSStjL1NHRDlhV1FXY0sxaXE2OVFYTUpYeE9XajhtelNRNnA0ZHU1?=
 =?utf-8?B?UHVYYWZBNUdtUmdOODNISnozYnpWbGx2dER4VDNQOHA5L0Z5UE91bkkvWEpo?=
 =?utf-8?B?NHliUHUwNDRIV3RibzlEWjJZcUdyWHNhMEZxbkg4NC9NMEplQnp3aHVrWFNJ?=
 =?utf-8?B?MWVMbVZtM0JRMnhtaEwzZzNrMng3NmMrTVNVRXp4eVNhdHIvZDJIcGpnSlFv?=
 =?utf-8?B?Z0JBblZQM29aZlZyd0xiL2J6Z0REaTBOTUhnUDNyMUVzNlFNcW1sdEJRQVNh?=
 =?utf-8?B?a1Z6ekJPRC9aODEycVh3TktWQlZhbVp1VlRvcStJcnFaaHF4RGJnS0E0akNQ?=
 =?utf-8?B?ZlQ2R3hQY1pFdkQ0QWNOcys1ckxRcm5FeFFlS21KVUpLUTZPdVo5dGk1dFNv?=
 =?utf-8?B?QTh3aklZS2dxL2JtUUV2S1M2WllEQk1pOTFVeUpXeGxId2RNWEdhREJmRWwx?=
 =?utf-8?B?T1h0Y3R2eC9qdzVNZVkxWm1XRVJQSkwra0NuZ243c2xacXpmMUlNRWZwSHFm?=
 =?utf-8?B?VTBmRXg3WGMyT3E4akZEU2xidmFlVDhGeE14bnFML21iZHlhUzdvb3ZOdVBM?=
 =?utf-8?B?RnZGVUJUS2E3Ylk3MnVrWHhsTWRENjlnbXQ0TWFZeHZOMGQrV2J4QmFTek80?=
 =?utf-8?B?ZnE0MXNENnY4dlQ3bVpobGh1UGFSVURWaXN5U2NrdzdpcERscEtKRXpQM0VE?=
 =?utf-8?B?YWk0NlFxSGZUZDRYeFZxYUZuVjVydmIxT2pCcGlMYmQwNm9NYmtia2FtNFMz?=
 =?utf-8?B?cU5wbDJCcUFuUGRib3BSQ1RWaVl1SlFleEdkenVhR3dkMXRNMXcwdXNBcGVu?=
 =?utf-8?B?MFMwNGl4NlZITzNJNkt1WGRQVWtWVnlDZVptOW9kRktjYy9qMzZGeUdSU0NG?=
 =?utf-8?B?RmluQmxHWXVvL2VvK094dWZSVnVWc3lMQkhvSFhnc2dTRjFDVERqQ2dYUDhm?=
 =?utf-8?B?TVdqbTZFV0kwbXU1Y256R3JhQktnWE1SaHlnazkrNGNadDk4Sk0xTmhwVDhs?=
 =?utf-8?B?cnJRL3QwczNPa1pTNTdCWlZwbjdsUGg2RGJGbmkwTzIxd3JodzBBSlNJWUd3?=
 =?utf-8?B?R0hZMXdwUWR2VXNxVDhIdWt1MUFJdnZoYXF2MHZxMUVpN1A1RnhwKzdVQWNk?=
 =?utf-8?B?RDk5SHorWFJRckRDL0UzVzdhSVNQdWprd3BwdFdHS1NIejdHQzRyeE9RUEdB?=
 =?utf-8?B?Q1VNWEFSVEhwQTBhYnRwRk5FalZ1Vmpoa2ZUY1NWWWxwSWJrTnYveUhtNitI?=
 =?utf-8?B?ZjFqWDc2WHRPaEJ3ak9VYXhZS2gzZytZNGI2dTZ6N25NaTFQNUhnczNHY1A1?=
 =?utf-8?B?UlQ1cUZvdkZwVS8wSTJlakhYUmpZanlybDg2K21NK2VGQk16RmRNaTFhZ1ZJ?=
 =?utf-8?B?ZVk3bmJJWGZKN1dzb05xTjJWakkwV3ZDUXZCZml5OVpFSlp5aHFBUzZIQmpL?=
 =?utf-8?B?TlR5TnZnaUlzMGVFUFpHU3A4T2tOU3YxOHpuWU56MDAxbnZ6WjNlcTh1SUx2?=
 =?utf-8?B?L25DUjdDdXZDbEFnRzBGZGs0ZkkydUl6d2s2cGtqWkF3RGs4cmI4MWw2SHRL?=
 =?utf-8?B?UXloRXB1TDVrdzIxU3p3ZzZsR09ybmt6ZjIzNmhpc1dWMnpBVlVyK2dEclN2?=
 =?utf-8?B?bFFsSFdzbVF4ZEtKK0c1Vk5mYU5mbDAxVzNmdmdUUFZyTlFpQkFUSGl3REtK?=
 =?utf-8?B?N0VtNEJRdmNJZnFxaXFzS3VoQXE2eVhibHRFT05kMzY3SGszTDI2SmR2akY0?=
 =?utf-8?B?VnQ5UXJjMkpDOFEwaDFQSGJUaFJOemZhMVpUbmR6QksvbXllRmM2bnJYSG1l?=
 =?utf-8?B?bmRvNlN2RjFybnZ3K2NrZlFVK3YyTTFCSmhZZi9FazdxMHpOTG1zNDNud0gz?=
 =?utf-8?B?TnJQVjZJSjRjYnRndjl3dVNZQ09OalNTbmVlUkFYZmZmdUlwTHBOaDhFY0VL?=
 =?utf-8?B?MXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26DCBF8240DF104BA3D28883A309993F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 282c8a35-a455-451e-5be2-08da8b72c8a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 17:03:53.4468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ku228HRdmMOf9NGIyKdJpGEDyBCJ3Fllz0oo1rBH5+XgG2yrKETSkXcm+lAvhGE+QRgen+bQIxM6xI0UgzHDFrA21NArkARPQ3wviJ+dszk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5581
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IFN0ZXBoZW4sDQoNCk9uIDMwLzA4LzIwMjIgMTM6NTIsIENvbm9yIERvb2xleSB3cm90ZToN
Cj4gVW5ub3RpY2VkIGluIGN1cnJlbnQgY29kZSwgdGhlcmUgaXMgYW4gYXJyYXkgYm91bmRzIHZp
b2xhdGlvbiBwcmVzZW50DQoNCkxvb2tzIGxpa2UgdGhlICJVbm5vdGljZWQgaW4gY3VycmVudCBj
b2RlIiBpcyBub3QgYWNjdXJhdGUuIEZvciBjZXJ0YWluDQpjb21waWxlci9rZXJuZWwgdmVyc2lv
biBjb21iaW5hdGlvbnMgdGhhdCBjYW4gYmUgdHJpZ2dlcmVkIHdpdGhvdXQgdGhlDQpyZXN0IG9m
IHRoZSBwYXRjaHNldC4gQXBwYXJlbnRseSB0aGUgZGVmYXVsdCB5b2N0byBnY2MgdXNlZCBieSBv
dXIgQlNQICYNCnY2LjAtcmNOIGRvZXMgdGhlIHRyaWNrLi4uDQoNCkNvdWxkIHlvdSB0YWtlIHRo
aXMgb25lIHBhdGNoIG9udG8gY2xrLWZpeGVzIG9yIHdvdWxkIHlvdSBsaWtlIG1lIHRvDQpyZXNl
bmQgaW5kaXZpZHVhbGx5Pw0KDQpUaGFua3MsDQpDb25vci4NCg0KPiBkdXJpbmcgY2xvY2sgcmVn
aXN0cmF0aW9uLiBUaGlzIHNlZW1zIHRvIGZhaWwgZ3JhY2VmdWxseSBpbiB2Ni4wLXJjMSwNCj4g
YW5kIGxpZmUgY2FycnlzIG9uLiBXaGlsZSBjb252ZXJ0aW5nIHRoZSBkcml2ZXIgdG8gdXNlIHN0
YW5kYXJkIGNsb2NrDQo+IHN0cnVjdHMvb3BzLCBrZXJuZWwgcGFuaWNzIHdlcmUgc2VlbiBkdXJp
bmcgYm9vdCB3aGVuIGJ1aWx0IHdpdGggY2xhbmc6DQo+IA0KPiBbICAgIDAuNTgxNzU0XSBVbmFi
bGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQgdmlydHVhbCBh
ZGRyZXNzIDAwMDAwMDAwMDAwMDAwYjENCj4gWyAgICAwLjU5MTUyMF0gT29wcyBbIzFdDQo+IFsg
ICAgMC41OTQwNDVdIE1vZHVsZXMgbGlua2VkIGluOg0KPiBbICAgIDAuNTk3NDM1XSBDUFU6IDAg
UElEOiAxIENvbW06IHN3YXBwZXIvMCBOb3QgdGFpbnRlZCA2LjAuMC1yYzEtMDAwMTEtZzhlMTQ1
OWNmNGVjYSAjMQ0KPiBbICAgIDAuNjA2MTg4XSBIYXJkd2FyZSBuYW1lOiBNaWNyb2NoaXAgUG9s
YXJGaXJlLVNvQyBJY2ljbGUgS2l0IChEVCkNCj4gWyAgICAwLjYxMzAxMl0gZXBjIDogX19jbGtf
cmVnaXN0ZXIrMHg0YTYvMHg4NWMNCj4gWyAgICAwLjYxNzc1OV0gIHJhIDogX19jbGtfcmVnaXN0
ZXIrMHg0OWUvMHg4NWMNCj4gWyAgICAwLjYyMjQ4OV0gZXBjIDogZmZmZmZmZmY4MDNmYWY3YyBy
YSA6IGZmZmZmZmZmODAzZmFmNzQgc3AgOiBmZmZmZmZjODA0MDBiNzIwDQo+IFsgICAgMC42MzA0
NjZdICBncCA6IGZmZmZmZmZmODEwZTkzZjggdHAgOiBmZmZmZmZlNzdmZTYwMDAwIHQwIDogZmZm
ZmZmZTc3ZmZiMzgwMA0KPiBbICAgIDAuNjM4NDQzXSAgdDEgOiAwMDAwMDAwMDAwMDAwMDBhIHQy
IDogZmZmZmZmZmZmZmZmZmZmZiBzMCA6IGZmZmZmZmM4MDQwMGI3YzANCj4gWyAgICAwLjY0NjQy
MF0gIHMxIDogMDAwMDAwMDAwMDAwMDAwMSBhMCA6IDAwMDAwMDAwMDAwMDAwMDEgYTEgOiAwMDAw
MDAwMDAwMDAwMDAwDQo+IFsgICAgMC42NTQzOTZdICBhMiA6IDAwMDAwMDAwMDAwMDAwMDEgYTMg
OiAwMDAwMDAwMDAwMDAwMDAwIGE0IDogMDAwMDAwMDAwMDAwMDAwMA0KPiBbICAgIDAuNjYyMzcz
XSAgYTUgOiBmZmZmZmZmZjgwM2E1ODEwIGE2IDogMDAwMDAwMDIwMDAwMDAyMiBhNyA6IDAwMDAw
MDAwMDAwMDAwMDYNCj4gWyAgICAwLjY3MDM1MF0gIHMyIDogZmZmZmZmZmY4MTA5OWQ0OCBzMyA6
IGZmZmZmZmZmODBkNmUyOGUgczQgOiAwMDAwMDAwMDAwMDAwMDI4DQo+IFsgICAgMC42NzgzMjdd
ICBzNSA6IGZmZmZmZmZmODEwZWQzYzggczYgOiBmZmZmZmZmZjgxMGVkM2QwIHM3IDogZmZmZmZm
ZTc3ZmZiYzEwMA0KPiBbICAgIDAuNjg2MzA0XSAgczggOiBmZmZmZmZlNzdmZmIxNTQwIHM5IDog
ZmZmZmZmZTc3ZmZiMTU0MCBzMTA6IDAwMDAwMDAwMDAwMDAwMDgNCj4gWyAgICAwLjY5NDI4MV0g
IHMxMTogMDAwMDAwMDAwMDAwMDAwMCB0MyA6IDAwMDAwMDAwMDAwMDAwYzYgdDQgOiAwMDAwMDAw
MDAwMDAwMDA3DQo+IFsgICAgMC43MDIyNThdICB0NSA6IGZmZmZmZmZmODEwYzc4YzAgdDYgOiBm
ZmZmZmZlNzdmZjg4Y2QwDQo+IFsgICAgMC43MDgxMjVdIHN0YXR1czogMDAwMDAwMDIwMDAwMDEy
MCBiYWRhZGRyOiAwMDAwMDAwMDAwMDAwMGIxIGNhdXNlOiAwMDAwMDAwMDAwMDAwMDBkDQo+IFsg
ICAgMC43MTY4NjldIFs8ZmZmZmZmZmY4MDNmYjg5Mj5dIGRldm1fY2xrX2h3X3JlZ2lzdGVyKzB4
NjIvMHhhYQ0KPiBbICAgIDAuNzIzNDIwXSBbPGZmZmZmZmZmODA0MDM0MTI+XSBtcGZzX2Nsa19w
cm9iZSsweDFlMC8weDI0NA0KPiANCj4gSXQgZmFpbHMgb24gImNsa19wZXJpcGhfdGltZXIiIC0g
d2hpY2ggdXNlcyBhIGRpZmZlcmVudCBwYXJlbnQsIHRoYXQgaXQNCj4gdHJpZXMgdG8gZmluZCB1
c2luZyB0aGUgbWFjcm86DQo+IFwjZGVmaW5lIFBBUkVOVF9DTEsoUEFSRU5UKSAoJm1wZnNfY2Zn
X2Nsa3NbQ0xLXyMjUEFSRU5UXS5jZmcuaHcpDQo+IA0KPiBJZiBwYXJlbnQgaXMgUlRDUkVGLCBz
byB0aGUgbWFjcm8gYmVjb21lczogJm1wZnNfY2ZnX2Nsa3NbMzNdLmNmZy5odw0KPiB3aGljaCBp
cyB3ZWxsIGJleW9uZCB0aGUgZW5kIG9mIHRoZSBhcnJheS4gQW1hemluZ2x5LCBidWlsZHMgd2l0
aCBHQ0MNCj4gMTEuMSBzZWUgbm8gcHJvYmxlbSBoZXJlLCBib290aW5nIGNvcnJlY3RseSBhbmQg
aG9va2luZyB0aGUgcGFyZW50IHVwDQo+IGV0Yy4gQnVpbGRzIHdpdGggY2xhbmctMTUgZG8gbm90
LCB3aXRoIHRoZSBhYm92ZSBwYW5pYy4NCj4gDQo+IERyb3AgdGhlIG1hY3JvIGZvciB0aGUgUlRD
UkVGIGFuZCB1c2UgdGhlIGFycmF5IGRpcmVjdGx5IHRvIGF2b2lkIHRoZQ0KPiBwYW5pYywgdXNp
bmcgYSBuZXdseSBhZGRlZCBkZWZpbmUgdGhhdCBicmluZ3MgdGhlIGluZGV4IGludG8gdGhlIHZh
bGlkDQo+IHJhbmdlLg0KPiANCj4gRml4ZXM6IDFjNmE3ZWEzMmI4YyAoImNsazogbWljcm9jaGlw
OiBtcGZzOiBhZGQgUlRDUkVGIGNsb2NrIGNvbnRyb2wiKQ0KPiBDQzogTmF0aGFuIENoYW5jZWxs
b3IgPG5hdGhhbkBrZXJuZWwub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBDb25vciBEb29sZXkgPGNv
bm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvY2xrL21pY3JvY2hp
cC9jbGstbXBmcy5jIHwgNSArKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21pY3JvY2hp
cC9jbGstbXBmcy5jIGIvZHJpdmVycy9jbGsvbWljcm9jaGlwL2Nsay1tcGZzLmMNCj4gaW5kZXgg
MDcwYzNiODk2NTU5Li45ZTQxZjA3YjNmYTYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xrL21p
Y3JvY2hpcC9jbGstbXBmcy5jDQo+ICsrKyBiL2RyaXZlcnMvY2xrL21pY3JvY2hpcC9jbGstbXBm
cy5jDQo+IEBAIC0yNyw2ICsyNyw4IEBADQo+ICAjZGVmaW5lIE1TU1BMTF9QT1NURElWX1dJRFRI
CTB4MDd1DQo+ICAjZGVmaW5lIE1TU1BMTF9GSVhFRF9ESVYJNHUNCj4gIA0KPiArI2RlZmluZSBS
VENSRUZfT0ZGU0VUCQkoQ0xLX1JUQ1JFRiAtIENMS19FTlZNKQ0KPiArDQo+ICBzdHJ1Y3QgbXBm
c19jbG9ja19kYXRhIHsNCj4gIAl2b2lkIF9faW9tZW0gKmJhc2U7DQo+ICAJdm9pZCBfX2lvbWVt
ICptc3NwbGxfYmFzZTsNCj4gQEAgLTM4MSw3ICszODMsOCBAQCBzdGF0aWMgc3RydWN0IG1wZnNf
cGVyaXBoX2h3X2Nsb2NrIG1wZnNfcGVyaXBoX2Nsa3NbXSA9IHsNCj4gIAlDTEtfUEVSSVBIKENM
S19NQUMwLCAiY2xrX3BlcmlwaF9tYWMwIiwgUEFSRU5UX0NMSyhBSEIpLCAxLCAwKSwNCj4gIAlD
TEtfUEVSSVBIKENMS19NQUMxLCAiY2xrX3BlcmlwaF9tYWMxIiwgUEFSRU5UX0NMSyhBSEIpLCAy
LCAwKSwNCj4gIAlDTEtfUEVSSVBIKENMS19NTUMsICJjbGtfcGVyaXBoX21tYyIsIFBBUkVOVF9D
TEsoQUhCKSwgMywgMCksDQo+IC0JQ0xLX1BFUklQSChDTEtfVElNRVIsICJjbGtfcGVyaXBoX3Rp
bWVyIiwgUEFSRU5UX0NMSyhSVENSRUYpLCA0LCAwKSwNCj4gKwlDTEtfUEVSSVBIKENMS19USU1F
UiwgImNsa19wZXJpcGhfdGltZXIiLA0KPiArCQkgICAmbXBmc19jZmdfY2xrc1tDTEtfUlRDUkVG
IC0gUlRDUkVGX09GRlNFVF0uaHcsIDQsIDApLA0KPiAgCUNMS19QRVJJUEgoQ0xLX01NVUFSVDAs
ICJjbGtfcGVyaXBoX21tdWFydDAiLCBQQVJFTlRfQ0xLKEFIQiksIDUsIENMS19JU19DUklUSUNB
TCksDQo+ICAJQ0xLX1BFUklQSChDTEtfTU1VQVJUMSwgImNsa19wZXJpcGhfbW11YXJ0MSIsIFBB
UkVOVF9DTEsoQUhCKSwgNiwgMCksDQo+ICAJQ0xLX1BFUklQSChDTEtfTU1VQVJUMiwgImNsa19w
ZXJpcGhfbW11YXJ0MiIsIFBBUkVOVF9DTEsoQUhCKSwgNywgMCksDQoNCg==
