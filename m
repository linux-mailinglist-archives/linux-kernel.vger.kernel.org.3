Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CF44BEEAD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 02:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238043AbiBVBN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 20:13:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238016AbiBVBN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 20:13:27 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80074.outbound.protection.outlook.com [40.107.8.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54F324F22;
        Mon, 21 Feb 2022 17:13:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1EsYvL73wxXEz6KftNUsPIPut0g3eqg+51j1xxVZKoyaE+gHfge8Z30oLmvm6T8xIMxSzjP/UdRrhFqdSMRrYlWpp0IjsGYRPHLTpFFrGT7CPCDjxbMJyX91Q7b5Qmqv8sFOwNa8wiPkdhijSCsIwevHq1PqBQiqFdBVRMAmr9PiWAxNqbZVAnJcUd1DANoUfAbWRGig+hLFnd0A+Z9ejcaWQS6Zx3K61xHIEHfRN/jl5SLQMrweIrIDM9U2E8VF3Zkt4/AqOSk+2JGi9Pgt2pOtJIOJJGllXzWvTeJWo4zBJRpBs6wzyxvfq/TI2LktJAPGS/H/uBBMWpzeIoknQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6CjFFzeUNjxnYdgMsd/BEvqY9ciWBaSpcNlh00SwM0=;
 b=V27mIer7jBh3+sZap8pwhIt7Kf5uZS0E/YI+kTvdAiUNrQN/evsYCXTFuvxYUMX1EThqUpOV9BUkuluCpWl2+TKM+UD/nNqsaOaO/kyWzZKdyAlFlT3zgKfbNsh+WdaKkezXQ8JcwRBiFKdEABZe9LnxsC9PV4bBDzuZSonKJG2Ih9m7j6dkABe/sqBMqMMUCev6/d0vU5o+ByLgoFPwZ0tKm65dDNdZiy94+IRUH2ZPr/AYh/chvFr1XIFqMgHrrhW/Kn0IMkF+vor+SyRPJiYZsKP2WYchwccGxMY7As0p15QjofTOgnCgVIqmOX8ZNT9PYwv5kYHZjBBFLp8MiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6CjFFzeUNjxnYdgMsd/BEvqY9ciWBaSpcNlh00SwM0=;
 b=SRbwQLQ5ufLa69lugp4+uACUd5eogtucsC2iC4QO+vSAp8l/tf9A9YYlPvxW9jKMQs9deC3oGtzx+TnyPGCtRmyKodwEsbOgdfhqX52tIazxvbZ8JRsFZ3F1Anmbxu7XQmAdCZBIoW/bw/xxTyx49wvxdyhpSc6VwgURi3s4+D8=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB5097.eurprd04.prod.outlook.com (2603:10a6:10:15::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Tue, 22 Feb
 2022 01:12:59 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Tue, 22 Feb 2022
 01:12:59 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Mike Turquette <mturquette@baylibre.com>
CC:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, Frank Li <frank.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        David Wolfe <david.wolfe@nxp.com>
Subject: RE: [PATCH 2/2] clk: imx: Remove audio_mclk_root_clk
Thread-Topic: [PATCH 2/2] clk: imx: Remove audio_mclk_root_clk
Thread-Index: AQHYE4fT0bbV2fYEaUGLH6MPqVy0J6ye63xg
Date:   Tue, 22 Feb 2022 01:12:59 +0000
Message-ID: <DU0PR04MB941759AC363C5B162ED35DEF883B9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220127141052.1900174-1-abel.vesa@nxp.com>
 <20220127141052.1900174-2-abel.vesa@nxp.com>
In-Reply-To: <20220127141052.1900174-2-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1c042d2-2e57-41c3-74cc-08d9f5a07777
x-ms-traffictypediagnostic: DB7PR04MB5097:EE_
x-microsoft-antispam-prvs: <DB7PR04MB50977F680E2E61A83906EBD0883B9@DB7PR04MB5097.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OPDob1z2RMTc/2FaWccFqc21Dbrt1p4LWP6nLEIhSgFngvyJOH4sYtxtqQK2laRdJyvgFym4r6td+Pw0Qo59S7Vn+Mg/IUIHBLuyXOpsT+yvI3cGTQCAQ0USoYkXEusVZUXQhbmkDiQd7IczgS8bGQG2EWvNQR2EIttNCS8R9JlKoVfgyMafsW01LwJakpiC/EOzs4J0SKCcl3M6sfr3ZJxnFVZOqp6UNi+ACIi0GTQtoSblhtFD3HbejhwnizM5yYACW/Vqajl3DN7iXe0fG3QjRMAIxhu6x29cmTANMoyb5cwMLgeYAKN0dd3WUECIZ+ElVfc2ay2OAiVYbkXxgBP5jd/wZqe07DC5xon3rk4q5QHNpytJWfyvwkjnnBQ/LHqrA13AI9aqvo4pM85BYJAQO+KAqrKU8wC/CBzNnRwyXs2QbfuL1HUNsOpxcDg9iTD3GfCeNXJJW9aTAYLTajiORQyaVSZWrV95sNZA2b5TDhnoaxyKBfRGaJNaWKeMsXvFR24YYxhAj4EZ2D7RUGUfIUjCUwh7q3oDdjsx0GQ27DBVPy9SnGbZ9dAOpFcxr5sU4jyNaaHNr0adzS8v3w30ZKtKSMPq+MCX/+P+Cl6CUXXKGo1CviIFAUp3Ig4dJPAuzfvIyN/0caSgcdn94UFLXTtCg++bJYinYWUtKT9a4woXJbKgzHZAbO0YsX6z95fOj51XXDhyd5LciE3W0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(38100700002)(2906002)(7416002)(66946007)(64756008)(8676002)(66446008)(66476007)(5660300002)(4326008)(122000001)(186003)(26005)(66556008)(52536014)(8936002)(44832011)(71200400001)(33656002)(7696005)(38070700005)(508600001)(110136005)(54906003)(55016003)(86362001)(83380400001)(316002)(6506007)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IlmX9G5gI2BgjfNaoe+88iQWHy65+WArlLyZ8m0B1rjz2/rgIAqhJmPYnz1O?=
 =?us-ascii?Q?80K7siJgAR0UX5vi2NDZQ66MTsxEw25S439cvm/YMFdVVekrPE5GmnNxfmBV?=
 =?us-ascii?Q?kDyay+8W1n+gdGdYyFejInDiv0OXpBcRkazK5xHnDWaIVSSGZFQ1ICZik22O?=
 =?us-ascii?Q?GYfa1Jk9qmCaGfPheKz1OItKnW/QLnoiO0MVW40MXU7N6vI5qMJ3uy2/3Ij8?=
 =?us-ascii?Q?/QnWtQecaUQ+PF8uL7rynLl+M9kV/p7zCU6S1As4c0UQrkZH+MDh2emVNwtn?=
 =?us-ascii?Q?DLeDQQ2iyhuWI0+W94y+aoDR+kPyueOhRIEZeIEslmGQhqg9hDLFDfQ0kc8n?=
 =?us-ascii?Q?gqO7rpzty/sGAkPMFuA3iTMpPUrlza0eePvaRmxh9qQ/+nMIzpprKycOvJv0?=
 =?us-ascii?Q?RJTnqor71AmKEP/5dntTtcRgDo2xtPbtFD25hZxtG/XQh54kHWl5Swzpo14k?=
 =?us-ascii?Q?59/LkkQtobmdm02VjiD9n+BkO+H150plvk5Z0kPxbGhLGgXE5pw14hXk0tNF?=
 =?us-ascii?Q?GZUApBrhNzj4mgRv1sd6nyEAk1HFLMfuzRPSP6919XD0oRj9er5UNBZ6laZ1?=
 =?us-ascii?Q?xokrhQbWRanAVrDbVIc9udfJ1HufZz5q+qqaqCHfYTlqT3WpBhkca/2XH1l6?=
 =?us-ascii?Q?WIrWl++depCc0XVO+LFoA0rnuRwNwb9JU7mEHBY5soWSFOS+LEdO4RQL0zcZ?=
 =?us-ascii?Q?T0JGbwWiODtLSfQ4gFkeVxWfe2mYDoUZcSNy8xEkns+NtWuFajddPfDx4MTA?=
 =?us-ascii?Q?Yex2ZX2we3eEholTNq5/m45Miw41sQMYo+Txfl/LgUWOi6YvVguFvPeaznPB?=
 =?us-ascii?Q?X/JdQqE13BxkEomFj8o9ZrGnLRwOr7b9TJmx0pVqP2nLeub146Ea/f1ahORY?=
 =?us-ascii?Q?EHTqlOQj2l1BdWYOZ2P16EEixcxtRgf89lemloBm1Ky7XyW7Uq9pxRKPWPzY?=
 =?us-ascii?Q?+lIrvT1uxuXmGVeLHNY1I7p0Pk9OFbTnAciJA8WjJMpbpi6/J0xqxqaUMJES?=
 =?us-ascii?Q?ehkEIlPNE078EAvy1QKLpQ5LA/1ordM1xeDY5+IE3gmL4gEylEfwTCgnErxx?=
 =?us-ascii?Q?21aScSE8PeHHITfAu15PSKz33PpCh0l7PBWRrVVK/CXGUICIGARzDUsf1mwL?=
 =?us-ascii?Q?gd90MkHkuBQWOBhrGqsDSBof04UEs5n82p/aSMpyDakQb/ZnvhfjN8wYhdzG?=
 =?us-ascii?Q?AluNgFjhGdO/0ijvsdrjdZzu/n/2sfX3ZJA22ndVcVBap+aosXPgoCzfTe5y?=
 =?us-ascii?Q?LwGeCW6fI+tCPitbzeQMST9zUokaF1HRj0Wdv/5PM2r4d6pwna0CUAcF9C05?=
 =?us-ascii?Q?OQQDqIAy0SqxntITq4q8YSq2nEtyBTImu6dl2o39rtUcLFyBBnm4XZ/5bxKt?=
 =?us-ascii?Q?NYMh2Kl0eC7H4AyPRr7GlgBbR1mPjDkoOp1VH6yu+Ze+D4m1UBD5EKR5m1Lo?=
 =?us-ascii?Q?ON2lM5elJ7KvSvfjzSeeefUYJRte8tyHTu1OFK+4WJZcIsWJts2WR/WE3PVD?=
 =?us-ascii?Q?BwV8yEBF0UIJrMIMXnoeqmPFy6BI5Z0s61cSUeA2OenZwAZ9zjPZGANx0Rwl?=
 =?us-ascii?Q?9ofTePLPSfIv6H3Gvw+eanbW3PdnMIdf7n8W5uXSF1tG/Oy71DpeBr27t6at?=
 =?us-ascii?Q?4w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c042d2-2e57-41c3-74cc-08d9f5a07777
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 01:12:59.7057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n2lCs7Plg4M1dhVpsgDykZSHCSUCy7XnlrZgrJ69toaty4ezI1/QjS/e2/s/gkZ/Voms6km/996Bg05Xl2bIhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5097
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH 2/2] clk: imx: Remove audio_mclk_root_clk
>=20
> The audio_mclk_root_clk was added as a gate with the CCGR121 (0x4790),
> but according to the reference manual, there is no such gate. The
> CCGR121 belongs to ECSPI2 and it is not shared.
>=20
> Fixes: 8f6d8094b215b57 ("ARM: imx: add imx7d clk tree support")
> Reported-by: David Wolfe <david.wolfe@nxp.com>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

> ---
>  drivers/clk/imx/clk-imx7d.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c in=
dex
> c4e0f1c07192..3f6fd7ef2a68 100644
> --- a/drivers/clk/imx/clk-imx7d.c
> +++ b/drivers/clk/imx/clk-imx7d.c
> @@ -849,7 +849,6 @@ static void __init imx7d_clocks_init(struct
> device_node *ccm_node)
>  	hws[IMX7D_WDOG4_ROOT_CLK] =3D
> imx_clk_hw_gate4("wdog4_root_clk", "wdog_post_div", base + 0x49f0, 0);
>  	hws[IMX7D_KPP_ROOT_CLK] =3D imx_clk_hw_gate4("kpp_root_clk",
> "ipg_root_clk", base + 0x4aa0, 0);
>  	hws[IMX7D_CSI_MCLK_ROOT_CLK] =3D
> imx_clk_hw_gate4("csi_mclk_root_clk", "csi_mclk_post_div", base + 0x4490,
> 0);
> -	hws[IMX7D_AUDIO_MCLK_ROOT_CLK] =3D
> imx_clk_hw_gate4("audio_mclk_root_clk", "audio_mclk_post_div", base +
> 0x4790, 0);
>  	hws[IMX7D_WRCLK_ROOT_CLK] =3D imx_clk_hw_gate4("wrclk_root_clk",
> "wrclk_post_div", base + 0x47a0, 0);
>  	hws[IMX7D_USB_CTRL_CLK] =3D imx_clk_hw_gate4("usb_ctrl_clk",
> "ahb_root_clk", base + 0x4680, 0);
>  	hws[IMX7D_USB_PHY1_CLK] =3D imx_clk_hw_gate4("usb_phy1_clk",
> "pll_usb1_main_clk", base + 0x46a0, 0);
> --
> 2.31.1

