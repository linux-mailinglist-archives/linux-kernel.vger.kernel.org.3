Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17045A2382
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245299AbiHZIs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiHZIs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:48:26 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490B8D599E;
        Fri, 26 Aug 2022 01:48:25 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id de16so566753qvb.12;
        Fri, 26 Aug 2022 01:48:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=wVGJbgFBnSEo5TsUVJyAIRxV0CFoLrFcVQwaQqKxaC4=;
        b=FMo7e77nALFvv//9tgszJb4Ox8obg6nnRHEgk788j0wVrDvdhGdO+eSNKStTArGj8k
         SKKJKQi63glUfWkz941KknwYPfnFVh8UVWoAHULw2ahWhHlxxewKcF5LWqSc/kfDWppS
         +xpgdxeL8sIDdw2IhhpE9OTOrafQZJnNMdl+oRC7wrMBQF2hSX2STwitf/mIag2ISJth
         VfYASzvhyiwGRPpr6kAA5eNFjJGpoDMRsYHkEB6/A0y14Az+SuGtF+dMcctjU4wtLLB0
         i1rQEXeuQZIbWcwx35a0xU6fAMlP0lYMnXxPNe6oSfnqIDerLhf9TD0lw6F55TCMBTC8
         DToQ==
X-Gm-Message-State: ACgBeo1X7KmR5VERKZSvm+LOaQ8mlPCfPodexYbhfsv5Yugq7n69oWVW
        yh30oynQCoHf/4DDpj1Qw2qiJA7asKxlKQ==
X-Google-Smtp-Source: AA6agR6QdetVG08wTH+Ub8FMCMa0woL7CKJAeK0FfgKOBEO/IibiKl5uuxLha77/sh9mNGvsy9gbLA==
X-Received: by 2002:a05:6214:d82:b0:477:3d7c:1081 with SMTP id e2-20020a0562140d8200b004773d7c1081mr7043430qve.28.1661503704356;
        Fri, 26 Aug 2022 01:48:24 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id j7-20020ac85c47000000b0031f0b43629dsm940586qtj.23.2022.08.26.01.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 01:48:24 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-3376851fe13so19611687b3.6;
        Fri, 26 Aug 2022 01:48:24 -0700 (PDT)
X-Received: by 2002:a25:415:0:b0:696:814:7c77 with SMTP id 21-20020a250415000000b0069608147c77mr6644403ybe.36.1661503703786;
 Fri, 26 Aug 2022 01:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220824094327.33685-1-wsa+renesas@sang-engineering.com> <20220824094327.33685-3-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220824094327.33685-3-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 26 Aug 2022 10:48:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXCcstc8eMKweQU1vn4q7myrqoGgFMiOTzqEvtb1mGYmw@mail.gmail.com>
Message-ID: <CAMuHMdXCcstc8eMKweQU1vn4q7myrqoGgFMiOTzqEvtb1mGYmw@mail.gmail.com>
Subject: Re: [PATCH 2/3] spi: sh-msiof: add generic Gen4 binding
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
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

On Wed, Aug 24, 2022 at 11:50 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> No further changes in this generation discovered yet.
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
