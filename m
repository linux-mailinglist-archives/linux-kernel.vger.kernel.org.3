Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FDD50B0E9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444565AbiDVGzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiDVGzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:55:08 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2136.outbound.protection.outlook.com [40.107.114.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6453450E23;
        Thu, 21 Apr 2022 23:52:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnyNWUsncmwKtNnnBP0YfBWNn2oM9pH4hkexBb/i9nBjzpw99Sx4tVUFV36CIX90XVDdUjA8WmDWomcKTxPE3Pzi2HdqdJ2R2tV7AegzCO15EiBOehZuWkUap+9n7s6q9uXDzXR+0Gi9ncCLcdRCfvS8y7yzeHSGSH8fPMqXIUvC0MfkAbtjbkLjXf4SIWef+MDoWiM0ftbqk3mc+oL6XShdFdG5yDI2fsF0DrFiWFwXLPmDb5M+qcM1+CQoiMSx0/E5/A/sFleLbRHd6718CND/xQjq6In0dTGR9qfv6FfgF9+V4Ye6zTh/s1S6fwgAtONzeWvUkQtV4q+sbSTgzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKEftI0wCIBXMygOpQGDNzjeTQaJCjziuqcRyrSSHcQ=;
 b=fRtrwqyFDx89NeVJT7ZuxsARDiKxcUe2SU4hFlhuMEZHTmKXimDoJ0bf0i2IFLSfQM9DwBXk2C7lE0SrJ/OezMK/7v90BmxYo7vz/Vu/yVCkfwoXYkW21ow33wl596aBT/ItTWoBUgZ2wdfcex0efn/9hHCKcH7GTkhRWVXQfhfBCFp+G7kYQMhEqVtW/18po06Y3RrYLInf9085L+SYqBRFCyjTslUa59Waf5bmGJ3viZ0WHFr1L8bSIoB3VlkILc9TrRpAtJ2MAYh0fHXSB5j503gyX2MWSvY8TxL30faeCK4HrAzE4Xs0SvdNCBwZjqrs/AAbDPYVdOO7tiiyGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKEftI0wCIBXMygOpQGDNzjeTQaJCjziuqcRyrSSHcQ=;
 b=kFUTtETOVo/+wUchvGWxxmPZ8ChuQK5WfPjdNuNHNu7PFMlf8dZVFO/6oX4VCmlLu19bKen7XgGJ80IcM2s3k/CIlkCd9iQnW3XGSAEsRL9JfqAnR4ygBEyRNtLbzvFyRfPH7vVXWpi5CDCafRfPqvtmWU/ch8ljykOj58okuIo=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB5991.jpnprd01.prod.outlook.com (2603:1096:604:d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 06:52:14 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b129:a6f3:c39e:98db]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b129:a6f3:c39e:98db%4]) with mapi id 15.20.5186.014; Fri, 22 Apr 2022
 06:52:13 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Pavel Machek <pavel@denx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 3/3] ASoC: sh: rz-ssi: Add a devres action to release the
 DMA channels
Thread-Topic: [PATCH 3/3] ASoC: sh: rz-ssi: Add a devres action to release the
 DMA channels
