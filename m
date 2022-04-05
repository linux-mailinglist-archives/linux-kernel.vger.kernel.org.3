Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C0E4F239D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 08:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiDEGvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 02:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiDEGvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 02:51:37 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163806D87F;
        Mon,  4 Apr 2022 23:49:40 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id w141so9579558qkb.6;
        Mon, 04 Apr 2022 23:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9xFUojzcZWjJAE9t/PMnReOgCUP09Oe/zUWR0S+t5P4=;
        b=oOTEVnQMXKG6JVQV/D3MAYNwqYJbURaDQIdj48Q9lVmdLEoK9ZibZ3fBA6znQTHBmD
         QZm5hcMGgCvL/C+vWmt4oBfNOWb1UgxgQ3W9DvFnmzcxa1erUsCl4w0fE9s1HOsSltUD
         TXtNFIXefQg3B5wONaYVVel0N1Wuishg8Yx8Qb5y7bsIYfUVXugM892M7CDBqer/rSet
         HtHm3xnyMESVMWIckW4ijBtozZdL+ghW3rWfmMhYehCFsTKDnUDSgT/rD/FcfFXwyX6E
         o2hsctkXU76ccAM4ky1ikcrWwqQFkZBtmBYDa504ffrCfkBRtTIDxPcMM6YctbN4CSRe
         m+eA==
X-Gm-Message-State: AOAM5321fGQmq3ciqawOwYQt2OPb79Rh6j8j1o0d0ku1eUI90wB75vi3
        giSYgiUaDKdYx+o1pR5ZUiDo2qIAZhBvcA==
X-Google-Smtp-Source: ABdhPJyQ4wBXU9EugXd+IGyfX6fpWQblLDPC1UuNHtq/8ubR0qDD20waTB9iEklWBYO20wXJhLMIxw==
X-Received: by 2002:ae9:eb06:0:b0:67b:3148:2f22 with SMTP id b6-20020ae9eb06000000b0067b31482f22mr1236699qkg.454.1649141378525;
        Mon, 04 Apr 2022 23:49:38 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id v18-20020a05622a189200b002e22e09d77fsm10898947qtc.59.2022.04.04.23.49.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 23:49:38 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2eb43ad7909so73721427b3.2;
        Mon, 04 Apr 2022 23:49:38 -0700 (PDT)
X-Received: by 2002:a81:3d81:0:b0:2eb:8069:5132 with SMTP id
 k123-20020a813d81000000b002eb80695132mr1448283ywa.438.1649141377810; Mon, 04
 Apr 2022 23:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wg6FWL1xjVyHx7DdjD2dHZETA5_=FqqW17Z19X-WTfWSg@mail.gmail.com>
 <20220404074734.1092959-1-geert@linux-m68k.org> <alpine.DEB.2.22.394.2204041006230.1941618@ramsan.of.borg>
 <545e68c7-2872-9ee7-0b39-59c39f2bb9d1@gmx.de>
In-Reply-To: <545e68c7-2872-9ee7-0b39-59c39f2bb9d1@gmx.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 5 Apr 2022 08:49:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX45omg_3pUPYnOdkwQC+wP89L3RE-GZq5A=jTHDqDJFA@mail.gmail.com>
Message-ID: <CAMuHMdX45omg_3pUPYnOdkwQC+wP89L3RE-GZq5A=jTHDqDJFA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.18-rc1
To:     Helge Deller <deller@gmx.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Michael Ellerman <mpe@ellerman.id.au>
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

Hi Helge,

CC Michael

On Tue, Apr 5, 2022 at 8:45 AM Helge Deller <deller@gmx.de> wrote:
> On 4/4/22 10:16, Geert Uytterhoeven wrote:
> > On Mon, 4 Apr 2022, Geert Uytterhoeven wrote:
> >> Below is the list of build error/warning regressions/improvements in
> >> v5.18-rc1[1] compared to v5.17[2].
> >>
> >> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/3123109284176b1532874591f7c81f3837bbdc17/ (all 96 configs)
> >> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/f443e374ae131c168a065ea1748feac6b2e76613/ (all 96 configs)
> >>
> >> *** ERRORS ***
> > parisc64-gcc8/generic-64bit_defconfig
> > parisc-gcc8/generic-32bit_defconfig
> > parisc-gcc8/parisc-allmodconfig
> > parisc-gcc8/parisc-allnoconfig
>
> Someone needs to adjust how the parisc kernel is built on kisskb...
>
> The parisc platform got vDSO support, so now the 32- and 64-bit
> hppa compiler needs to be installed when building (for 64-bit).
>
> In addition, it changed how to build a kernel:
>  make ARCH=parisc                         # to build a 32-bit kernel
>  or
>  make ARCH=parisc64                       # to build a 64-bit kernel
> (before ARCH=parisc was sufficient to build either for 32- or 64-bit).
>
> And, in case "CROSS_COMPILE=" is given, you need to give "CROSS32_COMPILE=" as well.
> It's preferred to leave out both CROSS[32]_COMPILE= parameters and let
> the environment detect the compilers automatically. They just need to be in $PATH.
>
> Who can change that on kisskb ?

Michael (CCed).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
