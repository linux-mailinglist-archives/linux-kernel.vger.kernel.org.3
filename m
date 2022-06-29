Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F7155FB40
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbiF2JCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbiF2JCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:02:54 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C1D2495E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:02:52 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id q6so31119325eji.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Aq4Lez9gHkzqnABxRDZ1hLRlEetQwaEfg0dHsywi6sM=;
        b=D+A0Z0nfwwfGtZx8tGcm4/WBeNfHt+7zWYMMTBHGJOzj4TRfGjsZEYOVY/8vn3Vz3o
         jA91WRgZKrXmVgySplb4YQQZX1ijQVkSUMWqbT0cFh+CnR7BXs0c80BpfpJBrwu7NfJs
         AtYFV3R8LNfgszGtTeMNR9kEoWQR1vqIJ1OFryRzYOmPvom+jm5wR3NN7Wx1UCyjEMvN
         lgH2U9xt81Y2VOxmJS3lPNcQuzysBGAmlOGOQpA8VdvSuWOr8Rg8pbEzsOA1M1yUw9Y/
         s1bV1sHele3XtGhcxTG7oG7SBUlPHqL/5krz67DSWrN20aCw2zQXaZPDd9qYCvWV9PP7
         i8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Aq4Lez9gHkzqnABxRDZ1hLRlEetQwaEfg0dHsywi6sM=;
        b=i05zWDONVcBrKZky1fuPxwn5EjECu90y+G0+sOLjNQfSkwcp8asoSZQyYXyhKeKjm7
         RVxV8NJDA1RGNqR6/LTvYIyZZUhpYL0seX67CN13TOMcbSOSI6or9i5aFmelhkNu6kJu
         3XszdZ3LE6ceGWhF5hHm16S8YmIKlr/mIwGJQrbnoZaIiqf6tme0CHEH1KHEp9hNf3zq
         AMy0c5bgNyEcq5mBq9EYHtftjXFFd5FoTxGDg+sWysPUPI88MdrNeuLojpVcTT43+L1q
         Y3NftZSDh9PE6k65do5BOdwbLggH3FF3zPtTrYEEUdClQnAf+/e6NlD34mVTq/t93BUN
         5gzw==
X-Gm-Message-State: AJIora8uoN6aj872cqk/efZEalLfaKNzgJm6u+EF610fYgo1cUoaKOOL
        LWqmt2kjUAeAYwW0PllO0zSF51tHTISG6WMOrl/8
X-Google-Smtp-Source: AGRyM1tBM1Cm/zj9t76+7Ewc+H/GPmxCAp+QVifCtXfA13Wy//rUlqSwojyFJtOnm0XtKcgoxbWXA/AnhlE9HWYrFPY=
X-Received: by 2002:a17:907:6e03:b0:726:a6a3:7515 with SMTP id
 sd3-20020a1709076e0300b00726a6a37515mr2273389ejc.676.1656493370536; Wed, 29
 Jun 2022 02:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220629082541.118-1-xieyongji@bytedance.com> <20220629082541.118-7-xieyongji@bytedance.com>
 <20220629042856-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220629042856-mutt-send-email-mst@kernel.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 29 Jun 2022 17:02:40 +0800
Message-ID: <CACycT3sZXwunA_UOCriSv=f2VARMnPb1mNU2GAUd9BLCU-Hg8w@mail.gmail.com>
Subject: Re: [PATCH 6/6] vduse: Update api version to 1
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 4:33 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Jun 29, 2022 at 04:25:41PM +0800, Xie Yongji wrote:
> > Let's update api version to 1 since we introduced
> > some new ioctls to support registering userspace
> > memory for IOTLB.
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>
>
> Adding new ioctls does not justify things like this.
>

What I want to do here is make userspace know whether this feature is
supported or not in the kernel. So do you think we need to add
something like CHECK_EXTENSION ioctl here?

> Besides, adding UAPI then changing it is not nice
> since it makes git bisect behave incorrectly.
>
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 12 ++++++++++++
> >  include/uapi/linux/vduse.h         |  8 +++++++-
> >  2 files changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > index 7b2ea7612da9..2795785ca6a2 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -1206,6 +1206,10 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> >       case VDUSE_IOTLB_GET_INFO: {
> >               struct vduse_iotlb_info iotlb;
> >
> > +             ret = -EPERM;
>
>
> Almost for sure a wrong error code.
>
> > +             if (dev->api_version < 1)
> > +                     break;
> > +
> >               iotlb.bounce_iova = 0;
> >               iotlb.bounce_size = dev->domain->bounce_size;
> >
>
>
> Wait a second. so you are intentionally breaking any userspace
> that called VDUSE_SET_API_VERSION with version 0?
>
> Please don't.
>

Yes, I'd like to let userspace know we don't support this feature.

Thanks.
Yongji
