Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A465D4DD256
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 02:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiCRBRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 21:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiCRBRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 21:17:12 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60082.outbound.protection.outlook.com [40.107.6.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A234929EE0F;
        Thu, 17 Mar 2022 18:15:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejx2XVe3tEgPAJ6yPHCmFnTIbHlsWIhAWBJcpZpKjd6Wdob1FnEJX4HSfSWLzH+CZ3QQdoKsZi4DXyOPjH+wNAEVr0YwY/rJWfNrLc+PLEuiu8dNJ62v50+Xm5D31IWx9MPRw0BQPCFETT/NpExn9p9JgqO/iW2MVzwxQpz8KbUHrht7Gm0Uaa5+aByO5vNnjPtDV7LunR+EMwTL4vV22teBBTWk/Qrqp6TGn3rwSmjO9ACogqBD0b4N5TRwfEYkeLuBvgYX1yAa8aZpozghFuvQ9RYRwY/3M0bYkNLcRPUMwTs+vT0pbUAVOVzdIAFZvnEyVS438tw0bv2VnqJFOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rCz9//TySGWAEViMmT7CXoor9W9DWBPlO1RtbTn3rQ=;
 b=TDuDJX0zGLUuSTNr6wE4lnVQtVlaKpZpZ/NlYLuYQfLHuRKu4cyqHfAquStBzUfJMac2boUwLR6OJsupoY42Ttrd85c7saJaYL1oOr/z1hJdN9bq9P+meBudWxDHF0yFYeWpaYTKguzq16WWUJ1fWnZNi2zEXkhSVsp+XmPoROPVSDn4iH9VqGLWXMYto30fNrYSyCro/+0pfDzQ/rqnSjQlfPaEsq2JVpkfjOs7nraT53C0CaOz/Aazz2ugV+1Yh+IhftDcHtRE8qevG5PSraARqdJvr255TKj2nRoE3VJ5WtnDE/ye6bnUYwQMfhsg431ujDOPnA6sVJVBFeZCjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rCz9//TySGWAEViMmT7CXoor9W9DWBPlO1RtbTn3rQ=;
 b=CQL6xmnccxG3stan99W1m7myypTvwIt/4nI/9AVC2dy9CspXwus04/dmTTgqEdYMZSmRpPib9RmHX7ungowcx+K3TdT09qXGE/JYfvc78p85MwBvmbZhHI+6CSspYHPMC3YLKm71YmBYtCad6CKZkBlC+r5E1LxoyldSIvFEwoE=
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by HE1PR0402MB2921.eurprd04.prod.outlook.com (2603:10a6:3:d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Fri, 18 Mar
 2022 01:15:51 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9470:2e85:68c0:83bc]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9470:2e85:68c0:83bc%7]) with mapi id 15.20.5081.014; Fri, 18 Mar 2022
 01:15:51 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 2/2] clk: imx8m: check mcore_booted before register clk
Thread-Topic: [PATCH V2 2/2] clk: imx8m: check mcore_booted before register
 clk
Thread-Index: AQHYLKA2MA7+7RMqd0yRWyJn90Rz2azEE9SAgABd4aA=
Date:   Fri, 18 Mar 2022 01:15:51 +0000
Message-ID: <PA4PR04MB9416FE8A48930C7F932CA09888139@PA4PR04MB9416.eurprd04.prod.outlook.com>
References: <20220228124112.3974242-1-peng.fan@oss.nxp.com>
 <20220228124112.3974242-2-peng.fan@oss.nxp.com>
 <20220317193815.47BC1C340E9@smtp.kernel.org>
