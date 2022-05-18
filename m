Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2767552BCE6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237261AbiERMoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 08:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237431AbiERMoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 08:44:19 -0400
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2CF1B1F5E
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 05:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1652877581; x=1684413581;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IcDrf88xCR0D8TlKSE5H8YuPG3hYhxaeqW64D5AyNV4=;
  b=uEKiDBCJ9+/LjDx93mTPBwh6JEkO8GGatf1svM/UMgF+B1phbyssm2P+
   nBnFmR2W58gkyoerRkhwcf7icEaQHagBGvf4woeU44u13FlVoy81egZlk
   yjHIDQj042hnNCkhYdxmMpCrtqFda9wxyEUWXNLMcJEn66263r3dXhzDJ
   NpvJZ50xq55Mk41zcP/7SqLdZCEM5AZFOaJeOlqFnQlv14rIGLwXyr1i9
   b7+15YoFDfCgcSxpk49msaRVV816ABAHpqjFo9j8bgWo1hW8vGJj/r/m0
   vendSIBIC+bTgpHNCyK8sEnmKOAuHKmMi29nnFVxeXlWWWd5ay3m8hcCf
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="56166590"
X-IronPort-AV: E=Sophos;i="5.91,234,1647270000"; 
   d="scan'208";a="56166590"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 21:38:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z01AkGmSXwUA7d2pDve4HOhDIS/AICw2BlzXbNrAz/4Gu8E3MlK0CgyoICJ6PnTXb4telDuxbTa5A0CVoOH1PzuDnAxN+7ICeAlacS4lH7zziMuDhcQPYJRcXOVriVst1w2sN7hUkIHGVDPnAN4euENONk6U1+WL98W9yED4qYItrDLbzLXcvNcIKx63gAqxhm24/dOVbtXJvVlX6DxVtOrD9TUdpKz0tu8rYuJsibQaoqx5YZn/NX75L8auYr+aWuOndMTLVfGVGuJLepp4d1YKlPZZ1usSxI2939qWW1dYqUEi1icqzhys0QHDX+rxEvjIEZz0GL6FqKWcDALKyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5wrY1KEj6/Tc1y9Ix4Tk3rCh+YlhIkGT2k/uw39zU8=;
 b=JllrDhRT2D9LmDUdKafKIifxomq+DH4YlTSY6Zu9PLBLY1f6Bd2B+TVMCbfF2H8468mN74PCBXDJYCGrP7+WvUgxGxO3B7M6XQuf78SBAMd6YiGEOlB4ZsrazppcBxDrdsH0G1Buw5k8f9xopYqf72dr8D6vGn92cjj2XovMtZrG7h9/HwJAy8nAvcMnKA944ejM1cqN7r4+VhfM/9CxToLw1l3yXSFtWnqj91oiWw3eobeAJtC/uCPNzicFDDPSvjLOVRPSeuVLc464e0t+4my7KDS+1mwGCPdWqhDoKLurupfQ1E4t/i/RZ6G4Ftk5ol7eFm0+U956y69S5eZeig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5wrY1KEj6/Tc1y9Ix4Tk3rCh+YlhIkGT2k/uw39zU8=;
 b=m+iSFog/FFplRxMaIWgxJjKzoILwcVy0n1DYrWUYoLkW1DY+TA9zXD8Y7tf8IBUoKkbEpXzbVj6kpNMpV0otMQkU7kPN2qGRE+uPvv16/G2TXOkJ8Xfy+Pn86h6pc/czNxb2dt8vufWhOy4CNpTbkS41g2R9dLa7sNVuvteF7Io=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by TY1PR01MB1836.jpnprd01.prod.outlook.com (2603:1096:403:1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 18 May
 2022 12:38:02 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::a041:7644:4eca:ec8]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::a041:7644:4eca:ec8%7]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 12:38:02 +0000
From:   "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
To:     'Greg KH' <gregkh@linuxfoundation.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "eugenis@google.com" <eugenis@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "pcc@google.com" <pcc@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "marcos@orca.pet" <marcos@orca.pet>,
        "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "marcan@marcan.st" <marcan@marcan.st>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 1/8] drivers: base: Add hardware prefetch control core
 driver
