Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEDF50F22B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343748AbiDZHYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbiDZHYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:24:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A51EF18
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650957656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eWIJZqdMwS3HNnV8QTrUrUSNrBG0fkI8SmgPmVCU0Ck=;
        b=bwCQIgGMGuFmv4332MnlNmqW8W8GRDfpax2pT5lVz2CcQQEpP8ubY3jrorcr3j10hzFT+q
        yG+wthMmpM23dfyRRmr1/gFveJC+P9ADCSDz6F1++yrKY53jbUhn+Oz18o+IHwf9nKpZLT
        pwIxWVX3iAWT7o9QlfnaRtgNnssXDTA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-nOz6XtbeMOKTdBch3A-1AA-1; Tue, 26 Apr 2022 03:20:53 -0400
X-MC-Unique: nOz6XtbeMOKTdBch3A-1AA-1
Received: by mail-pl1-f200.google.com with SMTP id m11-20020a170902f64b00b0015820f8038fso10833153plg.23
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:20:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eWIJZqdMwS3HNnV8QTrUrUSNrBG0fkI8SmgPmVCU0Ck=;
        b=vjfgEaKQmRXmPZxbWhoGD1cia1LKg7hOoFbG9/ppYwsPK6TirQ7xSWhonsN03xG0nT
         dEchE+SoFsr4FNSoy7VfmJwKzTvZanqOInfJltTB1kzbUfhco/xIHRuUGbsE4JGWOsBA
         XpOBakq6/75e0SKDqobRw9hqkU4ND8B+4S09bH6FPGEzK4hdLE8LzowhjEOkLTW+1F4t
         WixWOw36P58hifmHBDXGcgseruCCSAZei1aZ1KGrSNodJmwm9WgX15o2fz0W7NA5cgMJ
         eX6UjrWelh7OE0RfNkph3ZzmfKKBesdz6egQu8MP8eiJnwZuHoB7mCjSu4rd5M5ZTVaP
         8k7g==
X-Gm-Message-State: AOAM531Era7da5AwytlJuMTJVzGRJF+RPy4wyCaWwI4bKDnjIPAlC9yI
        hRq6v5tPdzKVdM9rNH/R/GfcnX89DDgNcUrPkpxPI9pRQwlR+a3TMjX9lgiMWZHcn1oo4QNMY5/
        SxOqosZYotTXoxefl5Xv1/GPNIFvBF/xHf6efx45s
X-Received: by 2002:a17:903:1251:b0:156:9d8e:1077 with SMTP id u17-20020a170903125100b001569d8e1077mr21717589plh.116.1650957652415;
        Tue, 26 Apr 2022 00:20:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQzhNeIPSrkAN2NRH72NBkrGTuMn5TOSB+Gf1Ek2ivyNsFh4NWKCgIImf9VW+7uyrobhzI2jCCiE6qk2ih9M4=
X-Received: by 2002:a17:903:1251:b0:156:9d8e:1077 with SMTP id
 u17-20020a170903125100b001569d8e1077mr21717577plh.116.1650957652173; Tue, 26
 Apr 2022 00:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220421140740.459558-1-benjamin.tissoires@redhat.com> <20220426040314.ez3cdpv2w45vbgkk@MBP-98dd607d3435.dhcp.thefacebook.com>
In-Reply-To: <20220426040314.ez3cdpv2w45vbgkk@MBP-98dd607d3435.dhcp.thefacebook.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 26 Apr 2022 09:20:41 +0200
Message-ID: <CAO-hwJLziatB9n5Rut_EYRgfN94t2XX8Zx8B_Zmu2nucTw3k8g@mail.gmail.com>
Subject: Re: [RFC bpf-next v4 0/7] Introduce eBPF support for HID devices (new attempt)
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 6:03 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Apr 21, 2022 at 04:07:33PM +0200, Benjamin Tissoires wrote:
> > Hi,
> >
> > so after the reviews from v3, and some discussion with Alexei, I am
> > back with a new version of HID-BPF.
> >
> > This version is not complete (thus the RFC), but I'd like to share
> > it now to get initial feedback, in case I am too far from the actual
> > goal.
> >
> > FTR, the goal is to provide some changes in the core verifier/btf so
> > that we can plug in HID-BPF independently from BPF core. This way we can
> > extend it without having to care about bpf-next.
>
> Overall looks great. imo much cleaner, simpler and more extensible
> than the earlier versions.
> The bpf core extensions are nicely contained and HID side can be
> worked on in parallel.

\o/

>
> > The things I am not entirely sure are:
> > - do we need only fentry/fexit/fmod_ret BPF program types or should
> >   programs that modify the data stream use a different kind?
>
> Probably not. I'll reply in patch 2.
>
> > - patch 3/7 is probably not the correct approach (see comments in the
> >   patch itself)
> >
> > We are missing quite a few bits here:
> > - selftests for patches 1 to 4
> > - add the ability to attach a program to a struct device, and run that
> >   program only for that struct device
>
> yes. That is still to be figured out.

I spent some time on that, and I don't think it makes a lot of sense
to use the current trampoline approach if we want to keep on using
fentry/fexit...
- the trampoline is pretty nice, but it adds instructions before
calling the actual function, meaning that adding a check on struct
device will be quite hard to do ()we have no idea where the struct
device is in the arguments) and will take more space on the trampoline
itself
- there is a limit on how many functions can be attached to a
trampoline (38 IIRC), and we probably will explode that number quickly
enough when we get more BPF programs to support HID devices.

So my chain of thoughts from yesterday was the following (completely
untested of course):
- instead of writing a new BPF API that might move in the future while
things are settling, I can actually simply load a tracer BPF program
from HID that monitors the BPF programs that are attached to a given
function
- I can also add a new API (a kfunc likely) that "registers" a given
BPF program (through its fd) to a given HID device
- when a device sends data, it hits hid_bpf_device_event() which will
have a default BPF program (loaded by the kernel) that dispatches the
registered BPF programs based on the HID device.

This would solve the 2 issues above IMO, except that the kfunc to
register a HID BPF program will suddenly be not standard.

>
> > - when running through bpf_prog_test_run_opts, how can we ensure we are
> >   talking to the correct device? (I have a feeling this is linked to the
> >   previous point)
> > - how can we reconnect the device when a report descriptor fixup BPF
> >   program is loaded (would it make sense to allow some notifications on
> >   when a BPF program is attached/detached to a device, and which
> >   function have been traced?)
>
> Not sure I follow. What kind of notification do you have in mind?
> To user space?
>

No, this is in-kernel notifications.
What I want to do, is when I load a BPF program that changes the HID
report descriptor, hid-core detects that and reconnects the attached
device.

But after a couple of days of thinking, and with the above approach
where HID would preload a BPF program, I should be able to achieve
that with the "register BPF through a HID kfunc call". When I see that
we are attaching a HID report descriptor fixup to a given HID device,
I can then reconnect the matching device.

It would certainly be cleaner to have a general "notify me when a
tracer is attached to this particular function", but we can hide that
right now with a preloaded BPF program :)

Cheers,
Benjamin

