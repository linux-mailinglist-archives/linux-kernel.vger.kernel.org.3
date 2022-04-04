Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12854F141A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 13:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbiDDLzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 07:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbiDDLzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 07:55:04 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993A03DA42
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 04:53:07 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id h7so16793496lfl.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 04:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3A/oOMPD4XhOt/XR7K6ZNebjmgt1JShjHVFeP98tYIw=;
        b=TJsHrAXtCsP3ZTaG5wYQoCQEXINE0XxNfvPqpNKPD4oTQvZ61EEsNQIsRrSjLW2Km0
         ohh3zbXkYcj+sf0nfdtCRoKH8PXFKCaZzUHTMkRzml8SSHKBOq+WV7ho3UWW/zZgG/qR
         T+2fgspN6Gs9T30v9hZaYuaXMVe2dmULoZSJfbSlxKJAC/MMMqhL/AL49OiEbh/SVfYd
         5c0lcKGxr7a3gbVLI/1b5YnE5vZeN2EvIjKXKAtxjeqrEWck5+LNrynS3q4BGGCLJxM3
         EY0Om7RHVkuzn9VxIn1UlXpcGKoY2T4Cn8iukEdafIIg6KEsfSackcSyL0ebZN3aKBKV
         TcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3A/oOMPD4XhOt/XR7K6ZNebjmgt1JShjHVFeP98tYIw=;
        b=qHajwans1tz0hO8PvDd1yP0WyVu+9asUKipqytdFXo+tB1xxmWYUSIHxZtzamoXLOm
         MzT+KKxDFXqUWSFcmnTZfDJWRLxyUxTy6vCtpK5DMoReDJMPlxem7Zne8RueqKGm3jf9
         jVrDBHu3lIL8sXZX9tegpmrf7coQtOR07jwkF7HsZcoOeUg3JOLJ4HPgOX6eTjv7m92i
         SEIBAT6q+Vnsfgc+EnodBqooOm2MLp35jcmS7tOOv/WbxnLPGqjYVSHQl2GtIH4HVagF
         19WiNxmHTYKtL+gy486Cg64u2MVQSFgQynWqZNXunv4vNbaYEyGAcbL9zgS5DMHA6ROF
         WI4A==
X-Gm-Message-State: AOAM533w2rYpsuJNKgyIKTcGMmdUbii26nIBIOKJC+Wd9MpTYW+wiOcW
        A5dgUyMhjjP+kWLL1z/Pxk+CWh7GBOgnnvYLI0m8Eg==
X-Google-Smtp-Source: ABdhPJyMVGHHaXWF/0a/XIFD/8k8S91lYwACGmvnMEkn/htKK6kKQlitGYTnTxtN67HD2nJuz2E5v8jUABPlbDjxB0I=
X-Received: by 2002:a05:6512:b19:b0:44a:b7c4:3d94 with SMTP id
 w25-20020a0565120b1900b0044ab7c43d94mr19148829lfu.358.1649073185832; Mon, 04
 Apr 2022 04:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220331073223.106415-1-michael@allwinnertech.com>
In-Reply-To: <20220331073223.106415-1-michael@allwinnertech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 4 Apr 2022 13:52:29 +0200
Message-ID: <CAPDyKFq4yowT_t_y_fg9vqgyr=qVykWeOux8H6CGZDyn0M5JhQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: block: enable cache-flushing when mmc cache is on
To:     Michael Wu <michael@allwinnertech.com>
Cc:     axboe@kernel.dk, adrian.hunter@intel.com, avri.altman@wdc.com,
        kch@nvidia.com, beanhuo@micron.com, swboyd@chromium.org,
        digetx@gmail.com, bigeasy@linutronix.de, CLoehle@hyperstone.com,
        cjb@laptop.org, arnd@arndb.de, andreiw@motorola.com,
        tgih.jun@samsung.com, jh80.chung@samsung.com,
        linus.walleij@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        allwinner-opensource-support@allwinnertech.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2022 at 09:32, Michael Wu <michael@allwinnertech.com> wrote:
>
> The mmc core enables cache by default. But it only enables
> cache-flushing when host supports cmd23 and eMMC supports
> reliable-write.
> For hosts which do not support cmd23 or eMMCs which do not support
> reliable-write, the cache can not be flushed by `sync` command.
> This may leads to cache data lost.
> This patch enables cache-flushing as long as cache is enabled,
> no matter host supports cmd23 and/or eMMC supports reliable write
> or not.
> For SD cards, backwards compatibility is guaranteed. Newer components
> like SD5.0 which have cache are also supported in advance, which means
> this patch will also be applicable if SD5.0 cache is added to the mmc
> core in the future.

SD 5.0 cache support was added in the commit 130206a615a9 below. No
need to resend, I will take care of updating the commit message.

>
> Fixes: f4c5522b0a88 ("mmc: Reliable write support.")
> Fixes: 881d1c25f765 ("mmc: core: Add cache control for eMMC4.5 device")
> Fixes: 130206a615a9 ("mmc: core: Add support for cache ctrl for SD cards")
> Fixes: d0c97cfb81eb ("mmc: core: Use CMD23 for multiblock transfers when we can.")
> Fixes: e9d5c746246c ("mmc/block: switch to using blk_queue_write_cache()")

I will have a look at the above to see what makes sense to add - and
then I will add a stable tag too.

>
> Reviewed-by: Avri Altman <Avri.Altman@wdc.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Signed-off-by: Michael Wu <michael@allwinnertech.com>

Thanks, applied for fixes!

Kind regards
Uffe


> ---
>  drivers/mmc/core/block.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 4e67c1403cc9..ec76ed82abb9 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2350,6 +2350,8 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>         struct mmc_blk_data *md;
>         int devidx, ret;
>         char cap_str[10];
> +       bool cache_enabled = false;
> +       bool fua_enabled = false;
>
>         devidx = ida_simple_get(&mmc_blk_ida, 0, max_devices, GFP_KERNEL);
>         if (devidx < 0) {
> @@ -2429,13 +2431,17 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>                         md->flags |= MMC_BLK_CMD23;
>         }
>
> -       if (mmc_card_mmc(card) &&
> -           md->flags & MMC_BLK_CMD23 &&
> +       if (md->flags & MMC_BLK_CMD23 &&
>             ((card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN) ||
>              card->ext_csd.rel_sectors)) {
>                 md->flags |= MMC_BLK_REL_WR;
> -               blk_queue_write_cache(md->queue.queue, true, true);
> +               fua_enabled = true;
> +               cache_enabled = true;
>         }
> +       if (mmc_cache_enabled(card->host))
> +               cache_enabled  = true;
> +
> +       blk_queue_write_cache(md->queue.queue, cache_enabled, fua_enabled);
>
>         string_get_size((u64)size, 512, STRING_UNITS_2,
>                         cap_str, sizeof(cap_str));
> --
> 2.29.0
>
