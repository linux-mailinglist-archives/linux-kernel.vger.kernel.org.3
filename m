Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C89509E4D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 13:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbiDULNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 07:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbiDULNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 07:13:46 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B29DF69
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 04:10:57 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d15so4510955pll.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 04:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5mDQNWE6CHbxD5RppFkYKwLi4HSMIbAeHaJuTv1BRD0=;
        b=joxbRWZL34N6wRmRFL2QNDESl9kKHHoFkc1TBgwu+vOWLqbwgebGY0J7IWsC8OOslo
         63Zae0O30/OtzO36UDhvAdh8gyewNzrbrj2obOs5mJwZTZZsbAHk2npZU7hsVtoaO3x2
         osrwOz0/jFx4rLKbiqrQ1wEq2YachOZLh966JhbWuH8gjTffQrekJ3eBKgJCUmE64rJX
         s+2+D906rSGh3+yZhvBMg8eHbyKPjRqzEPLUNKw3Ad2C+rvo5u32rrihqSq1I32gBSAj
         sqNWvJkqyMVWRCAZFcrcP8AhKgjGrFGuwbVweJEva+dzwMuDJFrWQiNW65CtqbBgjZ/o
         bKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5mDQNWE6CHbxD5RppFkYKwLi4HSMIbAeHaJuTv1BRD0=;
        b=CR038YMbr+YuJI9vSc8LC6Xkq5Os4wI7QYpja0sQs7vG1KoQuPLLhui+02pTDVDE3g
         rInYAFk1Kv7yAQ9M1pxNL2yo21NhwhoJlmMPwgkjxaawvW4qZ3O7Y+4ceSbBhfymvb95
         L5LZZYeAc8jeCbv1Qy2w4PzlrxsKWLytulYIP3zUi6fVxPq80rQRd0f6pzMKJl8aB+NI
         DyEDaRlXZT9M/8P3h/BqfC2/eCZ90UN1jzaODEblzTsNPldLrjvbGZlzbaqzJURjIJko
         xjHDaJgkIwsrvp+B20TGPocsXwtyyGi9vc1CgwxM7cNsZHOuQ5HAuRs2nntCtnXJmpHm
         gIag==
X-Gm-Message-State: AOAM5312kBsPYNh0pp/qVqfLdsKiVVI/Kk++xaR304JYUbuZ92HV8UFD
        eoiPf3Za2NY1J9w2k9VmZvhj+M+7oUeTP67mdTs=
X-Google-Smtp-Source: ABdhPJzBAjIJ/bWhTBjQlovjTGFiTqWvWgSvsp2xnthBIu2Xzx4vXVzEqaIo6lVNO66mFWxCZ6tswhnESYJYESjQ83Q=
X-Received: by 2002:a17:90a:3e48:b0:1cd:34ec:c72f with SMTP id
 t8-20020a17090a3e4800b001cd34ecc72fmr9897582pjm.65.1650539456849; Thu, 21 Apr
 2022 04:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220409042321.3184493-1-james.hilliard1@gmail.com>
 <CAMeQTsanEow=zq=MuZLjMqpzybdS=5S0=JrkxuCdT7d5MxpEWQ@mail.gmail.com>
 <CADvTj4rBKzGFch8iVzHu1s+6=P0PcLEwoFi74xd_ormEX+2rMA@mail.gmail.com>
 <CAMeQTsaM363n5F=--xhSTayFqOMNvjTQjqz_aEhby6i-KRVBKQ@mail.gmail.com>
 <CADvTj4o_zyVZxaBz0+kRUF30OW3SKFMuo87r6FE9Qkfn1dVsBw@mail.gmail.com>
 <CAMeQTsbKMxQcDsDRqHsMwqU1BnrcOLwtU7uOrB-1E0z65P79-w@mail.gmail.com>
 <CADvTj4rR5zt5iFTDrrYfNQ267KV896dHnjJHx6yq=e10+V_Okg@mail.gmail.com>
 <CAMeQTsZyp40ybkNxnYDCR=pvXRzWvtBLkT+i4VPyjNiwwWg0-A@mail.gmail.com> <CADvTj4rtFzOSCG0nPCTxqhNfVcDLX3JuY4QGTS24m79VGWfWVQ@mail.gmail.com>
