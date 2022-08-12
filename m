Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4335909CE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 03:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbiHLBZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 21:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiHLBZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 21:25:44 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70051.outbound.protection.outlook.com [40.107.7.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD68325581;
        Thu, 11 Aug 2022 18:25:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDZxH5ESiX7gxzic8cZSFR30Li9a65ubQv5+jLPkUcT/tP9BRCODVj0L0EmIboCJUpv4MeFyfEyUkHDz2aDcWjEtPadDBNYjYgcwTLFJe2FW8W2brxK7Bjv7q1JrO4GXHCnmqnjXOhqQiwp9PGrNGVP9bdvXhbaAVJNS10lkng125q3qVsFBUr2pMbjsyQZyuIZydK1sBLIdVa3iunsd+2euUm3NBLr0yoM4ccwD9NbrpLRGYuu6JsPU3qjPTUNB5Tg81FWPWdXRZ65xOcRxqV2ZCPPy0GckaFjRY+X+dJ47Wao59X8Gt+JRos4gkzjs2klI66Pi6Lvs/bolATrGSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPz1BXZZnJ2Xr2Yzz78Yfxyq7Ql90//OHKzvMVUfFMc=;
 b=UWHBpZimoS+aNxyADw5A73wUcCZO6BNZwmVNNIhywFzuMPyyZSzEi9cs37Iqi/O567bYdnc4QL6gQ8LvK/w+j0hEgw0BCSK1cm0bEgQmgm76GBly+8ubSff/wOCvGCVWqhER/i7WcnoCzQqXVGe0pMNZuim9Tz9yB2RcqWWVZyqlpnLkocR+rGAWdCBArma8uXTgphFn15AS0Ei5Pcf7Graq/BROMhMXgKPUh8o6jkLLuHSRBzPLH3zmeVPdu8QwibTfrGAeQ/VmYXg28HGEDdBBGTnoFrQB1br9CCv82e8BCqwgLNZlJAf2o5DNQ/oi4lMHH5CLTSUqauPmH5rI1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPz1BXZZnJ2Xr2Yzz78Yfxyq7Ql90//OHKzvMVUfFMc=;
 b=XiQFlIFpQxRNQ+M9bNRkN7M+/2TRR2EPKBTijMUrlRFXOXATKd0IFC7530w/VMl+v5YpJrxsmhhhq8dGeDfH0+d9jLvUPg0rQqUlBZFBTcLLJbr3WjyEtSgYR2wRVDq/u15n79SaKUdLGEucbZneuJcKyBamv6dU5Dromkg/7ms=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VE1PR04MB7214.eurprd04.prod.outlook.com (2603:10a6:800:1a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Fri, 12 Aug
 2022 01:25:37 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c%4]) with mapi id 15.20.5504.017; Fri, 12 Aug 2022
 01:25:37 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
CC:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "X.H. Bao" <xiahong.bao@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v4 1/4] media: add nv12_8l128 and
 nv12_10be_8l128 video format.
Thread-Topic: [EXT] Re: [PATCH v4 1/4] media: add nv12_8l128 and
 nv12_10be_8l128 video format.
Thread-Index: AQHYq7vKZWAESDmzLEOU58630Dz/+q2p092AgACncmA=
Date:   Fri, 12 Aug 2022 01:25:37 +0000
Message-ID: <AM6PR04MB6341198A94DC408DF921503BE7679@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <cover.1660027440.git.ming.qian@nxp.com>
 <84842bffb432884a0fd84de96c6e64ee2273e511.1660027440.git.ming.qian@nxp.com>
 <20220811151853.GB6390@tom-ThinkPad-T14s-Gen-2i>
