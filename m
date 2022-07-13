Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DC85734F0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 13:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbiGMLI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 07:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiGMLIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:08:55 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8852529D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 04:08:54 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id b11so19186503eju.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 04:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lJvpiSOQRpps7ywZWOpMZ0fV9KTgjPhhMacpKKuKlpc=;
        b=gooZU2UNAzr+ekmSNuvUfmAtNk41a5lzyKio83+PtxdQhaDpirWIqI4gKrh6tMdugO
         VDygYM8jm6Ax0w63VXe0VvAn5ff4MvuoNQydY8GBfd6wiUYj9flKTLfhscd39iuP8yvy
         wFcvGQgmMz8uCnFSivzXseEnfxJ4aWw4AlHpWlp54pKUQOiGOzO1yRxB7AS6qbNvVRGp
         wYQtqYmHAPBT4WHKJHud45k/z2tb/ZI6fgmG1pdOnINbHuFvDOfr1k7jYyyeLA9iUUTQ
         gB5Y6cQcjigsTwgAtD+pfOl4xAWh9ufxCwDclsT6fN+IZoLorvzas4hEhGJ+KKe5UYAe
         3Krg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lJvpiSOQRpps7ywZWOpMZ0fV9KTgjPhhMacpKKuKlpc=;
        b=osFxtM1eLc8r6Pw/d62cjYIniouo7NewvLUh4xHjrov0xzaRNuq/K8OlXBXy8o167z
         gmycBwI21kVt6RsQkPmeqJmJcdWU4kx9vrL4gy1bP3XMjSFA43aIKJt3ZujPDU38HjYS
         Q1Oua8Rszep6X5wSzzNCbiSZqh462wz0MZ9ZQ0adDghSJYoAD9MzIM+DxYmSv5Mhe+VI
         NCDjbITJbxzhm+/Le+PRR4nibwpsjd+HTu1XiR7/2EgqLXb4ISUgOJJmEZwc/sWx58GM
         Bcit6Koxi+aq8ShI6qUR7ncMrjP9AiXZlFkHkD8ubouvYF0ZMJpAP7XA2uCQ1ZAgCoPc
         6Z/Q==
X-Gm-Message-State: AJIora+XVWoSvYOTm0eWvQtWOYlwpdLrxSyw1FcUBAkchpluTnuLdo8n
        dfTOqhgqJhTSECNMZnuSOH+S6SfYj0+njA+cwqxi
X-Google-Smtp-Source: AGRyM1tMajvdaUW3g0GchHdyscPm64iC1ebSNxBBjRwvlKSl0dgXAwdIWpiaj+/d3AjQmepPUxddGr9vaz46P5t23Ak=
X-Received: by 2002:a17:906:5055:b0:6ff:1dfb:1e2c with SMTP id
 e21-20020a170906505500b006ff1dfb1e2cmr2977364ejk.200.1657710532643; Wed, 13
 Jul 2022 04:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220706050503.171-1-xieyongji@bytedance.com> <20220706050503.171-2-xieyongji@bytedance.com>
 <1106133f-ebd4-f6a8-83ab-19e995bcdba6@redhat.com>
In-Reply-To: <1106133f-ebd4-f6a8-83ab-19e995bcdba6@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 13 Jul 2022 19:08:42 +0800
Message-ID: <CACycT3sNt_PcPQ__KVSqV6xd=+z5+gbMqWhu6H3vcj_fTGzUsw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] vduse: Remove unnecessary spin lock protection
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        songmuchun@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 1:44 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> =E5=9C=A8 2022/7/6 13:04, Xie Yongji =E5=86=99=E9=81=93:
> > Taking iotlb lock to access bounce page in page fault
> > handler is meaningless since vduse_domain_free_bounce_pages()
> > would only be called during file release.
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> >   drivers/vdpa/vdpa_user/iova_domain.c | 7 ++-----
> >   1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_u=
ser/iova_domain.c
> > index 6daa3978d290..bca1f0b8850c 100644
> > --- a/drivers/vdpa/vdpa_user/iova_domain.c
> > +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> > @@ -211,17 +211,14 @@ static struct page *
> >   vduse_domain_get_bounce_page(struct vduse_iova_domain *domain, u64 io=
va)
> >   {
> >       struct vduse_bounce_map *map;
> > -     struct page *page =3D NULL;
> > +     struct page *page;
> >
> > -     spin_lock(&domain->iotlb_lock);
> >       map =3D &domain->bounce_maps[iova >> PAGE_SHIFT];
> >       if (!map->bounce_page)
> > -             goto out;
> > +             return NULL;
>
>
> Interesting, I wonder why we don't serialize with
> vduse_domain_map_bounce_page() with iotlb_lock?
>

Userspace should only access the bounce page after we set up the dma
mapping, so we don't need serialization from the iotlb_lock in this
case. And vduse_domain_map_bounce_page() only sets the
map->bounce_page rather than clears the map->bounce_page, we would not
have any problem without the lock protection.

Thanks,
Yongji
