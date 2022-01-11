Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF70A48A7E6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 07:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348252AbiAKGou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 01:44:50 -0500
Received: from mail-eopbgr50066.outbound.protection.outlook.com ([40.107.5.66]:63177
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234266AbiAKGoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 01:44:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5Mv42zK4wtNAyF4WMEp0bvVkep4Q/T+Cgwu2AD2DEkDd8Xe8FgrfdzopN9w3CZ1YHm7x/eUqy1cdkdvq6ScTr4l35XbKV2dCQyaIEHOo80I5xLOKAftJ9hhSEYJZe9Ij6/YylqqYfxDw0RrNYJxh93eVwd/vfnEabhcVKBiOhEKh3FdTCg/3nY1WnB2a2X+KrXNpMdDpadMATmXa+3N1kIvdUxxKzES2Dm20TqMLSJruhiysRGJkLP3Ud3/FJDB8lQby5tfQBwBqxPBAvYQEmYB8jEW8URtnZe7FkD7heRpPCgbILPd1eDyEU8IL6r9LkHXA2PvtiS1GNjfoeoRKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWcPcHC7sezCB69bNF6RlCc1n34wi/5pi3iy6L1Curc=;
 b=OnyW3X1ur86oPbF7k+JV5bB/O02KfykQFh9b2rhQC90ElUtS8ZR6xX+AbKxo0fH91sK1dLac12VjgIIxAd5p4lhHA7SbYrWSs3QM/YO6i9dHmbwt15u8w8lA8pJC1FQSFnBwFs/XHfHrYNEANd7B0nORqPLfeK/rPqgacZu5SWfptfToLgaAQ8Av+v3RwShnBvtf855rjOAB9RRsB/HLpWci6JGR2b9i5YRURZdCKhglCHukh499jwwU2i0f+jzHtFNjuGQrsF7Lz0uOUhLuRWTgKSeStUkiJVpWxbl7JS0T9HQFIPputZsBKhccr3OuBscj89qS13Px18D2qiESMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWcPcHC7sezCB69bNF6RlCc1n34wi/5pi3iy6L1Curc=;
 b=KWFYNTvKgGiLBK/mqh1OB+99AaIbg82IbrQWIMcsg51Hk+Zt8NuzFPcbVhSXRee1VS8AK8fDQg/+XFGDLNWTTN1YORhJF6xRNZ8Lk56d0Lb6VEEhqZUMoyXeejljjXBIWeTStBd5wp3YPZAtYpmdtkU+jJxYt410nCmjaCUDVbk=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB9129.eurprd04.prod.outlook.com (2603:10a6:10:2f4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 11 Jan
 2022 06:44:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4867.011; Tue, 11 Jan 2022
 06:44:41 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
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
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 1/9] dt-bindings: remoteproc: imx_rproc: support i.MX8QXP
Thread-Topic: [PATCH 1/9] dt-bindings: remoteproc: imx_rproc: support i.MX8QXP
Thread-Index: AQHYBpwqPpFjre1FRE2CDzo8h2g4iKxdYC5g
Date:   Tue, 11 Jan 2022 06:44:40 +0000
Message-ID: <DU0PR04MB9417B64FFCA45C6ABA034CD588519@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220111033333.403448-1-peng.fan@oss.nxp.com>
 <20220111033333.403448-4-peng.fan@oss.nxp.com>
In-Reply-To: <20220111033333.403448-4-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ea707ce-c002-475f-7a59-08d9d4cdd83b
x-ms-traffictypediagnostic: DU2PR04MB9129:EE_
x-microsoft-antispam-prvs: <DU2PR04MB9129E6D643DBD591C808515088519@DU2PR04MB9129.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v/7Lq/nxy1ZoDRxInbkX4ILE53RCVhanU/ZIpxmg7Gmy/dUkzn+diawae5JoCt3aqxZp8RcLzYg7FnlpDtOEqdmCasGvw15g1i2MVlUBfbsuq2T8DvONbN1JtXEgvjLGPWcYS5EyRATTclm6P1YxU14sQq4ZkbH1GbBayJ7IukqL2WgGh1+3skvU44v+A7PvPgOB/rPHciS4ykbdXvjmo9cgpt6XR8O8NDDwdvsvnj//avkhHRpndlguyi2sK6V/SvMfMnv3CAo906tVfI2waAbAl5eChYe66Nhesoir+Y+O4trAj9B2J7fzQTg73wzyTMqhsXH65iGYYaMef14KWGIZbDIynRupTGrEq2SqbQ+tdzVSFoOE4g//6gxk08RH4HxrBIP5oorTDVcke52JFXqc0MsPflAxfSdTXuqH/UdEYzhBTj3VrUEFui6uFNH4ZGsZv69RNm5quXlzMMUL313O3zA3f1YK28kZ/6q20sAAhrn2Y2wl9HWjccEgB1nMX2ZY92vOaXlzWylqqJutH/ZaJR90k+/4LTo82Cr6YF/z1WauDZ9hoKFZhr43o8i26AwVvY29ta42Pnqwxq0A0q4VgQlATtv5iT/Ct+cDxmSH5fC+WRJAgTx/N+pteD/IjYM/cn0IEXk+aeE02w8fo4itbqf0PmmvOTm0A2mwGmtdP6+mS7Lku56tjHpFkphlOWdjRPUIgvDlpq5FHoPhE439nv8jrvgBOetlaq9KRho=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(7416002)(8936002)(71200400001)(8676002)(122000001)(38100700002)(66946007)(6506007)(186003)(44832011)(33656002)(55016003)(9686003)(52536014)(316002)(66556008)(66446008)(64756008)(66476007)(7696005)(110136005)(2906002)(921005)(508600001)(5660300002)(86362001)(76116006)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L8aU4heZhObhvEOoGzeDu6s1Wr4WURC4NAyayvWTEglG4kMrJBQkbEeO8dKH?=
 =?us-ascii?Q?G0D2jE7dwsAv0EImfjjWsK0XSk6qFp/fhmlRfiU7txqrtSUFJANQA/e+8jrk?=
 =?us-ascii?Q?MrD8N3u/Ge2OXyvbgWRyTFY40tPFYemi0U7eYIeErndAJnr/7Dv/SEBn/KXV?=
 =?us-ascii?Q?uuYeJLeDToVfuQtRD/CaspgSwXFLhSHZZu/x1a7dAkp3Dv/h4AL6Vnwp5Ebl?=
 =?us-ascii?Q?x2/d1bz1CK3WCWR5ER0E6wBCtlCyRMVXFcnjSIXan0Av8LHl8N5/JK3DmAHx?=
 =?us-ascii?Q?COeuN6uq0q3wfYo92xybm5iiZq2JmyhCShinoSS+pMky2uTAYlTjxrVx4RFs?=
 =?us-ascii?Q?7utbdpUZwsdTBS60l/IY6Wl1WIdd/qWvhsEukmYk1J4ptAh/HntGt4q66Fva?=
 =?us-ascii?Q?gMjG0tjhsFicMtDzGCVd+mqOOTz4cVzmL8d7a4vsxTo9AVoZvnxun1b/g7OK?=
 =?us-ascii?Q?fkmWXzbI5IvR65lsLCepMvr2xNQNy5xEWf+3RHtM2ZT57579D6pvNWkEVm5n?=
 =?us-ascii?Q?Qc9uRqkcpi0f/2QXc1p+sja/2k/p/F0NGMxSrhznTeOQr5CRRuTjdN8xg2g2?=
 =?us-ascii?Q?6VjF1Jr0qOinZhppAOCla96X9axxPEQT4PGb8/02o7Ito3F1de0ScKW/iPsT?=
 =?us-ascii?Q?OJWk/P7gTZLKfQIc1eFlMJk1dL81yKzkH9eeIXAt+5MEsTil5E4pySHpDtEq?=
 =?us-ascii?Q?qpMCTWXr9L0sgdpn65k9Jcli22BnQSfVZJeYrNI0gHYRblPScO3GtKnaQekI?=
 =?us-ascii?Q?h6JdE+oHy8DhFsydL7jarqFnJC9DJwzhaUAeJnAQF/MgJfG0EZDRp32z0aP2?=
 =?us-ascii?Q?K6H2cRgmvpKDeOIMCSf7lWgt6nHjgGYL1BX3tu6lE3VnlWyxIxS3/jlHrH55?=
 =?us-ascii?Q?pTJYiFLwjJLVvYvW7rhyjKYfpvj3FLQz8M1h7EZxP+bNEDMf7TafqlGP1rI9?=
 =?us-ascii?Q?284A/QrwOlafR+vpDArHNoNoMoAqsPc5SNe/NW8N5rrE0R+gT2qv6amq0FYt?=
 =?us-ascii?Q?EUQUYNOPSEBiDCp14Iq28jXBbtgyIregXMF21n9pQ6Q8S1BfsUDa5BGP7lR+?=
 =?us-ascii?Q?BhRg7+C4+G1pu4FgiTyiDHOnL6OL42WaGoQxk3gPkCJucCz9c0WFOT9Hmq/k?=
 =?us-ascii?Q?/NFIADlLPLwLFhXDWKs+Nm4ov11fQBOO1UfXPgaZOn2dW7jZA+5gJ8T7SU7P?=
 =?us-ascii?Q?7xbQU5fmQmzwLSbk8KEGaT+GNE1xIwdwWnb4R0a2fm6idRldc9BWR2ejxAcy?=
 =?us-ascii?Q?voIHrrFdfziOFKKMq0Y4B+Iacjfu3l52mA56Atte64jf+3lkypuUqHc2JUvs?=
 =?us-ascii?Q?12VmhWgw2joWjEmJc0v7RGchjqnZZJpTVyTQsbFwleKLKkPj4yjM+FYqLisa?=
 =?us-ascii?Q?ZtRpiyvt7WQCrIYSBvvEY2poyRAg2QU4lnY+Ro4RIVJWwvSLIDNFCnTjF001?=
 =?us-ascii?Q?bPI8ZS5Kk2eVo17uleWWZTL3RL0Seu98JKDJnwhQfvWxgQ7IXjW9wYj/o03/?=
 =?us-ascii?Q?HhNhj1lyW2yXtYkxkh0ED+rmA6skEPhw3w/o3TgoXRo9pvDYUxIMPOL2uCIy?=
 =?us-ascii?Q?Z+Bo2ZOtrtZdYa26e6SOe/w11ENCN4EtbQo/YSIV/O3MKYBR0nyuVWgpHivB?=
 =?us-ascii?Q?2qxlpCpf7dX8BZnmJ9cJJtI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea707ce-c002-475f-7a59-08d9d4cdd83b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 06:44:40.9703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SJwzKYvUHW8FhoBWVo4pH0c9p3FvgHkQ5geuWGJ33/gZiiejndXA9pyFnhMNmQVpdiVh4hvDiAjZLnvfWoEbAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9129
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH 1/9] dt-bindings: remoteproc: imx_rproc: support i.MX8QXP

