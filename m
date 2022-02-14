Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B384B5019
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353103AbiBNM3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:29:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbiBNM3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:29:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FFE49FA1;
        Mon, 14 Feb 2022 04:29:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C18866133D;
        Mon, 14 Feb 2022 12:29:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A138FC340E9;
        Mon, 14 Feb 2022 12:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644841755;
        bh=5IGxa689e5iHmV9vD0rVk3g14o/eyR3Y+iTP3FcfY4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rHIfnmiZ8qFCsWhuH4/NtvYJmIbQgYsdk/sLU7NmJFgsposVN69K41w3goJDtzvh1
         K78UsQ1zy1fkKx5XC4bfRF3/DBfm/bJF2ooHaazXBJsM3kr4QMvdIqKofS+RZq7ZOg
         wkQF7IfpB7SzSLYce+M06fFo4ku7fNIQSJ7Gn04U=
Date:   Mon, 14 Feb 2022 13:29:12 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_ugoswami@quicinc.com,
        Jung Daehwan <dh10.jung@samsung.com>
Subject: Re: [PATCH v2] xhci: reduce xhci_handshake timeout in xhci_reset
Message-ID: <YgpLGGYI0W9mL2gg@kroah.com>
References: <1644836663-29220-1-git-send-email-quic_pkondeti@quicinc.com>
 <1644841216-1468-1-git-send-email-quic_pkondeti@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644841216-1468-1-git-send-email-quic_pkondeti@quicinc.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 05:50:16PM +0530, Pavankumar Kondeti wrote:
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
> 
> v2:
> - Add error print statements in the code that change log refers to
> 
>  drivers/usb/host/xhci.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index dc357ca..bb9ea3f 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -196,9 +196,11 @@ int xhci_reset(struct xhci_hcd *xhci)
>  		udelay(1000);
>  
>  	ret = xhci_handshake(&xhci->op_regs->command,
> -			CMD_RESET, 0, 10 * 1000 * 1000);
> -	if (ret)
> +			CMD_RESET, 0, 1 * 1000 * 1000);
> +	if (ret) {
> +		xhci_err(xhci, "Host controller reset timed out\n");

A timeout is not the only error that could have happened here.  So why
claim that all errors are timeout errors?

How did you test this?

thanks,

greg k-h
