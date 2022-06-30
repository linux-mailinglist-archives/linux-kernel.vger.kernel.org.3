Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B46A561F8B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbiF3PnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236200AbiF3PnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:43:20 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2051.outbound.protection.outlook.com [40.107.22.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B301F643C;
        Thu, 30 Jun 2022 08:43:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XT3E4KzkGzlPc2BjPX+20u2PxNPRHZytAIFpJommwVAB2Ub7MXU0WP5RLdkeGKaLdS0TA0k37jIoecbn+Gf81TqE6G3+W+zRIqymKbFp5m6aveiQVlptgGkF3fX2XW4GkJ6ezhDLhvwjlJmUBRtBY8oTbA4fq4ACwq0HqlyVBhiRMFM9ZR3MWmODSKn8MKOzwM7BpyR+Q2QOJAso1q1MrTQWlEDD/Wi5kfhy7C9k9dwakMVdOCMeeNkqLYNN/pYjK58TZzzO75NXfnUaW9xzBkR0r3GTZy7vWUCZW8ehCHDJ56b8Gh/qhCrNFDybBvxp41d/NIgFLvJVcQQ+7J++lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hWkgGvYtKyxXgcYv8X11uK/te7k+MZKhVyI5+l6hpE=;
 b=e7YYr8xckzPXtvsQcPZYm/FEj4NANwErh8tNpHjoaJ3+SobvmGshwnio90y1RZB8UjtIK26FWEstOYV2YA1Udpb8DhM1Cc36Vxv25YfW1eiwltsrSPpBQ4dJqd4Lr6Ft8qv2NAAPZTrwW6aDtTbm8133rkchrS0EVHr1iYG+5BkZ02s0sgkanuKNhtcF6qzYA9K86Iy2Yu/IvwmxvRKPioLy/pTslpBHmPu4OOR1QqJjGYNspChUBy/zpw8BAcdPYk4tC8MD/dN7xruOmzMmKohJivIJhW/Lxqw3diVFyeNpPa5kCgoTr7QJbM9Kk99hZJr4vMpooW3+IYfVv6vweg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hWkgGvYtKyxXgcYv8X11uK/te7k+MZKhVyI5+l6hpE=;
 b=bziD3baIm1l23d/nvf9SqwIsTI+WcE2lkCqXwYkpKKRbZg4Von9I1GcT87GGNSESVa7oY9S/54UDWbg9b2+NTY74Ull8q3c4UNWr05IDiNNWQigJT9Xey6wg9q3UmdXYAx4I2Kr++mmRbIPkof6KEXDqFMGneWwwgIUnjBTxwJ0=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR0402MB3904.eurprd04.prod.outlook.com (2603:10a6:803:17::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 15:43:15 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::71b7:8ed1:e4e0:3857]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::71b7:8ed1:e4e0:3857%4]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 15:43:15 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
