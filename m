Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB375ADD2B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 04:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbiIFCLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 22:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiIFCLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 22:11:46 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80054.outbound.protection.outlook.com [40.107.8.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F15D3F333;
        Mon,  5 Sep 2022 19:11:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/wjPzx2ydIewrxEFRlZf4p1AND6/3ajFl4H1og2teL9XLN0eN1Isnfx0dUdyakLGPuWHiBbT6sUkUpA4vdp3i+Ejia4LVwywbKuSNiNxU0Br17261ZP2JYSh1feHaecnyYzt3Cp2N4oWwSxMZs/WEOjFJQaOGIj3PoH2zLm6+KWKsB6XTX+RUIAkLKhUrlgo8yRbpz6wIw5NdCzrtyo+HVp1/hkJri1qD/gr8tyuaDn/I52R6wwUNRX67O+hvfUj7uMPw3z+SqfJi1FKjdKq4nO+J46647TFciDDbpmVurdbN82rEDRBC8qYEXm2V5hrpliw+bscqHzNDIqGD4tGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5HcHr7LTd5V2Bb2bOiYuqz+hiTRmzGnMx8sGDx3Z+I=;
 b=grUxJIfuzEtldVAdgtw4pjhUrMPjfe0kA+Sb1xTPifWjHrw0VsCAivXXmFs4UhDVbGuDo2nfOMMASCGkz03SJlMWdOiQD9rs3mX4dr73Uq0N43/4w9ZG+J0wxpkdfaiLcrEObiD19rul+A0fMxrl6gcM722IEfCHnhy3vxJ+t4b0ee3leo7O1WE2uQLGSzLexqZymvEBwDSyHeNXtgF7/ng2S90NSx50GHI3vMWRaIif6COAlzUOOg3p1TNHZeY547tqM+d+I2R/MszDN9tB6d6DdQ3YkfefSpPbypPg0/dRZfwajwONsLkz+uoqjV8vjFFyO62g4WrwBUtzG5FsCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5HcHr7LTd5V2Bb2bOiYuqz+hiTRmzGnMx8sGDx3Z+I=;
 b=aGUgZOiAycA6/v4wN1CwOsigTtShCJSVUkgSxHd9qcTDonrQJSgrw6an/JzOm5enKjGKIPg2p2w42Okx7zQjbhrNpp0yARfoSo/4JTpR5J22niqtV3f3W+NjV6IiQb0+6oTOc3FA0nkHy0+9c223ih2oaOWDNTBnHiHpZMjT1Jg=
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by VI1PR04MB5037.eurprd04.prod.outlook.com (2603:10a6:803:57::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.13; Tue, 6 Sep
 2022 02:11:39 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::f961:52e7:28f0:9094]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::f961:52e7:28f0:9094%6]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 02:11:39 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/7] watchdog: imx7ulp_wdt: update i.MX7ULP WDOG timer
 driver
Thread-Topic: [PATCH v2 0/7] watchdog: imx7ulp_wdt: update i.MX7ULP WDOG timer
 driver
