Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1A74E6B3C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 00:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355798AbiCXXco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 19:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355789AbiCXXcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 19:32:41 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDA6BB905
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 16:31:04 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id w27so10659823lfa.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 16:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zUdde2mcwvp5FLcF5BVkcO4uhR0gnw4uVhoG7NgX+Oc=;
        b=aXlO/WI50ZLLlXfIaFQuO8OH6UHPRUmwG/mj67PyZZTaqVIDV2iExtDNhL9St5OWwD
         wZrXN0NIa8HPAvrBbR0tG+ybkatyfhdjEdV7+vfLlO4Vtmq1Xz/eAKFNjtpsyP85EUpr
         X1eET4cd2plnz8W8LbmpqbroKj0rQeCZ1me68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zUdde2mcwvp5FLcF5BVkcO4uhR0gnw4uVhoG7NgX+Oc=;
        b=aFAObS04n7E4b4kISyKQUu73ZBCWRfZ9v/nEznghbgsJDlby8n2J38gEVVu62vRHDX
         2Y4ytwmxLsyxbZD/MoHXbEBbdkl7x5jCzjr/p8ALn28bOnE+Wh/snHQNkTdgFaW91MyG
         jUHEsQGzCxaF8X/nMLbvcJKIUaavNzlDNWYin/69MEmuh1VNs+5BzsAHCFJih4iZBWzP
         lXOZGODSoGNlhzEXtUNYQoPj7fuubTZYxnKQnyoUMIvhWMI5c/ZA5/pEBy94z8fDAWiw
         Qx+uB1Lt/eFBej8ZWgzf0021XBxY5/vUV8dsdTxl4Dyn6mMEjHtHCtoPdjROQVPpVtZx
         cKqQ==
X-Gm-Message-State: AOAM5307+OVNYlxNWYMCrElPswVr8vuEiH9+VFRKenS+dhwez7qKbM47
        kZRYArxpJfl8rwtMi2XBXjYiTfXI+tjIxql5TI8=
X-Google-Smtp-Source: ABdhPJy1y7HPhpLrXVapzIXPykhp3eBoeRvS9Mq9QCUaNg+Z1IUUboXXxSJmzDrLuqDbtHGDMvD15Q==
X-Received: by 2002:a05:6512:ad3:b0:44a:614e:9d4d with SMTP id n19-20020a0565120ad300b0044a614e9d4dmr3995285lfu.557.1648164662275;
        Thu, 24 Mar 2022 16:31:02 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id w19-20020a194913000000b0044821ce7e0fsm496161lfa.148.2022.03.24.16.31.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 16:31:01 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id s25so8223250lji.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 16:31:01 -0700 (PDT)
X-Received: by 2002:a05:651c:1213:b0:247:e2d9:cdda with SMTP id
 i19-20020a05651c121300b00247e2d9cddamr6055229lja.443.1648164660936; Thu, 24
 Mar 2022 16:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tytg5jd_i3z3C5Y1dii2-cgO11Gjgvaq8qoWn3CGfCreg@mail.gmail.com>
In-Reply-To: <CAPM=9tytg5jd_i3z3C5Y1dii2-cgO11Gjgvaq8qoWn3CGfCreg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Mar 2022 16:30:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wimbsaM03q_b2XNR0Aw13C8YoZ36KpyOgyYcefLbK_cGg@mail.gmail.com>
Message-ID: <CAHk-=wimbsaM03q_b2XNR0Aw13C8YoZ36KpyOgyYcefLbK_cGg@mail.gmail.com>
Subject: Re: [git pull] drm for 5.18-rc1
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Wed, Mar 23, 2022 at 7:30 PM Dave Airlie <airlied@gmail.com> wrote:
>
> This is the main drm pull request for 5.18.
>
> The summary changelog is below, lots of work all over,
> Intel improving DG2 support, amdkfd CRIU support, msm
> new hw support, and faster fbdev support.

Ok, so this was annoying.

I've merged it, but will note three things that I really hope get
fixed / checked:

 (1) My merge resolution looked mostly trivial, except for an annoying
conflict between commits

        4ed545e7d100 ("dt-bindings: display: mediatek: disp: split
each block to individual yaml")

and

        6d0990e6e844 ("media: dt-binding: mediatek: Get rid of
mediatek,larb for multimedia HW")

where one of them splits up a file that is modified by the other.

I ended up just getting rid of all the "mediatek,larb" mentions in the
split-up files, despite the fact that (a) those mentions can be found
elsewhere and (b) the split-up did other changes too, so maybe it's
wrong.

 (2) As Guenter reported, the fbdev performance improvement of
cfb_imageblit() is broken.

I was going to just revert it, but I see that there is a two-series
patch to fix it at

    https://lore.kernel.org/all/20220313192952.12058-1-tzimmermann@suse.de/

so I merged it in that broken form, in the hope that this set of fixes
will be sent to me asap.

 (3) Very similarly to (2), but broken mediatek DT files.

I hope my changes in (1) didn't make things worse, but there's a
series of fixes as

    https://lore.kernel.org/all/20220309134702.9942-1-jason-jh.lin@mediatek.com/

and again I hope I'll get those fixes from the proper places asap.

I considered just delaying merging this all entirely, but it seems
better to get this all in, with the known problems and known fixes,
and see if we hit something _else_ too.

Anyway, let's hope I didn't miss anything, and that those are the only
major issues.

                  Linus
