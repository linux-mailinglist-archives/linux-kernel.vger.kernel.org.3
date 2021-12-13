Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F38472EEC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 15:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbhLMOV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 09:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239144AbhLMOVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:21:50 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853C3C061751
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 06:21:49 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id g18so15060449pfk.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 06:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=871CXj1aRpC+2TqhzLMbz3iHeb2GTGhF6RiqfqFyWOM=;
        b=A26Vcu7LGR96dETcFTQz6G/P2Tn2GbitjgW9PNyOTyrshf8V39VQY8haNWeUWkdX32
         MPv4i0lWk/Y4Kma+UvE8OmQX/yeeSqP6hlUqvHVgA4BC3M1vkxUjvDJVHpXB4axH4/wi
         cs4z0bVuvivpTsBajslE6j59WaQtbCvnSRWeoNzXDSwBJia4FXLKBZmvqN5Tg3XG4FVj
         RWltlxaXXJlgUydNU5ScKfpskxQ+VCOPQWaFucaXyvDGcrKxzStj3IDjXfk5AUfZfk6W
         dvQDilPCRpLn96LKqIiqHKELyXZbN9eGQCTyLXjizdEXz8yV44GEBi7Emb/CV/iqDYZg
         Npfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=871CXj1aRpC+2TqhzLMbz3iHeb2GTGhF6RiqfqFyWOM=;
        b=X4wpFa54Wny0jKzHd+TuhtRH+oqHyQ7JwRFBQLaA8biiof1ZIh7y98OwHK6MxxbAC4
         J+IT/7a8Nic4JvuZfzV6cELQVAXh3UTY5jiQDvrCFhi9N/RLTewJs45nlYhb1hvjNmSn
         ItUUDXguoQsFe9qYcg3DS/tGn7fqTEos2XeFVAVPuDUBdpjXHaeDyVCEbrT+Tq9D2aZR
         /9SHqjZHrrjYklYWCo/c1e4aOZF/4ugD+0zyAgNIiIzP7lm+ETUeQuRHR4T55Q+lYoJ3
         5j32SRLc93ziCA2+f/M7fPJpZ52oZPDAWlXCFV1evRzJwzPFCiYEks/zVDNVUwq1r2ui
         tWWA==
X-Gm-Message-State: AOAM53058KVhgeZf0Ew6HhDPeFwPAv0S8eFuATBwHyMvWFpQD4TDUj2q
        ypLyuDGTpq/ScK0zER+Lp9E=
X-Google-Smtp-Source: ABdhPJwVjLfgiq+ZliTNrHlm2zTYfK9/0mO1eOHrTYjGAPYAu1YJNn14CAau60+dVFzoc1OPkUd86A==
X-Received: by 2002:a05:6a00:22ce:b0:4b1:39d2:bc7c with SMTP id f14-20020a056a0022ce00b004b139d2bc7cmr20556069pfj.27.1639405309025;
        Mon, 13 Dec 2021 06:21:49 -0800 (PST)
Received: from odroid ([114.29.23.242])
        by smtp.gmail.com with ESMTPSA id rm1sm7425733pjb.3.2021.12.13.06.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 06:21:48 -0800 (PST)
Date:   Mon, 13 Dec 2021 14:21:42 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Christoph Lameter <cl@gentwo.org>
Cc:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de,
        robin.murphy@arm.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, m.szyprowski@samsung.com,
        John.p.donnelly@oracle.com, kexec@lists.infradead.org
Subject: Re: [PATCH RESEND v2 0/5] Avoid requesting page from DMA zone when
 no managed pages
Message-ID: <20211213142142.GA999996@odroid>
References: <20211207030750.30824-1-bhe@redhat.com>
 <alpine.DEB.2.22.394.2112070859420.201880@gentwo.de>
 <20211209080540.GA3050@MiWiFi-R3L-srv>
 <alpine.DEB.2.22.394.2112091355510.270348@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2112091355510.270348@gentwo.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 01:59:58PM +0100, Christoph Lameter wrote:
> On Thu, 9 Dec 2021, Baoquan He wrote:
> 
> > > The slab allocators guarantee that all kmalloc allocations are DMA able
> > > indepent of specifying ZONE_DMA/ZONE_DMA32
> >
> > Here you mean we guarantee dma-kmalloc will be DMA able independent of
> > specifying ZONE_DMA/DMA32, or the whole sla/ub allocator?
> 
> All memory obtained via kmalloc --independent of "dma-alloc", ZONE_DMA
> etc-- must be dmaable.
> 
> > With my understanding, isn't the reasonable sequence zone DMA firstly if
> > GFP_DMA, then zone DMA32, finaly zone NORMAL. At least, on x86_64, I
> > believe device driver developer prefer to see this because most of time,
> > zone DMA and zone DMA32 are both used for dma buffer allocation, if
> > IOMMU is not enabled. However, memory got from zone NORMAL when required
> > with GFP_DMA, and it succeeds, does it mean that the developer doesn't
> > take the GFP_DMA flag seriously, just try to get buffer for allocation?
> 
> ZONE_NORMAL is also used for DMA allocations. ZONE_DMA and ZONE_DMA32 are
> only used if the physical range of memory supported by a device does not
> include all of normal memory.
> 
> > > The size of ZONE_DMA is traditionally depending on the platform. On some
> > > it is 16MB, on some 1G and on some 4GB. ZONE32 is always 4GB and should
> > > only be used if ZONE_DMA has already been used.
> >
> > As said at above, ia64 and riscv don't have ZONE_DMA at all, they just
> > cover low 4G with ZONE_DMA32 alone.
> 
> If you do not have devices that are crap and cannot address the full
> memory then you dont need these special zones.
> 
> Sorry this subject has caused confusion multiple times over the years and
> there are still arches that are not implementing this in a consistent way.

Hello Baoquan and Christoph.

I'm the confused one here too. :)

So the point is that ZONE_NORMAL is also dma-able if the device can access
normal memory. (which is false for ISA devices, ancient PCI devices,
...etc.)

Then if I understand right, I think the patch 5/5 (mm/slub: Avoid ...) should be removing
GFP_DMA flag from the function sr_probe() -> get_capabilities, rather than
copying copying normal kmalloc caches to dma kmalloc caches. (If the device does
not have limitation in its address space.)

Please let me know If I got it wrong :)

Thanks,
Hyeonggon.
