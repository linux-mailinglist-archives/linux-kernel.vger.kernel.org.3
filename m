Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659195A91E8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbiIAIRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbiIAIRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:17:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF631260C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:17:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBA5AB824F7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 08:17:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6A9C433D6;
        Thu,  1 Sep 2022 08:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662020260;
        bh=zUga1I0pI9vaiLYc4kRui+c3WrpJ9wddiTEbbURDV+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GPH7WBD2O0C/7s8vRLHAuh0zhLUPPsCjX6jXF0yVX2yJX6VyZbgFzTi/gBRFzhMIB
         GClsyiMMEHKHlhAO1tNCAt9tiYbs2UkSqsrxmkKdNXuVkVf8nFJed1B+YkNZK9Kn2k
         UcF+Bf5wdtLjE39qvN8z26tmEYXaquhzV40/p8qA=
Date:   Thu, 1 Sep 2022 10:17:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     hdegoede@redhat.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virt: vbox: Add check for device_create_file
Message-ID: <YxBqoe9oz/u3Xm2Z@kroah.com>
References: <20220901074521.3448337-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901074521.3448337-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 03:45:21PM +0800, Jiasheng Jiang wrote:
> As device_create_file() can return error number,
> it should be better to check the return value and
> deal with the exception.
> 
> Fixes: 0ba002bc4393 ("virt: Add vboxguest driver for Virtual Box Guest integration")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/virt/vboxguest/vboxguest_linux.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virt/vboxguest/vboxguest_linux.c b/drivers/virt/vboxguest/vboxguest_linux.c
> index 4ccfd30c2a30..0fee8e6ee6e0 100644
> --- a/drivers/virt/vboxguest/vboxguest_linux.c
> +++ b/drivers/virt/vboxguest/vboxguest_linux.c
> @@ -390,8 +390,13 @@ static int vbg_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
>  	}
>  
>  	pci_set_drvdata(pci, gdev);
> -	device_create_file(dev, &dev_attr_host_version);
> -	device_create_file(dev, &dev_attr_host_features);
> +
> +	ret = device_create_file(dev, &dev_attr_host_version);
> +	if (ret)
> +		goto err_unregister_misc_device_user;
> +	ret = device_create_file(dev, &dev_attr_host_features);
> +	if (ret)
> +		goto err_unregister_misc_device_user;

No, this driver should be using an attribute group, please switch it to
use that instead.

>  	vbg_info("vboxguest: misc device minor %d, IRQ %d, I/O port %x, MMIO at %pap (size %pap)\n",
>  		 gdev->misc_device.minor, pci->irq, gdev->io_port,

This should also be removed, when drivers are working properly, they are
quiet.  But that can be a second patch in your series.

thanks,

greg k-h
