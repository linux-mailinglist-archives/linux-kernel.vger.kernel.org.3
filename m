Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9235C4DD24C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 02:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiCRBPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 21:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiCRBPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 21:15:36 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2042.outbound.protection.outlook.com [40.107.21.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6183E2102A9;
        Thu, 17 Mar 2022 18:14:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYpRm6KtXuoSCI6vGCA3LlScc+AFpxJMiYoSMZH8TwlWJgKd54ee7iTGMfinUqIysUGbcLAa+n8LX6DAu5WFj8plgL5znC1HDTgZ5vDdRU6xNof1g0yAzxrJFtchcHY2Q2gdy9EYTMQV6ymZaL4koQdoNRRiRJ6rWMtE8lzr6JjpVsPMsCJK3D6znW+ec191+OI0Qh8I5XzFa3e87+xhqcKsfhsm7p9oV5rpB3YbS/Su04CRf42vt14tX0EJpp6vj3szIKog9BrT/p28ObBy2bdLwUScZX+qUyhdll7Sj873kh2+1kgcWxBDG8Ndftz8Fv55IfUVpqsT0qfKk2GjBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hgx/ZaCWF8BzYKy/fpGzFtwjRlPl+8cQ/bDSTSEs16A=;
 b=FpelCIhiDxFNLUcz+kkfNPnuGWb8ofDP7RGX+y9qwDWGWyfHV/KTjz2sfBA97ngGPSYSZu2klgEINzk5WmChjSqKvS0KClIu7M2c7n23vr/iNFI0NmIkPZuXUpXPpc8aohcei8EAIxj+VHhwkY6AhfHxKzpvBUYVsWXcPMt3ASaR6CupluhhS5E4dIDJvK4MF6BcZR9khB79wBg7AtFt69EISu6yXXqwkG+r9MD7ktIE4mwlIbqTNt1LzxcGJxnt14ty3lknZF0z779aSBE0J+MpwhJQM+e+0ThqJNPCCNeHS574Z3AGcpp4oxikniYEwVqcJuIXNTfrpUC/KmsGdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hgx/ZaCWF8BzYKy/fpGzFtwjRlPl+8cQ/bDSTSEs16A=;
 b=BjN35bofE7wDX9yXOI3pxgf2hRF3xmLW69daOAOMoheNaY42MnIC2Lf1fv4FcY39qv3mlFR+mY3C8fS/UP+6TSti3kx6xdSgVJqIP6q8FJVv7amDSKhjP2MeUw0XcpOuVUm6k/SkQ3iWb5eHeQ88fvYTt76DXAAHO1TpE/J7md4=
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by HE1PR0402MB2921.eurprd04.prod.outlook.com (2603:10a6:3:d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Fri, 18 Mar
 2022 01:14:14 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9470:2e85:68c0:83bc]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9470:2e85:68c0:83bc%7]) with mapi id 15.20.5081.014; Fri, 18 Mar 2022
 01:14:14 +0000
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
Subject: RE: [PATCH V2 1/2] clk: imx: add mcore_booted module paratemter
Thread-Topic: [PATCH V2 1/2] clk: imx: add mcore_booted module paratemter
Thread-Index: AQHYLKA0h+J5RMGvAUG7PEQSkRns8qzEE4+AgABbPXA=
Date:   Fri, 18 Mar 2022 01:14:14 +0000
Message-ID: <PA4PR04MB9416A26024C1437162A2C9C688139@PA4PR04MB9416.eurprd04.prod.outlook.com>
References: <20220228124112.3974242-1-peng.fan@oss.nxp.com>
 <20220317193717.33264C340E9@smtp.kernel.org>
