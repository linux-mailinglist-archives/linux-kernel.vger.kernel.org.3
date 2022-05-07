Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232FD51E43A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 07:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356241AbiEGFLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 01:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343722AbiEGFLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 01:11:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 881EB5523C
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 22:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651900048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WKFrTG6BT4XtoQUjOd0EJOeY4hUiJrW4gNuP1XW6bYk=;
        b=frzyhKaY5TE5sonZU4p/ekfqNvWlP8VNJrYyVSb9W8L7nY2Bk34IgIcR29c/SqFuoj9N7C
        eOpoBFRuXC4D0tZWQ4e9ZlU6G3dJngJPnER1mNpmMxmvaK8SFUWJyQeCp5ysZ3HgiTjoeZ
        OSIBAFobpviOkurncTdqMxcA5asKcKg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-E7RcxE1hOwW9Wawicl8uPg-1; Sat, 07 May 2022 01:07:26 -0400
X-MC-Unique: E7RcxE1hOwW9Wawicl8uPg-1
Received: by mail-lf1-f69.google.com with SMTP id e8-20020ac24e08000000b00473b1bae573so4069532lfr.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 22:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WKFrTG6BT4XtoQUjOd0EJOeY4hUiJrW4gNuP1XW6bYk=;
        b=DN2owTm7aWg9RQk/6MiVGf63AC69vJsudUpKEVJfOsfgkUETyNlYHtqjNY+3BE4vfc
         D+cPjm6Hk64sLWCm9m06R1tYSbRKvVweu4DdkTHW616TNDDaCno/PhLeHpwFFJIQx3Ol
         QWOhYw8m/d8VRQ/bHhso6rarRvASX0HaV5I4sSi+WhW6C0hvcbOEqBhY+GdxkA762ijN
         MWrW1jRVm1QwX/ai8pbT5yiRWkUuukaRKCE56c9VJP6Xv3c/vNBkAXeDh2uv7sejye7m
         ypEQyzU7rLu/+VvTFGEwZxNsOB84/0utsWimWZ7JNd3fSWr/T9hZDI/SvLjhD99saMKM
         74hA==
X-Gm-Message-State: AOAM530WxDdVa9D2ICslX3QNMYJCoYKe6s6LgzTEq4nhEJLgyt/F36vK
        tL8q9xSIFuuW+JdTc/X28JZZO3GW5w1OP/S7l2LPNDbcVDaqcKVbponFYYgPB+qQW9daeLR46Ka
        itTbkU6CJyokG8skyXz+InF+TVuB6SCY5ScRbjmZ6
X-Received: by 2002:a05:6512:33d0:b0:473:a25e:f9fb with SMTP id d16-20020a05651233d000b00473a25ef9fbmr4951617lfg.98.1651900045340;
        Fri, 06 May 2022 22:07:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZGP+pzBwvqTFnGLNL46r624MAOVl0Foh5oZRGkIyYHh3KQhYZ1Z+k+zg853w8U8aha7h4FUe6I44wlLfmAlE=
X-Received: by 2002:a05:6512:33d0:b0:473:a25e:f9fb with SMTP id
 d16-20020a05651233d000b00473a25ef9fbmr4951603lfg.98.1651900045134; Fri, 06
 May 2022 22:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220428151242.213824-1-sgarzare@redhat.com> <CACGkMEv=0VWh_NxhvM+6_TRHEx0f2RGRWbR1n5RhKfq0a7xJUw@mail.gmail.com>
 <20220429071449.pycbkk2dvvxmtvay@sgarzare-redhat> <CACGkMEtRwRb_jUdCcdrx77=O4bnRGssQ5z_81KJi1hEKdbMcCQ@mail.gmail.com>
 <20220505084045.xdh3xwgfr2spp3fj@sgarzare-redhat>
