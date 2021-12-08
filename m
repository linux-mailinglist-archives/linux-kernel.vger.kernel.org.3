Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225E346DC5F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 20:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbhLHThg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 14:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239687AbhLHThe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 14:37:34 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D42AC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 11:34:02 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id x5so3413444pfr.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 11:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jSyNpPfNL4nv3Nl83ASritesFLf9KF/N3krCSnAdabQ=;
        b=bMWE1jjtcEd3GyI6Fva9foJZbVg/olBS/RBGK3oLaGOZ6RQzFIQIlnJZXMeC7Y6VBM
         VH+yw7rAzPbBrS/Yy/kNSbKRDec9NOzG6PX9Ub8ChObF8OfbDEPypZuCuayiIllcNR3D
         p3TpK3IQMVbFVvlAlNGNoDDU1XTBYAQXTDUqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jSyNpPfNL4nv3Nl83ASritesFLf9KF/N3krCSnAdabQ=;
        b=a4IE2QpFO2C0/jywS6EQLK5uOW9kEN7oB3Oor9reBZsabMMdTEpLl5ziqqZ4ieWUFI
         8m16vp1qWV6o3aLmX4cngsQMzLdOjXFgckNHMVU8g9hHFeFm0ZsreerFQnJY1QWc/0uw
         nYReRT3fz9HErrI0fjYnKq6RpHaFeNFevIKDWBOE/T9Bglt4Vm6AJxgXgEAF2PBkSz5r
         hbwVkSnTOL2smXaY3Y9o81i1zIv1ERC7Bp64o+yLX2Sfzxe8UmYJOW7aok3v6gH2vjCT
         Gid4hjYN1ThTxjaWquc42NBurT/q4S6AfxMQ1y+eVaZt1UNDUJhCV8uJQBQ0MfT1lQY7
         JNyw==
X-Gm-Message-State: AOAM5306R0ZRLzC6I0HVdypPmIoK+P824cj8mfAIKWvSHFG3N7hRKb9+
        6Z49AP/nGWxjTU/S/LV7hJz8Jw==
X-Google-Smtp-Source: ABdhPJwfrmO6OuC4sSleROZVDgGz/w8i3eLzLrZ/yRIIlrGfRu+NcjCkwWuRt2QOUlIgndclg1Ga5A==
X-Received: by 2002:aa7:979a:0:b0:4a7:e510:ac1c with SMTP id o26-20020aa7979a000000b004a7e510ac1cmr7386686pfp.71.1638992041775;
        Wed, 08 Dec 2021 11:34:01 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m24sm3333830pgk.39.2021.12.08.11.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 11:34:01 -0800 (PST)
Date:   Wed, 8 Dec 2021 11:34:00 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] find: Do not read beyond variable boundaries on small
 sizes
Message-ID: <202112081128.08F5C41F8@keescook>
References: <20211203100846.3977195-1-keescook@chromium.org>
 <YaoN6wnNezMvyyd5@smile.fi.intel.com>
 <20211203182638.GA450223@lapt>
 <202112031450.EFE7B7B4A@keescook>
 <20211207233930.GA3955@lapt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207233930.GA3955@lapt>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 03:39:30PM -0800, Yury Norov wrote:
> I'm all for enabling -Warray-bounds, but the warnings that it spots
> only convinced me that bitmap API is used wrongly, and it should be
> fixed. Can you please share the list of bitmap-related issues found
> with -Warray-bounds that concerned you? I'll take a look and try to
> make a patch that fixes it.

On an x86 allmodconfig with -Warray-bounds, here are the bitmap
warnings:


In file included from ./include/linux/bitmap.h:9,
                 from ./include/linux/cpumask.h:12,
                 from ./arch/x86/include/asm/cpumask.h:5,
                 from ./arch/x86/include/asm/msr.h:11,
                 from ./arch/x86/include/asm/processor.h:22,
                 from ./arch/x86/include/asm/cpufeature.h:5,
                 from ./arch/x86/include/asm/thread_info.h:53,
                 from ./include/linux/thread_info.h:60,
                 from ./arch/x86/include/asm/preempt.h:7,
                 from ./include/linux/preempt.h:78,
                 from ./include/linux/spinlock.h:55,
                 from ./include/linux/wait.h:9,
                 from ./include/linux/wait_bit.h:8,
                 from ./include/linux/fs.h:6,
                 from ./include/linux/debugfs.h:15,
                 from drivers/bus/mhi/core/init.c:7:
drivers/bus/mhi/core/init.c: In function 'to_mhi_pm_state_str':
./include/linux/find.h:187:37: warning: array subscript 'long unsigned int[0]' is partly outside array bounds of 'enum mhi_pm_state[1]' [-Warray-bounds]
  187 |                 unsigned long val = *addr & GENMASK(size - 1, 0);
      |                                     ^~~~~
drivers/bus/mhi/core/init.c:80:51: note: while referencing 'state'
   80 | const char *to_mhi_pm_state_str(enum mhi_pm_state state)
      |                                 ~~~~~~~~~~~~~~~~~~^~~~~

