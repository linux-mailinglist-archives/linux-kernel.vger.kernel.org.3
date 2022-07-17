Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE5B577706
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 17:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbiGQPVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 11:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbiGQPVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 11:21:08 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C5913F49
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 08:21:05 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l23so17213183ejr.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 08:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j6Np8nI/vT4UK8NVILVHU1cnR7rvPe+g277Fy8916Js=;
        b=I1yznyTToKaIIYJ20zId0bQod87jVEJArYH+v6do3JO41FTndfWOfXYj/jmtObj9L2
         p6Ziht8h3ZNBlPX3zF445CM/rWSjvMesngZMB0+vL5oLS9gDoeLm1Ruulzu3aMuOy9wE
         3rbjK9UuR6+l/M+SSSgQhTr0VLRKaOBRxsXdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j6Np8nI/vT4UK8NVILVHU1cnR7rvPe+g277Fy8916Js=;
        b=pSGn4xEs19wXEpVjNrvMLt4VPeLqFDJK4ggwF7FvZ0409dIM2SKR7eWZ+yRToxHEPx
         t9P7gdD7aKaknyPcsC4Dlff03IwDCzguJuaAFSEeYGzpzfmALrC7A4Lq8An7iqU3qqgl
         o+VpntE2gWLX7AuA9FRPuvu3nqQhNLQb47W6UqjI/B04kHch/GQ+ejY5Tcg7BWVcftld
         GCWbPRiGFOhO/gK57xeeu1llBh1T1+h2xY/2b910tfL6aB0LX/7owfdPUq5+1AdH/At7
         xQDUK3Qair5dNRCFdGUkTsKD+M8+x7X11CSm/5aMkzQyym25krKIOt7Uqi+zdmtflv9x
         tutg==
X-Gm-Message-State: AJIora/ImCr/Zczqbnav/xrWUy0IV6Zyrl5CsdmSbYuIN/t4XFcUhwlM
        ogd/gVuTtYIBIz5toFgWe87MuDmSvTj2EH47
X-Google-Smtp-Source: AGRyM1uhRqJCvE5UjzlRqKBcdcuKKnqagMll+AB0nfRq4PjlQ0emAhIe5+2DaL7jWfLJdQ1giStnNw==
X-Received: by 2002:a17:907:1c1f:b0:72f:1ccc:bc3f with SMTP id nc31-20020a1709071c1f00b0072f1cccbc3fmr5497896ejc.281.1658071264106;
        Sun, 17 Jul 2022 08:21:04 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id r18-20020a17090609d200b006feed200464sm4397088eje.131.2022.07.17.08.21.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Jul 2022 08:21:02 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id e15so8368946wro.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 08:21:02 -0700 (PDT)
X-Received: by 2002:a5d:69c2:0:b0:21d:807c:a892 with SMTP id
 s2-20020a5d69c2000000b0021d807ca892mr19806032wrw.274.1658071262235; Sun, 17
 Jul 2022 08:21:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220716230344.239749011@linutronix.de> <20220716230952.787452088@linutronix.de>
 <0bec8fe2-d1e3-f01c-6e52-06ab542efdd8@citrix.com>
In-Reply-To: <0bec8fe2-d1e3-f01c-6e52-06ab542efdd8@citrix.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 17 Jul 2022 08:20:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiAF9KF5x8A8QW+=k_XFyaMgjS74h7gmHRYBB+PXkQ2rQ@mail.gmail.com>
Message-ID: <CAHk-=wiAF9KF5x8A8QW+=k_XFyaMgjS74h7gmHRYBB+PXkQ2rQ@mail.gmail.com>
Subject: Re: [patch 02/38] x86/cpu: Use native_wrmsrl() in load_percpu_segment()
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 5:22 PM Andrew Cooper <Andrew.Cooper3@citrix.com> wrote:
>
> It's only 32bit where the percpu pointer is tied to the GDT.  On 64bit,
> gsbase is good before this, and remains good after.

That sounds sensible to me, but somebody should check that there's
nothing that accidentally relied on the MSR_GS_BASE setting (or the
segment selector clearing, for that matter).

Not that I can necessarily see how anything could work with it wrong, but..

           Linus
