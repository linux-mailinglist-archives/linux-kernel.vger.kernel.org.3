Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68CE58B7AD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 20:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbiHFS1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 14:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiHFS1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 14:27:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2539594
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 11:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659810461; x=1691346461;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hKqlMeBf+wcOJeKanfPzHvrMYHWLurGonxxFozGvMuU=;
  b=cQVDxKEGtDD5x2uXJUAwyf8evQ9xwkh+Gbrjf34zS28ncWddSJiKsVNf
   kK60y0jh+r5Ksn+b6sMsz4oyDukF3l4APLNxcQWiV5Ocju5OUGIHNZwqY
   9mkKNE8pdFdxivqQx+047v6Vf2vVf+v8ka9hSE6KWNPE1Qk5I3mBxgrbz
   knDiRDEgIb7nXr+NQHdalBgFo8cSvP1LiWTyHOefgbZ72HzdtqmkSs7HP
   a+Bs7R4lxgypXtz6yEWR6C2d8902qh9dNb4WoZ70WtJzfBTzMxfokZiSM
   BZN0pWJm0AjBkD6OZT9JA/7X1eaKbk8c0GvRwppK7a1IW/WVyeVzlQeiT
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="175201772"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Aug 2022 11:27:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sat, 6 Aug 2022 11:27:39 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sat, 6 Aug 2022 11:27:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkHFELkXKGgvFj4FPH1HkJfGLYbpI6qcnWmvqg3tECy8GQQ8t3ZkcPgLirh/zMaYYauuIiQ518VPYxbG0LGXIqd1MAXgc0wp8/vhBIgvQWroT+vCNVIDzhzlVQ9A6d1KyPQHtp6ulRMjBYsTBUxuYgJRmVv+AcRQcc3fIA1cNsDmnwJ5cARe0aXMRYvdIvA77u7gUJypUqheceKb8olxYjiMrtB7/2orxzXIZUrG5FmFh4+U7rXuIPKwPRG923/FP0bB/sxwMfUquo/Bi2KExwhrn3Z0Ukk/gNn4tcFPCv6xszVcOO/7gPKTwsOrlSzQmHB2bEjRCZGBhSvdRjL+VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKqlMeBf+wcOJeKanfPzHvrMYHWLurGonxxFozGvMuU=;
 b=coF7ePcd7Ksgmj8+UywMYSPHZu/pIDm5Nn1tiRVr5Nj266qut058wajALGAnsPlZCTaTrOUizvIPi6RwIPy4ckq3V38Pei5ardxrK/QVQEpfjCCsPPbUUC5AtVL2h/p49HoLfptJEojGlMtpK+g1bb4wH7PV6w1StDatwU7Asnj6A/CwXkipEIM3mpRK6lBj9OeVc5SpaP6HUIim8FTR2FSruaBYtSeeKiUy6IkO8j8RK1lzdU1t2z2SiwpyI36IjYQYvV4AT1rxuADl0j06gV1TVH6HJOGtYs+4ReHDXmiMYR9C4GpzR9cbger/eweyugC5s1o5Hnd5aID1tIp/oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKqlMeBf+wcOJeKanfPzHvrMYHWLurGonxxFozGvMuU=;
 b=HyaT3mF6jZJ2MyzAFV29x8HW4cD+HcXSNQAW0+XRk7B5L0ULibJ6fd0fp58N7jq8vN1ZwfXpkJ6GQozSeAfXeXc7u2YuHS4HgTOhYY4Ae3BySDDWiJkpNXKhomljDs3fyT0f3Hyyn/eS6vQhcdDCCXYv9QaSmiVoaiZhRD6LBl0=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Sat, 6 Aug
 2022 18:27:34 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5504.017; Sat, 6 Aug 2022
 18:27:33 +0000
From:   <Conor.Dooley@microchip.com>
To:     <f.fainelli@gmail.com>, <linux-kernel@vger.kernel.org>
CC:     <sudeep.holla@arm.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <ionela.voinescu@arm.com>
Subject: Re: [PATCH] arch_topology: Silence early cacheinfo errors when
 non-existent
Thread-Topic: [PATCH] arch_topology: Silence early cacheinfo errors when
 non-existent
