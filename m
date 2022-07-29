Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6A5584A47
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 05:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbiG2Dqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 23:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiG2Dql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 23:46:41 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279D57B1F0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 20:46:41 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id bb16so4567532oib.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 20:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t9Hv4FAjpVoAbdJGuv6SEIg1X0dUXbfyUSHqr/roPps=;
        b=VPdTq/44bRH7YGcgocbPRNPG9MzRdzGYV0BzglXmDlk2acrs76P7NiofkI97I3GX+9
         WlJ6hiKtabeiJoimrxtorJBdNSYDgLIa0Epb7EGhiXHbx7gkKzTkeEQ5oWMTsmSQhogS
         Vro/f+SMdYuUZyfKC+JIvfOlTtaT7EQs3GR2lLl5J6Lgkp/CCAIEQYmqpuVtrdsb/r1s
         7+7LNfaHnyv9QlABO/4jjtftX2AtL54CQAFw7nG14CU4cWrzbTWDgPGNXPff583kdtKg
         +YFMXx7Cn7xvXBx68nT7sOBgstKXCPss46N+ezAIxBuTIFzNmxvwUGC85//cI+IfZJr8
         PT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=t9Hv4FAjpVoAbdJGuv6SEIg1X0dUXbfyUSHqr/roPps=;
        b=6426JLVRPrwaJC8pfTFcsDUC+2To6t7qQA2UVjC3g6oHJqIuibA/Zbt4peiN6hAFv1
         Og0QU9zZO/fGa+I80UKZIUUtuU16FgvGMwdjXp+MuuA2XPJtOoG6aPeZlsx2LuTv4Wdg
         LZJoH2FIuD6XRPLbRG9lrGBBN+hugSU6B3aK7Ugt+BRCbUvzN3nuOr2BHWLdhYPDiuKV
         VnhI/uph/P1Yh+JvML+avkojV8VN8zXN/471x7Uz3c+x0GzAX3unP/d2ZfZ3lKDOAnQb
         6QnqgVPzIZxejxJI7OruC3kPGRCss4qRtkby60n0c9IhWw/6u1bsR/goNnNEC+Iq53s8
         qWFw==
X-Gm-Message-State: AJIora8NNnYnOpJUEGlOmwC2KesO4BRr/qE14Tmeinen1lJek8IR7Sw4
        fjm7yuEL+9sF5YydaclcHLY=
X-Google-Smtp-Source: AGRyM1tbZEM1cQsm182QmmKW/QYSvVlPbnnJTYT1hP47JCY+plzxIbYVua7sFY/Sp2Uy06cKkCDWAw==
X-Received: by 2002:a05:6808:14d2:b0:33a:d0e1:1230 with SMTP id f18-20020a05680814d200b0033ad0e11230mr806858oiw.261.1659066400502;
        Thu, 28 Jul 2022 20:46:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c3-20020a9d6843000000b0061c94e755d8sm1027812oto.58.2022.07.28.20.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 20:46:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 28 Jul 2022 20:46:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Kees Cook <keescook@chromium.org>,
        Keith Busch <kbusch@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: Re: [PATCH 5/5] lib/nodemask: inline next_node_in() and node_random()
Message-ID: <20220729034638.GA2276915@roeck-us.net>
References: <20220711044711.466822-1-yury.norov@gmail.com>
 <20220711044711.466822-6-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711044711.466822-6-yury.norov@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 10, 2022 at 09:47:11PM -0700, Yury Norov wrote:
> The functions are pretty thin wrappers around find_bit engine, and
> keeping them in c-file prevents compiler from small_const_nbits()
> optimization, which must take place for all systems with MAX_NUMNODES
> less than BITS_PER_LONG (default is 16 for me).
> 
> Moving them in header file doesn't blow up the kernel size:
> add/remove: 1/2 grow/shrink: 9/5 up/down: 968/-88 (880)
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

This patch results in

