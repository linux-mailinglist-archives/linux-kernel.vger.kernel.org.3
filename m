Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65DD5A0145
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 20:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240546AbiHXSVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 14:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239596AbiHXSVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 14:21:42 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23C4F09;
        Wed, 24 Aug 2022 11:21:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KimoZvqY4PFIPlG49zOIV2sgHNQCXiYdoRylau3O+J6SUrL9UUddTD80FxozXW4yH/YxxrqgUJDzMRIXJnp+K0VoUuf+25WOQoyjq8XNHC4COR3a3JjZf5k5lImViBvyt1e/xcq/AiWw5eu3pxmiaRLRt0WMB7SIwjQMyN6qiZS8xjZJ/OXSBa4MM9ZiB3RtukuRotwUFrH+vXtsXlQTgxy+RMElsSSzvcwLKUpsHMQwfWnB7w1aO4Qc7jnzzuBGpqQCtsL0/tO3V/8ZC4NXe7VShgPsg8ynymgIF4D1FeOH5jDRu/8bOe2pou0GL50hMxzOq8fvbhisXaE1KMEDVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DiM/qI4d1Qxw9S80pYAS72F//EjRoUQcc7fd/wk7aT0=;
 b=NY+MAE+wJeB9kWX2kaCq/DLPHtuLqN09JTwwMuP6poXNg/RVeJqSxKaO7Z7vM2Rn8VoRcQJmrFm0mjMMsQIKcKYSu5HCvfok1fKrVX1zGlQPCJo8yog/oMjG2UcgkktcmXEb3dRGTKhgvqqNTokQSQipMJp+HCwURbtNvquTnBFHM0CnQbqnXqCVUd8k3YxHS6NRoAScyE1OiKaDhLM+OsJ1K+c4mbe8TvP7k+QQBM1y44oqnpB3lqO0QU1YtyaB96JMvFM1qYjj11i7FszAySVj6LgeKw3/eV+1FM75pz7AvSUBYoj+4YAsojP59Y732NF/kWIMzlDKnsfRwaz3qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DiM/qI4d1Qxw9S80pYAS72F//EjRoUQcc7fd/wk7aT0=;
 b=ZM4PwI+BkQm0nN7JCYRndIazY+LRPwmyBumFSlMAPbtRSVW72ASDh1bnLj7R2rlqORKb4TFrYBDTYiGjx3PEGjN925ciAwTt/xZsiFx1D4ao7zCpVCaOtve7ftD4S+5/4H3DDYuHoiUqQyhu2xCWNOVUtciRhcYjEMlhRO9HmYHcZ/NVdqh3m7CixxEt/7ZxcyZP/y8J/vAjO/6ylJ9pEVYLC3ui56srY9/66OIRj0nKHT+P78fxwGhrNbICgzQbQ29ofEo1gUezIMLD5mANzOhHT6qHGx2oaqVMyPFg7a6GInNAlMBQbuadThRDJBax9+zqyFJwSg8AqVmrEEYdNQ==
Received: from DM6PR12MB3164.namprd12.prod.outlook.com (2603:10b6:5:188::30)
 by DM5PR12MB1723.namprd12.prod.outlook.com (2603:10b6:3:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Wed, 24 Aug
 2022 18:21:39 +0000
Received: from DM6PR12MB3164.namprd12.prod.outlook.com
 ([fe80::c5ee:6ad4:e02e:f226]) by DM6PR12MB3164.namprd12.prod.outlook.com
 ([fe80::c5ee:6ad4:e02e:f226%4]) with mapi id 15.20.5566.015; Wed, 24 Aug 2022
 18:21:39 +0000
From:   Petlozu Pravareshwar <petlozup@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Jonathan Hunter <jonathanh@nvidia.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dmitry.osipenko@collabora.com" <dmitry.osipenko@collabora.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "Kartik ." <kkartik@nvidia.com>,
        "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
        Sandipan Patra <spatra@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] soc/tegra: pmc: Add IO Pad table for tegra234
