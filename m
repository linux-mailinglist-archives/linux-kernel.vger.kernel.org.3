Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A044FCF03
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 07:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348305AbiDLFkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 01:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348274AbiDLFkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 01:40:40 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B4B344F9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 22:38:23 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id p10so30229603lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 22:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ll/XCn4eT+mWamanV6qNk4+X9BXYFUW6oQ8MurM5uWk=;
        b=fgDQtBam00x6nb34pezhr9TPAf1bSvMtM9E7e+7/EJFJ0nDM4iVhYJw44irfk6xwVf
         a/rZdmHC8yHQm0YKrnUgWgtnnIIt+39mjQLGJjZI9WcmYGULNEqjt8ngp9lF9MPtXJid
         4JXvtH94CmaNaA67XvUEW5RqzRlX4VH/u8qsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ll/XCn4eT+mWamanV6qNk4+X9BXYFUW6oQ8MurM5uWk=;
        b=cpTi9rnjeVVfchw622CRw89KiKPz1CdFB2WRK7qsdmkKQFiHQrKM8ZM3hzDeRFDhYJ
         iv3QHuvRfph26XNvFXrBEyF36bBE6/59YhqbaYnaM5F0GgUoZlfQfayCdSWq0Rcy6N+g
         mKpP4fTPuDWJnDyjcS7aTHTvwiOdwfkR3hmcIJ4hO0qCgxHQyDB8QPg33XLm5tliNfu3
         HMpDCUE/cwIhbcI+bjiqWS8z0IJ/P10YcsqWK5ie5tR8Wh1JUejkdZKhbRtg3dwbRZ7Y
         HElKjPv9xeTVjBW5hzeIrQTgrhuYLEwxXGOlcgIq377XqfsjfCRZSCfTbnqgI3SgkG8t
         2rKA==
X-Gm-Message-State: AOAM533enmS59AsYB5faaB0E+x52mPYCYh6muKIjis3BGPh1isKxNt4I
        T97M6ScpAsiSPAwruhEAj4P9Aj8QEZklX2Uz
X-Google-Smtp-Source: ABdhPJwLFgE+zzA0chNx5azY5TJw6VS/bLv9kADQhZTmXcHj5oaoawqqaH0X9Fh9MKR0VFmANZLmdQ==
X-Received: by 2002:a19:8c4b:0:b0:44a:b6a4:4873 with SMTP id i11-20020a198c4b000000b0044ab6a44873mr23636723lfj.549.1649741901175;
        Mon, 11 Apr 2022 22:38:21 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id j5-20020a196e05000000b0046ba00b5e88sm755475lfc.230.2022.04.11.22.38.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 22:38:20 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id x33so23844465lfu.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 22:38:19 -0700 (PDT)
X-Received: by 2002:ac2:5483:0:b0:46b:9dc3:cdd4 with SMTP id
 t3-20020ac25483000000b0046b9dc3cdd4mr8854787lfk.542.1649741899091; Mon, 11
 Apr 2022 22:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2204111023230.6206@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wijDnLH2K3Rh2JJo-SmWL_ntgzQCDxPeXbJ9A-vTF3ZvA@mail.gmail.com> <alpine.LRH.2.02.2204111236390.31647@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2204111236390.31647@file01.intranet.prod.int.rdu2.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Apr 2022 19:37:44 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgsHK4pDDoEgCyKgGyo-AMGpy1jg2QbstaCR0G-v568yg@mail.gmail.com>
Message-ID: <CAHk-=wgsHK4pDDoEgCyKgGyo-AMGpy1jg2QbstaCR0G-v568yg@mail.gmail.com>
Subject: Re: [PATCH] stat: don't fail if the major number is >= 256
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 7:13 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> Should we perhaps hash the number, take 16 bits of the hash and hope
> than the collision won't happen?

That would "work", but I think it would be incredibly annoying to
users with basically random results.

I think the solution is to just put the bits in the high bits. Yes,
they might be masked off if people use 'MAJOR()' to pick them out, but
the common "compare st_dev and st_ino" model at least works. That's
the one that wants unique numbers.

> For me, the failure happens in cp_compat_stat (I have a 64-bit kernel). In
> struct compat_stat in arch/x86/include/asm/compat.h, st_dev and st_rdev
> are compat_dev_t which is 16-bit. But they are followed by 16-bit
> paddings, so they could be extended.

Ok, that actually looks like a bug.

The compat structure should match the native structure.  Those "u16
__padX" fields seem to be just a symptom of the bug.

The only user of that compat_stat structure is the kernel, so that
should just be fixed.

Of course, who knows what the libraries have done, so user space could
still have screwed up.

> If you have a native 32-bit kernel, it uses 'struct stat' defined at the
> beginning of arch/x86/include/uapi/asm/stat.h that has 32-bit st_dev and
> st_rdev.

Correct. It's literally the compat structure that has no basis in reality.

Or it might be some truly ancient thing, but I really don't think so.

Regardless, if we fill in the high 16 bits of that field, in the
_worst_ case things will act as if your patch had been applied, but in
any sane case you'll have that working "unique st_dev" thing.

I'd love to actually use the better "modern" 64-bit encoding (12+20
bits, or whatever it is we do, too lazy to look it up), but hey, that
historical thing is what it is.

Realistically, nobody uses it. Apparently your OpenWatcom use is also
really just fairly theoretical, not some "this app is used by people
and doesn't work with a filesystem on NVMe".

                 Linus
