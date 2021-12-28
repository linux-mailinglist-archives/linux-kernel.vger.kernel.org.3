Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4793748062E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 06:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbhL1FHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 00:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhL1FHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 00:07:06 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4659CC06173E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 21:07:06 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id rj2-20020a17090b3e8200b001b1944bad25so16029214pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 21:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hZ+creX9k430k6ghelPrSUQxPrNj5qOJUq4xMpywZ0E=;
        b=TR23MsUgpM1qIlyJ9Gaa5zJR+ZF7hTfeI6+AN+N9dBu3QUVKFPmGd5DPSBTO+S4wKU
         DS/7wW4STHFGZDB7sg3G0LR8eJoItVX8AwtXLBRepOUz1qKs55YECmWQQzvADcjezJ7s
         9PvqfASKTLMRYU+ewhQ41i3SK0o3+P9JGK0s7YUFJVd6I5Duvaxmqth7v6oGi7IMYDRA
         9ReGjC26Nxa6W/Nbjw00yoirmRVN60RWr8cWoV/ffMrmLZ0bkqTAANtcw90w3GjVvzfp
         YZlY2qZoQTRlDGtjzHsaHx8x2eGyVFN0inixAMwLLUcghqAZH5/ETW+2BeJLS6YigIRb
         dBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hZ+creX9k430k6ghelPrSUQxPrNj5qOJUq4xMpywZ0E=;
        b=PBwVtjG3+m3gQhlgyiE+3BOy/vfqOauscVH+KPSF6ZGLS5MzwO3YhJidq5GVLA3hsc
         hgOa21TNS4MWqrWtBlCLQS8OuHza9TrZkZhJ/SClKfRY0mh4ma0bd9MkJX27QIHkqcJI
         CLK8GALM4hp2XdL/EMc6fUsoDOPMi7SjyNjqPr82Ml8l4x8Kvo7ULWuSlpC/J0gX4FqF
         lxwepKgZCjOzEDRvMMQOE/lmCdefdn/QOZfMPjvIB7ywBHBBE7RQXmv7aVRkL7SHp0gc
         oUnjDQs5LSRwMWsDCVYmWwL5ufjgqrW3jNJXeM4CYriF862bn9hrgtZTS/ZoITbhemHk
         NCQg==
X-Gm-Message-State: AOAM530U6uZfQbbWCA2Eob5y7tmL8XL/DmePTR/zyzlHGXhylWJeNfsE
        vMi8d29eNHE5EKAzzONzJ2Q=
X-Google-Smtp-Source: ABdhPJy9ZOLEoPSXltwyOOGPfeJXxUCATF93RrxDZoRuaYT+w2GWGE1wR6VkbJbLtQF9knq76vTh6w==
X-Received: by 2002:a17:902:f682:b0:149:194c:d4a3 with SMTP id l2-20020a170902f68200b00149194cd4a3mr20026973plg.122.1640668025680;
        Mon, 27 Dec 2021 21:07:05 -0800 (PST)
Received: from odroid ([114.29.23.242])
        by smtp.gmail.com with ESMTPSA id w2sm15868658pgt.93.2021.12.27.21.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 21:07:05 -0800 (PST)
Date:   Tue, 28 Dec 2021 05:06:58 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hch@lst.de, cl@linux.com,
        John.p.donnelly@oracle.com, kexec@lists.infradead.org,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz, David.Laight@aculab.com, david@redhat.com,
        x86@kernel.org, bp@alien8.de
Subject: Re: [PATCH v4 3/3] mm/page_alloc.c: do not warn allocation failure
 on zone DMA if no managed pages
Message-ID: <20211228050658.GA2115590@odroid>
References: <20211223094435.248523-1-bhe@redhat.com>
 <20211223094435.248523-4-bhe@redhat.com>
 <Ycax90Xex3THEZTi@ip-172-31-30-232.ap-northeast-1.compute.internal>
 <20211227083253.GA24172@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227083253.GA24172@MiWiFi-R3L-srv>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021 at 04:32:53PM +0800, Baoquan He wrote:
> On 12/25/21 at 05:53am, Hyeonggon Yoo wrote:
> > On Thu, Dec 23, 2021 at 05:44:35PM +0800, Baoquan He wrote:
> ...... 
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index 7c7a0b5de2ff..843bc8e5550a 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -4204,7 +4204,8 @@ void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
> > >  	va_list args;
> > >  	static DEFINE_RATELIMIT_STATE(nopage_rs, 10*HZ, 1);
> > >  
> > > -	if ((gfp_mask & __GFP_NOWARN) || !__ratelimit(&nopage_rs))
> > > +	if ((gfp_mask & __GFP_NOWARN) || !__ratelimit(&nopage_rs) ||
> > > +		(gfp_mask & __GFP_DMA) && !has_managed_dma())
> > >  		return;
> > >
> > 
> > Warning when there's always no page in DMA zone is unnecessary 
> > and it confuses user.
> > 
> > The patch looks good.
> > Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > 
> > And there is some driers that allocate memory with GFP_DMA
> > even if that flag is unnecessary. We need to do cleanup later.
> 
> Thanks for reviewing and giving out some awesome suggestions.
> 

You're welcome. Impressed to see you keep following the issue.

> > 
> > Baoquan Are you planning to do it soon?
> > I want to help that.
> 
> Yes, I had the plan and have done a little part. I talked to Christoph
> about my thought. I planned to collect all kmalloc(GFP_DMA) callsite and
> post a RFC mail, CC mailing list and maintainers related. Anyone
> interested or know one or several callsites well can help.
>

Good to hear that.
I want to help by reviewing and discussing your patches.

> Now, Christoph has handled all under drviers/scsi, and post patches to
> fix them.

Oh, didn't know he was already doing that work.

> I have gone throug those places and found out below callsites
> where we can remove GFP_DMA directly when calling kmalloc() since not
> necessary.

Note that some of them might have 24bit addressing limitation.
we need to ask maintainer or read its specification to know GFP_DMA
is unnecessary.

> And even found one place kmalloc(GFP_DMA32).

kmalloc(GFP_DMA32) is wrong because we do not create DMA32 kmalloc caches.

> (HEAD -> master) vxge: don't use GFP_DMA
> mtd: rawnand: marvell: don't use GFP_DMA
> HID: intel-ish-hid: remove wrong GFP_DMA32 flag
> ps3disk: don't use GFP_DMA
> atm: iphase: don't use GFP_DMA

> Next, I will send a RFC mail to contain those suspect callsites. We can
> track them and can help if needed. Suggest to change them with:
> 1) using dma_alloc_xx , or dma_map_xx after kmalloc()
> 2) using alloc_pages(GFP_DMA) instead

Well if the buffer is not sensitive to performance, we can just
allocate with kmalloc(GFP_KERNEL) so that dma api can use proper bounce
buffer.

if the buffer is for fastpath, I think we should convert them to
use dma_alloc_pages() to get a proper buffer.

Note that most of devices are already calling dma_map_xx directly or indirectly
(think about block layer for example) if they don't use deprecated virt_to_bus()
or friends.

But if the device do not use DMA API at all, we have few choices.
maybe convert them to use alloc_pages(GFP_DMA/GFP_DMA32) I guess?

> When we fix, we all post patch with subject key words as
> 'xxxx: don't use GFP_DMA'. Christoph has posted patch with the similar
> subject, we can search subject to get all related patches for later back
> porting.
> 
> I will add you to CC when sending. Could be tomorrow. Any suggestion or thought?
>
> Thanks
> Baoquan
> 

Thank you!
Hyeonggon
