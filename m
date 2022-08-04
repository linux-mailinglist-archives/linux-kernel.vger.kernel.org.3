Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07865897CA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 08:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237756AbiHDGdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 02:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiHDGdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 02:33:46 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80084.outbound.protection.outlook.com [40.107.8.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51FC6113C;
        Wed,  3 Aug 2022 23:33:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URHA21XCMYNdEdm5ESBocsNeNl3hDOGoLMXK/4xoSMUYMqJNufmHkbSrUq0JAiyOdK+6t5kJOepQXXnJeNl4JuL1djDGImR/BOpaNQq1eZwosfun2GqLT2uu+fMIR9o9oNctGA49a9vf9kp+FmgkkrJmsrhKZ423UMeaP9CZBC1SNLdjAR3mGOTvQseo99t5bEi57pXD/0KcLCTu/TEViI7Tz6kzU5SJ4UxzKgmICLDIUaOtsWF2295MqLuZmV0kDiYWva9gKQLYmJkAubYPNF0UzOvYTpwr2cp+13h7qPmY6CPYxaAuvUIrsmJcdePYC2xoq/LUHEesAnkcuNWgPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+IcxB1s6qogr2gMv2Vgo4pLHvk5jHhtJSIIqDdlR4I=;
 b=IM5+fOOWCh0aLixIg2n4Bc1B2AtQ4QXHXONo5+cxsoaCt2Rc/Csp9/SBtHyDYaiWLOGh/VEIqgum1mENi9rRHeaXVau/cIJHM0eXdHlpLqGJ4UxMx5YiUz5lEBrqVvKVJreUNcobmKqllQuRCfiXv00llkS/pIoIk03Dft49rJ1kIX1WqCQtLyahjNCAESy3vIpKuQNpek+3ejIMn8GrLV0fNIytpxnAzUzUTB2nI2mUArOwrupwlLLOEW2xuKkX+zMNG6bNrdla/Op1GftYwlusregDdBDWGwQ/GITeCKCtGwFt73qqaNXusnRp9td+IYUrtJVK6imTHpPAAEFOlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+IcxB1s6qogr2gMv2Vgo4pLHvk5jHhtJSIIqDdlR4I=;
 b=YUT7j6Yc4jFrbC9fEKLmF+rB3UUJhvlNccvFCEZwWeWxrQgOQHgr11QLUrZWdFssbTnPCYawFA17GTK5qirih3ulH2PzQTsgGJVvG0r4mdmqnwaDGkDM3wiwAQlEyciWRvyd2zttX17yNacrfQqZSKQjKddJzFXXpBYaJCt3294=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DB9PR04MB8396.eurprd04.prod.outlook.com (2603:10a6:10:24a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Thu, 4 Aug
 2022 06:33:41 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::d547:3040:284e:580c]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::d547:3040:284e:580c%6]) with mapi id 15.20.5504.015; Thu, 4 Aug 2022
 06:33:40 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] tty: serial: lpuart: disable flow control when wait
 transmit engine complete
Thread-Topic: [PATCH] tty: serial: lpuart: disable flow control when wait
 transmit engine complete
Thread-Index: AQHYptxZdHRWyv0FAEWa0Wrq5GzANK2eRzYAgAACVhA=
Date:   Thu, 4 Aug 2022 06:33:40 +0000
Message-ID: <AS8PR04MB8404D7206557315813E7715B929F9@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20220803015512.25472-1-sherry.sun@nxp.com>
 <9fdbd349-b464-8075-f377-ed442761b827@kernel.org>
