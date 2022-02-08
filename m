Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256994AD999
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358092AbiBHNV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376474AbiBHNJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 08:09:35 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45411C03FED0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 05:09:34 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id x193so20562208oix.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 05:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SbtrRuHy+NSlAeGtvroJmD9+7e6TK8yWL1WcOGDbT60=;
        b=ipB2P1DX/pWgxuTpermK6N6bN/NM8fq3jGkEyjPKIkXcJpx6XjJ9MZa/NKoDWwrzzR
         H9zOo26gGXSh73UucCAB3b8IrpsW1y9z8bWdX9TuGNUEUL6P7BodxWlew7CktkYe46lB
         mTSdFCPQ3OkT1RP1x/cWc1BBjlCdCs9vkvqtGoNIO1KIyvUoux1SlJZUjb+j4n02gssA
         tpx4yKREirT9e4vk7X0IQqZIvUbeUkL8uwPIArNFxbd4OjMiyavTrZuTe4VqePCEvIIW
         C/es6W9/nRSRO9vZv0UYJzlCUwVtwQXGAEyGo2tiEFSLhexMFTuNnQ6mlfn+EXqCeeBl
         yteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SbtrRuHy+NSlAeGtvroJmD9+7e6TK8yWL1WcOGDbT60=;
        b=dHVf5++LQSVBKcKleiDyUrVOBOposbcXhiv9nSkxHqwWKJLkCFx7F6OWKlrmu4Yaq8
         ltLnZp4zKbl8fTjp9TyTD3Vy31g6I54ZJTq7IuZYsEbFojraiHWBMe5WpzHZp4ZL0rtw
         8gHbgWnSZH9J8RgfHgharJKq0uzHC3gHB7Zm6JfGy+wYZ2hT27p8XXIGN6MfCCyY/HTK
         LVLv89MJcJ52/TN6fFebJoKUnm2C/R1GsDv/37RD44JnY+VyqcaUx2ZFN+jTO/S6t5Hk
         6UkeXdMzIeo8CfUeozAWvuqx2dst4KSVDTLJd/En8mIw4CgyWwT26wx8iw7vj6sGzGuJ
         Feaw==
X-Gm-Message-State: AOAM530kP8B7HAxve3veDfkkUbGH5bDdt5FjmwNcLzjIAeoMeuynd7TB
        upOEEtvsqWWGDRhFkFKo34yLJZcte/ca8NRZfxHY9ojFDIobLA==
X-Google-Smtp-Source: ABdhPJyJ9Zma2ZEin8GNpdoeNj2ZN7XXaEM/ArByR8cTF7OFgqG6jNtpwnZynRpkSVBbmdgOEJlE7ZQrWSvJLj3ECJY=
X-Received: by 2002:a05:6808:1819:: with SMTP id bh25mr454334oib.35.1644325772109;
 Tue, 08 Feb 2022 05:09:32 -0800 (PST)
MIME-Version: 1.0
References: <20220125084702.3636253-1-andrew@daynix.com> <1643183537.4001389-1-xuanzhuo@linux.alibaba.com>
 <CAOEp5OcwLiLZuVOAxx+pt6uztP-cGTgqsUSQj7N7HKTZgmyN3w@mail.gmail.com>
In-Reply-To: <CAOEp5OcwLiLZuVOAxx+pt6uztP-cGTgqsUSQj7N7HKTZgmyN3w@mail.gmail.com>
From:   Andrew Melnichenko <andrew@daynix.com>
Date:   Tue, 8 Feb 2022 15:09:21 +0200
Message-ID: <CABcq3pE43rYojwUCAmpW-FKv5=ABcS47B944Y-3kDqr-PeqLwQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] TUN/VirtioNet USO features support.
To:     Yuri Benditovich <yuri.benditovich@daynix.com>
Cc:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Yan Vugenfirer <yan@daynix.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people,
Can you please review this series?

On Wed, Jan 26, 2022 at 10:32 AM Yuri Benditovich
<yuri.benditovich@daynix.com> wrote:
>
> On Wed, Jan 26, 2022 at 9:54 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > On Tue, 25 Jan 2022 10:46:57 +0200, Andrew Melnychenko <andrew@daynix.com> wrote:
> > > Added new offloads for TUN devices TUN_F_USO4 and TUN_F_USO6.
> > > Technically they enable NETIF_F_GSO_UDP_L4
> > > (and only if USO4 & USO6 are set simultaneously).
> > > It allows to transmission of large UDP packets.
> > >
> > > Different features USO4 and USO6 are required for qemu where Windows guests can
> > > enable disable USO receives for IPv4 and IPv6 separately.
> > > On the other side, Linux can't really differentiate USO4 and USO6, for now.
> > > For now, to enable USO for TUN it requires enabling USO4 and USO6 together.
> > > In the future, there would be a mechanism to control UDP_L4 GSO separately.
> > >
> > > Test it WIP Qemu https://github.com/daynix/qemu/tree/Dev_USOv2
> > >
> > > New types for VirtioNet already on mailing:
> > > https://lists.oasis-open.org/archives/virtio-comment/202110/msg00010.html
> >
> > Seems like this hasn't been upvoted yet.
> >
> >         https://github.com/oasis-tcs/virtio-spec#use-of-github-issues
>
> Yes, correct. This is a reason why this series of patches is RFC.
>
> >
> > Thanks.
> >
> > >
> > > Also, there is a known issue with transmitting packages between two guests.
> > > Without hacks with skb's GSO - packages are still segmented on the host's postrouting.
> > >
> > > Andrew Melnychenko (5):
> > >   uapi/linux/if_tun.h: Added new ioctl for tun/tap.
> > >   driver/net/tun: Added features for USO.
> > >   uapi/linux/virtio_net.h: Added USO types.
> > >   linux/virtio_net.h: Added Support for GSO_UDP_L4 offload.
> > >   drivers/net/virtio_net.c: Added USO support.
> > >
> > >  drivers/net/tap.c               | 18 ++++++++++++++++--
> > >  drivers/net/tun.c               | 15 ++++++++++++++-
> > >  drivers/net/virtio_net.c        | 22 ++++++++++++++++++----
> > >  include/linux/virtio_net.h      | 11 +++++++++++
> > >  include/uapi/linux/if_tun.h     |  3 +++
> > >  include/uapi/linux/virtio_net.h |  4 ++++
> > >  6 files changed, 66 insertions(+), 7 deletions(-)
> > >
> > > --
> > > 2.34.1
> > >
> > > _______________________________________________
> > > Virtualization mailing list
> > > Virtualization@lists.linux-foundation.org
> > > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
