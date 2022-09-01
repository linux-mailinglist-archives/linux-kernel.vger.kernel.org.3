Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8915A947C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbiIAKZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234112AbiIAKYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:24:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9A9E05
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 03:24:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C32F161C32
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6331C433C1;
        Thu,  1 Sep 2022 10:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662027885;
        bh=6jkDKq6cCqm6kRN+eHnN3rPhSEGvtYmmFG+yha+3gTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OeY/KNWzvADOYiA/Gh6fUuoThOkMbQG1wOcWyDlFomQVAM7w1hQWwEAh93hN8k1yD
         7LPZckv3VOFPahwhDa2dWF44X6W2OmMXOgsd9VGc3HFGaqSaFJqulPfqV1IRB95XJ9
         MkGoAhmhcr119ybN3lljCnH2GH9ZBo568JIWJQU4=
Date:   Thu, 1 Sep 2022 12:24:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     hdegoede@redhat.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v2 1/2] virt: vbox: Add check for device_create_file
Message-ID: <YxCIam9OS6fWpoA3@kroah.com>
References: <20220901101649.3499848-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901101649.3499848-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 06:16:49PM +0800, Jiasheng Jiang wrote:
> On Thu, Sep 01, 2022 at 05:39:46PM +0800, Greg KH wrote:
> >> -	device_create_file(dev, &dev_attr_host_version);
> >> -	device_create_file(dev, &dev_attr_host_features);
> >> +
> >> +	ret = device_create_file(gdev->dev, &dev_attr_host_features);
> >> +	if (ret)
> >> +		goto err_unregister_misc_device_user;
> >> +	ret = device_create_file(gdev->dev, &dev_attr_host_version);
> >> +	if (ret)
> >> +		goto err_remove_file_features;
> >>  
> >>  	vbg_info("vboxguest: misc device minor %d, IRQ %d, I/O port %x, MMIO at %pap (size %pap)\n",
> >>  		 gdev->misc_device.minor, pci->irq, gdev->io_port,
> >> @@ -399,6 +404,8 @@ static int vbg_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
> >>  
> >>  	return 0;
> >>  
> >> +err_remove_file_features:
> >> +	device_remove_file(gdev->dev, &dev_attr_host_features);
> > Please make a patch series that is linked together, the one you just did
> > was not properly threaded at all (hint, use git send-email).
> > 
> > And again, this is not the correct way to solve this issue, use a
> > default attribute group for the driver instead.  No driver should ever
> > be adding or removing files individually like this.
> 
> Need I use the group to replace the individually removal in
> vbg_pci_remove() too?

If you use a group, the driver core handles all of the adding and
removing automatically for you.  Look at other commits that set the
default groups attribute for a driver for examples.

thanks,

greg k-h
