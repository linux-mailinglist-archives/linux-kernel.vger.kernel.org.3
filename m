Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1C44D4895
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 15:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242662AbiCJOIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 09:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbiCJOIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:08:43 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFB813F55;
        Thu, 10 Mar 2022 06:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646921259; x=1678457259;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=IXol7EFlAnEQyMY1defFk1up4tfBFOzWebrdeY38Ac0=;
  b=h6mReeZkS2zMF9M3WAuoOAvJMz/S+1GGGFB+IUBUDIfvwXpz96Mvzn16
   dUOgk96WMB72AUoQJC/kJ0DNDaNmF2fTba5prh12gAjE5T4tysn249/rn
   KmLEjPnOkfnN0ZhwNAJBFAeGkoB/CCtIfTDBxgHeOVEaRnXtDb3wkITmh
   BQei0DYl9GNwA8v9gHavKGmmy89GQhR5M8Nt9/PrrVHcNa2Yg7BfZqeRk
   Mfne9qKsaio9w9q5Rp95noJ/UASpR4tfO+SxQU7beGVJHXgde4enS40KJ
   4R6gpNj8XkdQJe3MAnGcJomsFhUeOWBMeXnNuj2PWioN8PQ/f3AnZ+m4A
   w==;
X-IronPort-AV: E=Sophos;i="5.90,170,1643644800"; 
   d="scan'208";a="299114601"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2022 22:07:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPRWI6zY0PFGk0ZVs6AhamfPeqosz+u9aX7QnlwU5Phfkv/71nVnqmyMCek44FYiW9gHHA0sjnbccv2ckCWtIulDzSlvbPi2JaJT2+Ix4WerJNDfELdRrgMqd7ncjZ/AcSrKNd0ckfkKJk8M+jFfnwwJ+CHasozBEECjMh4ZQbGpcfWtd31J4JD1yvpmNET8UTV9zB+5r14hBopXJ+P0f0fxMMQxOEDnF40P/cufOrJszQ/cXd5hbiKIqVPYsw45qX14ZsUDgmQpDFA3deqGp8AuXE8utkz93+oEsEoPFq+LYO5DNg64Q1xyJRzAbBmcLLSgKcXQ0lPCy8tP+pONNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBRockZZhhDd+1Zp09+6B3tnBAB0wtu57yqBW8gd+Pg=;
 b=S7sBaLw8rJ1W/mZ9yxJt/wocrIm+tTuxqdyyrPzdTALgE6H0OO73dVGckiUHvxla715Eh9GVC5xpOGFLQ69FyF/WCHwp8N6Lq9dUFium1Lp5fU1S0UrJSt3dB3t7NNL0NcmFZmz55roO8qhuJ2inlC8634w3c1Dmri4FRj+NGGMVGHbclA7WPMfLVnwl5icZIRNLJbQwba11VUehymxiqWh44WIrx8XlW1Nzc3ZnN4/foCZIMd14tcNQb+aBjtHOw+8JKO24O3LXQWJnyBTOeZvGVpJqwD/KD1WyG5FFkLt4jvDk+hGd+h+1jmqbPfeNnpRS8ZGvyNpr2FiKARwglA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBRockZZhhDd+1Zp09+6B3tnBAB0wtu57yqBW8gd+Pg=;
 b=EiER3yDj/gA5cwzg65ua9B9OPKjTJCnA6Ug3TJ5sbdn7SRTppt8YRjcPvi4Iv1k5aM81Vy1KB0RWDUW5HnIELXkFvZVoTZU1cRrYx6mCukXoars7lHxhZo9vi2hh2pPLSwZvu/LkuyfFGWQBXRFkjGKfAUO3kuEI6zixpn8R+q0=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CY4PR0401MB3586.namprd04.prod.outlook.com (2603:10b6:910:8e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 14:07:34 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::941d:9fe8:b1bd:ea4b]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::941d:9fe8:b1bd:ea4b%6]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 14:07:34 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Marc Mattmueller <marc.mattmueller@netmodule.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] mmc: core: update life time and pre eol info values
 on sysfs read
Thread-Topic: [PATCH 1/2] mmc: core: update life time and pre eol info values
 on sysfs read
Thread-Index: AQHYM6IoKrsVePC5nUqXoi2eisjYGKy4qJdg
Date:   Thu, 10 Mar 2022 14:07:34 +0000
Message-ID: <DM6PR04MB6575908B2D0F065EAC721878FC0B9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <cover.1646820083.git.marc.mattmueller@netmodule.com>
 <5fe56c7fe12d48996ba557596b16b1cd0adca6a2.1646820083.git.marc.mattmueller@netmodule.com>
