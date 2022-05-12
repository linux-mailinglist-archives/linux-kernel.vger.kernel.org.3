Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B581524CA1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353639AbiELMX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353066AbiELMXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:23:23 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B881207DC
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:23:21 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id c1so4410866qkf.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/dqcXTObxTtO1V6/bZade+lRAjqtWrFdg0RrAzpzvMc=;
        b=kMzS8vTGcfljyvBPw+zA5U4fV+xgXwoWkeP5GZCv+jUmhDvG7DmroDuFk9j0B0wi6d
         4OWaXMUM/zg1DqHG35P2jypybc3RqSpsGQ9nFhx1iaddGMEtxYA9k5gISq3EtWYescX9
         LOf+M8jVzAvQ3EViKcJDXXkw9/Ua151rwj2tMki7WvgU5aYfsd4erpljcuz9daR0W71n
         MsUbuNWHkONE46UqG5l6O/j7kF/5sRYY7TN8jpd2gdpXLYbUyy28OGetV9xEXj0lf83l
         3m5HRjcOCTV4yZC/W/w+spIhqIZAMAD6f4BXnm1yYsvTXQzWEqokuvqhX/vdxis19I7D
         desg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/dqcXTObxTtO1V6/bZade+lRAjqtWrFdg0RrAzpzvMc=;
        b=HVuJ0cmr1FZDv7Vsm25VkAcrwCixh86ndj/edgJS01gveq1N/IOlnue5W1IQstNbGn
         d1OoUvi7neIx6fRHJtJYG2fdNNzVEs83cIR4MckGGvm9s6P9KwV5pNoOB+k63cKry+Tq
         LYyrhwkjsHLe8am5swE5JAW+yzc4qM6FHvnCyPgrWRFhTuM3OsfmBfTKpouKakhTzIxr
         YyBzsndooc0EJeR2HdtldnM0BQl6ZmGn5M+rGc1fuJfeSlU3BMcNX+DLBqYD+hkwqBZz
         i+qhQPvGXNANYtp6ySWqwW839zuLllkt3092dUMR4PEWXadTrEzlOG5xVG83rMd5sb/r
         W4rQ==
X-Gm-Message-State: AOAM530xJLjNOLgJaF4dR3+yvHzz3l/mUGqxsjA+Or/9MoiqR3JJmwXE
        fuvxyCa7ZW8h5uwC+xK9oYUjaw==
X-Google-Smtp-Source: ABdhPJwzBHgPAHf2HQk8rCbT71hRtFDjr+O1EShN21bHsc+FkfTfeygnqsW74ivRYIADcxGQbTFwhA==
X-Received: by 2002:a05:620a:2545:b0:680:a456:ba9e with SMTP id s5-20020a05620a254500b00680a456ba9emr23013666qko.490.1652358200237;
        Thu, 12 May 2022 05:23:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:14fe])
        by smtp.gmail.com with ESMTPSA id b8-20020a05620a04e800b0069fc13ce22esm2798975qkh.95.2022.05.12.05.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 05:23:19 -0700 (PDT)
Date:   Thu, 12 May 2022 08:23:18 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the mm tree
Message-ID: <Ynz8NusTdEGcCnJN@cmpxchg.org>
References: <20220512194607.74ee330d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512194607.74ee330d@canb.auug.org.au>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 07:46:07PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mm tree, today's linux-next build (powerpc allnoconfig,
> powerpc ppc44x_defconfig and arm64 defconfig) produced this warning:
> 
> WARNING: unmet direct dependencies detected for ARCH_ENABLE_MEMORY_HOTREMOVE
>   Depends on [n]: MEMORY_HOTPLUG [=n]
>   Selected by [y]:
>   - PPC [=y]
> Building: powerpc64 allnoconfig
> 
> WARNING: unmet direct dependencies detected for ARCH_ENABLE_MEMORY_HOTREMOVE
>   Depends on [n]: MEMORY_HOTPLUG [=n]
>   Selected by [y]:
>   - PPC [=y]
> 
> WARNING: unmet direct dependencies detected for ARCH_ENABLE_MEMORY_HOTREMOVE
>   Depends on [n]: MEMORY_HOTPLUG [=n]
>   Selected by [y]:
>   - ARM64 [=y]
> 
> WARNING: unmet direct dependencies detected for ARCH_ENABLE_MEMORY_HOTREMOVE
>   Depends on [n]: MEMORY_HOTPLUG [=n]
>   Selected by [y]:
>   - ARM64 [=y]
> 
> Probably introduced by commit
> 
>   52bc69c65c03 ("mm: Kconfig: group swap, slab, hotplug and thp options into submenus")

Sorry about the noise, I must be blind. And x86 does
  arch/x86/Kconfig:       select ARCH_ENABLE_MEMORY_HOTREMOVE if MEMORY_HOTPLUG
that's why it didn't trigger for me.

This should be the last one, I triple checked the commit.

---

From 588d2c5ba815df3b8028e198b7543a5450c24b33 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Thu, 12 May 2022 08:11:17 -0400
Subject: [PATCH] mm: Kconfig: group swap, slab, hotplug and thp options into
 submenus fix fix

WARNING: unmet direct dependencies detected for ARCH_ENABLE_MEMORY_HOTREMOVE
  Depends on [n]: MEMORY_HOTPLUG [=n]
  Selected by [y]:
  - PPC [=y]

This is a symbol for the architecture to declare a feature. It mustn't
be conditional on user selection. Move it out of 'if MEMORY_HOTPLUG'.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index c2f4a547ab00..f63d8dc36511 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -436,6 +436,9 @@ config HAVE_BOOTMEM_INFO_NODE
 config ARCH_ENABLE_MEMORY_HOTPLUG
 	bool
 
+config ARCH_ENABLE_MEMORY_HOTREMOVE
+	bool
+
 # eventually, we can have this option just 'select SPARSEMEM'
 menuconfig MEMORY_HOTPLUG
 	bool "Memory hotplug"
@@ -462,9 +465,6 @@ config MEMORY_HOTPLUG_DEFAULT_ONLINE
 	  Say N here if you want the default policy to keep all hot-plugged
 	  memory blocks in 'offline' state.
 
-config ARCH_ENABLE_MEMORY_HOTREMOVE
-	bool
-
 config MEMORY_HOTREMOVE
 	bool "Allow for memory hot remove"
 	select HAVE_BOOTMEM_INFO_NODE if (X86_64 || PPC64)
-- 
2.35.3

