Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42D1463A01
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 16:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235557AbhK3P3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 10:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbhK3P3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 10:29:49 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A6BC061574;
        Tue, 30 Nov 2021 07:26:30 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id t5so88697496edd.0;
        Tue, 30 Nov 2021 07:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tqLZVvk0RWhTD6VDf+Yk9o4cU+jOCNF9B48m9pB7b28=;
        b=fo6i4fuld0pIPppnlJmlHLjb7NQQr/Z4u+KsfZomLY1/DmQcAfbJUQ7XvmAhDThifZ
         x960Pxw09TiUwm94Ygzd9kWBrlSbHqOAdghmPhIMLhvAVJuXxw7N2J4aDyieHCp7zhkJ
         ioZR5ZrxbkrptkZ9917+d8bfgPCSuqMfB8s3iDcIfCiGFd5PEFEFDwBDp2DbHTNJ0ZCy
         EHEadC0aNVFocHdpoqiaNX3Od6R9L0i1SY3HgbsIIFI68tMcZBV2z1MdbC+zeL4Yb6AK
         liwPxh4fqK1i4vPsicH+ZSUIhYiKPYYgqxnBT8FfheZRnuyyt1GIsrczE6ka/D42r7B0
         AhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tqLZVvk0RWhTD6VDf+Yk9o4cU+jOCNF9B48m9pB7b28=;
        b=PRdGCftJC+89JsL5otBsxcvDLadkUuaAlpYJeJF1CLYwjATf1u1CMnk8fejOypxUep
         RDqWreK59Gi6+6tmeEjgKGMouveqLj/muev66qzCwwgvv+wsTf9ncth5U40bCF/i5u3o
         +FN5XNMJ4+p9WLy/7RiLgNLepi8sklBqyuLChXJdBviumgTrwPZCkaO2K0RmBtCgDU0s
         ISDCq0/nk8qC1PtEqOiMUSTjDiMu/vY2Yb0mpx3ebVO/DxiPvzOoSJ/68oaBbR3JOGog
         tudm7Xfdg7KWI4iCdgMeKJka0hZb7m27kvjpzNU4z0OY9JKUPL0RBJWk0nKXO4E3B/c7
         xjxQ==
X-Gm-Message-State: AOAM531kkDP7OVR79GmVdXJqQIEp//w8RAKqv89bxVPqlJQZ1507jdrS
        S066f+yZnoaFd3F1USA9ymWDaYYdjHgafIYFNe0=
X-Google-Smtp-Source: ABdhPJwa5EvFLFaO06pSdW88HbgR0ovXB8lFFQL3qGJyWdrB6xpLBZQtkIUgotCCsmcC1avkxUUGbwK+HLRCG08EEmI=
X-Received: by 2002:a17:906:974c:: with SMTP id o12mr66264957ejy.229.1638285988926;
 Tue, 30 Nov 2021 07:26:28 -0800 (PST)
MIME-Version: 1.0
References: <20211120071855.GB3874@Peter>
In-Reply-To: <20211120071855.GB3874@Peter>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Tue, 30 Nov 2021 09:26:17 -0600
Message-ID: <CAHrpEqSgGrG9bESUq9TWaeKMujpg5oa4L7+2qOhNu0x-R+vXKQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] usb: cdns3: gadget: fix new urb never complete if ep
 cancel requests before.
To:     Peter Chen <peter.chen@kernel.org>
Cc:     Frank Li <Frank.Li@nxp.com>, pawell@cadence.com,
        linux-usb@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2021 at 1:19 AM Peter Chen <peter.chen@kernel.org> wrote:
>
> Delete '.' please
>
> Reply-To:
> In-Reply-To: <20211117204447.16869-1-Frank.Li@nxp.com>
>
> On 21-11-17 14:44:47, Frank Li wrote:
> > This issue was found at android12 MTP.
> > 1. MTP submit many out urb request.
> > 2. Cancel left requests (>20) when enough data get from host
> > 3. Send ACK by IN endpoint.
> > 4. MTP submit new out urb request.
> > 5. 4's urb never complete.
>
> New out request new complete?


