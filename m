Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D9357869D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 17:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbiGRPo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 11:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiGRPoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 11:44:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C00910FE6;
        Mon, 18 Jul 2022 08:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658159094; x=1689695094;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3veo2QpPIuPm4hzerLhKqo3GKnKhiHyhbWowFvb2Ads=;
  b=wh2NYbYirkcQ1x8GQW4jFN6vFBxm4fSkEWldfPJUA8CfV59kBW6S+v7f
   c5696DYg1oq5g/Eyk7ONJoc/pUPmItQgW7faNK4vDcZNLYTHCmS3LwAzX
   ssJJgsHEeCshMuxggQscKbWC6FrzV8kSC+e1F7LNIHU12VpGl2EPwa38Z
   UJSJN5vhoXwWgwyBzJyDItcLUygsoe5ThPE4mOhUu8XvYU0skl7w5pXAl
   aj3Fy+KHf2nnEhUAcUso+HSaVDlyCf9TZqAXDnGjQ31VVwx89VpuGFL5R
   3vGfRYo2oyvWNPepfk2Xy3Az1NW2EHpVZMigCI155OItTbgYUjkFAnl1/
   w==;
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="165238697"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Jul 2022 08:44:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 18 Jul 2022 08:44:51 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 18 Jul 2022 08:44:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lh1LZ8S5rOp2xUb7sR4x6TEmjFswF8NAVdHi/dkhBmfshEsxDyHbdboff8wuGUeFNVBxTwJR7IT+GFv9hOiaF2Om2xIFseeZAP5czJwlSh5X9sG5g7VuLGI/YMgeIAGZ3OrTlbp4Cers0O7m7gbKT5Kfi7NV/V6G9dXqkdTpWk+l8QbV/vWB+vctQwM8pNqoIEeBhhRytYKakFsGNFUtTGUVh3LOkx0OQTT7C4kC81qQo4OvtGYzui/PX8XUYo0lAXHjPWmYti91mXzV+AQO5UW15ChA3A//T8roM0dPVdqc6LERMnm7VaCr0Lok3hXhLaytDf5vZmdiYbgrcW8X4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3veo2QpPIuPm4hzerLhKqo3GKnKhiHyhbWowFvb2Ads=;
 b=IqPgJaTDaJkHOcnQDrE0x5pM0+V7s7UPR/JLRt188UBx8ZT7dor5AUiaCQte+XfetiN3KopFRSYQkKBoC4VwyYUlfZ+fZjQz7V33lqdNi7pJOPqEuj/xiGeYBqorN3D8NqQr5Soq2bbVRTWxWQ/+W/+KzCCw12cwMUcqXEpgky5D/tQR6VoWzh8a7rieYbpLQT0a9DvNf9fGyPdiMWGdQmKWDIbKUXk2CbCwg7N+XfGm8oBiv+r+m1tcqcrCcAYkGbk/hpmWT4R8oGztYwPgQndK+Po1Ip3okB4FIa3HSCwIuHJ3nGLLPWbTGWOnwwIU6KLdhOwvcmpLB1yH67cigA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3veo2QpPIuPm4hzerLhKqo3GKnKhiHyhbWowFvb2Ads=;
 b=DIZzo3WHhpTw8VKfk2an7d1ijddY2Bq7Yf0hF+E6Zbp97Xc64F3o5dcBnN2QUF0pdBuEe2Sp6hXG6vJ5E2i0SYbMtv/ZmWDiGCT5LPPBL9z0styhwL/z9tYZStIEoFrPWciQgx1dBGhKI9E3Doe/oP5P/pI0jlEGseBTmmMkeko=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM6PR11MB3513.namprd11.prod.outlook.com (2603:10b6:5:63::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Mon, 18 Jul
 2022 15:44:49 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b%7]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 15:44:49 +0000
From:   <Conor.Dooley@microchip.com>
To:     <p.zabel@pengutronix.de>, <Conor.Dooley@microchip.com>
CC:     <paul.walmsley@sifive.com>, <Daire.McNamara@microchip.com>,
        <sboyd@kernel.org>, <aou@eecs.berkeley.edu>, <robh+dt@kernel.org>,
        <palmer@dabbelt.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <mturquette@baylibre.com>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2 03/12] reset: add polarfire soc reset support
Thread-Topic: [PATCH v2 03/12] reset: add polarfire soc reset support
Thread-Index: AQHYj5/vPcB4mHXnY0e1IrfO0oJ0YK2EFXqAgABFJgCAAAC/AA==
Date:   Mon, 18 Jul 2022 15:44:49 +0000
Message-ID: <dff80088-5f51-48f2-b956-0b1cd435ffff@microchip.com>
References: <20220704121558.2088698-1-conor.dooley@microchip.com>
 <20220704121558.2088698-4-conor.dooley@microchip.com>
 <22d3a11b-a603-8406-77ec-51ec038560fc@microchip.com>
 <b7540ac17d28cee09f6f9cce65b696248e545ae1.camel@pengutronix.de>
