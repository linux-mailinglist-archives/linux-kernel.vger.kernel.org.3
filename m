Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E53F4DD56A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 08:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbiCRHqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 03:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbiCRHqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 03:46:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B6C1F6845;
        Fri, 18 Mar 2022 00:45:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7DA3BB82180;
        Fri, 18 Mar 2022 07:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56146C340E8;
        Fri, 18 Mar 2022 07:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647589523;
        bh=mfk69zuIPfhhcTWagGzypXujpE6TuqQQSU1CspPJeKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eKc008nJ+OiKWUc2qQSi5Q9LljBP/znyiJF/qhEJ9AvzMmJkDTLksln/tCGe/16Ta
         y4qUr6Yt8UwKHvsdlN+/UkBgN0JC1Fy21x3U6QR5wC2L5BrEgq7bgOuN0i4690udpD
         3qq0xKUhqD3T327sOt1FRY5HukK9RYj+cUwfh12c=
Date:   Fri, 18 Mar 2022 08:45:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>
Cc:     mathias.nyman@intel.com, hzpeterchen@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        TonyWWang-oc@zhaoxin.com, weitaowang@zhaoxin.com,
        CobeChen@zhaoxin.com, TimGuo@zhaoxin.com
Subject: Re: [PATCH] USB: Fix xhci ERDP update issue
Message-ID: <YjQ4jzgRmrDJClUZ@kroah.com>
References: <dedb789b-c1bb-34af-7887-78a3fc627e75@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dedb789b-c1bb-34af-7887-78a3fc627e75@zhaoxin.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 03:32:14PM +0800, WeitaoWang-oc@zhaoxin.com wrote:
> On some situations, software handles TRB events slower than adding TRBs.
> If the number of TRB events to be processed in a given interrupt is 256.
> The local variable "event_ring_deq" that records in interrupt handler
> is equal to software_dequeue. It will cause driver not update ERDP,then
> software dequeue pointer is out of sync with ERDP on interrupt exit.
> On the next interrupt, the event ring may full but driver will not
> update ERDP as software_dequeue is equal to ERDP.
> 
> [  536.377115] xhci_hcd 0000:00:12.0: ERROR unknown event type 37
> [  566.933173] sd 8:0:0:0: [sdb] tag#27 uas_eh_abort_handler 0 uas-tag 7
> inflight: CMD OUT
> [  566.933181] sd 8:0:0:0: [sdb] tag#27 CDB: Write(10) 2a 00 17 71 e6 78 00
> 00 08 00
> [  572.041186] xhci_hcd On some situataions,the0000:00:12.0: xHCI host not
> responding to stop endpoint command.
> [  572.057193] xhci_hcd 0000:00:12.0: Host halt failed, -110
> [  572.057196] xhci_hcd 0000:00:12.0: xHCI host controller not responding,
> assume dead
> [  572.057236] sd 8:0:0:0: [sdb] tag#26 uas_eh_abort_handler 0 uas-tag 6
> inflight: CMD
> [  572.057240] sd 8:0:0:0: [sdb] tag#26 CDB: Write(10) 2a 00 38 eb cc d8 00
> 00 08 00
> [  572.057244] sd 8:0:0:0: [sdb] tag#25 uas_eh_abort_handler 0 uas-tag 5
> inflight: CMD
> 
> Fixed this issue by update software record local variable when handles 128
> TRB events.
> 
> Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
> ---
>  drivers/usb/host/xhci-ring.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index d0b6806..f970799 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -3141,6 +3141,7 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd)
>  		if (event_loop++ < TRBS_PER_SEGMENT / 2)
>  			continue;
>  		xhci_update_erst_dequeue(xhci, event_ring_deq);
> +		event_ring_deq = xhci->event_ring->dequeue;
> 
>  		/* ring is half-full, force isoc trbs to interrupt more often */
>  		if (xhci->isoc_bei_interval > AVOID_BEI_INTERVAL_MIN)
> -- 
> 2.7.4

What commit id does this change fix?

thanks,

greg k-h
