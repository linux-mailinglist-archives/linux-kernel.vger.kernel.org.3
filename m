Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7AC51FAAB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiEILBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbiEILBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:01:01 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60047.outbound.protection.outlook.com [40.107.6.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030AF1E7812;
        Mon,  9 May 2022 03:57:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Shv1ASm2HChlPWGRETPoqlOnGBtbi4QsYjRrCeNNaSvf4EUpZr9q/uBYGBZJYXlX1+t1yy9wzHpo4lLfKVm8JMitSjqeG+JK9EumkUYgm36Ziz+JR4TvoyFSKvwRBn24TJ0VkZDAUppGglOi4DmGxLCZ8EcElI5+D/ZRRzDsTfu/6mQGC69uBg4Re2GzKk9NOE0jAlHIU5tLCjII/+xda8iwWZBUxTl97V6ym7QTxFGjf0Fsd5GjJ7KAjvAhe6jOPcxkCfdt5ouk9Eule/cvdkhSjM9/mv5LCcaZ7PDCopB6afY+UoY4PRey2S2Zm8D0iBRbEEaH7d9hsHehaPCGvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Oo5QCJuU3WdBZSX3fD3WXWbZoN/JxUOoOyJWxXzmIM=;
 b=llvTuww23gVfSaq3MlP7RM3B5EmozdKhZHF9pTERPjgnd1Q18oMMDnm6pV2wUPkN+0wkEq5d6AeyodKnfK8OAuVp53CXIJmcgYQWuu+2fpsni/8MW4zvkPaYq2RMJDJMQlD1y4GDRW3TvPumZ+bKfWXqYO0dt0i1UgSpTVGkdebH0iFev+F3Qwwyj8HfU3U01AsnoHbCk4E8CwQgKiggxdPr8TyTSxbodxN/4VmsQoJ3sbdtOuxHWGVz2bXg8irDKkAuQyts1DfMq3pmsZuyDVACAmsyR8EEq/xV+m5DLo1Ov3+9XcTLNstz9FPZWmELIhfyJSqQSEQItLELKmYyCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Oo5QCJuU3WdBZSX3fD3WXWbZoN/JxUOoOyJWxXzmIM=;
 b=I1hbeZqvms8tw7PK+7UAtsNeX/rFUhOxroDJmQ9hJPmysVb9JnJN8J1Oxq0ZVHPXxVCXtX2DfUq2ghL8CNhX4jvufDwV4KM4s+M08ZHqgjzcMZyN0P0hB5AtKufCwNzmPNZV5Z2kOnP9bpYLwh4tr12YG+gJeLrs2toYCtsUT7g=
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com (2603:10a6:10:2c3::11)
 by HE1PR0402MB2907.eurprd04.prod.outlook.com (2603:10a6:3:e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 10:57:04 +0000
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::1d57:4a64:1c30:a00f]) by DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::1d57:4a64:1c30:a00f%6]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 10:57:04 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Peng Fan <peng.fan@nxp.com>
Subject: RE: [PATCH V4 4/4] arm64: defconfig: enable i.MX93 clk & pinctrl
Thread-Topic: [PATCH V4 4/4] arm64: defconfig: enable i.MX93 clk & pinctrl
Thread-Index: AQHYY3ZEpwkIAjIxCUSA+FvwB/2Ir60WX+3Q
Date:   Mon, 9 May 2022 10:57:04 +0000
Message-ID: <DB9PR04MB84775745E9884A85799D5CB980C69@DB9PR04MB8477.eurprd04.prod.outlook.com>
References: <20220509072911.3268668-1-peng.fan@oss.nxp.com>
 <20220509072911.3268668-5-peng.fan@oss.nxp.com>