In-Reply-To: <CADvTj4rtFzOSCG0nPCTxqhNfVcDLX3JuY4QGTS24m79VGWfWVQ@mail.gmail.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Thu, 21 Apr 2022 13:10:44 +0200
Message-ID: <CAMeQTsYA_9MFDLAFoPKnQYsq3sRgJjFOwYO0K_9zbwfkm9EW0g@mail.gmail.com>
Subject: Re: [PATCH v3] drm/gma500: depend on framebuffer
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 1:42 AM James Hilliard
<james.hilliard1@gmail.com> wrote:
>
> On Tue, Apr 12, 2022 at 3:30 AM Patrik Jakobsson
> <patrik.r.jakobsson@gmail.com> wrote:
> >
> > On Tue, Apr 12, 2022 at 3:48 AM James Hilliard
> > <james.hilliard1@gmail.com> wrote:
> > >
> > > On Mon, Apr 11, 2022 at 3:27 AM Patrik Jakobsson
> > > <patrik.r.jakobsson@gmail.com> wrote:
> > > >
> > > > On Sun, Apr 10, 2022 at 10:05 PM James Hilliard
> > > > <james.hilliard1@gmail.com> wrote:
> > > > >
> > > > > On Sun, Apr 10, 2022 at 1:52 PM Patrik Jakobsson
> > > > > <patrik.r.jakobsson@gmail.com> wrote:
> > > > > >
> > > > > > On Sun, Apr 10, 2022 at 9:40 PM James Hilliard
> > > > > > <james.hilliard1@gmail.com> wrote:
> > > > > > >
> > > > > > > On Sun, Apr 10, 2022 at 1:36 PM Patrik Jakobsson
> > > > > > > <patrik.r.jakobsson@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Sat, Apr 9, 2022 at 6:23 AM James Hilliard <james.hilliard1@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > Select the efi framebuffer if efi is enabled.
> > > > > > > > >
> > > > > > > > > This appears to be needed for video output to function correctly.
> > > > > > > > >
> > > > > > > > > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > > > > > > >
> > > > > > > > Hi James,
> > > > > > > > EFI_FB is its own driver and not needed by gma500 to drive its
> > > > > > > > hardware. What makes you think it's required?
> > > > > > >
> > > > > > > I wasn't getting any HDMI video output without it enabled for some reason,
> > > > > > > I assume it is doing some sort of initialization needed by gma500
> > > > > > > during startup.
> > > > > >
> > > > > > Then it sounds like you might just be using EFI_FB and not gma500. Can
> > > > > > you provide the kernel log with drm.debug=0x1f set on kernel
> > > > > > command-line.
> > > > >
> > > > > Seems efifb loads first and then hands off to gma500
> > > >
> > > > That is how it normally works but efifb shouldn't change the state of
> > > > the currently set mode so shouldn't affect gma500.
> > > > From the logs I can see that you have LVDS (internal panel), HDMI and
> > > > DP (3 displays in total) connected. This sounds wrong. Your version of
> > > > gma500 (Cedarview) doesn't support more than 2 crtcs/pipes. This might
> > > > be a problem.
> > >
> > > Yeah, there's a bug there with the connector status, only DVI-D-1 is actually
> > > connected, I have DP-2 and LVDS-1 turned off in weston.
> >
> > Ok, but are the connectors physically connected to anything?
>
> There is one HDMI cable physically connected to the board
>
> > Regardless of what you do in Weston, the connectors shouldn't be
> > getting modes if they aren't used.
>
> Yeah, it seems there's a bug there, not sure if that's related to the
> output failure when efifb isn't available.
>
> > LVDS might be from VBIOS but I'm
> > not sure where the DP modes come from. It would help if you also
> > provide kernel logs with drm.debug=0x1f when the outputs doesn't work
> > so I have something to compare with.
>
> Log with efifb/fb not enabled in kernel build which causes no
> HDMI output:

After examining the logs I cannot see anything that stands out except
for fbdev emulation not being enabled. Are you sure you just don't
need to compile your kernel with FB support (CONFIG_FB)? If you are
running weston on the fbdev backend then you would obviously not get
any output if FB is not compiled into the kernel.
