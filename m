Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3ADC54CB45
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239252AbiFOO0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiFOO0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:26:42 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5BF44A2B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:26:40 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id o73so8828436qke.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z+v4uJresp4bk2kGcz6lgky6S6tyTgmS2aLhIJim1Ts=;
        b=Rbbkn7M6SN8+V1tZRGvNaqzuFzhCQW+2fyKfXr7rc1LQX2BBMiKlurFQvXtzUq+aiC
         3bBJ8VHx3J45KX5zIfsJfEB0Shc9owf5O2eNvE4L1byGhsBN4QebC8v6D5tEGvfZVd9h
         OyMvobC+O9rvLKUrgdYSYBStob3Cza0wyfVwH5lCb2dqIpoee7G0nHHYVLBMghMq0hHo
         3rvw/AygtY8b92mqFeIRYTh4ngW0zdOVeg4mzZQn2tOtSLMH9Lycsnpt8xUn1GVGm1LK
         jjlklvVzwWiFLu8MCvx/0tq7ECnF/90orHvkYVQ4JsENMMzRWP1SNMTU6G7TcLhQhHz1
         z3Ng==
X-Gm-Message-State: AOAM530jJCUwiLwd4J1JiVWTUYlxy/JXgJNQF+VuU4zUTYTLHpVHOXDx
        DLKNEXeFcI6wrYI/PsrDhbeS4+o3noE/OA==
X-Google-Smtp-Source: ABdhPJxgzlFg+lRF9glc3lhTxOcknKW2Zbkz++C02QDTZZkgITTi+zKjifD5V2RX4SNoWePjcNs+nQ==
X-Received: by 2002:a05:620a:248c:b0:6a6:e50d:442a with SMTP id i12-20020a05620a248c00b006a6e50d442amr8033165qkn.117.1655303199791;
        Wed, 15 Jun 2022 07:26:39 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id w8-20020ac87e88000000b00304e29c9a6asm9791239qtj.91.2022.06.15.07.26.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 07:26:38 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-3137316bb69so62676787b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:26:38 -0700 (PDT)
X-Received: by 2002:a81:6c46:0:b0:315:bb1:6a21 with SMTP id
 h67-20020a816c46000000b003150bb16a21mr7276529ywc.283.1655303198318; Wed, 15
 Jun 2022 07:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220615142144.3968617-1-windhl@126.com>
In-Reply-To: <20220615142144.3968617-1-windhl@126.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Jun 2022 16:26:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX4O2d6BFnsW58r_uQezRnpQ9EERFyVt2RC6mbfxZEHSg@mail.gmail.com>
Message-ID: <CAMuHMdX4O2d6BFnsW58r_uQezRnpQ9EERFyVt2RC6mbfxZEHSg@mail.gmail.com>
Subject: Re: [PATCH] drivers: staging: board: Add missing of_node_put() in board.c
To:     Liang He <windhl@126.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liang,

On Wed, Jun 15, 2022 at 4:21 PM Liang He <windhl@126.com> wrote:
> In board_staging_gic_setup_xlate(), of_find_compatible_node() return
> a node pointer with refcount incremented. We should use of_node_put()
> when it is not used anymore.
>
> Signed-off-by: Liang He <windhl@126.com>

Thanks for your patch!

> --- a/drivers/staging/board/board.c
> +++ b/drivers/staging/board/board.c
> @@ -67,6 +67,8 @@ int __init board_staging_gic_setup_xlate(const char *gic_match,
>         if (!irqc_node)
>                 return -ENOENT;
>
> +       of_node_put(irqc_node);
> +
>         irqc_base = base;
>         return 0;
>  }

irqc_node is a global variable, and it is used after this function
has returned.

NAKed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