+Rob

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Add i.MX8QXP compatible
>=20
> Add a new property rsrc-id for SoC which supports SCFW. This rsrc-id is u=
sed
> to check whether remote process is under control of Linux or not.
>=20
> To i.MX8QM/QXP, when M4 is in the same hardware partition with Cortex-A
> cores, need power up M4 through SCFW, then M4 could start. So introduce
> power-domains property
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/remoteproc/fsl,imx-rproc.yaml  | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git
> a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> index fc16d903353e..ed1bcb3046a9 100644
> --- a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> @@ -19,6 +19,7 @@ properties:
>        - fsl,imx8mm-cm4
>        - fsl,imx8mn-cm7
>        - fsl,imx8mp-cm7
> +      - fsl,imx8qxp-cm4
>        - fsl,imx8ulp-cm33
>        - fsl,imx7d-cm4
>        - fsl,imx7ulp-cm4
> @@ -59,6 +60,15 @@ properties:
>        Indicate whether need to load the default firmware and start the
> remote
>        processor automatically.
>=20
> +  power-domains:
> +    maxItems: 8
> +
> +  rsrc-id:
> +    description:
> +      This property is to specify the resource id of the remote processo=
r in
> SoC
> +      which supports SCFW
> +    maxItems: 1
> +
>  required:
>    - compatible
>=20
> --
> 2.25.1

