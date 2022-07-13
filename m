Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A841573F20
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 23:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236836AbiGMVpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 17:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiGMVpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 17:45:34 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F643C169
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:45:33 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id k30so40567edk.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xryg/wyAEmcgAFZe/2FGYSAJQ5pYUeWTkKhjNYqQp04=;
        b=AdGnrzwQyk+BkYsu8V/E2oDFORdr7gasa29EuHtC3fdSF1wxQ97TWw10RMsUyVPeyi
         paiwWxijYZ/Ejbq7QJuQopODRVp8UWSEJdxm02AltWOPBW7jgLsV7cb8ILrX8QKcATKk
         7ekEPZGvOkl5y4D2u7O1u+O6jffe3hJs6QRik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xryg/wyAEmcgAFZe/2FGYSAJQ5pYUeWTkKhjNYqQp04=;
        b=sr6k20JWc1Y30sMS8nBwJuT+RNIe1pwN2wx5FQYzOigeZ98yNhxSqSunVHpheKQ+GM
         nqAdweRbA+dpfDuZ+YG4g8XyxL7HRHBxTbONiQnVOM7j8WM11MSYZ2Hh4KiJYsGrcHvF
         bS0oALWVHSHrp7LjfqbCCq+FKUY9uZYbl+mkZkAwL/y3vQILCLREkAJqf2L2enQy6W3X
         juVW7rgMA64htKxbDqAIPrsgZ5+PcIOuZOIThg8FuI8fant+Oh1Xwrqt/nOxcmOEoQq1
         HTLh6/d7L/d0b2LakMNe+3KvnQEdRkAv1Wb0ta9XbrB1nqkywaSZZDfZPsFFkSHxyXcl
         TEeg==
X-Gm-Message-State: AJIora94B7/l8muU3Kd0VrqbcW6S+Ge3M6oj6vNCKVcmPLR2hQPZE1W7
        gz3HOWwL1R6G2tX6R4LqUn+YhWMwtjKhGxhJdFU=
X-Google-Smtp-Source: AGRyM1tdlm2RItsOgOVwDci+As863XFyU/v8GevUt25TwdzaN7sj/QdeetvZCs4Gyu2+ODs6KBAMXg==
X-Received: by 2002:a05:6402:40ce:b0:43a:918d:a73f with SMTP id z14-20020a05640240ce00b0043a918da73fmr7827338edb.387.1657748731466;
        Wed, 13 Jul 2022 14:45:31 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id fn15-20020a1709069d0f00b006fecf74395bsm5419511ejc.8.2022.07.13.14.45.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 14:45:31 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id 9-20020a1c0209000000b003a2dfdebe47so1992222wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:45:30 -0700 (PDT)
X-Received: by 2002:a1c:4455:0:b0:3a2:d929:917a with SMTP id
 r82-20020a1c4455000000b003a2d929917amr5761713wma.38.1657748730445; Wed, 13
 Jul 2022 14:45:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net> <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <Ys8hqoiN5iWbslsM@shell.armlinux.org.uk> <CAHk-=wjNxyXQqn=k0KipzUPoBYWQhUwybxee8GTkF_Oz6RPVFw@mail.gmail.com>
 <CADVatmMJ4f+3-z1SWOSXuygee3fMsLqjcWhEY=NLhSCj61OB5Q@mail.gmail.com>
In-Reply-To: <CADVatmMJ4f+3-z1SWOSXuygee3fMsLqjcWhEY=NLhSCj61OB5Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Jul 2022 14:45:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgUGp96_Wup3=Utws=Mn+07vi7ZXknv4nKZkAJv8Ezhnw@mail.gmail.com>
Message-ID: <CAHk-=wgUGp96_Wup3=Utws=Mn+07vi7ZXknv4nKZkAJv8Ezhnw@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Guenter Roeck <linux@roeck-us.net>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 2:36 PM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> > >
> > > https://lore.kernel.org/all/20220524025139.40212-1-wangkefeng.wang@huawei.com/
> >
> > That patch looks sane to me, but I guess Guenter would need to check
>
> I still see the failure in my builds with this patch. But surprisingly
> I dont see the build failure (with or without this patch) with gcc-12,
> only with gcc-11.

Arrghs. "build failure"?

So is there another problem than the runtime issue that Guenter reports:

  OF: amba_device_add() failed (-19) for /amba/smc@10100000

in this area? That patch looks harmless from a build standpoint, but
that's not saying much, so can you please quote the actual build
failure here?

                  Linus
