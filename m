Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B031521DAE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243910AbiEJPNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345532AbiEJPMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:12:23 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3EA5B3D0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 07:46:01 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id w24so12546586edx.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 07:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m3/At7y3DpyH1xn4UVfn5ukqMWdZeC51Z6nb713nrEM=;
        b=fmwv+DkIw7qBc9dQvmK6dD2y9go7fNS8TbsYEOs3Z/4JbUN88xgE0dOxW7G7zdd0aL
         MtXMnd/Quc7Q+xJcY2adZVj6BpixNyMeZ0zWlmwjLzOw+CTiOetT3F5GIQoDgNnH5/FH
         hb90U2G6cv0nTLk7m4OQ5HvqH1rxUybdg3ZbaoyQnZT7Fs8I6DgT/rNyn6wVUJOJ/ijG
         0rqEQOixxhf65y7+OF13MiCIQ3Qpdn9iOpVYKpzuhtEWg1AQyqRTieyGjwF0KUytAOrN
         Nah5IxqwAgCEdSPr4dIVWQxzlUjRd5KSHA/mV+xxpktq9Te0SQqawc5ohTRuQdAXo8XT
         IbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m3/At7y3DpyH1xn4UVfn5ukqMWdZeC51Z6nb713nrEM=;
        b=w3JnKdDh2d7Tl3dut/pW57Jm6T7zhChQ/CKCzCCcpjRzMKxpnaRCy+esrsg95sN4fF
         H0r042Pq/U9YWZ6vkUVO3lCl5hmdMCl/IYTvwsfoPStl0KLAHkkY8xTBHtXgqxBJjAiN
         VM4wys8R8DBqMh5b63HMknsDecixaGHc/j+ONbXmLwmfapDcHulfpC5QCBde1iznBO4S
         fReAj2BMXnCzVSIeiD+ahB19rRcaOek8dE3jjdcVu2GsD+F6fe2BaPCzEfhr2MObaHZa
         OdeoHH39FzEqsg6wwgLZQfga5bfkgwEJX9lYhAesOojqzbKHTmTBsSAkqRWPXzh7EPuu
         i8TA==
X-Gm-Message-State: AOAM532n/u6ZgBalXSLbE02WI/wbXKoFiqaoYoGMo00t/XS2kEaywrHH
        E0+njeqPBKz6R08MSXM3xrCoDKYxYUWbRJftzL4/kw==
X-Google-Smtp-Source: ABdhPJyx8gmtrp9VEPth+GApYG51c0O501gkymHP+UpTVpU/3iDCq4sfkmvUz/9lxc3bdD5ilhpOQLuDyT6XFLRbsmk=
X-Received: by 2002:a05:6402:335:b0:425:e3e0:5a90 with SMTP id
 q21-20020a056402033500b00425e3e05a90mr23350271edw.14.1652193960197; Tue, 10
 May 2022 07:46:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220315153856.3117676-1-arnaud.pouliquen@foss.st.com>
 <20220506171222.GA2816011@p14s> <b7a3db59-201d-a5fb-f416-e1d60d79762f@foss.st.com>
