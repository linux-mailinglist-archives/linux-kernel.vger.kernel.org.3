Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7494CDE16
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 21:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbiCDUOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiCDUNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:13:22 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02032399C3
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 12:07:47 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id t7so15498511ybi.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 12:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y5wxxRemu0yerGXHelC0GgimMvnnSAL2fxL75mZiEww=;
        b=OPPApgLQsNqLqSJCNzr71vmsdlSjeZvh8KxGH3zlvpwcwDReQJ++Cynpcb4RCG7QIl
         GGr2MMCaC/TJ7+Ga2yK7QFgtWc5ZbrtI+ZBxDWzXlvDg4CPsbSr9HbILWsk21M9El/lY
         8YcLSm9rTgrRMXPmrr+SCjzFarkS5f12d0A7ANZGy+vNczxhPj15m6TiwvH60pkPsQDc
         J+gNoUcffcSSjlCumDvRIBZBfXhMdOYt6ytvc6rVTfMNfTi+D4YCPXOiw7jcYAIeu0i0
         LHUDamH+pNUF9mDWME6NjY5XHasZXOis+VRsfaFNJXHcazvqCdkeglRlcR0QvHZt4llb
         biqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y5wxxRemu0yerGXHelC0GgimMvnnSAL2fxL75mZiEww=;
        b=JNz+AWRypwyvxskYS8xUxLTc9inYMENESJXkvApjIpVsCefPyKVM+x0uZ5CB56W8La
         AgpDfOoLzpxHZOEgJ37h5uFd3D5l1ghGuxvU0fgN4uSyHprjry4at5LBOe3tS2m2GnWX
         OQoweffH+x3qnnkKQd/p56T5aDRzDFsedAmtNwJJcqwdb9pBF+D4aS5po3ohPQ+7/Slp
         C94DhLs9kATsq2bThGjcbBlgCpDDaoN+gw9xRPnkekqOebBL/vfPDWMpfHYB47AqA+lM
         X2OO2A2DijB3KCi3Wc3vNR/dlm0P0mDYACiKWYJBsyzjh8z04UB/9jXV3YhXeE7b6rl6
         Lw/Q==
X-Gm-Message-State: AOAM5301PTIGvEyESbxQxQfBTK0N4cbRiuYaG3l6KXkDuTw/st7K9+VO
        kerFNNmgl8OIl4GlGNjcJYChlKwn0K6Wt3sMS938Lg==
X-Google-Smtp-Source: ABdhPJycg1+niiU14/sSOYE+8uBQeVbCwQkT8R4Um2dbCPLisZaTM6lzBzH8gQaUxtYXTlIqzCfCvKfY/DDVMfa2c5o=
X-Received: by 2002:a25:b991:0:b0:610:bf4e:1b33 with SMTP id
 r17-20020a25b991000000b00610bf4e1b33mr151686ybg.352.1646424448111; Fri, 04
 Mar 2022 12:07:28 -0800 (PST)
MIME-Version: 1.0
References: <13c6c9a2-6db5-c3bf-349b-4c127ad3496a@axentia.se>
 <CAGETcx_yDtX0m4gVKahABvKamUtGg2adL1+6=gwb4U=KEhwm7w@mail.gmail.com>
 <69bb004f-0bb4-ec56-479c-5deab0ece00f@axentia.se> <CAGETcx8Bppn1y3Hffp2N_DPcJA6YyMEv1EFDTa1e1zOrkxbxzw@mail.gmail.com>
 <f91c6f22-67a4-076d-d86d-6be1d14bc18a@axentia.se> <7edb467a-c8b4-fe29-9947-f71c655caa9f@axentia.se>
In-Reply-To: <7edb467a-c8b4-fe29-9947-f71c655caa9f@axentia.se>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 4 Mar 2022 12:06:52 -0800
Message-ID: <CAGETcx_Mod=ZEn_C12knStvfW5KSnA6=LU+YbG=QV-tFHE+onw@mail.gmail.com>
Subject: Re: Regression: memory corruption on Atmel SAMA5D31
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <Ludovic.Desroches@microchip.com>,
        Daniels Umanovskis <du@axentia.se>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 4, 2022 at 2:57 AM Peter Rosin <peda@axentia.se> wrote:
