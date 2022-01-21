Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CA14961BD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 16:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381493AbiAUPJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 10:09:03 -0500
Received: from netrider.rowland.org ([192.131.102.5]:47619 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1381484AbiAUPJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 10:09:02 -0500
Received: (qmail 17761 invoked by uid 1000); 21 Jan 2022 10:09:00 -0500
Date:   Fri, 21 Jan 2022 10:09:00 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_sourcesink: Fix isoc transfer for
 USB_SPEED_SUPER_PLUS
Message-ID: <YerMjGG8VQkI85bB@rowland.harvard.edu>
References: <1642764684-26060-1-git-send-email-quic_pkondeti@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1642764684-26060-1-git-send-email-quic_pkondeti@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 05:01:24PM +0530, Pavankumar Kondeti wrote:
> Currently when gadget enumerates in super speed plus, the isoc
> endpoint request buffer size is not calculated correctly. Fix
> this by checking the gadget speed against USB_SPEED_SUPER_PLUS
> and update the request buffer size.
> 
> Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
> ---
>  drivers/usb/gadget/function/f_sourcesink.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/gadget/function/f_sourcesink.c b/drivers/usb/gadget/function/f_sourcesink.c
> index 1abf08e..0a423ba 100644
> --- a/drivers/usb/gadget/function/f_sourcesink.c
> +++ b/drivers/usb/gadget/function/f_sourcesink.c
> @@ -584,6 +584,8 @@ static int source_sink_start_ep(struct f_sourcesink *ss, bool is_in,
>  
>  	if (is_iso) {
>  		switch (speed) {
> +		case USB_SPEED_SUPER_PLUS:
> +			fallthrough;

There's no need for this "fallthough" line.  You're allowed to have 
multiple case labels for a single block of code.

Alan Stern

>  		case USB_SPEED_SUPER:
>  			size = ss->isoc_maxpacket *
>  					(ss->isoc_mult + 1) *
> -- 
> 2.7.4
> 
