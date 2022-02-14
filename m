Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E4A4B4F1D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352669AbiBNLon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:44:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349397AbiBNLoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:44:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA176476;
        Mon, 14 Feb 2022 03:36:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2306FB80E63;
        Mon, 14 Feb 2022 11:36:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346BFC340E9;
        Mon, 14 Feb 2022 11:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644838609;
        bh=TlEzTKDzz5YLQbPZsQhzfVGSadqt4B9CIscYLj+LK0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kugVbjDXHW+279ffyykAIl+lm4lroL1fP+sYFb5z/GkuL+jLxnZCzK674q5/Wn6C2
         xjUNWDD19u30ntzVU9q9KxkAOE/zR2OxqMnT0xcEPJwLjnF29KIH0D9ip0npLUDbGW
         R3XlYJIIsEZ2ipmVcjVXYSMxP6KajNa5BHU9VzG0=
Date:   Mon, 14 Feb 2022 12:36:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Sarah Sharp <sarah.a.sharp@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ugoswami@quicinc.com, Jung Daehwan <dh10.jung@samsung.com>
Subject: Re: [PATCH] xhci: reduce xhci_handshake timeout in xhci_reset
Message-ID: <Ygo+zxEu0gVh4THE@kroah.com>
References: <1644836663-29220-1-git-send-email-quic_pkondeti@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644836663-29220-1-git-send-email-quic_pkondeti@quicinc.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 04:34:23PM +0530, Pavankumar Kondeti wrote:
> From: Daehwan Jung <dh10.jung@samsung.com>
> 
> xhci_reset() is called with interrupts disabled. Waiting 10 seconds for
> controller reset and controller ready operations can be fatal to the
> system when controller is timed out. Reduce the timeout to 1 second
> and print a error message when the time out happens.
> 
> Fixes: 22ceac191211 ("xhci: Increase reset timeout for Renesas 720201 host.")
> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
> ---
>  drivers/usb/host/xhci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index dc357ca..ec4df72 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -196,7 +196,7 @@ int xhci_reset(struct xhci_hcd *xhci)
>  		udelay(1000);
>  
>  	ret = xhci_handshake(&xhci->op_regs->command,
> -			CMD_RESET, 0, 10 * 1000 * 1000);
> +			CMD_RESET, 0, 1 * 1000 * 1000);
>  	if (ret)
>  		return ret;
>  
> @@ -210,7 +210,7 @@ int xhci_reset(struct xhci_hcd *xhci)
>  	 * than status until the "Controller Not Ready" flag is cleared.
>  	 */
>  	ret = xhci_handshake(&xhci->op_regs->status,
> -			STS_CNR, 0, 10 * 1000 * 1000);
> +			STS_CNR, 0, 1 * 1000 * 1000);
>  
>  	xhci->usb2_rhub.bus_state.port_c_suspend = 0;
>  	xhci->usb2_rhub.bus_state.suspended_ports = 0;
> -- 
> 2.7.4
> 

I do not see any "print an error message" change here.  Where is that
addition?

confused,

greg k-h
