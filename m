Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA614F6684
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238077AbiDFQy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238339AbiDFQya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:54:30 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3743C2A9138
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 07:56:27 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id z12so4522757lfu.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 07:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nNVtA40oQHM0eOGId5yNo8xiVPzOWuJpNkMLS3feFc0=;
        b=muU3faxErilQjUnsrCmgyj60U8GEHYstiuZuK2DRn5NgDG38ZnUH2qyP1UUrECX3MF
         WmBZi7gaaPPLqwNdDPrVdXTcSmplJbHbgh7dAwcBtWX/0PB/R1FtVVWyWeWGBEqa2Dt5
         qG4ww8t31zd7uK0muC6tgclP5/Yb4MErHKHGy57IcxecvvLTVwjgGdDoiLVwREVFUg9y
         qj1fZR5zwQOmSapyD6wZHha26vwyKIvj3KzYUIgFb7ngPFmjjjKsN5wjhp8rBli8wxn+
         jMiEj/l4Z+MHIARTLbk5ZzOTCR0hyNkQdkDS6V8wfPzPaiK3cfJ0Y6mz+zyOLTdp3QSo
         2ovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nNVtA40oQHM0eOGId5yNo8xiVPzOWuJpNkMLS3feFc0=;
        b=6E8rtNMWLY+Q0O8vu1HExVJInnQetjVLArqhV4BnPVqG+THPNRQN18tNRopGt1JKm8
         wgGfeIUICe23R8EWGRpc1hFWNikcF95FU3Uog7f4y9zB3vghhO7W2bWGd7l2k2eAlh3z
         /KA6ql6D2nKm3Vbl7/2dby8vstIwhwJaPiDoJXUwg+gFvOa3I7hbWwBk/fDy9A3p8xKC
         +emkYfZnEtWpk8NJof+FnZyHcxWQ8TTnl2daN3vQlJRZG4twU0dogqq2UNwLsK1QXU1Z
         b2GovUq/vXaGrQteAmmspwozxv4TFRn+xNlXR4rb3yKlEfhfP3OaoGhPxw2IfRPrRhXC
         LMKQ==
X-Gm-Message-State: AOAM532QW7DbRsLWAf4IXDOrgzuV11+HgP7t8ShPmqqxRX5weN11iKVw
        yV7FrP3FbQlCzHCWQ6Zk6jedVxy42ULAfcyZrJNzhQ==
X-Google-Smtp-Source: ABdhPJzKPggqZccGIT2HfZeUDHW9yOnVHP5ILJl0MafomwBwwOiE+fVEx0WmfbRtpslMc/dD7zdERcTgRqXSNkmI4QM=
X-Received: by 2002:a05:6512:c0c:b0:44a:6865:860a with SMTP id
 z12-20020a0565120c0c00b0044a6865860amr5978705lfu.71.1649256985512; Wed, 06
 Apr 2022 07:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20c6efa9a4c7423bbfb9352705c4a53a@hyperstone.com>
In-Reply-To: <20c6efa9a4c7423bbfb9352705c4a53a@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 6 Apr 2022 16:55:49 +0200
Message-ID: <CAPDyKFod9iFyOAByt3C1G4qxvDYGOk7xsSqi0+Yh+W43eDZKxw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: mmc_spi: parse speed mode options
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2022 at 09:28, Christian L=C3=B6hle <CLoehle@hyperstone.com>=
 wrote:
>
> Since SD and MMC Highspeed modes are also valid for SPI let's parse
> them too.
>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/of_mmc_spi.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.=
c
> index 3629550528b6..bf54776fb26c 100644
> --- a/drivers/mmc/host/of_mmc_spi.c
> +++ b/drivers/mmc/host/of_mmc_spi.c
> @@ -70,6 +70,10 @@ struct mmc_spi_platform_data *mmc_spi_get_pdata(struct=
 spi_device *spi)
>         } else {
>                 oms->pdata.caps |=3D MMC_CAP_NEEDS_POLL;
>         }
> +       if (device_property_read_bool(dev, "cap-sd-highspeed"))
> +               oms->pdata.caps |=3D MMC_CAP_SD_HIGHSPEED;
> +       if (device_property_read_bool(dev, "cap-mmc-highspeed"))
> +               oms->pdata.caps |=3D MMC_CAP_MMC_HIGHSPEED;
>
>         dev->platform_data =3D &oms->pdata;
>         return dev->platform_data;
> --
> 2.34.1
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>
