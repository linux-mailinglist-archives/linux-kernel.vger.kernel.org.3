Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA6F591FA7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 13:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiHNLle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 07:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiHNLlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 07:41:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9772DF5;
        Sun, 14 Aug 2022 04:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660477289; x=1692013289;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lWBh+W5+VPmlTEtWBEBhB6khlx0zCFicJkFtkLi8yQ0=;
  b=FV5LmkAoaBJwvLv65rpGwWwBMUKJGo+O5Enxab8zNgrMMQzgzfAUDSET
   nNl5qn8E1N9g6sXlpo+v9T6vMdY4sz+ToKNcjdi02RsN9SOxLYWCNo2C9
   LJlZWkfNGegj3RJsI9hbxsYNjPdXMxng0pntOAHABCUU301Ur/fl/GxV3
   QW+rFlo/F9l6vn6gXqbWvIfI2MjewIk+2pRF3RJlKGGfnsZDUYAS26W+v
   RvEg0mTm5obTkhIIYKA7RK5sHBgkgicLvnb4N/H/AkF+ZgK02UD+1u/Kc
   H+NgrZrLf7afD64cjV75ZeBv4laoOotXDyL76ZBpyyoPFuqkxd1mpsh48
   w==;
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="108944464"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Aug 2022 04:41:28 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sun, 14 Aug 2022 04:41:28 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Sun, 14 Aug 2022 04:41:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ya3qlf+enPXA0RmttuwHLhYrBlaBA6xG+qroF3ZkK88VQjUOJu8hAe2gHGMoo41BqRNdl2t2jW4BrOoUXVRY9CSfwhTR/OyXTAnnCENPvXzfTIeVH7rgEcOae2xHCGCUk7psGKYCvaaTzyoXgwox+bSMS42Cwn8dJg62rIKf1qFqHLs29YIKwwgGzbODvdcehdqjVj7O7Ncratk1kH3yycYkW2ETiy0k6PiUzpCcl6A+mcOkooqXp099yVrWjWdfwazI0USmiYEXrB9CeGavAPySTrpO2OVlK8cLm+JdIgWU8G3WXhuu2U1/AfuUkVFVtHOJeZbLsxwGM5KRlZSHpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWBh+W5+VPmlTEtWBEBhB6khlx0zCFicJkFtkLi8yQ0=;
 b=AiArIJclVrxkK+GnxjjBNKTnBhx2dXp2zFNWMGD4DIwm4hiU2Th+2utsedvCBzD2R663j+Cpva+6Dxa8tvNF4orgXOAZnp/Wit3cNa1GdXdthb0nG3hAQ3fgml9bbVl/C1/mRfm04pyFG8jqDqaY6eGCTIOsKOk2dc0zWxlo2W8SvpNfw4gYqA5o6+AE+lLxBKVeQIvDLfudUaRw3upVt9zRaQvzyBBvh+uhxs3R2VxNHXAkSWQn3AT4d3T/uUEKEC0/zcbTrcplxNb7duJHBjvAmk5kjjg5c0QjPaleXx46En4I4UqNriIhJNu3KDP/ujo+uxzl37wFoeT9W5RmPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWBh+W5+VPmlTEtWBEBhB6khlx0zCFicJkFtkLi8yQ0=;
 b=lbJSWa+0LqrJM3+cgbMC/zOltAosFSS1sEBgA2MBOv1nJcv3NqJzP7rfkMQw4zD7K19HAcnhh5uqxIAi3NeIyk13W/aVqXiT6SkgEtCgppJyzDdsqPgUnNIHGeoMrIdBHsuxP9Ci66tA+Ws0sX8fEDX09MRlywMRjfZM9GNqMO8=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SA2PR11MB4921.namprd11.prod.outlook.com (2603:10b6:806:115::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Sun, 14 Aug
 2022 11:41:20 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Sun, 14 Aug 2022
 11:41:19 +0000
From:   <Conor.Dooley@microchip.com>
To:     <nathan@kernel.org>
CC:     <ndesaulniers@google.com>, <llvm@lists.linux.dev>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <Daire.McNamara@microchip.com>,
        <palmer@dabbelt.com>
Subject: Re: [PATCH v2 00/12] PolarFire SoC reset controller & clock cleanups
Thread-Topic: [PATCH v2 00/12] PolarFire SoC reset controller & clock cleanups
Thread-Index: AQHYj5/vIrxOVV1EL0SoHOsgiQHkyK2nacwAgAFM1ACAAAaZgIAAA0QAgAADOwCAASU6AIAEnVYA
Date:   Sun, 14 Aug 2022 11:41:19 +0000
Message-ID: <42354fef-8ca8-a81d-6af9-f250ecfd1924@microchip.com>
References: <20220704121558.2088698-1-conor.dooley@microchip.com>
 <bd14f1a2-750d-2511-df0a-85a9f5925f84@microchip.com>
 <YvP/bjh+wXihlrdG@dev-arch.thelio-3990X>
 <fc470bf4-33bb-d67b-3860-3ac775982f27@microchip.com>
 <YvQHtGObJwyBKGCQ@dev-arch.thelio-3990X>
 <3d2c56fa-8245-4992-2074-cd39677c2b3f@microchip.com>
 <d38d8b9c-45da-c464-264c-bebd084bdb17@microchip.com>
In-Reply-To: <d38d8b9c-45da-c464-264c-bebd084bdb17@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e85eb2f-7fe6-4482-5b2a-08da7de9e781
x-ms-traffictypediagnostic: SA2PR11MB4921:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CmOtUFAKUYhuNcmHTMeewIEUAPdanCOaYOkATFBVAmqYZQYie9wPJQXKsJJL073kq8CXKpw2F9AkwqlYeZGGOrHzVdpg0mLLue3wE52+qOG9UJu930I4ptUIm+ydwUxkWWNpvs6OHsNBvAx3ERIUrIwyDefU3yDkTED8tV4G3TzYtmXL6sAoFGh/pzHZuLboGQEGM1oh4lPbS6QAYcRK3PGWroa1eTpu6kpvR7VAGgxDqlPgoOmZCpS5/auM5g0gnQBWxHphr75GgFx1ObGvCoW5mUjSZ3niEzVuqAwV0nXNgJOzkc8FTvCw4xQaOJpyQ8oXirPd/rD3o6WEfTSyb2spB4Zy3n4w4owk9/1T7xeQAax7Xf5xxmAQPGkU4m24wEmAy5eqP+bdzauE2cCxohWnmJSnSV1q6B8Ptmqqo491YZFKSz+k5XECJYc0dw6sRV3hkQad20ze1+bS+xw9awLOd8EXYOwOklnsXI5Xgt0PYwxwk52F+dOD0DBZJqVtN+YhgWVkQwMdColUVxRKvpYwy+l1TLioM/luXE5mOXZsQ5w/8conVp438p3py9TCl4aWHH8a0vE3QeRiqesSKxx3fG2v2DTspsxcnZkKIaaUw1SgesJIZ//qrjJLoJo+MdJoSOVc+9rCJRRQ6sCRkNPy02r9CoRFz1ndpuzyE463AJGZTCCHeC4XA64JUN6mesG5fll9B2JxX3Xrnh8xGQU9L8Sy9UIAjr/bG91/8OkTgjj0pzgiKX/S51qxseZuT2VZ86boshP8aPHFwzDY9AH3IsooM1tr9ioDtOqxRrp+GrdXQQYJKk2zYqWl+E2pH6h5ZGFXKyTJtr0EJElkO390kNydwoytUmblfnanZ/Ei+o5FuB+X+zgLzVFofIC6QE1Krq1K/flow2JOpyXiNg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39850400004)(376002)(366004)(396003)(346002)(136003)(26005)(2616005)(71200400001)(186003)(6506007)(6512007)(53546011)(31686004)(36756003)(41300700001)(966005)(6486002)(478600001)(38100700002)(38070700005)(4326008)(31696002)(83380400001)(86362001)(316002)(122000001)(5660300002)(7416002)(2906002)(8936002)(66946007)(6916009)(64756008)(91956017)(66556008)(8676002)(66446008)(66476007)(54906003)(76116006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXJoeGRBa2R4SkZLZDZyS1FCZTQ0OVBrZU5kVnh1VEtUY0RhYnVzakhhRWdM?=
 =?utf-8?B?WkRvbnJKZ0JMOGRlM1ZqcGVsUXRGL21wdnlTZlJtUm03YnpyaTUzbkZzYzFn?=
 =?utf-8?B?by9BYTNFWlZDU0U0STErWlI3NVl0bjFOUWV5TXNwdHNidjdDNU9MMDVPOUw4?=
 =?utf-8?B?WkFFOUVobUpQQlEyU0xMQStmVytHSEFrdzdJTW81QS9OT2RsZDQxdmEwbVpN?=
 =?utf-8?B?QzQ3TzdEbHB6TUJuQ1Y4bTFPTDEzZHhQNTdSNnQ0RGJaeUxYSDFIVDFPbXh5?=
 =?utf-8?B?WUhoTWtIQ2Q4TVRxSXJMMURSWlJQWEZPOWtRTndjaFEyNmlVeEtNRi9aTFJE?=
 =?utf-8?B?NVovMm16VkVWeUhSSTFzY1hOTWZiaU85NjduNlB3bmJQR1o2WmNuVFpDZGFr?=
 =?utf-8?B?VEZBWVp2Q1lKVWFCT0ExSW5Dd2pvUCtPcGNzSzZSUXlzK1RUdEF5b0lCcE9p?=
 =?utf-8?B?NmhxRmhSeGY3N29lZVR2b05sRG1EaXprajl5dVFGNHU4eWd2VHNScGU0SG03?=
 =?utf-8?B?NGRYR09qWjNUSUhXYWlPamVHMGNKZ3pEbVVtSEZXWWRERlk4TTZUOUs0MkpZ?=
 =?utf-8?B?cWxCVzRHRG9GaDg1RzRsN2hyNXJlNytBR0JEWXJqZVpEajFJWUEvUFZmNFQv?=
 =?utf-8?B?RUhGWllTSzg4UmV4N09QUThiNncya1IzLzNYblpwTldrNmhyME5pR28zK3di?=
 =?utf-8?B?bWE3ZEk4ODNHV0xDckJzQW9JVHhwZk9pa2RaMitBRnJDcG13M3ovRWxSeUY3?=
 =?utf-8?B?YnhydDNrMk1oK3liaHNzS0Znb0lDelI0RFcxUk51M2M2eXRwMUhXNXNnSjUy?=
 =?utf-8?B?VG9yUmlTODliejdwM3NaVFgzVUp0QmJwQmVDZitRbkNhOHIwQ2FJY2Y3cVdG?=
 =?utf-8?B?cCt1U0ZPS2tVZlVoU2hTQ2dLa2VseUVxUEFkMTV3cEl5Njc0NjBQS1BNdkY0?=
 =?utf-8?B?SUVrK29qaWlYQktHamhWeGpGN1VBWVduS1BKK1I5Uzh5SzRNZ2hLYmZwTVho?=
 =?utf-8?B?N243WUphRFNGSTQ3dHRBRm5ZZFYxU24rTG5yUVM3aHlhYkRvbCs0MFlNclYr?=
 =?utf-8?B?Um8wdG1GR3FLOVdiYWhTL3Y3bDlhWlZWRSsvUDFpeE5OSzdNSStkdWNRM1dm?=
 =?utf-8?B?MCtGeGdYYVp5Wmg1QmlzandkVFRrQnJYWUR6bW41bWczT3l4ZHRXbS9BeGhQ?=
 =?utf-8?B?SkgrNFRHcVNrbFBNMUM0aGJWaUdjR0FmY2JhbGV0ZjhyeTVkVWNjVllwQWpM?=
 =?utf-8?B?Zk44MmRhcWUzYXNPUG9US1pqRzZ4NXVVTzE1NysrZkFBM2lYYnZ0YzNZT0tw?=
 =?utf-8?B?eFZHd0xNVGZEODJSL3NvUm5ScmlrZ0xwWFB5SzFEeXlrUTY2Rk1iTXpDM3RS?=
 =?utf-8?B?NkwvS1dSUFZURHBYUUJEUm50S1dFYjY0SHFWZU5SaUdKL1dEWUkydHdwZHJV?=
 =?utf-8?B?cmF2UHZsZjQvTmNOVTlqWkRKSDlmUHVid0VMM2lCU0hpTEVLN08zTXE4OWhv?=
 =?utf-8?B?YVpkOWU2N0lVeElORGJMZWRuUmpzY0FIclcxNTRNYVJKRWJDWWJPNngzYmxP?=
 =?utf-8?B?UzVTOHFVYktGb0IxbGErOUFzVElpTEwyaTZuR0ZRVjNXa0NFTXNxWWNGbFda?=
 =?utf-8?B?T3NnMHJPNWhNZHdFVVRQSzh2Uld2TFN1OWJMWU9Xemw0L3U3ZkE4NEd1bFR4?=
 =?utf-8?B?RlZyT2oyMHUyUjFUdmloNGlZbmlOQUdTaUxvckpYNmd6QTRadVIza2Juc0RJ?=
 =?utf-8?B?T0lFOWM0VVhoemI0cUdwTm5Ic1pNbkd0cjFkWlgvMnBrNFN6cTAwK3JyQWgx?=
 =?utf-8?B?dlNYbzBFcGdpKzJiUERLdmFtbThVZWEreHFNR24zb2NjQ2VOYjNWeTZVMkR0?=
 =?utf-8?B?UHg5ZVJ0bHBsN1R4ZXgwb3gzQVkrdS9iL3RJQld1VTViOGhhVlVZSlJyM0Fv?=
 =?utf-8?B?T2EzZGFVQkxuYkpxYXVyV24xUEs4eEg1aUkyWTVNNk00VTljdDBWdGNteXhE?=
 =?utf-8?B?Wm9jZlBwc0JBTDFreWpYZkdtaDFhZmNSOEtQajNkeXpvdnQ4MzVCSWZ5VkdZ?=
 =?utf-8?B?ejRxckpVeXJJaURhRG94OWhiOGdBTDhwV2lhY1VTa0dEWkdSSDdvMkVwRTE2?=
 =?utf-8?Q?WZfQP0Mmsg2uu8Bg6XYJEgSjG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <010B1817EAA32E4D8EC1DB27C848BA4C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e85eb2f-7fe6-4482-5b2a-08da7de9e781
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2022 11:41:19.1057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9jx28YJfagKxWibeKKpWAboaUGRHwSjw/JtclMsdGgVzflNN3niir1hxYqeB840yPbtuE0gcRJSgFcy8WA1MW9BGqoEXefQ1nu0MvRcnOw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4921
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMDgvMjAyMiAxNDoxMywgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBIZXkgTmF0aGFuLA0K
PiANCj4gT24gMTAvMDgvMjAyMiAyMDo0MywgQ29ub3IgRG9vbGV5IC0gTTUyNjkxIHdyb3RlOg0K
Pj4gT24gMTAvMDgvMjAyMiAyMDozMiwgTmF0aGFuIENoYW5jZWxsb3Igd3JvdGU6DQo+Pj4gT24g
V2VkLCBBdWcgMTAsIDIwMjIgYXQgMDc6MjA6MjRQTSArMDAwMCwgQ29ub3IuRG9vbGV5QG1pY3Jv
Y2hpcC5jb20gd3JvdGU6DQo+Pj4+IE9uIDEwLzA4LzIwMjIgMTk6NTYsIE5hdGhhbiBDaGFuY2Vs
bG9yIHdyb3RlOg0KPj4+Pj4gSGkgQ29ub3IsDQo+Pj4+Pg0KPj4+Pj4gT24gVHVlLCBBdWcgMDks
IDIwMjIgYXQgMTE6MDU6MzJQTSArMDAwMCwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20gd3Jv
dGU6DQo+Pj4+Pj4gK0NDIGNsYW5nIHBlb3BsZSA6KQ0KPj4+Pj4+DQo+Pj4+Pj4gR290IGFuIG9k
ZCBvbmUgaGVyZSBhbmQgd291bGQgYXBwcmVjaWF0ZSBzb21lIHBvaW50ZXJzIGZvciB3aGVyZSB0
bw0KPj4+Pj4+IGxvb2suIFRoaXMgY29kZSB3aGVuIGJ1aWx0IHdpdGggZ2NjIGJvb3RzIGZpbmUs
IGZvciBleGFtcGxlIHdpdGg6DQo+Pj4+Pj4gcmlzY3Y2NC11bmtub3duLWxpbnV4LWdudS1nY2Mg
KGc1OTY0YjVjZDcyNykgMTEuMS4wDQo+Pj4+Pj4gVGhlIHNhbWUgY29kZSBidXQgYnVpbGQgd2l0
aCBjbGFuZyBidWlsZCBpdCBmYWlscyB0byBib290IGJ1dCBwcmlvciB0bw0KPj4+Pj4+IHRoYXQg
YXBwbHlpbmcgdGhpcyBwYXRjaHNldCBpdCBib290cyBmaW5lLiBTcGVjaWZpY2FsbHkgaXQgaXMg
dGhlIHBhdGNoDQo+Pj4+Pj4gImNsazogbWljcm9jaGlwOiBtcGZzOiBtb3ZlIGlkICYgb2Zmc2V0
IG91dCBvZiBjbG9jayBzdHJ1Y3RzIg0KPj4+Pj4+DQo+Pj4+Pj4gSSBhcHBsaWVkIHRoaXMgcGF0
Y2hzZXQgb24gdG9wIG9mIHRvbmlnaHQncyBtYXN0ZXIgKDE1MjA1YzI4MjljYSkgYnV0DQo+Pj4+
Pj4gSSd2ZSBiZWVuIHNlZWluZyB0aGUgc2FtZSBwcm9ibGVtIGZvciBhIGZldyB3ZWVrcyBvbiAt
bmV4dCB0b28uIEkgdHJpZWQNCj4+Pj4+PiB0aGUgZm9sbG93aW5nIDIgdmVyc2lvbnMgb2YgY2xh
bmcvbGx2bToNCj4+Pj4+PiBDbGFuZ0J1aWx0TGludXggY2xhbmcgdmVyc2lvbiAxNS4wLjAgKDVi
MDc4OGZlZjg2ZWQ3MDA4YTExZjZlZTE5YjlkODZkNDJiNmZjZmEpLCBMTEQgMTUuMC4wDQo+Pj4+
Pj4gQ2xhbmdCdWlsdExpbnV4IGNsYW5nIHZlcnNpb24gMTUuMC4wIChiYWI4YWY4ZWEwNjJmNjMz
MmI1YzVkMTNhZTY4OGJiODkwMGYyNDRhKSwgTExEIDE1LjAuMA0KPj4+Pj4NCj4+Pj4+IEdvb2Qg
dG8ga25vdyB0aGF0IGl0IHJlcHJvZHVjZXMgd2l0aCBmYWlybHkgcmVjZW50IHZlcnNpb25zIG9m
IExMVk0gOikNCj4+Pj4+DQo+Pj4+Pj4gSXQncyBwcm9iYWJseSBzb21ldGhpbmcgc2lsbHkgdGhh
dCBJJ3ZlIG92ZXJsb29rZWQgYnV0IEkgYW0gbm90IGF1DQo+Pj4+Pj4gZmFpdCB3aXRoIHRoZXNl
IHNvcnQgb2YgdGhpbmdzIHVuZm9ydHVuYXRlbHksIGJ1dCBoZXkgLSBhdCBsZWFzdCBJJ2xsDQo+
Pj4+Pj4gbGVhcm4gc29tZXRoaW5nIHRoZW4uDQo+Pj4+Pg0KPj4+Pj4gSSB0b29rIGEgcXVpY2sg
Z2xhbmNlIGF0IHRoZSBwYXRjaCB5b3UgbWVudGlvbmVkIGFib3ZlIGFuZCBJIGRvbid0DQo+Pj4+
PiBpbW1lZGlhdGVseSBzZWUgYW55dGhpbmcgYXMgcHJvYmxlbWF0aWMuLi4NCj4+Pj4NCj4+Pj4g
WWVhaCwgSSBjb3VsZG4ndCBzZWUgYW55IGxvdyBoYW5naW5nIGZydWl0IGVpdGhlci4NCj4+Pj4N
Cj4+Pj4+IEkgd2FzIGdvaW5nIHRvIHNlZSBpZiBJIGNvdWxkDQo+Pj4+PiByZXByb2R1Y2UgdGhp
cyBsb2NhbGx5IGluIFFFTVUgc2luY2UgSSBkbyBzZWUgdGhlcmUgaXMgYSBtYWNoaW5lDQo+Pj4+
PiAnbWljcm9jaGlwLWljaWNsZS1raXQnIGJ1dCBJIGFtIG5vdCBoYXZpbmcgbXVjaCBzdWNjZXNz
IGdldHRpbmcgdGhlDQo+Pj4+PiBtYWNoaW5lIHBhc3QgU0JJLiBEb2VzIHRoaXMgcmVwcm9kdWNl
IGluIFFFTVUgb3IgYXJlIHlvdSB3b3JraW5nIHdpdGgNCj4+Pj4+IHRoZSByZWFsIGhhcmR3YXJl
PyBJZiBRRU1VLCBkbyB5b3UgaGFwcGVuIHRvIGhhdmUgYSB3b3JraW5nIGludm9jYXRpb24NCj4+
Pj4+IGhhbmR5Pw0KPj4+Pg0KPj4+PiBZZWFoLi4uIFNvIHRoZXJlIHdhcyBhIFFFTVUgaW5jYW50
YXRpb24gdGhhdCB3b3JrZWQgYXQgc29tZSBwb2ludCBpbg0KPj4+PiB0aGUgcGFzdCAoaWUgd2hl
biBzb21lb25lIHdyb3RlIHRoZSBRRU1VIHBvcnQpIGJ1dCBtb3N0IHBlcmlwaGVyYWxzDQo+Pj4+
IGFyZSBub3QgaW1wbGVtZW50ZWQgYW5kIGN1cnJlbnQgdmVyc2lvbnMgb2Ygb3VyIG9wZW5TQkkg
aW1wbGVtZW50YXRpb24NCj4+Pj4gcmVxdWlyZXMgbW9yZSB0aGFuIG9uZSBvZiB0aGUgdW5pbXBs
ZW1lbnRlZCBwZXJpcGhlcmFscy4gSSB3YXMgdHJ5aW5nIHRvDQo+Pj4+IGdldCBpdCB3b3JraW5n
IGxhdGVseSBpbiB0aGUgZXZlbmluZ3MgYmFzZWQgb24gc29tZSBwYXRjaGVzIHRoYXQgd2VyZSBh
DQo+Pj4+IHllYXIgb2xkIGJ1dCBubyBqb3kgOi8NCj4+Pg0KPj4+IEhlaCwgSSBndWVzcyB0aGF0
IHdvdWxkIGV4cGxhaW4gd2h5IGl0IHdhc24ndCB3b3JraW5nIGZvciBtZSA6KQ0KPj4+DQo+Pj4+
IEknbSBydW5uaW5nIG9uIHRoZSByZWFsIGhhcmR3YXJlLCBJJ2xsIGdpdmUgdGhlIG9sZGVyIGNv
bWJvIG9mIHFlbXUNCj4+Pj4gImJpb3MiIGV0YyBhIGdvIGFnYWluIG92ZXIgdGhlIHdlZWtlbmQg
JiB0cnkgdG8gZ2V0IGl0IHdvcmtpbmcuIEluIHRoZQ0KPj4+PiBtZWFudGltZSwgYW55IHN1Z2dl
c3Rpb25zPw0KPj4+DQo+Pj4gQXJlIHlvdSBidWlsZGluZyB3aXRoICdMTFZNPTEnIG9yIGp1c3Qg
J0NDPWNsYW5nJz8gSWYgJ0xMVk09MScsIEkgd291bGQNCj4+PiB0cnkgYnJlYWtpbmcgaXQgYXBh
cnQgaW50byB0aGUgaW5kaXZpZHVhbCBvcHRpb25zIChMRD1sZC5sbGQsDQo+Pj4gT0JKQ09QWT1s
bHZtLW9iamNvcHkpIGFuZCBzZWUgaWYgZHJvcHBpbmcgb25lIG9mIHRob3NlIG1ha2VzIGENCj4+
PiBkaWZmZXJlbmNlLiBXZSBoYXZlIGhhZCBzdWJ0bGUgZGlmZmVyZW5jZXMgYmV0d2VlbiB0aGUg
R05VIGFuZCBMTFZNDQo+Pj4gdG9vbHMgYmVmb3JlIGFuZCBpdCBpcyBtdWNoIGVhc2llciB0byBs
b29rIGludG8gdGhhdCBkaWZmZXJlbmNlIGlmIHdlDQo+Pj4ga25vdyBpdCBoYXBwZW5zIGluIG9u
bHkgb25lIHRvb2wuDQo+Pg0KPj4gTExWTT0xLg0KPj4NCj4+Pg0KPj4+IE90aGVyd2lzZSwgSSBh
bSBub3Qgc3VyZSBJIGhhdmUgYW55IGltbWVkaWF0ZSBpZGVhcyBvdGhlciB0aGFuIGxvb2tpbmcN
Cj4+PiBhdCB0aGUgZGlzYXNzZW1ibHkgYW5kIHRyeWluZyB0byBzZWUgaWYgc29tZXRoaW5nIGlz
IGdvaW5nIHdyb25nLiBJcw0KPj4+IHRoZSBvYmplY3QgZmlsZSBiZWluZyBtb2RpZmllZCBpbiBh
bnkgb3RoZXIgd2F5IChJIGRvbid0IHRoaW5rIHRoZXJlIGlzDQo+Pj4gc29tZXRoaW5nIGxpa2Ug
b2JqdG9vbCBmb3IgUklTQy1WIGJ1dCBJIGNvdWxkIGJlIHdyb25nKT8NCj4+DQo+PiBJJ2xsIGdp
dmUgdGhlIG9wdGlvbnMgYSBnbyBzbywgSSdsbCBMWUsgaG93IEkgZ2V0IG9uLg0KPiANCj4gU28g
SSBtYW5hZ2VkIHRvIHdyYW5nbGUgUUVNVSBpbnRvIHJlcHJvLWluZy4gYm9vdGluZyB3aXRoIGJv
b3Rsb2FkZXJzDQo+IGV0YyBpc24ndCBnb2luZyB0byB3b3JrIChub3Igd2lsbCB0aGUgY29uZmln
IHdpdGggZ2NjIGFjdHVhbGx5IGJvb3QNCj4gcHJvcGVybHkpIGJ1dCBpdCBnZXRzIGZhciBlbm91
Z2ggdG8gcmVwcm9kdWNlIHRoZSBwcm9ibGVtLg0KPiBZb3UndmUgZ290IHRvIGp1bXAgcmlnaHQg
dG8gdGhlIGtlcm5lbCBmb3Igd2hpY2ggdGhlIG1hZ2ljIGluY2FudGF0aW9uDQo+IGlzOg0KPiAN
Cj4gJChRRU1VKS9xZW11LXN5c3RlbS1yaXNjdjY0IC1NIG1pY3JvY2hpcC1pY2ljbGUta2l0IFwN
Cj4gwqDCoMKgwqAtbSAyRyAtc21wIDUgXA0KPiDCoMKgwqDCoC1rZXJuZWwgJCh3cmtkaXIpL3Zt
bGludXguYmluIFwNCj4gwqDCoMKgwqAtZHRiICQod3JrZGlyKS9yaXNjdnBjLmR0YiBcDQo+IMKg
wqDCoMKgLWRpc3BsYXkgbm9uZSAtc2VyaWFsIG51bGwgXA0KPiDCoMKgwqDCoC1zZXJpYWwgc3Rk
aW8NCj4gDQo+IChzZXJpYWwwIGlzIGRpc2FibGVkIGluIHRoZSBkdCkNCj4gDQo+IFdpdGggZ2Nj
IHRoZXJlJ2xsIGJlIGEgYnVuY2ggb2Ygd2FybmluZ3MgbGlrZToNCj4gY2xrX2FoYjogWmVybyBk
aXZpc29yIGFuZCBDTEtfRElWSURFUl9BTExPV19aRVJPIG5vdCBzZXQNCj4gVGhhdCdzICJmaW5l
Iiwgbm90IHN1cmUgaWYgaXQncyB0aGUgbGFjayBvZiBib290bG9hZGVycyBvciB0aGUNCj4gZW11
bGF0aW9uIGJ1dCAwIGlzbid0IGEgdmFsdWUgdGhlIGhhcmR3YXJlIHdpbGwgc2VlLiBXaXRoIHRo
ZSBkZWZjb25maWcNCj4gSSBwcm92aWRlZCBpdCdsbCBmYWlsIHRvIGJvb3QgZmFpcmx5IGxhdGUg
b24gYmVjYXVzZSBvZiBtaXNzaW5nIG11c2INCj4gZW11bGF0aW9uLg0KDQpGV0lXLCBJIHBvc3Rl
ZCBhIFFFTVUgcGF0Y2ggdG8gZml4IHRoZSBtaXNzaW5nIHBlcmlwaGVyYWxzLCBzbyBhIGRpcmVj
dA0Ka2VybmVsIGJvb3Qgd29ya3Mgbm93IGZvciBHQ0M6DQpodHRwczovL2xvcmUua2VybmVsLm9y
Zy9xZW11LWRldmVsLzIwMjIwODEzMTM1MTI3LjI5NzE3NTQtMS1tYWlsQGNvbmNodW9kLmllDQoN
CihidHcsIEkgYW0gb24gbGliZXJhIGFzIGNvbmNodW9kIGluICNyaXNjdiBpZiB5b3UgZXZlciB3
YW5uYSBwaW5nIG1lIGFib3V0DQpzb21ldGhpbmcsIHVzdWFsbHkgc3RpbGwgYWJvdXQgZm9yICJz
YW5lIiBOQSB3b3JraW5nIGhvdXJzIHRvbykNCg0KPiANCj4gRG9lc24ndCByZWFsbHkgbWF0dGVy
IHNpbmNlIHRoYXRzIGxvbmcgZW5vdWdoIHRvIGdldCBwYXN0IHRoZSBzd2l0Y2gNCj4gb3V0IG9m
IGVhcmx5Y29uIHdoaWNoIGlzIHdoZXJlIHRoZSBjbGFuZyBidWlsdCBrZXJuZWwgZGllcy4NCj4g
DQo+IERpZG4ndCBnZXQgYSBjaGFuY2UgdG8gbG9vayBhdCBkaXNhc3NlbWJseSBldGMgdG9kYXks
IGJ1dCBhcyBJIHNhaWQNCj4gbGFzdCBuaWdodCBpdCByZXByb2R1Y2VzIHdpdGggR05VIGJpbnV0
aWxzLg0KPiANCj4gVGhhbmtzLA0KPiBDb25vci4NCj4gDQo+IE9uIGFub3RoZXIgbm90ZSwgYnJv
dWdodCB1cCBvdXIgUUVNVSBwb3J0J3Mgc3RhdGUgdG9kYXkgc28gZml4aW5nDQo+IGl0IGlzIG5v
dyBvbiB0aGUgZ29vZCBvbGUsIGV2ZXIgZXhwYW5kaW5nIHRvZG8gbGlzdCA6KQ0KDQo=