In-Reply-To: <5fe56c7fe12d48996ba557596b16b1cd0adca6a2.1646820083.git.marc.mattmueller@netmodule.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd283be1-f715-4a7f-1f24-08da029f535b
x-ms-traffictypediagnostic: CY4PR0401MB3586:EE_
x-microsoft-antispam-prvs: <CY4PR0401MB3586370E5C44C7AC8533C96BFC0B9@CY4PR0401MB3586.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W7VQKHBrvcLy/DU0ZTkYuzDV84+uRjbnaPEOmLaE1yl7+kNJKDgoxijwpXDdBVYpZ8Jc7WMeTQRVcGwkXpy2HTvVFcSwhVLv8BfCeHsEgTmLw0yII9S0OXfkcaM+izdyc+ru8hq0gU6qH3dYHIuwCD6kO/XTSpnbHgtmSiH5QVoNJHI/wxX38ZaFWM0De5mNp8/ki1R5pZjGQAUdOUh8n97fYi/GE320zrSTrxPql7QH3Cacq5Kcd/DUy/Qo9XchfDhuIYznn3sblyfv/+qckFW+TxZ7bTC2DxpH8r5Gu2Gz5lWhNS3MZe2yhHcULFJCWCNouHJxmGdY+VRsn5f9TjKklfEyvBjHxX5c9dFU4jCigneNfoNg1EVc7J0ERRp0YlZQTzgmxjRZ/f2fh+OLNobhhCRwzsKGCa839MPlI3EQJup12+YYscTewEnbalPB/46hSyGHBQ8b/3dSed5uMTyZIWkW0+s0+gN3VGtLlMYjEVOrcNtPB72nQbXGMi5aBU5mbe0Cz4we1LKR7LqdRXh4h+ZVe37HvW/hzTxjkdnkSMmShQXpKDGxHMXgi5VRJI381RqtTO+S6o/LAjS4sT/WKy1s02TljVbdL2zAnPm4IM6kNtWGV1B95Paf1WHdi9x3/eO360WRdlbx/6KHCnwKmLFcIrxt14hzuChNRjUeqmscT24cuQdlQwBED94UWn9NtJwd6hdDrDpa9BOgFQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(8676002)(66556008)(66476007)(76116006)(66946007)(64756008)(38100700002)(66446008)(55016003)(7696005)(6506007)(9686003)(83380400001)(38070700005)(86362001)(186003)(26005)(71200400001)(316002)(508600001)(8936002)(82960400001)(15650500001)(5660300002)(52536014)(2906002)(122000001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vw4woPfuKwg6Hl8yeDDUkhpb75plxe8wiW7jtM1KFSEzv6H79MPlP7CoPnlu?=
 =?us-ascii?Q?nVQohqN4JRW7vKC+XXEPul5kf2aydr7aBdXw0CsErwyBVqbfV1bhwjg3ooAn?=
 =?us-ascii?Q?d44Af3Fo4br4lrjpjYaPOuykqgXUSNPrJSZpmUgr6eOyVPraPfTWuS8usfZ5?=
 =?us-ascii?Q?9FobeIGesPV3nOkciQMSBbgUmk8qcvYn94Jr9vjoxJXJ4JC9si0HlQYErYzc?=
 =?us-ascii?Q?iivVvskv7LRRi3EKwWCx0a3P6+yqGWU4QiZdv8K8BMRBMsrWMymfSzXK6Ko7?=
 =?us-ascii?Q?tQfg4jK6MhJVoFdDod+T3cT+81ByEF8XPoKsEpQDk3M+52GyqV6fT6la6Nuo?=
 =?us-ascii?Q?3qe3LLsxJvSPJct+wPA4HBprg6T1FSlIIk9TDk8dtk3bnbJ3hU0Uydou1sMI?=
 =?us-ascii?Q?/b5qKIDC3HHL9U3cZ+LfH6/I2i65/KbZ1xJx6x3vaxS+CuStORlJjiC29HrL?=
 =?us-ascii?Q?8HWix9dYPHDAzCxPtZCL9IZUs7FGLaRaumhUUF9Ylt7WDebXeRZippXRP3Fu?=
 =?us-ascii?Q?V+1YdNhPrgMM/3r600t/eQtYH6Op7xxt/9DbEJh5RlzEbiGBEJdFUMF0Fn9E?=
 =?us-ascii?Q?342Nqqk10O3ATtQw4EwDMYGAGjj2b1UDp9v21DPBwy0tj3aC2il/57S+0Mx+?=
 =?us-ascii?Q?9XPjgP0RoaYl1Pm187EDCuznRB4TCyNwRXJQQYzbXkaSS8sk2z+QXyaBTo/o?=
 =?us-ascii?Q?ZmVyMxN5liUSMPj2HEEsj2IVSyYKA6u9O8ForAf+E9OWLthmyOZKhqpIusRT?=
 =?us-ascii?Q?FhZvrwIuSeTe2Q3mEyO+YbB1QTVxA+73R3vwlmxPP9pdVFMz7szjQiputtj/?=
 =?us-ascii?Q?G/wxyTww6MFoS/feJQxv3UjUdyAwFJ3o5P42UK1fp6a8ad/63lKUcUnahBfU?=
 =?us-ascii?Q?LWfGILeauouWYVqcjR/9lrhDbQ3dcvjnnZSk9t+G6ywzVWXRiVUfZhDJ5NXP?=
 =?us-ascii?Q?W8vH4+OT3h0xT8exKrLEeEgYO8Lj2HUHRBd++JKhS3qDJ4j3gawxDMs+0Tqf?=
 =?us-ascii?Q?JN9ag4olNo87bN85JHXlavUPjQdvdYmchLHwISouTzn5c4xhDoBWNEHTue0t?=
 =?us-ascii?Q?obiTh4jMzNsXXDFe6aSWLd01htKMsPtQ1/BgammGsaSAclvcWhwWjxLMeUEW?=
 =?us-ascii?Q?/iBUyOheHEBFTn3OfQwg6Ds33HUcPbEaxd4JKv7MT8T0AEY9NYMOugRTxm1I?=
 =?us-ascii?Q?1C0Fvq9hpbGlxbM6xb9yk7reIwugPZFo1rBiTySwPncNvNv1lVBPLXaTzmqX?=
 =?us-ascii?Q?6Y3/JUjVV/XHkgNzq9SoccOwT9gRXaWmLeSP21bf+Sn055+Q7WUS3gMD76qr?=
 =?us-ascii?Q?K4BYdbUlc73RwBc3ioPqtLoRPZDMrNum/voKbV6HJBbcTEXazrw6dCsyogE3?=
 =?us-ascii?Q?Q6CAk7+uRCZM1rHWFA8jdnLpggLGMOVDR3GnHVPl8/ycJPUM7NTiUCDcxGoZ?=
 =?us-ascii?Q?V1PjrqM5ZOzJFTo5KODhRHL8viVUbsGu9c5NZ3G8ht7uCbb7SqAkXGHy4y0b?=
 =?us-ascii?Q?P+aSBaVPXSuxsISGL7W8r0bq6mQH2Tzc2SOa4dty3Q6xKD76XwfQ9VD8DhXJ?=
 =?us-ascii?Q?B2CYJ0Xq9kzFSKTjKfINOpqZrG9aNpMqdl9xw5ka4vZsiw/RpwnZVvOA0SXU?=
 =?us-ascii?Q?Mg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd283be1-f715-4a7f-1f24-08da029f535b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 14:07:34.7257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /GqKfQkWoPUPHjQwQ/wBUSxK/ZmQOFPRRDY4kNUIlUvPL+MDvE2/9INW8l1pBWDnwa1Tcet8J5pUGlciPZF2BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3586
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
> The mmc estimated life time values and pre-eol info values were only read=
 at
> start-up and were not updated on sysfs read.
> Thus, added update of the ext_csd structure on sysfs read of
> device_life_time_est_typ_a, device_life_time_est_typ_b and pre_eol_info.
I agree that a snapshot on init doesn't make much sense.
But you can read it using mmc-utils, why not just remove the useless entrie=
s?

Thanks,
Avri

>=20
> Signed-off-by: Marc Mattmueller <marc.mattmueller@netmodule.com>
> ---
>  drivers/mmc/core/mmc.c | 87
> ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 83 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c index
> 43d1b9b2fa49..d9537c894e33 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -357,6 +357,25 @@ static void mmc_manage_gp_partitions(struct
> mmc_card *card, u8 *ext_csd)
>  /* Minimum partition switch timeout in milliseconds */
>  #define MMC_MIN_PART_SWITCH_TIME       300
>=20
> +/*
> + * Update extended CSD parameters changing during runtime.
> + */
> +static int mmc_update_ext_csd_runtime_params(struct mmc_card *card,
> u8
> +*ext_csd) {
> +       int err =3D 0;
> +
> +       /* eMMC v5 or later */
> +       if (card->ext_csd.rev >=3D 7) {
> +               card->ext_csd.pre_eol_info =3D ext_csd[EXT_CSD_PRE_EOL_IN=
FO];
> +               card->ext_csd.device_life_time_est_typ_a =3D
> +                       ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A];
> +               card->ext_csd.device_life_time_est_typ_b =3D
> +                       ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B];
> +       }
> +
> +       return err;
> +}
> +
>  /*
>   * Decode extended CSD.
>   */
> @@ -367,6 +386,16 @@ static int mmc_decode_ext_csd(struct mmc_card
> *card, u8 *ext_csd)
>         struct device_node *np;
>         bool broken_hpi =3D false;
>=20
> +       /*
> +        * After once having initialized the ext_csd structure, we want t=
o
> +        * update only the changing parts. To check this the revistion is
> +        * taken.
> +        */
> +       if (card->ext_csd.rev !=3D 0) {
> +               err =3D mmc_update_ext_csd_runtime_params(card, ext_csd);
> +               goto out;
> +       }
> +
>         /* Version is coded in the CSD_STRUCTURE byte in the EXT_CSD regi=
ster
> */
>         card->ext_csd.raw_ext_csd_structure =3D ext_csd[EXT_CSD_STRUCTURE=
];
>         if (card->csd.structure =3D=3D 3) {
> @@ -791,10 +820,6 @@ MMC_DEV_ATTR(name, "%s\n", card-
> >cid.prod_name);  MMC_DEV_ATTR(oemid, "0x%04x\n", card->cid.oemid);
> MMC_DEV_ATTR(prv, "0x%x\n", card->cid.prv);  MMC_DEV_ATTR(rev,
> "0x%x\n", card->ext_csd.rev); -MMC_DEV_ATTR(pre_eol_info, "0x%02x\n",
> card->ext_csd.pre_eol_info); -MMC_DEV_ATTR(life_time, "0x%02x
> 0x%02x\n",
> -       card->ext_csd.device_life_time_est_typ_a,
> -       card->ext_csd.device_life_time_est_typ_b);
>  MMC_DEV_ATTR(serial, "0x%08x\n", card->cid.serial);
> MMC_DEV_ATTR(enhanced_area_offset, "%llu\n",
>                 card->ext_csd.enhanced_area_offset);
> @@ -807,6 +832,60 @@ MMC_DEV_ATTR(ocr, "0x%08x\n", card->ocr);
> MMC_DEV_ATTR(rca, "0x%04x\n", card->rca);  MMC_DEV_ATTR(cmdq_en,
> "%d\n", card->ext_csd.cmdq_en);
>=20
> +static int mmc_update_csd(struct mmc_card *card) {
> +       int err =3D 0;
> +
> +       mmc_claim_host(card->host);
> +       err =3D mmc_read_ext_csd(card);
> +       mmc_release_host(card->host);
> +       return err;
> +}
> +
> +static ssize_t life_time_show(struct device *dev,
> +                             struct device_attribute *attr,
> +                             char *buf) {
> +       int err =3D 0;
> +       struct mmc_card *card =3D mmc_dev_to_card(dev);
> +
> +       /* before eMMC v5 */
> +       if (card->ext_csd.rev < 7)
> +               return sprintf(buf, "%s\n", "-");
> +
> +       /* eMMC v5 or later */
> +       err =3D mmc_update_csd(card);
> +       if (err)
> +               return (ssize_t)err;
> +
> +       return sprintf(buf, "0x%02x 0x%02x\n",
> +                               card->ext_csd.device_life_time_est_typ_a,
> +
> +card->ext_csd.device_life_time_est_typ_b);
> +}
> +
> +static DEVICE_ATTR_RO(life_time);
> +
> +static ssize_t pre_eol_info_show(struct device *dev,
> +                                struct device_attribute *attr,
> +                                char *buf) {
> +       int err =3D 0;
> +       struct mmc_card *card =3D mmc_dev_to_card(dev);
> +
> +       /* before eMMC v5 */
> +       if (card->ext_csd.rev < 7)
> +               return sprintf(buf, "%s\n", "-");
> +
> +       /* eMMC v5 or later */
> +       err =3D mmc_update_csd(card);
> +       if (err)
> +               return (ssize_t)err;
> +
> +       return sprintf(buf, "0x%02x\n", card->ext_csd.pre_eol_info); }
> +
> +static DEVICE_ATTR_RO(pre_eol_info);
> +
>  static ssize_t mmc_fwrev_show(struct device *dev,
>                               struct device_attribute *attr,
>                               char *buf)
> --
> 2.20.1