Thread-Index: AQHYuF07MWeXDfz6qUWAYReSMbfZ963Ruz4w
Date:   Tue, 6 Sep 2022 02:11:39 +0000
Message-ID: <AM6PR04MB60538ED87D8A19C40443592BE27E9@AM6PR04MB6053.eurprd04.prod.outlook.com>
References: <20220825083256.14565-1-alice.guo@oss.nxp.com>
In-Reply-To: <20220825083256.14565-1-alice.guo@oss.nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27a7a730-594e-458b-7471-08da8fad2228
x-ms-traffictypediagnostic: VI1PR04MB5037:EE_
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KSRgVV3BkNj57rDXYEQzuNFZZ2thaauduHZgFpd1sYPfqpDiIdzRCrGYDWbrkAkq8TncwqcbFzZNPcbKoO8J5A0K49LqC2kX8HLQNB0PAldZt6S5c2Hyn6mSH7JhhUjmwZsTPAng/Umvzg2dVwOOPi851+4xw2b5Uq+Gw9zW4lOXLPazmkFCwr8qzbmXekCi7GQN5HF+HiqHfStbNqDc53AcMk18qkRzb+ZT117NymzshmYeQs7Iy2DHM6CwXKr7afi7LTwz6quhPuor7e7zrx1ZeauVV01CNKEnd00CIbe5/lH/nqJKX9qO7aZ/LGPsNA99l37fl3PRBkntvk5YRHre1phB2KUlDC+3nTya5Xc5VlxvTlRBr1omsw17HO5vZILDU+4RsBnkzVhMoz+liS8qPGhAjGBFYGj/+kTmOyvjnuoXHa0U9h7DVE/H5mCUWdIwAdappcBoVYorhIbOnrP2zOq0cQzB56/ZMemcHPzirTXrj1EKgu1Ep/jEe3/g/mhwuYGF/rnZo+mFc4TIX17x+9dCjHjcN82VMKsdTTYzQv7/0Z19D8BLMJXmBlfomUmvzoMBYVA+rr9XSfMvgJsy8flG7oJ7AFHW3eBKa/WIIpu8lpWGwDUg76HFeCDUM5uiIOVvFE4dnQaZZ7CNQLNqu0dvVf60i5Ix7iP87jyOUoe0X4mG8UVT/cu026bo/7gDfHkhzZ/fXeSIN4JQ5lGtHJghbWapqjc81VMpDb9Gd5RlWjxFqACR7KhluQIvGeEDio8s9xXCPFVAZl7gbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(66556008)(33656002)(83380400001)(66446008)(86362001)(64756008)(66476007)(478600001)(66946007)(76116006)(38070700005)(4326008)(53546011)(41300700001)(8676002)(9686003)(15650500001)(26005)(2906002)(6506007)(186003)(8936002)(52536014)(5660300002)(7696005)(122000001)(316002)(7416002)(38100700002)(110136005)(71200400001)(55016003)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RHu6iX1bVa5HEcKlchDl6yTzdbLQlgUK3D4LSGe1hNa6F6QSke7x8LQCtGhR?=
 =?us-ascii?Q?XlUcSBC0Vs0gJh2ffcpvCwr/S3HOyaP4ZDhmasOh1cTtUqeB3DiDeFuxv3kO?=
 =?us-ascii?Q?ZiIDQvLWgEbMSNc1EySA5g21yESQbgEeDneZUsySs/REkRtT+xrwoigVN6eI?=
 =?us-ascii?Q?jQA9NWfiiWISgUMqrWotCt3UHANUuDW8QgqBbun1nVsgKKFYkZLFjeMutE91?=
 =?us-ascii?Q?0wHmjH33GFsVBR8+9nZMJVWfwc/dtIjsmreRr3vvC61SL+28YyGVJCHkOXg2?=
 =?us-ascii?Q?RO7ZTKfe0sswuww2rN6wfk0l2tZ9AZ7qzgP3DQVULkkO1oNupmzMlJuMaW85?=
 =?us-ascii?Q?zu+En7++WC5xJ/QVmiwQsK76fHXJCz2Dcb76Vxj47vHROYZ/8BXAXhhODCSi?=
 =?us-ascii?Q?9iDCUa8wN/+rO/x56v94nkm3u1DtrOcXgPz7yrMLisZDwJlM26pwvXXBQawH?=
 =?us-ascii?Q?8y2vn16/nzEYkBhvx72Y/CTYKkmY3Jszj3P8f5cp8wDE3rwusaaJ4MO0pAwT?=
 =?us-ascii?Q?Hrgt4QP21J7RjJiGOJLp2sLQCymcQHnp4RZDE66D5fkCtL0nhWZCEBQQ4aRE?=
 =?us-ascii?Q?pyhDEGWqliaJt7qvhxES0SVXV2No+XyafmHOkavbk3Sw9Cr557BkZwzgTXn8?=
 =?us-ascii?Q?WvGGQbof7crQsTc8uiR74nMe13vHYiQdwYLv1NOXSIfyaMg7Q4XjXBVB+9vI?=
 =?us-ascii?Q?ykNMXAaJy0EJnpD7EnNYHqpV9bAXazUi+uxX78KU5NEZHUanNgKhq3N45H52?=
 =?us-ascii?Q?30uZUNnyC08aEfEa5ZNhlgJP6+EXTg96WDXNmdMQqg2O9xNaiW9aRvQgN6Jo?=
 =?us-ascii?Q?WRg95rrisD5QBLNMBFTEQ/qbQSkKgEnDSm/v4AXuwsDWnwj0IHJT0ywxtN7Y?=
 =?us-ascii?Q?flIhmDNxKrAwVv4K/Pl96F28ZfFPKrGUXPcZzNaaOx8aSZ9TKzBYIN1csAMd?=
 =?us-ascii?Q?AZfMjm5pr13KVSpuFdzcuJbQG8Uv34DDxDN7mTdYXRKDuXLty2YlChMts0/C?=
 =?us-ascii?Q?cLq9TxoiDZn+aIpT9JtC8jAmZtYtU3eN0PxtTBiT7fOl46Zu5z5TPer4UmAI?=
 =?us-ascii?Q?PwsdGz7Mnl+HwFG5/1NGNG63ee6OQJMwnZjRR7yXukx7MsE+/mUmTbWYPAta?=
 =?us-ascii?Q?fFU5a82iqTYGLqu/APkya2k8QFMDWYc56CyVcC3UWEAubaNqaTjN5pTsSWru?=
 =?us-ascii?Q?4oBM7nzbTWZ3iUqcYlBA/HelvIakbLZvpsHb41ReupQ4Ud8w+UsCDck0aW+2?=
 =?us-ascii?Q?ypZbDiikcBG2i9stApePctOpDxXaIOFSR1xjrHW0MWLKWbyvyz4HGNy2g47l?=
 =?us-ascii?Q?8cv4BhYVB+ppElX29zDu3zCESkQZiFM57eSZ3pIZ8K9HhC7TlBruaVHNJfyu?=
 =?us-ascii?Q?fvtFD3TcHxH0NMEk+KrY/reLZdrzV9TmeLKZPNd0lGQDcdjrQmXQ1GBGUnY7?=
 =?us-ascii?Q?SE6aTTxHmqjyQfSZ+viNxaNpA0jIudhWhQ5YM40afaGXD6SQr592XRQF57nj?=
 =?us-ascii?Q?U70yv51vCvwY5qHvQYHBU2+tzXkQXalSDDLuiB1AMUwBI3niLRRzbcP9n3ka?=
 =?us-ascii?Q?w3fz3rBasfz/6kU3uF0iSC5jiTQac/IjuWTabl7e?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a7a730-594e-458b-7471-08da8fad2228
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 02:11:39.1224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LbrgpASRyxucBJapIyt3ehqXhX1+h764GfqMbsamjSqZ81Q0fnnHV2WptZHN1RxW87iYIUsTVcF8LxQjQhP2qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5037
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A friendly ping...

