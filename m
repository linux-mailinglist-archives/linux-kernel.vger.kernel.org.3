Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807DF51C98C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 21:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385430AbiEETwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 15:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiEETwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 15:52:06 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2107.outbound.protection.outlook.com [40.107.113.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F605E741;
        Thu,  5 May 2022 12:48:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FyOZKAJ4aRsKAuC5TN5rhHqVLR6o9fG29nPk2GTZoGXI2cenfYQ5QlSSwkprSDhhLYeKS1eWFILdR2gL2eqp9aL4H0cQarVptTXVCMhpmJ9pAF2wHor5IPuT+uf4ZlMWD2+378XvtJnYi8B/Ekxe2DExrKHQukDjUFGiHZWeVvPz+e/c3XBWq5vAjri4bwZ62rNYdldT8dBzIGxzE0otsxBqySNSztRqyti7UzE3YpSX5dwbnEsrS6kW7PKU2raYR5EBzokkweLpehGRqiCa3GBI5KHp0Erb3iNKpoC8MSf3lIr8t9fjwhrQU5qEulHG8I5mXyYTSiypnfNMUxRN8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/KQ4nLXjtE6tjrRC642A7EKzyH9fbyTx/VH3dcSrrM=;
 b=Dkpcr1wmzlkI6e6dC5czOMjbF3Pgdyk1LKdyl/5JcxeWBiNBm/LviuBRUzDI279fWbaXUMI/WC0ZxHSJh1wV+xcFns6ZLifGLxES/bfz5/n3C/W674O9ollnneuA4+0pxBLHiEPEmJzns+BrtnDVuoAsp3qCIgWiqWqdfpxul3cjftRTJ9bv2cVtUXCaPJY++YlQiYwN6MSWfBv/uWxH7v7Dvjtvp6pU/7J4nWq5ForjBRx/QtHwSYcklDtbetJ6SUfPlm6/KIbfO9T6VQtZcLJGF0JTast+R+CWBEYjI9f3iwSNZMoNUJYBUDUYF4YHtp3OAE9+7tvO5JXO0a8vyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/KQ4nLXjtE6tjrRC642A7EKzyH9fbyTx/VH3dcSrrM=;
 b=HLI1bN92wA9sEqrgC4ggzakq5nPILZkWnMOOk88BCb0qBOn/8aQFN6cEpvxQbpeNWtzoFJ0ljdhiXU1XqcW7B7+ns6GUuoSlbD1813Atn7F3ZIqqKcrE8hzwLMXVfGg7bQbbw2osrWp4vzpQs8FoL4osbhnkAKhNSkqUp9bQoak=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB5807.jpnprd01.prod.outlook.com (2603:1096:400:45::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Thu, 5 May
 2022 19:48:19 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%7]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 19:48:18 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [RFC PATCH 2/4] clk: renesas: rzg2l-cpg: Add support to stack the
 resets instead of indexing
Thread-Topic: [RFC PATCH 2/4] clk: renesas: rzg2l-cpg: Add support to stack
 the resets instead of indexing
Thread-Index: AQHYYLbVZusSN6uyHkGFU4WhZ5VwLK0QryBg
Date:   Thu, 5 May 2022 19:48:18 +0000
Message-ID: <OS0PR01MB592225B5A5E1BA7D250C466786C29@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220505193143.31826-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220505193143.31826-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220505193143.31826-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 348c11c5-7b2d-4256-4ca7-08da2ed033d8
x-ms-traffictypediagnostic: TYCPR01MB5807:EE_
x-microsoft-antispam-prvs: <TYCPR01MB580770171ED359C96ACA510A86C29@TYCPR01MB5807.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4NftL0ZMcO510ETo1mUTErWkMSdtHtRZfQ9sEIEWeFyiqed5cGAG5ykadaphbWrMijWAIaaDK92BY4UVOWGI8npTsv9jyjKECLm9RXo42kNFrNJHCm0n2YkXWq+VVWDlmlUXAhK2Qpika31cmHboFHfNqafPd6MyyaTOc5l9a2DecoE3JQOtYEINhjkEO42bF3oj1o6aKBFFzDlVrvwAkMq4Hg6OrpFiNY5OuRod6TFr/Vam8ulEG4rwoF9M6BRE5VvzmY2zIit/L4SlFryX70VV97iJEvZeH3bgyq/cETIVq+87eTVL3iLzldjd1JPr7Nd4CqYhcGVi/Y3r9NIEAvew7vvDvQrJT7BVb5Rks6YigL7nYb4bqy60bUtTwlUHBkFAG2F2LN9zLsSEYczeOHzKxfm9znpXATqioIn5XE4wdksfwDKTZnLEs3FFkACSTvaXYkhf2x/hot1d2ye5/gTV/yehfDeceval4f4bC3L0tayqOWLHPHHp3nJDHFj58r/1//fA70nlUdinXaRBcGQmPSvuxIfVQwKxZskaDs1fd9NrnFyECWgaerKW9owASjZWKYMFkqJgWKb+hKQXR1DHNGIjWuLxyfkkI6UcQuBd8zVHtQYrzgDePjGBOsf2NfylEobRZTGKxag692SzywjzbJnWWz3QS7r9H+F6fQ3UCqzvmd4IR0Gcy4GghJlH05yM9cJ/YBJu1Eut9AbLTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(38100700002)(38070700005)(33656002)(8936002)(54906003)(7416002)(71200400001)(9686003)(26005)(5660300002)(110136005)(55016003)(122000001)(7696005)(6506007)(86362001)(8676002)(64756008)(66946007)(66446008)(186003)(4326008)(66476007)(52536014)(2906002)(66556008)(107886003)(508600001)(76116006)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N6DeRM8I9Bt/NNTf9qkVPuSc5iM8yOcyTB/FaJ192gNThclBBE0aF8GwouVb?=
 =?us-ascii?Q?syO4VRReldHXa5lI3LCu/TMY8I5G2r+r8EGwrIcPYYd7EtN4/LLxgqNiS7DJ?=
 =?us-ascii?Q?RaIoMSK25m6ycHcWVfwcvKrevx5Dp8HTsa/4ziiegNjto4BIufSwdGAL+oj/?=
 =?us-ascii?Q?GwUZ6oRJQueIiTTqdyGrR6t4yGYlIdGnFOXdpH6DnSiNsfeJ/knQYftXBzpa?=
 =?us-ascii?Q?uReRBiO0fmM8OcststT9aOQW3dSDdlbpUZKHzkaq6mRvHPenwmLlbxUXaEoq?=
 =?us-ascii?Q?Tn1FAqN2EqTENRENwXgrt1H+ts+7os5cN9Cs0w2hfJJP5hJByyormXgteGDX?=
 =?us-ascii?Q?Wq3YWIQk72IVCrneKKQxENfnTjE90RPKdjVjmFiDWrmw6BhMF2sZorap2ySs?=
 =?us-ascii?Q?nALIxNVL5DfVmQUCj35wY9X1nfF7irbZb7kvD8N5r59qD2MGdJYoOACRSZd/?=
 =?us-ascii?Q?sTIHSqxlKzmSZnQzYIBHMWpF/LhFBYBoN8irpwfPBERjBopWAyYuSQ+phHvy?=
 =?us-ascii?Q?5DYISA3Gh/7HbyYFPKmoq+Gj700QFptwu3yKINKJUPtbQhRl7ykMTnNwplt5?=
 =?us-ascii?Q?greZeQQfi9l1xBkYgD4xUalbtc79W9oC78sd5BaO7cf7IWgirJDkU0sfpAKZ?=
 =?us-ascii?Q?s1nDdW1ToT7N/K220/jjh3aMCrinMPr5GQYGEFsqdPE0KXtiu/ntHeBnj+/7?=
 =?us-ascii?Q?1pkpMgyrM+n5iP4cGuYeWl2yaz88QYXWrpP31uEbdNx5eX8TjXBzfjvVuCc4?=
 =?us-ascii?Q?mSBiJI+CJDmPV0khDYTNliwqRFxtFdK9dRD+GyJJt83QG/BRdgdLRFATAPMc?=
 =?us-ascii?Q?C2BS0Ugzx9yb8J5rjM1fUcTcWyhO9DM5BXm5XHOO658rS0bVLqbUumrsqOfr?=
 =?us-ascii?Q?RHwtsUjRPQpmpxBhFmtq6R5jtdeD3K9XFQKtKpBQi8vrvg5TtLkPzrqAwtXQ?=
 =?us-ascii?Q?wnwVj/uPHOf0WQduLAoD/7Arm/k8OJeIl+Oh4pJMQw0vo5GoC6kEtAua7iYn?=
 =?us-ascii?Q?UAeqzTQyEj7n988QK/99UGcNsr2w0Wuhxgc9T9cwQzDa/ESeLc8q/1ytm/3G?=
 =?us-ascii?Q?0NUJQacZheLLCxbsvn45Ka8FxH3nZ4KAzh3lMaN3Invpafd4M6UaLG5hBawJ?=
 =?us-ascii?Q?cxT+A6hyBjyfCzaa2RZ5PRXRxPFcyxZNLtjAGA4z8d6KBKWIWqIdAzP3PDZy?=
 =?us-ascii?Q?oIvrsB+Ru2uJq+rh93DrcJOD9+K2X+49ATZqnWCJrd3tR4lICjKcoO/U6oSj?=
 =?us-ascii?Q?ctEipSqBEwuruurEtzYVeFzjNY2EV4kBOCQXSXnvaF6JyPQ7K8woSq6qqHuA?=
 =?us-ascii?Q?gGvBSbS0MTBSvFRC9ObMyWI10cktwBgjMG6XR/D7eBIYu4Qp8QJoCR6UjZhG?=
 =?us-ascii?Q?nyBO+JwApOh9REQMAK8tzIhosqtGl+rRTFAoG19ME1+SDLBRqgTicQ0by47J?=
 =?us-ascii?Q?sUZiyLCwbW2j2vPWJU3xKaTBYyv+ZWPD4o6qlXMVv8CgtlWFFJuJhnfcuzTV?=
 =?us-ascii?Q?KKJkMkMiGUCXCLzuClbsmHLsVybOLDGhAJQf5H99CKHHE1ZQmv3o8OYaNEqx?=
 =?us-ascii?Q?np5xQ7V6RflTFQgHuTFsObDxcOxGu0WH4yzTece+7DPWTr/2wFFyMzfmohZK?=
 =?us-ascii?Q?IB7dlZVedOsAhMQ1manAzSEODMJZurSfvubtg9swDRJ8yQoFb1lcRWIlNQGg?=
 =?us-ascii?Q?9EQrwlYwunB6EB2eD998IHVW4PH3pGUK6xq20WdHhSQMt4vhggELIY1K8aoQ?=
 =?us-ascii?Q?KpYigtrG997INjzDGgl531e39KOliaU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 348c11c5-7b2d-4256-4ca7-08da2ed033d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 19:48:18.4079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y96Xy3kTpLPZCUr1WN8DQnqk0YCyF/M6wjWgLY5LCIap8USJCFhjY56i8n1xOZgGSmXoYXi4r/cf+w3TyHzyY2V5CuRhXkrOgTbKZ2EWmmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5807
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lad Prabhakar,

Thanks for the patch.

> Subject: [RFC PATCH 2/4] clk: renesas: rzg2l-cpg: Add support to stack th=
e
> resets instead of indexing
>=20
> Instead of indexing the resets, stack them and instead create an id membe=
r
> in struct rzg2l_reset to store the index. With this approach for every id
> we will have to loop through the resets array to match the id.
>=20
> This in preparation to add support for Renesas RZ/Five CPG in r9a07g043-
> cpg.c file where the resets array will be split up into three i.e. common
> and two SoC specific.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/clk/renesas/rzg2l-cpg.c | 76 ++++++++++++++++++++++++++-------
> drivers/clk/renesas/rzg2l-cpg.h |  4 +-
>  2 files changed, 63 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-
> cpg.c index 1ce35f65682b..94fe307ec4c5 100644
> --- a/drivers/clk/renesas/rzg2l-cpg.c
> +++ b/drivers/clk/renesas/rzg2l-cpg.c
> @@ -681,14 +681,37 @@ rzg2l_cpg_register_mod_clk(const struct rzg2l_mod_c=
lk
> *mod,
>=20
>  #define rcdev_to_priv(x)	container_of(x, struct rzg2l_cpg_priv,
> rcdev)
>=20
> +static const struct rzg2l_reset
> +*rzg2l_get_reset_ptr(struct rzg2l_cpg_priv *priv,
> +		     unsigned long id)
> +
> +{
> +	const struct rzg2l_cpg_info *info =3D priv->info;
> +	unsigned int i;
> +
> +	for (i =3D 0; i < priv->num_resets; i++) {
> +		if (info->resets[i].id =3D=3D id)
> +			return &info->resets[i];
> +	}

Is it not possible to use shared reset like RZ/G2L and RZ/V2L?, which
has optimal memory and performance wise we can avoid bigger loop.

Like adding Last index of RZ/Five as last reset index and
Handle RZ/G2UL specific as invalid reset index in xlate??


> +
> +	return NULL;
> +}
> +
>  static int rzg2l_cpg_reset(struct reset_controller_dev *rcdev,
>  			   unsigned long id)
>  {
>  	struct rzg2l_cpg_priv *priv =3D rcdev_to_priv(rcdev);
> -	const struct rzg2l_cpg_info *info =3D priv->info;
> -	unsigned int reg =3D info->resets[id].off;
> -	u32 dis =3D BIT(info->resets[id].bit);
> -	u32 we =3D dis << 16;
> +	const struct rzg2l_reset *reset;
> +	unsigned int reg;
> +	u32 dis, we;
> +
> +	reset =3D rzg2l_get_reset_ptr(priv, id);
> +	if (!reset)
> +		return -EINVAL;
> +
> +	reg =3D reset->off;
> +	dis =3D BIT(reset->bit);
> +	we =3D dis << 16;
>=20
>  	dev_dbg(rcdev->dev, "reset id:%ld offset:0x%x\n", id,
> CLK_RST_R(reg));
>=20
> @@ -708,9 +731,16 @@ static int rzg2l_cpg_assert(struct
> reset_controller_dev *rcdev,
>  			    unsigned long id)
>  {
>  	struct rzg2l_cpg_priv *priv =3D rcdev_to_priv(rcdev);
> -	const struct rzg2l_cpg_info *info =3D priv->info;
> -	unsigned int reg =3D info->resets[id].off;
> -	u32 value =3D BIT(info->resets[id].bit) << 16;
> +	const struct rzg2l_reset *reset;
> +	unsigned int reg;
> +	u32 value;
> +
> +	reset =3D rzg2l_get_reset_ptr(priv, id);
> +	if (!reset)
> +		return -EINVAL;
> +
> +	reg =3D reset->off;
> +	value =3D BIT(reset->bit) << 16;
>=20
>  	dev_dbg(rcdev->dev, "assert id:%ld offset:0x%x\n", id,
> CLK_RST_R(reg));
>=20
> @@ -722,11 +752,17 @@ static int rzg2l_cpg_deassert(struct
> reset_controller_dev *rcdev,
>  			      unsigned long id)
>  {
>  	struct rzg2l_cpg_priv *priv =3D rcdev_to_priv(rcdev);
> -	const struct rzg2l_cpg_info *info =3D priv->info;
> -	unsigned int reg =3D info->resets[id].off;
> -	u32 dis =3D BIT(info->resets[id].bit);
> -	u32 value =3D (dis << 16) | dis;
> +	const struct rzg2l_reset *reset;
> +	unsigned int reg;
> +	u32 dis, value;
> +
> +	reset =3D rzg2l_get_reset_ptr(priv, id);
> +	if (!reset)
> +		return -EINVAL;
>=20
> +	reg =3D reset->off;
> +	dis =3D BIT(reset->bit);
> +	value =3D (dis << 16) | dis;
>  	dev_dbg(rcdev->dev, "deassert id:%ld offset:0x%x\n", id,
>  		CLK_RST_R(reg));
>=20
> @@ -738,9 +774,16 @@ static int rzg2l_cpg_status(struct
> reset_controller_dev *rcdev,
>  			    unsigned long id)
>  {
>  	struct rzg2l_cpg_priv *priv =3D rcdev_to_priv(rcdev);
> -	const struct rzg2l_cpg_info *info =3D priv->info;
> -	unsigned int reg =3D info->resets[id].off;
> -	u32 bitmask =3D BIT(info->resets[id].bit);
> +	const struct rzg2l_reset *reset;
> +	unsigned int reg;
> +	u32 bitmask;
> +
> +	reset =3D rzg2l_get_reset_ptr(priv, id);
> +	if (!reset)
> +		return -EINVAL;
> +
> +	reg =3D reset->off;
> +	bitmask =3D BIT(reset->bit);
>=20
>  	return !(readl(priv->base + CLK_MRST_R(reg)) & bitmask);  } @@ -
> 756,10 +799,11 @@ static int rzg2l_cpg_reset_xlate(struct
> reset_controller_dev *rcdev,
>  				 const struct of_phandle_args *reset_spec)  {
>  	struct rzg2l_cpg_priv *priv =3D rcdev_to_priv(rcdev);
> -	const struct rzg2l_cpg_info *info =3D priv->info;
>  	unsigned int id =3D reset_spec->args[0];
> +	const struct rzg2l_reset *reset;
>=20
> -	if (id >=3D rcdev->nr_resets || !info->resets[id].off) {
> +	reset =3D rzg2l_get_reset_ptr(priv, id);
> +	if (!reset) {
>  		dev_err(rcdev->dev, "Invalid reset index %u\n", id);
>  		return -EINVAL;
>  	}
> diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-
> cpg.h index 92c88f42ca7f..a99f2ba7868f 100644
> --- a/drivers/clk/renesas/rzg2l-cpg.h
> +++ b/drivers/clk/renesas/rzg2l-cpg.h
> @@ -152,12 +152,14 @@ struct rzg2l_mod_clk {
>   * @bit: reset bit
>   */
>  struct rzg2l_reset {
> +	unsigned int id;

Now you are adding 4 bytes to each reset entry in the LUT.

Cheers,
Biju

>  	u16 off;
>  	u8 bit;
>  };

>=20
>  #define DEF_RST(_id, _off, _bit)	\
> -	[_id] =3D { \
> +	{ \
> +		.id =3D (_id), \
>  		.off =3D (_off), \
>  		.bit =3D (_bit) \
>  	}
> --
> 2.25.1