In-Reply-To: <b7540ac17d28cee09f6f9cce65b696248e545ae1.camel@pengutronix.de>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85223997-263c-470d-c1ac-08da68d4729b
x-ms-traffictypediagnostic: DM6PR11MB3513:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dB62HVxw8fOKcSOnFqtMAkBmwHI5//IXkTBUneoMAGvAVQ5LwkU7Ls1j5qc+ftZYhfFub3IbDWaRcOxwfzs4aOUvUs8RLGu1c4kLqD2jQsJHcmujSX7nSpFIAOPOS4vRCmndzKD/AWRylKzf6EDB2Wztl+sU+DaKIKBy5yzKzMEkNz+kojuoeXpL0l26PYHPHKZM33YZPG0qgvqBaeof15A+7Ox5fmBxdcaeWaEgnMJNJMoZWjCK+kAxUOShFGUfow5QnsHPuGCG4WaL6cQLlSduttK5UXZepRNY6xQTwOAJUu6MIcOhkuiiPiOlFSyp55JZaAP0zZ29lpqlUjUgf4qTvNapW9r2mCM5YrgldMg1V5NU7yd3q7LO374jCzRCq7M6BSaSvnd67ZQOsvzgCvX2Xv4/7urJKdnjZhEMt+GH1tCGwxctBWfQKZyyjxg1WrFpYW21dC1ejkXRUVHFoBfl22TjJS8tl+o3jlCosjr/XGVdPgBqAqFAQoefXtrc9Ejr8TR5Lm8me0wUAlGb3Mmlo884OB3dX1aKVApzT0SPzMqNBEYRprc7ldfEwQ0WSVQEmD73rsx0CWiC+uqMHFZ4cKO8gWz0G50fSRP/pAZ4tVB/v1CfKXTy5Xtw4yF6WNDOx8nYiE7m1LjqSI94OfHQazjqBt7f65xjozAm9NGS/Rn1bu3xzJxHCH0YVBEnTD+UjW+mVeve92JN8Qp8IEA+otGtODeA2va1GkncVv8LYpNS1p5Sp+gGXX7IVoOH4FWeZNdiHiXDQk1GwtbvdAHHlplQTa9YqwdHo+sC6q5a61iqYMcyLqYX9QO+JWKzESEMaNDHt07qLvRFAuD6CGddYgmwfWiE69X1O6t3cA9Y8ZaA/Q141rMDE3yN2pQi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(376002)(39860400002)(136003)(346002)(71200400001)(2616005)(76116006)(91956017)(4326008)(66446008)(64756008)(8676002)(66556008)(66476007)(41300700001)(2906002)(7416002)(66946007)(478600001)(5660300002)(86362001)(110136005)(6506007)(6486002)(6512007)(26005)(54906003)(8936002)(31696002)(53546011)(316002)(36756003)(122000001)(31686004)(38100700002)(186003)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzlyT0ZmeEFhRVJFcG41dllvVWtXbDMwS1lCTnZxTllQamYwUDNvL1FkLzFF?=
 =?utf-8?B?R00rTVRYWWlyWXpvbjZCb0djclVSSStWaVZSOUtORGE1ZXRjclp1WHZxTHVq?=
 =?utf-8?B?SGhNQWRTS0RiOWZHZWY2dlFKTWtxU2tpajB0TVRFdWlvbkVTanhZdUt6cFd5?=
 =?utf-8?B?V0VPbVVXQ3hqcjVDVVo5N3Q2UURjRmF4Tm9ZUzRXdFhpMkZuUnVwSmNMbWtj?=
 =?utf-8?B?QVRCalorc2E4bWZPZ1E0Qks4dmQ3N1lUT3MwS2xGLzM3ZENsa0pBVTh2TGpp?=
 =?utf-8?B?dEFLOUZNd0VMVlhKVWRlUTV5YURRUnVubFJxYW4vejQxWFU0N25xVVdITnVD?=
 =?utf-8?B?UXZJSFZ0akQ3TnFNdDZnbFlkUE5Db2s5OE5ZTytRT2kza2lSdmpkbFNubXNK?=
 =?utf-8?B?L3hpRFYvWFJXbXJBdWEyamNVbWhEai8yblBrMU1VaU1mbHQ2a3RwZkZKZEhv?=
 =?utf-8?B?ODZkTVNzTWhMb2ZUNWxpSGducW5MTTF5Z1RVR0pzRVNnVnYvS0dua1VKd0cz?=
 =?utf-8?B?Q3ZLRWlkRnluRDFkNXlXc09XQTlrMTBQMC9LbWZ2SmIxcWk2NllQcjV6Tmly?=
 =?utf-8?B?VGw4QWlDM3JOUTc1a0thT2MydHVDc05xcGN2RHVWUVZmVnJpdlFQYXJkRDND?=
 =?utf-8?B?TjZlZUVCa25lY2ZGV1hpWHpFRzFTV042Q3hnV1dpMEdnQjBMNFQweHBTaDYr?=
 =?utf-8?B?S2hUYnVkSUNCbEl4ZlkwVERHb1BmNmxaVC9vTHRYTzFRZXQ1eUY5Z2pYMGVP?=
 =?utf-8?B?Ti9udlRZWXBXdDlJSkJWcy9EVVIwRHFUKzhiM24wWk02eG5qMEhNN1FmS3h3?=
 =?utf-8?B?V1RtNkc0YkNHNjFoNm9rVlJuZkJLZk52ZnRYNDFnWENKMFFlV3dzb1I1cXdz?=
 =?utf-8?B?d2x6WDZXNk1FL0pMaWtCaUVYMmJ1QlhhK3h0SGtlNmt0Y1gvV3RMcGpRYjBx?=
 =?utf-8?B?elpoY0hTV25yb0ZGUi85azlkeVlxYmpyWjV1d2xORjVUWWlLRHFjUkliZXNX?=
 =?utf-8?B?UkFQQlRiNlNuWWcweWZHQnZEYVdNaUJrRXR5aWh0c2o1Ym15NFYrNU44S05P?=
 =?utf-8?B?TC9wSGJaSHdhaXJNVDlWTTdoV1BJZk8rbFl5NjkwNXhtVjJHTmJPdlVsZjRU?=
 =?utf-8?B?RllDa1hDNmduMnpjUDY1Z1RkbG0wVWY1MVlsbmxkL1hvNjlnb1NmZklTK2s3?=
 =?utf-8?B?MzhpSjZUSlpmVlNRNVowOUlOUUNBcFJuRngwZzZ2N0pheTBabWthUnBHcmJL?=
 =?utf-8?B?NGtSdlFiTFVWcm1KVURiQk1UUkFJQkdpWEw0Y0g2TUQvWnpqQUZwaHNrTXhJ?=
 =?utf-8?B?VWwxMHE2cGNjQkR3TDROeEFBalN6V2Nwb1NpOUVlZG9tYlg0K2twU0hNVGN4?=
 =?utf-8?B?cjZsK3ZBdWQ3SGxxSW1KeHc3cFhrTHV3MVdINENzRElvdEQ2azNTRnVlNXBU?=
 =?utf-8?B?SHkyS0loWlg3ZllleEdqdkpjejlMM0g1SE9jeGJFZmI4TGEzS29aYzVTNkVI?=
 =?utf-8?B?Z2lPWVdsR0p5Y2tHS28rWUdkUFVCUEh4Y2VWSkJZQ3dxdDZaZHpzOFBHdDZC?=
 =?utf-8?B?cTRtaDg0bklXY3krNFRIZnY4NVJyR1JJeWMrOTMyVDdvQ0NXNDJRS0Z6T2pr?=
 =?utf-8?B?SnJBYzMrY3BJaWFNbzdkQ2xrNnBoTFFzemxFYlliSjlraGFHUFVzOW8ybEQv?=
 =?utf-8?B?OUtxQTBKQ2JzdXYvVWU4bndwOG9lQnBKRmZtdmZNb1F5UDlGWjdpaUxCVDM4?=
 =?utf-8?B?SVFvQlBQd284blhSSGVUa2N3Y1V5MU5lTVMzUFAyWnliMmJoVmZoVjJCazN4?=
 =?utf-8?B?NkJFeUp3OC9NcGN4ejZrMyt2QlZjRHE1Y1QrQWkxdFJpU3FqYTJHOTArRVB3?=
 =?utf-8?B?emt5d1Z0UHBpODBxdnp0NHB2RkJlRnZOWFN1eFNhRTh6R3c1MzZUbERSOUp2?=
 =?utf-8?B?SGRUbW4raWljWEJSeWwydWExd3pDOEtibnNnWFN1WE4wclEyeXMwMm9XNXNm?=
 =?utf-8?B?R2RZM1RoRnRQQTdvckRBZERyazhiUkFxeGxPOG9nbEpzaGh5bE81VDk3SFhj?=
 =?utf-8?B?OCtqQ2tIaGhuYS9ydnNmcy9jaE9CK0toVytMTy8xSUtJc2xsbGVJbjVJSjRP?=
 =?utf-8?Q?z7yM3jzrWxCP/MzlkLx1glOb4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0892BD8C6A0A7C46B5D0259F8B579717@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85223997-263c-470d-c1ac-08da68d4729b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 15:44:49.0880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LmRXSH67aOgIx3W5E44oslp/uBgIotpWjsRBYUhYYcBeh2rb3BHavuAYvFu3FwjYNGw7JHWcuoQBvLAuFaogdnZlG8ZQ9XGQrUzb7uye8hE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3513
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTgvMDcvMjAyMiAxNjo0MiwgUGhpbGlwcCBaYWJlbCB3cm90ZToNCj4gSGkgQ29ub3IsDQo+
IA0KPiBPbiBNbywgMjAyMi0wNy0xOCBhdCAxMTozNCArMDAwMCwgQ29ub3IuRG9vbGV5QG1pY3Jv
Y2hpcC5jb20gd3JvdGU6DQo+IFsuLi5dDQo+Pj4gK2NvbmZpZyBSRVNFVF9QT0xBUkZJUkVfU09D
DQo+Pj4gKwlib29sICJNaWNyb2NoaXAgUG9sYXJGaXJlIFNvQyAoTVBGUykgUmVzZXQgRHJpdmVy
Ig0KPj4+ICsJZGVwZW5kcyBvbiBBVVhJTElBUllfQlVTICYmIE1DSFBfQ0xLX01QRlMNCj4+PiAr
CWRlZmF1bHQgTUNIUF9DTEtfTVBGUw0KPj4+ICsJaGVscA0KPj4+ICsJICBUaGlzIGRyaXZlciBz
dXBwb3J0cyBwZXJpcGhlcmFsIHJlc2V0IGZvciB0aGUgTWljcm9jaGlwIFBvbGFyRmlyZSBTb0MN
Cj4+PiArDQo+IA0KPiBQbGVhc2Ugc29ydCBhbHBoYWJldGljYWxseSBieSBjb25maWcgb3B0aW9u
Lg0KPiANCj4+PiDCoMKgY29uZmlnIFJFU0VUX01FU09ODQo+Pj4gwqDCoAl0cmlzdGF0ZSAiTWVz
b24gUmVzZXQgRHJpdmVyIg0KPj4+IMKgwqAJZGVwZW5kcyBvbiBBUkNIX01FU09OIHx8IENPTVBJ
TEVfVEVTVA0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Jlc2V0L01ha2VmaWxlIGIvZHJpdmVy
cy9yZXNldC9NYWtlZmlsZQ0KPj4+IGluZGV4IGE4MGE5YzQwMDhhNy4uNWZhYzNhNzUzODU4IDEw
MDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvcmVzZXQvTWFrZWZpbGUNCj4+PiArKysgYi9kcml2ZXJz
L3Jlc2V0L01ha2VmaWxlDQo+Pj4gQEAgLTE3LDYgKzE3LDcgQEAgb2JqLSQoQ09ORklHX1JFU0VU
X0syMTApICs9IHJlc2V0LWsyMTAubw0KPj4+IMKgwqBvYmotJChDT05GSUdfUkVTRVRfTEFOVElR
KSArPSByZXNldC1sYW50aXEubw0KPj4+IMKgwqBvYmotJChDT05GSUdfUkVTRVRfTFBDMThYWCkg
Kz0gcmVzZXQtbHBjMTh4eC5vDQo+Pj4gwqDCoG9iai0kKENPTkZJR19SRVNFVF9NQ0hQX1NQQVJY
NSkgKz0gcmVzZXQtbWljcm9jaGlwLXNwYXJ4NS5vDQo+Pj4gK29iai0kKENPTkZJR19SRVNFVF9Q
T0xBUkZJUkVfU09DKSArPSByZXNldC1tcGZzLm8NCj4gDQo+IFNhbWUgaGVyZS4gT3RoZXJ3aXNl
LA0KDQpUaGF0J3Mgd2VpcmQgLSB0aG91Z2h0IEkgaGFkIGRvbmUhDQpJJ2xsIGZpeCBpdCBmb3Ig
djMuDQoNCj4gDQo+IFJldmlld2VkLWJ5OiBQaGlsaXBwIFphYmVsIDxwLnphYmVsQHBlbmd1dHJv
bml4LmRlPg0KPiANCj4gYW5kDQo+IA0KPiBBY2tlZC1ieTogUGhpbGlwcCBaYWJlbCA8cC56YWJl
bEBwZW5ndXRyb25peC5kZT4NCg0KVGhhbmtzIFBoaWxpcHAuDQpDb25vcg0KDQo+IA0KPiB0byBt
ZXJnZSB0aGlzIHRvZ2V0aGVyIHdpdGggdGhlIG90aGVyIHBhdGNoZXMuDQo+IA0KPiByZWdhcmRz
DQo+IFBoaWxpcHANCg==
