Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4310D5814BC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239181AbiGZOCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbiGZOCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:02:05 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id CEC7EF1C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 07:02:03 -0700 (PDT)
Received: (qmail 386446 invoked by uid 1000); 26 Jul 2022 10:02:02 -0400
Date:   Tue, 26 Jul 2022 10:02:02 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Weitao Wang <WeitaoWang-oc@zhaoxin.com>
Cc:     gregkh@linuxfoundation.org, kishon@ti.com, dianders@chromium.org,
        s.shtylyov@omp.ru, mka@chromium.org, ming.lei@canonical.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        tonywwang@zhaoxin.com, weitaowang@zhaoxin.com
Subject: Re: [PATCH v3] USB: HCD: Fix URB giveback issue in tasklet function
Message-ID: <Yt/z2upnvoWGhkQO@rowland.harvard.edu>
References: <20220726074918.5114-1-WeitaoWang-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726074918.5114-1-WeitaoWang-oc@zhaoxin.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 03:49:18PM +0800, Weitao Wang wrote:
> Usb core introduce the mechanism of giveback of URB in tasklet context to
> reduce hardware interrupt handling time. On some test situation(such as
> FIO with 4KB block size), when tasklet callback function called to
> giveback URB, interrupt handler add URB node to the bh->head list also.
> If check bh->head list again after finish all URB giveback of local_list,
> then it may introduce a "dynamic balance" between giveback URB and add URB
> to bh->head list. This tasklet callback function may not exit for a long
> time, which will cause other tasklet function calls to be delayed. Some
> real-time applications(such as KB and Mouse) will see noticeable lag.
> 
> In order to prevent the tasklet function from occupying the cpu for a long
> time at a time, new URBS will not be added to the local_list even though
> the bh->head list is not empty. But also need to ensure the left URB
> giveback to be processed in time, so add a member high_prio for structure
> giveback_urb_bh to prioritize tasklet and schelule this tasklet again if
> bh->head list is not empty.
> 
> At the same time, we are able to prioritize tasklet through structure
> member high_prio. So, replace the local high_prio_bh variable with this
> structure member in usb_hcd_giveback_urb.
> 
> Fixes: 94dfd7edfd5c ("USB: HCD: support giveback of URB in tasklet context")
> Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
> ---

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

> v2->v3
>  - Add more detail info about how to patch this issue.
>  - Change initial value of boolean variable high_prio from 1 to true.
> 
>  drivers/usb/core/hcd.c  | 26 +++++++++++++++-----------
>  include/linux/usb/hcd.h |  1 +
>  2 files changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 06eea8848ccc..11c8ea0cccc8 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -1691,7 +1691,6 @@ static void usb_giveback_urb_bh(struct tasklet_struct *t)
>  
>  	spin_lock_irq(&bh->lock);
>  	bh->running = true;
> - restart:
>  	list_replace_init(&bh->head, &local_list);
>  	spin_unlock_irq(&bh->lock);
>  
> @@ -1705,10 +1704,17 @@ static void usb_giveback_urb_bh(struct tasklet_struct *t)
>  		bh->completing_ep = NULL;
>  	}
>  
> -	/* check if there are new URBs to giveback */
> +	/*
> +	 * giveback new URBs next time to prevent this function
> +	 * from not exiting for a long time.
> +	 */
>  	spin_lock_irq(&bh->lock);
> -	if (!list_empty(&bh->head))
> -		goto restart;
> +	if (!list_empty(&bh->head)) {
> +		if (bh->high_prio)
> +			tasklet_hi_schedule(&bh->bh);
> +		else
> +			tasklet_schedule(&bh->bh);
> +	}
>  	bh->running = false;
>  	spin_unlock_irq(&bh->lock);
>  }
> @@ -1737,7 +1743,7 @@ static void usb_giveback_urb_bh(struct tasklet_struct *t)
>  void usb_hcd_giveback_urb(struct usb_hcd *hcd, struct urb *urb, int status)
>  {
>  	struct giveback_urb_bh *bh;
> -	bool running, high_prio_bh;
> +	bool running;
>  
>  	/* pass status to tasklet via unlinked */
>  	if (likely(!urb->unlinked))
> @@ -1748,13 +1754,10 @@ void usb_hcd_giveback_urb(struct usb_hcd *hcd, struct urb *urb, int status)
>  		return;
>  	}
>  
> -	if (usb_pipeisoc(urb->pipe) || usb_pipeint(urb->pipe)) {
> +	if (usb_pipeisoc(urb->pipe) || usb_pipeint(urb->pipe))
>  		bh = &hcd->high_prio_bh;
> -		high_prio_bh = true;
> -	} else {
> +	else
>  		bh = &hcd->low_prio_bh;
> -		high_prio_bh = false;
> -	}
>  
>  	spin_lock(&bh->lock);
>  	list_add_tail(&urb->urb_list, &bh->head);
> @@ -1763,7 +1766,7 @@ void usb_hcd_giveback_urb(struct usb_hcd *hcd, struct urb *urb, int status)
>  
>  	if (running)
>  		;
> -	else if (high_prio_bh)
> +	else if (bh->high_prio)
>  		tasklet_hi_schedule(&bh->bh);
>  	else
>  		tasklet_schedule(&bh->bh);
> @@ -2959,6 +2962,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
>  
>  	/* initialize tasklets */
>  	init_giveback_urb_bh(&hcd->high_prio_bh);
> +	hcd->high_prio_bh.high_prio = true;
>  	init_giveback_urb_bh(&hcd->low_prio_bh);
>  
>  	/* enable irqs just before we start the controller,
> diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
> index 2c1fc9212cf2..98d1921f02b1 100644
> --- a/include/linux/usb/hcd.h
> +++ b/include/linux/usb/hcd.h
> @@ -66,6 +66,7 @@
>  
>  struct giveback_urb_bh {
>  	bool running;
> +	bool high_prio;
>  	spinlock_t lock;
>  	struct list_head  head;
>  	struct tasklet_struct bh;
> -- 
> 2.32.0
