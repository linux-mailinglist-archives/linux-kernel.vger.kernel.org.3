Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00594AAD99
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 04:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbiBFDTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 22:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiBFDTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 22:19:48 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A3FC043186;
        Sat,  5 Feb 2022 19:19:46 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id 10so629520plj.1;
        Sat, 05 Feb 2022 19:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QGk+V+tevAHKhW+yEMe4I8KgmYjwftpUv9T2QF06uWE=;
        b=J4rbAUwx4FzXDA6I/18kBT29+TTryshYioLti4InX/RjYUY/r/dl4EprlBmuuRtfAY
         6tqo3jCfjC3jASzc5pEp7aKLlaBFMBN7+FVbXNwDu5V5HNsoVlxqYfIOUVG+0A6/Bpul
         Jzuh9hENgnNkS5le4n0/ILY4m7blOqy9qxQRLMGATcg0H+TAoOg2fax9/B5yTXuj4d4j
         1FgnTr4Nm87JQfu+hMBH9NqoYFcpW+CaZ2zMMKNmaMTT6GpgcsFhYstOfD/dW3VMogIA
         6NBNdwwZKobUpi3Nr+BYYxnAUReEDzEcHtYg7N2SHMT22kjxcsBT7W2U831Hqc3sxrFt
         PMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QGk+V+tevAHKhW+yEMe4I8KgmYjwftpUv9T2QF06uWE=;
        b=7Ia7+kFaQ71YNOGXbIg4wPFQLyN8gLRE6LxTWIfa8FWx1kvLmRuGrhoVsKSORaQEqe
         xSM169EDGrNPFIpOv4mVAxkPO4V2YQ+jytxVlLPIVbm0l4BuOww4YXB4uKIZsMUP/NqO
         uHFYST+nK6iDiBC9mx8MQyZXDVSyioX/bF+l1R/gBCRFkR/EK3ldLetbr+07VqGrZNQj
         9SwXLyiHTBug+G1Xok9FBgSQwVvzZt3U1/TmJDnasCDFFGgPHgRKOg3tUn8ixkUokUOk
         0+jmJVd9UEBWYwQlDJ+tQNd1F1lrDLBjqfLtmaJDmoZqIy6lTTMUalney2YCEBnapZ6P
         kQPg==
X-Gm-Message-State: AOAM530Q+1Sspf6pOyc6hvePBaTnELPFnD+dQgpAR0dRU0NVUx2btpIJ
        lKC5enzaGDq2wNq8n0hH1DnqQO5Bm93XWx6R
X-Google-Smtp-Source: ABdhPJwiUEKuwoRTFvNXtuQDwL5z1wJtmltLIZQjCIR4zKw3P1z/Wtr9Px2qcl6IWmELpm32UEYvIQ==
X-Received: by 2002:a17:90a:fc90:: with SMTP id ci16mr6988155pjb.5.1644117586219;
        Sat, 05 Feb 2022 19:19:46 -0800 (PST)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id mu13sm19757730pjb.28.2022.02.05.19.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Feb 2022 19:19:45 -0800 (PST)
Date:   Sun, 6 Feb 2022 12:19:43 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-hexagon@vger.kernel.org, openrisc@lists.librecores.org
Subject: Re: [PATCH] mm: Remove mmu_gathers storage from remaining
 architectures
Message-ID: <Yf8+T8Ow7n+38w2H@antec>
References: <20220205141956.3315419-1-shorne@gmail.com>
 <Yf6UthQtASGNgW8Q@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yf6UthQtASGNgW8Q@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2022 at 05:16:06PM +0200, Mike Rapoport wrote:
> On Sat, Feb 05, 2022 at 11:19:53PM +0900, Stafford Horne wrote:
> > Originally the mmu_gathers were removed in commit 1c3951769621 ("mm: now
> > that all old mmu_gather code is gone, remove the storage").  However,
> > the openrisc and hexagon architecture were merged around the same time
> > and mmu_gathers was not removed.
> > 
> > This patch removes them from openrisc, hexagon and nds32:
> > 
> > Noticed while cleaning this warning:
> > 
> >     arch/openrisc/mm/init.c:41:1: warning: symbol 'mmu_gathers' was not declared. Should it be static?
> > 
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> 
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>

Thank you,

BTW For now my plan is to queue this on my openrisc branch unless someone else
wants to pick this up.

-Stafford

> > ---
> >  arch/hexagon/mm/init.c  | 2 --
> >  arch/nds32/mm/init.c    | 1 -
> >  arch/openrisc/mm/init.c | 2 --
> >  3 files changed, 5 deletions(-)
> > 
> > diff --git a/arch/hexagon/mm/init.c b/arch/hexagon/mm/init.c
> > index f01e91e10d95..3167a3b5c97b 100644
> > --- a/arch/hexagon/mm/init.c
> > +++ b/arch/hexagon/mm/init.c
> > @@ -29,8 +29,6 @@ int max_kernel_seg = 0x303;
> >  /*  indicate pfn's of high memory  */
> >  unsigned long highstart_pfn, highend_pfn;
> >  
> > -DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
> > -
> >  /* Default cache attribute for newly created page tables */
> >  unsigned long _dflt_cache_att = CACHEDEF;
> >  
> > diff --git a/arch/nds32/mm/init.c b/arch/nds32/mm/init.c
> > index f63f839738c4..825c85cab1a1 100644
> > --- a/arch/nds32/mm/init.c
> > +++ b/arch/nds32/mm/init.c
> > @@ -18,7 +18,6 @@
> >  #include <asm/tlb.h>
> >  #include <asm/page.h>
> >  
> > -DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
> >  DEFINE_SPINLOCK(anon_alias_lock);
> >  extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
> >  
> > diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
> > index 97305bde1b16..3a021ab6f1ae 100644
> > --- a/arch/openrisc/mm/init.c
> > +++ b/arch/openrisc/mm/init.c
> > @@ -38,8 +38,6 @@
> >  
> >  int mem_init_done;
> >  
> > -DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
> > -
> >  static void __init zone_sizes_init(void)
> >  {
> >  	unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
> > -- 
> > 2.31.1
> > 
> 
> -- 
> Sincerely yours,
> Mike.
