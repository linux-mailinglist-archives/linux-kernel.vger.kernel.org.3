Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BD85318E4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242574AbiEWSaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241348AbiEWSaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 14:30:00 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC7013FD52
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 11:04:25 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id t2so9167586qkb.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 11:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CJ4hCZhKAdwYtZTJlQiUAiJtEDoVXgbNXkSB87RTpgE=;
        b=ZsrlKqbxp0gzWhNS8Yo54hieo0JeXRDymm8LiMaSiNsnVZ8d6vRpYISeaNhDzahYBU
         hbv754gvFj1bedUixgENoivGZT7Sg70gHpP0yloaBa5L4CLm3C1TYhi1WiVh2g4JSjSk
         nGuQJ6qj3w5Guj2/vkmkqrKNbZIUHDj1S+0jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CJ4hCZhKAdwYtZTJlQiUAiJtEDoVXgbNXkSB87RTpgE=;
        b=g5jEAHo+I+e00O2V8J/PlW8Fxb6PqDKmFIKEWcSO0ItK9mxGzksq7bhAtwG0ObKo6t
         1LSNUM4O7hpDrJX/NUrV4PF4EUgZPDBiUKrS8ajZds1s2bo4C4d+a7ItGTCbIWLiDUyD
         yxfoR03GsK82l2XqXX4ENTEk2ohtPIW9kOxnMaCXAsV6vynqmPM8e4KZQRWIFIbNGKAL
         /igywqRKStyLMaoqx4EP9cn8MQiASukx6oscjrJTY6dRoBSB9u8a7twyFCh21HGEVCAV
         LGnxViSDTIWAyhqBF0j140Wfx2UocJk0n3hrh+uN2cHdFVV5jjDfQFuGbwHCO4aA0UCn
         9q+w==
X-Gm-Message-State: AOAM532ib/5uzFo25l73N66HBXB3DjXAjWoEdqPFkpPriMTdDUR1Zb8E
        VaIACljjjoVr6eybdHrF9EI2N2/p4gTm4g==
X-Google-Smtp-Source: ABdhPJydQm7W16LpSU5u7avzYtIANISgno+bjJttP4L4pPBO7BV3W+5eqiV0rlux9PctEGq+gwKg1w==
X-Received: by 2002:a05:620a:1a06:b0:6a3:7562:8ad9 with SMTP id bk6-20020a05620a1a0600b006a375628ad9mr5448731qkb.714.1653329044252;
        Mon, 23 May 2022 11:04:04 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id w7-20020ac857c7000000b002f9303ce545sm4298696qta.39.2022.05.23.11.04.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 11:04:04 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id a3so26839013ybg.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 11:04:03 -0700 (PDT)
X-Received: by 2002:a9d:58c3:0:b0:605:9fa7:f5b6 with SMTP id
 s3-20020a9d58c3000000b006059fa7f5b6mr9077073oth.230.1653328563293; Mon, 23
 May 2022 10:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220523052810.24767-1-duoming@zju.edu.cn>
In-Reply-To: <20220523052810.24767-1-duoming@zju.edu.cn>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 23 May 2022 10:55:49 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNqYPknYUQ9D3JQBx0S__-0dTQZGg_+aoJJOt7y7japNA@mail.gmail.com>
Message-ID: <CA+ASDXNqYPknYUQ9D3JQBx0S__-0dTQZGg_+aoJJOt7y7japNA@mail.gmail.com>
Subject: Re: [PATCH v3] mwifiex: fix sleep in atomic context bugs caused by dev_coredumpv
To:     Duoming Zhou <duoming@zju.edu.cn>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        amit karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>, kvalo@kernel.org,
        "David S. Miller" <davem@davemloft.net>, edumazet@google.com,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Johannes (you should check MAINTAINERS; devcoredump has a specified
maintainer)

On Sun, May 22, 2022 at 10:29 PM Duoming Zhou <duoming@zju.edu.cn> wrote:
>
> There are sleep in atomic context bugs when uploading device dump
> data in mwifiex. The root cause is that dev_coredumpv could not
> be used in atomic contexts, because it calls dev_set_name which
> include operations that may sleep. The call tree shows execution
> paths that could lead to bugs:
>
>    (Interrupt context)
> fw_dump_timer_fn
>   mwifiex_upload_device_dump
>     dev_coredumpv(..., GFP_KERNEL)
>       dev_coredumpm()
>         kzalloc(sizeof(*devcd), gfp); //may sleep
>         dev_set_name
>           kobject_set_name_vargs
>             kvasprintf_const(GFP_KERNEL, ...); //may sleep
>             kstrdup(s, GFP_KERNEL); //may sleep

I was only half paying attention to this patch earlier, but I realize
one source of my confusion: you're blaming the fix wrong. This piece
of code was only added for mwifiex's USB support; the SDIO/PCIe
support is totally fine, as we perform the dump from a worker, not a
timer. So, you have the Fixes tag wrong.

> In order to let dev_coredumpv support atomic contexts, this patch
> changes the gfp_t parameter of kvasprintf_const and kstrdup in
> kobject_set_name_vargs from GFP_KERNEL to GFP_ATOMIC. What's more,
> In order to mitigate bug, this patch changes the gfp_t parameter
> of dev_coredumpv from GFP_KERNEL to GFP_ATOMIC.
>
> Fixes: 57670ee882d4 ("mwifiex: device dump support via devcoredump framework")

That's wrong. Should be:

Fixes: f5ecd02a8b20 mwifiex: device dump support for usb interface

> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
> Changes in v3:
>   - Let dev_coredumpv support atomic contexts.
>
>  drivers/net/wireless/marvell/mwifiex/main.c | 2 +-
>  lib/kobject.c                               | 4 ++--

You almost definitely want to split this in two. One to fix
devcoredump to _really_ support the gfp arg (or else to drop it), and
one to start using it appropriately in mwifiex.

>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
> index ace7371c477..258906920a2 100644
> --- a/drivers/net/wireless/marvell/mwifiex/main.c
> +++ b/drivers/net/wireless/marvell/mwifiex/main.c
> @@ -1116,7 +1116,7 @@ void mwifiex_upload_device_dump(struct mwifiex_adapter *adapter)
>         mwifiex_dbg(adapter, MSG,
>                     "== mwifiex dump information to /sys/class/devcoredump start\n");
>         dev_coredumpv(adapter->dev, adapter->devdump_data, adapter->devdump_len,
> -                     GFP_KERNEL);
> +                     GFP_ATOMIC);

As noted above, PCIe and SDIO support is working just fine. Seems a
bit much to force it to be GFP_ATOMIC in those cases.

Maybe you also need a gfp arg for mwifiex_upload_device_dump()?

Brian

>         mwifiex_dbg(adapter, MSG,
>                     "== mwifiex dump information to /sys/class/devcoredump end\n");
>
