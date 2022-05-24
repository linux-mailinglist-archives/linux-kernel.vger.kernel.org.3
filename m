Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0441B532D9C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 17:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238944AbiEXPex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 11:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbiEXPet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 11:34:49 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA947580E1
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 08:34:48 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id i27so36105110ejd.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 08:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XKQgP4gZTvt4b++ZSM+DxjPg9J0TxcLJRrQHC/0hh0s=;
        b=qOWSHVyq0qvKCiLV6FRf5dYPoK4I2LWG04bQZX9Ixs9fvAkWtsiP4M4uyKV4L3Owf6
         oo/24gsZWsamGHpZduBebduOB08KFZ6VWJ5T4Rc6++e7D2kmtb3TldiP+fsuOoCb58kX
         unaIW9RfOgVRVfnTffoALlAAFpef3zWYDaCnut6LN7Ch51bKU0ykTNcCwHKcazddwjEY
         mI7Th1MC7eFPDtnWbOTS4Yw1UAF9wvJhofUEuwNpDEWy24GA4Kld0vjqW4Ejm7tj1c5N
         JYFsZNb30Nm8y7zM5MZDVk71xzFwlaxKIBdjayG81cNBu82apnYDEGFurYH+1lNSailj
         Xheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XKQgP4gZTvt4b++ZSM+DxjPg9J0TxcLJRrQHC/0hh0s=;
        b=y8WBu6zh/4pqeWM76G/IubpmRhoWtaOaom0iAK4s8vZalN8zVNmgkxNbJ+TE6X/A+J
         2DT87ycTtmhhp+q/uVWfjKOliLGe/g/8et6EaQG4ri8BNqOPoAHefIK9gDCw4D8W17A3
         6B0ua3qzRsUsLkb5tzmYwcT2gwpy9YkcqtvrDN+H1oeXQ8tKcEdFLpBUezyHR9feUuk0
         NMKkqFyMvYnWOx4hOu/91cozLtcHNaB6qJVIKTRkSr+s7Ork1K7qUhJHPF0mXSSdvPvs
         FsjO0/EOZDqT4dwX4c8IvbClzJJEHPIK5txCDR84osXSs4/IxhuF3Xmh5kM4liehL7AG
         dzag==
X-Gm-Message-State: AOAM531Uztcke6GD6RBJKcu0ipgqJtSqVe4YprcGilutPBD3CTdeMKij
        kr9JQM64QpzdeHLT6v7gsa9nSjOfQrnSSnAmSBIMrE6+Srw=
X-Google-Smtp-Source: ABdhPJyKYl8sTqnTGs974NhxolD0105jjPI+EMpfcxAqya5Yq62Twbhixcyf3O4P7dAR/BlHaFghgyOw2QYDKA6UwPg=
X-Received: by 2002:a17:907:160e:b0:6f4:54c0:657e with SMTP id
 hb14-20020a170907160e00b006f454c0657emr25501932ejc.253.1653406487255; Tue, 24
 May 2022 08:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220520082940.2984914-1-arnaud.pouliquen@foss.st.com>
In-Reply-To: <20220520082940.2984914-1-arnaud.pouliquen@foss.st.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 24 May 2022 09:34:36 -0600
Message-ID: <CANLsYkw7wjfVPTvA7SniMV8tBommm5E5w2FA0KMyRYn0BKVDyA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/10] Introduction of rpmsg flow control service
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Chris Lew <quic_clew@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaud,

I added your patchset to my review list.  Unfortunately it sits behind
a sizable backlog and as such I won't be able to get to it for some
time.

Thanks,
Mathieu

On Fri, 20 May 2022 at 02:30, Arnaud Pouliquen
<arnaud.pouliquen@foss.st.com> wrote:
>
> This series proposes an implementation for the rpmsg virtio transport
> backend, of the signaling API proposed by Deepak Kumar Singh:
> "rpmsg and glink signaling API support" [1]
>
> The aim of the series is to offer the possibility for an endpoint to inform
> a remote endpoint about its state, based on a software flow control[2].
>
> For this a new rpmsg service( with a fixed address 64) is proposed.
> It is responsible for:
> - transmitting local endpoint flow control information to the remote side,
> - informing a local endpoint about a remote endpoint flow control.
>
> For the rpmsg virtio transport layer the service is negotiated thanks to the
> virtio feature flag: VIRTIO_RPMSG_F_FC
>
> Notice that this pull request introduces new feature in the rpmsg protocol,
> So it has to be aligned with OpenAMP implementation.
> Pending OpenAMP pull request is available here:
> https://github.com/OpenAMP/open-amp/pull/394
>
>
> [1]https://lkml.org/lkml/2022/1/18/867
> [2]https://en.wikipedia.org/wiki/Software_flow_control
>
> Arnaud Pouliquen (8):
>   rpmsg: core: Add rpmsg device remote flow control announcement ops
>   rpmsg: virtio: Implement the announce_remote_fc ops
>   rpmsg: Introduce flow control channel driver
>   rpmsg: virtio: Add support of the VIRTIO_RPMSG_F_FC feature
>   rpmsg: virtio: Implement the set_flow_control ops
>   rpmsg: Add the destination address in rpmsg_set_flow_control
>   rpmsg: tty : Add the support of the flow control
>   rpmsg: virtio: Set default dst address on flow control
>
> Deepak Kumar Singh (2):
>   rpmsg: core: Add signal API support
>   rpmsg: char: Add TIOCMGET/TIOCMSET ioctl support
>
>  drivers/rpmsg/Kconfig            |  11 +++
>  drivers/rpmsg/Makefile           |   1 +
>  drivers/rpmsg/rpmsg_char.c       |  56 +++++++++++++--
>  drivers/rpmsg/rpmsg_core.c       |  47 +++++++++++++
>  drivers/rpmsg/rpmsg_fc.c         | 113 +++++++++++++++++++++++++++++++
>  drivers/rpmsg/rpmsg_internal.h   |   9 +++
>  drivers/rpmsg/virtio_rpmsg_bus.c | 111 +++++++++++++++++++++++++++++-
>  drivers/tty/rpmsg_tty.c          |  50 ++++++++++++++
>  include/linux/rpmsg.h            |  15 ++++
>  include/linux/rpmsg/fc.h         |  51 ++++++++++++++
>  10 files changed, 456 insertions(+), 8 deletions(-)
>  create mode 100644 drivers/rpmsg/rpmsg_fc.c
>  create mode 100644 include/linux/rpmsg/fc.h
>
> --
> 2.25.1
>
