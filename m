Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EBD547D5E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 03:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiFMBXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 21:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiFMBX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 21:23:27 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EE7BAC;
        Sun, 12 Jun 2022 18:23:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3awgTej/7llnJswGPgwz26pJEF7C+T0mgWWSuH6YCgi99gib76sYNlq8IvkKIZZqImpju++RMFEhI0PbPYDi3z9kGqi7qliF0bZyiEI2ffhJSzJy2hdDvF+03YuGMUm1dI6aBKc8xYMx0eUXhnNicQQ82mVEa2xY/KBxSeH8rc2sI3hLgDanO2fW+EUacAp5Jz9myhiskKrAh8Dw11xa0BIBzXPxcYFfRcX64PQ/z6PUNEOxWS+uRtXzweAA29pnDQRXOLXn0TyNtne5NxUu1iJPG+iEaPJ7uZM5mXNvIXlgSN7+kX5Gln2lN/aNNn9r61Ib7xv7i8N+dvybFtwag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h16zyG/rs43KguYCruxXlnFbU0ZdRwbQZ6S6SWj67mY=;
 b=B/G+M7smru1+HCDAGz97Cbsj+ff4/hdDeczedx4wDMTw3NJ/1FS1Pcn/UPb6lD9mPh2QQe3/ee0nFhMzPThc32o18GSngGy6B/ofb0EbsZ8mOanG1AZkdOSBbcUbKRI2SdKzO+npFUD0HTv9K6teipqj5HFf4QdteWIBFykO/boxAENujr78fhKbA0Eyd63Xl09wZ+KJGAFPVmGhmZ6OunzRStzrIoE3FnHSUM4gnNy1gtA8U1wSuDy3xHAYR6H3gPJn+vujsav2YVn7NKytNEyA1c7bx21PPj9nG+/evzjyK6Cmk1uYG8uJzh8VKjGL5V6/zxhaV38maxHpwhzFug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h16zyG/rs43KguYCruxXlnFbU0ZdRwbQZ6S6SWj67mY=;
 b=Q8MqA0BH8sBAgKIy8q2Ih2qADlyQMGiiD7rpVBv3JCbe8MLCJFyF4qL1vnqoPcHx4HBcTwiQWajEOHB3PSZSJLvxDQADWSBQFx8TyEcsrb4X3OxwlR7a4YohTWSoHPzdBMV4osKFAUH3gPC3oBKrQ+hXme9sbP0OtnzYaOlnZb0=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB4327.eurprd04.prod.outlook.com (2603:10a6:209:40::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.19; Mon, 13 Jun
 2022 01:23:19 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%8]) with mapi id 15.20.5332.015; Mon, 13 Jun 2022
 01:23:19 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "djakov@kernel.org" <djakov@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>, Abel Vesa <abel.vesa@nxp.com>,
        "abailon@baylibre.com" <abailon@baylibre.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "marex@denx.de" <marex@denx.de>,
        "paul.elder@ideasonboard.com" <paul.elder@ideasonboard.com>,
        "Markus.Niebel@ew.tq-group.com" <Markus.Niebel@ew.tq-group.com>,
        "aford173@gmail.com" <aford173@gmail.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 0/8] interconnect: support i.MX8MP
