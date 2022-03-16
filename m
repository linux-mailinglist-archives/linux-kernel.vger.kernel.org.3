Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959DF4DAF4B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 12:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355528AbiCPL71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 07:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345168AbiCPL7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 07:59:25 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E16167FA;
        Wed, 16 Mar 2022 04:58:10 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id s25so3317439lfs.10;
        Wed, 16 Mar 2022 04:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X5KML0hnqyksN62QQjE8XBIPa5cXwZ293F5MGevyM2U=;
        b=hVvNVkdvqeMRw6MG9cFqU9kZtzJuZGq7VFcM2ZSuH6z7LmbfOFrjbSJ596Ij4N2bTJ
         lP0VJp8wMsGBQrZ1KW7zM7lrhQI7uXi/umxZsXDYvCWayoAfWrjwjh+RJiWi4vlyU2zd
         PRqytTrJvgIsBbT8Y22hkKs3UVlkEZlVvQk0eMfX9lOpL4R5d3ooh2h1iDB9SkgdGgHJ
         t+cT2GkdnqMjdwABPLaN3gPFe7WLblqgOEmo36UcZOKYbazOBdr4ly4JdoMlXUWLCZ1z
         Z6ME6GNWCxJbMSEh3GTvmDJ0/6ZOM2ii8cI37rzDP24m1bmM1mHzTD3KEndKNxWYX8he
         VY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X5KML0hnqyksN62QQjE8XBIPa5cXwZ293F5MGevyM2U=;
        b=SqU5DUxdqMSt9ATjpmKEQFwGKepAo7JH2dQXw07BjaKZNDEepljJaCIZ26oCuSqpwC
         4fGgEW7HOTEUcg77cPwsupvGmF8rYWMqHvQeJ5zmR+yAY3otdIsUdYv2lG7JjX+lMX5Y
         jH7CDF+QRNXeMQNuRRHp1DWpuIi6/l4BrIGC4alHwfAqihrAdKns2IG6YbpJDbrPR3TJ
         QpYrWap0y80Cq2fbb2zg6i7SPL8WR/wypj6AgtylQ5Yul6jnE/hybFssh8ts0yZuNcgA
         N6yaVnoEArAfNwgmGZ89JhSGBzydzyoeP4LkybLdGj1nspJR5dclhC4CPZNYhhp+Xw4w
         cG9w==
X-Gm-Message-State: AOAM532xEry7IPy0B79SfIpd9VG6n7dWBjUK8Ux8Yzi7ZQuW6RcuMZwD
        vPinY9aVruua2DPV5SviC3VNMuIeYMa59MSw0Rg1wwVb
X-Google-Smtp-Source: ABdhPJw2L+OZSIYZv1DhyLkq071py4zAmh+vwGVJQBxC0XXbct9zGflXcugCXhiN8H7Q4QhXEZH8M5YpRhl9iDRdcvA=
X-Received: by 2002:a05:6512:410:b0:448:b553:8a00 with SMTP id
 u16-20020a056512041000b00448b5538a00mr2401057lfk.354.1647431889046; Wed, 16
 Mar 2022 04:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <3c576edf-89c3-ccf3-a43f-4ce2c1ced18d@zhaoxin.com> <Yi7xJy70XZCA8RyN@kroah.com>
In-Reply-To: <Yi7xJy70XZCA8RyN@kroah.com>
From:   Peter Chen <hzpeterchen@gmail.com>
Date:   Wed, 16 Mar 2022 19:57:54 +0800
Message-ID: <CAL411-o_2PSndEVXfa+ciLukSr5u5w8G9T63d2MpSm2Fpn5QTQ@mail.gmail.com>
Subject: Re: [PATCH] USB: Fix xhci ERDP update issue
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>,
        mathias.nyman@intel.com, Alan Stern <stern@rowland.harvard.edu>,
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

On Mon, Mar 14, 2022 at 10:34 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Mar 14, 2022 at 03:25:23PM +0800, WeitaoWang-oc@zhaoxin.com wrote:
> > On some situations, software handles TRB events slower than adding TRBs,
> > xhci_irq will not exit until all events are handled. If xhci_irq just
> > handles 256 TRBs and exit, the temp variable(event_ring_deq) driver records
> > in xhci irq is equal to driver current dequeue pointer. It will cause driver
> > not update ERDP and software dequeue pointer lost sync with ERDP. On the
> > next xhci_irq, the event ring is full but driver will not update ERDP as
> > software dequeue pointer is equal to ERDP.

At the current driver, the ERDP is updated at most 128 TRBs, how is
the above condition
triggered?

Peter



> >
> > [  536.377115] xhci_hcd 0000:00:12.0: ERROR unknown event type 37
> > [  566.933173] sd 8:0:0:0: [sdb] tag#27 uas_eh_abort_handler 0 uas-tag 7
> > inflight: CMD OUT
> > [  566.933181] sd 8:0:0:0: [sdb] tag#27 CDB: Write(10) 2a 00 17 71 e6 78 00
> > 00 08 00
> > [  572.041186] xhci_hcd On some situataions,the0000:00:12.0: xHCI host not
> > responding to stop endpoint command.
> > [  572.057193] xhci_hcd 0000:00:12.0: Host halt failed, -110
> > [  572.057196] xhci_hcd 0000:00:12.0: xHCI host controller not responding,
> > assume dead
> > [  572.057236] sd 8:0:0:0: [sdb] tag#26 uas_eh_abort_handler 0 uas-tag 6
> > inflight: CMD
> > [  572.057240] sd 8:0:0:0: [sdb] tag#26 CDB: Write(10) 2a 00 38 eb cc d8 00
> > 00 08 00
> > [  572.057244] sd 8:0:0:0: [sdb] tag#25 uas_eh_abort_handler 0 uas-tag 5
> > inflight: CMD
> >
> > Fixed this issue by update software record temp variable when handles 128
> > TRB events.
> >
> > Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
> > ---
> >  drivers/usb/host/xhci-ring.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> > index d0b6806..f970799 100644
> > --- a/drivers/usb/host/xhci-ring.c
> > +++ b/drivers/usb/host/xhci-ring.c
> > @@ -3141,6 +3141,7 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd)
> >                 if (event_loop++ < TRBS_PER_SEGMENT / 2)
> >                         continue;
> >                 xhci_update_erst_dequeue(xhci, event_ring_deq);
> > +               event_ring_deq = xhci->event_ring->dequeue;
> >
> >                 /* ring is half-full, force isoc trbs to interrupt more
> > often */
> >                 if (xhci->isoc_bei_interval > AVOID_BEI_INTERVAL_MIN)
> > --
> > 2.7.4
>
> Hi,
>
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
>
> You are receiving this message because of the following common error(s)
> as indicated below:
>
> - Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
>   and can not be applied.  Please read the file,
>   Documentation/email-clients.txt in order to fix this.
>
>
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
>
> thanks,
>
> greg k-h's patch email bot
