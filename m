Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD34579334
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 08:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbiGSG3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 02:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbiGSG3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 02:29:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3A929823
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 23:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658212159; x=1689748159;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4v432h4KswnzyKqtipbimarmF9e7Mqa3M3b9Czy0JZY=;
  b=jiVWDznkaotSg+pa83u614zX67REqnUeOYS2QIMp2BuIq2v7so1A+/xG
   w5G8ONLUz+CvxgXt4tF5v0/b37e2sRM0nzLSFn+MPLtMiFquIxocCdubT
   Czn5IFc205gkvXNoucfWAKX0fvE6p+74+2we2iPtNa0qNXTXDpXWuR9sC
   1/PG0vp20w6gznXOrm8x/4xKrqfUZzY8W8uo/PzJgA13sMiJH1LOT1qmX
   l9H55L0mcltXRi11Qu9FK4An9Yx/qHogR4oAyldPxIO3mDFLxvmvpAtkC
   9pukbjSbYA6u0DFdoEhnVMSXuvqFSVYDHJDVS9YoUM2zesPfEMdsvX5yn
   A==;
X-IronPort-AV: E=Sophos;i="5.92,283,1650956400"; 
   d="scan'208";a="105073978"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Jul 2022 23:29:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 18 Jul 2022 23:29:12 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 18 Jul 2022 23:29:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adIOIdWhGeqJbYFx+TKl2tybniPm3gOuobuv3cmSZO3nw3MtrIjGVUPqpORDQ1AwE0Sx22RN2IS0o2zEBTKJ9/UzaxkDau0rzBoz36F2T5BQrXvkJI1QKpUaHf8ZBujotzpIQPp0ntT70x1vIkTp3aEAR1+1ZNAvJZYhsAyLuZTKsHzxOAVObq3QLYNEndlkeSYypEJTL3lgss0hZ7tQWItpIOmJiXkGtro/oNz1KFCVeW6HCZPZ/eTy6h0dFwIlU4G9V7OSzL0ot9aEq8w97GfnUpKBFgfmfOvr5fvNdW7ttaSI0BA4GprJ5GXQsmg+HfR+ns9xvv15xHhKQKrfrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4v432h4KswnzyKqtipbimarmF9e7Mqa3M3b9Czy0JZY=;
 b=juQ29O5+l7JfxZ++eFr4zeGeZCHL9X2wLK/9NugDYaKVXCWQNaZyA9cg1+w/Tzupr+adY1BkZXaAoaNBBGd1avEI5U6RKfQwSgbgxW06K91IsY/08Fi60X2raMXj40Wz6vG2YTb0MbuKQQH0CzhD//vdknHNE4lfRAJDcbQPjNFPfa/f2SH53JWWG/etks3p9DsmYoF7Le0T+t/jHvUOJ508rQFWM0d+ubXlAUnXnCWwsT2z3CGZP9GO+IMOznHJBFMSdjAYfM5tKm4/WuFhbilUkS5/cueegSeCC8qj+qcFrv1BPwOsB0uF7hcWF5iQQK1cw0wsotvtiThqmpwoQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4v432h4KswnzyKqtipbimarmF9e7Mqa3M3b9Czy0JZY=;
 b=PetPPrU0ys37ww90vUisSI7+48XQ7+lXnemV2qugnXPejdsHPmpQNaFg0tUl6k8ACDI+sPSZ0VrX+A/XdSY4EieAR2JRF5FrlMK20svzGxx+7Y7oly9zfFpsdN+ObyO3Fvpt+2glZcdZBGoiRGUNnW2gUPyj8m93T4UJxWQQO+g=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BYAPR11MB3813.namprd11.prod.outlook.com (2603:10b6:a03:ff::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Tue, 19 Jul
 2022 06:29:08 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b%7]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 06:29:08 +0000