Thread-Index: AQHYVb9/WJebVmtRxEmme8RS6rMi36z7fKpQ
Date:   Fri, 22 Apr 2022 06:52:13 +0000
Message-ID: <OS0PR01MB5922C8287D7EEAB3F9DB60C386F79@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220421203555.29011-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220421203555.29011-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220421203555.29011-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e789b3bf-a5f6-4bf8-e38f-08da242ca1b0
x-ms-traffictypediagnostic: OS3PR01MB5991:EE_
x-microsoft-antispam-prvs: <OS3PR01MB59910BE1F6D76FD7E58CE72886F79@OS3PR01MB5991.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uPE8096/jrDd51gHpNWnTmhzTMZOkaX9KhoYQH1j4t/9H66RtnqPt6aR/iXerU8AN9CumRb4L/Z95UL0z5aYwO1fAJV3jdcRusVrjwXu/b7jsTZqC6xc7/nTeiHBJVug0CdiJZcPTU4OXAk2GuygFq+wWCu0Xj6p2N4O7A6L21oIiRV1EugP6TpKeD4VQE5MaKnUYyt2Vb105BUGMzCD8vqf5jZ6Cteu6ej/+fXMZIlcxjn/tNqzMJemO3+SxnjakdHk/fRkZ48v9jZcxzhMpL/fg6pvv3NHknEP35HGsObTx8f1YBiotZwdrBJQojOPi47S5dUstUiIrXQzRSBjzZaySjVYKRgyE8W/Ffc9wGKJ6qsjIcC67AR2W2t+GE7Goc4WkGKmxomB/f/Crkz60bP+Gr2AXpKEOaBO+BKNpHsz04EoI+/40md4EihTT8/k15HF5kC9nHq7N47FOQ+o6jOpLe2ve3TwM9UyNZSKLgefH9VHCh0RJGfv4Jpf8c5F7XbJ7UuUJNy4iQLgqMHjqrKxGzWSAULaYFU+5A5SzNtTIOMIdYS1p4iSbmzvfDCXXhBGSJ/Y09eAez2UVWt8wM0JglggbyEsQ+oD8KhHjDtYhbeFbrGMoujTBKaUgtH2SvvH1BcMj6Ut2KxQ6/RY3cnFSBpmeBtXw3vsBqbncXBqkls/W13EXQIsyD4RILnSoBUYmmti/6AHRVcpg1pcYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(26005)(9686003)(508600001)(4326008)(6506007)(66446008)(8676002)(66556008)(76116006)(66476007)(64756008)(66946007)(7696005)(107886003)(86362001)(38100700002)(5660300002)(8936002)(38070700005)(186003)(55016003)(2906002)(7416002)(33656002)(316002)(122000001)(110136005)(54906003)(71200400001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TqTtiC5u/9ESGcYBdCMb3RnvSqDWg8HI45WoYiwbuhCne4lgBq5lTLvB1dw7?=
 =?us-ascii?Q?rDGgbo0eZzrYJAj+GFnmrk5YXaFAAjgYMgyZbMPiP1BHAxQe5XAe2HstB3+b?=
 =?us-ascii?Q?oblYwK83sS9wi4JT2MpRNK5BCf0Q0RABPZcBHrynkgQiXgBf0vEE/ek62nXf?=
 =?us-ascii?Q?s9CsnZBSNgon3NTpW61jsfd4tG5h9KmXWUeFg2inR9ObKh/b7LulT21KAGvw?=
 =?us-ascii?Q?TW62jet4F5j89N1qB+M8n7wVgSQ10FVQor/R58UxAVmaqHUl6EfKYbsWfPpM?=
 =?us-ascii?Q?Sungp5OSo7X7xHiKkUTUz6+SWy7WOZMEl/q61Y0I5OGlHI7ASIils0sqHay4?=
 =?us-ascii?Q?8wM7Dgluk5wtT4VDxkIGrB//yDRwZfDZk+IcSeaVE0e47SBphvhOaNNWWnA5?=
 =?us-ascii?Q?OCDuZI9pV3DUTP536nT/baydfpho8Rw5jTWDIPjiJ5ZbpFXYjR3Low0m0get?=
 =?us-ascii?Q?sYbtAbPib059cB81W52ehB85WvhMb1LJVoEHO12FcajJNV2O1cqohEjpkoap?=
 =?us-ascii?Q?gGFc7rpjQArQ2GHMPu5DUd7J23mwBoylXl8FDAn9RU3yTspci7kW++KMp3zq?=
 =?us-ascii?Q?GWnLshFYbR+2KrXhQfVARBCsXaFuXLE4ke60F3z2Q06s1wrppcM3ObXWB4Oi?=
 =?us-ascii?Q?UWqTMP9/kPRCrwVcpVEK7j2Op4ZNhJH5np7C6ArItVZGY8/2kQkZi/62oCOA?=
 =?us-ascii?Q?BjyMCimDBEq0s93KyOwa/hDI/hc2lyINZgx7Abmo+CJzP8K1sQDAQhR7JGbb?=
 =?us-ascii?Q?ZHDVqVO8/+ZljWAWUblfj7Ny2h8HCNI2QECtyRaHto5OIKflla5XBEBCdLFR?=
 =?us-ascii?Q?/LcXtgIYRMY0t97tS8wrDcB3DAwbgwjyvbZOvcBxyB5UWRoUx37BDeG89FDF?=
 =?us-ascii?Q?NhPDOeRdY289wL/fgcZ5o6KXUq/7SkdcGgClGl5RG2QXCjP4MD3xEH0rDkYN?=
 =?us-ascii?Q?sditvRgIehUipMjF/Ng64ffQx0ndvXtkiq2iiUybzVznuCvfdiEgekAIlqlK?=
 =?us-ascii?Q?x3HWG+Y0eUGawOEU3BqIIqtH1KcW0yTq2pxU6BQLLrkXq/bHBNBIQuRNEqNv?=
 =?us-ascii?Q?R21CeSVtliphpDxkZssH5DLgK0v5JX5ncvBb9uilDZsil/BUI7CDWf46olYL?=
 =?us-ascii?Q?zCnynlpI+MGLTNLzSeJgfUmVDQj4F72RCv6lHO+p50/VvJn7Y0bv3DMJQQPE?=
 =?us-ascii?Q?paUyISmDDA7/+luSzffAWJQJqxHUfNoOF96j8dLsaQxRwILicxzFawA+uT0g?=
 =?us-ascii?Q?UlrJNQkSszzswdbBXpQOVSYFmzBhZMNkpdPxdfDwe0ZiEpjw3rzeF/oY7uft?=
 =?us-ascii?Q?0e/prDrkmEM9CZe/ltNFlqsRIPT4mQvzrJqq2GWmhqNTk+acVEGtSg/m7b75?=
 =?us-ascii?Q?4FLglS4A2qGc+L/nFd6y94FAzkCOKKdyPmyRVkTWdi9gR8JVVaTkAshjzAJy?=
 =?us-ascii?Q?ugXc0HtYNMJ25PGa7qFwH7u66OGjDXLk27mcfd96iBl4oShBeEfPoIbmgVoR?=
 =?us-ascii?Q?mTydPowhqSPNM26w0RZ+F8w9iYuB0QwHKMIDqZW64zNkgOJhent8HZfAVXJ1?=
 =?us-ascii?Q?8WlFm+8odgHSDrzdpI93gBxUjLYa+A/eJS/ilZOuzcc59mvZKflus8szpPxW?=
 =?us-ascii?Q?7636v9avB4ail6+m70MPmGTr1PpsDRe1LBdOWHlY2SeHLwXFkNBTCsJgYXaf?=
 =?us-ascii?Q?GZn4s/6pSCj/uQ6Cs7gkmyi2lNlM8ChLWmmZNafQemz4hWZq3gJdgd4yDcdq?=
 =?us-ascii?Q?AzqJ5wIP1AxCiEEIsyl7y1gsqUkGYUg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e789b3bf-a5f6-4bf8-e38f-08da242ca1b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 06:52:13.6075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W/98houYFjoEWnqyMdo+c+QbSmnkNvgwwef3gVxmQXVhdGEwjQKuQzFDE8yV51aMHtxFV3jTjGTNJnuYaswdECKJJCzhtCfVqPV1XQJVxDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5991
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lad Prabhakar,

Thanks for the patch.

> Subject: [PATCH 3/3] ASoC: sh: rz-ssi: Add a devres action to release the
> DMA channels
>=20
> DMA channels requested by rz_ssi_dma_request() in rz_ssi_probe() were nev=
er
> released in the error path apart from one place. This patch fixes this
> issue by adding a devres action to release the DMA channels and dropping
> the single rz_ssi_release_dma_channels() call which was placed in the err=
or
> path in case devm_snd_soc_register_component() failed.
>=20
> Fixes: 26ac471c5354 ("ASoC: sh: rz-ssi: Add SSI DMAC support")
> Reported-by: Pavel Machek <pavel@denx.de>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  sound/soc/sh/rz-ssi.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c index
> d9a684e71ec3..f04da1bf5680 100644
> --- a/sound/soc/sh/rz-ssi.c
> +++ b/sound/soc/sh/rz-ssi.c
> @@ -912,6 +912,11 @@ static const struct snd_soc_component_driver
> rz_ssi_soc_component =3D {
>  	.pcm_construct	=3D rz_ssi_pcm_new,
>  };
>=20
> +static void rz_ssi_release_dma_channels_action(void *data) {
> +	rz_ssi_release_dma_channels(data);
> +}
> +
>  static int rz_ssi_probe(struct platform_device *pdev)  {
>  	struct rz_ssi_priv *ssi;
> @@ -966,6 +971,11 @@ static int rz_ssi_probe(struct platform_device *pdev=
)
>  		dev_info(&pdev->dev, "DMA enabled");
>  		ssi->playback.transfer =3D rz_ssi_dma_transfer;
>  		ssi->capture.transfer =3D rz_ssi_dma_transfer;
> +
> +		ret =3D devm_add_action_or_reset(&pdev->dev,
> +					       rz_ssi_release_dma_channels_action,
> ssi);
> +		if (ret)
> +			return ret;
>  	}
>=20
>  	ssi->playback.priv =3D ssi;
> @@ -1027,8 +1037,6 @@ static int rz_ssi_probe(struct platform_device *pde=
v)
>  					      rz_ssi_soc_dai,
>  					      ARRAY_SIZE(rz_ssi_soc_dai));
>  	if (ret < 0) {
> -		rz_ssi_release_dma_channels(ssi);
> -

Maybe we need to keep this as it is, otherwise DMA channel release will hap=
pen
after CLK disable and Reset assert. Ideally release the channel, disable th=
e clock and assert
the reset.

Similarly, you may want to add "rz_ssi_release_dma_channels(ssi)" for error=
 path related to
Pm_runtime_resume_get.


Also with this change there is unbalanced release_dma_channels() one from d=
evres and other from remove.

Regards,
Biju



>  		pm_runtime_put(ssi->dev);
>  		pm_runtime_disable(ssi->dev);
>  		reset_control_assert(ssi->rstc);
> --
> 2.17.1

