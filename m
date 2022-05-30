Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B774A5373C9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 05:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbiE3Dsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 23:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiE3DsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 23:48:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20EB5719FA
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 20:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653882503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FmGS+JorM6DychXTopYG3ZDAjK7UxTCFM8Tie0jNFQA=;
        b=coLTib89G0z2U2YcThCUnhrH6CeKyjEYS/Ly7BNhazaEV+oC2AE5oYcwOVAme/oG/iSZ9k
        TPiWaNoP1R0rvYLWMP55937vw0ojxlZjQpcMb83tq++BalZSwLKrhcNKbeMpimPQX99wzM
        6ha/8a1i/9ouvqGuuK5BTyw4oe+R9bI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-T0h_jfJuNcyCbZWiRvKajA-1; Sun, 29 May 2022 23:48:21 -0400
X-MC-Unique: T0h_jfJuNcyCbZWiRvKajA-1
Received: by mail-lf1-f71.google.com with SMTP id bi27-20020a0565120e9b00b004786caccc7dso4642735lfb.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 20:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FmGS+JorM6DychXTopYG3ZDAjK7UxTCFM8Tie0jNFQA=;
        b=DghKjBq0P3Q3My5ytbCD6o32vnteTGvt7ArEQQTA3Wi7tr7gCV4pQZmFmESUUAx5uk
         kyuf0IrkLb45vbq+4T+gw5i8fSVzzDJgyOytpXBEaD/KDekD1mdUJjLwUG2PxYnAIJQg
         XtocqXuwtefJiFraHyT70ED8oGBGHS1rKvuYJUcI58luO5mTD+hE1idDKvD+clxkvSya
         jEW2jyyHzQIvV2Y0khqeq+j9SWQCWDoq8rphXjT4R/IpEQ+EEcBKBQgHswh+T4IYZh5F
         mII4JkAvoQeJw00TW+PvB+5yELDeQ+9DXa/N/RHyEcXF572AU/y4nue2dXokucXDOG6w
         YGvA==
X-Gm-Message-State: AOAM530pgJGm4jFG4a5+wezSIMb08n9k+iVc+kMf3FBK91E6gSVzdX64
        3eY6AA/qvYVkax9oY0O8+B6t1Fy5XZVdP1z1rdjNkdfv27joiLzz7BU72syh3RmicBlq/WDW1DK
        /AzRN/V7Ap9TIYG4v7zytM+rcE1odtdDvcv/yDUgI
X-Received: by 2002:a2e:bc05:0:b0:24b:212d:7521 with SMTP id b5-20020a2ebc05000000b0024b212d7521mr30777798ljf.243.1653882500083;
        Sun, 29 May 2022 20:48:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybmkowLkDNeOswXv7BzZ6+71C1oQB0CScKxGz3UP85HZsXfBflYJu2iC9B1ybQW9EKdBuBcy9WDtQBSdSav6s=
X-Received: by 2002:a2e:bc05:0:b0:24b:212d:7521 with SMTP id
 b5-20020a2ebc05000000b0024b212d7521mr30777785ljf.243.1653882499911; Sun, 29
 May 2022 20:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220527060120.20964-1-jasowang@redhat.com> <20220527060120.20964-10-jasowang@redhat.com>
 <20220527064118-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220527064118-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 30 May 2022 11:48:08 +0800
Message-ID: <CACGkMEvoFapNoqsqq59iH+z_qx1swecjnbbPs7=nN4bn6XdbtA@mail.gmail.com>
Subject: Re: [PATCH V6 9/9] virtio: use WARN_ON() to warning illegal status value
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 6:50 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> At a minimum, I don't see why it's part of the series. Host can always
> crash the guest if it wants to ...

Probably not with some recent technology. In those cases, a fault will
be generated if the hypervisor tries to access the memory that is
private to the guest.

> The point of BUG_ON is device or driver is already corrupted so we
> should not try to drive it.  If you still want this in pls come up with
> a better commit log explaining the why.

A question here, should we always use BUG_ON for the buggy/malicious hypervisor?

The interrupt hardening logic in this series tries to make guest
survive, so did this patch.

>
> On Fri, May 27, 2022 at 02:01:20PM +0800, Jason Wang wrote:
> > We used to use BUG_ON() in virtio_device_ready() to detect illegal
>
> not really, BUG_ON just crashes the kernel.  we detect by checking
> status.

We need a kind of notification otherwise there's no way for the user
to know about this expected value.

>
> > status value, this seems sub-optimal since the value is under the
> > control of the device. Switch to use WARN_ON() instead.
>
> some people use crash on warn so ...

Yes, but the policy is under the control of the user.

>
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Halil Pasic <pasic@linux.ibm.com>
> > Cc: Cornelia Huck <cohuck@redhat.com>
> > Cc: Vineeth Vijayan <vneethv@linux.ibm.com>
> > Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> > Cc: linux-s390@vger.kernel.org
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> > ---
> >  include/linux/virtio_config.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > index d4edfd7d91bb..9a36051ceb76 100644
> > --- a/include/linux/virtio_config.h
> > +++ b/include/linux/virtio_config.h
> > @@ -255,7 +255,7 @@ void virtio_device_ready(struct virtio_device *dev)
> >  {
> >       unsigned status = dev->config->get_status(dev);
> >
> > -     BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
> > +     WARN_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
> >
>
> we lose debuggability as guest will try to continue.
> if we are doing this let us print a helpful message and dump a lot of
> state right here.

I'm ok with dropping this patch from the series. And revisit it in the future.

Thanks

>
> >       /*
> >        * The virtio_synchronize_cbs() makes sure vring_interrupt()
> > --
> > 2.25.1
>