From:   <Conor.Dooley@microchip.com>
To:     <Tudor.Ambarus@microchip.com>, <p.yadav@ti.com>
CC:     <tudor.ambarus@gmail.com>, <vigneshr@ti.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <michael@walle.cc>
Subject: Re: [PATCH] MAINTAINERS: Use my kernel.org email
Thread-Topic: [PATCH] MAINTAINERS: Use my kernel.org email
Thread-Index: AQHYmzjZwPx3+h4lsE+Zp+/GIkBDAA==
Date:   Tue, 19 Jul 2022 06:29:07 +0000
Message-ID: <6b9a2433-12de-eee4-02a0-3cf9ea8843e4@microchip.com>
References: <20220718151243.1149442-1-p.yadav@ti.com>
 <165820520992.90015.1804934724521244853.b4-ty@gmail.com>
In-Reply-To: <165820520992.90015.1804934724521244853.b4-ty@gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d70726e9-52c2-4234-99b4-08da694ffc1e
x-ms-traffictypediagnostic: BYAPR11MB3813:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xZ4fv8tShoC/V2N/krydXtjHU71v/6+tcrmgyJVVHt398lC2QeByM3+lI3dqfCcrXtRXQksahGOZN5Oo3axZFrrBJXFmgzOKAsTohoxzgoYf2vEJCAQKseIR7SsJL0cL+3TMEaGkEyEdWSFiri0mrkVUQNphAaXCHU8pyLaHtGJMiFvaXKqeyuveOqQliZaLUj1qKf6xyTwjZ9T1+4PKiU99nbhrHRKzos2iELOKOs5ts1faTzX3BWVHm3EysAUJGo4nHh6dz+DJF37ZpueTdPo9KvowLJvwFWtzH5hpnplo2SYZ26W3VCpAAHaHuMWQJyBa7CIaI39l0cUkhYtNRLnV5+MH0PNyF6K+k/P2d9j+YAz9khk/n9xfubG+AAN2nojXgIL2+IMq6ucAi8BbBt3G4nlXipPozIWKjqwKHu2QZ/FX0zpUzL17IzP2gpjruP5Jm/KG9doTpwB3Ce3YM3uLMfGaMUDLUU8NdSoMaKl/7nLA3dRrXBG0A/A2Ig5RcjY5x6bwNGmREZEWTq5BAmFMNv39shECTkrQJFMDK6PLN7xw89sZnpTY0Guf1zjAS28+0oF193qK7dVOHJAiUebuF8UBivSAjh54k5aem+A8Y1PTXbmS/3NgZsrgHUkMd2TjKI3shz1tc+fkRRZsCkisFGQvVWDrAQwX+jRjOyTtPM4XZAZLQK8UIt1ScaKEZezGLzLzMlWeb5UNnXY9vlpTGa3ILep8WlACgYOEE8TqxQebF9W2EXrP0pd9YvRiZR1FAyJo9bDp2duMDmZzXvS9hO8U64gMXppjwiUgRUgOmEdNNnUv0lVOOaIBuEY+JwW6q+dePNYyEt11P0CUnnzssKj/EUX7lP8b/JMVl4+djRz+rjyYmUb9sD8eew3S1CdQhI8nNuDbOHxeRSHU3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(39860400002)(366004)(346002)(376002)(2906002)(31686004)(36756003)(5660300002)(8936002)(186003)(31696002)(86362001)(4744005)(4326008)(64756008)(66556008)(316002)(66476007)(8676002)(91956017)(76116006)(66446008)(6506007)(2616005)(26005)(53546011)(966005)(6486002)(41300700001)(6512007)(54906003)(110136005)(66946007)(38070700005)(122000001)(478600001)(38100700002)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUFsSU9uY1dNYWlpTlhtZ3lFd3E2Z2dSKzJMSC9vWks1clZEcjZ0T0hQaTNS?=
 =?utf-8?B?a1NEMjJpVlVqdGMxQjNGeXBBemJnTFNyYUxXV1VyT1YrNFhuQ1haVVR2M1hR?=
 =?utf-8?B?NGxyQnNFdnV6QXlheFNLU2dHa1lHeStsQTRvWUZQR3RFaUZXUVFhSWpEMW40?=
 =?utf-8?B?aDBSYko5MWM2NGRvSHJZdm5yaGdXQyttWjNDK0U5S09vQmR0aHMzbjZhZ1Y5?=
 =?utf-8?B?UXBITTZwOXo5Z3c2b1pScy9kVm1udFRtVDRTRUZNUFlhWFFlcXEwcVRDRUJK?=
 =?utf-8?B?UEJrd09NNmFBYXVFSUxrV1RjVXdwL09jcFpNb0t5TE5ZK011SEp0ei80WXRX?=
 =?utf-8?B?OXZJQmVsWnJ6NHVLMy9Od3BBN3MyZkNCKzVkeFB3ZGlKL2dmYVRmeHhrTUdr?=
 =?utf-8?B?MUpGRnR2SkdyTUgrN0NUalgvM3JhQWVuU0pGa2NPQXUwM0hJSXUzKzF3Y1dV?=
 =?utf-8?B?NWhndzVyeEhMckQrcSttaHU1UlMwcU9WYzltZlpSSHBnTHJCUnZnRENDZ2Ni?=
 =?utf-8?B?NVZxTTNCVXJTSFR4Z2FJVVozVFVHYWpGNTBQTmtHaldFTURnSFZwV2lmSWdQ?=
 =?utf-8?B?NExZaHRERXlJZHhBT09qUVY5R0pjOE5Qb0VGaHp4bjVuS3R3azJHUDZIS1FH?=
 =?utf-8?B?MWd2dmtTbU9mZk83RUcxelJzZEhrTTZxSmpTMEl6c2w2QzVzazhjTVc1Zk9h?=
 =?utf-8?B?RWVpUEtPVllsUnNjelBXSE9YbHZ5YUxNQjg2ZXRNcE5ZWGpheno2anQvQUF4?=
 =?utf-8?B?SHdRWEgvTkZuTXVVejc5NUcvTFpNY2p6bGszbFhpeDVwOGppOXJ3Z0pPdFhH?=
 =?utf-8?B?UnliS3VBV2JVRC9sRTI0ZXc5Yzlkb08xWkJGWmtvaHdkRWFsRWVtenJ6QVZw?=
 =?utf-8?B?aEUyZHIyd3FLQTJyYnlXa3dRV0d1UHBueVF3NTVBNzY3NVR4enUxQXkyV3Fy?=
 =?utf-8?B?R1VDVlRkdGIvc2xxZU5pYnh2U0V5cjUvZnpET3JZTlppeHkyM3lkRWhNc1dH?=
 =?utf-8?B?Yzd2QlJXelQ0OVRtcFk3eDc4cys1K0RaSGFRc0JjMEV3VWZzd2t1Zzc1RGJZ?=
 =?utf-8?B?N3MvSlJNY3RiRHN5T2xDM0JmaW9ybWVTVUh1T3ZiZmZWT1hvQytWWldEcElH?=
 =?utf-8?B?Y3Rpb2lwMVJqSFBxbEdJa2wzSTFxanVQcmZnSEJXckZZc1ZjSmRKdktma0pQ?=
 =?utf-8?B?aXZacGZCeFdOcURuSzE1NmtQenhuQVQzTlg3Rit4UzNjVlMwZEZvVzV4cFdZ?=
 =?utf-8?B?TFB5cFM1ZERqcVFQSmF6bGFkN05IMVVsQnNDQTYrb1RPTXBtQWYreWhXbmVr?=
 =?utf-8?B?NFhjNVY4UnBuM2h1NUVnejJVVld1Q3JSb2d6cTFxdlJJWDh2SDd5UE9jUHYz?=
 =?utf-8?B?WUxLeEticTBqUk44MlJJQ1Q4Q3ZUK2xlZmhQM3FvUldPenJBemRQaHJDY3Vl?=
 =?utf-8?B?VU1zMTE3RnowaHVrZ2dYR3M1bWRPUndDQlN1eHpzUWZndERPdXN1QUZCdWJq?=
 =?utf-8?B?MklTVUdUc1YwdW9iOXlONHozdTNZanpNZy9veENuUm1NempBMzBtdURKbGxk?=
 =?utf-8?B?c2FBK2dSQzJ0ZjNuc2Z6OXRWK3V5SVhLWHhvaVNXd253ak9EQjNNRHFMV20y?=
 =?utf-8?B?Vk9wcElONGhETGxLWkN6NjZLcHB1TDUrSldIN1NlY1N5SnJaSEk0OEN2elhs?=
 =?utf-8?B?MUUzV0Q5UmJqOXNuY0FNaVRYMEdMdlFiNVFpdWRGWjRaeFF5S1NaOTBTelBl?=
 =?utf-8?B?cHFZQkZBZ0hrSms1Z2FxczMyU0hmOFFuWDFidjV4UlVSbU5lYkFiY0R6U3Nh?=
 =?utf-8?B?OVhVVm9EMk5xemYrSk00a25zV3hPempKZ292dE9QSVI0T2RoeW9jMEZLK0dD?=
 =?utf-8?B?U3BEV0NWUGk4QUpGZTQxb2NwMUJLb1FjMjVDenl6clpTazV6TzAyVTZ5STRx?=
 =?utf-8?B?cVBnSWE2SVFWYm1tV2VVb0U4NmRkZWZMcFJTOFpUTDNwZ01Iek5PQ1N5QkE4?=
 =?utf-8?B?allsanVGZnBwNjU5TGZvK1FtSnRxVDltZVpFSjEvdGxhbGNYR0VkeVovMktO?=
 =?utf-8?B?SXkwNXUxYWpXZmdENUxQM1JRc3JWaUxaRyt1UzNnanU4a1VnOWVTNHllTkk3?=
 =?utf-8?Q?Emev+45aVgiXIUGlfD5bg73Ro?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <212DBE6E9AA4FA4BAC1B1A9F7D9211ED@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d70726e9-52c2-4234-99b4-08da694ffc1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 06:29:07.8918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iU5haB40N7LUEyZOlKB1pTa5pqb/c7Xk3wVJLerHGHPrJyeCuMuDFiZX846HSky4mwwCcip/E96iuY69pLnnbAlA2S+k5M50yhr66XfBiuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3813
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTkvMDcvMjAyMiAwNTozNCwgVHVkb3IgQW1iYXJ1cyB3cm90ZToNCj4gRnJvbTogVHVkb3Ig
QW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BnbWFpbC5jb20+DQo+IA0KPiBPbiBNb24sIDE4IEp1bCAy
MDIyIDIwOjQyOjQzICswNTMwLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4+IFVzZSB0aGUga2Vy
bmVsLm9yZyBlbWFpbCBJIGhhdmUgZm9yIHJldmlld2luZyBwYXRjaGVzLg0KPj4NCj4+DQo+IA0K
PiBBcHBsaWVkIHRvIHNwaS1ub3IvbmV4dCwgdGhhbmtzIQ0KPiANCj4gWzEvMV0gTUFJTlRBSU5F
UlM6IFVzZSBteSBrZXJuZWwub3JnIGVtYWlsDQo+ICAgICAgICBodHRwczovL2dpdC5rZXJuZWwu
b3JnL210ZC9jLzdkZTMwNzRiMjE4Zg0KPiANCg0KSGV5IFR1ZG9yLA0KSnVzdCBGWUkgdGhhdCBs
aW5rIGRvZXMgbm90IHJlc29sdmUgdG8gYW4gb2JqZWN0Lg0KRm9yZ2V0IHRvIHB1c2g/DQpUaGFu
a3MsDQpDb25vci4NCg==
