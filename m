Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7846A4967CD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 23:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbiAUWZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 17:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiAUWZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 17:25:29 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8FBC06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 14:25:29 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id a21so11684325qkn.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 14:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=XJ462ytAz0hcbce7Qxok4fgHrIR2JOkx/Pcn0NLVtO8=;
        b=Fj7Yxzokng/yswkkT5uo4vHoj0afMUDM+gvIEWqZCvXFLURgWhc6Nb/JoWcjkA6IzU
         PFK/E4rcW0nGuhDgWd5cfUbyRF2GCxXuGxBWUTuREZKLQNbV7UndxAZUI/NW72qu1AN+
         DzOqGAfBevia1lFU3gmeEWf7HOD7iTK04GbmGAuPbS/AcfrzbRRStLkaBBGJnzgRD25x
         oj4+NhdoUJu3umSr2K3in2iezs5QuViw+NHKGu6NLfjlpfu76JsRaLVWa/yVdxxCe+fw
         0xT817/tNp0gqjFppdHtyjdYTDC14e2IGyu6fjr+YbeJETXKI6zeOxHTHOMDjbCYOZ9s
         de/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=XJ462ytAz0hcbce7Qxok4fgHrIR2JOkx/Pcn0NLVtO8=;
        b=qmf2n47bgLRiPzGDpI5Api73sI+yz/RIbCtKSNYmbDU3EggFSgCy2FqT8rCyTR8AM7
         wqbhmhS/7ZdJx0zGHcdP1nYNqFTIc2J3N1z1mcPcJglASHd0EYSBkyrUE8kHi1kacpLD
         jeFG5hC9W6gfVGYIA/Cde7C/jPoRg63Wq1gOZlckwlZO1l7vfSRqNZ7ggQ+KrgFiaR8D
         TKns9kK035NsppwSI6VNqCrFQZ+c7vwzUqNLfcQ2xptKZ3+rwB7Kz7uySG78DqZ6ZNTK
         s/KBd7fsXf/21TCDrfKClFHQ4UMDXr4kung/Rdtjdo4KRmFCujb6XUWrkYZg3KnmKXcw
         fAqg==
X-Gm-Message-State: AOAM531ytZaLoZ0f/BJnlGGPduHPxRMp9aRgCgKtVHb4VF6WkBcO+7Uv
        N18YtLnztp+cf60TvYNt82vO0Q==
X-Google-Smtp-Source: ABdhPJxSEzK+t4hCdg7DJ17MrKCf3E8MKt1dGDp1nyImhqtLw3F/jX6CSb03WZ7u+SPvYZpZVGH0PA==
X-Received: by 2002:a37:de09:: with SMTP id h9mr4245123qkj.764.1642803928183;
        Fri, 21 Jan 2022 14:25:28 -0800 (PST)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id j186sm3620509qkb.57.2022.01.21.14.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 14:25:27 -0800 (PST)
Message-ID: <a90c49239b86d8212045b1f2ef591c4bbf3cb8fd.camel@ndufresne.ca>
Subject: Re: [EXT] Re: [PATCH v8 04/15] media:Add v4l2 event codec_error and
 skip
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ming Qian <ming.qian@nxp.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 21 Jan 2022 17:25:26 -0500
In-Reply-To: <AM6PR04MB63417E126287421BCA133514E7539@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <cover.1631002447.git.ming.qian@nxp.com>
         <647f84c1e7c2a48d6492d38fa4f06586235500b8.1631002447.git.ming.qian@nxp.com>
         <fffd24d3374ecb2fbfafa9b85fa0ef8012fc7efa.camel@ndufresne.ca>
         <AM6PR04MB634124118288EC775F05AFC3E7D59@AM6PR04MB6341.eurprd04.prod.outlook.com>
         <8984f8a3c0dfd3a5f83fb5cc7b0357dca4787274.camel@ndufresne.ca>
         <AM6PR04MB63417E126287421BCA133514E7539@AM6PR04MB6341.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 13 janvier 2022 à 07:18 +0000, Ming Qian a écrit :
> Hi Nicolas,
> 
>    I have question about skip event or similar concepts.
> If the client control the input frame count, and it won't queue any more frames unless some frame is decoded.
> But after seek, There is no requirement to begin queuing coded data starting exactly from a resume point (e.g. SPS or a keyframe). Any queued OUTPUT buffers will be processed and returned to the client until a suitable resume point is found. While looking for a resume point, the decoder should not produce any decoded frames into CAPTURE buffers.
> 
> So client may have queued some frames but without any resume point, in this case the decoder won't produce any decoded frames into CAPTURE buffers, and the client won't queue frames into output buffers. This creates some kind of deadlock.
> 
> In our previous solution, we send skip event to client to tell it that some frame is skipped instead of decoded, then the client can continue to queue frames.
> But the skip event is flawed, so we need some solution to resolve it.
> 1. decoder can produce an empty buffer with V4L2_BUF_FLAG_SKIPPED (or V4L2_BUF_FLAG_ERROR) as you advised, but this seems to conflict with the above description in specification.
> 2. Define a notification mechanism to notify the client
> 
> Can you give some advice?  This constraint of frame depth is common on android