In-Reply-To: <b7a3db59-201d-a5fb-f416-e1d60d79762f@foss.st.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 10 May 2022 08:45:48 -0600
Message-ID: <CANLsYkzEXQbcWBEOecVa2jkJFLY4a_sXm1ig-HA_OMb7u=R7Ww@mail.gmail.com>
Subject: Re: [PATCH] rpmsg: virtio: set dst address on first message received
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 May 2022 at 03:18, Arnaud POULIQUEN
<arnaud.pouliquen@foss.st.com> wrote:
>
> Hello Mathieu,
>
> On 5/6/22 19:12, Mathieu Poirier wrote:
> > On Tue, Mar 15, 2022 at 04:38:56PM +0100, Arnaud Pouliquen wrote:
> >> when a rpmsg channel has been locally created with a destination address
> >
> > s/when/Wen
> >
> > Also, please be more specific about the "locally created" part, i.e
> > rpmsg_ctrldev_ioctl() -> rpmsg_create_channel().  Otherwise it is really hard to
> > understand the context of this change.
> >
> >> set to RPMSG_ADDR_ANY, a name service announcement message is sent to
> >> the remote side. Then the destination address is never updated, making it
> >> impossible to send messages to the remote.
> >>
> >> An example of kernel trace observed:
> >> rpmsg_tty virtio0.rpmsg-tty.29.-1: invalid addr (src 0x1d, dst 0xffffffff)
> >>
> >> Implement same strategy than the open-amp library:
> >> On the reception of the first message, if the destination address is
> >> RPMSG_ADDR_ANY, then set it to address of the remote endpoint that
> >> send the message.
> >>
> >
> > I would have expected a "Fixes:" tag.
>
> Difficult to give a reference. For me the issue exists since the creation
> of the rpmsg virtio bus. A driver can create a channel that generates a NS
> announcement leading to this issue.
> The issue as been highlighted by the creation of the  RPMSG_CREATE_DEV_IOCTL
> control.
>

Ok

> >
> >> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> >>
> >> ---
> >> Remark:
> >> An alternative (or a complement?) could be to add a NS bind/unbind in
> >> the NS announcement channel (in rpmsg_ns.c).
> >> This would allow the local and/or the remote processor to inform the
> >> remote side the the service announced in bound.
> >> ---
> >>  drivers/rpmsg/virtio_rpmsg_bus.c | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> >> index 3ede25b1f2e4..99d2119cc164 100644
> >> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> >> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> >> @@ -708,6 +708,7 @@ static ssize_t virtio_rpmsg_get_mtu(struct rpmsg_endpoint *ept)
> >>  static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
> >>                           struct rpmsg_hdr *msg, unsigned int len)
> >>  {
> >> +    struct rpmsg_device *rpdev;
> >>      struct rpmsg_endpoint *ept;
> >>      struct scatterlist sg;
> >>      bool little_endian = virtio_is_little_endian(vrp->vdev);
> >> @@ -746,6 +747,15 @@ static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
> >>      mutex_unlock(&vrp->endpoints_lock);
> >>
> >>      if (ept) {
> >> +            rpdev = ept->rpdev;
> >> +            if (rpdev->ept == ept && rpdev->dst == RPMSG_ADDR_ANY) {
> >
> > Please add a comment to explain the first part of the if() clause.  It took me
> > quite some time to understand.
> >
> >> +                    /*
> >> +                     * First message received from the remote side on the default endpoint,
> >> +                     * update channel destination address.
> >> +                     */
> >> +                    rpdev->dst = msg->src;
> >
> > This triggers a bot warning and should be addressed.  If it can't be addressed add
> > a comment that clearly explains why so that we don't end up receiving patches
> > for it every 4 weeks.
>
> Oops, I missed it, thanks for pointing it out.
>
>
> Concerning the patch itself as discussed in RP open-amp meeting. I wonder if this issue
> could be addressed by the flow control[1][2][3], or if needed in any case.
>
> I propose to send a V2 when ready to propose in parallel the flow control.
> So both can be addressed at same time to have a global picture of the way to address the
> use case..
>

It will be one or the other, we can't have two ways to do things.  If
the flow control patchset addresses this problem on top of adding more
functionality then we should go with that one.

> Thanks,
> Arnaud
>
> [1] POC Linux code:
> https://github.com/arnopo/linux/commits/signalling
>
> [2] openamp library associated code:
> https://github.com/arnopo/open-amp/commits/flow_ctrl
>
> [3] overview presentation
> https://drive.google.com/file/d/1CLU3ybI3oSBGvor18AQ-HOzOJ2nOppEb/view
>
>
> >
> > Thanks,
> > Mathieu
> >
> >> +            }
> >> +
> >>              /* make sure ept->cb doesn't go away while we use it */
> >>              mutex_lock(&ept->cb_lock);
> >>
> >> --
> >> 2.25.1
> >>
