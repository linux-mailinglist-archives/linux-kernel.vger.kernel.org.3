Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A864581BBC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 23:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239629AbiGZVlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 17:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiGZVlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 17:41:05 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9276397
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 14:41:01 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id b11so28345662eju.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 14:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dobQXyCJnXCvhS60t6+uPgdDrEwoWKRNXHCECg4WCzQ=;
        b=g9S5IxFWudhyN2dvNUZBtI/UZ4iuQwa88c9wTdnf63zVFhWVnLiKdFPb3Ppe2Uf7Hk
         nxFz0RUrLygp7C4R7R/zJ1whmiRTdwutmLrtDvGvcKRnAnPs+p9Ge4GU5QWHfLUgmQEE
         N+wYxNGirDdB+sYUrEO1Z5n54YhVTPNrLavgWKbLvqLsj1srBrdqLhNYIOx8nmS7LNoJ
         OrySPim7JeMmL6yNVJnNaVJgElInCz5vMRF8OZ4rF5XfxEhXNPJ+FqHrQvujqiTE0QP2
         BfWrXLAUEnAmo8AWbdl34k2YkwWfKkHZzOy+vySW3QSY53JawFGf2OugDjFRZrJnPBh8
         WvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dobQXyCJnXCvhS60t6+uPgdDrEwoWKRNXHCECg4WCzQ=;
        b=Vd63vXnFsKcunMENMAkKaB5jFr7QFdFVhcXTLCGysK6GbzqV3DUWZQUi31x8KrjSQL
         LNoQhviRD+DsxcIwGVkxf7xUr3+aO3s4SW8Ese0h4csN/sG3Pm/c66eKg7V+Jf9Za3aD
         Lmlu5HhjCeNBaTGNwT5kTLhFCgQuLMYwya4+dHI1PRlksHR9vHKFVmOBHGABxnbrXLa3
         6TDnWndA8KDBQnVbPNEP/7/WzzzzBKGSzqKy+1C0PgRJgakEHt9JYYOlG6Z68MdgpV6a
         f3efh+bwBiRe0UgU2WDWGSqwX7eGasO8Pgm4BMQ9R01u2fz6LnOmnntB7YpR3zLyJgiC
         7KYA==
X-Gm-Message-State: AJIora+p9xZAchhmwhgjP19cedulrvicYA3Futj5oZor/wKIbKtd8OB8
        NvIXSdHpnrpl43GCzDhs1shEdAlmk/J7rdEtvUFkwDwcbRbj5A==
X-Google-Smtp-Source: AGRyM1shllA1rNjVCvItJFWMKXBnekv+i7L2wZ4KlwmYUZRjfGSqA85VYZmFBB9EBZbYNjZWH6EsKEKN94sxSYU4WcI=
X-Received: by 2002:a17:907:6e0e:b0:72b:9ec4:2ba2 with SMTP id
 sd14-20020a1709076e0e00b0072b9ec42ba2mr15278702ejc.300.1658871659839; Tue, 26
 Jul 2022 14:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <CANX2M5Zw_zW6ez0_wvaXL1pbLnR2jWY=T7MgkT=4a-zNkiwVig@mail.gmail.com>
 <YtuceCr5OCJcDatJ@kroah.com> <874jz82kx0.wl-tiwai@suse.de>
In-Reply-To: <874jz82kx0.wl-tiwai@suse.de>
From:   Dipanjan Das <mail.dipanjan.das@gmail.com>
Date:   Tue, 26 Jul 2022 14:40:48 -0700
Message-ID: <CANX2M5Ywm+GpYY3+GsOWCLH24Nhy0M0LjBE-pHC8wFcd7SO=wQ@mail.gmail.com>
Subject: Re: KASAN: vmalloc-out-of-bounds Write in snd_pcm_hw_params
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>, perex@perex.cz,
        tiwai@suse.com, consult.awy@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        fleischermarius@googlemail.com, its.priyanka.bose@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2022 at 3:17 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Sat, 23 Jul 2022 09:00:08 +0200,
> Greg KH wrote:
> >
> > Wondeful, do you have a fix for this that solves the reported problem
> > that you have tested with the reproducer?
>
> ... or at least more detailed information.

Here is our analysis of the bug in the kernel v5.10.131.

During allocation, the `size` of the DMA buffer is not page-aligned:
https://elixir.bootlin.com/linux/v5.10.131/source/sound/core/memalloc.c#L149.
However, in sound/core/pcm_native.c:798
(https://elixir.bootlin.com/linux/v5.10.131/source/sound/core/pcm_native.c#L798),
the `size` variable is page-aligned before memset-ing the `dma_area`.
From the other BUG_ON assertions in other parts of the code, it looks
like the DMA area is not supposed to be equal to or greater than
0x200000 bytes. However, due to page-alignment, the `size` can indeed
get rounded up to 0x200000 which causes the out of bound access.

> Last but not least, you should check whether it's specific to your
> 5.10.x kernel or it's also seen with the latest upstream, too.

The bug is not reproducible on the latest mainline, because in
sound/core/memalloc.c:66
(https://github.com/torvalds/linux/blob/5de64d44968e4ae66ebdb0a2d08b443f189d3651/sound/core/memalloc.c#L66)
the allocation function `snd_dma_alloc_dir_pages()` now page-aligns
the `size` right before allocating the DMA buffer. Therefore, any
subsequent page-alignment, like the one in `snd_pcm_hw_params()` does
not cause an out of bound access.

-- 
Thanks and Regards,

Dipanjan
