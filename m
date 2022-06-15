Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642F354C021
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 05:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349660AbiFODYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 23:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242783AbiFODYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 23:24:12 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DCD2EA2F;
        Tue, 14 Jun 2022 20:24:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9CB/nnhfwr14hGeo7sUzJ5aX24j+uMkRWR1tzD74yhZeKO2dR80OWPizmVtjcKsd6CYq4xp2I6W46P0UzVrFtbl+0mMG+4DNNEehmEWCcf7D+N1sMqZibzXcSAz74hj7T2y8O4DVd9Rmk6B7l4zb2yLGRIO1tuTZrR7qUg9eXs3166fhmxwM88Fy3PvNocg+tysLGfwV1pHLVd4Ufio8o0knYvpQSpjiPOekZgPVjFeZcTWxJ4gAE7Af/tBDG3UxckSI2gJPnr7VNZ+aoGhrhpXsrW8H3HA9agDOlL2ZVK6wfwOp/d7cnEidMEp21SXs4537hpWVrrEm8mHYwJGxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTRkzz0KoszR6PtevQFoqUqvE/dwQvDXUf0ikhe5gMU=;
 b=g5Ehd1JHQ6qQO7++2Pl8pvysNSeRwllFIoL5p37fm53GnH5qdhzQwENYtj8qdcqKGH6yAvCXAQcbsYLsTr6T2zFYps+SHwdbtWuQPuYUZg6wwZjwIYM60gcC3brHkpxqrz/Z49WQ7QE5AF4LK6zLnoqNcNB+29e+Mp478NTlxWuKFlD7ddk2pL+Uz5lMt35BP9buibe42dZduSjsVXJ/mCnCVWllEteFentdujPzGKuylSbT6yWeXSbTxqqMouT+3Ajtuoh54sY/DLAcO1lneT1KfJVyUCiZ600sa6aNOYVhd8LTdTbx5TjAliVzh0mb9XR6kglLhKkZpHG9wsGxSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTRkzz0KoszR6PtevQFoqUqvE/dwQvDXUf0ikhe5gMU=;
 b=LuHij6+3kAClwN8YFpieymYPoYNzb9u/iLDyqMBkzfsinKa0LwUCmuO1gMrvrRP8vhobWEEBw4A1U9IAYsYugMXpZkjb3WxnMgjE56rh4cGRwQEStNHphUgk84Px1dReq9CqRDi0WhPs6OxLsEMgOpezOZ+hNPiJ/O90ujLwVv8=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8817.eurprd04.prod.outlook.com (2603:10a6:20b:42c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Wed, 15 Jun
 2022 03:24:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%8]) with mapi id 15.20.5332.015; Wed, 15 Jun 2022
 03:24:03 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH V3 0/6] remoteproc: imx_rproc: support i.MX8QM/QXP
