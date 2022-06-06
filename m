Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308C753EC95
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240976AbiFFPr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241174AbiFFPru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:47:50 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA2D8DDE1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:47:48 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id er5so19373663edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 08:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jLpWvMlf+YUwu7qBpzspLbufy8yyDTs9EuJTxwHjhIs=;
        b=sAgL1HX3YrPvng7nckLZkM6PqZZq8RKPIRXtt7wwM4al/LJSnm1WAVNBbbzeQh4R2H
         Jq7/nQtKQuCFpgc0sv062DxA8dvn2F/t4f5EYYVz81sdhSFtwHdehGNkLnvoab3T1fwP
         YZSY2QPUMi83ez2/lssfP34+EvEtX5nx65of/XBbu3YJIBp4+O35V5RUeroJr0wl7/bS
         BTqZbvIrwzkeuYlBV0ekUNJg7WpdLF55ymyo794mVag6VrVpqKYFhUklQ17gZT+mipiB
         Z6xXhQoEDesesVKLQbxfUsgj0TSrARi9FwRMZDSczxSXkNoyBcUGA27qutTVyGgvlpyH
         riCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jLpWvMlf+YUwu7qBpzspLbufy8yyDTs9EuJTxwHjhIs=;
        b=h9waLCAo4mBgWqBfkkx3XrK0QTYvm57Xdm5u0upY18BWNUO/LvAO16c1LTxZzhXIgt
         bEhE0as0oN7fmVVu04zVt1GIQ8PX6ouwJDIutU3MOqYBD2T7prMAxHux3x6XXhi9BK0g
         xopTulknmuM1e8x+tuSvAd3kqYpfopSu9sOx9oSNIwGTU87NXNNJc3et8x64GCq/Ionu
         ej4Q9FNNxRllVuqX4fx1pfOtqZaymR8UNhYdCvs8Vo2Dx1lW6SyEqnKZ+kOH1xSQecbH
         Pa/ZgYxYefo0SdLF+jTuoXxD6m7pBVKJX9SnEbwh1GQG53ak1DBZaq/glT0Fq1U9UQYm
         DXsA==
X-Gm-Message-State: AOAM5305kJ8XL8X4jzOWOd79IPtDFnVL1S+J9rJDm4iQw2WS8IGVGR59
        Nc4yupbW5AeTg4ClxIu9CIUzQ1tW1tupn6kZ8zATNg==
X-Google-Smtp-Source: ABdhPJziEwq+2TK54NAomosbKFoIgCbxKZ0vpPY7wD/35TTSTUyrCW2Y4sC6CD4fFotGJU9nupk9KF/eT9WvZshZfmE=
X-Received: by 2002:a05:6402:274a:b0:42d:dcd1:c847 with SMTP id
 z10-20020a056402274a00b0042ddcd1c847mr27773129edd.169.1654530466868; Mon, 06
 Jun 2022 08:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220406095446.1187968-1-arnaud.pouliquen@foss.st.com>
 <20220406095446.1187968-3-arnaud.pouliquen@foss.st.com> <20220601174159.GD531268@p14s>
 <b85c7526-80a4-35f2-7629-319d172bc734@foss.st.com>
In-Reply-To: <b85c7526-80a4-35f2-7629-319d172bc734@foss.st.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 6 Jun 2022 09:47:35 -0600
Message-ID: <CANLsYkzcgC3+pWSzyRKaRQuWEp=m_tML5W9hc1+fR9CLgMYHSQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5 2/4] remoteproc: core: Introduce
 rproc_register_rvdev function
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Bruce Ashfield <bruce.ashfield@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jun 2022 at 05:54, Arnaud POULIQUEN
<arnaud.pouliquen@foss.st.com> wrote:
>
> Hello Mathieu,
>
> On 6/1/22 19:41, Mathieu Poirier wrote:
> > On Wed, Apr 06, 2022 at 11:54:44AM +0200, Arnaud Pouliquen wrote:
> >> The rproc structure contains a list of registered rproc_vdev structure.
> >
> > This should be rproc_rvdev.
>
> Thanks for your review!
>
> I will send a new version according to your comments except
> this one.
> The structure name rproc_vdev is the good one, or
> or maybe I'm missing something?
>

Structure rproc does not contain a list of rproc_vdev, it contains a
list of rproc_rvdev in rproc::rvdevs.

> Thanks,
> Arnaud
>
> >
> >> To be able to move the management of the rproc_vdev structure in
> >> remoteproc_virtio.c (i.e rproc_rvdev_add_device and
> >> rproc_rvdev_remove_device functions), introduce the rproc_register_rvdev
> >> and rproc_unregister_rvdev functions.
> >
> > The name of those functions doesn't match the content of the patch.
> >
> >>
> >> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> >> ---
> >>  drivers/remoteproc/remoteproc_core.c | 16 ++++++++++++++--
> >>  1 file changed, 14 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> >> index 3a469220ac73..081bea39daf4 100644
> >> --- a/drivers/remoteproc/remoteproc_core.c
> >> +++ b/drivers/remoteproc/remoteproc_core.c
> >> @@ -484,6 +484,18 @@ static int copy_dma_range_map(struct device *to, struct device *from)
> >>      return 0;
> >>  }
> >>
> >> +static void rproc_add_rvdev(struct rproc *rproc, struct rproc_vdev *rvdev)
> >> +{
> >> +    if (rvdev && rproc)
> >> +            list_add_tail(&rvdev->node, &rproc->rvdevs);
> >> +}
> >> +
> >> +static void rproc_remove_rvdev(struct rproc_vdev *rvdev)
> >> +{
> >> +    if (rvdev)
> >> +            list_del(&rvdev->node);
> >> +}
> >> +
> >>  static struct rproc_vdev *
> >>  rproc_rvdev_add_device(struct rproc *rproc, struct rproc_vdev_data *rvdev_data)
> >>  {
> >> @@ -547,7 +559,7 @@ rproc_rvdev_add_device(struct rproc *rproc, struct rproc_vdev_data *rvdev_data)
> >>                      goto unwind_vring_allocations;
> >>      }
> >>
> >> -    list_add_tail(&rvdev->node, &rproc->rvdevs);
> >> +    rproc_add_rvdev(rproc, rvdev);
> >>
> >>      rvdev->subdev.start = rproc_vdev_do_start;
> >>      rvdev->subdev.stop = rproc_vdev_do_stop;
> >> @@ -576,7 +588,7 @@ static void rproc_rvdev_remove_device(struct rproc_vdev *rvdev)
> >>      }
> >>
> >>      rproc_remove_subdev(rproc, &rvdev->subdev);
> >> -    list_del(&rvdev->node);
> >> +    rproc_remove_rvdev(rvdev);
> >
> > With the above:
> >
> > Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> >
> >>      device_unregister(&rvdev->dev);
> >>  }
> >>
> >> --
> >> 2.25.1
> >>