In-Reply-To: <20220811151853.GB6390@tom-ThinkPad-T14s-Gen-2i>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed83061f-e9ec-4e74-1826-08da7c018fdf
x-ms-traffictypediagnostic: VE1PR04MB7214:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5u9iNyDq/fGpVDr9XbyYzYgQzxIbhri69pazh9uhBRIfX8M52YUTZMu0kCH/1n4OV/anVMjelbx7ERo8DFQt1CZElIKGOM/GgbmovMce4Fm+t2COBDkRyWOEOPLVWH3pTrdkge/nBYSNSKkh3aIfyF4nPnqDOINrjWkqxCXAFB5Vo29Bl/wHdZ/apnCvzRyxQRuH6Iw2zmgnC0+qox9FLLA3RSQJtFILjAdrQADof8ZVe9Pg3IXpgwP+0s8HrIcs1UO1C+rORQWD/tCwWTZT4G7EQjXSqNbZA58swGSVhMs407tG/+3X+8/3aGtvZI8VuA3Nd7d+CMEbyz+fVPXW8dhzr+poX2+rkjgqhr0lItAdGIajdwR7v7K9UWT4Tj7wEFuYWJcUEgBKNVjX7hUdWqxNot3+qYb4an5GhIxOrfTsgjohjUdj0Y9e9hTU86Z1SPj6MOXaENJrxcOf1LEiIVlKclAo2gIs1mz+X894v2IxldqnoSXu28w8ZPqrwxzp2kwN/nzhwwASHW6dr5tzKBNtsxYuVN6kNgOYuZqtAWo8AM/S/1E9sAsb0R2tuisTuDtTEI7/o4kQSEucIYNuaq34HOSSaLFXCimlGof1DOwL1o1Nl7SlqTX2nzqzBQuBZjiYqXqiYmfrbpQ3tf+7cjHMHiAGv+uFDSinfvtOgiLO2KCqxcHxh9RCbvAIgG3OszH4Er5lCr9Hi43gN5HIiW4LYjkvO1e1Ly1KO81dt0HyWXBUmAdE6Q7w3aQko9biPLsBoxQeed8o75Jez04bQMkjpSqx8KB0zWmKxPtaejWN1KaJkZaK3BVyBznG7zagSVfDHbd+WaLRLw+1YY6cwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(316002)(6916009)(478600001)(71200400001)(45080400002)(41300700001)(54906003)(4326008)(64756008)(55016003)(2906002)(66476007)(76116006)(52536014)(8676002)(66556008)(38100700002)(66446008)(66946007)(44832011)(7416002)(5660300002)(8936002)(33656002)(86362001)(40140700001)(38070700005)(122000001)(186003)(9686003)(6506007)(26005)(83380400001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?aERYUDRMaHVQTmJoZC9jZk1wRDQ1aC9tTFM0bk82OG1RcTgyUGk5SnhUcnFY?=
 =?gb2312?B?WldmNEppa2ZWd0JjVDdlWEVEb3RiT2xXa3NQeklrWlBxeHJqSHU1WFB4K3I3?=
 =?gb2312?B?VXp1YVNrMVNYR25nQWF2OHk5VGZDQnVUYkJNLzZ2RzRhZ2p2TVppalM3a2pV?=
 =?gb2312?B?RmFXUERNWExCUHFnQlZ3VmdrUE03ZFdXcUV1RjBRNGRTMHFYMnJJMU51c216?=
 =?gb2312?B?VnVxRnJ3bHVCWnpNOCt1VStwUUlvTjBIKzlVUWxXYkVLdXpMWmNLRVA4Y0NC?=
 =?gb2312?B?RzFhR1I5alQxb0FjeWg4eWszZksrS3huMjA0QmxzWFE0TW9MQzhaYjhQR0NO?=
 =?gb2312?B?U1hvOXpIMWpwQW0wS3FUWWxleGNPcmlPKzBybzMrRnIvQnkxOEhjbHpEUkZD?=
 =?gb2312?B?YUxJWXZiZTdEaHhzTHl2cEJ4RGFmc3VYcGtucGZoNWJMWEtmTnpNbUtGbDBv?=
 =?gb2312?B?QmxaTzJOM0p2SzFEZDFNY3RlVDFuK2pkcE5FK2NadlNsblV1SldoL0EvNHVE?=
 =?gb2312?B?RUh3TTR3b3AxZC9lenozUXZNWnhRdjVYYTliQklNanhvWXZuSHRUUW0wSDZN?=
 =?gb2312?B?eFN2NHZ5L3dZQWFaUkRsN0V1K3hudm1jeVFvQmsvcXhwQ0ZRN3YydFNKZXFY?=
 =?gb2312?B?blgwY0xpUVVpK3V0OTBNcUQzSXhVZndKdXNTeXVyS2pjcEpMemZPTmYwdmNP?=
 =?gb2312?B?SS9oclp1Y0prT0k4SWdUaWlTNktpekRsd2JMaXRad1dLNkp6eWdBelJ2dklx?=
 =?gb2312?B?bmUrRDk5c3ZpbHZDQjRZU3FDclhCOFJkQjNCbmFjYnV5YzJYNzVZelZFMHlz?=
 =?gb2312?B?NHY0Vnh3NFhiaWFudENQb1NFRDBKZmNKVGN5RERUSkxkajRyMWZzYjVrTnlR?=
 =?gb2312?B?cktza0hpaTBxdTlKRFZhSG1uUGRrSnphUmgyU2lBbk5jYXora1EyLzJWL0cv?=
 =?gb2312?B?VFgvc1NTUXFobzQxNGtVQkM5ZXc1eU9WZUdjaFVlckFqUDhNcE5aR3Npby9I?=
 =?gb2312?B?RWtlNmFZVDk3VUgrOEVIUDZVYzdMSTFNbG4yZ0xXb0s1eWNjayt4N2Y0VFh4?=
 =?gb2312?B?MU9xQk5UWndDYUNwNUhXWWErdWgrOVZMR2lGMFRiSWFCVVd6Mlc2NE0vbC9H?=
 =?gb2312?B?T3J3NStNbHk2cXBPeEl5MnNNYkt0T0xmMFFQZjZBRmV0NWI4MUlhSFQ1S21p?=
 =?gb2312?B?dFhzdkxoblk5eDNwZnRDNFJmaTBwYVFFTUJBNEMwL2REQTBSZU9NM2xqMFJ4?=
 =?gb2312?B?MjFjVVd6THhkSzN4V2piYkp6eFN5bEJyMTA1eUgxWEg0eXB2bVJTR0hSKzZC?=
 =?gb2312?B?ZTJkbG41QlBEVFlpQlNlUng2YnFqeGR6cExCT21MVkF3WFNyOFA3eFNBaEVI?=
 =?gb2312?B?MGZLZW91Sjg4SElCUlJmUEZ1K25FcXV0OGg4SVU4R2Y2cUliQVdjbmhrQkhH?=
 =?gb2312?B?KzV0cXRrVkFpUHFQNUJ0VTJneG1JVTZvdnd3eU10SXNmdzY2bjNKdnp5UmRn?=
 =?gb2312?B?YzJsdTdHR0k4cld4dWZsUG90NzM4Q1k2YUdKb2FqT050dmtZVWFmMGw4OEhw?=
 =?gb2312?B?Zmp3R3ZUVVpoTXc5NFU4TXFaT0lVUXBKZHJwbnNBWGJGMDg0ZnVBVlAxczRX?=
 =?gb2312?B?dWF1MzgrZG1uQ00vVXluM2d6M2IxYXNDUlZTR3ljUEVPOTJBRVFtdU8xSUF6?=
 =?gb2312?B?eitSWjA0Sk1jeVFUQjlZVGpDeUdBTXdXMG9RUmVraS9LOVdOK3JkV1lSdjdP?=
 =?gb2312?B?UEFES0ZuUXdoOUMyV01wS1N5VVBkanAxL2ZDZmZnQjl0UzZqVmtETXphZ1FR?=
 =?gb2312?B?L0oySFJka1c4RVhSYUkxTUtGYnkwTGRYNEdaZWtKS3pqdjlIUTgvVTBmZ3h0?=
 =?gb2312?B?MitpcUoyUzcyV1NkbjRjRGRQdnNvM3I1TzgvUERhN3ZUUzdzYzdTYndYQ0hZ?=
 =?gb2312?B?MTUyTTBJcitROTVsTk9MWDBvajlNa003MndYQUUyYmlqU1BySmJCWXMyZ1B5?=
 =?gb2312?B?WFZ5cEJITHBza09OaUVrNEs5MWR6K2FDaEZxRjlzZlhlZjNWcXRCRDcyQWdO?=
 =?gb2312?B?aE9ORXRvRG9RcHA3Z0h1am9RYXhZT1dmanI2bk9sQzU4OE1nNURaSHZUUUYy?=
 =?gb2312?Q?LAgQ=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed83061f-e9ec-4e74-1826-08da7c018fdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2022 01:25:37.6451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sXIxykCFL/VPXYb3gyryJL87BRRZtf7WqmKbBh4ZEsaYbRPNcMnQIP/cqdZYwRTn7JDzW0XWCdudWQPv9KJAyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7214
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PkZyb206IFRvbW1hc28gTWVyY2lhaSA8dG9tbWFzby5tZXJjaWFpQGFtYXJ1bGFzb2x1dGlvbnMu
Y29tPg0KPlNlbnQ6IDIwMjLE6jjUwjExyNUgMjM6MTkNCj5UbzogTWluZyBRaWFuIDxtaW5nLnFp
YW5AbnhwLmNvbT4NCj5DYzogbWNoZWhhYkBrZXJuZWwub3JnOyBodmVya3VpbC1jaXNjb0B4czRh
bGwubmw7IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+cm9iaCtkdEBrZXJuZWwub3JnOyBzLmhhdWVy
QHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+ZmVzdGV2YW1AZ21haWwu
Y29tOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsgWC5ILiBCYW8NCj48eGlhaG9u
Zy5iYW9AbnhwLmNvbT47IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZzsNCj5saW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcN
Cj5TdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIHY0IDEvNF0gbWVkaWE6IGFkZCBudjEyXzhsMTI4
IGFuZA0KPm52MTJfMTBiZV84bDEyOCB2aWRlbyBmb3JtYXQuDQo+DQo+Q2F1dGlvbjogRVhUIEVt
YWlsDQo+DQo+SGkgTWluZywNCj4NCj5PbiBUdWUsIEF1ZyAwOSwgMjAyMiBhdCAwMjo1MDozOFBN
ICswODAwLCBNaW5nIFFpYW4gd3JvdGU6DQo+PiBhZGQgY29udGlndW91cyBudjEyIHRpbGVkIGZv
cm1hdCBudjEyXzhsMTI4IGFuZCBudjEyXzEwYmVfOGwxMjgNCj4+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBNaW5nIFFpYW4gPG1pbmcucWlhbkBueHAuY29tPg0KPj4gUmV2aWV3ZWQtYnk6IE5pY29sYXMg
RHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAY29sbGFib3JhLmNvbT4NCj4+IC0tLQ0KPj4gIC4u
Li91c2Vyc3BhY2UtYXBpL21lZGlhL3Y0bC9waXhmbXQteXV2LXBsYW5hci5yc3QgICAgICAgICB8
IDggKysrKysrKysNCj4+ICBkcml2ZXJzL21lZGlhL3Y0bDItY29yZS92NGwyLWlvY3RsLmMgICAg
ICAgICAgICAgICAgICAgICAgfCAyICsrDQo+PiAgaW5jbHVkZS91YXBpL2xpbnV4L3ZpZGVvZGV2
Mi5oICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMiArKw0KPj4gIDMgZmlsZXMgY2hhbmdl
ZCwgMTIgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQNCj4+IGEvRG9jdW1lbnRhdGlv
bi91c2Vyc3BhY2UtYXBpL21lZGlhL3Y0bC9waXhmbXQteXV2LXBsYW5hci5yc3QNCj4+IGIvRG9j
dW1lbnRhdGlvbi91c2Vyc3BhY2UtYXBpL21lZGlhL3Y0bC9waXhmbXQteXV2LXBsYW5hci5yc3QN
Cj4+IGluZGV4IDEwYjFmZWViMGI1Ny4uZjFkNWJiN2I4MDZkIDEwMDY0NA0KPj4gLS0tIGEvRG9j
dW1lbnRhdGlvbi91c2Vyc3BhY2UtYXBpL21lZGlhL3Y0bC9waXhmbXQteXV2LXBsYW5hci5yc3QN
Cj4+ICsrKyBiL0RvY3VtZW50YXRpb24vdXNlcnNwYWNlLWFwaS9tZWRpYS92NGwvcGl4Zm10LXl1
di1wbGFuYXIucnN0DQo+PiBAQCAtMjczLDcgKzI3Myw5IEBAIG9mIHRoZSBsdW1hIHBsYW5lLg0K
Pj4gIC4uIF9WNEwyLVBJWC1GTVQtTlYxMi0xNkwxNjoNCj4+ICAuLiBfVjRMMi1QSVgtRk1ULU5W
MTItMzJMMzI6DQo+PiAgLi4gX1Y0TDItUElYLUZNVC1OVjEyTS04TDEyODoNCj4+ICsuLiBfVjRM
Mi1QSVgtRk1ULU5WMTItOEwxMjg6DQo+PiAgLi4gX1Y0TDItUElYLUZNVC1OVjEyTS0xMEJFLThM
MTI4Og0KPj4gKy4uIF9WNEwyLVBJWC1GTVQtTlYxMi0xMEJFLThMMTI4Og0KPj4gIC4uIF9WNEwy
LVBJWC1GTVQtTU0yMToNCj4+DQo+PiAgVGlsZWQgTlYxMg0KPj4gQEAgLTMxOSw2ICszMjEsOSBA
QCBwaXhlbHMgaW4gMkQgOHgxMjggdGlsZXMsIGFuZCBzdG9yZXMgdGlsZXMgbGluZWFybHkgaW4N
Cj5tZW1vcnkuDQo+PiAgVGhlIGltYWdlIGhlaWdodCBtdXN0IGJlIGFsaWduZWQgdG8gYSBtdWx0
aXBsZSBvZiAxMjguDQo+PiAgVGhlIGxheW91dHMgb2YgdGhlIGx1bWEgYW5kIGNocm9tYSBwbGFu
ZXMgYXJlIGlkZW50aWNhbC4NCj4+DQo+PiArYGBWNEwyX1BJWF9GTVRfTlYxMl84TDEyOGBgIGlz
IHNpbWlsYXIgdG8NCj4+ICtgYFY0TDJfUElYX0ZNVF9OVjEyTV84TDEyOGBgIGJ1dCBzdG9yZXMg
dHdvIHBsYW5lcyBpbiBvbmUgbWVtb3J5Lg0KPj4gKw0KPg0KPkRvbid0IGtub3csIG1heWJlIHdl
IG5lZWQgbW9yZSBkZXRhaWxzIGhlcmU/DQoNCkhpIFRvbW1hc28sDQogICAgSSBoYXZlIGFkZGVk
IHRoZSBub24gY29udGlndW91cyBmb3JtYXQgVjRMMl9QSVhfRk1UX05WMTJNXzhMMTI4LCB0aGV5
J3JlIGFsbW9zdCBzYW1lLCBidXQgc3RvcmUgdHdvIHBsYW5lcyBpbiBjb250aWd1b3VzIG1lbW9y
eSBvciBub24gY29udGlndW91cyBtZW1vcnksIGp1c3QgbGlrZSBOVjEyIGFuZCBOVjEyTSwgIA0K
ICAgIHRoZSBkZXNjcmlwdGlvbnMgYXJlIGFsbW9zdCB0aGUgc2FtZSwgc28gSSBqdXN0IHNheSBW
NEwyX1BJWF9GTVRfTlYxMl84TDEyOCBpcyBzaW1pbGFyIHRvIFY0TDJfUElYX0ZNVF9OVjEyTV84
TDEyOC4NCiAgICBEbyBJIG5lZWQgdG8gY29weSB0aGUgZnVsbCBkZXNjcmlwdGlvbiBmcm9tIHRo
ZSBWNEwyX1BJWF9GTVRfTlYxMk1fOEwxMjggdG8gaGVyZT8NCg0KTWluZw0KDQo+DQo+PiAgYGBW
NEwyX1BJWF9GTVRfTlYxMk1fMTBCRV84TDEyOGBgIGlzIHNpbWlsYXIgdG8NCj4+IGBgVjRMMl9Q
SVhfRk1UX05WMTJNYGAgYnV0IHN0b3Jlcw0KPj4gIDEwIGJpdHMgcGl4ZWxzIGluIDJEIDh4MTI4
IHRpbGVzLCBhbmQgc3RvcmVzIHRpbGVzIGxpbmVhcmx5IGluIG1lbW9yeS4NCj4+ICB0aGUgZGF0
YSBpcyBhcnJhbmdlZCBpbiBiaWcgZW5kaWFuIG9yZGVyLg0KPj4gQEAgLTMzNCw2ICszMzksOSBA
QCBieXRlIDI6IFkxKGJpdHMgMy0wKSBZMihiaXRzIDktNikgIGJ5dGUgMzogWTIoYml0cw0KPj4g
NS0wKSBZMyhiaXRzIDktOCkgIGJ5dGUgNDogWTMoYml0cyA3LTApDQo+Pg0KPj4gK2BgVjRMMl9Q
SVhfRk1UX05WMTJfMTBCRV84TDEyOGBgIGlzIHNpbWlsYXIgdG8NCj4+ICtgYFY0TDJfUElYX0ZN
VF9OVjEyTV8xMEJFXzhMMTI4YGAgYnV0IHN0b3JlcyB0d28gcGxhbmVzIGluIG9uZQ0KPm1lbW9y
eS4NCj4+ICsNCj4NCj5oZXJlIGFsc28/DQoNCkl0J3MgdGhlIHNhbWUgaXNzdWUuDQoNCj4NCj4+
ICBgYFY0TDJfUElYX0ZNVF9NTTIxYGAgc3RvcmUgbHVtYSBwaXhlbCBpbiAxNngzMiB0aWxlcywg
YW5kIGNocm9tYQ0KPj4gcGl4ZWxzICBpbiAxNngxNiB0aWxlcy4gVGhlIGxpbmUgc3RyaWRlIG11
c3QgYmUgYWxpZ25lZCB0byBhIG11bHRpcGxlDQo+PiBvZiAxNiBhbmQgdGhlICBpbWFnZSBoZWln
aHQgbXVzdCBiZSBhbGlnbmVkIHRvIGEgbXVsdGlwbGUgb2YgMzIuIFRoZQ0KPj4gbnVtYmVyIG9m
IGx1bWEgYW5kIGNocm9tYSBkaWZmIC0tZ2l0DQo+PiBhL2RyaXZlcnMvbWVkaWEvdjRsMi1jb3Jl
L3Y0bDItaW9jdGwuYw0KPj4gYi9kcml2ZXJzL21lZGlhL3Y0bDItY29yZS92NGwyLWlvY3RsLmMN
Cj4+IGluZGV4IGMzMTQwMjVkOTc3ZS4uZDk3M2JkMmZmNzUwIDEwMDY0NA0KPj4gLS0tIGEvZHJp
dmVycy9tZWRpYS92NGwyLWNvcmUvdjRsMi1pb2N0bC5jDQo+PiArKysgYi9kcml2ZXJzL21lZGlh
L3Y0bDItY29yZS92NGwyLWlvY3RsLmMNCj4+IEBAIC0xNDQ0LDcgKzE0NDQsOSBAQCBzdGF0aWMg
dm9pZCB2NGxfZmlsbF9mbXRkZXNjKHN0cnVjdCB2NGwyX2ZtdGRlc2MNCj4qZm10KQ0KPj4gICAg
ICAgY2FzZSBWNEwyX01FVEFfRk1UX1ZJVklEOiAgICAgICBkZXNjciA9ICJWaXZpZCBNZXRhZGF0
YSI7IGJyZWFrOw0KPj4gICAgICAgY2FzZSBWNEwyX01FVEFfRk1UX1JLX0lTUDFfUEFSQU1TOiAg
ICAgIGRlc2NyID0gIlJvY2tjaGlwDQo+SVNQMSAzQSBQYXJhbWV0ZXJzIjsgYnJlYWs7DQo+PiAg
ICAgICBjYXNlIFY0TDJfTUVUQV9GTVRfUktfSVNQMV9TVEFUXzNBOiAgICAgZGVzY3IgPSAiUm9j
a2NoaXAgSVNQMQ0KPjNBIFN0YXRpc3RpY3MiOyBicmVhazsNCj4+ICsgICAgIGNhc2UgVjRMMl9Q
SVhfRk1UX05WMTJfOEwxMjg6ICAgZGVzY3IgPSAiTlYxMiAoOHgxMjggTGluZWFyKSI7DQo+YnJl
YWs7DQo+PiAgICAgICBjYXNlIFY0TDJfUElYX0ZNVF9OVjEyTV84TDEyODogIGRlc2NyID0gIk5W
MTJNICg4eDEyOA0KPkxpbmVhcikiOw0KPj4gYnJlYWs7DQo+PiArICAgICBjYXNlIFY0TDJfUElY
X0ZNVF9OVjEyXzEwQkVfOEwxMjg6ICAgICAgZGVzY3IgPSAiMTAtYml0IE5WMTINCj4oOHgxMjgg
TGluZWFyLCBCRSkiOyBicmVhazsNCj4+ICAgICAgIGNhc2UgVjRMMl9QSVhfRk1UX05WMTJNXzEw
QkVfOEwxMjg6ICAgICBkZXNjciA9ICIxMC1iaXQNCj5OVjEyTSAoOHgxMjggTGluZWFyLCBCRSki
OyBicmVhazsNCj4+DQo+PiAgICAgICBkZWZhdWx0Og0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
dWFwaS9saW51eC92aWRlb2RldjIuaA0KPj4gYi9pbmNsdWRlL3VhcGkvbGludXgvdmlkZW9kZXYy
LmggaW5kZXggY2Q2NmUwMWVkM2MzLi42NGYxNjQ5MGRkMmINCj4+IDEwMDY0NA0KPj4gLS0tIGEv
aW5jbHVkZS91YXBpL2xpbnV4L3ZpZGVvZGV2Mi5oDQo+PiArKysgYi9pbmNsdWRlL3VhcGkvbGlu
dXgvdmlkZW9kZXYyLmgNCj4+IEBAIC02NTUsNiArNjU1LDggQEAgc3RydWN0IHY0bDJfcGl4X2Zv
cm1hdCB7ICAjZGVmaW5lDQo+PiBWNEwyX1BJWF9GTVRfTlYxMl8xNkwxNiB2NGwyX2ZvdXJjYygn
SCcsICdNJywgJzEnLCAnMicpIC8qIDEyICBZL0NiQ3INCj4+IDQ6MjowIDE2eDE2IHRpbGVzICov
ICAjZGVmaW5lIFY0TDJfUElYX0ZNVF9OVjEyXzMyTDMyIHY0bDJfZm91cmNjKCdTJywNCj4+ICdU
JywgJzEnLCAnMicpIC8qIDEyICBZL0NiQ3IgNDoyOjAgMzJ4MzIgdGlsZXMgKi8gICNkZWZpbmUN
Cj4+IFY0TDJfUElYX0ZNVF9QMDEwXzRMNCB2NGwyX2ZvdXJjYygnVCcsICcwJywgJzEnLCAnMCcp
IC8qIDEyICBZL0NiQ3INCj4+IDQ6MjowIDEwLWJpdCA0eDQgbWFjcm9ibG9ja3MgKi8NCj4+ICsj
ZGVmaW5lIFY0TDJfUElYX0ZNVF9OVjEyXzhMMTI4ICAgICAgIHY0bDJfZm91cmNjKCdBJywgJ1Qn
LCAnMScsICcyJykgLyoNCj5ZL0NiQ3IgNDoyOjAgOHgxMjggdGlsZXMgKi8NCj4+ICsjZGVmaW5l
IFY0TDJfUElYX0ZNVF9OVjEyXzEwQkVfOEwxMjggIHY0bDJfZm91cmNjX2JlKCdBJywgJ1gnLCAn
MScsDQo+PiArJzInKSAvKiBZL0NiQ3IgNDoyOjAgMTAtYml0IDh4MTI4IHRpbGVzICovDQo+Pg0K
Pj4gIC8qIFRpbGVkIFlVViBmb3JtYXRzLCBub24gY29udGlndW91cyBwbGFuZXMgKi8gICNkZWZp
bmUNCj4+IFY0TDJfUElYX0ZNVF9OVjEyTVQgIHY0bDJfZm91cmNjKCdUJywgJ00nLCAnMScsICcy
JykgLyogMTIgIFkvQ2JDcg0KPj4gNDoyOjAgNjR4MzIgdGlsZXMgKi8NCj4+IC0tDQo+PiAyLjM3
LjENCj4+DQo+DQo+Rm9yIHRoZSBvdGhlciBwYXJ0cyBsb29rJ3MgZ29vZCB0byBtZS4NCj5SZXZp
ZXdlZC1ieTogVG9tbWFzbyBNZXJjaWFpIDx0b21tYXNvLm1lcmNpYWlAYW1hcnVsYXNvbHV0aW9u
cy5jb20+DQo+DQo+UmVnYXJkcywNCj5Ub21tYXNvDQo+DQo+LS0NCj5Ub21tYXNvIE1lcmNpYWkN
Cj5FbWJlZGRlZCBMaW51eCBFbmdpbmVlcg0KPnRvbW1hc28ubWVyY2lhaUBhbWFydWxhc29sdXRp
b25zLmNvbQ0KPl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4NCj5BbWFydWxh
IFNvbHV0aW9ucyBTUkwNCj5WaWEgTGUgQ2FuZXZhcmUgMzAsIDMxMTAwIFRyZXZpc28sIFZlbmV0
bywgSVQgVC4gKzM5IDA0MiAyNDMgNTMxMA0KPmluZm9AYW1hcnVsYXNvbHV0aW9ucy5jb20NCj5o
dHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUz
QSUyRiUyRnd3dy5hbQ0KPmFydWxhc29sdXRpb25zLmNvbSUyRiZhbXA7ZGF0YT0wNSU3QzAxJTdD
bWluZy5xaWFuJTQwbnhwLmNvbSU3Q2I2DQo+MTZkMDg5ZGNiYjQ3MTk1YjEzMDhkYTdiYWNjZjA1
JTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2Mw0KPjUlN0MwJTdDMCU3QzYzNzk1ODI3
OTM3OTE2NTE2NCU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXDQo+SWpvaU1DNHdMakF3TURB
aUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MzMA0KPjAw
JTdDJTdDJTdDJmFtcDtzZGF0YT1SZWVwcFA4UHFrUFFONXVRQ2xiMUNkUmNOdXBNRkh5YlJyYlFv
TQ0KPiUyQjJXa2clM0QmYW1wO3Jlc2VydmVkPTANCg==
