Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E764E466F8B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 03:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377988AbhLCCLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 21:11:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:46969 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377980AbhLCCLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 21:11:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638497278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xTEet6pLGYYGny4qkW0aFj01Nakh9JQXlab8tLgNhaw=;
        b=EgwKRP02H1exZVPZMxPAqRIA09jG3fX8UlqCkWh4z5iPjeARETs0JuSktnyRdy9Av2g9qU
        /hzNT0SzNM6Ul6JtibuWAu2lrbrQBfjmnXpkheAtSzOO0j3c3kxQm/kXQ/HoXfwkULZ2s0
        YWhGFH320SxYbgnn7YgKDAZgEw3aX7M=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-229-KKqEfhjpNgmMr-e7eK5E0A-1; Thu, 02 Dec 2021 21:07:55 -0500
X-MC-Unique: KKqEfhjpNgmMr-e7eK5E0A-1
Received: by mail-lj1-f199.google.com with SMTP id r20-20020a2eb894000000b0021a4e932846so601897ljp.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 18:07:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xTEet6pLGYYGny4qkW0aFj01Nakh9JQXlab8tLgNhaw=;
        b=rtir6+YGUuIzibNQ5x+VTdg5FYeIfTwNzy23TL1ZOh+Js8FGP0nXEkF//NxwGifhjk
         quNR5rhvuHmEJ16UR0aRyNWBgfH1ePQGfrYWrBkkv56BpX312rNE1lj4OHetvlKSulLf
         oV9GMw0VD4NOMBQqlLO/qYHMtOF+BRfxwGTDGzD6LzVqi/orRsrnR86q1lt8jY3NTPqN
         T9rChnnic0ZkWiI8SPAwSW/rqP9lHrXclMEnnDIHX5Uthe9S6gGnmfjwkVjcI+AKfXFj
         Kf2Uin29I0QYfDnZqleoy/QebNbqPXC+yoG8aYhDD8Vqb3H3eqV0T+Lk6XmL9UsUJirQ
         1WKg==
X-Gm-Message-State: AOAM533UfSETrSeAFCA8Gm9CZlG8wQnvR5Gl99FVoR8EDptbn6pPAoEe
        46A/KnT0WHb2/fdYGbenO9RYdo/wv3DnkzStae1ExDFDlnS0lv1+dPJep7EBfeXnMpBWnGGEfp9
        Vbd9Zkev6L3Lwnb2HYtTR0wht1b7S2VbMEW4HEImd
X-Received: by 2002:a05:6512:3d09:: with SMTP id d9mr15987273lfv.481.1638497273646;
        Thu, 02 Dec 2021 18:07:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwJRoPd+cWIW68hbj/YiNMRxYyNhn/ZnlOPexARC9hJ5F7TK6WyGKAKRGjhJM+pT5KjTXm/Q7GaYzO+2iabKiY=
X-Received: by 2002:a05:6512:3d09:: with SMTP id d9mr15987247lfv.481.1638497273400;
 Thu, 02 Dec 2021 18:07:53 -0800 (PST)
MIME-Version: 1.0
References: <20211124162045.25983-1-arnaud.pouliquen@foss.st.com>
 <20211124161055-mutt-send-email-mst@kernel.org> <CACGkMEvQoUcPFgOTvEDGkZHMXhjhPrk0xq-Zq3+G20_Lp-hu8A@mail.gmail.com>
 <20211202170011.GA900071@p14s>
In-Reply-To: <20211202170011.GA900071@p14s>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 3 Dec 2021 10:07:42 +0800
Message-ID: <CACGkMEs5DWPT76U8KYdr385e0Y6EUQQRSfRMfR3ZZz34HBdVKA@mail.gmail.com>
Subject: Re: [PATCH v2] rpmsg: virtio: don't let virtio core to validate used length
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 3, 2021 at 1:00 AM Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> Hey guys,
>
> On Thu, Nov 25, 2021 at 10:15:44AM +0800, Jason Wang wrote:
> > On Thu, Nov 25, 2021 at 5:12 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Wed, Nov 24, 2021 at 05:20:45PM +0100, Arnaud Pouliquen wrote:
> > > > Using OpenAMP library on remote side, when the rpmsg framework tries to
> > > > reuse the buffer the following error message is displayed in
> > > > the virtqueue_get_buf_ctx_split function:
> > > > "virtio_rpmsg_bus virtio0: output:used len 28 is larger than in buflen 0"
> > > >
> > > > As described in virtio specification:
> > > > "many drivers ignored the len value, as a result, many devices set len
> > > > incorrectly. Thus, when using the legacy interface, it is generally
> > > > a good idea to ignore the len value in used ring entries if possible."
> > > >
> > > > To stay in compliance with the legacy libraries, this patch prevents the
> > > > virtio core from validating used length.
> > > >
> > > > Fixes: 939779f5152d ("virtio_ring: validate used buffer length")
> > > >
> > > > Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> > > > Cc: Jason Wang <jasowang@redhat.com>
> > > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > >
> > > Arnaud, thanks a lot for the analysis.
> > >
> > > Jason, I think this is another good point. We really should not
> > > validate input for legacy devices at all.
> >
> > I agree. Will do that in the next version.
>
> I'm a little unclear about the "next version" in the above comment - is this
> something I should wait for?  Should I move forward with Arnaud's patch?

Just to make it clear. If my understanding is correct, my series was
reverted so this patch is not needed.

For "next version", I meant I will resend the new version of used
length validation that

- only do the validation when it was explicitly enabled
- warn instead of bug
- do not validate legacy device

Thanks

>
> Thanks,
> Mathieu
>
> >
> > Thanks
> >
> > >
> > >
> > > > Update vs v1[1]: update commit message to clarify the context.
> > > >
> > > > base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
> > > >
> > > > [1]https://lore.kernel.org/lkml/20211122160812.25125-1-arnaud.pouliquen@foss.st.com/T/
> > > > ---
> > > >  drivers/rpmsg/virtio_rpmsg_bus.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> > > > index 9c112aa65040..5f73f19c2c38 100644
> > > > --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> > > > +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> > > > @@ -1054,6 +1054,7 @@ static struct virtio_driver virtio_ipc_driver = {
> > > >       .feature_table_size = ARRAY_SIZE(features),
> > > >       .driver.name    = KBUILD_MODNAME,
> > > >       .driver.owner   = THIS_MODULE,
> > > > +     .suppress_used_validation = true,
> > > >       .id_table       = id_table,
> > > >       .probe          = rpmsg_probe,
> > > >       .remove         = rpmsg_remove,
> > > > --
> > > > 2.17.1
> > >
> >
>

