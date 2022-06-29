Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08D355F294
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 03:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiF2BCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 21:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiF2BBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 21:01:55 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00041.outbound.protection.outlook.com [40.107.0.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE829193EB;
        Tue, 28 Jun 2022 18:01:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2s08/uYF/Yos5vAb+adTxh8iFT7vuLYkDLQ6esDLvltZ2Sw60wjuKXuMBPYhPlsidgLlq4T+WWgnMdpDE/zwYqH+CXv4JGfnCoMGqLVOCnafYHoI1bTSpSRLRsnVbkEpfz1OLzbK33a3SDLTfl81A/hFGMp+1Oa3kP7QDWN7EnM0Z44ZXDsb/0eLF/FfUguP1zAdiEphxWB5sgKQ0ZREzNTco92M0iDIB7n9BEswbL19slhmOflDvEiolyIb5ywKAWiknj+z99vM8EPBRJxNnLhvRkEtRri/Wa2FSKP0KnLtwPj38kli21NKWe8xid0fpOg9PbdO+AOojHRbak4yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wioNI3LF7z8XEvM7h5CAjAxUN917hBmuCTuAGaVWyA=;
 b=KOypG1tGTV23I90q8a+0tC9K8DVAFdhEHuU5ocgAsXjHULA1xCzRfyTWcq5JBi1LOO3qfNccrUT2csTq9hS8N+susaMsvJkBsuHF5mWlSZ9InfZSYA2SWXywpg2vex98ew8XNhJGZ9FoLBho8ac7Vhk03XeOnGDoUjr4Ez/R4imr9rinsPaYLWKJ05sKnSXU0HSI1aI84xLU094s8UACOB32dPWhK3Ez5lOI1PcQxn2i0GyU06zBZ+P7NvBB5Amyarp5sCHYMAIsAAtjzHz7S0velr0PrxLpD8XG1LFLBW7tRq647HsE87ZZ59y3Hj66ql85DlqvwRwLvHybtdNBrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wioNI3LF7z8XEvM7h5CAjAxUN917hBmuCTuAGaVWyA=;
 b=l463DMb5YiPwpRdNx3cNb9lqxqvu6JZH79tS1JxD9pNLrZkNlQffPdREMMe0n5ggiBylELNkvP5bn2diFmdGdPuxobN9XgT0KFHzLsQ8lovFqxrZVfAInt0T23ZE2BnlwvQNrUMy05dif4H8uWK+AZrNxj0r7z1Cyj4ABb4co/M=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7878.eurprd04.prod.outlook.com (2603:10a6:20b:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 01:01:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%6]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 01:01:49 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
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
        <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH V3 3/6] remoteproc: imx_rproc: support attaching to
 i.MX8QXP M4
Thread-Topic: [PATCH V3 3/6] remoteproc: imx_rproc: support attaching to
 i.MX8QXP M4
Thread-Index: AQHYaboPysN7SFTIkkO2wTcw2XHHqK1lVU8AgAB+VfA=
Date:   Wed, 29 Jun 2022 01:01:49 +0000
Message-ID: <DU0PR04MB941719F27198614ACBBEE4B488BB9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220517064937.4033441-1-peng.fan@oss.nxp.com>
 <20220517064937.4033441-4-peng.fan@oss.nxp.com>
 <20220628172746.GB1942439@p14s>
