Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E924A9BB1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359588AbiBDPMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiBDPMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:12:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9154BC061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 07:12:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3AD40B837CA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 15:12:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEB9C004E1;
        Fri,  4 Feb 2022 15:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643987528;
        bh=067hDVxi+b/lqCImfNdJsFF36HNXY7Gq9n7MG2mjYBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yCvZPumyM+8jZeDdP7sbGmXcxOg5mjO1n5L7wGbmiwGfJC/684atfpmyBWpOrR5vQ
         bSQU/vWfW8WCaoakXP0tCcB/OU3JMmAahfdq6qlbavHz2J56GCWDE3gQ5Z3ZdP1SNQ
         PKJTrgqV75NthSY94V51HR+XGqyeKqkg1HVbpO9k=
Date:   Fri, 4 Feb 2022 16:12:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jorgen Hansen <jhansen@vmware.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, pv-drivers@vmware.com,
        Vishnu Dasa <vdasa@vmware.com>
Subject: Re: [PATCH v2 4/8] VMCI: dma dg: set OS page size
Message-ID: <Yf1CQO99mPzLg+Mq@kroah.com>
References: <20220203131237.3380-1-jhansen@vmware.com>
 <20220203131237.3380-5-jhansen@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203131237.3380-5-jhansen@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 05:12:33AM -0800, Jorgen Hansen wrote:
> Tell the device the page size used by the OS.
> 
> Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
> Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
> ---
>  drivers/misc/vmw_vmci/vmci_guest.c | 9 +++++++++
>  include/linux/vmw_vmci_defs.h      | 1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
> index 5a99d8e27873..808680dc0820 100644
> --- a/drivers/misc/vmw_vmci/vmci_guest.c
> +++ b/drivers/misc/vmw_vmci/vmci_guest.c
> @@ -581,6 +581,15 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
>  	/* Let the host know which capabilities we intend to use. */
>  	vmci_write_reg(vmci_dev, caps_in_use, VMCI_CAPS_ADDR);
>  
> +	if (caps_in_use & VMCI_CAPS_DMA_DATAGRAM) {
> +		uint32_t page_shift;
> +
> +		/* Let the device know the size for pages passed down. */
> +		vmci_write_reg(vmci_dev, PAGE_SHIFT, VMCI_GUEST_PAGE_SHIFT);
> +		page_shift = vmci_read_reg(vmci_dev, VMCI_GUEST_PAGE_SHIFT);
> +		dev_info(&pdev->dev, "Using page shift %d\n", page_shift);

Please do not print out debugging stuff like this to the kernel log.

When drivers are working properly, they are quiet.

thanks,

greg k-h
