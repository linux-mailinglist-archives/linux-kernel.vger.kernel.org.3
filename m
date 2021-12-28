Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B381A480764
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 09:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbhL1I0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 03:26:44 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38692 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbhL1I0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 03:26:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9CD97B80D97;
        Tue, 28 Dec 2021 08:26:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5D3C36AE8;
        Tue, 28 Dec 2021 08:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640679996;
        bh=Jm+D1iWBu7R1yzoXReCfMiYzW4DAqKUJ4JBX9vgR8oQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FLSklKthTjHedcZTLZXv14S8I4mJOCaIIAB0NdYQz8pqZXFFg+xO0CHNDGovd6Ecd
         KVqqbaoLiwfCiwgbCVi9wiknkWdrF1QwNmUKALAs6THA2/YwdU4S+UEUXklhdiGHe7
         NCvQYH3R2/u7y1DzWjMHnYR1zSyXAfhKrE9g5/WI=
Date:   Tue, 28 Dec 2021 09:26:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Puma Hsu <pumahsu@google.com>
Cc:     mathias.nyman@intel.com, albertccwang@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xhci: re-initialize the HC during resume if HCE was set
Message-ID: <YcrKNP4TRXB6nsCI@kroah.com>
References: <20211228060246.2958070-1-pumahsu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211228060246.2958070-1-pumahsu@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 02:02:46PM +0800, Puma Hsu wrote:
> When HCE(Host Controller Error) is set, it means an internal
> error condition has been detected. It needs to re-initialize
> the HC too.
> 
> Signed-off-by: Puma Hsu <pumahsu@google.com>
> ---
>  drivers/usb/host/xhci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index dc357cabb265..c546d9533410 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -1146,8 +1146,8 @@ int xhci_resume(struct xhci_hcd *xhci, bool hibernated)
>  		temp = readl(&xhci->op_regs->status);
>  	}
>  
> -	/* If restore operation fails, re-initialize the HC during resume */
> -	if ((temp & STS_SRE) || hibernated) {
> +	/* If restore operation fails or HC error is detected, re-initialize the HC during resume */
> +	if ((temp & STS_SRE) || (temp & STS_HCE) || hibernated) {
>  
>  		if ((xhci->quirks & XHCI_COMP_MODE_QUIRK) &&
>  				!(xhci_all_ports_seen_u0(xhci))) {
> -- 
> 2.34.1.448.ga2b2bfdf31-goog
> 

What commit does this fix?  Does it need to be backported to older
kernels as well?

thanks,

greg k-h