Thread-Topic: [PATCH v4 1/8] drivers: base: Add hardware prefetch control core
 driver
Thread-Index: AQHYaoDl8CSHsFy4xEexv5ItLZ1gVa0kN1gAgABT8sA=
Date:   Wed, 18 May 2022 12:38:02 +0000
Message-ID: <OSBPR01MB203742A3195333D0E8785E5A80D19@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <20220518063032.2377351-1-tarumizu.kohei@fujitsu.com>
 <20220518063032.2377351-2-tarumizu.kohei@fujitsu.com>
 <YoSbmA+5m1Le0XGe@kroah.com>
In-Reply-To: <YoSbmA+5m1Le0XGe@kroah.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad072bfd-e403-4b41-83a4-08da38cb3fbf
x-ms-traffictypediagnostic: TY1PR01MB1836:EE_
x-microsoft-antispam-prvs: <TY1PR01MB18368399C4EEC33D729D7D0D80D19@TY1PR01MB1836.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j1sJe73kAphdkEa9Sfa6z5oo/T0++kngQIXxQqUXwXl7X3HzHnPyl0d83Uga78S13UftXfy6s511ANzmQXFi3TdWNvEP1AqrCPTWVdF0IjfRly3XGKpvZB+EgKm0OustBLOP9fFBq8aiWGVUxypT1/BzPduiIBJqjlJNdetnXJgWwPghW6v7nDezY2SKD99aPp8vSHjxLoaNOssFiiZqbTpMl44oM6bcfyBXZ52+BL6ncF8zWegJIcSSuM+DGoOtAmzdoNwmMrDucVDJmX0ac1kEq30kvErOvFmWEuHSuD/uYpkTx8M3wlZ3GdaNkKOX2il2732pPMgN70xXg+GsEe4iMghSvKJLN6Undr0wFwvoIDGgZZ8yh6mLmlw+c099BbAfNuUvVdPdAnVx5EfABbp6x1jPivCj28U3o0u0otOfP8w1AQd/eyOuJYMrn1XenRkHnGpqRyacJYzQuKQn0I/HoJkzmIZXa/v/65p8qF5gzYV5Yr4bbrTMXyV4YDALrwMgnrLHvwGpP2bve6WkN9GSFjxzxlInF5X33GmE5LGJGfj+SQD7b9VfXfMafnsKITGmJnYiusP1Zpua78BIPnosB9DEYu0pgthIq3w8EksOreo8J3c60zI+nxp16kPaxds3sU+FnVxV5lZojsbOMWQsznOSgDeRlmWNUijx3hFTgDO2pyxsR6E0sv7EQSGU8HJ5RoEVVyi91PecJ0y67w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(6916009)(8936002)(316002)(52536014)(8676002)(64756008)(82960400001)(66556008)(55016003)(66946007)(76116006)(66446008)(5660300002)(71200400001)(4326008)(33656002)(508600001)(122000001)(7416002)(38070700005)(38100700002)(66476007)(85182001)(7696005)(26005)(9686003)(86362001)(6506007)(186003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?REg1ZEZDWHV2WkNEQkdRVmtOU0dJaWJKOFE1MVZvK1RhczRDL1dFYWZi?=
 =?iso-2022-jp?B?NG83K1pnV2ZkeDk1TWRycFlVL0lqamlYQXRmQkhCZkd1MTlGYW9uQXRF?=
 =?iso-2022-jp?B?MlE5T2VwN2NoOWlGbEl2VVIvTTF5aE1IQUozSGo3UElWQ2ZoeHg4dGky?=
 =?iso-2022-jp?B?VFM3Y1lVdlE3RjljTjlsVHBYTDNLNXdRYjl4TGo1Rk42ai90b1BlRFE0?=
 =?iso-2022-jp?B?NzRNelBmQm41WDFzMHROYklRR1h4M3kwMXA5WXI5UlJGRGcwZkdVZGU2?=
 =?iso-2022-jp?B?S0xnM1J3dS9obTFaOFFNbk9tdHNXOGF2a1BETStOb1JTemNQb2EraXY2?=
 =?iso-2022-jp?B?cUZsT3ZZN2Nsc1dobnlxeFJzZktzY3JsVEF2S3J2c2RyME1SbFkwRVc4?=
 =?iso-2022-jp?B?T2F0VjY4SklCWktEZWEvK3JCSWdwZ3lmekRQWFVTWWdxMEFodG5SOE5k?=
 =?iso-2022-jp?B?QTFCVXlaZ1JvaWgzTWU0R2hzVGNKSFl4QUltcjN1Z1hRazMxMHl1S3dS?=
 =?iso-2022-jp?B?cXpzMkFha1FZTnM3YW5wVTJoNlBpZ1lwMHNUR1BYWWl6WlBKK3BTd3Jr?=
 =?iso-2022-jp?B?dkl2bXZydStjVW5ocUdYQ0I3YWhrM3hXR3I4blpIbnJTMlpYNU9wZ0hw?=
 =?iso-2022-jp?B?YzM0Q0NQQnRsMjdyVEFnTzYyRER2cmYwOXVxODNQa01rTGdTUEt4bGxz?=
 =?iso-2022-jp?B?bkVwTWw3TzltYnV6ak9VUGRNZEdvS2pCNmJQZ1JyNytsVTRYQ2RVYzhQ?=
 =?iso-2022-jp?B?dnlDNTVLSGh6eE42WVREVUJtSVgxTktETnNEbHErMVNEU2dPbDVDSGV4?=
 =?iso-2022-jp?B?cDdZbnl6RVp2ZDQ3enhyWWtCdVlYS1RlakM4VmxCYVdZVkhyZS91eE9s?=
 =?iso-2022-jp?B?TVh2Q05Tb3RhK1d2Smx0QW5mZHIvc3pUdFcwMDdVb0pOU20xYXlFY3JX?=
 =?iso-2022-jp?B?U1cvcTkrc1VJY2M4OVVGYlJVRGtvVUx3MWFVUU85ZmlBQlh1TFpoc2tL?=
 =?iso-2022-jp?B?aWZTVXVZUWZxajdxcEhpQVUxOTdNeFZnL0J3WlJPRy9WNDJTdDhjWkFS?=
 =?iso-2022-jp?B?T1ZiY1JOc1BVSjZ0T0RDYUFveVFONlN3VEZJREtSRlJHRytILzA1NTZL?=
 =?iso-2022-jp?B?TEVUeUpvSEZlcXo0eStsTTJ6MDZtZ0dRdXhheVRJUUVXRTVzUFpCbEpU?=
 =?iso-2022-jp?B?SjVndlFveDVIRStwdmJoMU4wa3IyMVBDQzVZTmRCUUxLYVZIZlM3WFFw?=
 =?iso-2022-jp?B?SW1rSzg4T1RPTjZ6MHNrbFd6NndKS0diejJORExFczFaNWFpY1BJbXdN?=
 =?iso-2022-jp?B?aVJ1Q0JSRDdtYTNwTmxncGJtMTBvQ3hTNWJVUFNuMUUrU3NWRXlVMTFa?=
 =?iso-2022-jp?B?RUFnWURSL1VYUnkxQy80Z01WaDd4d1M5TTZVTWxHVWNySURWOVlIWnVS?=
 =?iso-2022-jp?B?S25pNW1LZzROYTk3NjdhRVlEMVpsSE5QMGdDN1RJRjRUMitNZHVVeFBh?=
 =?iso-2022-jp?B?QkZIUEpFMnJaN1dCTVJCeWY4bUVTMitIZC8rUVJseXUzaGY3Q2xnaVFC?=
 =?iso-2022-jp?B?WlNMWFV5T0ZPRnA3M08rUlp0UE5wNGU2bXhabU1obGF4NHgyUVB5Wmll?=
 =?iso-2022-jp?B?eWdvdmNFclB0Q0hMb3cwRXhDdGhxNC9Rbk10ak90ckxQSjFyVkJBbFcx?=
 =?iso-2022-jp?B?dDlMVEFTN2tTUGJ4bkhsdGdrcmI2RFFqdmV6R1pRYlRCWlV2YXNVN2Mv?=
 =?iso-2022-jp?B?MDEyYVFhNGMwazJUTTJ3b2tONTRmVXdqMmNycU51ektZTWZvWDVmbDM0?=
 =?iso-2022-jp?B?MlJlVkNsc3RONTRLWUE1TURVSHBSeVU0TTVjaWhzSnE4TklmMlZUWlYy?=
 =?iso-2022-jp?B?ZVpCMTBNSUNnVVpYODgxWEZPK3p2bSsvYmVvZmNEVUptL1NrY0dGRDJm?=
 =?iso-2022-jp?B?TmV0M1BENkx5aC9OTWZIOWwrYTd1UTF1TXpkcXJRK3Bkc0hnUkpDWDVQ?=
 =?iso-2022-jp?B?V3FreFZaenBlZi9tb3QrQitWdW0rTXhtUmhGRGhua1Q2ZUhlUWJwUTZR?=
 =?iso-2022-jp?B?d2szM1RKK0p6eHFkM1I1OHA5Vkxoa1ZTUFFKa2VuUENLYTgweTlhclJz?=
 =?iso-2022-jp?B?a3hQd0dYeEk5YXFGWitvTE9FTFhyaVdKS2t4RUxtckdlRlRUd0ZKQnA0?=
 =?iso-2022-jp?B?SjNia0xVVmNkU3k3YWJOcUp2ZjZyc1hrZzJzZUhFb1FJOVlJNy8xUTZ5?=
 =?iso-2022-jp?B?cEt3cTllcW0rRWpVWVg3bmJYT2FuYWt4T011aWJyM21TY2ZWN3lFY0RW?=
 =?iso-2022-jp?B?Y0dtNjlLK0xzM1BUOTR2bnBCODRNdVdhRnM5RFBBdjJucDgwWkwrdzNv?=
 =?iso-2022-jp?B?N0g1Tkx6d01RRnZWQ0YvYzc0V2F2eC8zZmxrdkhtbUtlNldsaXA0T3RM?=
 =?iso-2022-jp?B?VmxUWmQrUXp4Z0YveThUOE5ySGtrajJxUkVSazhUZVFaYXJCNG5RaWxi?=
 =?iso-2022-jp?B?Myt6NXNlS2lFRFBpSmFReVlCUjdvTUl4TWxuL3Y0YmJMdVpWYXRhZVI3?=
 =?iso-2022-jp?B?SE93OFRNQT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad072bfd-e403-4b41-83a4-08da38cb3fbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 12:38:02.5222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WJ1ERRF2kfkMSC5Yg9zCXfmsWID8Cpp0LGDjxrYBinWZ9EOIwKGdOrLb2sKz+yPNSdcwe7GJ26zWQqGQ6GJIGL0E/h2ymAXLrmUnTWJF5Ik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1836
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the comment.

> This feels wrong, attributes should be groups and be automatically added =
and
> removed by the driver core that way.  Not as lists of attributes like thi=
s, as that
> will race and be wrong.
>=20
> Use a list of attribute groups please.

> You just raced with userspace and lost :(
>=20
> Please use attribute groups instead of manually adding files after the de=
vice is
> created and userspace is notified that it was present.
>=20
> That also makes your clean up logic much simpler (i.e. none as the drive =
core did it
> for you already.)

> Attribute groups please.

I modify to use attribute groups in the next version.

> Why do you think this needs to be in the driver core?  Why isn't this jus=
t a normal
> cpu driver?
>=20
> thanks,

Does this mean that creating only dedicated driver for a CPU (e.g.
arch/x86/kernel/cpu/x86-pfctl.c) without creating core driver?
If so, there is no problem. I remove the core driver and create only
the dedicated drivers for each CPU in the next version.

As a reference, I previously wanted to define it as a common sysfs I/F
for A64FX and x86, so I create a core driver to provide it. However,
as I proceed with the consideration, it became clear that these were
independent I/F specifications. Therefore, the core driver is not
currently needed.