In-Reply-To: <20220628172746.GB1942439@p14s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff066653-1f57-4335-ef57-08da596af274
x-ms-traffictypediagnostic: AS8PR04MB7878:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /lKWrD9Lqwu1fq4NDLylUZUuck0h3E8guTMDWTgjHX7M0ivCgOf7o9OgZdO3M/x8GiGMDzhQeOb6DlWGlupFs0RgTwq0mDkghKBBhf0Jj9R4+iDppj+64y52nAxcXD3hQD370rXaPGfQjExPnkJn+VRLbhgt+4p8Qt+YfIRvnylnUQU5d4JZY9JXRBjfg4fLhsYaE9VK/c1SxC6SbdDIbQUqWYlcoZBLf2hqPBHHvETk5TBFRanIrpQ3OeZ9pc2FMhnAqNueunvidt5VcuCWWbRoLET1+GOZY64ak5biZm/SSu33CAFPRAyY9WXibG8NfONbK9fOCwwxTN/gJCNa26/ZZMMZVNfGuet3ogMLUji7haoy9atbeEIHYLsGUEscSqZdZ0vxy1486pDlhAg4u+TXr4Md8JrAp2HBilR7ukHbv6ZH6UiUWCC0u24i+RRJTUOCGfR8MUsC5Y5GMNDj8mFGe49A7eExqjLgnJi5ms1ZppCDvIw2ElNwHW/zMgDXCBvzwWZdVevFCwz6kkYnDIgzXEtUDporgS7IjSlW1bQcTlXpAuZ2DurxgWLhcro+AjrxjdhEpJ+AiPqExVYZVVB8bwYpe3IL++StdeCfXFpdMVRBM68A9BV/gfhwt0auutqkSAh7EIPorC/jroOWjxKZijJEi9d9CdkFYcsU2aHlb5Cbws8wnWyKR9uMw9i2mDKJyoeBkIVUxwIWqScb24YoTkOSD106nrFrC01mPMp3KzTmIyzW/i4VbWXau/La/TiDmPkHyhagR4qOst0dwYLcIEv3KCD2veWgBI2wWuE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(2906002)(38100700002)(4326008)(52536014)(478600001)(66946007)(316002)(8676002)(86362001)(41300700001)(7416002)(7696005)(8936002)(110136005)(6506007)(38070700005)(122000001)(26005)(54906003)(83380400001)(9686003)(44832011)(55016003)(5660300002)(66556008)(186003)(71200400001)(76116006)(33656002)(64756008)(66446008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SHQqBnJK2K1iaK/suJ/ZKeMcD9Rx73eoST7NMG9myyqBOeXzoe+Hpq8rs1KO?=
 =?us-ascii?Q?0x0i1ASV/ISDo8LWLOd3IIGASt6pnhuracJWcnxX391fDdJe94EuEopmv5w6?=
 =?us-ascii?Q?N+sY7rT0ajgVWSXF7ehUfFQ565HLXRSyQIQCwLbC8E/UBOH0kyL4Hn/5Bq8t?=
 =?us-ascii?Q?YNHY1PcsjNYapal3vw+ZFYxrqnQfzEXLEEjBGy0iwvpDoJtYx84iKQWqFPbZ?=
 =?us-ascii?Q?jMT3Xr5r+QMpZcoB1HkfOuHpbHkwacQ6HDCTHuUtjY9yqdxpvGWggOjge8jm?=
 =?us-ascii?Q?jEzrWK1A+/bNcqVsKUgfmtAVEh4YsXx/+UQSs016W+CMd9qeUuZmBQtkmvt+?=
 =?us-ascii?Q?OotBEb8nTVg8yd9tupJcoH+Yn1gjud6iZgtILlCmFi7ccYRVldzxttLxZvG3?=
 =?us-ascii?Q?X7Kim0goEi/qUKHERrmfRzs5LNNeZJMQnrh78g+wVHZEtK+NJQdmwDRa+RMk?=
 =?us-ascii?Q?eHp4s4TyWeQMn/u1mwwz3Gxq4JN8AZ/h4KNsbY5HupShafU7/gERLm+Qd3xH?=
 =?us-ascii?Q?Y8dfasrsxOBp2Ja1ktTnonJ/OWpKl5K+gMDXqTPOpLaExWVmSJgFiNyM8zQz?=
 =?us-ascii?Q?7gwkxSO2P9MIDSpV5NA2BseW3G87heQcYU9cwG1OKf1frwJluawB2I4i1Pcq?=
 =?us-ascii?Q?xDS9HL2y/Sj0ClggJl9U8KKWUc+aXZD+05+GCTfBAd7TcxQdnZByDlqBj4XV?=
 =?us-ascii?Q?71uAn7+Ut+eVxGjUGeBUEqrEW5hmFK3Z+b+yW7KG2DsBmUg6vCLNQgGkagJa?=
 =?us-ascii?Q?EVkZmp8iWA6mcipypGZpfyQ0filgdiwA/hmOujfV1Cyfmpyoe/Ar8RIBmJbi?=
 =?us-ascii?Q?QPnHT1lUjrEm3AY9jsLPDb4FJAxcmTiFopMIyCMY+gpZeIpSu0E2oZIcDNAi?=
 =?us-ascii?Q?dA1LctLFQY7hLlE5tzrfSPEsDvFAYR9S0BqVkQY1t3++CyrxcG05TERCWUW3?=
 =?us-ascii?Q?gMqDpY6Zrtg9fnI7NQgz4aJCRhAlJcssH4iW2833imemN8+QMaSTnyZOjHC7?=
 =?us-ascii?Q?jrNKObSomh50dK5fyVd4ecvX7YC9TVvhNpICa7eFibinFpAI07rcYfRwl4VB?=
 =?us-ascii?Q?eqbURIgBVTKnoiEvO8fJkb79fEjp0zw2ZwceIq7t8T5RULi9EnTWD6X35orO?=
 =?us-ascii?Q?jGeX5QH3VlHRTC49nKh4gEiFR+hKWhptk8BfiTH/OD45TUJ5s/G8XkCfeqNO?=
 =?us-ascii?Q?+swnHSbNaSbL7RXU8jzFrl9q7QvodvfFUtfRtKmC0CEF/U27+zxWW/3Ji4sr?=
 =?us-ascii?Q?4/lJvHSdwSk1gtThcsKnwr+E8YoXccsnnYSMnYYE8sHUuir87h7Kh6z7kxq5?=
 =?us-ascii?Q?pwMWtH6xTdaPylb6a6E7xO+hfBQWqvjspBT9X71xQWkNSW6HBNQ8xSCDXtd6?=
 =?us-ascii?Q?aSX1rJOLaqT3MtxwJxu53gMEgck37h0/Ujm2r6wIoYmljEKgLvFybNb4Y0Nc?=
 =?us-ascii?Q?3j3mP9n2IXL6VuNhrgyfgnFYdmDt8u7G290erlcaZcsi52cn3w7iMx7j17oq?=
 =?us-ascii?Q?c7xlU1PLcYnkhY7903Y5iKEE/VFdjjfPYv6BvnkccXWUI5J25Gxvyeo1RY/u?=
 =?us-ascii?Q?AOdNIeF+cvMVLgaWE9o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff066653-1f57-4335-ef57-08da596af274
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 01:01:49.5033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xojGhxEO6JbO7uDxKJ3t+vEtjIZBYOeJNo7HtYQaE2iR3gLbiXeYpTA/EaQjranIJ7a7i9XTSpBbrZv+itk9mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7878
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V3 3/6] remoteproc: imx_rproc: support attaching to
> i.MX8QXP M4
>=20
> Hi Peng,
>=20
> On Tue, May 17, 2022 at 02:49:34PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > When M4 is kicked by SCFW, M4 runs in its own hardware partition,
> > Linux could only do IPC with M4, it could not start, stop, update image=
.
> >
> > We disable recovery reboot when M4 is managed by SCFW, because
> > remoteproc core still not support M4 auto-recovery without loading
> > image.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/remoteproc/imx_rproc.c | 88
> > ++++++++++++++++++++++++++++++++++
> >  1 file changed, 88 insertions(+)
> >
> > diff --git a/drivers/remoteproc/imx_rproc.c
> > b/drivers/remoteproc/imx_rproc.c index 4a3352821b1d..2e751fc90760
> > 100644
> > --- a/drivers/remoteproc/imx_rproc.c
> > +++ b/drivers/remoteproc/imx_rproc.c
> > @@ -6,6 +6,7 @@
> >  #include <linux/arm-smccc.h>
> >  #include <linux/clk.h>
> >  #include <linux/err.h>
> > +#include <linux/firmware/imx/sci.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/kernel.h>
> >  #include <linux/mailbox_client.h>
> > @@ -59,6 +60,8 @@
> >  #define IMX_SIP_RPROC_STARTED		0x01
> >  #define IMX_SIP_RPROC_STOP		0x02
> >
> > +#define	IMX_SC_IRQ_GROUP_REBOOTED	5
> > +
> >  /**
> >   * struct imx_rproc_mem - slim internal memory structure
> >   * @cpu_addr: MPU virtual address of the memory region @@ -89,6
> > +92,10 @@ struct imx_rproc {
> >  	struct work_struct		rproc_work;
> >  	struct workqueue_struct		*workqueue;
> >  	void __iomem			*rsc_table;
> > +	struct imx_sc_ipc		*ipc_handle;
> > +	struct notifier_block		rproc_nb;
> > +	u32				rproc_pt;	/* partition id */
> > +	u32				rsrc_id;	/* resource id */
> >  };
> >
> >  static const struct imx_rproc_att imx_rproc_att_imx93[] =3D { @@ -117,=
6
> > +124,18 @@ static const struct imx_rproc_att imx_rproc_att_imx93[] =3D =
{
> >  	{ 0xD0000000, 0xa0000000, 0x10000000, 0 },  };
> >
> > +static const struct imx_rproc_att imx_rproc_att_imx8qxp[] =3D {
> > +	{ 0x08000000, 0x08000000, 0x10000000, 0 },
> > +	/* TCML/U */
> > +	{ 0x1FFE0000, 0x34FE0000, 0x00040000, ATT_OWN | ATT_IOMEM },
> > +	/* OCRAM(Low 96KB) */
> > +	{ 0x21000000, 0x00100000, 0x00018000, 0 },
> > +	/* OCRAM */
> > +	{ 0x21100000, 0x00100000, 0x00040000, 0 },
> > +	/* DDR (Data) */
> > +	{ 0x80000000, 0x80000000, 0x60000000, 0 }, };
> > +
> >  static const struct imx_rproc_att imx_rproc_att_imx8mn[] =3D {
> >  	/* dev addr , sys addr  , size	    , flags */
> >  	/* ITCM   */
> > @@ -255,6 +274,12 @@ static const struct imx_rproc_dcfg
> imx_rproc_cfg_imx8mq =3D {
> >  	.method		=3D IMX_RPROC_MMIO,
> >  };
> >
> > +static const struct imx_rproc_dcfg imx_rproc_cfg_imx8qxp =3D {
> > +	.att		=3D imx_rproc_att_imx8qxp,
> > +	.att_size	=3D ARRAY_SIZE(imx_rproc_att_imx8qxp),
> > +	.method		=3D IMX_RPROC_SCU_API,
> > +};
> > +
> >  static const struct imx_rproc_dcfg imx_rproc_cfg_imx8ulp =3D {
> >  	.att		=3D imx_rproc_att_imx8ulp,
> >  	.att_size	=3D ARRAY_SIZE(imx_rproc_att_imx8ulp),
> > @@ -683,6 +708,22 @@ static void imx_rproc_free_mbox(struct rproc
> *rproc)
> >  	mbox_free_channel(priv->rx_ch);
> >  }
> >
> > +static int imx_rproc_partition_notify(struct notifier_block *nb,
> > +				      unsigned long event, void *group) {
> > +	struct imx_rproc *priv =3D container_of(nb, struct imx_rproc,
> > +rproc_nb);
> > +
> > +	/* Ignore other irqs */
> > +	if (!((event & BIT(priv->rproc_pt)) && (*(u8 *)group =3D=3D
> IMX_SC_IRQ_GROUP_REBOOTED)))
> > +		return 0;
> > +
> > +	rproc_report_crash(priv->rproc, RPROC_WATCHDOG);
> > +
> > +	pr_info("Partition%d reset!\n", priv->rproc_pt);
> > +
> > +	return 0;
> > +}
> > +
> >  static int imx_rproc_detect_mode(struct imx_rproc *priv)  {
> >  	struct regmap_config config =3D { .name =3D "imx-rproc" }; @@ -692,6
> > +733,7 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
> >  	struct arm_smccc_res res;
> >  	int ret;
> >  	u32 val;
> > +	u8 pt;
> >
> >  	switch (dcfg->method) {
> >  	case IMX_RPROC_NONE:
> > @@ -702,6 +744,51 @@ static int imx_rproc_detect_mode(struct
> imx_rproc *priv)
> >  		if (res.a0)
> >  			priv->rproc->state =3D RPROC_DETACHED;
> >  		return 0;
> > +	case IMX_RPROC_SCU_API:
> > +		ret =3D imx_scu_get_handle(&priv->ipc_handle);
> > +		if (ret)
> > +			return ret;
> > +		ret =3D of_property_read_u32(dev->of_node, "fsl,resource-id",
> &priv->rsrc_id);
> > +		if (ret) {
> > +			dev_err(dev, "No fsl,resource-id property\n");
> > +			return ret;
> > +		}
> > +
> > +		/*
> > +		 * If Mcore resource is not owned by Acore partition, It is kicked b=
y
> ROM,
> > +		 * and Linux could only do IPC with Mcore and nothing else.
> > +		 */
> > +		if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
> > +			return 0;
> > +
> > +		priv->rproc->state =3D RPROC_DETACHED;
> > +		priv->rproc->recovery_disabled =3D true;
> > +
> > +		/* Get partition id and enable irq in SCFW */
> > +		ret =3D imx_sc_rm_get_resource_owner(priv->ipc_handle,
> priv->rsrc_id, &pt);
> > +		if (ret) {
> > +			dev_err(dev, "not able to get resource owner\n");
> > +			return ret;
> > +		}
> > +
> > +		priv->rproc_pt =3D pt;
> > +		priv->rproc_nb.notifier_call =3D imx_rproc_partition_notify;
> > +
> > +		ret =3D imx_scu_irq_register_notifier(&priv->rproc_nb);
> > +		if (ret) {
> > +			dev_warn(dev, "register scu notifier failed.\n");
> > +			return ret;
> > +		}
>=20
> I woul have expected to see imx_scu_irq_register_notifier() being called =
when
> the driver is removed and in the probe() error path. =20

You mean unregister, right? I not included driver removing in my test case,
will add the test and fix the issues.

Thanks,
Peng.

More comments to
> come.
>=20
> Thanks,
> Mathieu
>=20
> > +
> > +		ret =3D imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_REBOOTED,
> BIT(priv->rproc_pt),
> > +					       true);
> > +		if (ret) {
> > +			imx_scu_irq_unregister_notifier(&priv->rproc_nb);
> > +			dev_warn(dev, "Enable irq failed.\n");
> > +			return ret;
> > +		}
> > +
> > +		return 0;
> >  	default:
> >  		break;
> >  	}
> > @@ -855,6 +942,7 @@ static const struct of_device_id
> imx_rproc_of_match[] =3D {
> >  	{ .compatible =3D "fsl,imx8mm-cm4", .data =3D &imx_rproc_cfg_imx8mq }=
,
> >  	{ .compatible =3D "fsl,imx8mn-cm7", .data =3D &imx_rproc_cfg_imx8mn }=
,
> >  	{ .compatible =3D "fsl,imx8mp-cm7", .data =3D &imx_rproc_cfg_imx8mn }=
,
> > +	{ .compatible =3D "fsl,imx8qxp-cm4", .data =3D &imx_rproc_cfg_imx8qxp=
 },
> >  	{ .compatible =3D "fsl,imx8ulp-cm33", .data =3D &imx_rproc_cfg_imx8ul=
p },
> >  	{ .compatible =3D "fsl,imx93-cm33", .data =3D &imx_rproc_cfg_imx93 },
> >  	{},
> > --
> > 2.25.1
> >
