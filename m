Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C5A501F29
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 01:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346098AbiDNXfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 19:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237892AbiDNXfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 19:35:17 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595A4AD125
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 16:32:51 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id a8so7626052ljq.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 16:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sa7u+ZRCHDwKgHlQLbM1vs4Jt2a53sPV1j8OeRq25D8=;
        b=eglZIE9MXugBNIfsVulolUvIIy8x+cjwaIDOUhzKbQivLhVwRamN5vM+bF4TeAuN5W
         K12uHIOCK7sGxGm+PUsF6/cUldQ+eDw7biDzolA0vbKfaF0aFR2xzUnniUfH1LQTu2R1
         vAf2hqcuUX7GHVmi3S2z8la2ROdTYKQsPich8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sa7u+ZRCHDwKgHlQLbM1vs4Jt2a53sPV1j8OeRq25D8=;
        b=ppj3pfzDUxep4Nule4PitjORfLTzLndDByTkRc8YHY0oRbOifbgI091W0EgXh+XLYL
         H/23/waNJzpH7v+GGcYwn7C4c+G4phXhLdzrjtxMGjAD0CRi/zAUH8Hg6fxuSlcBTzZ1
         mxNtw4XtRiS8V6epCA9GlHM7ACahEI2gWFzwbrIiegH+ccVOaOZjAq2/3Yfwy2/2LB7m
         Oeb3lYQeZdhWg8D4YHub2DVH8hW9kQtlg9b+We+tP1DofAfMeLufjcte6S8iDx8d9hs1
         eSNkiAs3SNQI3Hxky2lZ7x6blLFTLra+LUtT6W0aE+Ol/JT/QICRXNEdaQl93E5r/c3i
         OxdQ==
X-Gm-Message-State: AOAM530srIQSyNJ4e2IE6GOo6Hu8FxvU2t95G1rBGEMn19hdJalxExi7
        8OMU85Qd9Liubed7LLKTH/j0U9+GKgKHL5Nx
X-Google-Smtp-Source: ABdhPJysjVQCVLyVQUjeCyk9Ps5JbfS2ihlsmWefNz3Zoqe+jvxV3HhpTeQbbHi9GlYAMgbHUb7ubQ==
X-Received: by 2002:a2e:9ad3:0:b0:24b:59a5:ae9 with SMTP id p19-20020a2e9ad3000000b0024b59a50ae9mr2959961ljj.306.1649979169453;
        Thu, 14 Apr 2022 16:32:49 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id g21-20020a2e9395000000b0024da326f812sm88132ljh.118.2022.04.14.16.32.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 16:32:48 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id bn33so7858565ljb.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 16:32:48 -0700 (PDT)
X-Received: by 2002:a2e:a78d:0:b0:24b:62bc:28ab with SMTP id
 c13-20020a2ea78d000000b0024b62bc28abmr2836956ljf.164.1649979167688; Thu, 14
 Apr 2022 16:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tzmeDfgQ3VhutQWLcgVhodHJhGmzrjMTB=yvXOhwnw0CA@mail.gmail.com>
In-Reply-To: <CAPM=9tzmeDfgQ3VhutQWLcgVhodHJhGmzrjMTB=yvXOhwnw0CA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 14 Apr 2022 16:32:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh2kmGysfLOUHpWZXDEM6oNAQZw9k8pfbQgWg1conE66A@mail.gmail.com>
Message-ID: <CAHk-=wh2kmGysfLOUHpWZXDEM6oNAQZw9k8pfbQgWg1conE66A@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 5.18-rc3
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

On Thu, Apr 14, 2022 at 2:33 PM Dave Airlie <airlied@gmail.com> wrote:
>
>   git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-04-15

.. and since I'm  now back home, I can confirm that my boot-time splat
I saw before is all gone.

It presumably went away with the previous pull request already, but I
hadn't remembered to check the issue until this pull reminded me about
the issue.

Thanks,
                    Linus
