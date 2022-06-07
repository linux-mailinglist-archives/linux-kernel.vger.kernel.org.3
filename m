Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF12453FB16
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240930AbiFGKXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240914AbiFGKW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:22:59 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163A833E39
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:22:57 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id c144so10354140qkg.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 03:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ogveWgeE/FVBGqs6VUOZoS5JOHdjSLfC5uSmNP3+Doo=;
        b=RL0Wr/rMa+CC870hZDr+Ysfj5t6qyka+3Iu2uRmYdQzTcFOAujy6T4DM5gxMpVRwZf
         kYe6jO3vbgsmJ69Q/hMJsnwcHrtZg79vwmJwhFZMXybAPzKp4kbvXNFr1uRGf49gFwoQ
         kSbaxHeOWQlf4g1HJziF8SfRAKAxEb//Zi1M1FMkd1bGQihjeHZJoolzEu1SIV9xBDva
         jnmYE0HxQS0GkLt64vMMicpgSZrDIs4wyAID3VdY9JVZcyUISDoxR7pOIILEZ14a5Ijo
         BwMkBIUrTDQGF+Q+E5Z+yBb4r02+WHymQXJBTiCYPoqWYxWblGi80aFhVWk/aslwBSbu
         /7Mw==
X-Gm-Message-State: AOAM530gZfokwt9lJIuYIVVbf33M7lDza6CxRUUpozMbnDbKZSnCPJt0
        8G8077heXzRczIZKgL55zU20rAo8ZNXDGQ==
X-Google-Smtp-Source: ABdhPJwZymQIRsvzf3CVQP0bGY/tlg/s2Hmu9EEzAzIZa2hcJYr6T3N3LH5R1AzFO8KQgS9yDbkLVQ==
X-Received: by 2002:a05:620a:29c9:b0:6a6:4f4d:637e with SMTP id s9-20020a05620a29c900b006a64f4d637emr18542365qkp.43.1654597376091;
        Tue, 07 Jun 2022 03:22:56 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id i20-20020a05620a249400b006a3296726e2sm2939256qkn.43.2022.06.07.03.22.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 03:22:55 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id l204so30341405ybf.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 03:22:55 -0700 (PDT)
X-Received: by 2002:a05:6902:120e:b0:634:6f29:6b84 with SMTP id
 s14-20020a056902120e00b006346f296b84mr30096899ybu.604.1654597375274; Tue, 07
 Jun 2022 03:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tw62EZfAm0PbiOPmMrpfR98QMFTWGEQcA34G4ap4xxNkA@mail.gmail.com>
In-Reply-To: <CAPM=9tw62EZfAm0PbiOPmMrpfR98QMFTWGEQcA34G4ap4xxNkA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Jun 2022 12:22:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXb5-gOVRsQx6tDqjQMD9cC-p=o56VuF2cBPWyMFRgHMA@mail.gmail.com>
Message-ID: <CAMuHMdXb5-gOVRsQx6tDqjQMD9cC-p=o56VuF2cBPWyMFRgHMA@mail.gmail.com>
Subject: Re: [git pull] drm for 5.19-rc1
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave.

On Wed, May 25, 2022 at 4:49 PM Dave Airlie <airlied@gmail.com> wrote:
>       drm/amdgpu: add nbio v7_7_0 ip headers

These header files are heavy users of large constants lacking the "U"
suffix e.g.:

    #define NB_ADAPTER_ID__SUBSYSTEM_ID_MASK 0xFFFF0000L

Assigning this to unsigned long on 32-bit will trigger a signed integer
overflow, which is technically UB, and causes "error: initializer
element is not constant" warnings with gcc-5 and -std-gnu11, cfr. [1]

While gcc-5 is old, the fact that this is UB will probably start to
bite us one day...

[1] https://lore.kernel.org/r/CAK8P3a0QrihBR_2FQ7uZ5w2JmLjv7czfrrarCMmJOhvNdJ3p9g@mail.gmail.com

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
