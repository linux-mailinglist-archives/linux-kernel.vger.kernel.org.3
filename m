Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1794158FE83
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 16:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbiHKOsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 10:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiHKOsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:48:05 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35B27823E;
        Thu, 11 Aug 2022 07:48:03 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id e28so5599818qts.1;
        Thu, 11 Aug 2022 07:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=OY6kXjlT/4YU1tqALSVt6+oYPv3FKO3xFRDEkjpCRDs=;
        b=MmP7abxo1qPw+BpPRzvjqj5df5agTUdeHROw7TLY45ttT7OkfMBr6YsrJgbCV6/zdf
         aJ9AlcS13d6E1hZv6QmlfBPpBufn3pijtiRW/W2twXuPUBZgEtY27oW0ErFnBJnjQYbt
         bP4KMrvJYx8Nc2NFxQJiAB3OtjMX1BbsWZmidAcjBMG0miRpxYrQn2j/VJBlVeNVH1UV
         kRteV0v7zGF3cPlrI6WXJw0GhmWeoQ+CFouUBDyyEET9HgK3o3LJ537LY9gR5ukL3m+o
         77v9RkGElFNqVGEPkkw0rOgLcuseekbWuTmS3A4ezLmIPH/jpnGxli2tIZBLMdi+riea
         0FYQ==
X-Gm-Message-State: ACgBeo3zNjCNku+5aHob+CpKfW4yX3IUuhdHJu2cBxm/Bpf6U+e8ILRT
        pAljcMwrS5LFzoWEJ3jk7WusKkBiiZcfzUqK
X-Google-Smtp-Source: AA6agR5WsZPMiittHx0u+9sWKGxLBiyDSuXNZMsMYEbe7hezZ64I9xN2CWcicsTlHnBVPTC+Q/PE3Q==
X-Received: by 2002:ac8:5881:0:b0:342:e993:89b2 with SMTP id t1-20020ac85881000000b00342e99389b2mr23597205qta.0.1660229282889;
        Thu, 11 Aug 2022 07:48:02 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id gd8-20020a05622a5c0800b0031eeecd21d6sm1771582qtb.69.2022.08.11.07.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 07:48:02 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 7so28648414ybw.0;
        Thu, 11 Aug 2022 07:48:02 -0700 (PDT)
X-Received: by 2002:a25:d811:0:b0:676:fffb:979 with SMTP id
 p17-20020a25d811000000b00676fffb0979mr27343882ybg.604.1660229282091; Thu, 11
 Aug 2022 07:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220722151155.21100-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220722151155.21100-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220722151155.21100-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 11 Aug 2022 16:47:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWG6FkNVYsbkvqHZHQd_XNNOKX0=fy-UdZjg62gzH4jrw@mail.gmail.com>
Message-ID: <CAMuHMdWG6FkNVYsbkvqHZHQd_XNNOKX0=fy-UdZjg62gzH4jrw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: dts: renesas: rzg2l-smarc-som: Add PHY
 interrupt support for ETH{0/1}
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 5:12 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> The PHY interrupt (INT_N) pin is connected to IRQ2 and IRQ3 for ETH0
> and ETH1 respectively.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v2->v3
> * Included irqc-rzg2l.h header

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.1.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