In-Reply-To: <20220317193717.33264C340E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58c5897e-c171-4867-68f1-08da087c9ded
x-ms-traffictypediagnostic: HE1PR0402MB2921:EE_
x-microsoft-antispam-prvs: <HE1PR0402MB29217411053D8710D20A7F1988139@HE1PR0402MB2921.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DtDTDic5c2eHVdKSZMhdbGsCdlpTFg8wws1tZuMxrXlAlVbnTpp/HpWmvSU/PkM8pzL5wmbtnSSqNyuMZyuM3wqiGGY7wgbcHNCNWLv8S1ccwMDvPaA8BSox5TI+P9zOIxVxNAMtMwu96gI53wTcipHCbxOhFDbswSyNoqiudWI2HiI9EuU0gv09pAAZr17BjOAczz1t3EnLa2tbvnGUmDCVBIBYPhc4s171oS70CdtqJyU5/AeY/XUn1gNK/C/kdXQZeSrm4aYMsBIsh8tih8THb3SPc9Ed4ZliA3Z7djx0sHpyAO/RwuS31NoSY5irsfrQhuuWbN6XM8b7GCq+4FfqMYvIlua40YMX7iQGIWu7D5jqp4NnwNHTRaeM66g9ijrb1/dyBqsZjfr12y2t1U8r5fe90QIOGq4QWDE4g1ODU37+QCRPQMVoUp8md2tmRI2bJXChPMqEtdm55/NF/tamoYPv9aHpz1nvWdps6uT8qwmmP956IwA7MqNgQgR1jt3WmlpSjwANbS4s4iEwSWvgetfyqUDWeWEpnOvGnv0OJH3IYfQ1AAg8h/K2eYWHh99z9wUfUUJjfIcQgdj0lDf+LGFG2wbQgg3ZzAyRapo9ebVPH7zqz+xpimwIq8yPqL68dwbDLDcz6VZ/AAsp/vWlLGkPCb3SnHSMHHm3R9coHf5Vp44fzp+akxt0vtzWVXMlzuVUSD0ayOaBGb+GHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(83380400001)(52536014)(508600001)(110136005)(8676002)(44832011)(86362001)(7696005)(6506007)(54906003)(9686003)(186003)(55016003)(76116006)(8936002)(71200400001)(122000001)(2906002)(38100700002)(66556008)(33656002)(66946007)(66446008)(64756008)(38070700005)(66476007)(4326008)(5660300002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1lZNnlJZWlBcmg1c0RFeVYyenBqZjB4S28vckMvaGtwbWdpYzJFckFyUUFq?=
 =?utf-8?B?M05SZjVtdW1FSmdpN3NydVZMSmRWMGJJZ0VFeU9UT0F6b3R3SkZsWEZFUDFM?=
 =?utf-8?B?NGhnWVpJVTRSTTJSdXVLanU1bjBEdTRjayszTTBQQ1Y3cVltaklDRnhaR21s?=
 =?utf-8?B?SHJTN2RwdnEvcGRzbjg4bXZCbUprUFBieEx3OEt5UWMwdjBWQldkQks4TDM3?=
 =?utf-8?B?T09oMVNnb2JjWThTMXh3MUU4dVlyTHEzMmhVYjJaS0FEZmN1S1k1SENUUlV0?=
 =?utf-8?B?eHBMNlNMd0FmNXZEVjVqOVk2VjV6SGJJeURLV1lJM0ZHaVVEeEg1VW9MM0pz?=
 =?utf-8?B?dC9RSU1ka0dwcWcvVmd2RVp5Wk9RZHM1NmtsYzFGQ0x4elFZQVJNVDZmOVQv?=
 =?utf-8?B?UjJUaWVaNkNoaVhNSThLdzE1SXhWV2N5M2hDWEx2QWRFOWVSU1dCamlSWnhT?=
 =?utf-8?B?T0NTbHNNUjB6NXk5aldXYmpSN1A4VUgxNWdra08vYnJSV283ZHBGcEJsNmp3?=
 =?utf-8?B?MFpubE5laDFzMTNvUkNMTEhES2xjUXZCS3RrSG1SWVlyUFNVNDZ1a3oveTFr?=
 =?utf-8?B?RjV0WWRHdkFoQmlGNUEwWGFkeU5ZdjN5WDhmc2JRWlBxMVBRQ0x1c2V4ZUlY?=
 =?utf-8?B?aHdOd2ZncmhCRjE0eGcrTmUyMmg5SEI4QWVkdmRac0lLQ3pmU3ZnTFQ0WC9L?=
 =?utf-8?B?aExBallUY2h1Y2x1L1dYVk8rcHdsNEFqbGJvbysvQUJGeGl5MUtKY3ZDaHF6?=
 =?utf-8?B?eVNJNU1pZ1d0blB4SEU2bHU1eVlMN3puSmhiUmJyRFNDcGdZd3I0QW1GVW1x?=
 =?utf-8?B?UUJtTGlxemc0Mnp2WUpuM3NyVmlwNGJLQk1nMWlBdHYvN0hRcGJhS04wWjhB?=
 =?utf-8?B?cGtVTnN3R2FKMW15cDhCQ0dlSFAzZFNaTGdzR1AxVHF5dnZMaXZJOTY5Ni81?=
 =?utf-8?B?dDJGL3I4SGxxZEF3VU9IdkxOZGNvbDltdFBWbmpRcW9EU2Z3QmNibE1nb1px?=
 =?utf-8?B?cmMwc2NQMG9NT1BTdWIxcHd3ak4zbFpPc0ZocllqUnk0MUUzc3ZpK3lmcThs?=
 =?utf-8?B?UWdwZVljemZSd1NDN1pFK3lhdkp0dlVwNkJxd05FcXdaWVZLWk1QQ2I3cXp2?=
 =?utf-8?B?cmM4OUZtbWJIb3FWNmVxZTJOTThhVzRicHBNVXNQOVprR2lnSXFKWndkclZj?=
 =?utf-8?B?UHZWSHloWnVxLy9naFFLZU0rOFFTYnJ6aDFjM1pkSlpZRHZXVTBYUkF2VkxE?=
 =?utf-8?B?TzBrTWZUTDJzZXBmaEd3MGI3ajUvNGJxVStzU3dXQzhiekNKaHg2VU5XSDV6?=
 =?utf-8?B?eHh6aDdOcklhNU9GTWc2aGdzblBnTGlRd3VndUpZV0F0TFFlZjI1SlhXQzF4?=
 =?utf-8?B?RzNWNm45cUR3VEY3UVZvWDBNaXIyaEJUOTc4OHJFOVBORnJrS3NUQ25aNUNt?=
 =?utf-8?B?eE1ROEhHSklWc2tpa0lLU09KNE85Y1RkclUyTkJnZStOR01qbjZFSzJHTFlR?=
 =?utf-8?B?alNOTnVLMFJPakl2a3NxTnNjbTY3a25VLys2SmNKbXozYk82TXVNQWRHdjFa?=
 =?utf-8?B?RTJzZWFVSEhxT01FRDhiaUVYNDNtZUlhZlBodVpuSHFsbEtmZWFvM0daQ0d5?=
 =?utf-8?B?QjJxbmRYMGU4VUZieFpmZStPYkg3TXUvTE11bXhrMnMwZmJXT0NpMEp3VTZN?=
 =?utf-8?B?WlRzV1BKT1FuZkFscGdvUU9XUVRGWWlpS2x2Y3ozTnd2TWhvV3J3UU5GdXRQ?=
 =?utf-8?B?WGdtaXhZc2l4QlJ3dzVZQjBQbysxZ3plTk8ra240cXhJdUxkMDhISExEa3VU?=
 =?utf-8?B?NUwzU2g5THpLeHdLMG1oSlBKQlJMdTIyVm9QVWZKVkpsTVFNdS8vRTJmRVc4?=
 =?utf-8?B?bTZjclZINUZXZDNxaDA4RlM3SVY5K3hBVWp1WjVnNlo2V25VdmU1ck94Z1Ni?=
 =?utf-8?Q?l/QrjZQL2EY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c5897e-c171-4867-68f1-08da087c9ded
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 01:14:14.4114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QHxpyFOYraoNwDjW6b9cvtwKA0yNWGhsD2p2orPG7tLbfTh+4cxqTwovWCCrkf0toO5h1xWmHBdQwBnVvvCzow==
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIFYyIDEvMl0gY2xrOiBpbXg6IGFkZCBtY29yZV9ib290ZWQg
bW9kdWxlIHBhcmF0ZW10ZXINCj4gDQo+IFF1b3RpbmcgUGVuZyBGYW4gKE9TUykgKDIwMjItMDIt
MjggMDQ6NDE6MTEpDQo+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4N
Cj4gPiBBZGQgbWNvcmVfYm9vdGVkIGJvb3QgcGFyYW1ldGVyIHdoaWNoIGNvdWxkIHNpbXBsaWZ5
IEFNUCBjbG9jaw0KPiA+IG1hbmFnZW1lbnQuIFRvIGkuTVg4TSwgdGhlcmUgaXMgQ0NNKGNsb2Nr
IGNvbnRyb2wgTW9kdWxlKSB0byBnZW5lcmF0ZQ0KPiA+IGNsb2NrIHJvb3QgY2xvY2ssIGFuYXRv
cChhbmFsb2cgUExMIG1vZHVsZSkgdG8gZ2VuZXJhdGUgUExMLCBhbmQgQ0NHUg0KPiA+IChjbG9j
ayBnYXRpbmcpIHRvIGdhdGUgY2xvY2tzIHRvIHBlcmlwaGVyYWxzLiBBcyBiZWxvdzoNCj4gPiAg
IGFuYXRvcC0+Y2NtLT5jY2dyLT5wZXJpcGhlcmFsDQo+ID4NCj4gPiBMaW51eCBoYW5kbGVzIHRo
ZSBjbG9jayBtYW5hZ2VtZW50IGFuZCB0aGUgYXV4aWxpYXJ5IGNvcmUgaXMgdW5kZXINCj4gPiBj
b250cm9sIG9mIExpbnV4LiBBbHRob3VnaCB0aGVyZSBpcyBwZXIgaGFyZHdhcmUgZG9tYWluIGNv
bnRyb2wgZm9yDQo+ID4gQ0NHUiBhbmQgQ0NNLCBhdXhpbGlhcnkgY29yZSBub3JtYWxseSBvbmx5
IHVzZSBDQ0dSIGhhcmR3YXJlIGRvbWFpbg0KPiA+IGNvbnRyb2wgdG8gYXZvaWQgbGludXggZ2F0
ZSBvZmYgdGhlIGNsayB0byBwZXJpcGhlcmFscyBhbmQgbGVhdmUgQ0NNDQo+ID4gYW5hIGFuYXRv
cCB0byBMaW51eC4NCj4gPg0KPiA+IFBlciBOWFAgaGFyZHdhcmUgZGVzaWduLCBiZWNhdXNlIEND
R1IgYWxyZWFkeSBzdXBwb3J0IGdhdGUgdG8NCj4gPiBwZXJpcGhlcmFscywgYW5kIGNsayByb290
IGdhdGUgcG93ZXIgbGVha2FnZSBpcyBuZWdsaWdpYmxlLiBTbyB3aGVuIGluDQo+ID4gQU1QIGNh
c2UsIHdlIGNvdWxkIG5vdCByZWdpc3RlciB0aGUgY2xrIHJvb3QgZ2F0ZS4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+DQo+
ID4gVjI6DQo+ID4gIFN3aXRjaCB0byB1c2UgbW9kdWxlIHBhcmFtZXRlciwgdGVzdGVkIG9uIGku
TVg4TVAtRVZLDQo+IA0KPiBXaHkgaXMgYSBtb2R1bGUgcGFyYW1ldGVyIGJlaW5nIHVzZWQ/IEkn
ZCBleHBlY3QgdGhpcyBpbmZvcm1hdGlvb24gdGhhdA0KPiBtY29yZSBpcyBib290ZWQgdG8gY29t
ZSBmcm9tIGRldmljZXRyZWUvZmlybXdhcmUgc29tZWhvdy4NCg0KSW4gaS5NWCBwbGF0Zm9ybSBk
ZXNpZ24sIG1jb3JlIGNvdWxkIGJlIGtpY2tlZCBieSBVLUJvb3Qgb3IgTGludXggcmVtb3RlcHJv
Yy4NClRoZSBoYXJkd2FyZSBjbGsgSVAgaGFzIENDTShjbG9jayByb290IGNvbXBvc2l0ZSkgYW5k
IENDR1IoY2xvY2sgZ2F0ZSkuDQpDQ0dSIHN1cHBvcnQgbXVsdGlwbGUgaGFyZHdhcmUgZG9tYWlu
IGNvbnRyb2wsIGJ1dCBDQ00gbm90Lg0KTGludXggaGFuZGxlcyBjbG9jayBtYW5hZ2VtZW50LCBt
Y29yZSBvbmx5IGhhbmRsZXMgQ0NHUiwgc28gdGhhdCBtZWFucw0KTGludXggQ0NNIG9wZXJhdGlv
biBtYXliZSBzaHV0ZG93biBhbmQgY2F1c2UgQ0NHUiBoYXMgbm90IGNsayBpbnB1dC4NCg0KU28g
d2hlbiB3ZSBuZWVkIG1jb3JlIHJ1biwgd2Ugc2hvdWxkIG5vdCByZWdpc3RlciBDQ00gY2xrIGdh
dGUgaW4NCnRoZSBjb21wb3NpdGUuIFRvIG1jb3JlIGlzIGJvb3RlZCBieSBVLWJvb3QsIHdlIHBy
ZXZpb3VzIHVzZSBpbmZvcm1hdGlvbg0KZnJvbSBoYXJkd2FyZSwgYnV0IHRvIG1jb3JlIGlzIGJv
b3RlZCBieSByZW1vdGVwcm9jLCB3ZSBoYXZlIG5vIHdheSwNCmJlY2F1c2UgbGludXggYWxyZWFk
eSByZWdpc3RlcmVkIGFsbCBjbG9ja3MuDQoNClNvIG5vdyB3ZSB1c2UgYSBtb2R1bGUgcGFyYW1l
dGVyIHRvIGxldCB1c2VyIGRlY2lkZS4NCg0KSG9wZSB0aGlzIGlzIGNsZWFyLg0KDQpUaGFua3Ms
DQpQZW5nLg0KDQo=