In-Reply-To: <20220509072911.3268668-5-peng.fan@oss.nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: afbecb71-b162-4a59-31ff-08da31aaa6f5
x-ms-traffictypediagnostic: HE1PR0402MB2907:EE_
x-microsoft-antispam-prvs: <HE1PR0402MB29073AE7B1B582D5021FE05780C69@HE1PR0402MB2907.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iMnxpir8XNECRyBTiEJ33tjFc8VxJTYjD4z8ztR3punK5cdRU5GYqaflbRKVA9ZW03/8j9cYu4yeZcQx1j9SY8dJRMhlU9yG86hfamyfMyd4PDZ2+LUTCOQMF7qgU2enTji9Df7HGX6Z01VvmMMB2kTFSJ+Q8a0cVlk0Ax3dxMs0eXKnFRRvH8Z8VEvsyESwV8IkQQO5rwsW9dKOOnqdSXc9W6Vhk80liavGOT2pmBdJmsyr12gkyFnoSwLd2jp5QK8JuSRUraeK5eXQRGlUAqLM544uIiu2ON+YsH3NKa5JHrq3EBJReBo6qfaRve+0i4W5RjUwuhUXSMxCETf9/oRjfO/w/xmRLE4OlJHuSboLf/0pKzvAhIKj0REPqp0anWJ+K0WR4s0tQ9Jd30xnrun4fVksBUn84huXkbqT2aMmlF0ObkO0+HKu7/khVL3vBrCZ3Uky+QQfpa5McyX3KlwIYa1MEdLhYuu4ArUo2Sm4r81Sfc9uCVFIFR6HfwA7v9uCZFKdueJGJIhkmsb31xxjuln4kehOSsMxt+NwNSpeUWVpz3FUqobqtQ+/D/XOmub3PeXQlxAo2qhj9peAnR55OdouOxfa5tNf8BhXOO23NsoHaITpA8yTBuTjNm8qsowyjldmsfDmwZ5ZYDsYG36/YTeBPum1I7Kxvsa53uBbjPT/CQAhEKcBX+9UnYJklvZwAbfIlY8CQpUUzStbUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(76116006)(186003)(66946007)(66476007)(66446008)(8936002)(44832011)(66556008)(64756008)(33656002)(52536014)(5660300002)(9686003)(26005)(8676002)(4326008)(71200400001)(6506007)(86362001)(508600001)(54906003)(558084003)(110136005)(7696005)(55016003)(38070700005)(2906002)(316002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFZoZEk4N3BDYzFwUVlpS0tSbHVJbkNyQktFTk51MVFKTkdnT1F3VXluUkhY?=
 =?utf-8?B?M1JiVG9YWDFheTN0Z0tmaXduUk13M1hMeWN0VTl0QlV6bUtWWWw2ZmpNTVVF?=
 =?utf-8?B?OG1IbU4rb0FTMUk5ZDR4WXRxbmw3YmdWSnRVNklJM0I2M2h5c3ZSUENIUGFm?=
 =?utf-8?B?Qll5b2w1R0hwQ21VazBKbUdHaXM0Tm5TSml0NkI2MDFrRDNDbUNSSFpJTjV1?=
 =?utf-8?B?a1NwWGM2RXk4eUdTSEI1VDk0YTZWNXoySHVWRnJ4NWZSUzRoNTRld0paWTRv?=
 =?utf-8?B?UjZ1SG1oWU5BSEJ5amw4NjhHY3ovTjdldU1pSVcwN0F1R0Y3bHhiWGN1QmFF?=
 =?utf-8?B?N3FFSU9uTE1kNEtCN2NoaW5IUkdkYUIxV0hBVHFOVnJycUdKRlVUZ05JMVVC?=
 =?utf-8?B?RjNuYVNTWmtiL3ZacHhRUU90OW9kM1lGb2hRWHJNWGh6QVptVVptQ0R3cEg0?=
 =?utf-8?B?RjltOEtWS1Z6bmpYNE5uM0FNQ2ZNZ051WlJDTDg5N1pwSFFrcmRnZEtHOEdE?=
 =?utf-8?B?WXNqb2JPNk1ob3VaYTF4cjFnanVGL2hiV2dneXpoR2RaYVBJUHdCNXIwQ1RU?=
 =?utf-8?B?VExIRXkyR002T3ozYjdPMS9iUkxUQWZKNHlXd0wzVmRaMUZaejZzZGowWnlk?=
 =?utf-8?B?YUk5MkJSTzY2alR4V3VXMm1jbHpHWGc3T1hkZGxDZ3g4cEQrNzQxbzNhY3FB?=
 =?utf-8?B?aDM0WTViY0xCTkVKV3czbW1NZkg3azd3OGkyY1NZK3hISjluNmRVWnBubjBI?=
 =?utf-8?B?WUplNktBWHhzeWpDSnlNdGVaMUdCeUkzR0s2L2p1d3N2cGZEUDZyQkdJaGxH?=
 =?utf-8?B?SThpVTZHSzF1UkhENWlTOUhFeHR3MTZQOVlCZUllbk5WbVFTdFJWOFBsVFVj?=
 =?utf-8?B?VkhGOW0zWGEwOXozL3dwTm0rVnYxaDVWRW5ianNoVGc1WkgrYTRBYWd1RURv?=
 =?utf-8?B?SG8xek9sTXA2dGh3T2wxbkpOZWZZek5ybFJGbkE5aEdNVWVuNlVJWkE0NVJw?=
 =?utf-8?B?SlZESnViZmdSQXVMdlcxblN5QjhIWVNQVmZnMkdWVVBtZm8vYW1iY3hBVGFR?=
 =?utf-8?B?SlBFem9UT2REZzZRUWJpR2k0OGxwcHF0Q0Jicmt6Z2xjSDJNNTdTR0dWWHBr?=
 =?utf-8?B?VVZrWVVtTzYrckR6VG1Na1FjWC9LSVhWeGlrUXJwbGF2dGZuVzlMK0s5L2do?=
 =?utf-8?B?YmpoYmsydGRmQmVOK2xVYWNTazhPNEVxTWRGTkVPeWtNR1MzQ2kvNWN4dS9o?=
 =?utf-8?B?ZHFMcURtRVc0eHkwbzNZbU11Njd5ZGM3eTFlWFltZ05sVGx1K1Q5NENwZ2lR?=
 =?utf-8?B?MjhsZ2ZRKzlqUGVhaGdLdzlUbktOeWU2NjhIOG1oUlFQYnJZMy9LemtxMnVC?=
 =?utf-8?B?ck1YcFNyQVRoTzEyZ0JTRlBuQVZQZkdadG9CcTY2cHNyek0yeFozL042WHZE?=
 =?utf-8?B?clFodHVSQ3VzOFYrcjRLTFc0MC9hbGVyWkFLZ3J4N25PK1M0cXRLNHdkbkg0?=
 =?utf-8?B?SU9mT2FjczNkdjNUc3AyOE9BajZQNy9Ea3VxaGpoQXZXUFk5dGhCQ05ES1hj?=
 =?utf-8?B?SlJOdzhGNG4rcmZYcXNVNE9wdUNOVUxWQ3lsWGtjSHBySmNnbmhQN1daOXQv?=
 =?utf-8?B?SHliVEU1TGNIMUdsWFlvU1drZTZxeDAwSFZOemxRNGFkSkw2eEkzcys1dUlu?=
 =?utf-8?B?bFhuS3Nobmo4T3ZCTmNzLzJ1Q2dpVjk5akluSEc0VVVCNGwzMEFJcnNJOFVL?=
 =?utf-8?B?ZEd6dTNoeUJNR2RFTEVwMzk2L1dGaFE0SHhiTzhGY0M3L1g4QnhFOEl0Zklt?=
 =?utf-8?B?NTR4VlJpWHlPMTUrZGRkY1Y2Wm9TN3BydThWVlQ1WjZPbk50MlpLWW1sRkRY?=
 =?utf-8?B?UTgzcXVVbncwcUd1cUorUVgveTU3Ykpjb1pRREpReG5RUFF2bHZ2VW9VNklR?=
 =?utf-8?B?YThhSlNNRXI4NUNJRVl6K2k3eWFlUXFsYnV1UlJ5S1FyZVR5WGxjUnA1VTJ4?=
 =?utf-8?B?MndPZWJJaDhLUi82enZHRUpxVmxOaGFFcmJBM05SR29BTEtmRW5VSEhQWXFC?=
 =?utf-8?B?QVRoS3Y5bThXRldaSzZBVTZWdjYvdThKNjZFcUM4bXp6WGZaY0xtOFRvM2xC?=
 =?utf-8?B?TGJWWWxMVHFPLzdQalpIa3ltRGphazlYQ24rbnJoY05IbHdYRVNSNVBwaE53?=
 =?utf-8?B?UWQzTkRiK1hoY3h1Q2V1d0xZSU5VRE9BNWFZTkc5cFFhQVZ0Y0hsYlE1Q1V4?=
 =?utf-8?B?QTliVXI0MVVHZ24rcll4a2x5U1g2Zjd1QlVENFZvdVhyQVVBWWJaSm8zL2hU?=
 =?utf-8?B?K3FYNzhpUU1JUGNQR25TcVliZ0tuR25lTmpzRmxBb3NMT1FkSkFXdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afbecb71-b162-4a59-31ff-08da31aaa6f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 10:57:04.1322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MvzMrae95oyPna+A3O/Z5BRsiS8TDO0Zqy+XmJhHDgJAfJ8yPn8vgUTFB2AIw1GsxYVSs5ForcgISMyOIQqHYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2907
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbiAoT1NTKSA8cGVuZy5mYW5Ab3NzLm54cC5jb20+DQo+IFNlbnQ6IE1v
bmRheSwgTWF5IDksIDIwMjIgMzoyOSBQTQ0KPiANCj4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFu
QG54cC5jb20+DQo+IA0KPiBFbmFibGUgaS5NWDkzIGNsayBhbmQgcGluY3RybCBkcml2ZXIgZm9y
IGJvb3RpbmcgdGhlIHN5c3RlbQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcu
ZmFuQG54cC5jb20+DQoNClJldmlld2VkLWJ5OiBEb25nIEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0Bu
eHAuY29tPg0KDQpSZWdhcmRzDQpBaXNoZW5nDQo=