New out request never complete.
>
>
> >
> > TRACE LOG:
> >
> > MtpServer-2157    [000] d..3  1287.150391: cdns3_ep_dequeue: ep1out: req: 00000000299e6836, req buff 000000009df42287, length: 0/16384 zsi, status: -115, trb: [start:87, end:87: virt addr 0x80004000ffd50420], flags:1 SID: 0
> > MtpServer-2157    [000] d..3  1287.150410: cdns3_gadget_giveback: ep1out: req: 00000000299e6836, req buff 000000009df42287, length: 0/16384 zsi, status: -104, trb: [start:87, end:87: virt addr 0x80004000ffd50420], flags:0 SID: 0
> > MtpServer-2157    [000] d..3  1287.150433: cdns3_ep_dequeue: ep1out: req: 0000000080b7bde6, req buff 000000009ed5c556, length: 0/16384 zsi, status: -115, trb: [start:88, end:88: virt addr 0x80004000ffd5042c], flags:1 SID: 0
> > MtpServer-2157    [000] d..3  1287.150446: cdns3_gadget_giveback: ep1out: req: 0000000080b7bde6, req buff 000000009ed5c556, length: 0/16384 zsi, status: -104, trb: [start:88, end:88: virt addr 0x80004000ffd5042c], flags:0 SID: 0
> >       ....
> > MtpServer-2157    [000] d..1  1293.630410: cdns3_alloc_request: ep1out: req: 00000000afbccb7d, req buff 0000000000000000, length: 0/0 zsi, status: 0, trb: [start:0, end:0: virt addr (null)], flags:0 SID: 0
> > MtpServer-2157    [000] d..2  1293.630421: cdns3_ep_queue: ep1out: req: 00000000afbccb7d, req buff 00000000871caf90, length: 0/512 zsi, status: -115, trb: [start:0, end:0: virt addr (null)], flags:0 SID: 0
> > MtpServer-2157    [000] d..2  1293.630445: cdns3_wa1: WA1: ep1out set guard
> > MtpServer-2157    [000] d..2  1293.630450: cdns3_wa1: WA1: ep1out restore cycle bit
> > MtpServer-2157    [000] d..2  1293.630453: cdns3_prepare_trb: ep1out: trb 000000007317b3ee, dma buf: 0xffd5bc00, size: 512, burst: 128 ctrl: 0x00000424 (C=0, T=0, ISP, IOC, Normal) SID:0 LAST_SID:0
> > MtpServer-2157    [000] d..2  1293.630460: cdns3_doorbell_epx: ep1out, ep_trbaddr ffd50414
> >       ....
> > irq/241-5b13000-2154    [000] d..1  1293.680849: cdns3_epx_irq: IRQ for ep1out: 01000408 ISP , ep_traddr: ffd508ac ep_last_sid: 00000000 use_streams: 0
> > irq/241-5b13000-2154    [000] d..1  1293.680858: cdns3_complete_trb: ep1out: trb 0000000021a11b54, dma buf: 0xffd50420, size: 16384, burst: 128 ctrl: 0x00001810 (C=0, T=0, CHAIN, LINK) SID:0 LAST_SID:0
> > irq/241-5b13000-2154    [000] d..1  1293.680865: cdns3_request_handled: Req: 00000000afbccb7d not handled, DMA pos: 185, ep deq: 88, ep enq: 185, start trb: 184, end trb: 184
> >
> > Actually DMA pos already bigger than prevous submit request afbccb7d's TRB (184-184). The reason of (not handled) is that deq position is wrong.
>
> %s/prevous/previous. Ok, so the reason is dep position is wrong, and
> %cdns3_trb_handled returns false, so the completion is not called?


Yes, cdns_trb_handled return false. so the completion is not called.

