Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64139564DCC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 08:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbiGDGkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 02:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbiGDGkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 02:40:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E05138A1
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 23:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656916831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qMOEw4DkVDPn98Rjv4lUmJsvQgI5ankcWzzn5AvogbY=;
        b=M7nO6uEN5DxBFYmwWbE71uTRVH+cQHNbTSmzCfUG9k1ErSnxvVEIC+Pu3DLeie2Vnjaac8
        Cxk7pnE05j5pwkwIEQCz41o5VHa19ZzAeOFAf5vNvOhofI3tDRMkC6GqiX6BZeadzO0lau
        5AHtNfRNZJUbqwSsUa8WpuWrWw2aNVo=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-Zb1gnL01Pf-UOwuJF-NPKg-1; Mon, 04 Jul 2022 02:40:29 -0400
X-MC-Unique: Zb1gnL01Pf-UOwuJF-NPKg-1
Received: by mail-lj1-f200.google.com with SMTP id k6-20020a2e9206000000b0025a8ce1a22eso2432445ljg.9
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 23:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qMOEw4DkVDPn98Rjv4lUmJsvQgI5ankcWzzn5AvogbY=;
        b=1s+HDu83LQShFx7ieuaB9L3lvmSjjtCxwBY1F0RmtQNB2IaIJq9d6oQHEf98okTycO
         hut07SOlVQCRWmsi+gikbm1nraoLHbcHH3uGq8xq+GeTZ7QG3uMA35JARfaR7Mx262tE
         EkymeS27Tc9ru8wvJT0WQfxE+CF0z8nhdzKIqHYNl9xxgZ1BGpGD9Zg50QG2Z3wK9Aaj
         laOJ57bMwyQMUs4qAdiUf0NYjXxGXTuMvAVvjT0eDqCn7DI4WGCLKqp8Wtr7vY8EfRef
         AvwRILK3DVyPJQ2mqdzq5apeM2cM1QsvgExB4CcZ7CEvpWqAlgfuZs7FjWHiYv7aoJX6
         zTbA==
X-Gm-Message-State: AJIora++3aIbr8jqsxatvNsaHvdS14PNGSNHuqIu1IGLnWNnPmVTnpyI
        9+bK5VWXjN1+/Pik0EsiEDBEKCeM8KDSib+gUeyL5LFyruLGlssuZcRAbMJ+YUbpWGlhrnQ4iUO
        ORS/seBdw61xkr1F2P4vdsE3enxZ+T1T6tLXvgnAL
X-Received: by 2002:a05:6512:3f0f:b0:47f:6f89:326 with SMTP id y15-20020a0565123f0f00b0047f6f890326mr16831242lfa.124.1656916827637;
        Sun, 03 Jul 2022 23:40:27 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sppZhtxMRB1b8yVzweWY5H/6xxlxkDGQ6ZEQ0ZTAxznZHDFs4TDHotunAxKLZpFvYHKvkNwdjwao4UXuarT50=
X-Received: by 2002:a05:6512:3f0f:b0:47f:6f89:326 with SMTP id
 y15-20020a0565123f0f00b0047f6f890326mr16831229lfa.124.1656916827448; Sun, 03
 Jul 2022 23:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEsC4A+3WejLSOZoH3enXtai=+JyRNbxcpzK4vODYzhaFw@mail.gmail.com>
 <CACGkMEvu0D0XD7udz0ebVjNM0h5+K9Rjd-5ed=PY_+-aduzG2g@mail.gmail.com>
 <20220629022223-mutt-send-email-mst@kernel.org> <CACGkMEuwvzkbPUSFueCOjit7pRJ81v3-W3SZD+7jQJN8btEFdg@mail.gmail.com>
 <20220629030600-mutt-send-email-mst@kernel.org> <CACGkMEvnUj622FyROUftifSB47wytPg0YAdVO7fdRQmCE+WuBg@mail.gmail.com>
 <20220629044514-mutt-send-email-mst@kernel.org> <CACGkMEsW02a1LeiWwUgHfVmDEnC8i49h1L7qHmeoLyJyRS6-zA@mail.gmail.com>
 <20220630043219-mutt-send-email-mst@kernel.org> <CACGkMEtgnHDEUOHQxqUFn2ngOpUGcVu4NSQBqfYYZRMPA2H2LQ@mail.gmail.com>
 <20220704021950-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220704021950-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 4 Jul 2022 14:40:16 +0800
