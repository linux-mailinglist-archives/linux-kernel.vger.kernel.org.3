Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3AE573DB6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 22:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237061AbiGMUWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 16:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236662AbiGMUWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 16:22:10 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6EE2E694
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 13:22:08 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id va17so21893913ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 13:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GJflsK92JuV59E3RXCQjvHWgsAc9fN7oPHKEHYO4/Yw=;
        b=Pf5e5dY4ycmPKNE+mP4Y1lGkQifW/vnVMda6koFE/ah0VebtYYKLeXhDl0yxQe5PN8
         Ov9ax8+x8Ob7EqWRSwBhLfOhk63lN23ULz/lIIuRWUQ9ib0LZZLoZI3TgLrOhA2Xefog
         AqJViDcTGsK2uzCBoJV5UDYv+qKYmCLgZGKss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GJflsK92JuV59E3RXCQjvHWgsAc9fN7oPHKEHYO4/Yw=;
        b=8KOGAuLk3vqsHesIqDQf8DsbaybOYBqKLfp1N0Bg28t2BiT+b+RuGgv6CH76Y64Llx
         UKkUuoeW3q698x0zTuu6l+P4W4MRIGpesXRL+72oEe0pI8zZrq6gZF/isEubW9p/NNdR
         bcLIAjzH5P6Gj1Nn42sCxxLUNL5QtWD8moLtLedNjeY+rnIGExO7GdB6h1Z/J5+lrltN
         luhikF0NA8EnDHx6oVskTQ6SOxqPaqEZ79INwC3DXFB9gNegLUGGWmoPzZvofJLikSdg
         ZN+cdkiRhurUe7SHCebKdfFzAi/JNC8gyKTo/N9BZzh/J8PZku++sh2mKILh+t4VCb77
         JJRQ==
X-Gm-Message-State: AJIora8DaU/OcAO7yEiUWvmux13q8UTq4Y26jVd48kFCFQgC5TH1I3as
        Lkey+sirXO8SmLb5QxcEWuyqc5kG8sSdh9QIIxY=
X-Google-Smtp-Source: AGRyM1uBwil10I/jdu5shLj49JWaVng8NYtELAGtzL//foLLyaXDY+W41P+Ek0g/0HZJiuSW7Py+KQ==
X-Received: by 2002:a17:906:4482:b0:70a:19e3:d18a with SMTP id y2-20020a170906448200b0070a19e3d18amr5235356ejo.510.1657743726888;
        Wed, 13 Jul 2022 13:22:06 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id pv5-20020a170907208500b0072af4af2f46sm5332152ejb.74.2022.07.13.13.22.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 13:22:05 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id a5so17039361wrx.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 13:22:05 -0700 (PDT)
X-Received: by 2002:a05:6000:180f:b0:21d:68f8:c4ac with SMTP id
 m15-20020a056000180f00b0021d68f8c4acmr5115827wrh.193.1657743724966; Wed, 13
 Jul 2022 13:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net> <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <Ys8hqoiN5iWbslsM@shell.armlinux.org.uk>
In-Reply-To: <Ys8hqoiN5iWbslsM@shell.armlinux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Jul 2022 13:21:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjNxyXQqn=k0KipzUPoBYWQhUwybxee8GTkF_Oz6RPVFw@mail.gmail.com>
Message-ID: <CAHk-=wjNxyXQqn=k0KipzUPoBYWQhUwybxee8GTkF_Oz6RPVFw@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Guenter Roeck <linux@roeck-us.net>,
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

On Wed, Jul 13, 2022 at 12:49 PM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> There may be a patch that solves that, but it's never been submitted to
> my patch system:
>
> https://lore.kernel.org/all/20220524025139.40212-1-wangkefeng.wang@huawei.com/

That patch looks sane to me, but I guess Guenter would need to check
... Guenter?

             Linus
