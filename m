Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32615787DD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 18:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbiGRQyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 12:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbiGRQyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 12:54:44 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5141056A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 09:54:43 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x91so16180727ede.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 09:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gfpNnbv9YOemTBAvBMvhdh6XDEmFRn+jVc5Sgvldw+c=;
        b=YIUJz0+n5d+MRgeE8Kggy7XaBMiqg9MnEjo0j7YMzPJYtH+Alg1O4ymKE42Z3IKh8q
         CxHTP8fHRuyW1dviJIgkn/4suGtCaaNT3qo/CGesBmoKK3PSiBlk6RHX+n/t+kUoiPoT
         k0G+McbVBQ+YkIJdowKGhQWEFRIb15jfHhgAWgGXCVhS1G3UHIQ1FKnl7kIeBbfnl8+m
         A3K6w2y+CDIvDFweCJJ+9bvBReSF6l/TYXyO2YTlCVXiNKFhO2QQ5k7JhpSnnNChCq0O
         qL7v5XVPRwIu3iiveTk2YtcapolY9zaZDcb/3ocmub/aF/+BYBFSyUHuyL1PsrMFjn3r
         B2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gfpNnbv9YOemTBAvBMvhdh6XDEmFRn+jVc5Sgvldw+c=;
        b=Jb3Qt9N2aDUFakN69desD1Q6tWN2pQRyudbkJYmDf3K9j1yTRF++rO5CeZb2qV2s8J
         TJXtrZIbbelk8bob405VAJ1C8X3MtDC74DCYpXWlvTNLNDM3i+sSfwX3Iw6qfxER5Q/T
         5WU5q8wHV37FfcRmCgMSb5N42NvuN775q8gPL3tAOR38WJFVXLqthODfYBkqDp8cOsXp
         s9cgYZIqAj4XYCD8HzzPNOOxWSbU2BUKBx9azv4wtfW7Lhe1ssBtZPWdgfloc+Kz6SwQ
         Z+466bt+iFVDCh8Q+VbLZDCSt/xWDHQygUddz0SiBbaWZLVDhE1LhJBpmVETNwLgD0Po
         kP/A==
X-Gm-Message-State: AJIora/xVMdqHVmHrhVbQwYRGNaaJro+ZK7ojUoxcsPOuoZ8UvW16dWe
        gwS1R3vGpAW1t1us8Lv1MZK1rtNG5hOojX6MvNN/IQ==
X-Google-Smtp-Source: AGRyM1uuQTfolK7IZXwrLw43B2IEgqnbRr3TMqufL5pVAuJ8GJwGEAlIsCHfQBLshR8K/V80YP6eU5UeCGY9Oho6mXg=
X-Received: by 2002:a05:6402:35cf:b0:43a:d139:ea2b with SMTP id
 z15-20020a05640235cf00b0043ad139ea2bmr38300885edc.415.1658163281692; Mon, 18
 Jul 2022 09:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <1654651005-15475-1-git-send-email-quic_clew@quicinc.com> <0eaabd6c-07bd-eb83-da9d-6195b350bc9a@foss.st.com>
In-Reply-To: <0eaabd6c-07bd-eb83-da9d-6195b350bc9a@foss.st.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 18 Jul 2022 10:54:30 -0600
Message-ID: <CANLsYkxBZ+4its5sUPJExnenU8dgttcUwdsBApwC_nYMLmsmHg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Introduction of rpmsg_rx_done
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc:     Chris Lew <quic_clew@quicinc.com>, bjorn.andersson@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jul 2022 at 02:26, Arnaud POULIQUEN
<arnaud.pouliquen@foss.st.com> wrote:
>
> Hello Chris,
>
> On 6/8/22 03:16, Chris Lew wrote:
> > This series proposes an implementation for the rpmsg framework to do
> > deferred cleanup of buffers provided in the rx callback. The current
> > implementation assumes that the client is done with the buffer after
> > returning from the rx callback.
> >
> > In some cases where the data size is large, the client may want to
> > avoid copying the data in the rx callback for later processing. This
> > series proposes two new facilities for signaling that they want to
> > hold on to a buffer after the rx callback.
> > They are:
> >  - New API rpmsg_rx_done() to tell the rpmsg framework the client is
> >    done with the buffer
> >  - New return codes for the rx callback to signal that the client will
> >    hold onto a buffer and later call rpmsg_rx_done()
> >
> > This series implements the qcom_glink_native backend for these new
> > facilities.
>
> The API you proposed seems to me quite smart and adaptable to the rpmsg
> virtio backend.
>
> My main concern is about the release of the buffer when the endpoint
> is destroyed.
>
> Does the buffer release should be handled by each services or by the
> core?
>
> I wonder if the buffer list could be managed by the core part by adding
> the list in the rpmsg_endpoint structure. On destroy the core could call
> the rx_done for each remaining buffers in list...
>
> I let Bjorn and Mathieu advise on this...

Thanks for taking a look Arnaud.  I'll get to this sortly.

>
> Thanks,
> Arnaud
>
> >
> > Chris Lew (4):
> >   rpmsg: core: Add rx done hooks
> >   rpmsg: char: Add support to use rpmsg_rx_done
> >   rpmsg: glink: Try to send rx done in irq
> >   rpmsg: glink: Add support for rpmsg_rx_done
> >
> >  drivers/rpmsg/qcom_glink_native.c | 112 ++++++++++++++++++++++++++++++--------
> >  drivers/rpmsg/rpmsg_char.c        |  50 ++++++++++++++++-
> >  drivers/rpmsg/rpmsg_core.c        |  20 +++++++
> >  drivers/rpmsg/rpmsg_internal.h    |   1 +
> >  include/linux/rpmsg.h             |  24 ++++++++
> >  5 files changed, 183 insertions(+), 24 deletions(-)
> >