Message-ID: <CACGkMEsVcmerW7xE01JvntnxkomxF5r4H2dQGDP8-xGNZJ87kw@mail.gmail.com>
Subject: Re: [PATCH V3] virtio: disable notification hardening by default
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        virtualization <virtualization@lists.linux-foundation.org>,
        kvm <kvm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 4, 2022 at 2:22 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Jul 04, 2022 at 12:23:27PM +0800, Jason Wang wrote:
> > > So if there are not examples of callbacks not ready after kick
> > > then let us block callbacks until first kick. That is my idea.
> >
> > Ok, let me try. I need to drain my queue of fixes first.
> >
> > Thanks
>
> If we do find issues, another option is blocking callbacks until the
> first add. A bit higher overhead as add is a more common operation
> but it has even less of a chance to introduce regressions.

So I understand that the case of blocking until first kick but if we
block until add it means for drivers:

virtqueue_add()
virtio_device_ready()
virtqueue_kick()

We probably enlarge the window in this case.

Thanks

>
> > >
> > >
> > > > >
> > > > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > >I couldn't ... except maybe bluetooth
> > > > > > > > > > > > but that's just maintainer nacking fixes saying he'll fix it
> > > > > > > > > > > > his way ...
> > > > > > > > > > > >
> > > > > > > > > > > > > And during remove(), we get another window:
> > > > > > > > > > > > >
> > > > > > > > > > > > > subsysrem_unregistration()
> > > > > > > > > > > > > /* the window */
> > > > > > > > > > > > > virtio_device_reset()
> > > > > > > > > > > >
> > > > > > > > > > > > Same here.
> > > > > > > > > >
> > > > > > > > > > Basically for the drivers that set driver_ok before registration,
> > > > > > > > >
> > > > > > > > > I don't see what does driver_ok have to do with it.
> > > > > > > >
> > > > > > > > I meant for those driver, in probe they do()
> > > > > > > >
> > > > > > > > virtio_device_ready()
> > > > > > > > subsystem_register()
> > > > > > > >
> > > > > > > > In remove() they do
> > > > > > > >
> > > > > > > > subsystem_unregister()
> > > > > > > > virtio_device_reset()
> > > > > > > >
> > > > > > > > for symmetry
> > > > > > >
> > > > > > > Let's leave remove alone for now. I am close to 100% sure we have *lots*
> > > > > > > of issues around it, but while probe is unavoidable remove can be
> > > > > > > avoided by blocking hotplug.
> > > > > >
> > > > > > Unbind can trigger this path as well.
> > > > > >
> > > > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > > > so
> > > > > > > > > > we have a lot:
> > > > > > > > > >
> > > > > > > > > > blk, net, mac80211_hwsim, scsi, vsock, bt, crypto, gpio, gpu, i2c,
> > > > > > > > > > iommu, caif, pmem, input, mem
> > > > > > > > > >
> > > > > > > > > > So I think there's no easy way to harden the notification without
> > > > > > > > > > auditing the driver one by one (especially considering the driver may
> > > > > > > > > > use bh or workqueue). The problem is the notification hardening
> > > > > > > > > > depends on a correct or race-free probe/remove. So we need to fix the
> > > > > > > > > > issues in probe/remove then do the hardening on the notification.
> > > > > > > > > >
> > > > > > > > > > Thanks
> > > > > > > > >
> > > > > > > > > So if drivers kick but are not ready to get callbacks then let's fix
> > > > > > > > > that first of all, these are racy with existing qemu even ignoring
> > > > > > > > > spec compliance.
> > > > > > > >
> > > > > > > > Yes, (the patches I've posted so far exist even with a well-behaved device).
> > > > > > > >
> > > > > > > > Thanks
> > > > > > >
> > > > > > > patches you posted deal with DRIVER_OK spec compliance.
> > > > > > > I do not see patches for kicks before callbacks are ready to run.
> > > > > >
> > > > > > Yes.
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > MST
> > > > > > > > >
> > > > > > >
> > > > >
> > >
>