In-Reply-To: <20220317193815.47BC1C340E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 534673fc-e867-4ab6-d7ab-08da087cd800
x-ms-traffictypediagnostic: HE1PR0402MB2921:EE_
x-microsoft-antispam-prvs: <HE1PR0402MB2921516A9358F9DEE913F1FD88139@HE1PR0402MB2921.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LD8bKHxlPBFSvQvNz6Bsn8Mjon5KvG/SDzy6+xSDh+rCDGLrx1vUs2dUFABCMTb26evXnshmv8r0PpOkMbcycnX+OHRl8Axjiq0sw3nh48a7UHqKN3F3Et5XwvEiZHfnLeeV5PYhXH3JFjoUIesKrYuFDy9J+7jGpSpHUTy242cyXOsQc76I2oGeqWifRa2j/R6mfL5MlnziB7XflSz+/eUxua+c46V0Hhz6vvsc5t+0n/IyXWh+4xDhhylJsm40xNygKrge7OM4WRpkn+weDpXYdnVAEY2+YPz/C2/iz6I131ltPRyUx7TY7UhFIEnah/1minr/zBwG4W8S+7CfOno3TZaqKFYrX1gHLn8zZ0o83kV4QmQquAleaGhxWI+YPuKin1Mml/Gqoic/tKLgVIJbcYPGD0kRNmFgfn8sRIZi/B/QBHBLHfBUlEIaeo6YZLXMNCPv+3luMvWr3lZzhwLBFKqtB4T+XXS3cS4F/Y9D4N9wENqe8tS3pg+TDTGBi7bUsPHvBvpOw7i7UTFxrQcjAKM0A6TG7h/NCpHes21aonsuNzFeTIFJRzCcXLohfK/57XQGkpwc9rwl52DeK7wIQeLfZTunn0VU0IaWJtK5mwROBJGEdQem0tl/cF5dfwWQAjBiZGZVYwiuIg7Bd9sYFVjrC4BBQFQuRPdSgkvmx/HhU97W6V3TcYMAzAIpeFyYslXB3nUuUtDa1+Ey5p3Su5ZF+2/mENH9KNPwMzk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(122000001)(76116006)(55016003)(186003)(71200400001)(8936002)(64756008)(38070700005)(66476007)(66446008)(5660300002)(26005)(4326008)(38100700002)(66556008)(33656002)(66946007)(44832011)(8676002)(86362001)(316002)(83380400001)(508600001)(110136005)(52536014)(9686003)(7696005)(6506007)(54906003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dktURTRBS2puNFNzVWRGVThVTHBsSVdSaHFZeSs2OXVDdzNtcjBjbXpUQ1hp?=
 =?utf-8?B?UHdmYXRPRDljWW9tZitGR3RxR0VzNVdjVGMyUVRETElwbWFPSDA1ZEdrMnZK?=
 =?utf-8?B?dWY1VlFJNDI3bTJmS0tkSDF6WUl3ZXJ1WmQxczRqaHRkY3JuSk5aN244M29Z?=
 =?utf-8?B?V2Vyd0tpbVh4UkVGTHNiamt4WnVGaVJDN0Z2cGlGTnFLdEFkNWNWSzJlNGY5?=
 =?utf-8?B?K0JScHZWaUV0dGt3bkJiOExFcUZ0cytKL2FITHFsM0FSWHZzcVZ3SGZvZy9n?=
 =?utf-8?B?Yk1KbHFjUXREQUlEb2luLytFdUNkcXh6Sm1XczJLRGJMbW0yb1JTZFcwVFZr?=
 =?utf-8?B?azFEa3E1RkU4ZGVNZ2ZjWUk0cmczY20zM0NpU3JuU0Jud25CTjJlRVF5NDIy?=
 =?utf-8?B?dzhTZWZCcTN2bFhzOFl2bWhpL3lLc082algrY2s5VXY2S29NakNDMjdBSWha?=
 =?utf-8?B?cmZnam9mN1pwMnJRRmFBc2dlUTY5Q2EzTWhaRE9WNzA0QVdwenhGOFVQc1U4?=
 =?utf-8?B?ejVhV0xpbkxQWUVtcmZlRDBoSk94aWQ2c2paaXhFSnBPUGhqaXpIS0tLOU5Q?=
 =?utf-8?B?WTQxS1YzamxPTE9wYXRzYWdnK2Z0SUUyMFBkemdnTEk0eHloSk1pZDRwam9L?=
 =?utf-8?B?cDZWTTl1aElUV0xZc3ZpR2RZbTBCOUFUbUZHMjVETGFOY2l1bTJpYktSYUlG?=
 =?utf-8?B?eFhhMEd2akJWT29PSUdEWnM1ZnFEVXBNTW1icVBNNXFNMmlTTWNVWGlUbWtQ?=
 =?utf-8?B?cHJqckV0L3VwdGFkNjdReTNaa1gveEVHbURtMDl6d3pKakNobi9sUVl1eElZ?=
 =?utf-8?B?WE9RWDZTVFFkYlBZdXhHWmUxSmpBajZwbW9RVFlaNHMzTXhpbi8vSitsUWZE?=
 =?utf-8?B?aWdrL3V1Nko2T1gvQTlKcTRCZkNOTkJvejMrQUFKbHhWVWJob0RNTDBLdXNK?=
 =?utf-8?B?L01NRVlySGxwMnJ1K2tNaTZRd0ErMXpidTB2TkxTdWxzNjdNMC9pbDRVWkVJ?=
 =?utf-8?B?ZVk4d09uZXVIUmMwNFNhOUhWQW91UTVZeXA5bzRTU2EranUyM29pbHBHT0h1?=
 =?utf-8?B?ZFptdkI3U3l1YTJLZXV5anhVSFpGNDU1bVdkL3hpUXNXWUZEcGRKUi84RnVw?=
 =?utf-8?B?cmgzbDBqKzlObzlaeGlOSE5rc1FCVUp0Q0k1RG16aXprdjlIdVp2UmRLRWFl?=
 =?utf-8?B?VHh4Rmh4REVKL2kzTVIyNjZ6M2lsNFpIU09IZXUxVzZucHRrcmVXNlFqdGVY?=
 =?utf-8?B?a2x6QUxZZTFxUFNHWmZtdGlSb2R6TWQweXNCV1grbml5NDlzWGVYUC9xamdz?=
 =?utf-8?B?cEVLbzZmZ1lQSG5USkNuZml2aWpJWlZBLytmVFZsTGVsQmhBWkczUkJUMk5Z?=
 =?utf-8?B?bHVxVzIrZEl6aWJ0VWJxQ0pTeE9NbUk5WWprbmNYYW5zeTNtNk9MSk80SzRh?=
 =?utf-8?B?VS92bEFxN2dOR2ZLQUg1OW9UMVRaRjMrNmdjWlYxK0VITGRBUGg1ZytkYVNk?=
 =?utf-8?B?NnppVm1WM2ZBTDJ4aGZCK0YzL3djUXZHMzBnSitnRGtUc0wxaXJkL1VmeTJm?=
 =?utf-8?B?TVB2bGhJQk55dXQ4WFRlR1R2ZW1nM1h0eHlIc08vT0puMHU4UVBPTExsTlFQ?=
 =?utf-8?B?bzVCRTNEWXFoY2Zjd3pWZUVDWTErcGZKRjltTTllN0s3Q1laL05rMzFJVTJ0?=
 =?utf-8?B?MkRsSXF0bU5xTXlnZEtCQTFZYVdPb2d0bGxlWHgvdVphWmRXOHdPdUM2cG9S?=
 =?utf-8?B?b2tsTTV0RFVUWG1PV1pFZWxVaDNWK2FUYVAwTVJCRjUreS9ESjd6bzNTaHFm?=
 =?utf-8?B?ZElyZkpJNVFXdHQ0MXlFWUpuOG5idGVPMVRwM3cxc09TOVNtK2pEMVBnVUl0?=
 =?utf-8?B?NUFwUEZRTk10Sk84WVV1SHd0QzdsYzJYMkZVVi8xelFpaTY2dmNkSStaRFBB?=
 =?utf-8?Q?5dBRsRQ0cKA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 534673fc-e867-4ab6-d7ab-08da087cd800
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 01:15:51.8622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1LGU52nlqXGyVFwECUzp3ny40ftNT61ERYEtrKvPu5CQkQCYxOTV11zNkL6bkW8/IWIIn3U86/WinWujvL+7Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2921
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIFYyIDIvMl0gY2xrOiBpbXg4bTogY2hlY2sgbWNvcmVfYm9v
dGVkIGJlZm9yZSByZWdpc3Rlcg0KPiBjbGsNCj4gDQo+IFF1b3RpbmcgUGVuZyBGYW4gKE9TUykg
KDIwMjItMDItMjggMDQ6NDE6MTIpDQo+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5j
b20+DQo+ID4NCj4gPiBJZiBtY29yZV9ib290ZWQgaXMgdHJ1ZSwgaWdub3JlIHRoZSBjbGsgcm9v
dCBnYXRlIHJlZ2lzdHJhdGlvbiBhbmQNCj4gPiB0aGlzIHdpbGwgc2ltcGxpZnkgQU1QIGNsb2Nr
IG1hbmFnZW1lbnQgYW5kIGF2b2lkIHN5c3RlbSBoYW5nDQo+ID4gdW5leHBlY3RseSBlc3BlY2lh
bGx5IExpbnV4IHNodXRkb3duIGNsayB1c2VkIGJ5IG1jb3JlLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4gLS0tDQo+ID4NCj4gPiBWMjoN
Cj4gPiAgTm9uZQ0KPiA+DQo+ID4gIGRyaXZlcnMvY2xrL2lteC9jbGstY29tcG9zaXRlLThtLmMg
fCAyMSArKysrKysrKysrKysrLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2Vy
dGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9j
bGsvaW14L2Nsay1jb21wb3NpdGUtOG0uYw0KPiA+IGIvZHJpdmVycy9jbGsvaW14L2Nsay1jb21w
b3NpdGUtOG0uYw0KPiA+IGluZGV4IDJkZmQ2MTQ5ZTUyOC4uYjE2YzJjMGVhOWY2IDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvY2xrL2lteC9jbGstY29tcG9zaXRlLThtLmMNCj4gPiArKysgYi9k
cml2ZXJzL2Nsay9pbXgvY2xrLWNvbXBvc2l0ZS04bS5jDQo+ID4gQEAgLTIyMywxNCArMjIzLDE5
IEBAIHN0cnVjdCBjbGtfaHcNCj4gKl9faW14OG1fY2xrX2h3X2NvbXBvc2l0ZShjb25zdCBjaGFy
ICpuYW1lLA0KPiA+ICAgICAgICAgZGl2LT5sb2NrID0gJmlteF9jY21fbG9jazsNCj4gPiAgICAg
ICAgIGRpdi0+ZmxhZ3MgPSBDTEtfRElWSURFUl9ST1VORF9DTE9TRVNUOw0KPiA+DQo+ID4gLSAg
ICAgICBnYXRlID0ga3phbGxvYyhzaXplb2YoKmdhdGUpLCBHRlBfS0VSTkVMKTsNCj4gPiAtICAg
ICAgIGlmICghZ2F0ZSkNCj4gPiAtICAgICAgICAgICAgICAgZ290byBmYWlsOw0KPiA+IC0NCj4g
PiAtICAgICAgIGdhdGVfaHcgPSAmZ2F0ZS0+aHc7DQo+ID4gLSAgICAgICBnYXRlLT5yZWcgPSBy
ZWc7DQo+ID4gLSAgICAgICBnYXRlLT5iaXRfaWR4ID0gUENHX0NHQ19TSElGVDsNCj4gPiAtICAg
ICAgIGdhdGUtPmxvY2sgPSAmaW14X2NjbV9sb2NrOw0KPiA+ICsgICAgICAgLyogc2tpcCByZWdp
c3RlcmluZyB0aGUgZ2F0ZSBvcHMgaWYgTTQgaXMgZW5hYmxlZCAqLw0KPiA+ICsgICAgICAgaWYg
KG1jb3JlX2Jvb3RlZCkgew0KPiA+ICsgICAgICAgICAgICAgICBnYXRlX2h3ID0gTlVMTDsNCj4g
DQo+IEl0IGNvdWxkIGV2ZW4gdXNlIHRoZSBwcm90ZWN0ZWQtY2xvY2tzIHByb3BlcnR5IGFuZCB0
aGVuIHBhcnNlIGl0IHRvIGZpZ3VyZSBvdXQNCj4gdG8gbm90IHJlZ2lzdGVyIHRoaXMgZ2F0ZT8N
Cg0KQmVjYXVzZSBvZiBoYXJkd2FyZSBkZXNpZ24gYXMgSSByZXBsaWVkIGluIHBhdGNoIDEvMiwg
dGhhdCBtZWFucyB3ZSB3aWxsIGFkZA0KaHVuZHJlZHMgb2YgY2xrIGVudHJ5IGluIGRldmljZSB0
cmVlLiBJIHdvdWxkIG5vdCBkbyB0aGF0Lg0KDQpUaGFua3MsDQpQZW5nLg0KDQo+IA0KPiA+ICsg
ICAgICAgfSBlbHNlIHsNCj4gPiArICAgICAgICAgICAgICAgZ2F0ZSA9IGt6YWxsb2Moc2l6ZW9m
KCpnYXRlKSwgR0ZQX0tFUk5FTCk7DQo+ID4gKyAgICAgICAgICAgICAgIGlmICghZ2F0ZSkNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGZhaWw7DQo+ID4gKw0KPiA+ICsgICAgICAg
ICAgICAgICBnYXRlX2h3ID0gJmdhdGUtPmh3Ow0KPiA+ICsgICAgICAgICAgICAgICBnYXRlLT5y
ZWcgPSByZWc7DQo+ID4gKyAgICAgICAgICAgICAgIGdhdGUtPmJpdF9pZHggPSBQQ0dfQ0dDX1NI
SUZUOw0KPiA+ICsgICAgICAgICAgICAgICBnYXRlLT5sb2NrID0gJmlteF9jY21fbG9jazsNCj4g
PiArICAgICAgIH0NCg==