>
> >
> > The TRB link is below when irq happen.
> >
> >       DEQ LINK LINK LINK LINK LINK .... TRB(afbccb7d):START  DMA(EP_TRADDR).
> >
> > Original code check LINK TRB, but DEQ just move one step.
> >
> >       LINK DEQ LINK LINK LINK LINK .... TRB(afbccb7d):START  DMA(EP_TRADDR).
> >
> > This patch skip all LINK TRB and sync DEQ to trb's start.
> >
> >       LINK LINK LINK LINK LINK .... DEQ = TRB(afbccb7d):START  DMA(EP_TRADDR).
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > Signed-off-by: Jun Li <jun.li@nxp.com>
> > ---
> >  drivers/usb/cdns3/cdns3-gadget.c | 23 ++++++++++++-----------
> >  1 file changed, 12 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> > index 1f3b4a1422126..01d0e09a87ad7 100644
> > --- a/drivers/usb/cdns3/cdns3-gadget.c
> > +++ b/drivers/usb/cdns3/cdns3-gadget.c
> > @@ -337,17 +337,21 @@ static void cdns3_ep_inc_deq(struct cdns3_endpoint *priv_ep)
> >       cdns3_ep_inc_trb(&priv_ep->dequeue, &priv_ep->ccs, priv_ep->num_trbs);
> >  }
> >
> > -static void cdns3_move_deq_to_next_trb(struct cdns3_request *priv_req)
> > +static void cdns3_sync_deq_to_trb(struct cdns3_request *priv_req)
> >  {
> >       struct cdns3_endpoint *priv_ep = priv_req->priv_ep;
> > -     int current_trb = priv_req->start_trb;
> > +     struct cdns3_trb *trb =  priv_ep->trb_pool + priv_ep->dequeue;
> >
> > -     while (current_trb != priv_req->end_trb) {
> > -             cdns3_ep_inc_deq(priv_ep);
> > -             current_trb = priv_ep->dequeue;
> > -     }
> > +     if (TRB_FIELD_TO_TYPE(le32_to_cpu(trb->control)) == TRB_LINK) {
> > +             while (priv_ep->dequeue != priv_req->start_trb) {
> > +                     dev_dbg(priv_ep->cdns3_dev->dev, "Remove TRB_LINK");
> > +                     trb = priv_ep->trb_pool + priv_ep->dequeue;
> > +                     WARN_ON_ONCE(TRB_FIELD_TO_TYPE(le32_to_cpu(trb->control)) != TRB_LINK);
> > +                     trace_cdns3_complete_trb(priv_ep, trb);
> >
> > -     cdns3_ep_inc_deq(priv_ep);
> > +                     cdns3_ep_inc_deq(priv_ep);
> > +             }
> > +     }
> >  }
> >
> >  /**
> > @@ -1518,10 +1522,7 @@ static void cdns3_transfer_completed(struct cdns3_device *priv_dev,
> >               trb = priv_ep->trb_pool + priv_ep->dequeue;
> >
> >               /* Request was dequeued and TRB was changed to TRB_LINK. */
> > -             if (TRB_FIELD_TO_TYPE(le32_to_cpu(trb->control)) == TRB_LINK) {
> > -                     trace_cdns3_complete_trb(priv_ep, trb);
> > -                     cdns3_move_deq_to_next_trb(priv_req);
> > -             }
> > +             cdns3_sync_deq_to_trb(priv_req);
>
> > So, the issue is it doesn't skip all link trb's handler? How about below Change?

Yes, below change can work. let me send v2 patch
>
>
> diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> index 1f3b4a142212..8463e5429cb0 100644
> --- a/drivers/usb/cdns3/cdns3-gadget.c
> +++ b/drivers/usb/cdns3/cdns3-gadget.c
> @@ -337,19 +337,6 @@ static void cdns3_ep_inc_deq(struct cdns3_endpoint *priv_ep)
>         cdns3_ep_inc_trb(&priv_ep->dequeue, &priv_ep->ccs, priv_ep->num_trbs);
>  }
>
> -static void cdns3_move_deq_to_next_trb(struct cdns3_request *priv_req)
> -{
> -       struct cdns3_endpoint *priv_ep = priv_req->priv_ep;
> -       int current_trb = priv_req->start_trb;
> -
> -       while (current_trb != priv_req->end_trb) {
> -               cdns3_ep_inc_deq(priv_ep);
> -               current_trb = priv_ep->dequeue;
> -       }
> -
> -       cdns3_ep_inc_deq(priv_ep);
> -}
> -
>  /**
>   * cdns3_allow_enable_l1 - enable/disable permits to transition to L1.
>   * @priv_dev: Extended gadget object
> @@ -1517,10 +1504,11 @@ static void cdns3_transfer_completed(struct cdns3_device *priv_dev,
>
>                 trb = priv_ep->trb_pool + priv_ep->dequeue;
>
> -               /* Request was dequeued and TRB was changed to TRB_LINK. */
> -               if (TRB_FIELD_TO_TYPE(le32_to_cpu(trb->control)) == TRB_LINK) {
> +               /* The TRB was changed as link TRB, and the request was handled at .ep_deuque */
> +               while (TRB_FIELD_TO_TYPE(le32_to_cpu(trb->control)) == TRB_LINK) {
>                         trace_cdns3_complete_trb(priv_ep, trb);
> -                       cdns3_move_deq_to_next_trb(priv_req);
> +                       cdns3_ep_inc_deq(priv_ep);
> +                       trb = priv_ep->trb_pool + priv_ep->dequeue;
>                 }
>
>                 if (!request->stream_id) {
>
> --
>
> Thanks,
> Peter Chen
>