In-Reply-To: <9fdbd349-b464-8075-f377-ed442761b827@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9aff3a47-d2c9-46a2-b04c-08da75e34566
x-ms-traffictypediagnostic: DB9PR04MB8396:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +rpvCVWRNpNuxQ/p706LYezF0hHwVQUuTd2truVQ2G3zRrrg+Cjv/ZB9YwHPf72lH9RQyZmLOkKtG6fP801H62EK/5aIG3G4Gfm6vM9EbRf1uzgWugGEdtQLOa5iAapAAL4CSQDrfhO0u4WxhoHxkiDV4tCaUC5o7PWwK0wq+mqVBsBdphwU4tLG+8BBVd7VZYQqB87bjrDJzvsk+H+njJB3FAyWPForS4vJpAna1r+f+LMUpr8Y2I3J4OdOUna8M9ehh0Mzqwol/y5x/j7zdzI6x8mWzunJmtsZjTsBsuUAJxZdHBOJ4sBgC/jnlriJYylcF1qndIY3izQGY2Mj5WbXb70ot6XciZXax1k3nGN0y4HwHaT6LiCnxJLmCkF70RHNk+0COhJr51IUGnEmofe6Ro2omG5Wu/yWBMRFmytPiLLaXtGBDseTN5sntahZ+8BfSBXyFXwHEptg9Rl+P82dHCDWBkwBdP8/21vTHZzsgSIjXCsdvjUe8Cn98AX82YU5weYKn4+essJrVReLtBpKtXQErF90uvP7Q+O4wm0ZvK571TJ6u5H8KJvNN/XjgP4M2FqEZ9kqKKx4+MVnXC6LvhOKDKPpmUCrYGr5/UnD4HISuWPimRQVDMqz8NTyQBQn+fLEolhkM9gxqrJi1ZBXgYQX5OdH4KZdkq4K8Y61UhuLxNqDUibPHYnYAZt70FZFZmqWHHJsIpDzkAkTcMcTH6JHw8pDAkMCFhfDd60XXl84W33ST1fHzpd+zsVJeW6soWJXXZtxkc8hgLxKSC0wfRj0zZHMGjBgonOjiS7TPELaADj79hFMYVH8tKO6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(7696005)(6506007)(2906002)(41300700001)(186003)(26005)(9686003)(38100700002)(86362001)(38070700005)(55016003)(83380400001)(33656002)(122000001)(44832011)(71200400001)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(478600001)(110136005)(316002)(54906003)(52536014)(5660300002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0lJTm5NZFVjZXFJU055Z0I4R3d1bjRIUDJDbzRaOXQ0QU4xQVQ3YkJlNzk0?=
 =?utf-8?B?aWU2VEFwVVNqSDREZEtOMDFvdFJPVjdiK0JRcC92dEFjcTlNOXNyV2RKcWR6?=
 =?utf-8?B?T0J3NjVzSk5pZEZQalM0ZmQ1blA4NjA2MDVzNVFMVjl0LzRwTEJCelZpc1lx?=
 =?utf-8?B?enFrQ29OKzQxdUNlV2Z5VU1qMmJWMmFNTy9Zb0dGOWJKWmhvOE5vMkowMmk2?=
 =?utf-8?B?V1k2d3orR1o2K21TU3k5cHpPZEd2K2lxcTArZDZxTUtmMVpjS0x5ek4zS1FR?=
 =?utf-8?B?ejY4aW1rcEdEWTlxZ3RpcVY5Ry9CWjN2UytTYlpMMUc3amFuOTdvRXlXWDhT?=
 =?utf-8?B?ZnJWNmhXYmhYYnNSMW5zOEhRZjFqblhPdEJTcXlhT08zNG9RV0VlUC9rRHYz?=
 =?utf-8?B?d0FXREcxRENsVjNpZ3dmc1BYZVhFaVMxaDB5VExKQWR5aEpIbjNoRW1RcnMy?=
 =?utf-8?B?ZmFINDJ0VHBFZjlZK3pMQ3FrNURJUFVkOVRUNkRQTERjRkJSWS9LV2N3d256?=
 =?utf-8?B?OTBzKzhDN0pqWnEwTW9xYlNSRHlISDVGTXE4TWVVTXloRDFpWllqa2hvdm95?=
 =?utf-8?B?SythZUtrZWdyQUZVQ29VTjM3T3UyN1BKSVBtNFVkVWNtdGNMOExTSFNmcVcx?=
 =?utf-8?B?blBCckhmUlpNSDhOMjRrbG80QVo0Rno5eXYrZ2NPdGc5dkttTURVaE45bEZo?=
 =?utf-8?B?K3lpRi8wUXJVTExiSzNHa1ZlWlMwY0Q3OHBkVmNxMGc2a1RYTmZ0TnBnckR4?=
 =?utf-8?B?Nk5xdmZvMmxSQnhGUzd0WG0yaVlmYkpLOTFpT2pLS0NyTG9ndTk3STdXM1BJ?=
 =?utf-8?B?U3ZIZEVQV202TzR1aElSSHpuZW81dWRiWWxFVlVZMEd1cE9EN2VhRnRGcVZw?=
 =?utf-8?B?Q0ZIczNKUlFEb3dKRVNsOEFhV0ZJcWtOVG8wMmxXb0pJSE9lRzRNM053V08w?=
 =?utf-8?B?Nk1taDBJWmJZblNoT213QzZiTDhzcmk5L2d3VGRhejR3U1NibFBzNGo3Ymoy?=
 =?utf-8?B?MlY1QmtXVDJDeVN3SjRpYjF4a3MySi9lUlJGNWJFZGkybGYrNndtc3lRMklI?=
 =?utf-8?B?SHBnbHRsQmU3M0UwT2pDTHc3VUNablBYMmtrTlhSOXNVRFdVNXhxbURlWnRJ?=
 =?utf-8?B?bWJUQW5rNnFqMkJvZVM1LytkWEFROFZuWU9kZ0xNTGthZ2EyUzFLRkJZcVZX?=
 =?utf-8?B?aXdZOEk4dStwbEJ0ejV6NjZwTlhSaGxacWhGak9vaFNkVlptNkVtSW9YS2lt?=
 =?utf-8?B?V1hEQUp6cU1EaHpPSUN1Yjlwa3dUTmszUXg4Q1htc3A2TVc2ajlUQTRUTTRY?=
 =?utf-8?B?RzhXS2tjQjhoRTVIekNJL25GTmQzcUFjU3RpdzRwb2dMQWVzV3RPTlhtQjZZ?=
 =?utf-8?B?L25sajEySUVGRWkyT1orbjRSZHlweEtvY2I4MkthcXdYMG94VnZ4NUkxdUhR?=
 =?utf-8?B?V3U3MC9kNDlJY2srUnRxakVMY3Q0VW4vd2xPb3hRSmhMRG5zWFZtN1F6Z25V?=
 =?utf-8?B?QUlKK0xaTGZLeXhwNmVNdjlSUzVnT1hFakp0Tzd0cnVMT1Q1NmRHUGFsbElv?=
 =?utf-8?B?TXRXRjRaN1dORlZ3N3NtRGZTLzlrNE9DQnFqenF4OHVLN3c2b3JVVzVoSm45?=
 =?utf-8?B?U1ZHOEF3dERpMmw0elNObVE3Z3V5dU5WOGpYRFlWUTdPK1dCT2pNVW94czgx?=
 =?utf-8?B?ZkpCUzZpeGdvRk5xdk9GeVlYNWZha3pQYXF6SFVhamd2aGNnSEdPYXNHN3hw?=
 =?utf-8?B?NjNWZmtYcTljU0pUbHRYSUVadmJCeXkxTUlmMS8xYXhSQkJ5MGppNEN1MlZ4?=
 =?utf-8?B?TFpaRG9FVDAybXFlZm5LYTNuODhPQmt3cXg3VXM3QXRLaGhUVFdtT1l2K2RM?=
 =?utf-8?B?alViL1REc3JFZk9qU0NUT2FHVmtHeThPMU5QV2tpYmdiby8wdkx6OC9HazVG?=
 =?utf-8?B?Q3RUbXRQTjk5S1lYdkxURnhzcnptTkwwQ01Gd3JxdmNVKzdjaHZaOWkxZmZD?=
 =?utf-8?B?YkMrT2drenp1WXI4NFhnY0NBajhwZEtIK2t3SzNwcUJUMm43QXlBbjhpVytw?=
 =?utf-8?B?MXByMTd0aG5sTWtDSDhkVnNwMUZBZlBRaldOUW9QVE8xNXVvMXk0UEpObTNB?=
 =?utf-8?Q?ryLoYkf9R6QkphZ/VMHQwX8NB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aff3a47-d2c9-46a2-b04c-08da75e34566
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2022 06:33:40.8417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DvWtukMew/yweEgRyPcV/+O8PgNjaTicMcvuYFjd4svzdfUxuswFKBOD6KR9SjWXgrgjufRpNplCz3pNHP/zaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8396
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIDAzLiAwOC4gMjIsIDM6NTUsIFNoZXJyeSBTdW4gd3JvdGU6DQo+ID4gV2hlbiBUWCBm
aWZvIGhhcyBkaXJ0eSBkYXRhLCB1c2VyIGluaXRpYWxpemUgdGhlIHBvcnQgYW5kIHdhaXQNCj4g
PiB0cmFuc21pdCBlbmdpbmUgY29tcGxldGUsIGl0IHNob3VsZCBkaXNhYmxlIHRoZSBmbG93IGNv
bnRyb2wsDQo+ID4gb3RoZXJ3aXNlIHR4IGZpZm8gbmV2ZXIgYmUgZW1wdHkuDQo+IA0KPiBTb3Jy
eSBJIGNhbm5vdCBwYXJzZSB0aGUgYWJvdmUuIENhcmUgdG8gcmVwaHJhc2U/IChBbmQgbWF5YmUg
c3BlbGxjaGVjaz8pDQoNCkhpIEppcmksIHN1cmUsIG1heWJlIHNvbWUgZ3JhbW1hdGljYWwgZXJy
b3JzIGluIHRoZSBjb21taXQgbG9nLCBJIGNhbiBzZW5kIFYyIGZvciB5b3VyIGNoZWNrLiBUaGFu
a3MhDQoNCkJlc3QgcmVnYXJkcw0KU2hlcnJ5DQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoZXJy
eSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvdHR5L3Nl
cmlhbC9mc2xfbHB1YXJ0LmMgfCAxICsNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0
LmMNCj4gPiBiL2RyaXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMgaW5kZXggZmM3ZDIzNWEx
ZTI3Li5mMGZjY2QyZmY3YWMNCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJp
YWwvZnNsX2xwdWFydC5jDQo+ID4gKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQu
Yw0KPiA+IEBAIC0yMTcyLDYgKzIxNzIsNyBAQCBscHVhcnQzMl9zZXRfdGVybWlvcyhzdHJ1Y3Qg
dWFydF9wb3J0ICpwb3J0LA0KPiBzdHJ1Y3Qga3Rlcm1pb3MgKnRlcm1pb3MsDQo+ID4gICAJdWFy
dF91cGRhdGVfdGltZW91dChwb3J0LCB0ZXJtaW9zLT5jX2NmbGFnLCBiYXVkKTsNCj4gPg0KPiA+
ICAgCS8qIHdhaXQgdHJhbnNtaXQgZW5naW4gY29tcGxldGUgKi8NCj4gPiArCWxwdWFydDMyX3dy
aXRlKCZzcG9ydC0+cG9ydCwgMCwgVUFSVE1PRElSKTsNCj4gPiAgIAlscHVhcnQzMl93YWl0X2Jp
dF9zZXQoJnNwb3J0LT5wb3J0LCBVQVJUU1RBVCwgVUFSVFNUQVRfVEMpOw0KPiA+DQo+ID4gICAJ
LyogZGlzYWJsZSB0cmFuc21pdCBhbmQgcmVjZWl2ZSAqLw0KPiANCj4gdGhhbmtzLA0KPiAtLQ0K
PiBqcw0KPiBzdXNlIGxhYnMNCg==