Thread-Topic: [PATCH V3 0/6] remoteproc: imx_rproc: support i.MX8QM/QXP
Thread-Index: AQHYaboGz7v8csTJX0uCaklNTdvzCK1P+z+w
Date:   Wed, 15 Jun 2022 03:24:03 +0000
Message-ID: <DU0PR04MB941740BC9C2C5B205985CAB588AD9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220517064937.4033441-1-peng.fan@oss.nxp.com>
In-Reply-To: <20220517064937.4033441-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f886f948-84cf-4571-595a-08da4e7e7f2f
x-ms-traffictypediagnostic: AS8PR04MB8817:EE_
x-microsoft-antispam-prvs: <AS8PR04MB8817E473BE432139B192DFD188AD9@AS8PR04MB8817.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Uc1qIagdHnql6wfYyTWmiF8JsPHYcZOqPK4Q2Yo5KOsaJfhNuAaU1XlMJrzzdirlabMfUnZY8iIXYWZDAZ++VgM3lTwJS1WCZPXuTmeaB2UXcooE2oxzIDetntrA8IhUgabTAPdsXNbDlFBsdA5Bh3Am1HItEyCibFgSj9+m5sPU83vP4WnlqnKIm1K4wEGJ/s4Xe3Jf6E10wigwnyU5LWfxtzyJGaZmmGdXa5+X9y6xlALdYNaW/705WJ0poL9pk/FOFk0mxr6p0qLIC+x77ADMfcUD+lpx2YqaDMznzZNe+VWg8nqpBrLSbSEifjApYt4dooUU8m8ArMbS60yiJyymEgBhl2BNFK4vbj29aacyKSKU2gROxi+yN0fgqyyYTi9XlMdM12GxJDAnM28j8hfXxUwqCu0/jiqKJql8g3qNfVQO5qIcNhgi3HJvEWt2evkAkspAOC6GI7V/207JDwHPn93XPBKwFlisW20r85NDg2uxC///q9lO5af/304+GNC4Fz5m2nD/L7U0BfNyxSOkiVOksi2YaNduI3lTvtiyEw2IAZ/yq/jDVcfeb+5eAYfCaM14npf1/PsvFkJtcwrziQPHSXQk2SdJy52QC52Ml+Pro+EmkMbBNN8fQi4tFVnz1JkN2Kze6K8bxSbVjB37bO5Gz93g0cucLypaXyUNsMhPXkp1MQgKGaubKbQqRKH0dDwdpwxo1fpRT2S+ZAVWcgY8bnohEZ58ERlsHcYac6wwoJJyzV/ui9O0v3dYLDxxtJUBX3QV0Ov+Pyf1Euacs14+BuDrmg6z/Dd7DoflXDuSdpDx1uh5RKRoeQUvG31zz2FrqE5pWWs8vmSEVew9zF6CblBgPSMCPBCkDc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(122000001)(921005)(186003)(66446008)(64756008)(66476007)(4326008)(8676002)(71200400001)(110136005)(76116006)(66556008)(66946007)(55016003)(316002)(6506007)(26005)(7696005)(9686003)(508600001)(8936002)(52536014)(966005)(2906002)(38100700002)(86362001)(38070700005)(83380400001)(33656002)(44832011)(7416002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tJQvMZhWRg3BxynBnpULGTEc4Vg5hJWWjc1Ec54Y78Dfo8vSCeOPnc88iRxx?=
 =?us-ascii?Q?aBX1tHurZ6o4+m1AN1nV1ZJugT/BqnmvtB50guabuH/80duE8Xlj4PnkhO3j?=
 =?us-ascii?Q?s0VJ4SQqtWbotlm5GLFGAt7nDjTG3GisLZ+ZEbEaEn2cXupx6UjhRMI0Xn+o?=
 =?us-ascii?Q?otbMMcMkLxhikXR8rC4eEJcIiwy91e2vxAsjYmOlt0MY7bv49M7Ma7MIe/fZ?=
 =?us-ascii?Q?WSffMsa+7GilUb0oQv4AafNOQi1u6bBko25VAgjq27kA0xAecpTWVyUzJsPh?=
 =?us-ascii?Q?4QRv2BbdHSSEZ3+Q9ShNx/rY9teDP0h6DFZp6SC0AmRRNg+4girriSRb3F8Y?=
 =?us-ascii?Q?3CjqaaBzAAYQv5KSvyocg9/3KMz3L0N3mzzMNPWyuifKguFlfK0M3dpFsy8z?=
 =?us-ascii?Q?4luKXWDNisE0MiS+5/bN6EKz6JSj2aAfI4+wx7zFNaxvQwW6S/TJLh8M2u9s?=
 =?us-ascii?Q?vkzzcDcLYBogg+fJW/IIPVKjPVmYYb7XXLSfXxNNxKIZPZmn53RiracbJaNO?=
 =?us-ascii?Q?AWoPeOu13McS2fAFlt+TMxyHYp/RYBulIQwgcE7VvWMYYrxGl/sIe3v5XT82?=
 =?us-ascii?Q?o1+k98M2+BT6QJ53gv4gz1EGNOZiS1fP/Z2dGVxkU+40A3zlshzvgIrAnl8+?=
 =?us-ascii?Q?JlxbMVgUeZc5vVePTfmjnp1PdZwDiBA3O1JH+uS3EUdzHZgerZERxXJ/eghQ?=
 =?us-ascii?Q?MnufiouJDyarmp4Q0SnzIutVcifA6+zvJeKKqRnSDAhQJ3jQUiuilGs+QvXB?=
 =?us-ascii?Q?Dhb7OGvV8qxmFZe5vh4TWa3/P2nJc09a7BbIpPm3ACm+q3jdytzgvckbdhZm?=
 =?us-ascii?Q?Rx3fzOjTAHzp+lNVR4NrTYKHZaIywarwzofWAIQrsOnFQWBCjgtySVjCoXtn?=
 =?us-ascii?Q?lVn90d0Ghva9McxBMScZ8Cn8iovEfgRwfXojxFI7KC5Nc4yv16e/03pAztYZ?=
 =?us-ascii?Q?iAAmVKaHYEnQn0PDuuSGXmBAXf+GSyeDFtXGKgN4LRC9gkvu5eGt8OJB1V9Y?=
 =?us-ascii?Q?4RV5E/keCzhiEoSdlZ3xY2GL9QfchlssO4i9LJ7bNy81XSkgfKZJuVfiWHXV?=
 =?us-ascii?Q?AFCIOH9V2Pny+nJx2kSkVtkV0QDRfzoBRPJniFjaqVCsw69j5y5UeG0jkzVt?=
 =?us-ascii?Q?34GxU3EuQIT4yc4j0Mog5j/5RtxdgYuwfJDJJDSaPcGe0vAB7KoU+DYP4cgY?=
 =?us-ascii?Q?ORPT80S1zXvBJK00NdRZ9yjJLHd2Vy5IW7I6fw4Dtz6Y9ZvWAXtnaFMSy/b6?=
 =?us-ascii?Q?iOiDAOvOMS8QOuIi98y3glovBOMxgrhVtAFA3a7CRl5VpQ07Es4zBRDC/usM?=
 =?us-ascii?Q?R5kh+GfNdbykn1cRRDekvZQIBZ3y5YtNP3oC7mxucdILLReXwNc0B35ojFFg?=
 =?us-ascii?Q?fhoSLaa+4R8axrHt7pMULvE9xYQux2q7xlOglQPk/ZcVI0vdef/7orxYF4fi?=
 =?us-ascii?Q?7qKo2rYdCVW4jybrlNpt3mN0TrXwtnXnRp3P9LrGYspus9EoR4XRBkEL0bj8?=
 =?us-ascii?Q?NHKhHfNZq6+FwSl826UKsdZVNDPIOF+TJoZIRmDHJNVzyikRTIGIPAtAY1ED?=
 =?us-ascii?Q?BMvFyQsKU6nlIgtujvpSj7bBPXZh51M+ZSt8yyrRhlAqVKV0NLDD5KOQEb5r?=
 =?us-ascii?Q?laeKI+4dD5fSkZ1mZZugeAzE9KBd+3cOK3GZScAuyig8Tp8Scb1rtpOAn7nC?=
 =?us-ascii?Q?VXsh3jRvcbMB81IePX67KryNqLwSJ72Z/ngjzPd6IH1pp4Lj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f886f948-84cf-4571-595a-08da4e7e7f2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 03:24:03.2533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HGCEUfJcclqXjrt19goOpYxclSoS4knkv2E39RNZqEDeKPbD6fmAoCsqr/A0wnph4LVY1eliMiG/JK+dHTt11w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8817
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn, Mathieu