Thread-Topic: [PATCH v2] soc/tegra: pmc: Add IO Pad table for tegra234
Thread-Index: AQHYq2OBoFD/HPDAc0O2lhI1i2kS5q2003sAgAmibVA=
Date:   Wed, 24 Aug 2022 18:21:39 +0000
Message-ID: <DM6PR12MB3164D87DECA91CBBC4803118B5739@DM6PR12MB3164.namprd12.prod.outlook.com>
References: <20220808201420.3451111-1-petlozup@nvidia.com>
 <Yv5XMt5M7IGm4/Gx@orome>
In-Reply-To: <Yv5XMt5M7IGm4/Gx@orome>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59573bcd-757d-4014-ef6c-08da85fd7ce9
x-ms-traffictypediagnostic: DM5PR12MB1723:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q1pTGqa3bT5c8y+lpWM5eDy7f8OE8O7VlCnNvbO1hs5kMFtfg3WpetwR0+LxLcFpYMDX89wUld4SxE8tT2IRZ53opUd2jHsZnrRLB1jNZVGUmXf8PSU/QYCNPEXK0d/7svJ6GTG/ZnpdngFF8qm0QwP8KxsCKY528P52B/EmpkVWaPcWlpCJOx+y4io5fk1rWpBsGGz2LtaS0OZmQplN9NEkeg7sBkjv+lYG8ut6L8Ye8fDOHUXXNg068vh/JTcIC/GYDV2hgLziCrfEpCFekJ9cYI6xzaSth2izeU7oX5yiZJwvJKPMy+2pfQwEKq0129OdCqQUGbNwBlfNh+ImqHQBysbZusAzV1iOm/fZzMKbtAC6iHkmPKCQJ4umaRWmRbEdYGgFEiKyrwaK/O+hE0RF+izXtfg6TSvYiTuWVIhPnltl8nc9KJEhYfBgGAsELKjTNcc2A4yP//kM08Z+oksgKyijtyjawncuwVprJzqIN3QvH/gqbFl/M/+/9ZsLF3oH/vg290+dHtdrOs2j9QUq8/m5oXcx9/bC4dzCRoRuDlyx9XQeho9E05o1+t7+ANPzrCUToPWf0GHfLsjidkOr8xiJtnLP6h4DcTtzUTv8OgzgTz4Jz6tUw1O8knHpYcmrKtA4QMAHmCvD+cR2ZQ/5tXFuGAonNFQ9c2HYLGw3pwg8bB7NYvvjNamVfvLzbAgBZP2/793kQilbxgbiktDl0bKveUYAXpBSjBv/zbPzyXf2MpQtEFpBl3cO+fVxJ6HK2PM3jmdEec4gT7YdTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3164.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(122000001)(41300700001)(5660300002)(55016003)(71200400001)(38070700005)(86362001)(76116006)(38100700002)(2906002)(33656002)(8936002)(186003)(9686003)(26005)(4326008)(6506007)(52536014)(83380400001)(7696005)(8676002)(54906003)(55236004)(66946007)(64756008)(66476007)(66556008)(316002)(66446008)(6916009)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NhT077iLgPyGSoQD2FXxMqaBGBOK6kf04M6jjBZw1XR+uozONpO4nsWVv/zv?=
 =?us-ascii?Q?6B5x3N3S/QzDRLzRzyOQoHVKzejPtH+mO1tLsy5HKYfu0EgU9V2NWoB4xU0z?=
 =?us-ascii?Q?IovhrIueNKOOqgzyXJSDmLIbXhtKTGCFy/B6Nqm8YBFLTPo3hD6IFKM9urHj?=
 =?us-ascii?Q?hE6cc2I8rrQFLwceL7mzBGvnH89SatpGQ9JNM6Y4ejgDcYTbaC0X3EYBJHmE?=
 =?us-ascii?Q?TeeWUnqjsk7jfH2rvCsh4OAcz0fgxzLZfkCp1M6pxC6nyh0yBVfVqFYx09EX?=
 =?us-ascii?Q?iZkKjHJpx28v/KaLmMBP8Mc1XKdTpPREbpl+JOsGpkJrWQL7l1e3SbahRxPt?=
 =?us-ascii?Q?fipNhC5V3rCM5wQs2boKNXHzKlFv0AQ9fxHfy/AVT2ffsH9jPulE6gzbTQVl?=
 =?us-ascii?Q?86994H0YY1VqFOXCpuy4ONB0P1qyNwNcuTMpo0J9OKAgtvOFPxJRvvdwMp3k?=
 =?us-ascii?Q?dW2EvVPGGL+5nehf+CWOthKtQNriERRuWvIcuT6y1vIJqgBKQZCjRV2XD4GT?=
 =?us-ascii?Q?m7j0NRLgqbiMAV+jLzzrqv8zsQNazrP9X9yQV2pb/L4yPFXgn1jjAwUbywMz?=
 =?us-ascii?Q?rSlJ3WvQ/vNGQnJeuTyyRmDh7bae8e53lIl1Ltv5fGt8bwF9NI9EUEO2+lPe?=
 =?us-ascii?Q?wEsp07+NRYk5P6RzIOnPsh1YrW6eeN+AIQl2ikccKbCSEXOz1s7d5DnuJbET?=
 =?us-ascii?Q?ZPVlolxZ5rqIsv5jbB3ohvaXcVsF2huAzw4FeUp5dhUbDjbuNE84SYhLvaBY?=
 =?us-ascii?Q?UdDu7Eh2BOzeUCTIiQRkk+Bj3g+qRB5GxU8nwVZ4pbOWevM0fyxwUsR8j+h5?=
 =?us-ascii?Q?jzzjTidm6QWVOGZU6/nOJChdCB2JTeA9M7hlP428jt1bNW9thkLVAzK/aa2y?=
 =?us-ascii?Q?CZc9lW6akxM/stkRBgsV7xTLovBLEaxZpW/MDxkxC3N6MiiIdCZh2NKsU5RJ?=
 =?us-ascii?Q?hUGltJtEqqJ7N/IhyBgjZt5OfaX+VSRuES/M9zJ/9jUmUQG510FMSjsVPmcY?=
 =?us-ascii?Q?NF/dpq79VUCkahXHXnNOGQTDNrH0Lw+fjPNw0INfkkjPdkIEXBpzgNHgyuJl?=
 =?us-ascii?Q?27mV66OCkzqwS/i8AI+7ZhoyeO+be02h+iCQkM7PdUhzpvbuUGMfE63kq2js?=
 =?us-ascii?Q?j1+x3iZ6bJf/XX7ttTxBJWoWqHJvY3pklbwp/nD+WwtBeWgUbisXSd2LAJ2v?=
 =?us-ascii?Q?lNaC/40ofS1wNjPBHG3yw7bFDjkKWUIvFpLvLS6S0qIkmo9Gd1zF5NbJIVe8?=
 =?us-ascii?Q?hBtQz6ugkCm7w1oqgeTO0EuL2bhb0005ZEWAJOaRHrOM2tLE3H1VI31epxXO?=
 =?us-ascii?Q?8Bu9mlbsatW5jodeFGqsgClyMTFEqLX+XjyKD02LSRAsrHxsYQkPuvgghzx1?=
 =?us-ascii?Q?lfnVqbcYbXTF2V0Mz/IOseEo/5CYu6tBW2zQMkawGgDLWF2mQHffnQDj61qW?=
 =?us-ascii?Q?8awcC0GZbgZkIzXPTR0TKR/kFIX/tRdMirION1lzdnz1ryYBAFL1dAArd9Bm?=
 =?us-ascii?Q?0TGSYXRRQfD7ZsQipxuDzB5y9n0/DFR0wl+bs1bOqV9o4nN+T3AWlUN+va3i?=
 =?us-ascii?Q?ZgFMbuUhN8W9CYW1Mk1X7CvWHvw8WccvX9bl5HHF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3164.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59573bcd-757d-4014-ef6c-08da85fd7ce9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 18:21:39.4960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O2VeO/JL43YtoyqjOpVuP4H622toM1XpytcJFD91N3TChMKplhelYijbafA7YF8MOSY7+U+ryVD67lVarTys9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1723
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> On Mon, Aug 08, 2022 at 08:14:20PM +0000, Petlozu Pravareshwar wrote:
> > Add IO PAD table for tegra234 to allow configuring dpd mode and
> > switching the pins to 1.8V or 3.3V as needed.
> >
> > In tegra234, DPD registers are reorganized such that there is a
> > DPD_REQ register and a DPD_STATUS register per pad group.
> > This change accordingly updates the PMC driver.
> >
> > Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
> > ---
> >  drivers/soc/tegra/pmc.c | 109
> > ++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 105 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c index
> > 5611d14d3ba2..34d36a28f7d6 100644
> > --- a/drivers/soc/tegra/pmc.c
> > +++ b/drivers/soc/tegra/pmc.c
> > @@ -266,11 +266,22 @@ struct tegra_powergate {
> >  	struct reset_control *reset;
> >  };
> >
> > +enum tegra_dpd_reg {
> > +	TEGRA_PMC_IO_INVALID_DPD,
> > +	TEGRA_PMC_IO_CSI_DPD,
> > +	TEGRA_PMC_IO_DISP_DPD,
> > +	TEGRA_PMC_IO_QSPI_DPD,
> > +	TEGRA_PMC_IO_UFS_DPD,
> > +	TEGRA_PMC_IO_EDP_DPD,
> > +	TEGRA_PMC_IO_SDMMC1_HV_DPD,
> > +};
> > +
> >  struct tegra_io_pad_soc {
> >  	enum tegra_io_pad id;
> >  	unsigned int dpd;
> >  	unsigned int voltage;
> >  	const char *name;
> > +	enum tegra_dpd_reg reg_index;
> >  };
> >
> >  struct tegra_pmc_regs {
> > @@ -284,6 +295,8 @@ struct tegra_pmc_regs {
> >  	unsigned int rst_source_mask;
> >  	unsigned int rst_level_shift;
> >  	unsigned int rst_level_mask;
> > +	const unsigned int *reorg_dpd_req;
> > +	const unsigned int *reorg_dpd_status;
> >  };
> >
> >  struct tegra_wake_event {
> > @@ -364,6 +377,7 @@ struct tegra_pmc_soc {
> >  	bool has_blink_output;
> >  	bool has_usb_sleepwalk;
> >  	bool supports_core_domain;
> > +	bool has_reorg_hw_dpd_reg_impl;
> >  };
> >
> >  /**
> > @@ -1546,6 +1560,14 @@ static int
> tegra_io_pad_get_dpd_register_bit(struct tegra_pmc *pmc,
> >  	if (pad->dpd =3D=3D UINT_MAX)
> >  		return -ENOTSUPP;
> >
> > +	if (pmc->soc->has_reorg_hw_dpd_reg_impl) {
> > +		*mask =3D BIT(pad->dpd);
> > +		*status =3D pmc->soc->regs->reorg_dpd_status[pad-
> >reg_index];
> > +		*request =3D pmc->soc->regs->reorg_dpd_req[pad-
> >reg_index];
> > +
> > +		goto done;
> > +	}
> > +
> >  	*mask =3D BIT(pad->dpd % 32);
> >
> >  	if (pad->dpd < 32) {
> > @@ -1556,6 +1578,7 @@ static int
> tegra_io_pad_get_dpd_register_bit(struct tegra_pmc *pmc,
> >  		*request =3D pmc->soc->regs->dpd2_req;
> >  	}
> >
> > +done:
> >  	return 0;
> >  }
> >
>=20
> All of this looks "bolted on". Can we not instead rework the existing reg=
ister
> definitions to work with the new dpd_status and dpd_request arrays? It
> means that we'd probably need a bit of duplication of data since we would
> no longer programmatically determine the register offsets like we used to=
,
> but it would save the extra flag and make the code much more readable, in
> my opinion.
>=20
> Thierry
Yes. Agree that we can rework the patch to make the code more readable and
to save the extra flags. Will update the patch.

Thanks.
