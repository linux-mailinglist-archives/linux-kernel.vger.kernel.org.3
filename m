Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A9656BDDC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238585AbiGHPtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 11:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238358AbiGHPs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:48:58 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1292610B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 08:48:57 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a9so8653737ejf.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 08:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j+o9UFkr4miZ6ZJbv7jIOMm65fDIfcGoDCu77QllkD8=;
        b=Vf6J5lrdT2e0t9YKquocE6p1+bGCXw6F1c+2Qci6EmZi70bVMm5E4XZS4x/EfnpOj9
         u05z08rhPvF5VZpVwFIA1j8Lr/jyVttU7ZvnV9tgPOBvLMi7bNMoRSdriFc4uDFF3f7x
         aHRh9VYizgSYoF0131drXiCaMsVbJOzyo4zNYmjKWoytlApkqX7hVt2xrK/dsdWuYV9Q
         OFAXaUHW437J859SxB+Leonk0Sl1vZttUylRiZGcminEHB070sinyZX1LflXRoK3PUew
         wBtKD/jhF7jSPhppXOu2000CSzd7sj4RiRkKX+dT/izGsog0I3Mxz5ZihYEPQTnZZoh+
         Nqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j+o9UFkr4miZ6ZJbv7jIOMm65fDIfcGoDCu77QllkD8=;
        b=pr1R4joNktGMc7H3ehm8NR94TDxvrh9L3/Ii1PlX4dtLKrDoWxUFkZey2Ioy2WrS61
         FLRyKwGcv0I9Dz/+IvUCB0LFXVFESIDPyjZySfAcs+Sd24wIgVSh6UD8X/KRhE2VUU6C
         DanMoAvZI3b8NkpvoGC7NqmJ4bJ+CskT9EjZANNDNAdk1d50QGkDPnUXTaL8WVIZPydY
         AiMWgLi4G0O/GOmZ7mz+F5rUwpVsmHEgeg3m75lvFGpudnK59xQ555k/m8SVq69iyTgA
         saOGPRgz4gEEF92D35jkyv/g4s+gcs81G4qi64G3vMImfQXMpnYWrl5VoHOIuiFh5DIO
         ShmQ==
X-Gm-Message-State: AJIora8RGx9T25smvZRQspvil/Ik8XkoP+TfcxLJbnM0kE0sIbO2b1Mp
        mO/ciJNB86UPIwkkj2U2hSppbqHD1CvZ5fzkb1WUxA==
X-Google-Smtp-Source: AGRyM1vn3WWbG5xseO7A/ootbQ5rPnYmuU7wj8wUNkHcp3HiF7KweWR7h/oruLE4pVAZ4aw0zsvqwjpJnSc0j8/XOFU=
X-Received: by 2002:a17:907:8a25:b0:726:c9f2:2f5e with SMTP id
 sc37-20020a1709078a2500b00726c9f22f5emr4230156ejc.286.1657295336291; Fri, 08
 Jul 2022 08:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <585795d19c13a7136bc4b61307114591af2aea69.1657279521.git.viresh.kumar@linaro.org>
 <CAMRc=MdHAZ=OE+jjxx5BV_4Z2L4g0WmEVaiyifN+nu2JnMx82g@mail.gmail.com> <CAHp75VdWe_EaJB3Bqz13rb362uDBTJAGaVh7Sjeq874tm=wrgA@mail.gmail.com>
In-Reply-To: <CAHp75VdWe_EaJB3Bqz13rb362uDBTJAGaVh7Sjeq874tm=wrgA@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 8 Jul 2022 17:48:45 +0200
Message-ID: <CAMRc=MeePjCDagyAO6K3GrL5zjaygtsAP8P9+prG5Dq+BDg6-g@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: cdev: Don't access uninitialized descriptor
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 8, 2022 at 5:14 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Jul 8, 2022 at 3:32 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > On Fri, Jul 8, 2022 at 1:25 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> ...
>
> > Kent beat you to it with commit c8e27a4a5136e7230f9e4ffcf132705bf56864cc.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c8e27a4a5136e7230f9e4ffcf132705bf56864cc
> Notice: this object is not reachable from any branch.
>
> Rebased?
>
> --
> With Best Regards,
> Andy Shevchenko

It's in next and I just sent it out to Torvalds too.

Bart
