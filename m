Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860F34C2DA0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 14:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbiBXNxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 08:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235245AbiBXNxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:53:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7374B13C25A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 05:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645710785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nW0eks/cUbzpUTn5JZlT+rD6G7IprS9N+XGNcxMKob0=;
        b=SKX//xaKnJufs2LW8fbsXCVi4Yo8lc/RUtk81nckOAc9IREhueBfjsAc/0ydExasL9dTWb
        DINH7Bhax2dhVXNSDbHS7m616kNQ16jaBZlXRYF5srJQoHBda29gwws4dq8a7gFZIgkzsu
        NILD5KyHtSb4bx81ANVz5LCbPq8Hu0s=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-iZ4YmzygOriwpjv7xuIdXw-1; Thu, 24 Feb 2022 08:53:04 -0500
X-MC-Unique: iZ4YmzygOriwpjv7xuIdXw-1
Received: by mail-pj1-f71.google.com with SMTP id t12-20020a17090abc4c00b001bc770db571so1338781pjv.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 05:53:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nW0eks/cUbzpUTn5JZlT+rD6G7IprS9N+XGNcxMKob0=;
        b=eHwXMkg2ggGnR9/LMwamj9kTW1eWF7vYBJpA0g66lyiyBwXNQh100u5lzpFxM6EAbR
         75+G4T7/GFYCyYjz8ldXkahh49x3j+qqw/c4LinroVAbSIkxtvTaNGilnuFcxjeV4wY8
         knLwjibZFmbILIs9OTO7N3IbqjzPYCkQK1z0lwVaGjtoPpo8teVDZJLxdydZjjPdpVG6
         TSOQM2N519waEdmTw2KfS0gX/VFIlgW+BoO2y64GvovJm5CVOqR8DCmaX+SYePdUVEKr
         Sm3iJZtWvfUK0kYJv7ecKwcyd5lgJUAMjpYdXrMebpJyClQZs/Cp2eNUb3nIUsVkSczY
         kLBA==
X-Gm-Message-State: AOAM5301FXGQQ2ipV7dI/g0N0AjTvy0h1dUBhGnOmFqb1at324H/1UBF
        jpswHNq4pAcy0mtgQ0jToHWp0iXjaRo8D+1C96A7oM5S5WGOmECqbTMP+r68qMGCDCbpGN0spWy
        ViwWHO0SPHRjFqKMZBHOXABp6AhkzKSsbp4AC/zOc
X-Received: by 2002:a17:90b:3796:b0:1bc:c077:5be4 with SMTP id mz22-20020a17090b379600b001bcc0775be4mr2926057pjb.113.1645710783274;
        Thu, 24 Feb 2022 05:53:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyP5SF908XSlgAzoTvKvDDAdvOLIhxJ4D3T0E+ATkZQ8SViZKIlb+DLC9cEjliR0+RFjbKI3qPerMdruQrSD9Y=
X-Received: by 2002:a17:90b:3796:b0:1bc:c077:5be4 with SMTP id
 mz22-20020a17090b379600b001bcc0775be4mr2926032pjb.113.1645710783083; Thu, 24
 Feb 2022 05:53:03 -0800 (PST)
MIME-Version: 1.0
References: <20220224110828.2168231-1-benjamin.tissoires@redhat.com>
 <20220224110828.2168231-2-benjamin.tissoires@redhat.com> <YhdtKN7qodX7VDPV@kroah.com>
In-Reply-To: <YhdtKN7qodX7VDPV@kroah.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 24 Feb 2022 14:52:52 +0100
Message-ID: <CAO-hwJKQA4v53ER-y6Qx6gK032O3a+HNxbpQVhn2GiP4UJqe5g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/6] HID: initial BPF implementation
To:     Greg KH <greg@kroah.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Joe Stringer <joe@cilium.io>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 12:41 PM Greg KH <greg@kroah.com> wrote:
>
> On Thu, Feb 24, 2022 at 12:08:23PM +0100, Benjamin Tissoires wrote:
> > index 000000000000..243ac45a253f
> > --- /dev/null
> > +++ b/include/uapi/linux/bpf_hid.h
> > @@ -0,0 +1,39 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later WITH Linux-syscall-note */
> > +
> > +/*
> > + *  HID BPF public headers
> > + *
> > + *  Copyright (c) 2021 Benjamin Tissoires
> > + */
> > +
> > +#ifndef _UAPI__LINUX_BPF_HID_H__
> > +#define _UAPI__LINUX_BPF_HID_H__
> > +
> > +#include <linux/types.h>
> > +
> > +#define HID_BPF_MAX_BUFFER_SIZE              16384           /* 16kb */
> > +
> > +struct hid_device;
> > +
> > +enum hid_bpf_event {
> > +     HID_BPF_UNDEF = 0,
> > +     HID_BPF_DEVICE_EVENT,
> > +};
> > +
> > +/* type is HID_BPF_DEVICE_EVENT */
> > +struct hid_bpf_ctx_device_event {
> > +     __u8 data[HID_BPF_MAX_BUFFER_SIZE];
> > +     unsigned long size;
>
> That's not a valid type to cross the user/kernel boundry, shouldn't it
> be "__u64"?  But really, isn't __u32 enough here?

thanks. Even __u16 should be enough, given that the upper bound is
16384. I'll amend it in v2.

Cheers,
Benjamin

>
> thanks,
>
> greg k-h
>