Best Regards,
Alice Guo

> -----Original Message-----
> From: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> Sent: Thursday, August 25, 2022 4:33 PM
> To: m.felsch@pengutronix.de; linux@roeck-us.net; wim@linux-watchdog.org;
> shawnguo@kernel.org; s.hauer@pengutronix.de; festevam@gmail.com
> Cc: kernel@pengutronix.de; dl-linux-imx <linux-imx@nxp.com>;
> linux-watchdog@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org
> Subject: [PATCH v2 0/7] watchdog: imx7ulp_wdt: update i.MX7ULP WDOG
> timer driver
>=20
> From: Alice Guo <alice.guo@nxp.com>
>=20
> Alice Guo (1):
>   watchdog: imx93: add watchdog timer on imx93
>=20
> Anson Huang (1):
>   watchdog: imx7ulp: Move suspend/resume to noirq phase
>=20
> Jacky Bai (1):
>   watchdog: imx7ulp: Add explict memory barrier for unlock sequence
>=20
> Jason Liu (1):
>   watchdog: imx7ulp_wdt: init wdog when it was active
>=20
> Ye Li (3):
>   watchdog: imx7ulp_wdt: Check CMD32EN in wdog init
>   watchdog: imx7ulp_wdt: Fix RCS timeout issue
>   watchdog: imx7ulp_wdt: Handle wdog reconfigure failure
>=20
>  drivers/watchdog/imx7ulp_wdt.c | 212
> ++++++++++++++++++++++++++-------
>  1 file changed, 168 insertions(+), 44 deletions(-)
>=20
> --
> 2.17.1

