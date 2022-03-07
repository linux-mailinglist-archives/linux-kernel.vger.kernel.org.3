Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691834D0609
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244610AbiCGSM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234219AbiCGSM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:12:57 -0500
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C3E6580D;
        Mon,  7 Mar 2022 10:12:03 -0800 (PST)
Received: by mail-qk1-f176.google.com with SMTP id 85so4569860qkm.9;
        Mon, 07 Mar 2022 10:12:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RvQxk6rfBJMN5vOvhO/EagDwtVMLYLBKUqMsr005EBM=;
        b=PVeKuv3+priIbUWyuZb2/Vp3EKZCrXjC42Or2a1KPGMuJV0VUcv/lGUIaQQJreAEOm
         Ebccd1xqzaQl8FahedGBJe8JAefhM1RiDjrgbyLkEEMvtqa2px8Z5bRLih6Pf12xl2YA
         HF7bSKhx1LHyo+4ZGNg/zdBD6+Pa5YZUQpDO7TsSNUrFZx3X8NRoG0UitAy/4k9uRbZ9
         9BVs2vsaVCXLySGCk3l6KMnLCVt1mPk9xx1PeeOejkWz+KXNF659Hi55FiXEWR5kkipE
         W0jLXnFaxIXQ8sixFGcAOmHSuyRjd14/IEK+fENG4tC97D8QmNQndm+D7u8/AB56iwXu
         psQw==
X-Gm-Message-State: AOAM531X5D0rzeP4LtqKGyEYNu858RfRl8haRKdLm1iipzcDKXQ+p6Im
        g8s+tXdHa0WDU71gmdKUJY6zu2pxxYuG/g==
X-Google-Smtp-Source: ABdhPJzIjcvzrzHDLq/sPZHcpca2+/B2rbXW/Xo58ZaKpjYzjlDNmyiQ7dQ7U+qngD/fDNAcCUFQJw==
X-Received: by 2002:a05:620a:9:b0:67b:1ebe:3bd9 with SMTP id j9-20020a05620a000900b0067b1ebe3bd9mr4232957qki.133.1646676722039;
        Mon, 07 Mar 2022 10:12:02 -0800 (PST)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id ay35-20020a05620a17a300b00648cc8356e2sm6541396qkb.9.2022.03.07.10.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 10:12:01 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id x200so32652297ybe.6;
        Mon, 07 Mar 2022 10:12:01 -0800 (PST)
X-Received: by 2002:a25:bc8f:0:b0:628:8649:5c4b with SMTP id
 e15-20020a25bc8f000000b0062886495c4bmr8798382ybk.207.1646676721196; Mon, 07
 Mar 2022 10:12:01 -0800 (PST)
MIME-Version: 1.0
References: <20210922091007.5516-1-wsa+renesas@sang-engineering.com>
 <163282533892.34438.1878675609177525004.b4-ty@canonical.com>
 <CAMuHMdUqQLo7=NFaNEukqniTJbx-mSZv7eQNB9eCT=L28y3u=A@mail.gmail.com> <8078e6af-034f-d705-c14d-49f86495f86b@canonical.com>
In-Reply-To: <8078e6af-034f-d705-c14d-49f86495f86b@canonical.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Mar 2022 19:11:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV8sYDFPE22-zH7KNYTYDLShAh-Bu4fG-+NKHqLAnwnDw@mail.gmail.com>
Message-ID: <CAMuHMdV8sYDFPE22-zH7KNYTYDLShAh-Bu4fG-+NKHqLAnwnDw@mail.gmail.com>
Subject: Re: [RFC PATCH] memory: renesas-rpc-if: Correct QSPI data transfer in
 Manual mode
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
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

Hi Krzysztof,

On Mon, Mar 7, 2022 at 6:47 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
> On 07/03/2022 17:44, Geert Uytterhoeven wrote:
> > On Tue, Sep 28, 2021 at 12:36 PM Krzysztof Kozlowski
> > <krzysztof.kozlowski@canonical.com> wrote:
> >> On Wed, 22 Sep 2021 11:10:06 +0200, Wolfram Sang wrote:
> >>> This patch fixes 2 problems:
> >>> [1] The output warning logs and data loss when performing
> >>> mount/umount then remount the device with jffs2 format.
> >>> [2] The access width of SMWDR[0:1]/SMRDR[0:1] register is wrong.
> >>>
> >>> This is the sample warning logs when performing mount/umount then
> >>> remount the device with jffs2 format:
> >>> jffs2: jffs2_scan_inode_node(): CRC failed on node at 0x031c51d4:
> >>> Read 0x00034e00, calculated 0xadb272a7
> >>>
> >>> [...]
> >>
> >> Applied, thanks!
> >>
> >> [1/1] memory: renesas-rpc-if: Correct QSPI data transfer in Manual mode
> >>       commit: fff53a551db50f5edecaa0b29a64056ab8d2bbca
> >
> > While trying to enable support for RPC on Salvator-X(S)[*], I
> > discovered HyperFLASH detection is broken:
> >
> >     rpc-if-hyperflash rpc-if-hyperflash: probing of hyperbus device failed

[...]

> Thanks for letting me know. This patch is already in mainline, so the
> solution is either to revert it or fix it. I will wait for it from you
> (as in plural "you" :) ).

Thanks, that's exactly what I had expected ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
