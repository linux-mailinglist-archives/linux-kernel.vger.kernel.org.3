Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84F84DB8E1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 20:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349674AbiCPTaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 15:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243997AbiCPTaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 15:30:23 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDC23A735
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 12:29:08 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id s29so5398897lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 12:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kXm3aPGa6kumOLc0BpQgk8B33A75Ce44sP5rN5yEc48=;
        b=UM0MNayjkbqgfu1XWtyQYDhdQX7mfqFrOqJ5oTFXnVWReMsB2OW0NJS9z0mNjhhG7T
         N2kjjSIYqHXhSCpdeX1kH9/ZaHtGOMLhLlpsRan74z8rXHQzlg/+zNFykJGOa5jH7x5Y
         O3ezJcxIGCKF6PpACvz1gCAsDUwBPb8o3fyzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kXm3aPGa6kumOLc0BpQgk8B33A75Ce44sP5rN5yEc48=;
        b=Of80Eb9H8hZBwnxLEdv5i/4b1KdQuuJLEqsy3y94SQqpMln4plkiPOfVkfLeTPnAKH
         o6m4wb+uy9YuyOvQxqOu1TcsrU7ncegq2Bej4Ck6NPX6oKqDi0lh9h5OM/bKvGXuPHSo
         93qQbAc1GPR8ngTQMAtpD5fQZI23hLECzJzx8e+oGVUNzLob/Qfue9MS9Gu5mSEq1i1X
         GrG3QVoXRuE439V45ujfdNaLECNIz8CF01Ge5rcnXK7iyfA/ztR2XQ5nr/vlajBxTqAG
         Vt6SE2EszLMe3kPL8NObE8pieEVXWQtQ8i2GOQjMJm4TGwPfrX3ji2FiuNOjQsZYgvQh
         XFew==
X-Gm-Message-State: AOAM5302t9KGk3GjihAAvIfxS3LCmE+LzFoZZL0j0W4xP5xRyTJ2pZXj
        KGofxs73IP+sUvzTEf8Fe4iR0SO3c3eNgbyAIX8=
X-Google-Smtp-Source: ABdhPJybosOT0C55mB5ZrnQw+GrMHTi1EzDlMZ0J/e2O/kAIsY3RAKD8sKsgkP2r78lWDq6+S0n6FA==
X-Received: by 2002:a19:8c54:0:b0:448:2271:57d3 with SMTP id i20-20020a198c54000000b00448227157d3mr719693lfj.482.1647458946134;
        Wed, 16 Mar 2022 12:29:06 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id t10-20020ac24c0a000000b004435eefa4efsm248655lfq.269.2022.03.16.12.29.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 12:29:03 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id u7so4422071ljk.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 12:29:03 -0700 (PDT)
X-Received: by 2002:a2e:6f17:0:b0:248:124:9c08 with SMTP id
 k23-20020a2e6f17000000b0024801249c08mr671918ljc.506.1647458942587; Wed, 16
 Mar 2022 12:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000085b1b305da5a66f3@google.com>
In-Reply-To: <00000000000085b1b305da5a66f3@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Mar 2022 12:28:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjLNbf7viXP74K59jK=sRkg6mUbj0i3qpQvy9_2S4Lbtg@mail.gmail.com>
Message-ID: <CAHk-=wjLNbf7viXP74K59jK=sRkg6mUbj0i3qpQvy9_2S4Lbtg@mail.gmail.com>
Subject: Re: [syzbot] WARNING: kmalloc bug in snd_pcm_plugin_alloc (2)
To:     syzbot <syzbot+72732c532ac1454eeee9@syzkaller.appspotmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Willy Tarreau <w@1wt.eu>
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

On Wed, Mar 16, 2022 at 11:51 AM syzbot
<syzbot+72732c532ac1454eeee9@syzkaller.appspotmail.com> wrote:
>
> WARNING: CPU: 1 PID: 3761 at mm/util.c:591 kvmalloc_node+0x121/0x130 mm/util.c:591
>  snd_pcm_plugin_alloc+0x570/0x770 sound/core/oss/pcm_plugin.c:71
>  snd_pcm_plug_alloc+0x20d/0x310 sound/core/oss/pcm_plugin.c:118
>  snd_pcm_oss_change_params_locked+0x19db/0x3bf0 sound/core/oss/pcm_oss.c:1041
>  snd_pcm_oss_change_params sound/core/oss/pcm_oss.c:1104 [inline]
>  snd_pcm_oss_get_active_substream+0x164/0x1c0 sound/core/oss/pcm_oss.c:1121
>  snd_pcm_oss_get_rate sound/core/oss/pcm_oss.c:1778 [inline]
>  snd_pcm_oss_set_rate sound/core/oss/pcm_oss.c:1770 [inline]
>  snd_pcm_oss_ioctl+0x144f/0x3430 sound/core/oss/pcm_oss.c:2632

Well, that looks like a real bug in the sound subsystem, and the
warning is appropriate.

It looks like

        size = frames * format->channels * width;

can overflow 32 bits, and this is presumably user-triggerable with
snd_pcm_oss_ioctl().

Maybe there's some range check at an upper layer that is supposed to
catch this, but I'm not seeing it.

I think the simple fix is to do

        size = array3_size(frames, format->channels, width);

instead, which clamps the values at the maximum size_t.

Then you can trivially check for that overflow value (SIZE_MAX), but
you can - and probably should - just check for some sane value.
INT_MAX comes to mind, since that's what the allocation routine will
warn about.

But you can also say "Ok, I have now used the 'array_size()' function
to make sure any overflow will clamp to a very high value, so I know
I'll get an allocation failure, and I'd rather just make the allocator
do the size checking, so I'll add __GFP_NOWARN at allocation time and
just return -ENOMEM when that fails".

But that __GFP_NOWARN is *ONLY* acceptable if you have actually made
sure that "yes, all my size calculations have checked for overflow
and/or done that SIZE_MAX clamping".

Alternatively, you can just do each multiplication carefully, and use
"check_mul_overflow()" by hand, but it's a lot more inconvenient and
the end result tends to look horrible. There's a reason we have those
"array_size()" and "array3_size()" helpers.

There is also some very odd and suspicious-looking code in
snd_pcm_oss_change_params_locked():

        oss_period_size *= oss_frame_size;

        oss_buffer_size = oss_period_size * runtime->oss.periods;
        if (oss_buffer_size < 0) {
                err = -EINVAL;
                goto failure;
        }

which seems to think that checking the end result for being negative
is how you check for overflow. But that's actually after the
snd_pcm_plug_alloc() call.

It looks like all of this should use "check_mul_overflow()", but it
presumably also wants fixing (and also would like to use the
'array_size()' helpers, but note that those take a 'size_t', so you do
want to check for negative values *before* if you allow zeroes
anywhere else)

If you don't mind "multiplying by zero will hide a negative
intermediate value", you can pass in 'ssize_t' arguments, do the
multiplication as unsigned, put the result in a 'ssize_t' value, and
just check for a negative result.

That would seem to be acceptable here, and that
snd_pcm_oss_change_params_locked() code could also just be

        oss_period_size = array_size(oss_period_size, oss_frame_size);
        oss_buffer_size = array_size(oss_period_size, runtime->oss.periods);
        if (oss_buffer_size < 0) {
                ...

but I would suggest checking for a zero result too, because that can
hide the sub-parts having been some invalid crazy values that can also
cause problems later.

Takashi?

                 Linus
