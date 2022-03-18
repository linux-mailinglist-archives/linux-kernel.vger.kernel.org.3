Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4704DDB3B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237045AbiCROIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237031AbiCROIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:08:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34BF32FFDD
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 07:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647612429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=maHIdBZx2FrOp6S6njvn7N4QHjRKBaOIDNVSSeHFgSg=;
        b=MraOSWioyRz/Xss9ez0IEH0QQeQDdJZIwPa8qFxtm1ekJyc1VhJTdjdv9GBANBSwe865Y7
        hJ3pQqzzNqJ8T/zMGvzIqi3Yv8t/PXFY11IbTclTD+U8vuW5RK0oybJ8bo1kPDuDKm7D2i
        jSKowNWIlQfNSeTwV2qiUaJjzoJ/yZ0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-lZhfa5p0PPe1bj80Zt2hyw-1; Fri, 18 Mar 2022 10:07:07 -0400
X-MC-Unique: lZhfa5p0PPe1bj80Zt2hyw-1
Received: by mail-pj1-f71.google.com with SMTP id o12-20020a17090a420c00b001c65aec76c0so4582637pjg.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 07:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=maHIdBZx2FrOp6S6njvn7N4QHjRKBaOIDNVSSeHFgSg=;
        b=nC9poYyvUIptMuX+17o83L7i7o0b/GyszEMPGz/laeXgL5DfuPRMftlJE4OMKO2AtX
         OIUJ+erU6Mu8BRS6pO7yVwwErdc03h5y2GSr7xKYucSlCBt8tt2BNA09xeDixq9vNCjv
         eJqZWDZJY5zK/WEfSiNn+iMQM0pB/zENs0wQK1YG07zpSH3Y6bn4S4zXGOxqDhpzJhrM
         GXiUDy642h7s2j3D8mUcTiJX8ipQKiSDySzC17mqv2kjKFUcyiXojRv3nLepa+hvwC2I
         WN6FZ7awWS9QZwHnevWxvXBZHT/NtrvkgS1sQ+JisYlMNPUY6JWmo5SCPuHedAr5hxLJ
         Eu0A==
X-Gm-Message-State: AOAM531RNnPyOY4UAdboK2ntpv3kENmmHidNBsybHi3lad6+1Wg1FQC8
        K4dSYpQwmbRJgAF9rIyjrDIojRL93j8xkXNpyLVrvksm8nPp0zuBKgE9gWihiR1ZHMeaOLYUFu4
        FMO9YPXlo8hJUtOS7eHrMIjtTyT9zJ8ndURw6FMaF
X-Received: by 2002:a63:5110:0:b0:374:2312:1860 with SMTP id f16-20020a635110000000b0037423121860mr8066228pgb.146.1647612426657;
        Fri, 18 Mar 2022 07:07:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsiQTQGZVaHbS7Tn5Fqv9XAuJAKJo9F201eDLflW91uRj7iaAEtvNd77z2x3tm4LR4I1PVYq8KYvCF3gqUmg8=
X-Received: by 2002:a63:5110:0:b0:374:2312:1860 with SMTP id
 f16-20020a635110000000b0037423121860mr8066211pgb.146.1647612426384; Fri, 18
 Mar 2022 07:07:06 -0700 (PDT)
MIME-Version: 1.0
References: <s5htubv32s8.wl-tiwai@suse.de> <20220318130740.GA33535@elementary> <s5hlex72yno.wl-tiwai@suse.de>
In-Reply-To: <s5hlex72yno.wl-tiwai@suse.de>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 18 Mar 2022 15:06:55 +0100
Message-ID: <CAO-hwJK8QMjYhQAC8tp7hLWZjSB3JMBJXgpKmFZRSEqPUn3_iw@mail.gmail.com>
Subject: Re: [REGRESSION] Right touchpad button disabled on Dell 7750
To:     Takashi Iwai <tiwai@suse.de>
Cc:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        linux-input@vger.kernel.org,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Jiri Kosina <jkosina@suse.cz>, stable@vger.kernel.org,
        regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 2:11 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Fri, 18 Mar 2022 14:07:40 +0100,
> Jos=C3=A9 Exp=C3=B3sito wrote:
> >
> > Hi Takashi,
> >
> > Thanks for reporting the regression here.
> >
> > On Fri, Mar 18, 2022 at 12:42:31PM +0100, Takashi Iwai wrote:
> > > Hi,
> > >
> > > we received a bug report about the regression of the touchpad on Dell
> > > 7750 laptop, the right touchpad button is disabled on recent kernels:
> > >   https://bugzilla.suse.com/show_bug.cgi?id=3D1197243
> > >
> > > Note that it's a physical button, not a virtual clickpad button.
> > >
> > > The regression seems introduced by the upstream commit
> > > 37ef4c19b4c659926ce65a7ac709ceaefb211c40 ("Input: clear
> > > BTN_RIGHT/MIDDLE on buttonpads") that was backported to stable 5.16.x
> > > kernel.
> > >
> > > The device is managed by hid-multitouch driver, and the further
> > > investigation revealed that it's rather an incorrectly recognized
> > > buttonpad property; namely, ID_DG_BUTTONTYPE reports it being 0 =3D
> > > clickable touchpad although it's not.  I built a test kernel to ignor=
e
> > > this check and it was confirmed to make the right button working agai=
n
> > > by the reporter.

Yep, I came to the same conclusion this morning with the reporter of
the libinput bug Jos=C3=A9 was mentioning.

> > >
> > > Is this check really correct in general?  Or do we need some
> > > device-specific quirk?

The device firmware is clearly wrong here. It's the first time I see
this failing like that and I hope this is just an isolated case.
The device advertises itself as a buttonpad, when it's not.

However, the fact that it passed MS certification (even if I doubt
Microsoft ever got that touchpad in their own hands) leads me to
believe that the certification doesn't enforce that setting too much,
and that we might see more devices coming in with that same bug.

To sum up, I am not happy that this commit introduced a regression
that we can not work around in userspace: given that BTN_RIGHT gets
removed from the device, all of the values are filtered out and
userspace can not resolve that situation by itself.

I wish I had a better way of fixing this than having to quirk the device.

> >
> > A couple of days ago another user with the same laptop (Dell Precision
> > 7550 or 7750) emailed me to report the issue and I sent him a patch for
> > testing.
> >
> > I he confirms that the patch works, I'll send it to the mailing list.
> >
> > I believe that your analysis of the regression is correct and I think
> > that we'd need to add a quirk for the device.
> >
> > In case you want to have a look to the patch, I added it to this
> > libinput [1] report.
>
> Great, I'll try to build and ask the reporter to test with the patch.
>

As noticed on the libinput bug, I think the patch is wrong (not by a lot).
We should base the class on MT_CLS_WIN8, not MT_CLS_DEFAULT.

The testers might say that it's working, but this might create some
corner cases where it's not leading to more and more headaches with
your users.

Cheers,
Benjamin

> Thanks!
>
>
> Takashi
> >
> > Thanks,
> > Jose
> >
> > [1] https://gitlab.freedesktop.org/libinput/libinput/-/merge_requests/7=
26#note_1303623
> >
>

