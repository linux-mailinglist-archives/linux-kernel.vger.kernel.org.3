Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF944DBCB4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 02:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352830AbiCQB63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 21:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbiCQB62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 21:58:28 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891B11CB1B;
        Wed, 16 Mar 2022 18:57:13 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id q5so5420913ljb.11;
        Wed, 16 Mar 2022 18:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D2eRtDhUiRlh6LC4tNmroWlfl0w9KefZzF7QC113Ymw=;
        b=HWHhI+tJQb7NceqGVdfZf3qv6HHsoD0DK8KH+CJhB6W4ZWMx0h+SDyEEwnL25LMVQg
         zKpt0ilsFTJWMEn+YotbBv+CHmhm5wz9RJm+gBH3YhHI/sHYQXOCtql1zNHK16BwRv2P
         sGc0l127JfS/+cMODtL4iRAzr56VdQX3AYGKDR/BmEsAQPDNuYKFh+B1i0a2Px4TICyD
         OWROAcrc5KqNBGAXvwAhOqXYkRgxfVHMf+b+Z1cYZBFcpkRErF0rm1jhR9xPhKPFUnbW
         0XJsyPajRCCHhkCPbcMA0M0GcAvaVRxYsfyiDLT9zqaKO3jUS9WTDeci37Hs2h244u1Z
         /FdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D2eRtDhUiRlh6LC4tNmroWlfl0w9KefZzF7QC113Ymw=;
        b=PWlxqGLaegudeSlUyEronYsKHl3U0xDk79vXeZFovlK8kiB4MWeABDOT0C8DrB5za5
         fQk9eODxH6cQyPeiOS2plK3kvWAe9c8m99O1wolgLRG/TLq8pzDuR1pMvh5O4ZPQ+vtl
         z4H3xTlMcudd3nhfJY9jTPvrKvfozLoNf7E53/D+V76sAT9/DkwZgRzVD1WxN2snq+mB
         fzszcb9RLugd0QFzmh0B1D5ZhPRbWCjg1BA/4JKZ4XjEU7x7sjRDhbPB9Ed1t2ip6rQo
         GNqtebi79d8AeLeizIOEdNf0gcT0RHU5zvVziQ88qoHUaybyhYWI3xbICUlhqbnx4B9r
         Fiog==
X-Gm-Message-State: AOAM532f7KKR8TnCb7txfbfIDKaFwBuNZzwhEWHT+PUo+ftlOKarolbS
        qYwWNpaMYb1YEf3cDvb77BBkVSU5TLCopR+84L0=
X-Google-Smtp-Source: ABdhPJyFlkiIFXp5hQL4DLC4LGWzR86G2RzWAwiNyNiA38WnKp4DUP+0KDCKDRtO1/T4VA2hZDiQIlMOygIkkzfVeKY=
X-Received: by 2002:a2e:9d86:0:b0:247:da0e:7c59 with SMTP id
 c6-20020a2e9d86000000b00247da0e7c59mr1443340ljj.127.1647482231736; Wed, 16
 Mar 2022 18:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <3c576edf-89c3-ccf3-a43f-4ce2c1ced18d@zhaoxin.com>
In-Reply-To: <3c576edf-89c3-ccf3-a43f-4ce2c1ced18d@zhaoxin.com>
From:   Peter Chen <hzpeterchen@gmail.com>
Date:   Thu, 17 Mar 2022 09:56:57 +0800
Message-ID: <CAL411-pthKbSuUEjFPDJtRK=nWApRnJkPVH0C+qaqNRyf0u5yg@mail.gmail.com>
Subject: Re: [PATCH] USB: Fix xhci ERDP update issue
To:     "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>
Cc:     mathias.nyman@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        USB list <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, CobeChen@zhaoxin.com,
        TimGuo@zhaoxin.com, tonywwang@zhaoxin.com, weitaowang@zhaoxin.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 1:30 AM WeitaoWang-oc@zhaoxin.com
<WeitaoWang-oc@zhaoxin.com> wrote:
>
> On some situations, software handles TRB events slower than adding TRBs,
> xhci_irq will not exit until all events are handled. If xhci_irq just
> handles 256 TRBs and exit, the temp variable(event_ring_deq) driver
> records in xhci irq is equal to driver current dequeue pointer. It will
> cause driver not update ERDP and software dequeue pointer lost sync with
> ERDP. On the next xhci_irq, the event ring is full but driver will not
> update ERDP as software dequeue pointer is equal to ERDP.
>
> [  536.377115] xhci_hcd 0000:00:12.0: ERROR unknown event type 37
> [  566.933173] sd 8:0:0:0: [sdb] tag#27 uas_eh_abort_handler 0 uas-tag 7
> inflight: CMD OUT
> [  566.933181] sd 8:0:0:0: [sdb] tag#27 CDB: Write(10) 2a 00 17 71 e6 78
> 00 00 08 00
> [  572.041186] xhci_hcd On some situataions,the0000:00:12.0: xHCI host
> not responding to stop endpoint command.
> [  572.057193] xhci_hcd 0000:00:12.0: Host halt failed, -110
> [  572.057196] xhci_hcd 0000:00:12.0: xHCI host controller not
> responding, assume dead
> [  572.057236] sd 8:0:0:0: [sdb] tag#26 uas_eh_abort_handler 0 uas-tag 6
> inflight: CMD
> [  572.057240] sd 8:0:0:0: [sdb] tag#26 CDB: Write(10) 2a 00 38 eb cc d8
> 00 00 08 00
> [  572.057244] sd 8:0:0:0: [sdb] tag#25 uas_eh_abort_handler 0 uas-tag 5
> inflight: CMD
>
> Fixed this issue by update software record temp variable when handles
> 128 TRB events.
>
> Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>

Reviewed-by: Peter Chen <peter.chen@kernel.org>

> ---
>   drivers/usb/host/xhci-ring.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index d0b6806..f970799 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -3141,6 +3141,7 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd)
>                  if (event_loop++ < TRBS_PER_SEGMENT / 2)
>                          continue;
>                  xhci_update_erst_dequeue(xhci, event_ring_deq);
> +               event_ring_deq = xhci->event_ring->dequeue;
>
>                  /* ring is half-full, force isoc trbs to interrupt more
> often */
>                  if (xhci->isoc_bei_interval > AVOID_BEI_INTERVAL_MIN)
> --
> 2.7.4
