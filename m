Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E855482F8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 11:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239881AbiFMJH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239720AbiFMJHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:07:55 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9221010DA;
        Mon, 13 Jun 2022 02:07:54 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id q104so3919049qvq.8;
        Mon, 13 Jun 2022 02:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EBVgfZvHOFMLYwxjCwCR93H8ZcHhXQ17mo9XcZyf3JE=;
        b=jD2o9/xPujtSTouJILilQWzB0mSOzn5x0eYw0rbmlBvTcCtAAFV3gSUYFWQgYLRxFZ
         aWW1TTySPXiMHnVgEMkjUsoDGC6Eo+gNFvtcZHXRZDMhpdNdUqRPjY6Gy/xCj3wZyELH
         +3zE57i/LFAtKRQXqM0oPSVT+UQ1vbUDPNykp+raOdmEocXGt/ktDbiqELRD/E4fdZEu
         9ZZtRVHHBEz9VWP3l1LTAEDhzHvzJyTL2gYvp+JX5PI74+LebiPA++Oz00BbQLyvsQGA
         WbTvV4BUBCaV0Om/SCnLeITC4ki+6Mr3SXKchG4ehztIRfW4683dq5SYpks+bUXKNMGI
         k7cQ==
X-Gm-Message-State: AOAM533mm/bgE3B0A5mv99lokm1RdT7Ih5GBEdtBjkdaE6TrliZlBVOi
        lhZAszAN2KypUkI3caF8Lt0w6SPYUPr9eA==
X-Google-Smtp-Source: ABdhPJyluuJPNBADUmjp65xxpUUInsfPY1e2vSfgcBhB0Up7IYnJ5AYXTBzNRTvPEEJvTtsk/CrfHA==
X-Received: by 2002:a05:6214:1c49:b0:467:d775:3c6f with SMTP id if9-20020a0562141c4900b00467d7753c6fmr39189937qvb.9.1655111273666;
        Mon, 13 Jun 2022 02:07:53 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id t5-20020a05620a450500b006a79f9d6521sm250759qkp.74.2022.06.13.02.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 02:07:52 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id e184so8800792ybf.8;
        Mon, 13 Jun 2022 02:07:52 -0700 (PDT)
X-Received: by 2002:a25:7307:0:b0:65c:b98a:f592 with SMTP id
 o7-20020a257307000000b0065cb98af592mr57068004ybc.380.1655111272121; Mon, 13
 Jun 2022 02:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220610200500.6727-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220610200500.6727-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Jun 2022 11:07:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXmRTDfP_g0ado04sdBXZtv+4a8PUnTyh7idzJpHjZzeQ@mail.gmail.com>
Message-ID: <CAMuHMdXmRTDfP_g0ado04sdBXZtv+4a8PUnTyh7idzJpHjZzeQ@mail.gmail.com>
Subject: Re: [PATCH v3] thermal: rcar_gen3_thermal: improve logging during probe
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
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

On Fri, Jun 10, 2022 at 10:08 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> When setting up a new board, a plain "Can't register thermal zone"
> didn't help me much because the thermal zones in DT were all fine. I
> just had a sensor entry too much in the parent TSC node. Reword the
> failure/success messages to contain the sensor number to make it easier
> to understand which sensor is affected. Example output now:
>
> rcar_gen3_thermal e6198000.thermal: Sensor 0: Loaded 1 trip points
> rcar_gen3_thermal e6198000.thermal: Sensor 1: Loaded 1 trip points
> rcar_gen3_thermal e6198000.thermal: Sensor 2: Loaded 1 trip points
> rcar_gen3_thermal e6198000.thermal: Sensor 3: Can't register thermal zone
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Change since v2:
>
> * don't add plural-'s' at runtime to allow for a greppable string
>   (Thanks, Niklas!)

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
