Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8934DD9F1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 13:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236403AbiCRMsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 08:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiCRMs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 08:48:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBE32E417C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 05:47:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A63ABB82267
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 12:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E302CC340E8;
        Fri, 18 Mar 2022 12:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647607628;
        bh=s/tR3vmJ6yluDHWR+/tWoJCyxW4zOMrmbL3tDyikWFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RtXxBn4OFQ9FB2xH98Gr68EKBJpgpK6Nvtw40YUmKfM1YXhcw5bPcox4a9ceX0W2a
         RIuptf52vePW8hqljxdb0TPZIMvWHheK30QhCpLgaCnIw6l1CWszcatFnwDkShmux+
         jKz14+wlPLVnMISLpKJDfv6IoiDvgwLtZugPE6Us=
Date:   Fri, 18 Mar 2022 13:47:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     vdasa@vmware.com
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, pv-drivers@vmware.com,
        bryantan@vmware.com, rjalisatgi@vmware.com,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH RESEND] VMCI: Check exclusive_vectors when freeing
 interrupt 1
Message-ID: <YjR/RyduLkaQevQp@kroah.com>
References: <20220318055843.30606-1-vdasa@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318055843.30606-1-vdasa@vmware.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 10:58:43PM -0700, vdasa@vmware.com wrote:
> From: Vishnu Dasa <vdasa@vmware.com>
> 
> free_irq() may be called to free an interrupt that was not
> allocated.  Add missing 'if' statement to check for
> exclusive_vectors when freeing interrupt 1.
> 
> Fixes: cc68f2177fcb ("VMCI: dma dg: register dummy IRQ handlers for DMA datagrams")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: Bryan Tan <bryantan@vmware.com>
> Reviewed-by: Rajesh Jalisatgi <rjalisatgi@vmware.com>
> Signed-off-by: Vishnu Dasa <vdasa@vmware.com>
> ---
>  drivers/misc/vmw_vmci/vmci_guest.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
> index 6596a54daa88..57a6157209a1 100644
> --- a/drivers/misc/vmw_vmci/vmci_guest.c
> +++ b/drivers/misc/vmw_vmci/vmci_guest.c
> @@ -862,7 +862,9 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
>  	return 0;
>  
>  err_free_bm_irq:
> -	free_irq(pci_irq_vector(pdev, 1), vmci_dev);
> +	if (vmci_dev->exclusive_vectors)
> +		free_irq(pci_irq_vector(pdev, 1), vmci_dev);
> +
>  err_free_irq:
>  	free_irq(pci_irq_vector(pdev, 0), vmci_dev);
>  	tasklet_kill(&vmci_dev->datagram_tasklet);
> -- 
> 2.25.1
> 

You sent the previous version 2 days before this, and 5 days before
that.  Please relax and don't start worrying unless it's been 2 weeks.

thanks,

greg k-h
