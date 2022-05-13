Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCF6525C3B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377716AbiEMHMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 03:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377711AbiEMHMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 03:12:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411AE26FA53;
        Fri, 13 May 2022 00:12:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3D37B82C44;
        Fri, 13 May 2022 07:12:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56728C34100;
        Fri, 13 May 2022 07:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652425939;
        bh=Efly38ojSC+2X+o+BwIM7NdLaXlX8jtPOhcOnIOteXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G9FfP9WB1HTWb4GUFWG07bcH6hGMuS4e/umt/T/vWdhgoh07vL27cWDLwn4bh+bUp
         KKhvBQ/dfrs9VsQdOpwFjQqt/GIDp0hIsDddpnVCyfgizwHF7qEmrdItpKc4PWjsvZ
         LddMS9YkQ7pEsX8FLzcKUMc5WpzXG33UGt/WsFc0=
Date:   Fri, 13 May 2022 09:12:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Albert Wang <albertccwang@google.com>
Cc:     balbi@kernel.org, quic_jackp@quicinc.com, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb: dwc3: gadget: Move null pinter check after
 window closed
Message-ID: <Yn4E0XHlsPjaEgMw@kroah.com>
References: <20220513065709.1606634-1-albertccwang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513065709.1606634-1-albertccwang@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 02:57:09PM +0800, Albert Wang wrote:
> After inspecting further, we do see the locking is implicit, with the
> main gotcha being the unlock/re-lock.

This sentance makes no sense at all.

Who is "we"?  What is the gotcha?  What is the subject of the sentance?
What is going on?

> That creates a window for a race to happen.

What is "that"?

> This change moves the NULL check to be adjacent to where
> to it's used and after the window is "closed".

What is "this"?

Please read Documentation/process/submitting-patches.rst for how to
properly write a changelog text so that others can understand what is
going on.

thanks,

greg k-h


> 
> Fixes: 26288448120b ("usb: dwc3: gadget: Fix null pointer exception")
> Signed-off-by: Albert Wang <albertccwang@google.com>
> ---
>  v3: Add change log to be compliant with the canonical patch format
>  v2: Remove redundant 'else' and add additional comments and more
>      descriptive commit text
> 
>  drivers/usb/dwc3/gadget.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 19477f4bbf54..fda58951cf27 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -3366,14 +3366,19 @@ static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
>  	struct dwc3		*dwc = dep->dwc;
>  	bool			no_started_trb = true;
>  
> -	if (!dep->endpoint.desc)
> -		return no_started_trb;
> -
> +	/*
> +	 * This function eventually leads to dwc3_giveback() which unlocks
> +	 * the dwc->lock and relocks afterwards. This actually creates a
> +	 * a window for a race to happen.

What race?  Why mention it here?  Why not fix it instead of documenting
it?

this comment does not make sense, sorry.

thanks,

greg k-h
