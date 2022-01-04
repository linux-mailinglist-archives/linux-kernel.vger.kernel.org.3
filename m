Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F0F4843C0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbiADOv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:51:59 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:55918 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiADOv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:51:58 -0500
Received: by mail-wm1-f45.google.com with SMTP id c66so23390613wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 06:51:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b3+GmntaMimU+/bPpFnuf/v5ZVH63cB+da8coqiM/zw=;
        b=AQ4CNeGljwoO0nJ29jCAyAqk6lw6zXgV3GbPJPuAdE6D5q15sQpW4QInP7b9fVE1ow
         y1qy3qRnLTehltv9DZ6EnyWxJYyvoMrd1zmUEqdsbf1L5FfrvuCZuJaD5zhUwouHRhx4
         9kONMI0b5tvT7sYLHDcVQOwxoDzDsWT0ks0DBMrT283cGevmUXrP5BbyjhYrt22pwxZn
         8GjyOYygxJy621tAnq8jtuLAqDLfQra2I7wt+qDQo1XkhKUMsAJj7rT3wh01evwzRWb6
         5HnxL//TEI6u+c90Wrfff47L5ulMzdTaOUWgZXkmak7aoLAQsX7rWqWO3vNjmj7HT9XA
         QRwQ==
X-Gm-Message-State: AOAM531HaCEEI6nZ6iE8qbslVJrvpcG7hMiBlU+260ZpS/In8z89d2AI
        rRZadz5gvKeueZVc1Qrj53M=
X-Google-Smtp-Source: ABdhPJzjX5oClLRzYaX+nwg/mczDAlcvm4aJRos5NEuVy9/Ir+iOKjFdNrYEQvcjJTtqOW+WLD1Ikg==
X-Received: by 2002:a1c:c917:: with SMTP id f23mr43473624wmb.10.1641307917364;
        Tue, 04 Jan 2022 06:51:57 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id k31sm37872962wms.21.2022.01.04.06.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 06:51:56 -0800 (PST)
Date:   Tue, 4 Jan 2022 14:51:55 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Tianyu Lan <ltykernel@gmail.com>, m.szyprowski@samsung.com,
        robin.murphy@arm.com, michael.h.kelley@microsoft.com,
        kys@microsoft.com, Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, brijesh.singh@amd.com, konrad.wilk@oracle.com,
        hch@lst.de, wei.liu@kernel.org, parri.andrea@gmail.com,
        thomas.lendacky@amd.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] Swiotlb: Add CONFIG_HAS_IOMEM check around memremap() in
 the swiotlb_mem_remap()
Message-ID: <20220104145155.hm7j5byhddn4zhb2@liuwe-devbox-debian-v2>
References: <20211231165640.1245751-1-ltykernel@gmail.com>
 <YdKrxgnpT0Dc0t2T@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdKrxgnpT0Dc0t2T@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2022 at 11:54:46PM -0800, Christoph Hellwig wrote:
> On Fri, Dec 31, 2021 at 11:56:40AM -0500, Tianyu Lan wrote:
> > From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> > 
> > HAS_IOMEM option may not be selected on some platforms(e.g, s390) and this
> > will cause compile error due to miss memremap() implementation. Fix it via
> > adding HAS_IOMEM check around memremap() in the swiotlb.c.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> > ---
> >  kernel/dma/swiotlb.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index b36c1cdd0c4f..3de651ba38cc 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -167,6 +167,7 @@ static void *swiotlb_mem_remap(struct io_tlb_mem *mem, unsigned long bytes)
> >  {
> >  	void *vaddr = NULL;
> >  
> > +#ifdef CONFIG_HAS_IOMEM
> 
> Please stub out all of swiotlb_mem_remap instead of the ifdef inside the
> function.

Does this look okay to you?

---8<---
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index b36c1cdd0c4f..f1e7ea160b43 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -163,6 +163,7 @@ static inline unsigned long nr_slots(u64 val)
  * when swiotlb_unencrypted_base is set. (e.g. for Hyper-V AMD SEV-SNP
  * Isolation VMs).
  */
+#ifdef CONFIG_HAS_IOMEM
 static void *swiotlb_mem_remap(struct io_tlb_mem *mem, unsigned long bytes)
 {
 	void *vaddr = NULL;
@@ -178,6 +179,12 @@ static void *swiotlb_mem_remap(struct io_tlb_mem *mem, unsigned long bytes)
 
 	return vaddr;
 }
+#else
+static void *swiotlb_mem_remap(struct io_tlb_mem *mem, unsigned long bytes)
+{
+	return NULL;
+}
+#endif
 
 /*
  * Early SWIOTLB allocation may be too early to allow an architecture to
