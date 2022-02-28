Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D504C7224
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 18:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238038AbiB1RGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 12:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbiB1RGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:06:52 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0188A82D17
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:06:13 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id b11so22460485lfb.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iCqSJLVmzSiAQCZuGWx3jdcx0OAjD7prrRZYblRmLXk=;
        b=biJj7wivuUwsykg3cCHNhf5pu9DOv2jbE6fUXHgxl5AXqJvtb2ehNXEpFdBsjf5qD4
         vkHTAQcKYQZBp7geavn1aVx7d+zborulBdlwD7Z9JRROJb12Mj6rRHX0cdfRhdrBzE0T
         /VohSnvjl3cAMBB76kxjvj0WUoNEYnotB2u9aY4x3HQ8MsPfk5guRYXgM9MGsq6586hO
         P3k48kII6PkFhXlZjZdrwpfYsUaBAhs1H81yb5JvQCu2e5fNvNljwd6rz18hGoRAllT7
         8vpUEGH8aPTJnoNzpFlbD5QQcpiY4id2uDJYhd0pnDZxqOyuc1WlmXodzzdBd3L88bUq
         P45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iCqSJLVmzSiAQCZuGWx3jdcx0OAjD7prrRZYblRmLXk=;
        b=vwVZ3i4ETIR2dCd4i/SKfdJSqNkvxhw5dVGqkMG2F2dKHle93AXe7nVyPgGj79KeY7
         tqCjevA7G0obEkAzQPraV4Vp0ma9Oxqq6CDWXkSnJOXYHgOMv/e+pSQL/0OX8FgImOrO
         icDdiOxoa4RPj8L0L9NHRng5HIymnxAZWWdavzYaoMCYibXeSd3Zgp0a+LieT1I2sXX4
         Jpu1zP6Db0tUAYxh8Ffl7M+6PvMGeRrD3xYZaejatJH44l4+cEnmlkt1CNMfwnZHuZzI
         DsyyO88OmoozIEQP+oldIlrU6q4XFYsn8gRG+6lfI7Y6B+p905qlyO4/a1TN0LsVMIQl
         DKJQ==
X-Gm-Message-State: AOAM530eNFKmalb/gBRpLPZGYod/V1Z7elNjxrGtmReiwY/e9SGktoL7
        K5pRePB8CXKfaQ9VIubLM7Uy/1N57Bq8f2x3fhgpBA==
X-Google-Smtp-Source: ABdhPJyiqgn7SIzkaA0Z4EPVWwcwg577znE0wY62h7WlddpNO9W0l3Jz/eBXTKgDKMBrXh7YF6zOLSFPqFGqc/Yec0M=
X-Received: by 2002:a19:9144:0:b0:43b:86a4:1497 with SMTP id
 y4-20020a199144000000b0043b86a41497mr13291435lfj.254.1646067971343; Mon, 28
 Feb 2022 09:06:11 -0800 (PST)
MIME-Version: 1.0
References: <20220216124239.4007667-1-rong.chen@amlogic.com>
In-Reply-To: <20220216124239.4007667-1-rong.chen@amlogic.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Feb 2022 18:05:35 +0100
Message-ID: <CAPDyKFq797hihSwtX00V6tW2c035FLPnWonbBGcuh4L-zWqHTw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: meson: Fix usage of meson_mmc_post_req()
To:     Kevin Hilman <khilman@baylibre.com>,
        Rong Chen <rong.chen@amlogic.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        1131046452@qq.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        45581586@qq.com, Heiner Kallweit <hkallweit1@gmail.com>
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

+ Hainer

On Wed, 16 Feb 2022 at 13:42, Rong Chen <rong.chen@amlogic.com> wrote:
>
> Currently meson_mmc_post_req() is called in meson_mmc_request() right
> after meson_mmc_start_cmd(). This could lead to DMA unmapping before the request
> is actually finished.
>
> To fix, don't call meson_mmc_post_req() until meson_mmc_request_done().
>
> Signed-off-by: Rong Chen <rong.chen@amlogic.com>

We should probably add a fixes tag to this, right?
Fixes: 79ed05e329c3 ("mmc: meson-gx: add support for descriptor chain mode")

Moreover, you want this tagged for stable kernels too, right?

I have applied it for fixes and added the above tags, please tell if
you want me to change it.

Kind regards
Uffe


> ---
>  drivers/mmc/host/meson-gx-mmc.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 8f36536cb1b6..58ab9d90bc8b 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -173,6 +173,8 @@ struct meson_host {
>         int irq;
>
>         bool vqmmc_enabled;
> +       bool needs_pre_post_req;
> +
>  };
>
>  #define CMD_CFG_LENGTH_MASK GENMASK(8, 0)
> @@ -663,6 +665,8 @@ static void meson_mmc_request_done(struct mmc_host *mmc,
>         struct meson_host *host = mmc_priv(mmc);
>
>         host->cmd = NULL;
> +       if (host->needs_pre_post_req)
> +               meson_mmc_post_req(mmc, mrq, 0);
>         mmc_request_done(host->mmc, mrq);
>  }
>
> @@ -880,7 +884,7 @@ static int meson_mmc_validate_dram_access(struct mmc_host *mmc, struct mmc_data
>  static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  {
>         struct meson_host *host = mmc_priv(mmc);
> -       bool needs_pre_post_req = mrq->data &&
> +       host->needs_pre_post_req = mrq->data &&
>                         !(mrq->data->host_cookie & SD_EMMC_PRE_REQ_DONE);
>
>         /*
> @@ -896,22 +900,19 @@ static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>                 }
>         }
>
> -       if (needs_pre_post_req) {
> +       if (host->needs_pre_post_req) {
>                 meson_mmc_get_transfer_mode(mmc, mrq);
>                 if (!meson_mmc_desc_chain_mode(mrq->data))
> -                       needs_pre_post_req = false;
> +                       host->needs_pre_post_req = false;
>         }
>
> -       if (needs_pre_post_req)
> +       if (host->needs_pre_post_req)
>                 meson_mmc_pre_req(mmc, mrq);
>
>         /* Stop execution */
>         writel(0, host->regs + SD_EMMC_START);
>
>         meson_mmc_start_cmd(mmc, mrq->sbc ?: mrq->cmd);
> -
> -       if (needs_pre_post_req)
> -               meson_mmc_post_req(mmc, mrq, 0);
>  }
>
>  static void meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)
> --
> 2.25.1
>
