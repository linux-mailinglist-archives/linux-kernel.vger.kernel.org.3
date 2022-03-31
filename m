Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDA54ED262
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 06:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiCaELs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 00:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiCaELJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 00:11:09 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9FB14A6D7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 20:44:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V8gzrDQ_1648697185;
Received: from 30.225.24.67(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0V8gzrDQ_1648697185)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 31 Mar 2022 11:26:27 +0800
Message-ID: <ad53a5b5-2fbd-3e86-f9d9-5d2677e71791@linux.alibaba.com>
Date:   Thu, 31 Mar 2022 11:26:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH RESEND] uio/uio_pci_generic: Introduce refcnt on
 open/release
Content-Language: en-US
To:     Yao Hongbo <yaohongbo@linux.alibaba.com>, mst@redhat.com,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, alikernel-developer@linux.alibaba.com
References: <1648693432-129409-1-git-send-email-yaohongbo@linux.alibaba.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <1648693432-129409-1-git-send-email-yaohongbo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/31/22 10:23 AM, Yao Hongbo wrote:
> If two userspace programs both open the PCI UIO fd, when one
> of the program exits uncleanly, the other will cause IO hang
> due to bus-mastering disabled.
> 
> It's a common usage for spdk/dpdk to use UIO. So, introduce refcnt
> to avoid such problems.
> 
> Fixes: 865a11f("uio/uio_pci_generic: Disable bus-mastering on release")

Fixes commit id should be 12 abbrev instead.

Thanks,
Joseph

> Reported-by: Xiu Yang <yangxiu.yx@alibaba-inc.com>
> Signed-off-by: Yao Hongbo <yaohongbo@linux.alibaba.com>
> ---
>  drivers/uio/uio_pci_generic.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/uio/uio_pci_generic.c b/drivers/uio/uio_pci_generic.c
> index e03f9b5..8add2cf 100644
> --- a/drivers/uio/uio_pci_generic.c
> +++ b/drivers/uio/uio_pci_generic.c
> @@ -31,6 +31,7 @@
>  struct uio_pci_generic_dev {
>  	struct uio_info info;
>  	struct pci_dev *pdev;
> +	atomic_t refcnt;
>  };
>  
>  static inline struct uio_pci_generic_dev *
> @@ -39,6 +40,14 @@ struct uio_pci_generic_dev {
>  	return container_of(info, struct uio_pci_generic_dev, info);
>  }
>  
> +static int open(struct uio_info *info, struct inode *inode)
> +{
> +	struct uio_pci_generic_dev *gdev = to_uio_pci_generic_dev(info);
> +
> +	atomic_inc(&gdev->refcnt);
> +	return 0;
> +}
> +
>  static int release(struct uio_info *info, struct inode *inode)
>  {
>  	struct uio_pci_generic_dev *gdev = to_uio_pci_generic_dev(info);
> @@ -51,7 +60,9 @@ static int release(struct uio_info *info, struct inode *inode)
>  	 * Note that there's a non-zero chance doing this will wedge the device
>  	 * at least until reset.
>  	 */
> -	pci_clear_master(gdev->pdev);
> +	if (atomic_dec_and_test(&gdev->refcnt))
> +		pci_clear_master(gdev->pdev);
> +
>  	return 0;
>  }
>  
> @@ -92,8 +103,11 @@ static int probe(struct pci_dev *pdev,
>  
>  	gdev->info.name = "uio_pci_generic";
>  	gdev->info.version = DRIVER_VERSION;
> +	gdev->info.open = open;
>  	gdev->info.release = release;
>  	gdev->pdev = pdev;
> +	atomic_set(&gdev->refcnt, 0);
> +
>  	if (pdev->irq && (pdev->irq != IRQ_NOTCONNECTED)) {
>  		gdev->info.irq = pdev->irq;
>  		gdev->info.irq_flags = IRQF_SHARED;
