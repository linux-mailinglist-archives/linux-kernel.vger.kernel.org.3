Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7DD574216
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 06:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiGNEEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 00:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGNEES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 00:04:18 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC87275D5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 21:04:16 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id r9so798211lfp.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 21:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4i9kRRQ3z5mPuTkc7JYERdBNQjh9yJap1kHoFmvgt2E=;
        b=g2PW9IgWmqtqJqypCXqUQuEht8KkrnXHuWybS7uFFKnrHx34x8vzi8X43eSz5cpPvb
         RU/lfqVHLQeGjNLX+ryurrcn/yPW2Egl7H1MeSeBYtzdnBlokD6W8RARKfcKjb9mSx2H
         73RILF0jFfUKLuF5FGMhd/OPwnIQec9eVD6fhIDBujAhXWjaF5ZVDEeTPRM+RA38lta3
         CbfBbR/LhkV9aRqfo/bpb1VYmQ9eVtfovKyQyDNp7caDWiQ3yYWEWfAhEXDkD6YtU9A5
         pLCJ+nf7Q4Lkw0BBYMPFL17FB3rM8R7NuiMeiczNU9IqB6vxc/9VD2zVKLa4ehJ9vxwo
         PvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4i9kRRQ3z5mPuTkc7JYERdBNQjh9yJap1kHoFmvgt2E=;
        b=hw2SmBzplYMqFTQ04L6nJK4otYPgmuFsE4GjWQW8jGLDTCsvWwLjQojO1rsB4T1PQh
         2z4iFzCqy7+ixdLu6dI75p8B7mdghxMp8S552heUSeoiLN0+//YFJQJMc5VzwdmExzne
         gw4z+/LcmRsrNRLsGuwB+BepT4wF13aLyLhFdlT0W++K4rFZZwYo4YOYhuClgO4hU1rs
         BypjJuz7iw7lzmixJGfGD119IouIj25ZNA93fKKVZzRZH7w1GZGaO9uu41QTBrrRImA0
         lyxEMliDDa/IGBtuIRGNvl2NSwQCrrgS5pRbUx0+nUpyihZnHyP3jFtXoNj0WjmejaRa
         Wn8g==
X-Gm-Message-State: AJIora/lR/C0aJ4Ue5n3TTKddWNsHZBOb4wf4mK0l3jeVAmR/XNg3VWo
        NCAnWDlKIMALNpVsRsYiqkb3+4X61Ie85wC7XRA=
X-Google-Smtp-Source: AGRyM1tTXHqt4pCwxoPjOyqf/dZLan2X/Xhis7R50nAsZuWfR4YjfA9pDssH6EMEMRpQ9gggAzyTiGViJC6Jx2ikHYU=
X-Received: by 2002:a05:6512:23aa:b0:489:ddb4:6f84 with SMTP id
 c42-20020a05651223aa00b00489ddb46f84mr3923640lfv.683.1657771454853; Wed, 13
 Jul 2022 21:04:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210623120127.327154589@linutronix.de> <20210623121452.214903673@linutronix.de>
In-Reply-To: <20210623121452.214903673@linutronix.de>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Wed, 13 Jul 2022 21:04:02 -0700
Message-ID: <CANaxB-wkcNKWjyNGFuMn6f6H2DQSGwwQjUgg1eATdUgmM-Kg+A@mail.gmail.com>
Subject: Re: [patch V4 09/65] x86/fpu: Sanitize xstateregs_set()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Chang Seok Bae <chang.seok.bae@intel.com>,
        Megha Dey <megha.dey@linux.intel.com>,
        Oliver Sang <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 5:24 AM Thomas Gleixner <tglx@linutronix.de> wrote:
....
>
> -       /*
> -        * mxcsr reserved bits must be masked to zero for security reasons.
> -        */
> -       xsave->i387.mxcsr &= mxcsr_feature_mask;
> -
> -       /*
> -        * In case of failure, mark all states as init:
> -        */
> -       if (ret)
> -               fpstate_init(&fpu->state);
> +       fpu__prepare_write(fpu);
> +       ret = copy_kernel_to_xstate(&fpu->state.xsave, kbuf ?: tmpbuf);

This change breaks gVisor. Now, when we set a new fpu state without
fp,sse and ymm
via ptrace, mxcsr isn't reset to the default value. The issue is
reproduced only on hosts
without xsaves. On hosts with xsaves, it works as expected.

Thanks,
Andrei