Building powerpc:allmodconfig ... failed
--------------
Error log:
In file included from include/linux/nodemask.h:97,
                 from include/linux/sched.h:22,
                 from include/linux/sched/mm.h:7,
                 from arch/powerpc/lib/feature-fixups.c:16:
include/linux/random.h: In function 'add_latent_entropy':
include/linux/random.h:25:46: error: 'latent_entropy' undeclared

and many more similar errors when trying to compile ppc:allmodconfig.

Guenter

---
# bad: [7c5e07b73ff3011c9b82d4a3286a3362b951ad2b] Add linux-next specific files for 20220728
# good: [e0dccc3b76fb35bb257b4118367a883073d7390e] Linux 5.19-rc8
git bisect start 'HEAD' 'v5.19-rc8'
# good: [96bce6a87ad9690eaa9b1ca9ace7c98444d7869f] Revert "Revert "drm/amdgpu: add drm buddy support to amdgpu""
git bisect good 96bce6a87ad9690eaa9b1ca9ace7c98444d7869f
# good: [6826ff5991a129f39064118771333e494e866056] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
git bisect good 6826ff5991a129f39064118771333e494e866056
# good: [df0b60ba0ccf758c3db940b965c019fc1d3e653a] Merge branch 'char-misc-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
git bisect good df0b60ba0ccf758c3db940b965c019fc1d3e653a
# good: [eb8489c7931473c1d1c2a122ac84317ba2c6cff6] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching
git bisect good eb8489c7931473c1d1c2a122ac84317ba2c6cff6
# good: [4724a9771b17c1fb2409c2b50d9bf9ae65262d9a] Merge branch 'mm-nonmm-unstable' into mm-everything
git bisect good 4724a9771b17c1fb2409c2b50d9bf9ae65262d9a
# good: [50186f0b6f5020051f58b5b865a0abc97483700a] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
git bisect good 50186f0b6f5020051f58b5b865a0abc97483700a
# good: [03b33c09ea22fa89dd204ad0a2058e512c691b9f] fs: remove the NULL get_block case in mpage_writepages
git bisect good 03b33c09ea22fa89dd204ad0a2058e512c691b9f
# good: [c28fab17145d04eceac245c4839e65582b4d3083] Merge branch 'rust-next' of https://github.com/Rust-for-Linux/linux.git
git bisect good c28fab17145d04eceac245c4839e65582b4d3083
# bad: [9f0b715d001153c4002b39f2e1acdf9183e3735b] lib/nodemask: inline next_node_in() and node_random()
git bisect bad 9f0b715d001153c4002b39f2e1acdf9183e3735b
# good: [b0b0b77ea611e3088e9523e60860f4f41b62b235] iommu/vt-d: avoid invalid memory access via node_online(NUMA_NO_NODE)
git bisect good b0b0b77ea611e3088e9523e60860f4f41b62b235
# good: [9b2e70860ef2f0d74b6d9e57929d57b14481b9c9] lib/cpumask: move trivial wrappers around find_bit to the header
git bisect good 9b2e70860ef2f0d74b6d9e57929d57b14481b9c9
# good: [7343f2b0db4961d9f386e685e651c663dc763d0c] headers/deps: mm: align MANITAINERS and Docs with new gfp.h structure
git bisect good 7343f2b0db4961d9f386e685e651c663dc763d0c
# good: [3a2ba42cbd0b669ce3837ba400905f93dd06c79f] x86/olpc: fix 'logical not is only applied to the left hand side'
git bisect good 3a2ba42cbd0b669ce3837ba400905f93dd06c79f
# good: [c3aaaf9e2ada48c0e3d03203ca6458362a639c2c] powerpc: drop dependency on <asm/machdep.h> in archrandom.h
git bisect good c3aaaf9e2ada48c0e3d03203ca6458362a639c2c
# first bad commit: [9f0b715d001153c4002b39f2e1acdf9183e3735b] lib/nodemask: inline next_node_in() and node_random()
