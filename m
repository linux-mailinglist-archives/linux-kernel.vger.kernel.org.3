Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A2D54F9F5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 17:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383103AbiFQPPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 11:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383088AbiFQPPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 11:15:37 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 451683614A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 08:15:36 -0700 (PDT)
Received: (qmail 769005 invoked by uid 1000); 17 Jun 2022 11:15:35 -0400
Date:   Fri, 17 Jun 2022 11:15:35 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Liang He <windhl@126.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: host: ohci-ppc-of: Fix refcount leak bug
Message-ID: <Yqyal2aXvZRebui+@rowland.harvard.edu>
References: <20220617034637.4003115-1-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617034637.4003115-1-windhl@126.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 11:46:37AM +0800, Liang He wrote:
> In ohci_hcd_ppc_of_probe(), of_find_compatible_node() will return
> a node pointer with refcount incremented. We should use of_node_put()
> when it is not used anymore.
> 
> Signed-off-by: Liang He <windhl@126.com>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

This seems to be the last one; ehci-ppc-of.c was already fixed by an 
earlier patch.

>  drivers/usb/host/ohci-ppc-of.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/host/ohci-ppc-of.c b/drivers/usb/host/ohci-ppc-of.c
> index 1960b8dfdba5..591f675cc930 100644
> --- a/drivers/usb/host/ohci-ppc-of.c
> +++ b/drivers/usb/host/ohci-ppc-of.c
> @@ -166,6 +166,7 @@ static int ohci_hcd_ppc_of_probe(struct platform_device *op)
>  				release_mem_region(res.start, 0x4);
>  		} else
>  			pr_debug("%s: cannot get ehci offset from fdt\n", __FILE__);
> +		of_node_put(np);
>  	}
>  
>  	irq_dispose_mapping(irq);
> -- 
> 2.25.1
> 
