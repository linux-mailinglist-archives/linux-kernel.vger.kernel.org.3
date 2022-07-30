Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07DC585B84
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 20:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbiG3SPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 14:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiG3SPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 14:15:08 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284BA11C36
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 11:15:07 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-10bd4812c29so9202222fac.11
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 11:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=AV37Ed7YOZ0S/U4KXZNq93kgcOKE/yFuDjXhB9YSKcw=;
        b=Kof/HcsqvZZTkQVgMo8Tf2WaoBZ9fG9wPg0OYNNjp1ja6+Tk7/811P2Nh383pKjzZH
         DhBgUH812AD2BvDRcL/oKG0em8X0j9pXPGLUyVTGe9L4ujdprC/FCYpao8YkfWTg5ym7
         vvkFrvP9jQfoCKytfoT8j4smqNu2LNGy813Boj8ASnOGPgj44N3SG8zYF5rWxsaa/we1
         7XBMgiMdWzY7Aroxp83ibd8mp61IblHERfc+sGcX5JWzZORy3sWnae+fUG1JVx9kC6ry
         S+c1+ktomp84bkaYH9vriBtfKpCRLfrUUnIeepJKkwcps3WpFLJVozN47fW/0MpQYLGG
         DH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=AV37Ed7YOZ0S/U4KXZNq93kgcOKE/yFuDjXhB9YSKcw=;
        b=RDyjTXiuBxHTGZ+ld/CufIz2EmoLM4uO6cC2skLngui1pFbCeQCP9c2l2+PqMnJujh
         c8UYnx4eEqVG8gDn7sH5RzCR0qyPg9GJjQz6h1YNFv2HwGyk8zGbq8Gd2by3Ct4Ok8Gj
         O3MCxGCbXh9wcQgwCRHuWoYlvM6ASsi/lFJJDnlqZgpeOowyJm3UVImlmc6gKjtDAP9V
         Q5xy47VJF4XflB5Y91HnXQkKKrToiKP2MhNV+W5Kf+IX5/bdbnnPqdfs01nTJj8SL8Po
         hK3KmUvObFEagseO9LQhgFuTIRMt+RPkzqIyvcCs9XWSzDLQjBQAbDc2pe0LtKbdgAGA
         bWXA==
X-Gm-Message-State: AJIora9tgjNkgBPPDTAQocXP8fRchiserxXDpr16Lp9K6TM3E3CCH3BM
        WUtBcp3tCbZA9u2Feqh5O3Y=
X-Google-Smtp-Source: AGRyM1sxo3lcXMReFqFkSqYnWMS89g8jrlHFYvtQYBrEYrOJL9PWv6sobuwQhVdDBRT771uxFRAnDA==
X-Received: by 2002:a05:6870:5489:b0:10e:7821:bf57 with SMTP id f9-20020a056870548900b0010e7821bf57mr4194760oan.167.1659204906446;
        Sat, 30 Jul 2022 11:15:06 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id m15-20020a4ad50f000000b004320b0cc5acsm1864587oos.48.2022.07.30.11.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 11:15:05 -0700 (PDT)
Date:   Sat, 30 Jul 2022 11:15:03 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Gow <davidgow@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
        Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v5 0/5] cpumask: fix invalid uniprocessor assumptions
Message-ID: <YuV1J7Zt+NzkrWeV@yury-laptop>
References: <cover.1659077534.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1659077534.git.sander@svanheule.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 09:01:17AM +0200, Sander Vanheule wrote:
> On uniprocessor builds, it is currently assumed that any cpumask will
> contain the single CPU: cpu0. This assumption is used to provide
> optimised implementations.
> 
> The current assumption also appears to be wrong, by ignoring the fact
> that users can provide empty cpumasks. This can result in bugs as
> explained in [1] - for_each_cpu() will run one iteration of the loop
> even when passed an empty cpumask.
> 
> This series introduces some basic tests, and updates the optimisations
> for uniprocessor builds.
> 
> The x86 patch was written after the kernel test robot [2] ran into a
> failed build. I have tried to list the files potentially affected by the
> changes to cpumask.h, in an attempt to find any other cases that fail on
> !SMP. I've gone through some of the files manually, and ran a few cross
> builds, but nothing else popped up. I (build) checked about half of the
> potientally affected files, but I do not have the resources to do them
> all. I hope we can fix other issues if/when they pop up later.
> 
> [1] https://lore.kernel.org/all/20220530082552.46113-1-sander@svanheule.net/
> [2] https://lore.kernel.org/all/202206060858.wA0FOzRy-lkp@intel.com/
 
Hi Sander,

I tried to apply it on top of bitmap-for next, and there are many conflicts
with already pulled patches. There's nothing really scary, just functions
changed their prototypes and locations. Can you try your series on top of
bitmap-for-next from git@github.com:/norov/linux.git (or just -next)? 

I'm asking you to do it instead of doing myself because I don't want to
screwup your code accidentally and because many cpumask functions in -next
are moved to the header, and it would be probably possible to avoid building 
cpumask.o in UP case.

Briefly looking into the -next code, cpumask.c hosts  only cpumask_next_wrap() 
that is not overwritten by UP code, and in UP case it can be simplified.

Thanks,
Yury
