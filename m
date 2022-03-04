Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0809C4CD5B1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 14:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239483AbiCDN6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 08:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbiCDN6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 08:58:36 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE8A41987;
        Fri,  4 Mar 2022 05:57:48 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id c19so1091744ede.8;
        Fri, 04 Mar 2022 05:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V5nbFt1LWA85FHBfIJV2mdkXvx7kKnUB3QLf39i2vgo=;
        b=dfiW6zayWObNNgP6CwXoRoqBPxQY7wiOH6fO5BcJv1SFBtMs3lawe9zWEom/ZA7aBH
         8Ibt2l4mhRmBTn/p4d2gZRjOjY9oW2lorwlH1iXI36zdras/b3tM2DgdZ8qiarVig7lw
         RRA0Kjmp8Pecerkq4FxYMdJRh02wGi6c2e5uv4u87MDqGuYJoQTRJkgI8ahBUUxoJezx
         76fIf6aqcsk37nFQZhQhGoETN16DLwyp+zpFOXgGkFb8iedTs/zwYtzFakw0fu9wDK0S
         q2mk4Tz0Gkmv7tuD04DE7PXoZEO9+4ge3zHaMKEcpwFoiy2NxG51sf8pOrcnqwduqm5A
         ag4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V5nbFt1LWA85FHBfIJV2mdkXvx7kKnUB3QLf39i2vgo=;
        b=hchVs3naQ7eYZtNzOVEH5/bCkZXoxCZM5VHKbvqWnfNLuOED5AylYNfqqix/FH45C6
         leapeLTS6F9stoU+CE0tz6DnTs3V2OJr+DUFaa/VY0ZowILCv60N/RU2x+einlR0+wUy
         Raash52/94dmi3g4yrTCOPAgKvvjvhv1wfg5BeVrr7k9LHLCgcfcTVswJ5lZGMnfsLeG
         RaM2E5N/PvZCSulsr1Yp2St+a6QequRMzaQYjQ2WnhB8iOQjahatEM+vp06QGvKlOvTg
         /oAxDjJ9ZNYVHJZFQ/6FEXD79wi2tcAqvUC6BFtjf4ZEZxlpPioAUU2NkJdp+BMYIuEI
         9+6g==
X-Gm-Message-State: AOAM530ymgHmQRE7ePqNznInA8ARQcYQ7LFUAdAdcIqPLoNppN4AV759
        +CbKd1YpxtoGmWa5GemvDgAYJ4AYcw8F32JlC6k=
X-Google-Smtp-Source: ABdhPJxdG3SMoJqAwxqByNR7W2v4BfsToiquWcNDTtNN/tCIS1IlOQVTHwj1EIBbbth3+ximAA/li80riOI1yWn/CV8=
X-Received: by 2002:aa7:d543:0:b0:416:13eb:6fec with SMTP id
 u3-20020aa7d543000000b0041613eb6fecmr550878edr.348.1646402266648; Fri, 04 Mar
 2022 05:57:46 -0800 (PST)
MIME-Version: 1.0
References: <20200221195256.54016-1-tony@atomide.com> <20200221195256.54016-7-tony@atomide.com>
 <CAHCN7xJ0j4kZXiQs-5GrrKLxXYgkYJsnNDreH0MKi8mHPs_Xvw@mail.gmail.com> <YiG4O2h4oVX7CqIe@atomide.com>
In-Reply-To: <YiG4O2h4oVX7CqIe@atomide.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 4 Mar 2022 07:57:35 -0600
Message-ID: <CAHCN7xKL8x2=As35PG4T_qbgvqReVk8i_+SaibK9zF86+tGVZQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] bus: ti-sysc: Implement SoC revision handling
To:     Tony Lindgren <tony@atomide.com>
Cc:     Linux-OMAP <linux-omap@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?Q?Andr=C3=A9_Hentschel?= <nerv@dawncrow.de>,
        "H . Nikolaus Schaller" <hns@goldelico.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 4, 2022 at 12:57 AM Tony Lindgren <tony@atomide.com> wrote:
>
> Hi,
>
> * Adam Ford <aford173@gmail.com> [220302 14:37]:
> > I apologize for digging up an old thread, but I finally managed to get
> > my hands on an OMAP3503.  It seems like older kernels do not boot at
> > all or hang somewhere in the boot process.  I am still seeing a
> > difference in behavior between OMAP3503 and OMAP3530, where 3505
> > throws a bunch of splat and a kernel panic, while the 3530 appears to
> > boot happily.
> >
> > Using the latest 5.17-rc6, I had to remove some IVA and SGX references
> > from omap_l3_smx.h to get the 3503 to stop crashing on boot.
>
> OK interesting, I did not know those registers are not accessible
> on 3503.
>
> > Do you have any ideas how we can make the omap3_l3_app_bases and
> > omap3_l3_debug_bases more cleanly remove the IVA and SGX references
> > if/when OMAP3503 is detected?  I assume the same algorithm would have
> > to detect a AM3703 as well.  I'm trying to get my hands on an AM3703
> > to see if there is similar behavior as what I'm seeing on the
> > OMAP3503.
>
> As there are possibly multiple omap3 variants used on the same
> boards, we need to rely on the runtime detection of the SoC.
> So yeah soc_device_attribute is the way to go here.
>
> I don't recall any similar issues booting 3703 but it's been a while
> so worth testing for sure.

In addition to the OMAP3503, I managed to get an AM3703.  From what I
can tell, going back as far as kernel 4.9, the OMAP3503 does not boot
at all. I haven't tried the 4.4 since it's marked EOL at this point.

I have not started testing the AM3703 yet, but I think it would be a
good idea to backport this to stable at some point, since it appears
to fix a serious regression,  not booting.  I'm going to work on some
experiments with both the AM3703 and OMAP3503 to see what works, what
doesn't and I'm going try to come up with some ideas on how to address
the omap3_l3_app changes, but if you have any ideas on how to do it
cleanly, I'm open for suggestions.

adam
>
> Regards,
>
> Tony
