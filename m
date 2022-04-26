Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9902D50FF76
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344897AbiDZNvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243366AbiDZNvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:51:18 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2104.outbound.protection.outlook.com [40.107.113.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029B61BEA3;
        Tue, 26 Apr 2022 06:48:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOypxFEMH87mXCUSzjJgjYkm+YR0ea5qpEB+HZkOjaHI9wQyJHR36YZeMWsTjjFagwBwDnRGZKoal2Nce4IdxwMQAoOKTGsFaH5KzfEe6ra1MEeJJ4xINTnunsleLh2cIcI4vXM5egDBIqEa4S3sLZLl8ZKwwaUugzNnDE+7BqIdan/5939MPUfx8dgTo50RDZUp2RLjRToSul5Gz7qWnQYS0gpsFay18vhW+SleGHuZBMGhauS2L6+ObDrRhRXRX94SMCeUTi+Trf4dgiRhN1f9wCi4LRN17+Glta6H7IjrWzXlhNweEfTPOF75/iE0KWcmSgJN6HqY8EU95ur0hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PiPtvnGnGFook3JQEEeZC00N2WBSHLc7J+2GuAQgsf8=;
 b=UoN/xx7UG4NhObtPkHUMJTlUUAB9sMnVDtJHxNfUGM9g8qkOdWS5xuz81QmZeY0xz0ZlVWP712qPvZuMvX1Bb/J/U8pv8m91b7Jf1nIerpL7X/00MHOXigo1AtAEeJux2KcCnINNcLgBoLeDeTPkI2bgDJ7dP1Zo/yDXMGorl+qYsggS6Tku5vzB43e1AqJJAI0tZ8JDJtT7nvwZ36BvtE6fJ6RBt8SAQpG+mepCTcwGA6KyQ4dNBOfXciYXKMquv/s1j95rng8dd+3LEgcl9T9lrtF71HdFNqSB9ujfyrags75ScNQ+JKuVb0lnSmQs6FKlVSTh39j+iBxoc54Txw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PiPtvnGnGFook3JQEEeZC00N2WBSHLc7J+2GuAQgsf8=;
 b=Vx4onO67qOd8A3UHN5n764MMKG6artBt8hdmitXDQrXKiWexGVKMFyAFtnA5UC6PUhL/vdIWT9a+cOtmcxg0KqESxLoqiiuePmBJ6XbCI9F/QFnDlMZtd3ATOgkxP4CpYDBsLsJGddCLVPgZDocsFENMFcpPCfgt8bUXQp62Ql4=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB9728.jpnprd01.prod.outlook.com (2603:1096:400:22a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 26 Apr
 2022 13:48:06 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b129:a6f3:c39e:98db]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b129:a6f3:c39e:98db%4]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 13:48:05 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Pavel Machek <pavel@denx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v2 3/3] ASoC: sh: rz-ssi: Release the DMA channels in
 rz_ssi_probe() error path
Thread-Topic: [PATCH v2 3/3] ASoC: sh: rz-ssi: Release the DMA channels in
 rz_ssi_probe() error path
