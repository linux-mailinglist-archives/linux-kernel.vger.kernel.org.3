Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77768547ACD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 17:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237624AbiFLP1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 11:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235371AbiFLP1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 11:27:10 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0085EDDF
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 08:27:09 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-30c2f288f13so30054227b3.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 08:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JKtz7aN4iqLwpjMxddmPWT/Yv9HKk9kmTNthHMCTmzI=;
        b=T9YefAqcwoWBIxZvqn+6v2XWWOet+BsnQU0+RFWVg6KgivzT/L5lObsCTPCQTt/t5Q
         O40qE1hi12jMrF4WTFqKtW2LzpBjaorQNa34aV4k3hv8HKQ8PdKPMEaSSxFMV47/mzpy
         5NB8fyovqGp5apHZFDa58gx5ZaH+tLAMzs45xITz4fb4vlzo0gMUB+DN67+3WhqdQW2m
         K11090o1HY9Z5N/7OrH4HIp/tOUVaTeFZraEa0DnsQrfgrbOu3JKvaQW4n5bCyWXag2u
         d53mOuvNeMu27ZoK5W99SVTmAQTCjGIg6OdP3eCz5qEG76PT5nxBz7fhGrEZ0izsu26g
         oVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JKtz7aN4iqLwpjMxddmPWT/Yv9HKk9kmTNthHMCTmzI=;
        b=S5kk8Vy/hbCmGs+JuVFX4JM6A/PtzLvT0qrBhKyHunQXGOVWfMOVKfegH2g3kCx1NN
         e53HssUIu2lo84KpLz0e9cQyJpkC/jTEShBKTwm0UjmbKYGF8NR+h6lswQLlzifD+qsH
         5HPHxkc9FF547/doUKw+RR2j399SiFYQJ+iHtc6h4wd3AV1Pd+8EU6y6YIie43Rx6Bm1
         WP2qypTYT5QHNxwuvd5JI4d+58QSRRDl7bvVlGP4YzOwjFFfVhAzrloHChxOAheoa9sB
         55W4f3HqZtR0heDqUoaiXZtfMU6zCNPC/M+YfggNuspK1k2IDZxfSiQE62oR4n4Zok6E
         DEaA==
X-Gm-Message-State: AOAM532CFbYrTvVuKYJvLFKoM9N94RYYDNv4gDMy8K/tp11GF6IT9EOm
        sO3NdQqIc3uYvX8O1vUJlp6ttJwkRf7jh4Nx5eYQzQ==
X-Google-Smtp-Source: ABdhPJzw73ekffcunyjrSkMcYzhG2oTN3hgX5618XHyVJPGma2VxAdtu2GUrDNvI7Ls/FS87wXEYytUyk6/LQyIQ8vY=
X-Received: by 2002:a81:1a43:0:b0:30c:78b1:f23d with SMTP id
 a64-20020a811a43000000b0030c78b1f23dmr60215098ywa.166.1655047628056; Sun, 12
 Jun 2022 08:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtVOfWWpx96fa3zzKzBPKiNu1w3FOD4j++G8MOG3Vs0EA@mail.gmail.com>
 <Yp47DODPCz0kNgE8@google.com> <CA+G9fYsjn0zySHU4YYNJWAgkABuJuKtHty7ELHmN-+30VYgCDA@mail.gmail.com>
 <Yp/kpPA7GdbArXDo@google.com> <YqAL+HeZDk5Wug28@google.com>
 <YqAMmTiwcyS3Ttla@google.com> <YqANP1K/6oRNCUKZ@google.com> <YqBRZcsfrRMZXMCC@google.com>
In-Reply-To: <YqBRZcsfrRMZXMCC@google.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sun, 12 Jun 2022 20:56:56 +0530
Message-ID: <CA+G9fYvjpCOcTVdpnHTOWaf3KcDeTM3Njn_NnXvU37ppoHH5uw@mail.gmail.com>
Subject: Re: qemu-arm: zram: mkfs.ext4 : Unable to handle kernel NULL pointer
 dereference at virtual address 00000140
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        regressions@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
        Nitin Gupta <ngupta@vflare.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

On Wed, 8 Jun 2022 at 13:06, Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (22/06/08 11:45), Sergey Senozhatsky wrote:
> >
> > Something like this?
>
> May be even something like below. Move static initializer to cpu up
> hook.

Thanks for providing a fix patch.
As per your suggestion debug lock enabled.

CONFIG_DEBUG_LOCK_ALLOC=y

I have tested this patch and the reported issue got resolved [1].

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

> ---
>  mm/zsmalloc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 9152fbde33b5..6d3789d834e2 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -453,9 +453,7 @@ MODULE_ALIAS("zpool-zsmalloc");
>  #endif /* CONFIG_ZPOOL */
>
>  /* per-cpu VM mapping areas for zspage accesses that cross page boundaries */
> -static DEFINE_PER_CPU(struct mapping_area, zs_map_area) = {
> -       .lock   = INIT_LOCAL_LOCK(lock),
> -};
> +static DEFINE_PER_CPU(struct mapping_area, zs_map_area);
>
>  static __maybe_unused int is_first_page(struct page *page)
>  {
> @@ -1113,6 +1111,7 @@ static inline int __zs_cpu_up(struct mapping_area *area)
>         area->vm_buf = kmalloc(ZS_MAX_ALLOC_SIZE, GFP_KERNEL);
>         if (!area->vm_buf)
>                 return -ENOMEM;
> +       local_lock_init(&area->lock);
>         return 0;
>  }
>
>
> 2.36.1.255.ge46751e96f-goog

Build artifacts link [2]

--
Linaro LKFT
https://lkft.linaro.org

[1] https://lkft.validation.linaro.org/scheduler/job/5160519#L828
[2] https://builds.tuxbuild.com/2ATpwm83jTe2wlUX33YeTpshh2u/
