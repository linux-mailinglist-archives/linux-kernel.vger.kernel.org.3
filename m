Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE625794D3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 10:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbiGSIEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 04:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiGSIEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:04:51 -0400
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF1F29C89;
        Tue, 19 Jul 2022 01:04:51 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id r12so10566359qvm.3;
        Tue, 19 Jul 2022 01:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X5wBMic0/EzjK/0y6uiyjdPLhA4k/D4a9x+gguX2roU=;
        b=YR1gKi25Mnep/4VFiOU5ILvFTbPdMT9XnkiOBYSqZFsXunJ6c4WZkd8ZoWtR6V/hnM
         /Sj6G3EiyXhRHZIo+HZTiihDuyNgy7IVMYI5xRZws3694XpoiE75iJRfS7h1g61b3+2T
         07UY12d7Q7zX573CiJpycNgY0JAFQuwoCkhpaPq9XhGeY81249bWPnwDJJPRcMMRBBZ9
         WboSG2s+aSrLwcVb69iSe9J/PNzqdBcK0gTLDsP/3MDf8AW0wV3s3lA0CjBwkeuQnoDe
         V0TebB1bUhz1alIS5cSOOYjZMXedKuG9NtjUaOog2HL93Wad/HOh060aSYRyAoEHrrO4
         G1IA==
X-Gm-Message-State: AJIora/GFuo1tMWK+x4mhQXPzwve0HJs4QusRkoi1uXDeQgjEKnnb1Pq
        kc8iDrV+1a3Ttu5EmSxg3cxv/uqWfIddMg==
X-Google-Smtp-Source: AGRyM1vN0/h4GZWjxi+VEd0Wso6NEQT3GQdpi+aOWbgipV1jh4/vJRiB5M5lt820OUkPICs7M/+v0g==
X-Received: by 2002:a05:6214:4016:b0:473:2180:c03a with SMTP id kd22-20020a056214401600b004732180c03amr24292178qvb.83.1658217890113;
        Tue, 19 Jul 2022 01:04:50 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id n20-20020ac81e14000000b003177969a48fsm10351768qtl.21.2022.07.19.01.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 01:04:49 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id e69so25145654ybh.2;
        Tue, 19 Jul 2022 01:04:49 -0700 (PDT)
X-Received: by 2002:a25:f06:0:b0:670:1685:d31d with SMTP id
 6-20020a250f06000000b006701685d31dmr13003184ybp.380.1658217889355; Tue, 19
 Jul 2022 01:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220713100603.3391-1-wsa+renesas@sang-engineering.com> <20220713100603.3391-4-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220713100603.3391-4-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Jul 2022 10:04:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU8vo4+9hpkArj0OdJPiesJOaDk9U+gNR2ccMyUm7DiAg@mail.gmail.com>
Message-ID: <CAMuHMdU8vo4+9hpkArj0OdJPiesJOaDk9U+gNR2ccMyUm7DiAg@mail.gmail.com>
Subject: Re: [PATCH 3/3] clocksource/drivers/sh_cmt: Add R-Car Gen4 support
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 12:07 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Add support for the R-Car Gen4 CMT types 0/1 which are the same as in
> the previous two generations.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