Thread-Index: AQHYqSA0gidgBn3dLEKeiubImkRm/q2iMiKA
Date:   Sat, 6 Aug 2022 18:27:33 +0000
Message-ID: <9bfc7145-86d7-dc69-bfa0-f36c4c8b42d5@microchip.com>
References: <20220805230736.1562801-1-f.fainelli@gmail.com>
In-Reply-To: <20220805230736.1562801-1-f.fainelli@gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cbd7d685-344c-4846-88c3-08da77d954a4
x-ms-traffictypediagnostic: BYAPR11MB2758:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iU3xg0BgbC8wYGRmH8rpNHVgUFLvMBdMLIWBgU4PWYoEVdjqfillMixDw7LmblpOt90wG+06N+GaFdoe1pC3qiI2fOxVf8s6SBAbP+xwl43hkW9Fx0Aa9PMPPkc6u5RS58HQerxkvDPprUDU20WeoCd7yPBdsFbFlmYcjrew4rLnP1wMsf+CRytZiWwfp0g5oqnetdyo6Jf5ttHhA21yiKNHwNerzcOQQDyqJNjc1Scl4YsBEeBUrzblLEt0JtD16qP1i3tBwRk2Ft84lhuMDZh0MPZ+NjDAVpu2+PlvYwmHRZXf/nrMrjJ9aCsQ/E6TmF9YTyZgb+c6DaJKXnMIsHbhiUa/mhDOyeYwhrHmb5JojGVIz+NMFDd87QWPYmJo0yhTuoFsTWh/ytq/3zm2OmGqFzTtf6Kwj8M1Fw4f0jnmI5u9qe1r0rJfr2qyvJ43wQ1OTgPNtez2CqrseqVy7eQ5UyYudz7iQeWv9krottKzQnB4OsY/PJ1fcXB5jU8BXblnBOnjYAHOsnz554DuKrmcnqfSec9J7aU9+IEfBgC/D75iSockigVyLJoyKI6TxpVnJSnOMu2tPCWryqCC607rcQ1fkucNLrDZWNUgXekr3COAJxbVqo216Xj/brIMmgqUrl0V94m0OVrR2GlypT8nHsY7BhxIwIjeYTX1HEVD+HJ2wopsyjmMzqUOjWEO+/sJ57D1XpHVWXBX5XpAExFrOvtvRPVEfaZT4CKGtcWD6JZMkcp6TwMfMhTlBvyT5MbBHz+XPBUZs/eLHW/ycH3ksQBZiEABRhZzq223mklq6/YHLtV7U50y5IYri9Hr4MYGQK514A1RzlvhtU6NT2U+r7q+4umqf4skdtP2A7Ql4HMDCrtiC20dq1NR3uV2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(39850400004)(376002)(346002)(136003)(6486002)(31696002)(86362001)(2616005)(8936002)(478600001)(83380400001)(38100700002)(91956017)(71200400001)(66476007)(4326008)(8676002)(64756008)(66556008)(76116006)(38070700005)(53546011)(6506007)(66446008)(66946007)(2906002)(41300700001)(6512007)(5660300002)(26005)(122000001)(316002)(186003)(54906003)(110136005)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TG9YZ2NHNUExb05JSlc1ZFNDTUtsWmg5K2YxeVg1WnhuMTBDM1FlWnFIM3No?=
 =?utf-8?B?WEppZlhQSTF1M1kydXR0a1RwVmREamNINkhLcXdYbW5lMGYxTmMreGdadDVQ?=
 =?utf-8?B?WllYNDhYMnREc0pBWXdrbG85OERmVWl6WEZsdE40MkxlZHQ1YmxrM08xMXRC?=
 =?utf-8?B?eGcrdXBmSkNhQm12cE5wbmVTVURubHk4S0U4ZGp1ZVlicjdIekN2QjZyY2Q1?=
 =?utf-8?B?NXF1R1VvRHFEMXBOR1dRY2l4Y0tFbnNpajNlYjlOdktSajZ6NU5QMlBtMSt4?=
 =?utf-8?B?SzF2endURE5lYlo4TXMrWXJZU1FLdlpQNXI3MW5aVWFiaVlQdTJRZWJ3SHVa?=
 =?utf-8?B?dndUMWp3WGVjVmdXN2pueW9TNnRGN0RiTVdXcnhoR2dVTDNaYkJwQXJoeGNt?=
 =?utf-8?B?dzJSVW5yL0NGNXFYNE5BdGdMemFjTXNpU3k2Y2VGTzV0dWlmTHZXYXlJcngv?=
 =?utf-8?B?M1F3MGcrdjhpQXg3bmN1WDNCaEtnOVZtNURUN3NLWmFNbTJWOFJLNmFBbUx1?=
 =?utf-8?B?V3BhazBPbkRoYnIzY3pxRjE2Q3JTWDBzNU4vMTVKWEE1dEdYci93MHRDUW0v?=
 =?utf-8?B?OXJpMkx2YUJub3dQZ05JM1NudHF0WEdZclJOWGgxNjA2VEJudGJocStmOFQv?=
 =?utf-8?B?Nnhod1F0RXFvUG5CZGdkSE9HbTd0ZS8ycTBUb2hYODNqTHNUaHVhekkvWHUz?=
 =?utf-8?B?TjNYZlpacHQ1ZWZiRm1iSGtIRHEySHRDNVJ6cHpXdXZ0ZHZuM3BHRVlJRmRR?=
 =?utf-8?B?NTY1WHAzKzI2Y0pzTzc2UVNkZk5kRkZWb0wvMHlUUWlKUE5xUld6YnhTNDU1?=
 =?utf-8?B?ZmdscCt5ZC9mRmkrZmRwS21lWWdDdUhqWU5LajJEQWQ2cFhITGJlZjJaZzJh?=
 =?utf-8?B?NkU2YWZKa3M3cndOY0MyZENWWlllZEhOM3R5RmhESXVORTNUZEZDRHBMQ3k5?=
 =?utf-8?B?S3dVelBhM3VJeWRwbFpWS215OGNaNXRoNTR0bWF1NTFESXp1U0tIbVpvTnl4?=
 =?utf-8?B?RGtURUFpc0FLMWlRZ09ySlhoNVNrSmJqVi9SeTVGaGNpTjZRUklob2hLdXNz?=
 =?utf-8?B?VmRLSUZKZmdmZ3NzM1hRaVlUUWkyTkp4eVVRWXJldGdQMjgxMmZEK01yWUxy?=
 =?utf-8?B?bHNhWFBZaFVKN3BRelpmeFAxdXJHaE02WE4ycVR5b3FRbFpMeTFraC9sSmFo?=
 =?utf-8?B?Ti84enJSUyt0bitkNk5UdXcyMVREUXROV2FuV0l3aXpXY0ZibjFNRGU1cHp6?=
 =?utf-8?B?Q2w5QU1VaWtuQmhSTkRvZTZkTlNhaldtOW5xdDRacnl3UjRZcmIyZUJQa3JJ?=
 =?utf-8?B?ZFJYU3pibVRqY3QyZk5XTnFCTjlWUVB3em1Ma3l4eTVLK2t0T2haSGRtSnBJ?=
 =?utf-8?B?WFVkOTVUOVBGbDd1aldvWEVuSzJmRU51Sk1NZ2NtOXhiYW9qZ3FQb2YrNkhq?=
 =?utf-8?B?NXJONjhjQ1d0eGZTM0FWWVo2cmxBZ2FWM3BwUnFscW9sMlVFV3RDRkk1dXlF?=
 =?utf-8?B?ckwwbzRhcFVaVDVRb3ZoS2RpZkdxQ2pDV0lTSy80aVNvdGFESmwyakVleEQr?=
 =?utf-8?B?RldxOC93bUhuL2VpcUJBUFhiUDU3M2dUK2VMSFdLVFN3OE4rRUZBQkd2MlBS?=
 =?utf-8?B?ckRXYUw2dTlza2FGOGlwNVNyOGdlY3ZMcmxJdCtmYW40YnR1TmtycHBtOW9r?=
 =?utf-8?B?MjdvUG1aVlloWU5kYlVpa3crck40OTVkYnRhNnlqOW1BUTZ2NitDaDVVQW1t?=
 =?utf-8?B?QUhtbzBQdDdscS90RHVtMDVDeklqbEh5RWRVeENFNGtRakpkQW94eDVzZEto?=
 =?utf-8?B?WEtTMnh6NTZiUHhtekpmWERGZnc2U01WK1YvUFJQcFRFbzNYanJPUWFyZzAx?=
 =?utf-8?B?ZW5CZzg1YktiMFc3Y2ZGbjJXV3lSN0FWM01NcGpFbXE1Njg0eU9oUjMwT1VX?=
 =?utf-8?B?cTVDS2lwSE1Pc3pLYnJOQkJFWXRQcnlMTFFwOUVsb24xeWd2Y0F6WkZaNmJL?=
 =?utf-8?B?ZnYvZVBpMlZFNWNyejVHTS9MaUhrYXJxNXNNOXVNcjhuYnFPWkZGaGtsMHF2?=
 =?utf-8?B?RnRIeXowRFhHQUFxL21xcW0rL3ZZTzdYUVlhT3RkeXBmUXZjVGRxOVJxS3dq?=
 =?utf-8?Q?/Vv5d/MqYtzoawpB5l/JaWJQ2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EF49F0FB08B67469974399339A13A37@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd7d685-344c-4846-88c3-08da77d954a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2022 18:27:33.7555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EBHWLol8OTQW/YYu3AQP50qVZm7A0nt5dWtYpjxfZSQNW+NLk0Sug1PAdTkzufU93Uhpt6LzZdl7Bc9a7O9DuLVOfyGy96Jor/Vo/9B6mGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2758
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDYvMDgvMjAyMiAwMDowNywgRmxvcmlhbiBGYWluZWxsaSB3cm90ZToNCj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBcmNoaXRlY3R1cmVzIHdoaWNoIGRvIG5v
dCBoYXZlIGNhY2hlaW5mbyBzdWNoIGFzIEFSTSAzMi1iaXQgd291bGQgc3BpdA0KPiBvdXQgdGhl
IGZvbGxvd2luZyBkdXJpbmcgYm9vdDoNCj4gDQo+ICBFYXJseSBjYWNoZWluZm8gZmFpbGVkLCBy
ZXQgPSAtMg0KPiANCj4gVHJlYXQgLUVOT0VOVCBzcGVjaWZpY2FsbHkgdG8gc2lsZW5jZSB0aGlz
IGVycm9yIHNpbmNlIGl0IG1lYW5zIHRoYXQgdGhlDQo+IHBsYXRmb3JtIGRvZXMgbm90IHN1cHBv
cnQgcmVwb3J0aW5nIGl0cyBjYWNoZSBpbmZvcm1hdGlvbi4NCg0KTWFrZXMgc2Vuc2UgdG8gbWUu
IE1heWJlIHdlIGNvdWxkIHNvZnRlbiB0aGUgd29yZGluZyBmb3IgZmFpbHVyZXMgb24gdGhlDQpw
bGF0Zm9ybXMgdGhhdCBkbyBzdXBwb3J0IGl0IHNpbmNlIGVhcmx5IGNhY2hlaW5mbyBmYWlsdXJl
cyAoYXQgbGVhc3Qgb24NClJJU0MtVikgYXBwZWFyIGhhcm1sZXNzIC0gYnV0IHRoYXQncyBmb3Ig
YW5vdGhlciBkYXkuDQpGV0lXOg0KUmV2aWV3ZWQtYnk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9v
bGV5QG1pY3JvY2hpcC5jb20+DQoNCj4gDQo+IEZpeGVzOiAzZmNiZjFjNzdkMDggKCJhcmNoX3Rv
cG9sb2d5OiBGaXggY2FjaGUgYXR0cmlidXRlcyBkZXRlY3Rpb24gaW4gdGhlIENQVSBob3RwbHVn
IHBhdGgiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBGbG9yaWFuIEZhaW5lbGxpIDxmLmZhaW5lbGxpQGdt
YWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2Jhc2UvYXJjaF90b3BvbG9neS5jIHwgMiArLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9iYXNlL2FyY2hfdG9wb2xvZ3kuYyBiL2RyaXZlcnMvYmFzZS9h
cmNoX3RvcG9sb2d5LmMNCj4gaW5kZXggMDQyNGI1OWI2OTVlLi5lYWExYjhkMmQzOWQgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvYmFzZS9hcmNoX3RvcG9sb2d5LmMNCj4gKysrIGIvZHJpdmVycy9i
YXNlL2FyY2hfdG9wb2xvZ3kuYw0KPiBAQCAtNzM1LDcgKzczNSw3IEBAIHZvaWQgdXBkYXRlX3Np
YmxpbmdzX21hc2tzKHVuc2lnbmVkIGludCBjcHVpZCkNCj4gICAgICAgICBpbnQgY3B1LCByZXQ7
DQo+IA0KPiAgICAgICAgIHJldCA9IGRldGVjdF9jYWNoZV9hdHRyaWJ1dGVzKGNwdWlkKTsNCj4g
LSAgICAgICBpZiAocmV0KQ0KPiArICAgICAgIGlmIChyZXQgJiYgcmV0ICE9IC1FTk9FTlQpDQo+
ICAgICAgICAgICAgICAgICBwcl9pbmZvKCJFYXJseSBjYWNoZWluZm8gZmFpbGVkLCByZXQgPSAl
ZFxuIiwgcmV0KTsNCj4gDQo+ICAgICAgICAgLyogdXBkYXRlIGNvcmUgYW5kIHRocmVhZCBzaWJs
aW5nIG1hc2tzICovDQo+IC0tDQo+IDIuMjUuMQ0KPiANCg0K
