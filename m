Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8744153EC0A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241750AbiFFQU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241688AbiFFQUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:20:55 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831C32B2BAF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 09:20:54 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id q1so29955913ejz.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 09:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=12UkLhNWmn2NlSuxlr6S4i7rRJBFRzlnkvu5nBhtCdk=;
        b=DFflpyIFsZnXHHqmPDg2ed5oqgbXienQBXEPLAaCN/Rw/SD9GDpUQKli40bGJQrMvW
         d+mCUp9VxvOfdf5J0RrlUNq7WdkjaSStwDF4au+pvldwh621urWTtklhLgROAMxL6Zb0
         /12gojX0eluv6wl7sIV3Cb+6xpuA68WDLF4eopEzoDyz1FilA1N40+ZRysXVjgyBZ3my
         ydGPh5FvCWvFpOCLtzcbqk1eabc01zfqE3A8+cy9O7r2XTkvpDje1arAnkuTEpgT1OSO
         yFNMJa5+XiBnHZB/lCCWXGKcmG1hqtTH6eIHfuRHNkrVZDoQFvKPEhqaMSY6JBMtn0pc
         3Hng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=12UkLhNWmn2NlSuxlr6S4i7rRJBFRzlnkvu5nBhtCdk=;
        b=DedX4EGRk6AOnPDxv6maLdp3S6bvM0xDxJBR5/ieLjqQ0wom6UWlv09MPI2KLuiOhY
         wggqiJbyYSqa4y0jLTrpkjmxNn4p6M8P2tHE/NP6k9U4H9VeWNY3RChSB2g+H5oUd5kw
         cagnR/7fTEhkWL0cVSR/Y3pqYYHo/rgbeP79Uns51SrUmJVyTdvwjlrME8E5DmJNR56B
         /w1LvewKgLaMq6TXqXizo4iFswl0WrnEYQM3dfhRNag8xAcbmdLxC0K8SGebOlnJxAvJ
         xfCwlUY10sTIKjqN2eA72Lc89mjeJf06y9l8vpqZ9RnrXXsLKoflWzVjH/6UNO6OF5I3
         wFkA==
X-Gm-Message-State: AOAM532nE6KbeXBA+oCWd39sGOspvfJzjPVhBqak3zJlZDXyZqBLEnIC
        L6ZDWkxmYXgSxxLPYtmHMfsF/Jgags+9xyavI9m2Ww==
X-Google-Smtp-Source: ABdhPJySZx0kslKEfNGrGcdenQ/vGoHfPvIpIIerAHQ96ovYKU6gs5Xm9U68o1ARI3U9vVrPknGE2fegJ/Nwqo5tf6g=
X-Received: by 2002:a17:907:c22:b0:711:dc95:3996 with SMTP id
 ga34-20020a1709070c2200b00711dc953996mr396834ejc.62.1654532453015; Mon, 06
 Jun 2022 09:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220406095446.1187968-1-arnaud.pouliquen@foss.st.com>
 <20220406095446.1187968-3-arnaud.pouliquen@foss.st.com> <20220601174159.GD531268@p14s>
 <b85c7526-80a4-35f2-7629-319d172bc734@foss.st.com>
In-Reply-To: <b85c7526-80a4-35f2-7629-319d172bc734@foss.st.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 6 Jun 2022 10:20:41 -0600
Message-ID: <CANLsYkwsqoKVoYSj7bWxT+t=rMp3dhsrpMYaWm6DhFKHvMSEKw@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

You are correct - I had the name of the variable, i.e rvdev, found in
rproc_handle_vdev() in my head.  You can forget this comment.

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