In-Reply-To: <20220505084045.xdh3xwgfr2spp3fj@sgarzare-redhat>
From:   Jason Wang <jasowang@redhat.com>
Date:   Sat, 7 May 2022 13:07:14 +0800
Message-ID: <CACGkMEsAyx2V_Q41MbrFu3eXoi+Qmg_aeEz9-Aw6qYHsFivCTg@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim_blk: add support for VIRTIO_BLK_T_FLUSH
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 5, 2022 at 4:40 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Thu, May 05, 2022 at 04:26:24PM +0800, Jason Wang wrote:
> >On Fri, Apr 29, 2022 at 3:14 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
> >>
> >> On Fri, Apr 29, 2022 at 10:46:40AM +0800, Jason Wang wrote:
> >> >On Thu, Apr 28, 2022 at 11:13 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
> >> >>
> >> >> The simulator behaves like a ramdisk, so we don't have to do
> >> >> anything when a VIRTIO_BLK_T_FLUSH request is received, but it
> >> >> could be useful to test driver behavior.
> >> >>
> >> >> Let's expose the VIRTIO_BLK_F_FLUSH feature to inform the driver
> >> >> that we support the flush command.
> >> >>
> >> >> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >> >> ---
> >> >>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 12 ++++++++++++
> >> >>  1 file changed, 12 insertions(+)
> >> >>
> >> >> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> >> >> index 42d401d43911..a6dd1233797c 100644
> >> >> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> >> >> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> >> >> @@ -25,6 +25,7 @@
> >> >>  #define DRV_LICENSE  "GPL v2"
> >> >>
> >> >>  #define VDPASIM_BLK_FEATURES   (VDPASIM_FEATURES | \
> >> >> +                                (1ULL << VIRTIO_BLK_F_FLUSH)    | \
> >> >>                                  (1ULL << VIRTIO_BLK_F_SIZE_MAX) | \
> >> >>                                  (1ULL << VIRTIO_BLK_F_SEG_MAX)  | \
> >> >>                                  (1ULL << VIRTIO_BLK_F_BLK_SIZE) | \
> >> >> @@ -166,6 +167,17 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
> >> >>                 pushed += bytes;
> >> >>                 break;
> >> >>
> >> >> +       case VIRTIO_BLK_T_FLUSH:
> >> >> +               if (sector != 0) {
> >> >> +                       dev_err(&vdpasim->vdpa.dev,
> >> >> +                               "A driver MUST set sector to 0 for a VIRTIO_BLK_T_FLUSH request - sector: 0x%llx\n",
> >> >> +                               sector);
> >> >
> >> >If this is something that could be triggered by userspace/guest, then
> >> >we should avoid this.
> >>
> >> It can only be triggered by an erratic driver.
> >
> >Right, so guest can try to DOS the host via this.
>
> Yes, but I don't expect the simulator to be used in the real world, but
> only for testing and development, so the user should have full control
> of the guest.

Right, but from kernel POV it's better to avoid any guest triggerable behaviour.

>
> >
> >>
> >> I was using the simulator to test a virtio-blk driver that I'm writing
> >> in userspace and I forgot to set `sector` to zero, so I thought it would
> >> be useful.
> >>
> >> Do you mean to remove the error message?
> >
> >Some like dev_warn_once() might be better here.
>
> We also have other checks we do for each request (in and out header
> length, etc.) where we use dev_err(), should we change those too?

I think so.

>
> I don't know, from a developer's point of view I'd prefer to have them
> all printed, but actually if we have a totally wrong driver in the
> guest, we risk to hang our host to print an infinite number of messages.

Or we can use pr_debug() or tracepoints. Then the log is enabled conditally.

>
> Maybe we should change all the errors in the data path to
> dev_warn_once() and keep returning VIRTIO_BLK_S_IOERR to the guest which
> will surely get angry and print something.
>
> If you agree, I'll send a patch to change all the printing and then
> repost this with your suggestion as well.

Yes.

Thanks

>
> Thanks,
> Stefano
>

