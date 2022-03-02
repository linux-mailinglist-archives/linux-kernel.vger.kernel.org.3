Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B594CAB75
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243764AbiCBRXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbiCBRXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:23:40 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C217E4BBAB
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:22:55 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id bx5so2359387pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 09:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jklf8XPuym2PP8A66P9TwV3A0pOKZ2tfA0gEcqm6VHU=;
        b=JCnfVceXbb7gtnysgddHpYe+fZSK1mwYXlQ9n8cgZmLcjIvEAEax475FB2bAKmLvYm
         7ld6i+2lkqVHygprODVZpZg8RaTihov8S5A6HJUnOQDHQbaNjlObmzqxVIHLLCG1PsMh
         7MUw6VDSYcUG2Hrs3gkHPqu3r6RslxC4gm+UOIy+ItO1o5s8loyFtrIn3Lhno9r8AIa0
         H8jY0REOsHbJF8dBleSo9CLHklTHHv+lpWzoC2YtNjG2t9Y1zjyn5SEwR+50l676Z5Gf
         E8iZkOnZbtV/P0PbHahihueRwEWd4PwK+PCzcCTvi2KFjLZx4QxHaw4elUwYxwbnjiyt
         zmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jklf8XPuym2PP8A66P9TwV3A0pOKZ2tfA0gEcqm6VHU=;
        b=P7SPweHoN+1djW81gyLXapyS/8fGbHIbb92kARFVQV15nFosQ9f576ng+cZ+1Gg4lp
         O+mZLmQoFrU9PiMRNXUxtICrrOGRVmgkQmKw02NwfSjfHg9mpGA7b/luUSdxcxvjXMiM
         AXzr6U2xD1B9MNbtW0bt34V0XHEtU5+4G1VupaUrE+ZmnKPkirDiVRoNrsCr23jQ+i8f
         PMbveqHDXP1LcA7Lb10gYVDWzC3fL3y5loT5pxaRRgkJGgYOg4lgXRAE28BXtajaKfmI
         QLu6nSVS0x9GMpkJvzEkriFEzp6YbxrF1JiGciChMbqtD9/d8KJMYph1HBQOtvh2nZlz
         esAA==
X-Gm-Message-State: AOAM531WmwDLmt9NoW7bi6Xh4Lb0NX3N9HTEIq3BCSQYyErzw8Q+Q0hy
        f0ubSe/AAy7KanmbIjlqr4g=
X-Google-Smtp-Source: ABdhPJzhAaDYo23YzK1/SpdmOHYrat1lErBtR/w0fcviW8SQM2/DBGIsAiPQFsF/IgQn1wI6MMu4kg==
X-Received: by 2002:a17:90a:528b:b0:1bc:c5f9:82a with SMTP id w11-20020a17090a528b00b001bcc5f9082amr852446pjh.210.1646241774169;
        Wed, 02 Mar 2022 09:22:54 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id a19-20020a17090ad81300b001bc447c2c91sm5661748pjv.31.2022.03.02.09.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:22:53 -0800 (PST)
Date:   Wed, 2 Mar 2022 17:22:48 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>
Subject: Re: [PATCH 2/5] mm/slub: use stackdepot to save stack trace in
 objects
Message-ID: <Yh+n6MmSkjYM43iQ@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <20220225180318.20594-1-vbabka@suse.cz>
 <20220225180318.20594-3-vbabka@suse.cz>
 <YhtH5o2+7r85THg1@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <4b6e9dbb-ba3e-f33c-956e-07b5f81deee8@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b6e9dbb-ba3e-f33c-956e-07b5f81deee8@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 05:51:32PM +0100, Vlastimil Babka wrote:
> On 2/27/22 10:44, Hyeonggon Yoo wrote:
> > On Fri, Feb 25, 2022 at 07:03:15PM +0100, Vlastimil Babka wrote:
> >> From: Oliver Glitta <glittao@gmail.com>
> >> 
> >> Many stack traces are similar so there are many similar arrays.
> >> Stackdepot saves each unique stack only once.
> >>
> >> Replace field addrs in struct track with depot_stack_handle_t handle.  Use
> >> stackdepot to save stack trace.
> >>
> > 
> > I think it's not a replacement?
> 
> It is, for the array 'addrs':
> 
> -#ifdef CONFIG_STACKTRACE
> -	unsigned long addrs[TRACK_ADDRS_COUNT];	/* Called from address */
> +#ifdef CONFIG_STACKDEPOT
> +	depot_stack_handle_t handle;
> 
> Not confuse with 'addr' which is the immediate caller and indeed stays
> for redundancy/kernels without stack trace enabled.
>

Oh, my fault. Right. I was confused.
I should read it again.

> >> The benefits are smaller memory overhead and possibility to aggregate
> >> per-cache statistics in the following patch using the stackdepot handle
> >> instead of matching stacks manually.
> >> 
> >> [ vbabka@suse.cz: rebase to 5.17-rc1 and adjust accordingly ]
> >> 
> >> This was initially merged as commit 788691464c29 and reverted by commit
> >> ae14c63a9f20 due to several issues, that should now be fixed.
> >> The problem of unconditional memory overhead by stackdepot has been
> >> addressed by commit 2dba5eb1c73b ("lib/stackdepot: allow optional init
> >> and stack_table allocation by kvmalloc()"), so the dependency on
> >> stackdepot will result in extra memory usage only when a slab cache
> >> tracking is actually enabled, and not for all CONFIG_SLUB_DEBUG builds.
> >> The build failures on some architectures were also addressed, and the
> >> reported issue with xfs/433 test did not reproduce on 5.17-rc1 with this
> >> patch.
> > 
> > This is just an idea and beyond this patch.
> > 
> > After this patch, now we have external storage that records stack traces.
> 
> Well, we had it before this patch too.
>
> > It's possible that some rare stack traces are in stack depot, but
> > not reachable because track is overwritten.
> 
> Yes.
> 
> > I think it's worth implementing a way to iterate through stacks in stack depot?
> 
> The question is for what use case? We might even not know who stored
> them - could have been page_owner, or other stack depot users.

> But the point is usually not to learn about all existing traces, but to
> determine which ones cause an object lifetime bug, or memory leak.

Yeah, this is exactly what I misunderstood.
I thought purpose of free_traces is to show all existing traces.
But I realized today that free trace without alloc trace is not useful.

I'll review v2 with these in mind.
Thank you.

> >> 
> >> Signed-off-by: Oliver Glitta <glittao@gmail.com>
> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >> Cc: David Rientjes <rientjes@google.com>
> >> Cc: Christoph Lameter <cl@linux.com>
> >> Cc: Pekka Enberg <penberg@kernel.org>
> >> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > 
> 

-- 
Thank you, You are awesome!
Hyeonggon :-)
