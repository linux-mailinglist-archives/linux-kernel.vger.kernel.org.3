Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419AD55FBCA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbiF2JXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbiF2JW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:22:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6ECCF38DB6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656494575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3T3KoZe6xrSR0yQtVMqOrhBkODeV64PTbOu8+iOAQkg=;
        b=EuzZvHCXBY5cXZ1wGRlhKcJPVs3kQ2+CNX8pPKY8CLAAWdOVEDx9bI2rRGtVDtH94alTgn
        XqXDjGZoFhdsNBXqe4R2DKpV5LD1yt2Zh4r/+4o3669VzJqEmYvSiRHDHqgz+2m3geUIez
        Z2MykOxEjjyQALdnOM7XgD4kNUT4/+E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-266-YaidL1k6NViBsEEGcV5OhQ-1; Wed, 29 Jun 2022 05:22:53 -0400
X-MC-Unique: YaidL1k6NViBsEEGcV5OhQ-1
Received: by mail-wm1-f69.google.com with SMTP id z11-20020a05600c0a0b00b003a043991610so6076932wmp.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3T3KoZe6xrSR0yQtVMqOrhBkODeV64PTbOu8+iOAQkg=;
        b=k25iy5B5F+lQ8Ld2q7F4OOFa5KPTxvJrA1P3DQZRdSal6TOKB+/bFz4A9+uqTGYHVD
         SE8+vPFTKzGhd5GCuKAOA0y2HA5iSgEIbFJCy1AB2AwSNfFnkIVJ13X4lnrmpkjKH1b3
         u80TZF21BCvufgyGa0L9kUT8Xf3Epbm8snUrlcjEU/TG2dlH1y0mjGdZDN24G/1UL6b/
         5JgRh6dRGKrIKjJEmsxJOnR8WKw8Q55xz6wK4yRBZivpgrGuwgJd7AtiTu9s5CHNjglR
         tr2tRtJh4fluD49Zy89QZ+heja6kesXemvjRLnyc1vyUCjKcL7MGfw2A+waEGvEPWuAH
         Tytg==
X-Gm-Message-State: AJIora+yexd/v6BCbwZA+S2+op/3uHbC5jdMhfLYqkV1N7emEsZT2MEQ
        omytb43lvet+U55kVza2MmQ6jOEnEw5qj5iH6UUT80mbruam9o9KKfGk29fhBFNcTu/mCBArEFi
        aUOs71YlpkZP3TaJGq8vVvaVE
X-Received: by 2002:a05:600c:4fc9:b0:3a0:4d54:b315 with SMTP id o9-20020a05600c4fc900b003a04d54b315mr2464376wmq.62.1656494572274;
        Wed, 29 Jun 2022 02:22:52 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uxC/Xv2PCl30ysM0HmldDOVWW/6SECfAu75JVsX0/hX7re1RKv0XaHkkLAz5M55BrTVL72bw==
X-Received: by 2002:a05:600c:4fc9:b0:3a0:4d54:b315 with SMTP id o9-20020a05600c4fc900b003a04d54b315mr2464356wmq.62.1656494572066;
        Wed, 29 Jun 2022 02:22:52 -0700 (PDT)
Received: from redhat.com ([2.52.23.204])
        by smtp.gmail.com with ESMTPSA id x2-20020a7bc202000000b0039c18d3fe27sm2433190wmi.19.2022.06.29.02.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 02:22:51 -0700 (PDT)
Date:   Wed, 29 Jun 2022 05:22:47 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] vduse: Update api version to 1
Message-ID: <20220629052130-mutt-send-email-mst@kernel.org>
References: <20220629082541.118-1-xieyongji@bytedance.com>
 <20220629082541.118-7-xieyongji@bytedance.com>
 <20220629042856-mutt-send-email-mst@kernel.org>
 <CACycT3sZXwunA_UOCriSv=f2VARMnPb1mNU2GAUd9BLCU-Hg8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACycT3sZXwunA_UOCriSv=f2VARMnPb1mNU2GAUd9BLCU-Hg8w@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 05:02:40PM +0800, Yongji Xie wrote:
> On Wed, Jun 29, 2022 at 4:33 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Jun 29, 2022 at 04:25:41PM +0800, Xie Yongji wrote:
> > > Let's update api version to 1 since we introduced
> > > some new ioctls to support registering userspace
> > > memory for IOTLB.
> > >
> > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> >
> >
> > Adding new ioctls does not justify things like this.
> >
> 
> What I want to do here is make userspace know whether this feature is
> supported or not in the kernel. So do you think we need to add
> something like CHECK_EXTENSION ioctl here?

Why bother? unsupported ioctls just return an error code.

> > Besides, adding UAPI then changing it is not nice
> > since it makes git bisect behave incorrectly.
> >
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 12 ++++++++++++
> > >  include/uapi/linux/vduse.h         |  8 +++++++-
> > >  2 files changed, 19 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > index 7b2ea7612da9..2795785ca6a2 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -1206,6 +1206,10 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> > >       case VDUSE_IOTLB_GET_INFO: {
> > >               struct vduse_iotlb_info iotlb;
> > >
> > > +             ret = -EPERM;
> >
> >
> > Almost for sure a wrong error code.
> >
> > > +             if (dev->api_version < 1)
> > > +                     break;
> > > +
> > >               iotlb.bounce_iova = 0;
> > >               iotlb.bounce_size = dev->domain->bounce_size;
> > >
> >
> >
> > Wait a second. so you are intentionally breaking any userspace
> > that called VDUSE_SET_API_VERSION with version 0?
> >
> > Please don't.
> >
> 
> Yes, I'd like to let userspace know we don't support this feature.
> 
> Thanks.
> Yongji


-- 
MST

