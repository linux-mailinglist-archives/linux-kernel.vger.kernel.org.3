Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64C0575371
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbiGNQxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiGNQxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:53:02 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D8FCD9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:53:01 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id z23so4470435eju.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5tuLjpCGqWrD227/QGgnnSNYGLhT/vS01RvkkxDi7L4=;
        b=TZsJ1ETna5AdZ9RUaz3BU1K06a0qxx7Lmc2KWmixjNCYKF3jI7BxPIkOC+Qj9zRghD
         l5Fzn3Y+T7eKxPuPwxN0jxHkTm41clKD/a8wI1pJgiL/4tmWdd445WFkkX0UqpDwfaf8
         CKfI6AxIl1ahxJJsc0V60tRZUco7YXkim060eyE6tKzRBriKRtH4Z7Wa9bOvdMCtinni
         vX425htCQlkf/N27mVBvwst5puJ+li9xAb+yGkzWhtCGb2svRSOBLT41f7lCmYGzntMb
         otwXLl9V2CK7fMSE6XByhfZjAmQBIohjqk3qCbdzLbsSRI3gYX7IIBolcdEiLqOSX86j
         1lXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5tuLjpCGqWrD227/QGgnnSNYGLhT/vS01RvkkxDi7L4=;
        b=DoPvxXoXIm+bp3wTGV/G3LTkjPUMjiA3woa8Hlqk6WV2J2FwZgi17dff5SVHiNPcip
         flPiZ0i7Q22DZLjA/3HpC4hS3SgpPPw7lclOfcGvElTQGjtV28ELmeXrKWu4WhKpvxLV
         YFCT7utPWgIXA5b2x5U3U9qQUYR8TEmrLjW2aV72Eg/Y570LV0gpM9iQ5oOZEUK6olE2
         cIJ2S4JHAxGVRUsqCNrrQWGxtz8e84uSCapZxrSSbXTTqrUUmY5MvHi3D/SxNSTSrSwl
         YBFNgtrXHhhdraoBBHAB6/VvzuMSI/gP9AGguFn3BB9V+O78rBk0MTx4usJECpucGlEl
         Bypw==
X-Gm-Message-State: AJIora8GjWLXpYeqqpbF9EMP1XDMAGEJG9q4hC2M/i8x/wY+ktXa/dYu
        3czMemLwmlqwU8CXGUREvGw3kFRVPam7NA/YoiA=
X-Google-Smtp-Source: AGRyM1s6mcagDQ5ljN0eoYPPZCg+A/DFYjmUcK2ayLILrDu7Mxf2FI+04Gck13f6BKZ8622WE2PUCMXV5IU5gO/KDgw=
X-Received: by 2002:a17:907:2702:b0:72b:307b:98e6 with SMTP id
 w2-20020a170907270200b0072b307b98e6mr9697124ejk.658.1657817580248; Thu, 14
 Jul 2022 09:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net> <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <a804b76e-159f-dbc2-f8dc-62a58552e88d@roeck-us.net> <CADnq5_O6Tp2QPXyDCvpWuRXhDr6H1PM50Ow5YG2WeukqUd-GnQ@mail.gmail.com>
 <CAHk-=wj4+BSj2SPMRUr-TZ4Qg2o9HGOBWiJQE336YcF_U1sVNQ@mail.gmail.com>
In-Reply-To: <CAHk-=wj4+BSj2SPMRUr-TZ4Qg2o9HGOBWiJQE336YcF_U1sVNQ@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Jul 2022 12:52:48 -0400
Message-ID: <CADnq5_ME1DsZsmC1NbHOyzfKbBp_jcKycG7Fh1HMN8y3AejWKg@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 5:32 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Jul 13, 2022 at 2:01 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > If you want to apply Guenter's patch original patch:
> > https://patchwork.freedesktop.org/patch/490184/
> > That's fine with me.
>
> Honestly, by this time I feel that it's too little, too late.
>
> The ppc people apparently didn't care at all about the fact that this
> driver didn't compile.
>
> At least Michael Ellerman and Daniel Axtens were cc'd on that thread
> with the proposed fix originally.
>
> I don't see any replies from ppc people as to why it happened, even
> though apparently a bog-standard "make allmodconfig" just doesn't
> build.
>
> I'd try it myself, since I do have a cross-build environment for some
> earlier cross-build verification I did.
>
> But since my upgrade to F36 it now uses gcc-12, and possibly due to
> that I get hundreds of errors long before I get to any drm drivers:
>
>   Cannot find symbol for section 19: .text.create_section_mapping.
>   arch/powerpc/mm/mem.o: failed
>   ...
>   Cannot find symbol for section 19: .text.cpu_show_meltdown.
>   drivers/base/cpu.o: failed
>   Error: External symbol 'memset' referenced from prom_init.c
>
> this cross environment used to work for me, but something changed (I
> mention gcc-12, but honestly, that's based on nothing at all, except
> for the few problems it caused on x86-64. It could be something
> entirely unrelated, but it does look like some bad interaction with
> -ffunction-sections).
>
> So considering that the ppc people ignored this whole issue since the
> merge window, I think it's entirely unreasonable to then apply a
> ppc-specific patch for this at this time, when people literally asked
> "why is this needed", and there was no reply from the powerpc side.
>
> Does any of that sound like "we should support this driver on powerpc" to you?

Fair enough.  I don't have a strong opinion on the matter.  Users will
hopefully likely notice the failure after release because most people
don't test until after a release and then we'll apply the fix and
re-enable it for 5.20 so that would leave 5.19 broken for PPC64 users
which would not be ideal.  But as you said, no one has cared up to
this point.

Alex

>
>                  Linus
