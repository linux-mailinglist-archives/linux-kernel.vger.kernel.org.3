Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E9F5831FA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 20:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbiG0S1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 14:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbiG0S0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 14:26:48 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B567C1AA
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 10:25:33 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 6so16425655pgb.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 10:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aRYTdQvWDpyqVjOPdSP2XFuUk7q1OKCQMMIYuDoZftQ=;
        b=KSaXXjQ9Q8q4nvZ1LIjN7EpcCYubJ7LJrIwUk3QU/TQboe1/7HeUIiNsc19if3vqtw
         koD7jHasRtFOsLVQR02K3vRayC2Fw+xFRjJYSpam4BadS0UgnhI5Q2SrlgVMXNeLPMLJ
         RStWAL+U6gSQKrnoSFlaXHW5yYBb/arVSDyTSje917f/x1TRuRsY1bhOIA4VcIjSPJt7
         t4EBlKW9JxPu5ijsW+gU5Pw/Z7hfD14FBeNO+D2YnKUSs8uPQ/CX5XFqLBalAZOGQKHX
         8AOrhjZsS/oQyKRfWD+6feszwL5qlGvtgcNfdgctRtgAk7si26lhYcxRWwFW4oub67p2
         LZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aRYTdQvWDpyqVjOPdSP2XFuUk7q1OKCQMMIYuDoZftQ=;
        b=f0OTE/URf2RE1nLO629zgCbRgRXZwxOn5xgDYneRLepHpinBy+qQlx9ehJk4bh+oZw
         Z539I8ivL3HSUsHzpvRJl35hTq4XEAlVVC4cCAzEk02s9lzlMq7db2LXAH156DLjx745
         sXusPvfm0hSppDyn0xz4a6Edk4YWqdmo6iNdpwg5h1/a6MYvXe9OkCvbaW/zvuJll9Br
         Ob0GEfyoQRr1949ZgJLRnOT2gyjEXapo96cCJeakJ+nZbmW3g6uJGotOhjSKY2qC136U
         Zp8NBhThdUGiz/ck2dEARWcjVd22kjEZJ0sz/+FPHwdtpomO76ziwH5sgzXJNjSuOD4l
         20Mg==
X-Gm-Message-State: AJIora9bD7Ce2jDCDW/JD31OE0mHSORGSzFHrBRv+rg2DMoOBYqI1TPe
        zulgFt5gUB5KUNmJG8xKpUIakQ==
X-Google-Smtp-Source: AGRyM1tzuzOwE7U0vsXDtxQcHC5dm7uQPwgyJdNsGsv8MqDRGtDk6xzhEPDjc4nscHhJRfRINiw50w==
X-Received: by 2002:a63:ec47:0:b0:419:7e6d:19b5 with SMTP id r7-20020a63ec47000000b004197e6d19b5mr20061555pgj.256.1658942732312;
        Wed, 27 Jul 2022 10:25:32 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id p127-20020a622985000000b00528d3d7194dsm14156981pfp.4.2022.07.27.10.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 10:25:31 -0700 (PDT)
Date:   Wed, 27 Jul 2022 11:25:29 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc:     Chris Lew <quic_clew@quicinc.com>, bjorn.andersson@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Introduction of rpmsg_rx_done
Message-ID: <20220727172529.GD199805@p14s>
References: <1654651005-15475-1-git-send-email-quic_clew@quicinc.com>
 <0eaabd6c-07bd-eb83-da9d-6195b350bc9a@foss.st.com>
 <CANLsYkxBZ+4its5sUPJExnenU8dgttcUwdsBApwC_nYMLmsmHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkxBZ+4its5sUPJExnenU8dgttcUwdsBApwC_nYMLmsmHg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 10:54:30AM -0600, Mathieu Poirier wrote:
> On Mon, 18 Jul 2022 at 02:26, Arnaud POULIQUEN
> <arnaud.pouliquen@foss.st.com> wrote:
> >
> > Hello Chris,
> >
> > On 6/8/22 03:16, Chris Lew wrote:
> > > This series proposes an implementation for the rpmsg framework to do
> > > deferred cleanup of buffers provided in the rx callback. The current
> > > implementation assumes that the client is done with the buffer after
> > > returning from the rx callback.
> > >
> > > In some cases where the data size is large, the client may want to
> > > avoid copying the data in the rx callback for later processing. This
> > > series proposes two new facilities for signaling that they want to
> > > hold on to a buffer after the rx callback.
> > > They are:
> > >  - New API rpmsg_rx_done() to tell the rpmsg framework the client is
> > >    done with the buffer
> > >  - New return codes for the rx callback to signal that the client will
> > >    hold onto a buffer and later call rpmsg_rx_done()
> > >
> > > This series implements the qcom_glink_native backend for these new
> > > facilities.
> >
> > The API you proposed seems to me quite smart and adaptable to the rpmsg
> > virtio backend.
> >
> > My main concern is about the release of the buffer when the endpoint
> > is destroyed.
> >
> > Does the buffer release should be handled by each services or by the
> > core?
> >
> > I wonder if the buffer list could be managed by the core part by adding
> > the list in the rpmsg_endpoint structure. On destroy the core could call
> > the rx_done for each remaining buffers in list...

Arnaud has a valid point, though rpmst_endpoint_ops::destroy_ept() is there for
this kind of cleanup (and this patchet is making use of it).

I think we can leave things as they are now and consider moving to the core if
we see a trend in future submissions.

Thanks,
Mathieu

> >
> > I let Bjorn and Mathieu advise on this...
> 
> Thanks for taking a look Arnaud.  I'll get to this sortly.
> 
> >
> > Thanks,
> > Arnaud
> >
> > >
> > > Chris Lew (4):
> > >   rpmsg: core: Add rx done hooks
> > >   rpmsg: char: Add support to use rpmsg_rx_done
> > >   rpmsg: glink: Try to send rx done in irq
> > >   rpmsg: glink: Add support for rpmsg_rx_done
> > >
> > >  drivers/rpmsg/qcom_glink_native.c | 112 ++++++++++++++++++++++++++++++--------
> > >  drivers/rpmsg/rpmsg_char.c        |  50 ++++++++++++++++-
> > >  drivers/rpmsg/rpmsg_core.c        |  20 +++++++
> > >  drivers/rpmsg/rpmsg_internal.h    |   1 +
> > >  include/linux/rpmsg.h             |  24 ++++++++
> > >  5 files changed, 183 insertions(+), 24 deletions(-)
> > >
