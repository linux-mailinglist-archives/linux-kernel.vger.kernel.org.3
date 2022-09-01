Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2A15A9350
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbiIAJjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiIAJjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:39:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2742FA44B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 02:39:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A3B661A0C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:39:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E30C433D6;
        Thu,  1 Sep 2022 09:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662025189;
        bh=Nb+hhfRxZqj5DmLros4E6gk2jMz+AbmonjFjphN1jVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fo0zqVfVujqX+N3cPzwTi4Ku5MbNfEP0lif1MsO+qp+UlhgKnKTegYAL870jAEQ4x
         kk22EhPHqX6DvEVMhzHlC1nPlZ7yX+qIHF5+Xf1ATXYJiTmvBfOYArZPKVrKea9aEm
         2EHNkiWX+G3UiHDHRQ9ajmTp4Cxi+ti9aQJEz/Cw=
Date:   Thu, 1 Sep 2022 11:39:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     hdegoede@redhat.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] virt: vbox: Add check for device_create_file
Message-ID: <YxB94tzInpj4he1R@kroah.com>
References: <20220901091752.3474095-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901091752.3474095-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 05:17:52PM +0800, Jiasheng Jiang wrote:
> As device_create_file() can return error number,
> it should be better to check the return value and
> deal with the exception.
> Moreover, this driver should be using an attribute group.
> 
> Fixes: 0ba002bc4393 ("virt: Add vboxguest driver for Virtual Box Guest integration")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Change log:
> 
> v1 -> v2:
> 
> 1. Use gdev->dev instead of dev.
> 2. Remove file when creation failed.
> ---
>  drivers/virt/vboxguest/vboxguest_linux.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virt/vboxguest/vboxguest_linux.c b/drivers/virt/vboxguest/vboxguest_linux.c
> index 4ccfd30c2a30..2fb9a6d91b53 100644
> --- a/drivers/virt/vboxguest/vboxguest_linux.c
> +++ b/drivers/virt/vboxguest/vboxguest_linux.c
> @@ -390,8 +390,13 @@ static int vbg_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
>  	}
>  
>  	pci_set_drvdata(pci, gdev);
> -	device_create_file(dev, &dev_attr_host_version);
> -	device_create_file(dev, &dev_attr_host_features);
> +
> +	ret = device_create_file(gdev->dev, &dev_attr_host_features);
> +	if (ret)
> +		goto err_unregister_misc_device_user;
> +	ret = device_create_file(gdev->dev, &dev_attr_host_version);
> +	if (ret)
> +		goto err_remove_file_features;
>  
>  	vbg_info("vboxguest: misc device minor %d, IRQ %d, I/O port %x, MMIO at %pap (size %pap)\n",
>  		 gdev->misc_device.minor, pci->irq, gdev->io_port,
> @@ -399,6 +404,8 @@ static int vbg_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
>  
>  	return 0;
>  
> +err_remove_file_features:
> +	device_remove_file(gdev->dev, &dev_attr_host_features);
>  err_unregister_misc_device_user:
>  	misc_deregister(&gdev->misc_device_user);
>  err_unregister_misc_device:
> -- 
> 2.25.1
> 

Please make a patch series that is linked together, the one you just did
was not properly threaded at all (hint, use git send-email).

And again, this is not the correct way to solve this issue, use a
default attribute group for the driver instead.  No driver should ever
be adding or removing files individually like this.

thanks,

greg k-h