> Subject: [PATCH V3 0/6] remoteproc: imx_rproc: support i.MX8QM/QXP

Please give a look on this patchset if possible.

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> V3:
>  Drop the dependency in V2.
>  Tested on i.MX8QM/8MM
>  Use 'fsl,resource-id' and 'fsl,entry-address' Per dt maintainer  Drop 'r=
eg'
> property Per remoteproc maintainer  Drop mcore self recovery, until we la=
nd
> in common framework support.
>=20
> V2:
>=20
> https://patchwork.kernel.org/project/linux-remoteproc/cover/202203091021
> 18.8131-1-peng.fan@oss.nxp.com/
>  Depends on
> https://patchwork.kernel.org/project/linux-remoteproc/list/?series=3D6213=
11
>  Tested on i.MX8QXP/QM/8MP
>  Addressed Mathieu's comments
>  Drop V1 patch 5/9, patch 3/9 is replaced with upper dependency patchset
> Move V1 patch 4/9 out to
> https://patchwork.kernel.org/project/linux-remoteproc/patch/202203080657
> 54.3355-1-peng.fan@oss.nxp.com/
>  Update commit log
>  Drop magic number to get entry address from device tree in patch 4/6
>=20
> The V1 patchset:
> https://patchwork.kernel.org/project/linux-remoteproc/patch/202201110333
> 33.403448-4-peng.fan@oss.nxp.com/
>=20
> Peng Fan (6):
>   dt-bindings: remoteproc: imx_rproc: support i.MX8QXP
>   dt-bindings: remoteproc: imx_rproc: support i.MX8QM
>   remoteproc: imx_rproc: support attaching to i.MX8QXP M4
>   remoteproc: imx_rproc: support kicking Mcore from Linux for i.MX8QXP
>   remoteproc: imx_rproc: support i.MX8QM
>   remoteproc: imx_rproc: request mbox channel later
>=20
>  .../bindings/remoteproc/fsl,imx-rproc.yaml    |  16 ++
>  drivers/remoteproc/imx_rproc.c                | 222
> +++++++++++++++++-
>  2 files changed, 231 insertions(+), 7 deletions(-)
>=20
> --
> 2.25.1

