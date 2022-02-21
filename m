Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6034BE7F4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354215AbiBUKML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 05:12:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352663AbiBUJ4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:56:20 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69910443F4;
        Mon, 21 Feb 2022 01:24:35 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id d7so30507696qvk.2;
        Mon, 21 Feb 2022 01:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NfLzYG7x5hWrxzh3aPbQ9F5T1m6I+7za53WlrcA8RHg=;
        b=TRVxoyTG2DYkX1CqX/AOQCl8MjLoZXTSrvOrHA6WfxVVOX2y5CdFMbwaDVMW+LVeeb
         mObzVMrLCuE+wAiN8TIVOviFEz0Szf/Pguz4Mgc/3HSPwDX3BDZrevH3kahBMj6QrjXb
         ZoencRJpPY4e4K66dWYBXJKt6X3gNJvrLwC5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NfLzYG7x5hWrxzh3aPbQ9F5T1m6I+7za53WlrcA8RHg=;
        b=PzU2BLxCGFuHbgBwqmC990eOI0O+/o+iAlZgPhyH1hkQVnqOb5cnd4zmEx+0Kw1j+r
         RYldKC/eNKK+ywbgrJJmDuOsapcakWbcLU4DxS40Db8HyeQtPPN8z0ExBaTn/hWvtMmy
         LVVpNiqSdHfjKj8dlUYnrbY7HUdDFeCVwkalT+gXVyLa+LezGu7FnqJbj/IkU3ryZi/M
         waJKLs4hgw5QiyIHLJVEF5N4v03WgKqyW1xDf5L271NsxKowzzzC0BzNQmSFve8m4JXQ
         sQ+3SXl3zVsal/mb3CB1OPbeXjsW6EbZV+LDD6MbcL0hYz1e6iItp8SkXsDzb0jd78G7
         S5Ig==
X-Gm-Message-State: AOAM530MHDyJBWdTsFS5P22zzOzQyjouDbaLTO2I1iI1pAZZbp2mJcmv
        L5m5zb65Vwpg2oupZ2HxVa8CrlQr6a7tHRXO/mU=
X-Google-Smtp-Source: ABdhPJy9KlKEyt6s72SDOXKeNCVDgTsHYzPzdxKYJL2f5Y/OKpVgI2rlT7MItO9kJmKriRxMRYZKSWvL/3gNIyoDRa8=
X-Received: by 2002:ad4:5ba2:0:b0:42d:64b8:52c3 with SMTP id
 2-20020ad45ba2000000b0042d64b852c3mr14533967qvq.21.1645435474500; Mon, 21 Feb
 2022 01:24:34 -0800 (PST)
MIME-Version: 1.0
References: <2c123f8b0a40dc1a061fae982169fe030b4f47e6.1641765339.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <2c123f8b0a40dc1a061fae982169fe030b4f47e6.1641765339.git.christophe.jaillet@wanadoo.fr>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 21 Feb 2022 09:24:22 +0000
Message-ID: <CACPK8XfxZRXtU0Bn+f0=B3CGUE8A8i9Ob_a9=2t=TzLc5a+75w@mail.gmail.com>
Subject: Re: [PATCH v3] fsi: Aspeed: Fix a potential double free
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jeremy Kerr <jk@ozlabs.org>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>, linux-fsi@lists.ozlabs.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Thanks for the patch.

On Sun, 9 Jan 2022 at 21:56, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> A struct device can never be devm_alloc()'ed.
> Here, it is embedded in "struct fsi_master", and "struct fsi_master" is
> embedded in "struct fsi_master_aspeed".
>
> Since "struct device" is embedded, the data structure embedding it must be
> released with the release function, as is already done here.
>
> So use kzalloc() instead of devm_kzalloc() when allocating "aspeed" and
> update all error handling branches accordingly.

This looks like a problem with the design of the fsi master structure.
It's a common pattern to devm_alloc the platform devices as they are
probed, the fsi masters all embed a copy of struct fsi_master, which
as you say embeds struct device.

Can we learn from other bus drivers (eg i2c?) how we should lay out
these structures?




>
> This prevent a potential double free().
>
> This also fix another issue if opb_readl() fails. Instead of a direct
> return, it now jumps in the error handling path.
>
> Fixes: 606397d67f41 ("fsi: Add ast2600 master driver")
> Suggested-by: Greg KH <gregkh@linuxfoundation.org>
> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v2: Keep the release function which is correct
>     s/devm_kzalloc()/kzalloc()/ instead
>
> v3: Update the error handling path to free "aspeed" [Guenter Roeck]
>     Fix another issue when opb_readl() fails [Guenter Roeck]
>
> I hope that fixing both issues in the same patch is ok. It makes no sense
> to me not to update the goto to the correct label if opb_readl() fails.
> ---
>  drivers/fsi/fsi-master-aspeed.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
> index 8606e55c1721..0bed2fab8055 100644
> --- a/drivers/fsi/fsi-master-aspeed.c
> +++ b/drivers/fsi/fsi-master-aspeed.c
> @@ -542,25 +542,28 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
>                 return rc;
>         }
>
> -       aspeed = devm_kzalloc(&pdev->dev, sizeof(*aspeed), GFP_KERNEL);
> +       aspeed = kzalloc(sizeof(*aspeed), GFP_KERNEL);
>         if (!aspeed)
>                 return -ENOMEM;
>
>         aspeed->dev = &pdev->dev;
>
>         aspeed->base = devm_platform_ioremap_resource(pdev, 0);
> -       if (IS_ERR(aspeed->base))
> -               return PTR_ERR(aspeed->base);
> +       if (IS_ERR(aspeed->base)) {
> +               rc = PTR_ERR(aspeed->base);
> +               goto err_free_aspeed;
> +       }
>
>         aspeed->clk = devm_clk_get(aspeed->dev, NULL);
>         if (IS_ERR(aspeed->clk)) {
>                 dev_err(aspeed->dev, "couldn't get clock\n");
> -               return PTR_ERR(aspeed->clk);
> +               rc = PTR_ERR(aspeed->clk);
> +               goto err_free_aspeed;
>         }
>         rc = clk_prepare_enable(aspeed->clk);
>         if (rc) {
>                 dev_err(aspeed->dev, "couldn't enable clock\n");
> -               return rc;
> +               goto err_free_aspeed;
>         }
>
>         rc = setup_cfam_reset(aspeed);
> @@ -595,7 +598,7 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
>         rc = opb_readl(aspeed, ctrl_base + FSI_MVER, &raw);
>         if (rc) {
>                 dev_err(&pdev->dev, "failed to read hub version\n");
> -               return rc;
> +               goto err_release;
>         }
>
>         reg = be32_to_cpu(raw);
> @@ -634,6 +637,8 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
>
>  err_release:
>         clk_disable_unprepare(aspeed->clk);
> +err_free_aspeed:
> +       kfree(aspeed);
>         return rc;
>  }
>
> --
> 2.32.0
>
