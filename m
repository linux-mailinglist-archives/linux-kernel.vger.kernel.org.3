Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB20D542778
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbiFHHE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345964AbiFHGMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 02:12:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF9C2065F2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 22:34:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE41BB825A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 05:31:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5512AC34116;
        Wed,  8 Jun 2022 05:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654666295;
        bh=ejFnUTe3BbCkOEXPPTvyYVxAfza3oqmKEJetvnad9OI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eCsOf8ZbxGqlgOQ0cyKfaDiMqQaFWHb9NHLhzqT8/LLf898Dja9/yufARu4IFSyqp
         FkoLU6V8JxG7XwGky049vEf+RVmbFe+KvZX25sjTEWJNd8NAyNO5DPOMygldMBHxFJ
         rwXm4IL0CRvXrAu3gHtYsg1NYnbdc7gG7Dy+M34M=
Date:   Wed, 8 Jun 2022 07:31:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ke Liu <liuke94@huawei.com>
Cc:     scott.branden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: bcm-vk: Directly use ida_alloc()/free()
Message-ID: <YqA0NGXzOCnoFVN3@kroah.com>
References: <20220608031927.1704412-1-liuke94@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608031927.1704412-1-liuke94@huawei.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 03:19:27AM +0000, Ke Liu wrote:
> Use ida_alloc()/ida_free() instead of deprecated
> ida_simple_get()/ida_simple_remove().
> 
> Signed-off-by: Ke Liu <liuke94@huawei.com>
> ---
>  drivers/misc/bcm-vk/bcm_vk_dev.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
> index a16b99bdaa13..a3a82ebbc699 100644
> --- a/drivers/misc/bcm-vk/bcm_vk_dev.c
> +++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
> @@ -1401,7 +1401,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		bcm_vk_tty_set_irq_enabled(vk, i);
>  	}
>  
> -	id = ida_simple_get(&bcm_vk_ida, 0, 0, GFP_KERNEL);
> +	id = ida_alloc(&bcm_vk_ida, GFP_KERNEL);
>  	if (id < 0) {
>  		err = id;
>  		dev_err(dev, "unable to get id\n");
> @@ -1500,7 +1500,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	misc_device->name = NULL;
>  
>  err_ida_remove:
> -	ida_simple_remove(&bcm_vk_ida, id);
> +	ida_free(&bcm_vk_ida, id);
>  
>  err_irq:
>  	for (i = 0; i < vk->num_irqs; i++)
> @@ -1573,7 +1573,7 @@ static void bcm_vk_remove(struct pci_dev *pdev)
>  	if (misc_device->name) {
>  		misc_deregister(misc_device);
>  		kfree(misc_device->name);
> -		ida_simple_remove(&bcm_vk_ida, vk->devid);
> +		ida_free(&bcm_vk_ida, vk->devid);

If conversions were this simple, why wouldn't the maintainer have done
this already for the whole tree?

Are you sure these types of changes are correct?  How did you test them?

thanks,

greg k-h
