Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2898E4D9ADB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 13:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348143AbiCOMHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 08:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbiCOMHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 08:07:22 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C2152E73
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:06:06 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6212268AA6; Tue, 15 Mar 2022 13:06:02 +0100 (CET)
Date:   Tue, 15 Mar 2022 13:06:01 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, hch@lst.de, axboe@fb.com, kbusch@kernel.org,
        Mark_Hsieh@wistron.com, Walt Hubis <whubis@micron.com>
Subject: Re: [PATCH] nvme-pci: disable write zeros support on specific SSDs
Message-ID: <20220315120601.GA7918@lst.de>
References: <20220315104702.20798-1-mark_hsieh@wistron.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315104702.20798-1-mark_hsieh@wistron.corp-partner.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 06:47:02PM +0800, Mark Hsieh wrote:
> Like commit 5611ec2b9814 ("nvme-pci: prevent SK hynix PC400 from using
> Write Zeroes command"), Micron has the same issue:
> [ 6305.633887] blk_update_request: operation not supported error, dev
> nvme0n1, sector 340812032 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
> 
> So also disable Write Zeroes command on Micron.
> 
> Signed-off-by: Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
> Change-Id: Ic6ebfe141702d1869490bbf210627055b5b4d80f

Please drop these strange Change-Id tags.  But more importantly
something seems really broken here if the device claims to support
Write Zeroes but then doesn't claims it is not supported.

Can you see if this only happens with some I/O size?  With our without
the nounmap flag?  Does the device report non-MDTS command limits?

> ---
>  drivers/nvme/host/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index a7a502a5b2b5..68745e1d7b6a 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3245,6 +3245,8 @@ static const struct pci_device_id nvme_id_table[] = {
>  		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
>  	{ PCI_DEVICE(0x2646, 0x500d),   /* Kingston OM3PDP3256B-AH 256G */
>  		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
> +	{ PCI_DEVICE(0x1344, 0x5411),   /* Micron 2450 MTFDKCD256TFK 256G */
> +		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
>  	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
>  	{ PCI_DEVICE(0x2646, 0x2263),   /* KINGSTON A2000 NVMe SSD  */
>  		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
> -- 
> 2.17.1
---end quoted text---
