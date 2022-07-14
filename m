Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309F357416D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 04:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiGNC1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 22:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiGNC1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 22:27:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDD9620BEB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 19:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657765658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DKqtVQoelkyekmm3n/TzJpiFYoNhlddM3fmt1VyGkDE=;
        b=BgCF7KLdy5UbAuxoSgBqNsFoqdMZvpv67+2nFwsrheJRnKANbxwymoa8WUdFSXbaIaoJ7q
        aNrmkHdt8FoBahIvOM/FXJ0aYICHSG1W8n6DqOftwJH1XnSWSCuUyOCT5+XmM2xjIfLM7+
        2zn9jSpp3TVvZdZkeshZYrYzq1NmrMo=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-E2EyB-OcMGiMxgpQXmjvVA-1; Wed, 13 Jul 2022 22:27:36 -0400
X-MC-Unique: E2EyB-OcMGiMxgpQXmjvVA-1
Received: by mail-lf1-f69.google.com with SMTP id d12-20020a056512368c00b00489f92be8c4so193901lfs.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 19:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DKqtVQoelkyekmm3n/TzJpiFYoNhlddM3fmt1VyGkDE=;
        b=dGpV8PCiXPIzsJFo6OoW82sjuMnFZOIIc2x21bZZTdLU00fHiUsyObkR4CKcvgeUq7
         ruBZ4dLzAzq8Nh/oqS2z+SiibgezwQ6F7M/FL9sk8BsAcVH87ScakndRhp8dxWG5NFF9
         +ZiV0D8xhBxxYcUcDmhIaA3WiF6mKSyxkhj4ktO5F87guUlDduJqqqSJ1G6zvj4jc7rJ
         s0wfcq5gCln4bBz2Q1dUQbZDAp0im/GBXur4AqWrRj3KGzP6gWcbFD8QC2XiikQ8PHnP
         HVsQVDqsL52fzMmws6WSMoW1++4aVLfa6UcSg3FswxJBQxErSSZY9zqQXKnracTJeDx0
         12Uw==
X-Gm-Message-State: AJIora9IfcChVIR6FmzP29Ag3WwJPUhaBnkAXAcg6Kbtjy9+c+vPhcG8
        MZsSDO1Ct3S8gn6Ym0tAsspQHnHPXsGXiO2qEmsL/tdAexNzGqb6CU1DpLQMgRyvqEueD6ZJL80
        gogoflBEU4by1fr+X3npwsmi7PRSHI0XYAAUkb8pJ
X-Received: by 2002:a05:6512:313a:b0:489:caea:7e27 with SMTP id p26-20020a056512313a00b00489caea7e27mr3925201lfd.397.1657765655205;
        Wed, 13 Jul 2022 19:27:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sm+WAiUx+ESlDemm3AD5k1QLfG2dAptqNFigTGtYGMDx63OJNqx3GB1rUNc0SY46t+RFz+/8OEIy5PHUQQUvA=
X-Received: by 2002:a05:6512:313a:b0:489:caea:7e27 with SMTP id
 p26-20020a056512313a00b00489caea7e27mr3925190lfd.397.1657765655011; Wed, 13
 Jul 2022 19:27:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220706050503.171-1-xieyongji@bytedance.com> <20220706050503.171-2-xieyongji@bytedance.com>
 <1106133f-ebd4-f6a8-83ab-19e995bcdba6@redhat.com> <CACycT3sNt_PcPQ__KVSqV6xd=+z5+gbMqWhu6H3vcj_fTGzUsw@mail.gmail.com>
In-Reply-To: <CACycT3sNt_PcPQ__KVSqV6xd=+z5+gbMqWhu6H3vcj_fTGzUsw@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 14 Jul 2022 10:27:23 +0800
Message-ID: <CACGkMEsOXyewVZ76Cc4BoZv1vhXbT1t8tm-9GqV9CJ70bF-xwg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] vduse: Remove unnecessary spin lock protection
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        songmuchun@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 7:09 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Wed, Jul 13, 2022 at 1:44 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> >
> > =E5=9C=A8 2022/7/6 13:04, Xie Yongji =E5=86=99=E9=81=93:
> > > Taking iotlb lock to access bounce page in page fault
> > > handler is meaningless since vduse_domain_free_bounce_pages()
> > > would only be called during file release.
> > >
> > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > ---
> > >   drivers/vdpa/vdpa_user/iova_domain.c | 7 ++-----
> > >   1 file changed, 2 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa=
_user/iova_domain.c
> > > index 6daa3978d290..bca1f0b8850c 100644
> > > --- a/drivers/vdpa/vdpa_user/iova_domain.c
> > > +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> > > @@ -211,17 +211,14 @@ static struct page *
> > >   vduse_domain_get_bounce_page(struct vduse_iova_domain *domain, u64 =
iova)
> > >   {
> > >       struct vduse_bounce_map *map;
> > > -     struct page *page =3D NULL;
> > > +     struct page *page;
> > >
> > > -     spin_lock(&domain->iotlb_lock);
> > >       map =3D &domain->bounce_maps[iova >> PAGE_SHIFT];
> > >       if (!map->bounce_page)
> > > -             goto out;
> > > +             return NULL;
> >
> >
> > Interesting, I wonder why we don't serialize with
> > vduse_domain_map_bounce_page() with iotlb_lock?
> >
>
> Userspace should only access the bounce page after we set up the dma
> mapping, so we don't need serialization from the iotlb_lock in this
> case.

What about the buggy/malicious user space that tries to access those
pages before or just in the middle of it has been mapped?

> And vduse_domain_map_bounce_page() only sets the
> map->bounce_page rather than clears the map->bounce_page, we would not
> have any problem without the lock protection.

Probably, I see an assignment of orig_phys after the alloc_page() but
it seems only used in bouncing which will only be called by dma ops.
At least we'd better have a comment to explain the synchronization
here.

Thanks

>
> Thanks,
> Yongji
>