In file included from ./include/linux/bitmap.h:9,
                 from ./include/linux/cpumask.h:12,
                 from ./include/linux/smp.h:13,
                 from ./include/linux/lockdep.h:14,
                 from ./include/linux/mutex.h:17,
                 from ./include/linux/notifier.h:14,
                 from ./include/linux/clk.h:14,
                 from drivers/irqchip/irq-ingenic-tcu.c:7:
drivers/irqchip/irq-ingenic-tcu.c: In function 'ingenic_tcu_intc_cascade':
./include/linux/find.h:40:23: warning: array subscript 'long unsigned int[0]' is partly outside array bounds of 'uint32_t[1]' {aka 'unsigned int[1]'} [-Warray-bounds]
   40 |                 val = *addr & GENMASK(size - 1, offset);
      |                       ^~~~~
drivers/irqchip/irq-ingenic-tcu.c:30:18: note: while referencing 'irq_reg'
   30 |         uint32_t irq_reg, irq_mask;
      |                  ^~~~~~~

In file included from ./include/linux/bitmap.h:9,
                 from ./include/linux/cpumask.h:12,
                 from ./include/linux/smp.h:13,
                 from ./include/linux/lockdep.h:14,
                 from ./include/linux/mutex.h:17,
                 from ./include/linux/notifier.h:14,
                 from ./include/linux/clk.h:14,
                 from drivers/irqchip/irq-ingenic-tcu.c:7:
./include/linux/find.h:40:23: warning: array subscript 'long unsigned int[0]' is partly outside array bounds of 'uint32_t[1]' {aka 'unsigned int[1]'} [-Warray-bounds]
   40 |                 val = *addr & GENMASK(size - 1, offset);
      |                       ^~~~~
drivers/irqchip/irq-ingenic-tcu.c:30:18: note: while referencing 'irq_reg'
   30 |         uint32_t irq_reg, irq_mask;
      |                  ^~~~~~~

In file included from ./include/linux/bitmap.h:9,
                 from drivers/iommu/intel/iommu.c:17:
drivers/iommu/intel/iommu.c: In function 'domain_context_mapping_one':
./include/linux/find.h:119:37: warning: array subscript 'long unsigned int[0]' is partly outside array bounds of 'int[1]' [-Warray-bounds]
  119 |                 unsigned long val = *addr & GENMASK(size - 1, 0);
      |                                     ^~~~~
drivers/iommu/intel/iommu.c:2115:18: note: while referencing 'max_pde'
 2115 |         int pds, max_pde;
      |                  ^~~~~~~

In file included from ./include/linux/bitmap.h:9,
                 from ./include/linux/cpumask.h:12,
                 from ./arch/x86/include/asm/cpumask.h:5,
                 from ./arch/x86/include/asm/msr.h:11,
                 from ./arch/x86/include/asm/processor.h:22,
                 from ./arch/x86/include/asm/cpufeature.h:5,
                 from ./arch/x86/include/asm/thread_info.h:53,
                 from ./include/linux/thread_info.h:60,
                 from ./arch/x86/include/asm/preempt.h:7,
                 from ./include/linux/preempt.h:78,
                 from ./include/linux/spinlock.h:55,
                 from ./include/linux/swait.h:7,
                 from ./include/linux/completion.h:12,
                 from drivers/iio/adc/stmpe-adc.c:10:
drivers/iio/adc/stmpe-adc.c: In function 'stmpe_adc_probe':
./include/linux/find.h:98:23: warning: array subscript 'long unsigned int[0]' is partly outside array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Warray-bounds]
   98 |                 val = *addr | ~GENMASK(size - 1, offset);
      |                       ^~~~~
drivers/iio/adc/stmpe-adc.c:258:13: note: while referencing 'norequest_mask'
  258 |         u32 norequest_mask = 0;
      |             ^~~~~~~~~~~~~~

In file included from ./include/linux/bitmap.h:9,
                 from ./include/linux/cpumask.h:12,
                 from ./arch/x86/include/asm/cpumask.h:5,
                 from ./arch/x86/include/asm/msr.h:11,
                 from ./arch/x86/include/asm/processor.h:22,
                 from ./arch/x86/include/asm/cpufeature.h:5,
                 from ./arch/x86/include/asm/thread_info.h:53,
                 from ./include/linux/thread_info.h:60,
                 from ./arch/x86/include/asm/preempt.h:7,
                 from ./include/linux/preempt.h:78,
                 from ./include/linux/spinlock.h:55,
                 from ./include/linux/swait.h:7,
                 from ./include/linux/completion.h:12,
                 from drivers/iio/adc/stmpe-adc.c:10:
./include/linux/find.h:98:23: warning: array subscript 'long unsigned int[0]' is partly outside array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Warray-bounds]
   98 |                 val = *addr | ~GENMASK(size - 1, offset);
      |                       ^~~~~
drivers/iio/adc/stmpe-adc.c:258:13: note: while referencing 'norequest_mask'
  258 |         u32 norequest_mask = 0;
      |             ^~~~~~~~~~~~~~


I expect there are more outside of x86 allmodconfig. I still think it
makes sense to have a single API that is forgiving with its inputs. We
can change the API in one place and solve this for all callers.

-- 
Kees Cook
