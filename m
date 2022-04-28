Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D128A513705
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 16:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348471AbiD1OjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 10:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348467AbiD1OjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:39:22 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F4F4ECF5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 07:36:07 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E289B68AFE; Thu, 28 Apr 2022 16:36:03 +0200 (CEST)
Date:   Thu, 28 Apr 2022 16:36:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: fix host memory buffer allocation size
Message-ID: <20220428143603.GA20460@lst.de>
References: <20220428101922.14216-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220428101922.14216-1-linux@weissschuh.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 12:19:22PM +0200, Thomas Weiﬂschuh wrote:
> We want to allocate the smallest possible amount of buffers with the
> largest possible size (1 buffer of size "hmpre").
> 
> Previously we were allocating as many buffers as possible of the smallest
> possible size.
> This also lead to "hmpre" to not be satisifed as not enough buffer slots
> where available.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
> 
> Also discussed at https://lore.kernel.org/linux-nvme/f94565db-f217-4a56-83c3-c6429807185c@t-8ch.de/
> 
>  drivers/nvme/host/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 3aacf1c0d5a5..0546523cc20b 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2090,7 +2090,7 @@ static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
>  
>  static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
>  {
> -	u64 min_chunk = min_t(u64, preferred, PAGE_SIZE * MAX_ORDER_NR_PAGES);
> +	u64 min_chunk = max_t(u64, preferred, PAGE_SIZE * MAX_ORDER_NR_PAGES);

preferred is based on the HMPRE field in the spec, which documents the
preffered size.  So the max here would not make ny sense at all.

