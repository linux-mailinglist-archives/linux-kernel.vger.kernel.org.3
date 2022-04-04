Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C284F10D6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347262AbiDDI0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242397AbiDDI0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:26:39 -0400
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5307425C5F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 01:24:44 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id kl29so6902796qvb.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 01:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FicpfUnQ7T87Zj/vZxO6kNFpJtzAUUMNRMAzYFTMPPk=;
        b=6/C/DecR4nwmn8UA5Gwts2ECzjpS4NbVp5TElYqmiRv2+UCD90PZrZmOB3YOHBtexW
         wrrl/y15opcWiGKkDxuLT5+TL7W8XUH64Y7VswBEkAKXvJVH1WjdpAwlYq+onHys/XU+
         yASFQOLHueSpOyDDnK9NAAxnoY+pDt8wBqqcBgy0v4p+CwNWA0xEZXHtYbKJT8w82+d5
         ZuPB8bTB9TfwWwnY8vO7DNbSZA/HCpamoBK2fAXT8W0IvuBxWTCktzLLmt+P/xbRLSUo
         Oz36q1YfAUalawgK+YuB1t/uv2s935dn0T/vRKmUqcHbfUWroM9x6t6GdQFwFTXRYzKs
         8oew==
X-Gm-Message-State: AOAM531V5cvx0nKIQoCs+aMg/jbV/J2MErrAElaTOJfcJCRKlMq+0eUs
        eAQOGYf+eNzsWrhSXTtppOufuSCbHDOfDA==
X-Google-Smtp-Source: ABdhPJzSD5cf4zd4elv3a61oJIO84Cly0cyMarJ87N4Ja4r/U3nFXirnwjyPXOpFf1s3Zftfx481jQ==
X-Received: by 2002:a05:6214:e69:b0:441:75c6:92d with SMTP id jz9-20020a0562140e6900b0044175c6092dmr16249175qvb.99.1649060683191;
        Mon, 04 Apr 2022 01:24:43 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id x6-20020a376306000000b0067b32a8568esm5987320qkb.101.2022.04.04.01.24.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 01:24:42 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-2eafabbc80aso90121097b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 01:24:42 -0700 (PDT)
X-Received: by 2002:a81:618b:0:b0:2db:d952:8a39 with SMTP id
 v133-20020a81618b000000b002dbd9528a39mr21431894ywb.132.1649060681792; Mon, 04
 Apr 2022 01:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <4c449fab-8135-5057-7d2c-7b948ce130cc@theinnocuous.com>
 <0b31b1d3-852d-6cab-82ae-5eecaec05679@theinnocuous.com> <202203151150.1CDB1D8DA@keescook>
 <bfbd9394-161b-0e70-00c5-79d0dd722e08@theinnocuous.com> <alpine.DEB.2.21.2204022255430.47162@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2204022255430.47162@angie.orcam.me.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Apr 2022 10:24:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXNLmuhry3bMJ_fMZf4Z5MYYjKg+1vNKxagOu=S5SYjOg@mail.gmail.com>
Message-ID: <CAMuHMdXNLmuhry3bMJ_fMZf4Z5MYYjKg+1vNKxagOu=S5SYjOg@mail.gmail.com>
Subject: Re: [PATCH] x86: Remove a.out support
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     James Jones <linux@theinnocuous.com>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
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

On Sun, Apr 3, 2022 at 6:46 PM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
> On Wed, 16 Mar 2022, James Jones wrote:
> > Probably getting a bit off topic, but I did spend a few hours searching
> > around for any existing tools to convert a binary from a.out->ELF, and
> > trying to come up with something myself by extracting the sections with
> > objdump and re-combining them into an ELF using a linker script placing
> > the sections at the same locations. I couldn't get it working in an
> > evening or two messing with it so I moved on, but I agree something like
> > this seems possible in theory.
>
>  Chiming in late as I'm scanning outstanding mailing list traffic: if this
> is as you say all statically linked stuff, then converting from a.out to
> ELF might be as easy as:

Probably, as https://lwn.net/Articles/889952/ claims dynamically linked
a.out was broken in v5.1.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