CC:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: mscc: ocelot: enable FDMA usage
Thread-Topic: [PATCH] MIPS: mscc: ocelot: enable FDMA usage
Thread-Index: AQHYh97QV6mbRUNvdEuKYy1moheUK61oIHoA
Date:   Thu, 30 Jun 2022 15:43:15 +0000
Message-ID: <20220630154314.q65meid3vgfdso3z@skbuf>
References: <20220624152548.128700-1-clement.leger@bootlin.com>
In-Reply-To: <20220624152548.128700-1-clement.leger@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1ca7102-a5c6-4a53-89ff-08da5aaf3f21
x-ms-traffictypediagnostic: VI1PR0402MB3904:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iMoTrxXchTjl7LqmI+ABzXZHrSAzRfueSRDP1XHz8vY/S1WQ5Zfp/YmzN6s+qHN3RMORpcHU7eoJURRfwhmvHIlXz0Uz+m8lJoTYx+ymX2moJf8DnXTkSvcDjQ5cW9QAb0+PpWENeFbZcfT7uxi3wg1JVCBAXfzVvxzaQ1U8KV6UNOTd99jwwgvV1BS4uS70XHiH0eZpzYs8Xj49CL3gINgmFsuB5OIEtrTYCMmvY2fV6yotx2z3OCHJ0Rs9CwT6AAQ01p0YJGZ7eTxwXQpZ0O2/v33FtkWcwdC3Ti/x3WI/Ie5GrB3f+1yXt/bWHY5aS3VL//AV7TqAKAu5kEeoUqkwNyllMXR42veHyJ+xPwR/WJ/MzTCJzqOs7ZTnM7Glipg6KU16qY1SUWy95rC2od79yR30bJsw3IxiO2+qi0fKl14pIedHxIICmP4YFHfs++ONaZuonZcbhZsDtbdqXubvlghHkPbcqa8goiExERXNN1WEC0j4nuyz5hLC1LR2nct0gONVeLuqqBMBYLQmTB17R+o09pkAKjI9UZgB0pL0QCHD2TYqDdd1sMW+Ax6dBcx7TOVNYvRuuQwgEfOhO8Ju8aPGU7v3J1uCmHJ8lqxuowrhRKEWv7ignwNLV7TP7AEGKMM8XI0T1NfAVQJUSxmt3GP90WGQctuB8kg+Hth89lR0kATHxWYWuXlJrNIw5L4qg+gi8+kAJuiF26YMe792FSYyCU6/EoD/mn4f+StcA1WWShv6+F3rEY/NCbjoHu9XEwHN4mjn+nBlu+NAAGNJIZoHEx8Omvw8Z6xu9dhX1Z4y80u4XMEoa2Kp9Qmb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(366004)(346002)(39860400002)(396003)(136003)(376002)(86362001)(66556008)(66446008)(186003)(6512007)(91956017)(478600001)(4326008)(64756008)(5660300002)(9686003)(66946007)(316002)(41300700001)(38070700005)(6486002)(26005)(6506007)(6916009)(8676002)(54906003)(71200400001)(38100700002)(1076003)(66476007)(44832011)(558084003)(8936002)(2906002)(33716001)(122000001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1oOam93zMcR33s4uMRhZ0xLFkE6D499a+N59bMi5s4TluH6QxdwSCkSxJ1?=
 =?iso-8859-1?Q?BUGSZ39SYLsgt5nYQhYwOxPb0nPt2mQXlCYyhEeUhKLbbEcUfKA4XXgZT8?=
 =?iso-8859-1?Q?mxt0w28CJsJuZ7X/gJxnNWhYIhB0rSOwk6brSD73m+PdRQhKsegw5SiNVx?=
 =?iso-8859-1?Q?jxwUwz/eoXZ63Yb2P84hk2iHEHALMs2HNwokD/vJM4hMW0nI7vJKyL6byG?=
 =?iso-8859-1?Q?y0nmgL62Gow0wgU1C9TrYibbJ7b1MuoITRZeFL//lVyUVOe4W+pPGtfJhM?=
 =?iso-8859-1?Q?k739vfbSiWZNtYMTqwnFogoZnHENl3hprLLruIwMat+aY5VRCseupnx31k?=
 =?iso-8859-1?Q?1u0NULW2bBVKYFS23EGUG8DfkvwDsggZ/o2nys2EuQC3yYw7Hrel5+IuIz?=
 =?iso-8859-1?Q?P6hfzUmlGM1jBgf9AuinvEDyAKNVNpzzTdZbTj1M523nxq1GR/cDtJfOPT?=
 =?iso-8859-1?Q?OWXI+tfnK8WrOQAixsIksldsWE4Kvh00VeCOH8+N8PNnp0kZGnS6a2cx9K?=
 =?iso-8859-1?Q?LwF5YfNX95+3xPZ2pD09WUaorq8HXKwsvt/fItjmyK2JLctlJF6Yr9HwCq?=
 =?iso-8859-1?Q?s/GPwJPTgP+NAncCyMYC2hNz91pTIIeuOezwl/aZpkxYS3FNmZgvQzv/9a?=
 =?iso-8859-1?Q?AbfaQgco7qtu4YGzi5TCzEBRdD+XReIihVgCWvPrr31YMRpsWxqut2mveO?=
 =?iso-8859-1?Q?DNMrnSjBaOpd00UFqGcSaPA+mCpS1m4QFfwelTlhNKdvmljarLltTJcbnw?=
 =?iso-8859-1?Q?ePDMDahpgz5ARUT0ocqNi2BfhzX8dUZ8XVDwQWQft8gxgD/60R7YQz1USZ?=
 =?iso-8859-1?Q?fLqeTcHI5M0T81VQkJlVxXTnM7TRS/fVBauqE+JvLYNriEv0OY1CUTxMd7?=
 =?iso-8859-1?Q?XoAszxEjYcq2GNIrrOZVr5B0nGhtKOX8/SnFTEYLkstBFjloxx9WfxiPBu?=
 =?iso-8859-1?Q?WsuGIW2SPMiA4J/rpm7YmlB1qLKiojN6aRr59oBcEf/RWjCC/PDE++Szlo?=
 =?iso-8859-1?Q?VwSD1fMbunJMiiOHwcV4DUuzYaoJQWFpLqt7fBll7LB8mjQNRmoD67vdpb?=
 =?iso-8859-1?Q?8BJ90xzYBMMiui8Q3fEjqyUcrAG4puU93BNFPODCVPauuHCf0JhScW6GGn?=
 =?iso-8859-1?Q?VpPohHwKkCTEoSdc7iDtjCRd6qziMYXEHNbXA4/d/QGezcCmLeU6Lrwa38?=
 =?iso-8859-1?Q?r77ICcqM+ie8a0aPtxrGzAQ6FAXoDb2I9KsES7oWXvibGkWWU9CsNCIgDp?=
 =?iso-8859-1?Q?YA0+qyXV0EZZ5e1lj7lf512FHi4CZ5lAbnxVUnIJoRrpGTlghDthiZHOP6?=
 =?iso-8859-1?Q?CqNosLFYDB5hYSEJZF6cIjrtIWYVPf1JKgunyADP1HgCgAkujYRSHgrFEz?=
 =?iso-8859-1?Q?J5pC78X94VbDCt0wVN1x5LP//9iFLjIZC5y+7VtlPhvcUVAltUnaKl4GvR?=
 =?iso-8859-1?Q?PaFXE71NU5W/w5EFzxJcQu/rTdieGq0mdlMkInn1I8o7E9jl0p1TMDyj6L?=
 =?iso-8859-1?Q?GzFkAPmOQksxr+fZc6C7umkGlpad6ncyzSTMqUlcVsZPs2noq05xGcbG8v?=
 =?iso-8859-1?Q?pgLrRJNjon/b2Ow380WoJyB11eidbrGdVpIY65o+ee2lOyYuKFCkTXq9Vc?=
 =?iso-8859-1?Q?qpzbF0xJDPYtNS6OwV8nx5w5l7pv6ybWcNbrrUWpwvWc64G6ETbS1WDg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <A8B520D67D8F2142935AA4F3B2F2774B@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ca7102-a5c6-4a53-89ff-08da5aaf3f21
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 15:43:15.0660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lde5vx5vrsg1EyZmZURbxxZJUh3UDBAxGtQHWA4x82SQYNKveSNsJVZM6kqocAkWe+JO9ZQ4q+LLKaSo9mreOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3904
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 05:25:48PM +0200, Cl=E9ment L=E9ger wrote:
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
>=20
> Enable FDMA usage by adding "fdma" resource in regs and interrupts.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Cl=E9ment L=E9ger <clement.leger@bootlin.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>=
