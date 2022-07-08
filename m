Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C1856BC39
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 17:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238196AbiGHOjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 10:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237847AbiGHOjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:39:08 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 2D89E1B7AC
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 07:39:07 -0700 (PDT)
Received: (qmail 7518 invoked by uid 1000); 8 Jul 2022 10:39:06 -0400
Date:   Fri, 8 Jul 2022 10:39:06 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jozef Martiniak <jomajm@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>, Hangyu Hua <hbh25y@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gadgetfs: ep_io - wait until IRQ finishes
Message-ID: <YshBijUt6HgPeB0U@rowland.harvard.edu>
References: <20220708070645.6130-1-jomajm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708070645.6130-1-jomajm@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 09:06:44AM +0200, Jozef Martiniak wrote:
> after usb_ep_queue() if wait_for_completion_interruptible() is
> interrupted we need to wait until IRQ gets finished.

This should say "request" or "I/O request", not "IRQ".  Not a big deal.

> 
> Otherwise complete() from epio_complete() can corrupt stack.
> 
> Signed-off-by: Jozef Martiniak <jomajm@gmail.com>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/gadget/legacy/inode.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
> index 79990597c39f..01c3ead7d1b4 100644
> --- a/drivers/usb/gadget/legacy/inode.c
> +++ b/drivers/usb/gadget/legacy/inode.c
> @@ -362,6 +362,7 @@ ep_io (struct ep_data *epdata, void *buf, unsigned len)
>  				spin_unlock_irq (&epdata->dev->lock);
>  
>  				DBG (epdata->dev, "endpoint gone\n");
> +				wait_for_completion(&done);
>  				epdata->status = -ENODEV;
>  			}
>  		}
> -- 
> 2.25.1
> 
