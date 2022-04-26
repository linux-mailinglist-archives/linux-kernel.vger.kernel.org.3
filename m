Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EEA510CDF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 01:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356216AbiDZX62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 19:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243701AbiDZX6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 19:58:25 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E930E24
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 16:55:15 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id r189so509613ybr.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 16:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nlt5qC+wvX5QcXEUX3mdcdWLCql1FNsd3/g2ToCHKcU=;
        b=aO9N7IfdWDlkYSXheT2CnTYqLmWETHZgTvHopWHBxHIRPnCHtG+d2P8fseumLmleiK
         XCjpLuWHvHtP3sAvSblNcRUz36ij1Ka+uhe4+hxA0JyF8nJWfkSWPLa/K+cqk8VbyoXl
         qh1AjswHxttcFaICPkdy5Zs8ecRYAZjidd543EcpsqmWRLE7mnlzXwe1OJpMKzYQPKgy
         KA72QY9Nx0woIqJKKvLZn4dEOoT5ex3klxZv7Ld+xzXikBITIqHj3PryMn/rYTtPmS8y
         AIg34upVQalYNavbxTu49mipu5FLybaW2WgXFAvQ7hMJGW4DWTXCIDT8Ijct5QZOp6RT
         MwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nlt5qC+wvX5QcXEUX3mdcdWLCql1FNsd3/g2ToCHKcU=;
        b=y0VQQTKRtHuLF3xzkquj4fNunEJ6LoN/KvpEWJU1Yv8N3DhUygSPk0+3JYv/Y3Sl08
         S+XbHbUiq6Bv5zvJ0BUbNGQMkBAFAiV6yI3WBoDB/7dxE9BK3SgppVkxPPutpqeTFjhy
         dY6Z5XD9XhHd2WGCrfmjVw9Bmut4CoEYOHNsxnx9MS6qBwsBpORa0a0hc7nrc6ZGx9h1
         pIJUAXy9R93QEMmv5Y1G3qlEzTG3qD8oAzHQUCEBkbAmdzMrbdVvZIFEvt14Gbaw2mz8
         TumDfFKgJ2IC8hpTSNgjx3Ds7XnCDSfYGCxd6FAh5+6oqaAVXml0RQ1ehdC9BZXxieQG
         WyKQ==
X-Gm-Message-State: AOAM533Kd972L9uTJ1b4J+O9x8x5pd+5q9mcJMoAUg2zGmXll0Uh6yCg
        qEjKlzzMdsznBeoSHr8lHSyCMzWMVZEtYJCNDCA=
X-Google-Smtp-Source: ABdhPJw1e5UpoiyY0rnTzfkQyWo+TP1DNsQS+nw0hkXS+1iwawNqWqm0B17hT9qfFi7HJuY7QKDXpWEhpwzdtzMLkOQ=
X-Received: by 2002:a05:6902:1249:b0:644:d8bb:e741 with SMTP id
 t9-20020a056902124900b00644d8bbe741mr24530799ybu.585.1651017314763; Tue, 26
 Apr 2022 16:55:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220426014545.628100-1-briannorris@chromium.org> <20220426014545.628100-2-briannorris@chromium.org>
In-Reply-To: <20220426014545.628100-2-briannorris@chromium.org>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Tue, 26 Apr 2022 19:55:02 -0400
Message-ID: <CAMdYzYqyDr1HFYB4p8NK8ssq60qfjR2jyoSJ=tcRn8CWsZr16g@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] soc: rockchip: power-domain: Replace dsb() with smb()
To:     Brian Norris <briannorris@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Arnd Bergmann <arnd@arndb.de>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 9:46 PM Brian Norris <briannorris@chromium.org> wrote:
>
> It's unclear if these are really needed at all, but seemingly their
> purpose is only as a write barrier. Use the general macro instead of the
> ARM-specific one.
>
> This driver is partially marked for COMPILE_TEST'ing, but it doesn't
> build under non-ARM architectures. Fix this up before *really* enabling
> it for COMPILE_TEST.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>
> Changes in v3:
>  * New in v3
>
>  drivers/soc/rockchip/pm_domains.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
> index 1b029e494274..cf16ff9b73b3 100644
> --- a/drivers/soc/rockchip/pm_domains.c
> +++ b/drivers/soc/rockchip/pm_domains.c
> @@ -178,7 +178,7 @@ static int rockchip_pmu_set_idle_request(struct rockchip_pm_domain *pd,
>                 regmap_update_bits(pmu->regmap, pmu->info->req_offset,
>                                    pd_info->req_mask, idle ? -1U : 0);
>
> -       dsb(sy);
> +       wmb();

Just curious, shouldn't this be mb() instead of wmb()?
From the arm64 barrier.h:

#define mb() dsb(sy)
#define wmb() dsb(st)


>
>         /* Wait util idle_ack = 1 */
>         target_ack = idle ? pd_info->ack_mask : 0;
> @@ -285,7 +285,7 @@ static void rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *pd,
>                 regmap_update_bits(pmu->regmap, pmu->info->pwr_offset,
>                                    pd->info->pwr_mask, on ? 0 : -1U);
>
> -       dsb(sy);
> +       wmb();
>
>         if (readx_poll_timeout_atomic(rockchip_pmu_domain_is_on, pd, is_on,
>                                       is_on == on, 0, 10000)) {
> --
> 2.36.0.rc2.479.g8af0fa9b8e-goog
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