Without going against the spec, you can as of today pop a capture buffer and
mark it done with error. As it has nothing valid in it, I would also set the
payload size to 0.

So I'd say, for every unique input timestamp, that didn't yield a frame
(skipped), pop a capture buffer, copy the timestamp, set the payload size to 0
and set it as done with error.

I'm not sure though if we that we can specify this, as I'm not sure this is
possible with all the existing HW. I must admit, I don't myself had to deal with
that issue as I'm not using a dummy framework. In GStreamer, we take care of
locating the next sync point. So unless there was an error in the framework,
this case does not exist for us.

> 
> Ming
> 
> > > > > +    * - ``V4L2_EVENT_SKIP``
> > > > > +      - 8
> > > > > +      - This event is triggered when one frame is decoded, but it
> > > > > + won't
> > > > > be
> > > > outputed
> > > > > +     to the display. So the application can't get this frame, and
> > > > > + the
> > > > > input
> > > > frame count
> > > > > +     is dismatch with the output frame count. And this evevt is
> > > > > + telling
> > > > > the
> > > > client to
> > > > > +     handle this case.
> > > > 
> > > > Similar to my previous comment, this event is flawed, since
> > > > userspace cannot know were the skip is located in the queued
> > > > buffers. Currently, all decoders are mandated to support
> > > > V4L2_BUF_FLAG_TIMESTAMP_COPY. The timestamp must NOT be
> > interpreted
> > > > by the driver and must be reproduce as-is in the associated CAPTURE
> > > > buffer. It is possible to "garbage" collect skipped frames with this
> > > > method, though tedious.
> > > > 
> > > > An alternative, and I think it would be much nicer then this, would
> > > > be to use the v4l2_buffer.sequence counter, and just make it skip 1
> > > > on skips. Though, the down side is that userspace must also know how
> > > > to reorder frames (a driver job for stateless codecs) in order to
> > > > identify which frame was skipped. So this is perhaps not that
> > > > useful, other then knowing something was skipped in the past.
> > > > 
> > > > A third option would be to introduce V4L2_BUF_FLAG_SKIPPED. This way
> > > > the driver could return an empty payload (bytesused = 0) buffer with
> > > > this flag set, and the proper timestamp properly copied. This would
> > > > let the driver communicate skipped frames in real-time. Note that
> > > > this could break with existing userspace, so it would need to be
> > > > opted-in somehow (a control or some flags).
> > > 
> > > Hi Nicolas,
> > >    The problem we meet is that userspace doesn't care which frame is
> > > skipped, it just need to know that there are a frame is skipped, the
> > > driver should promise the input frame count is equals to the output frame
> > count.
> > >     Your first method is possible in theory, but we find the timestamp
> > > may be unreliable, we meet many timestamp issues that userspace may
> > > enqueue invalid timestamp or repeated timestamp and so on, so we can't
> > accept this solution.
> > 
> > The driver should not interpret the provided timestamp, so it should not be
> > able to say if the timestamp is valid or not, this is not the driver's task.
> > 
> > The driver task is to match the timestamp to the CAPTURE buffer (if that buffer
> > was produced), and reproduce it exactly.
> > 
> > >     I think your second option is better. And there are only 1
> > > question, we find some application prefer to use the V4L2_EVENT_EOS to
> > > check the eos, not checking the empty buffer, if we use this method to
> > > check skipped frame, the
> > 
> > Checking the empty buffer is a legacy method, only available in Samsung MFC
> > driver. The spec says that the last buffer should be flagged with _LAST, and any
> > further attempt to poll should unblock and DQBUF return EPIPE.
> > 
> > > application should check empty buffer instead of V4L2_EVENT_EOS,
> > > otherwise if the last frame is skipped, the application will miss it.
> > > Of course this is not a problem, it just increases the complexity of
> > > the userspace implementation
> > 
> > The EPIPE mechanism covers this issue, which we initially had with the LAST
> > flag.
> > 
> > >     I don't think your third method is feasible, the reasons are as below
> > >               1. usually the empty payload means eos, and as you say,
> > > it may introduce confusion.
> > >       2. The driver may not have the opportunity to return an empty
> > > payload during decoding, in our driver, driver will pass the capture
> > > buffer to firmware, and when some frame is skipped, the firmware won't
> > > return the buffer, driver may not find an available capture buffer to
> > > return to userspace.
> > > 
> > >    The requirement is that userspace need to match the input frame
> > > count and output frame count. It doesn't care which frame is skipped,
> > > so the V4L2_EVENT_SKIP is the easiest way for driver and userspace.
> > >    If you think this event is really inappropriate, I prefer to adopt
> > > your second option
> > 
> > Please, drop SKIP from you driver and this patchset and fix your draining
> > process handling to follow the spec. The Samsung OMX component is
> > irrelevant to mainline submission, the OMX code should be updated to follow
> > the spec.
> > 
> > > 