>
> On 2022-03-04 07:57, Peter Rosin wrote:
> > On 2022-03-04 04:55, Saravana Kannan wrote:
> >> On Thu, Mar 3, 2022 at 1:17 AM Peter Rosin <peda@axentia.se> wrote:
> >>>
> >>> On 2022-03-03 04:02, Saravana Kannan wrote:
> >>>> On Wed, Mar 2, 2022 at 4:29 PM Peter Rosin <peda@axentia.se> wrote:
> >>>>>
> >>>>> Hi!
> >>>>>
> >>>>> I'm seeing a weird problem, and I'd like some help with further
> >>>>> things to try in order to track down what's going on. I have
> >>>>> bisected the issue to
> >>>>>
> >>>>> f9aa460672c9 ("driver core: Refactor fw_devlink feature")
> >>>>
> >>>> I skimmed through your email and I'll read it more closely tomorrow,
> >>>> but it wasn't clear if you see this on Linus's tip of the tree too.
> >>>> Asking because of:
> >>>> https://lore.kernel.org/lkml/20210930085714.2057460-1-yangyingliang@=
huawei.com/
> >>>>
> >>>> Also, a couple of other data points that _might_ help. Try kernel
> >>>> command line option fw_devlink=3Dpermissive vs fw_devlink=3Don (I fo=
rget
> >>>> if this was the default by 5.10) vs fw_devlink=3Doff.
> >>>>
> >>>> I'm expecting "off" to fix the issue for you. But if permissive vs o=
n
> >>>> shows a difference driver issues would start becoming a real
> >>>> possibility.
> >>>>
> >>>> -Saravana
> >>>
> >>> Thanks for the quick reply! I don't think I tested the very tip of
> >>> Linus tree before, only latest rc or something like that, but now I
> >>> have. I.e.
> >>>
> >>> 5859a2b19911 ("Merge branch 'ucount-rlimit-fixes-for-v5.17' of git://=
git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace")
> >>>
> >>> It would have been typical if an issue that existed for a couple of
> >>> years had been fixed the last few weeks, but alas, no.
> >>>
> >>> On that kernel, and with whatever the default fw_devlink value is, th=
e
> >>
> >> It's fw_devlink=3Don by default from at least 5.12-rc4 or so.
> >>
> >>> issue is there. It's a bit hard to tell if the incident probability
> >>> is the same when trying fw_devlink arguments, but roughly so, and I
> >>> do not have to wait for long to get a bad hash with the first
> >>> reproducer
> >>>
> >>>    while :; do cat testfile | sha256sum; done
> >>>
> >>> The output is typical:
> >>> 78464c59faa203413aceb5f75de85bbf4cde64f21b2d0449a2d72cd2aadac2a3  -
> >>> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
> >>> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
> >>> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
> >>> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
> >>> e03c5524ac6d16622b6c43f917aae730bc0793643f461253c4646b860c1a7215  -
> >>> 1b8db6218f481cb8e4316c26118918359e764cc2c29393fd9ef4f2730274bb00  -
> >>> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
> >>> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
> >>> 7d60bf848911d3b919d26941be33c928c666e9e5666f392d905af2d62d400570  -
> >>> 212e1fe02c24134857ffb098f1834a2d87c655e0e5b9e08d4929f49a070be97c  -
> >>> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
> >>> 7e33e751eb99a0f63b4f7d64b0a24f3306ffaf7c4bc4b27b82e5886c8ea31bc3  -
> >>> d7a1f08aa9d0374d46d828fc3582f5927e076ff229b38c28089007cd0599c645  -
> >>> 4fc963b7c7b14df9d669500f7c062bf378ff2751f705bb91eecd20d2f896f6fe  -
> >>> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
> >>> 9360d886046c12d983b8bc73dd22302c57b0aafe58215700604fa977b4715fbe  -
> >>> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
> >>>
> >>> Setting fw_devlink=3Doff makes no difference, AFAICT.
> >>
> >> By this, I'm assuming you set fw_devlink=3Doff in the kernel command
> >> line and you still saw the corruption.
> >
> > Yes. On a bad kernel it's the same with all of the following kernel
> > command lines.
> >
> > console=3DttyS0,115200 rw oops=3Dpanic panic=3D30 fw_devlink=3Don ip=3D=
none root=3Dubi0:rootfs ubi.mtd=3D6 rootfstype=3Dubifs noinitrd mtdparts=3D=
atmel_nand:256k(at91bootstrap),384k(barebox),256k@768k(bareboxenv),256k(bar=
eboxenv2),128k@1536k(oftree),5M@2M(kernel),248M@8M(rootfs),-@256M(ovlfs)
> >
> > console=3DttyS0,115200 rw oops=3Dpanic panic=3D30 fw_devlink=3Doff ip=
=3Dnone root=3Dubi0:rootfs ubi.mtd=3D6 rootfstype=3Dubifs noinitrd mtdparts=
=3Datmel_nand:256k(at91bootstrap),384k(barebox),256k@768k(bareboxenv),256k(=
bareboxenv2),128k@1536k(oftree),5M@2M(kernel),248M@8M(rootfs),-@256M(ovlfs)
> >
> > console=3DttyS0,115200 rw oops=3Dpanic panic=3D30 fw_devlink=3Dpermissi=
ve ip=3Dnone root=3Dubi0:rootfs ubi.mtd=3D6 rootfstype=3Dubifs noinitrd mtd=
parts=3Datmel_nand:256k(at91bootstrap),384k(barebox),256k@768k(bareboxenv),=
256k(bareboxenv2),128k@1536k(oftree),5M@2M(kernel),248M@8M(rootfs),-@256M(o=
vlfs)
> >
> >> If that's the case, I can't see how this could possibly have anything
> >> to do with:
> >> f9aa460672c9 ("driver core: Refactor fw_devlink feature")
> >>
> >> If you look at fw_devlink_link_device(), you'll see that the function
> >> is NOP if fw_devlink=3Doff (the !fw_devlink_flags check). And from
> >> there, the rest of the code in the series doesn't run because more
> >> fields wouldn't get set, etc. That pretty much disables ALL the code
> >> in the entire series. The only remaining diff would be header file
> >> changes where I add/remove fields. But that's unlikely to cause any
> >> issues here because I'm either deleting fields that aren't used or
> >> adding fields that won't be used (with fw_devlink=3Doff). I think the
> >> patch was just causing enough timing changes that it's masking the
> >> real issue.
> >
> > When I compare fw_devlink_link_device() from before and after
> > f9aa460672c9 ("driver core: Refactor fw_devlink feature")
> > I notice that you also removed an unconditional call to
> > device_link_add_missing_supplier_links() that was live before,
> > regardless of any fw_devlink parameter.
> >
> > I don't know if that's relevant. Is it?
> >
> > Not knowing this code at all, and without any serious attempt
> > at reading it, from here the comment of that removed function
> > sure looks like it might cause a different ordering before and
> > after the patch that is not restored with any fw_devlink
> > argument.
>
> It appears that the device_link_add_missing_supplier_links() difference
> is not relevant after all. What actually happened in the header file in
> the "bad" commit was that two fields were removed (none added). Like so:
>
>  struct dev_links_info {
>         struct list_head suppliers;
>         struct list_head consumers;
> -       struct list_head needs_suppliers;
>         struct list_head defer_sync;
> -       bool need_for_probe;
>         enum dl_dev_state status;
>  };
>
> If I restore those fields on a bad kernel, the issue is no longer
> visible. That is true for the first bad kernel, i.e.

Ha... I thought this might be a possibility but I wasn't sure. Which
is why I kinda left it at:
"The only remaining diff would be header file
changes where I add/remove fields. But that's unlikely to cause any
issues here because I'm either deleting fields that aren't used or
adding fields that won't be used (with fw_devlink=3Doff)."

Ok, at this point I'm going to ignore this thread. Call me out
explicitly if you want me to pay attention :)

-Saravana