Thread-Topic: [PATCH 0/8] interconnect: support i.MX8MP
Thread-Index: AQHYdZuXp1k0Y8bakU2NzRLysk7WMq1Mm6BQ
Date:   Mon, 13 Jun 2022 01:23:18 +0000
Message-ID: <DU0PR04MB941799547BD863444C6F268D88AB9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220601094156.3388454-1-peng.fan@oss.nxp.com>
In-Reply-To: <20220601094156.3388454-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa016d06-251d-41fa-f610-08da4cdb4c73
x-ms-traffictypediagnostic: AM6PR04MB4327:EE_
x-microsoft-antispam-prvs: <AM6PR04MB4327FB5BF3689E1E7559594588AB9@AM6PR04MB4327.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9vk6cDWUo1yx12QTR5Hvo9/sQk9BXciW6nYJHbJxM2G8mMC7k0aiMhlXfcHz6oUGivW1/na/f4zMKqtBDt2utR4dDAP/A4hTCUMqPs3TgNcUpTdeoCD6tiZ7znf6c6+QxiYKuDBg7FnpdB465cKyOr5TRlqtLPRUtCzm0uYjz4OsSyKhwvwliF0PMgrk8bCvyHU29ypvbj7BzOYm/nL509NGTHor56CYakQzassqlOxomFgddZeGMqZm6t3ste4MXsEpdZJdHW4LTu2VJTj+YZ8TZI/Gw1FlCZfh4pFzCjNAaHuBsn7A8smLt3IKNy+dA3uTGev7254jyzw2vensULCVCmicq53389IAH/Q4mweEoEE/3H8E+ICLlOxyu4vTdzQnkiMfrzztMyypl4KkDJvlliC5P5Wd+ECJpovpvBxXFQ1M4VsOX6fMDVHzID3uzK2AyiMOtz3p8HkZRGqBxQSG150QXRNmFdwtX4O+Arib6Q/JY8ncEgF/gUBn13Q93MBLn3CpmpwOjXQB0BOxOzF1dyIyKz3lef3AfsSow+/AsGbOLsoK8bdV1icNRguwCzhidxupYBsMxvQWg088WCwRlKI2gcKc5EkxEbzmoPioEYOCbCYGM05eXy18HaMFtBk83fM5M8VschJRmEhDzwb0vK4iEqtKf6Ha53b2r5IBX8OCessGGwK9/c6EV85YqVcI4u6wU2SfCYIL6iJf8OX+1Lv9zCP+afZ02THRSbLmqE4hI6VIwgNnu+D5UYDdlOEMOBWW3Xsz9uOWZ2H7EiDk4V2oSiN3cyOIq1C+vGn+K3cswwpauytZAcdYhuqnCvTUbBtrLM2TyUEDhWDek5M9C5JXTbXfzOD/vfKkgBA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(52536014)(966005)(71200400001)(44832011)(86362001)(66946007)(122000001)(83380400001)(33656002)(921005)(66446008)(8676002)(66476007)(186003)(66556008)(76116006)(2906002)(4326008)(64756008)(7416002)(8936002)(508600001)(54906003)(5660300002)(110136005)(316002)(6506007)(7696005)(9686003)(26005)(38070700005)(55016003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xlCNgaBqyJOSQ9yQhKCoUvAsRgOsGf6nCP1otTjqBT+oM4wYLeqfBjmlrJMQ?=
 =?us-ascii?Q?M/cT8eJc6EryYkV0IAAZEi20P4xRsbEZThmn6Q5Dkj6ZasqDhsuGOYAxlLwF?=
 =?us-ascii?Q?H1VNvIDbRMY8tNRxUzUK9I/7+b/TVtxYdWalWug0S0JVn6sqdw0lQ1VR7TO8?=
 =?us-ascii?Q?JglfMMwQS8KTsrCA1BvpJ5SoQcgCdvHFQ5Sx4NpNxB9PhqGF73YKWB+OlqOn?=
 =?us-ascii?Q?+VFdbN4d0bP0y1RhnM7fWGV95u7GipDx9vQrBqn656MSk8YCek+IQWxLU3pl?=
 =?us-ascii?Q?kpQGDiMgtxhizX79qjmrLUHPSxaqvSWA1emwSgq5LB9sLnx01GKgYOYCKp3y?=
 =?us-ascii?Q?U7bjcK2QUrKfi1tot9aoqvpwzuUuJ+kux+AI9L0IRMDYLEETzXO4AoKmwF6q?=
 =?us-ascii?Q?iA7W3YXuafFYhUcSoyJQv6I+YiYLnd9z+P1cnCAco1/bKCghRveDxADPmciY?=
 =?us-ascii?Q?HkM9bqJEYwX8+uxrquUFdqUI3+QLmKNJFVlqkTwXl2bbusApgJiSEqPPvn9Z?=
 =?us-ascii?Q?dlUp26QJsbJSdUlL5OEKscG7yvAH12Tn4Ue38JTuKpy+Uk37HIJ5nflsrM0X?=
 =?us-ascii?Q?Fq83r2YIoToIPP5mmXOhanbB+16p6gpyupJNqOGjyxGUOa035Ht5mEeOStLn?=
 =?us-ascii?Q?u3qabAv31w9052nr5oWn7gMt1HmS9BxpO0L3qpwXa+6LvSCcFZuQu7a+t7jD?=
 =?us-ascii?Q?C4IGV+L2TpIJ/6gDgfrc9kWixU0i0uksQ8lIzyndbXKifMkE+yTNqlv8IIG7?=
 =?us-ascii?Q?y4wCmYWT/RzuEzuEGEUyePcgs0NFdbFvYQveYj4Daa/j2PUcaUfQUrqS5w7c?=
 =?us-ascii?Q?ZgtnWTPQRq5ix04szX7F7gAAY25Tcpw1N8HVrHSde4peiwa9hy12y63xMA2Q?=
 =?us-ascii?Q?Wa8Qq6jQ3FvCrQ/cCBoTcsIatzzDhCIr0NewRaiVLXnAqC4B/QFGCzTi7hl2?=
 =?us-ascii?Q?MytNFWt9QBJmodtQp1F+XH57P6rJliLzSeLR0qNOVqf8G1JeGblYo+RVI7lz?=
 =?us-ascii?Q?ELp7ofV7IjueK+AeOenG2qoNfq2rc4z+vcvFRZ/fPZk6sl3Y5YeNjygdR/BL?=
 =?us-ascii?Q?fpZTmBnFp7cV7vpqU+wsD8SXplGVmCm6g+vmE/nA7OrFCVbmsVOWzegeom1O?=
 =?us-ascii?Q?Ibk6RMOuzNm7+DSBgfNIhGcunBb4TQ5YH34mRZp8HUhOrJ+BbxI6KINodowJ?=
 =?us-ascii?Q?bgkIbImtFCfxdBZPjbrNVedQn8Ahuo+5Qt/7B66wTMPYs7+ieRjzUTsudNnF?=
 =?us-ascii?Q?kKhLgDUKKPKx9c1G52uv2XoLwk1WB4b0ivPxJ5+xjuJZOuX9dCftnlQFSQWJ?=
 =?us-ascii?Q?GFMqWy8NR/K59wcAR+kEXWrm3NSkJN+JvIE9cI/RCppMWgn0QYcr154jHL5g?=
 =?us-ascii?Q?FV9hSHt1jumoMVyY0jmNyVtkKnZn99+LriNyj8FaSJl0m+noetAs6Z4y1+xV?=
 =?us-ascii?Q?0+yu/Q7lHMLnB+prO5/IUwel2HBJ5n3H7lR5Ti8JNfliJUuiLVD8e647KbJn?=
 =?us-ascii?Q?k3UdbCx2wg0PcudFWUgYWkGPN57kYmsb63aW8oKdTpuCQXl3sUpFs/26pNCY?=
 =?us-ascii?Q?7IaYb2Ts8Iod4QO0Q3gkEbPchQ7CyCTHlINnBfjPlN5EJV4rV7bv2c/aviiZ?=
 =?us-ascii?Q?uJ+RzhZLWaM2B3ksx8hRs8jgQSMjw/quYkFcWZV6Ee3bSZuDuKDb79DzoUJN?=
 =?us-ascii?Q?AM4aDmwTk9wXC7Z+HR4Wlu7MX4Gb4a3DyBRGFqFqbcn7A/TY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa016d06-251d-41fa-f610-08da4cdb4c73
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 01:23:18.9938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /DncKipyGXC1h7Kg8kkIo/PWrR+jW00vLOsnHSSQsDfVOFjuZSYVTemkusphesQTdIc1+XXP7X/6Vh4dR6u+TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4327
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All,

> Subject: [PATCH 0/8] interconnect: support i.MX8MP

I am going to send out V2 this week to address the comments until now.
But before that I would like to see if any one has any comments on the
design here.

Georgi, do you have comments on Patch 2 " interconnect: add device
managed bulk API"

Lucas, since you had comments when I first use syscon to configure NoC,
are you ok with the design to use interconnect in this patchset?

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> This patchset is to support i.MX8MP NoC settings, i.MX8MP NoC initial val=
ue
> after power up is invalid, need set a valid value after related power dom=
ain up.
>=20
> This patchset also includes two patch[1,2] during my development to enabl=
e the
> ICC feature for i.MX8MP.
>=20
> I not include ddrc DVFS in this patchset, ths patchset is only to support=
 NoC
> value mode/priority/ext_control being set to a valid value that suggested=
 by
> i.MX Chip Design Team. The value is same as NXP downstream one inside Arm
> Trusted Firmware:
> https://source.codeaurora.org/external/imx/imx-atf/tree/plat/imx/imx8m/im=
x
> 8mp/gpc.c?h=3Dlf_v2.4#n97
>=20
> A repo created here:
> https://github.com/MrVan/linux/tree/imx8mp-interconnect
>=20
> Peng Fan (8):
>   dt-bindings: interconnect: imx8m: Add bindings for imx8mp noc
>   interconnect: add device managed bulk API
>   interconnect: imx: fix max_node_id
>   interconnect: imx: set src node
>   interconnect: imx: introduce imx_icc_provider
>   interconnect: imx: set of_node for interconnect provider
>   interconnect: imx: configure NoC mode/prioriry/ext_control
>   interconnect: imx: Add platform driver for imx8mp
>=20
>  .../bindings/interconnect/fsl,imx8m-noc.yaml  |   6 +
>  drivers/interconnect/bulk.c                   |  34 +++
>  drivers/interconnect/imx/Kconfig              |   4 +
>  drivers/interconnect/imx/Makefile             |   2 +
>  drivers/interconnect/imx/imx.c                |  68 +++--
>  drivers/interconnect/imx/imx.h                |  25 +-
>  drivers/interconnect/imx/imx8mm.c             |   2 +-
>  drivers/interconnect/imx/imx8mn.c             |   2 +-
>  drivers/interconnect/imx/imx8mp.c             | 232
> ++++++++++++++++++
>  drivers/interconnect/imx/imx8mq.c             |   2 +-
>  include/dt-bindings/interconnect/fsl,imx8mp.h |  59 +++++
>  include/linux/interconnect.h                  |   6 +
>  12 files changed, 424 insertions(+), 18 deletions(-)  create mode 100644
> drivers/interconnect/imx/imx8mp.c  create mode 100644
> include/dt-bindings/interconnect/fsl,imx8mp.h
>=20
> --
> 2.25.1

