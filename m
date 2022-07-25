Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC588580045
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 15:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbiGYN6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 09:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbiGYN6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 09:58:08 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id EB83312D32
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 06:58:02 -0700 (PDT)
Received: (qmail 351518 invoked by uid 1000); 25 Jul 2022 09:58:01 -0400
Date:   Mon, 25 Jul 2022 09:58:01 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Weitao Wang <WeitaoWang-oc@zhaoxin.com>
Cc:     gregkh@linuxfoundation.org, kishon@ti.com, dianders@chromium.org,
        s.shtylyov@omp.ru, mka@chromium.org, ming.lei@canonical.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        tonywwang@zhaoxin.com, weitaowang@zhaoxin.com
Subject: Re: [PATCH v2] USB: HCD: Fix URB giveback issue in tasklet function
Message-ID: <Yt6haeQBseJOEx1r@rowland.harvard.edu>
References: <20220725065251.832087-1-WeitaoWang-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725065251.832087-1-WeitaoWang-oc@zhaoxin.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 02:52:51PM +0800, Weitao Wang wrote:

This is basically okay.  Just a couple of small comments...

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
> Fix this issue by taking new URBs giveback in next tasklet function call.
> Add a member high_prio for structure giveback_urb_bh and replace the local
> high_prio_bh variable with this structure member in usb_hcd_giveback_urb.

The patch description should do more than say what the new code _is_ -- 
we can see that easily enough by reading the patch.  The description 
should explain _why_ the code was changed.

> Fixes: 94dfd7edfd5c ("USB: HCD: support giveback of URB in tasklet context")
> Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
> ---
> v1->v2:
>  - Fix compile warning by remove label "restart".
>  - Modify the patch description info.
>  - Change structure member from hi_priority to high_prio.
> 
>  drivers/usb/core/hcd.c  | 25 ++++++++++++++-----------
>  include/linux/usb/hcd.h |  1 +
>  2 files changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 06eea8848ccc..1feb9a604380 100644
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
> @@ -1705,10 +1704,16 @@ static void usb_giveback_urb_bh(struct tasklet_struct *t)
>  		bh->completing_ep = NULL;
>  	}
>  
> -	/* check if there are new URBs to giveback */
> +	/* giveback new URBs next time to prevent this function from
> +	 * not exiting for a long time.
> +	 */

Minor stylistic issue: The currently accepted format for multi-line 
comments is like this:

	/*
	 * Blah blah blah
	 * Blah blah blah
	 */

Alan Stern
