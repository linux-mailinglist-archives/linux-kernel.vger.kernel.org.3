Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F53248BC6E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347734AbiALB3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347481AbiALB3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:29:03 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9765AC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 17:29:03 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id t18so1665697plg.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 17:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3Z+Ei60w2ioktXiC7mAi86WXP0yiOanAEQdnAPdW938=;
        b=g96MK+3C1r7VhzMPJIHEH+x1e94MnCWzwtZP7Ov4d8ol0ihQ39NJrUFauJSn1EM3x/
         bcAxQ3ssaDf+YU4jpOILUop3Ah0i/FtN9D3PqSUSfYTbAzgPTcMVmQnRHMxywUd6AJUR
         d9BTzd23XMhhYNMIwIjloqkpJJskeSrvAQAI6bkzM9BXAmKF1QbZWLiZ8QK7wifg7UDK
         jleqEV/m18QURVRcmzJFd83KZhvWezj6Kvs05xPP8plJzjnxPA6Z8LEurLPQPo/r4NV2
         7jhxl6p7j7N4YvqCdHxRllszxvK6wIE8okv26dDFOr/DYf1HytgqPzUa3fAO4pxkQvw5
         6UsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Z+Ei60w2ioktXiC7mAi86WXP0yiOanAEQdnAPdW938=;
        b=FSwd1p2XjKNSiM4YD3sz+Wt22/JYBZVa/tCdCK6M/tIDdbaYOX1FSC5uhcSX7X9RHr
         efMzjCaiayBxU7j7BX0cjOQmw0liaWTJbW/jSbR9huX4UzDQvAREgRtHZA+8SdJbjNif
         E8UsIxNBc+Zz1A0ah1DLTllXKoLsZ2D1j8ai4xJxy0CBDZns3gF+/GrdDFmQGwbrvPCR
         5eD0XXNnakxfaLgaJUkjYqBhmGmbNYi9rjF8qtNpPgMB/k+LOULAiSN3fUCV9g9ck5nQ
         d0QNMhFDtp4rP52kk13erHwsDhAHjy/qnCvFgfULIRq+agL6Q5VDg2qLNLIOD33NY042
         UAmw==
X-Gm-Message-State: AOAM530e4e+EAc0GqFw/wP8uKdHTYh5nUyNRCpUm6IHuO38rxTTIrkP7
        onToaUJlhlfCybnJ75gScuv/nA==
X-Google-Smtp-Source: ABdhPJxwdALuACZdnBHuvH6YRa65O5LGXz6cdHNbKd3Ed9cXftu4h5W2A/V0xtTiUXL3THcaE+b7RQ==
X-Received: by 2002:a63:461c:: with SMTP id t28mr6388540pga.547.1641950942978;
        Tue, 11 Jan 2022 17:29:02 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id o186sm11044974pfb.187.2022.01.11.17.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 17:29:02 -0800 (PST)
Date:   Wed, 12 Jan 2022 01:28:58 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [x86/entry_32]  aa93e2ad74:
 BUG:soft_lockup-CPU##stuck_for#s![systemd-logind:#]
Message-ID: <Yd4u2rVVSdpEpwwM@google.com>
References: <20220106083523.GB32167@xsang-OptiPlex-9020>
 <Yd1l0gInc4zRcnt/@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd1l0gInc4zRcnt/@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022, Peter Zijlstra wrote:
> On Thu, Jan 06, 2022 at 04:35:23PM +0800, kernel test robot wrote:
> > 
> > 
> > Greeting,
> > 
> > FYI, we noticed the following commit (built with clang-14):
> > 
> > commit: aa93e2ad7464ffb90155a5ffdde963816f86d5dc ("x86/entry_32: Remove .fixup usage")
> > https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git x86/core
> > 
> > in testcase: kernel-selftests
> > version: 
> > with following parameters:
> > 
> > 	group: x86
> > 
> 
> It would be very useful if this thing would also say which of the many
> x86 selftests fails... it appears to be: ldt_gdt_32.
> 
> The below fixes it, but I'm still not entirely sure what the actual
> problem is, although Andy did find a bug in that the exception handler
> should do: *(ss:esp) = 0, adding ss-base (using insn_get_seg_base())
> doesn't seem to cure things.

Because I was curious...

The issue is that PARANOID_EXIT_TO_KERNEL_MODE in the handle_exception_return
path overwrites the entry stack data with the task stack data, restoring the "bad"
segment value.
