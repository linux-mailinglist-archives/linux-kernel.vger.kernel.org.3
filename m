Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7422D47BC37
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 09:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbhLUIxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 03:53:01 -0500
Received: from verein.lst.de ([213.95.11.211]:45923 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235860AbhLUIxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 03:53:00 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 58D8768AFE; Tue, 21 Dec 2021 09:52:56 +0100 (CET)
Date:   Tue, 21 Dec 2021 09:52:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, corbet@lwn.net, hch@lst.de, cl@linux.com
Subject: Re: [PATCH 2/2] dma-pool: allow user to disable atomic pool
Message-ID: <20211221085256.GB7439@lst.de>
References: <20211217090827.101938-1-bhe@redhat.com> <20211217090827.101938-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217090827.101938-3-bhe@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 05:08:27PM +0800, Baoquan He wrote:
> In the current code, three atomic memory pools are always created,
> atomic_pool_kernel|dma|dma32, even though 'coherent_pool=0' is
> specified in kernel command line. In fact, atomic pool is only
> necessary when CONFIG_DMA_DIRECT_REMAP=y or mem_encrypt_active=y
> which are needed on few ARCHes.
> 
> So change code to allow user to disable atomic pool by specifying
> 'coherent_pool=0'.
> 
> Meanwhile, update the relevant document in kernel-parameter.txt.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 3 ++-
>  kernel/dma/pool.c                               | 7 +++++--
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index ec4d25e854a8..d7015309614b 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -664,7 +664,8 @@
>  
>  	coherent_pool=nn[KMG]	[ARM,KNL]
>  			Sets the size of memory pool for coherent, atomic dma
> -			allocations. Otherwise the default size will be scaled
> +			allocations. A value of 0 disables the three atomic
> +			memory pool. Otherwise the default size will be scaled
>  			with memory capacity, while clamped between 128K and
>  			1 << (PAGE_SHIFT + MAX_ORDER-1).
>  
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 5f84e6cdb78e..5a85804b5beb 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -21,7 +21,7 @@ static struct gen_pool *atomic_pool_kernel __ro_after_init;
>  static unsigned long pool_size_kernel;
>  
>  /* Size can be defined by the coherent_pool command line */
> -static size_t atomic_pool_size;
> +static unsigned long atomic_pool_size = -1;

Using UINT_MAX instead of -1 here and below would probably be more
descriptive.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
