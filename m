Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A6448B592
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 19:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344697AbiAKSTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 13:19:12 -0500
Received: from netrider.rowland.org ([192.131.102.5]:33349 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1344540AbiAKSTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 13:19:05 -0500
Received: (qmail 209967 invoked by uid 1000); 11 Jan 2022 13:19:04 -0500
Date:   Tue, 11 Jan 2022 13:19:04 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] usb: host: ehci-sched: Use struct_size() in
 kzalloc()
Message-ID: <Yd3KGMSb7vBIwH+j@rowland.harvard.edu>
References: <20220111075427.GA76390@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111075427.GA76390@embeddedor>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 01:54:27AM -0600, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows that,
> in the worse scenario, could lead to heap overflows.
> 
> Also, address the following sparse warning:
> drivers/usb/host/ehci-sched.c:1168:40: warning: using sizeof on a flexible structure
> 
> Link: https://github.com/KSPP/linux/issues/160
> Link: https://github.com/KSPP/linux/issues/174
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/host/ehci-sched.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-sched.c b/drivers/usb/host/ehci-sched.c
> index 0f85aa9b2fb1..bd542b6fc46b 100644
> --- a/drivers/usb/host/ehci-sched.c
> +++ b/drivers/usb/host/ehci-sched.c
> @@ -1165,10 +1165,8 @@ static struct ehci_iso_sched *
>  iso_sched_alloc(unsigned packets, gfp_t mem_flags)
>  {
>  	struct ehci_iso_sched	*iso_sched;
> -	int			size = sizeof(*iso_sched);
>  
> -	size += packets * sizeof(struct ehci_iso_packet);
> -	iso_sched = kzalloc(size, mem_flags);
> +	iso_sched = kzalloc(struct_size(iso_sched, packet, packets), mem_flags);
>  	if (likely(iso_sched != NULL))
>  		INIT_LIST_HEAD(&iso_sched->td_list);
>  
> -- 
> 2.27.0
> 