Thread-Index: AQHYWUI9b6YCzhSj9EqJ5aXC4ZDfIq0CNJSA
Date:   Tue, 26 Apr 2022 13:48:05 +0000
Message-ID: <OS0PR01MB5922BF4F1DB81E97926499E786FB9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220426074922.13319-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220426074922.13319-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220426074922.13319-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 906803ac-ab22-4853-1c32-08da278b6406
x-ms-traffictypediagnostic: TY3PR01MB9728:EE_
x-microsoft-antispam-prvs: <TY3PR01MB9728E5E407160110811611F386FB9@TY3PR01MB9728.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WYUd+qgosIHNXyFODVYGG4bmnnQViQEoQDMnWorA393dOHlKp/gf2ZPayJEbN13lyfH8WAQwpHbPQsS0lQw2GnOPv4ltIKvteusbmbq+sKZFfoDL2cDC9ROwb9M8yzpMa5OPDi3L7S5UXuTswdj0BN1C/JOatSE9zdzfZwOQRsYgzFzVLWAx5fG97UO5zXINqWn9656OsdVHXkhFl+FySgRkCLwl++wbjuNO/W8PvgXVex0A8mBxt0q9SimSUdzaLWiFTmxgfFcEi/g6XTIBY6yd/fpbFZeaKTtUSmqc08bPgiMwRcIKGCazydcyeVaZFOjLsk86cPn/AUHyOZgr31s8afFv5q3FGG0PEW82tA0Dc3sDlFP/mvTSRp3htIjOvKLG+q5jaPfc44leNPwvsOycqsVXbSyOOAGg9SBq8Me6I8Z0/PJex5zZYgDasf9Rs9N8d7ZwhrwaK5r5vaKh15UjHMlrEDtvqc0e/cpVS/2qZ0FH679ToGWpDDDKpDywGlDVM/839UfoFOUuMlaHI94aETeNNpxHgAA2UnVAD9c/7GEysNaHyuCuJ6SQeK+rqU/26If/upeA6Fys4VqDt5TGgcJ9AEPerup8LiAkfWixcaOaaEBb28zzEIKg55Q87jVSMdCtthyX9sjVKXWaSQt7x9NBHFupCooFUwDw37wC8wdXUp+pwujWGtViPWgf8jVpTX+qTc9hx2Yl1coIUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(122000001)(54906003)(83380400001)(38100700002)(33656002)(6506007)(316002)(9686003)(7696005)(26005)(186003)(508600001)(71200400001)(110136005)(66446008)(64756008)(66476007)(66556008)(107886003)(5660300002)(66946007)(76116006)(4326008)(8676002)(38070700005)(52536014)(86362001)(2906002)(7416002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e2s5I1sXbGSXn/N41xdE0yzhXQQWqLIZXd4tbwrmhKf7husPnicbuUJnF1YM?=
 =?us-ascii?Q?HstqHLAi60sv0GJTDOKShKs9JIAU08LGKGS4f29HZaf2c0S8tpzd0UHzeFDY?=
 =?us-ascii?Q?ORj/vSGs4sT62dwoeL/GG5bKAtC+FPR1oBIiSWpSOybK8PqQ2rjXVJvMLrDL?=
 =?us-ascii?Q?NmNx2idCKsc9MFT15UyflGUtOO6eRy7wJ7Q15KOflvMT5+UF8+BPZBOKGAmn?=
 =?us-ascii?Q?DBaWHxvwRXFSnw5zSe15Z+022hUz5QUiigmjdITSqQPc76AyDxMG+HhXV/lI?=
 =?us-ascii?Q?by5bz+rMM3giSWp0oNm6trN30ozGMGEFAASsOottw0o1Y0FBeVGYicloXFo/?=
 =?us-ascii?Q?bNiglnaCERwOFGFmF8gs/j0kUeM89zgHkU6c5tefUzeNMyfl+LUGSKGWSWF4?=
 =?us-ascii?Q?UZ2Je4hrkcmSqQYPO5EtSLWS9dwFZ3IPjfpQ4hFt8b1DAKkSyawmX4RSk4SW?=
 =?us-ascii?Q?DppmwCQ3olOICsmm/W1DsU8Rr9L0752kv6YFwGyTeFRqjuvgqaCIxPtQpW0q?=
 =?us-ascii?Q?ksaIG2hmuRSsGdHjelbue4VZW/9U2FvlvlNyUkeQ3385x4qysS9C0xZnGXSG?=
 =?us-ascii?Q?6lQ09QfRFmtLT5mAcF6mPM4+sbpI+wU9UiEFd+GXgK7usbTY/10RvSl+j6Du?=
 =?us-ascii?Q?2XgdKkOd/3xdOfsuR4ULJrmxQtgOYUYI9kWMD4kHEDIt3LnaIZm+FM226ICo?=
 =?us-ascii?Q?qoyTpCr4WFf5mKkL3DdFeb6zFrvfoeist0d5u9oc8HC16EJP3jFklTlzCAUS?=
 =?us-ascii?Q?gnvyZ5A2UNz7d4wyvfJOy+68SMeK9aQpDVXjWAItqsi4R/CwnA0D/gxvRCxC?=
 =?us-ascii?Q?kE0WxrmSGETs4uuncWLcOXt/h+LjXdtM+2rzIr3OiAPCkefOSR3jasnYqcw2?=
 =?us-ascii?Q?oQ4AeQkvSiZatyoxy2NZDr+u5IUvO9VAESSucocyI1tsEHTgdSmwGlvWguHG?=
 =?us-ascii?Q?A8jWXeNKmwuccfOMfEBUr6HvoW9dY6QlOMrIlTLW6f6Z+y5awBRIYFlD5ftB?=
 =?us-ascii?Q?SnVXD+WqFz/fb8XcYHBaQmYhbpq6jlElcB/TJp5RSjBLd87oeLHH1SqSVu4b?=
 =?us-ascii?Q?Wsyn+m/uOFMl3O3UDqWc1OkaieB/MeMdrk4W492/bzqf7SFtt856dowxgpnq?=
 =?us-ascii?Q?MNg0eQLXRrh0QfS7Q25wZ1JDeJNWUPvuSyZtbLKpTqIT1bySUKIXV5TUEpZH?=
 =?us-ascii?Q?VeEtJQxRREuFOAeFVuhpvLyOukop6Zk1DLGXmB4GoXM14CEonx6+oAmVBdO4?=
 =?us-ascii?Q?YB69uHTTWfkWtivIyLRIZFx+K5PHWMP9IB2oCM230sNlMVGOpfsUZt/ByY86?=
 =?us-ascii?Q?SL0sqbm2vBQafGnDjkMePhsHcSC1QqwmwkdZRubJjX32vA1woPXMO79Rd29y?=
 =?us-ascii?Q?g5DrZenm2mH0m4rqa6kuJgi3MZ07B7kaWuzUzqUZz/P0VdUHKNv2PsLeBmXz?=
 =?us-ascii?Q?D32Er5Ni7aJ0MKVsMIIcNCnpPlaKeevVOkP4OR51XRjPIDyANu3GROPH/OZa?=
 =?us-ascii?Q?hv+siNfqed5ZuKwDCHwJnKtDLgU5Qv911RxqFN7lNBBgssQ5zu972XIlGtnb?=
 =?us-ascii?Q?ccTOaiEpAlNPOW5TLeMDM3giWKZ9/rxb1X+USJZsa9RJv320mZStyAEYF4Nc?=
 =?us-ascii?Q?DXZp3ipCdGFKwdpBav0Vtq1+ZoCcfUi/zvqFssM8NR7SR8EByUQvmvUnNPgx?=
 =?us-ascii?Q?WIvwfKWA8Gp4625UFd2qmEJ+sKnZU2H8c2u8ULwSLqVDcjPEF1h91PoPdDeo?=
 =?us-ascii?Q?rzOAv756QOzWc+q6zMcV2SlFrPoSmkA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 906803ac-ab22-4853-1c32-08da278b6406
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 13:48:05.8249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HdDWIg8lYPZXgZXxgKcbWB1XdJ5yINBgzka2p8W+JPtdGVqru4P87zxL9RJXKyRzYIvIWVH8nK3f7q55dOb9k/A0BB/1djhlSLvgydu6Lm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9728
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lad Prabhakar,

Thanks for the patch.

> Subject: [PATCH v2 3/3] ASoC: sh: rz-ssi: Release the DMA channels in
> rz_ssi_probe() error path
>=20
> DMA channels requested by rz_ssi_dma_request() in rz_ssi_probe() were
> never released in the error path apart from one place. This patch fixes
> this issue by calling rz_ssi_release_dma_channels() in the error path.
>=20
> Fixes: 26ac471c5354 ("ASoC: sh: rz-ssi: Add SSI DMAC support")
> Reported-by: Pavel Machek <pavel@denx.de>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2
> * Dropped devers action and instead called rz_ssi_release_dma_channels()
>   in the error path.
> ---
>  sound/soc/sh/rz-ssi.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c index
> d9a684e71ec3..e392de7a262e 100644
> --- a/sound/soc/sh/rz-ssi.c
> +++ b/sound/soc/sh/rz-ssi.c
> @@ -976,14 +976,18 @@ static int rz_ssi_probe(struct platform_device
> *pdev)
>=20
>  	/* Error Interrupt */
>  	ssi->irq_int =3D platform_get_irq_byname(pdev, "int_req");
> -	if (ssi->irq_int < 0)
> +	if (ssi->irq_int < 0) {
> +		rz_ssi_release_dma_channels(ssi);
>  		return ssi->irq_int;
> +	}
>=20
>  	ret =3D devm_request_irq(&pdev->dev, ssi->irq_int, &rz_ssi_interrupt,
>  			       0, dev_name(&pdev->dev), ssi);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		rz_ssi_release_dma_channels(ssi);
>  		return dev_err_probe(&pdev->dev, ret,
>  				     "irq request error (int_req)\n");
> +	}
>=20
>  	if (!rz_ssi_is_dma_enabled(ssi)) {
>  		/* Tx and Rx interrupts (pio only) */ @@ -1011,13 +1015,16 @@
> static int rz_ssi_probe(struct platform_device *pdev)
>  	}
>=20
>  	ssi->rstc =3D devm_reset_control_get_exclusive(&pdev->dev, NULL);
> -	if (IS_ERR(ssi->rstc))
> +	if (IS_ERR(ssi->rstc)) {
> +		rz_ssi_release_dma_channels(ssi);
>  		return PTR_ERR(ssi->rstc);
> +	}

May be we could move reset handle get above DMA channel request??

Cheers,
Biju

>=20
>  	reset_control_deassert(ssi->rstc);
>  	pm_runtime_enable(&pdev->dev);
>  	ret =3D pm_runtime_resume_and_get(&pdev->dev);
>  	if (ret < 0) {
> +		rz_ssi_release_dma_channels(ssi);
>  		pm_runtime_disable(ssi->dev);
>  		reset_control_assert(ssi->rstc);
>  		return dev_err_probe(ssi->dev, ret, "pm_runtime_resume_and_get
> failed\n");
> --
> 2.25.1

