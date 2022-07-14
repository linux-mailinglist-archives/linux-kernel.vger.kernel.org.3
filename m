Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0F35744B8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 07:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbiGNF7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 01:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiGNF7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 01:59:06 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64859DEF6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 22:59:04 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id t3so1108638edd.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 22:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+sXM3m04HgUCYw+v/+NTie1QGsvj01TURanyfbem+gI=;
        b=wkLDWLe5OFnjq+5nnvKBxK0gZyh7hMUxl+0P8iVOLrg1JNJozvNJN6HvvWO6ldz6FX
         BOYHxQGAZuaygAqx6NSIUJ+yL9MWpyyGOUiIFnojhZiA7UrzociuiouMSp51bKzl2fvg
         XFhH51p2kLv2HWdkO5FPciLi0I+k93q2qEGcK4SqTsOw5e1VVifUcOsNOjZpY3vE4iy/
         EWYElF7jvyvu9WwlpIG4gd40n6ZrHtoSEemfdAHtND/R9gtFooYV/OFgFHCQAuwp3Ujj
         d4GTFsFnbcLTlpzCLYrzocaYN0lgoyz0Szhrwuv+MFMc00bLsP1lUV8PMTyI3GKmSfqu
         zLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+sXM3m04HgUCYw+v/+NTie1QGsvj01TURanyfbem+gI=;
        b=MdPTXjFoB4Xjbh4aXfmda7TJ6x0ft4pxgPZNSce2Y2tYMHGENjRWv4Y83NedqeT2n1
         xmQGR7r4+qEUZIbGocLADYBgduxHrI+eesPSC5yQ6nfi2Cft7gieh/lJT1xPJGZH9ijA
         3+Lh74i7SjGjxo0csR29kjbwaIpTtehNtH/9YRbjj6totLo2fJ/6qzuk9ztpA1NQaG6i
         p1pY/umTnZFgX9LOPZgDO508PDMB1T0RhDALq+YSgnsqb20+/GqEILHCHxa3lsN1IpeB
         q34kFp6F37acFSMZWQ+tM0/EdXvmCp9b0dFWVvR1w2MbnxZQIMA9PUjJoQHbeWkZnNqp
         iRJQ==
X-Gm-Message-State: AJIora/qRSJ3ZRBFO7d6VhAkmZoexmGso9StfMf6CElXUyJWfxCZZvEp
        0hiW67pVolSXikwAMl6lGnJT01oxPldfywrOlpib
X-Google-Smtp-Source: AGRyM1sjmbqQGSDaxiYY23ePP7UWuLGRdwT7YhPfRwvG8MIzR48DeXMfKUKdMLYEJL+la1o+1n/O3x/x3g7y6Bas+eQ=
X-Received: by 2002:a05:6402:240a:b0:437:d2b6:3dde with SMTP id
 t10-20020a056402240a00b00437d2b63ddemr10217227eda.62.1657778342993; Wed, 13
 Jul 2022 22:59:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220706050503.171-1-xieyongji@bytedance.com> <20220706050503.171-5-xieyongji@bytedance.com>
 <CACGkMEv9s2WP+Ou5wk2GCBXfD+Pc8CDY2Kz41w7sO8bnkVTc7w@mail.gmail.com>
In-Reply-To: <CACGkMEv9s2WP+Ou5wk2GCBXfD+Pc8CDY2Kz41w7sO8bnkVTc7w@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Thu, 14 Jul 2022 13:58:52 +0800
Message-ID: <CACycT3sUprAUDobiQH61ThJ+tYtjQ1rgZa143f-sjKv_bC9x1A@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] vduse: Support querying IOLTB information
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst <mst@redhat.com>, Liu Xiaodong <xiaodong.liu@intel.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        songmuchun@bytedance.com,
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

On Thu, Jul 14, 2022 at 10:51 AM Jason Wang <jasowang@redhat.com> wrote:
>
> On Wed, Jul 6, 2022 at 1:06 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> >
> > This introduces a new ioctl: VDUSE_IOTLB_GET_INFO to
> > support querying IOLTB information such as bounce
> > buffer size.
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 13 +++++++++++++
> >  include/uapi/linux/vduse.h         | 17 +++++++++++++++++
> >  2 files changed, 30 insertions(+)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > index 3bc27de58f46..c47a5d9765cf 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -1089,6 +1089,19 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> >                 ret = vduse_dev_queue_irq_work(dev, &dev->vqs[index].inject);
> >                 break;
> >         }
> > +       case VDUSE_IOTLB_GET_INFO: {
>
> As discussed, it's better not to expose the VDUSE internal structure
> like "IOTLB" in the name.
>
> We probably need to extend GET_FD or have a new ioctl like GET_FD_INFO.
>

OK, will do it in v3.

Thanks,
Yongji
