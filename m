Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1CD49C551
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 09:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238506AbiAZIci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 03:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiAZIcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 03:32:36 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD902C061744
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 00:32:36 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id g15-20020a9d6b0f000000b005a062b0dc12so7483600otp.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 00:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e2BGPbgxNsjIOcq9lLJ9KQzQO0Zg9McVWQ2H+KEkY/8=;
        b=IuF0OHqM0YtU+6Ni8u9RjwmM75GrCxWoyVk4PDoMariwcrvsfp2YuifnjJWjufDcSm
         13iUSKEGxgEBLZDhNb4mS4ESnWp0l5FqFxXXR7ZrFQR1Z9VbnMhuAyCgTxQ66ab3u1S3
         Q/2W/tHwp7TRz4fIFQrRy0/V1tj8qRxQ+m52iMOYuS7RSQFQbRt/lLECdvi6ER/UdiO6
         MmnGb4Ijjut54FHIVE1ufzmRWGeCI6glhHhYTf3EUTJgGY46r7c7EEF0WIXRjhQ63Jne
         qRrHeYfCKZQRP/pd1cS9ONanSzhHaI0f+8ZT9YnU4nmPiIV1ETutvIXdnFOsI1XbG+YF
         bBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e2BGPbgxNsjIOcq9lLJ9KQzQO0Zg9McVWQ2H+KEkY/8=;
        b=x+Xm+jnsEMNQHu+i5iYX1eZ2fZOwRTHIhmah12gHtY7LeQbJ7iwyyog6sWzmBel14Y
         KD84CnLvFaBjYiN5FxuoBZuxwcMLAImM4VsoifWUkrC5Mvdy71PsHVMmQ//zP3uTk51o
         LCcVWrnHrWrpL4NO63K7mxxJl52dWjOp0YYmRxIJ/JX7tb1ZrgWmupFGOo6s9jVg0G3J
         DsSC6/sH5QZDYnj5e4vfCUj90ozhXK0FCk8cDAyMgkYyPkkX6PXfRmLAW1XB8xgkBKzP
         YiRfEX6Q14wbJHOxjzrR+qL5xrZ+XSGrfGafCzNufFkywNamLTkAf4W284AfWO5IjCPg
         KVxA==
X-Gm-Message-State: AOAM530siHQfLQ0T3Z3b5zX5vaQ9DwW5IlGmOqshlG9cZIN8V6v7rSAF
        dDM+y99lspAm1rOcro8DFyHs0lYy2z2wRgFFY59KPw==
X-Google-Smtp-Source: ABdhPJz1eMtqPc7zF2TNXjxiyxOoImyr6IMt5tZ8nz4RKJOIHml02NLosf18hu6uaIzph0k5GPQaTnHAFDmrKNtyTEo=
X-Received: by 2002:a05:6830:4013:: with SMTP id h19mr11781846ots.153.1643185956172;
 Wed, 26 Jan 2022 00:32:36 -0800 (PST)
MIME-Version: 1.0
References: <20220125084702.3636253-1-andrew@daynix.com> <1643183537.4001389-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1643183537.4001389-1-xuanzhuo@linux.alibaba.com>
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
Date:   Wed, 26 Jan 2022 10:32:24 +0200
Message-ID: <CAOEp5OcwLiLZuVOAxx+pt6uztP-cGTgqsUSQj7N7HKTZgmyN3w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] TUN/VirtioNet USO features support.
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     Andrew Melnychenko <andrew@daynix.com>,
        Yan Vugenfirer <yan@daynix.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 9:54 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> On Tue, 25 Jan 2022 10:46:57 +0200, Andrew Melnychenko <andrew@daynix.com> wrote:
> > Added new offloads for TUN devices TUN_F_USO4 and TUN_F_USO6.
> > Technically they enable NETIF_F_GSO_UDP_L4
> > (and only if USO4 & USO6 are set simultaneously).
> > It allows to transmission of large UDP packets.
> >
> > Different features USO4 and USO6 are required for qemu where Windows guests can
> > enable disable USO receives for IPv4 and IPv6 separately.
> > On the other side, Linux can't really differentiate USO4 and USO6, for now.
> > For now, to enable USO for TUN it requires enabling USO4 and USO6 together.
> > In the future, there would be a mechanism to control UDP_L4 GSO separately.
> >
> > Test it WIP Qemu https://github.com/daynix/qemu/tree/Dev_USOv2
> >
> > New types for VirtioNet already on mailing:
> > https://lists.oasis-open.org/archives/virtio-comment/202110/msg00010.html
>
> Seems like this hasn't been upvoted yet.
>
>         https://github.com/oasis-tcs/virtio-spec#use-of-github-issues

Yes, correct. This is a reason why this series of patches is RFC.

>
> Thanks.
>
> >
> > Also, there is a known issue with transmitting packages between two guests.
> > Without hacks with skb's GSO - packages are still segmented on the host's postrouting.
> >
> > Andrew Melnychenko (5):
> >   uapi/linux/if_tun.h: Added new ioctl for tun/tap.
> >   driver/net/tun: Added features for USO.
> >   uapi/linux/virtio_net.h: Added USO types.
> >   linux/virtio_net.h: Added Support for GSO_UDP_L4 offload.
> >   drivers/net/virtio_net.c: Added USO support.
> >
> >  drivers/net/tap.c               | 18 ++++++++++++++++--
> >  drivers/net/tun.c               | 15 ++++++++++++++-
> >  drivers/net/virtio_net.c        | 22 ++++++++++++++++++----
> >  include/linux/virtio_net.h      | 11 +++++++++++
> >  include/uapi/linux/if_tun.h     |  3 +++
> >  include/uapi/linux/virtio_net.h |  4 ++++
> >  6 files changed, 66 insertions(+), 7 deletions(-)
> >
> > --
> > 2.34.1
> >
> > _______________________________________________
> > Virtualization mailing list
> > Virtualization@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
