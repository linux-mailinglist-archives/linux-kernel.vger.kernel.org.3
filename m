Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B274D7C20
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 08:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236743AbiCNHki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 03:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiCNHkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:40:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C8C15A3C;
        Mon, 14 Mar 2022 00:39:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F5F7B80D23;
        Mon, 14 Mar 2022 07:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BF4C340F6;
        Mon, 14 Mar 2022 07:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647243564;
        bh=hyHKa60oXqLMWAMVXpGMeOM3xEshsXN3pwLJbgdydhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0vHXeOjjVL98pYvqnriD/yKpCTVgkNtzwO0SiLb16xI8C0ecnJ6HhS2yvj5Zp4ANn
         vo+kL3rhYjQxFccN3cyCweSpbB+YMTW/LAs36KnDFzK2/95RpHVWOQOraAPcearMrh
         mal1yh4x65R4kCxVyh3BqUpepxMdtbbJlK6izA/s=
Date:   Mon, 14 Mar 2022 08:39:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>
Cc:     mathias.nyman@intel.com, stern@rowland.harvard.edu,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, tonywwang@zhaoxin.com,
        weitaowang@zhaoxin.com
Subject: Re: [PATCH] USB: Fix xhci ERDP update issue
Message-ID: <Yi7xJy70XZCA8RyN@kroah.com>
References: <3c576edf-89c3-ccf3-a43f-4ce2c1ced18d@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c576edf-89c3-ccf3-a43f-4ce2c1ced18d@zhaoxin.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 03:25:23PM +0800, WeitaoWang-oc@zhaoxin.com wrote:
> On some situations, software handles TRB events slower than adding TRBs,
> xhci_irq will not exit until all events are handled. If xhci_irq just
> handles 256 TRBs and exit, the temp variable(event_ring_deq) driver records
> in xhci irq is equal to driver current dequeue pointer. It will cause driver
> not update ERDP and software dequeue pointer lost sync with ERDP. On the
> next xhci_irq, the event ring is full but driver will not update ERDP as
> software dequeue pointer is equal to ERDP.
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
> Fixed this issue by update software record temp variable when handles 128
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
>                 if (event_loop++ < TRBS_PER_SEGMENT / 2)
>                         continue;
>                 xhci_update_erst_dequeue(xhci, event_ring_deq);
> +               event_ring_deq = xhci->event_ring->dequeue;
> 
>                 /* ring is half-full, force isoc trbs to interrupt more
> often */
>                 if (xhci->isoc_bei_interval > AVOID_BEI_INTERVAL_MIN)
> -- 
> 2.7.4

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/email-clients.txt in order to fix this.


If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
