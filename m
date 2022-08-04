Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC72F589FC9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 19:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237992AbiHDRRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 13:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiHDRRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 13:17:41 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805635C9D2
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 10:17:40 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id j8so445004ejx.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 10:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=W3oQTjR935kyPwW8JTzNphawSp0RrVbBZvc3FA95SqM=;
        b=CXWDpj8EE+E/y1A4LLIdWpEV4dz6BU5+YOyxOh/YLtPkJwFlBJB1T2YAT5I0CWpJbm
         VVDqDcqzQQ8s3ioCrfGbckfIaXDN/DMIQcyKDaq2cGGklhoikD/bu8Yh47Rv2wLjHhXb
         ti4AKQ9roXLqZxh+MOQdxpogEjPOBzv2zGxt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=W3oQTjR935kyPwW8JTzNphawSp0RrVbBZvc3FA95SqM=;
        b=RKyprCBoto//mRXYle0gLKPG7KDI42a6NQXXcK4/rqr6g6scxBQbT3Lau3AytIfgHP
         gNBCZku0t9KIMSCK17t4bdPkD0I0bfFwiqjp6H5H3Uou5jD2BpxFm0Fa/1Xd4OeyUiW0
         93eMHGbzpw+MAR4xU009yDQcPzsMXMu5+W86phsytt/YIHI5HNk4HXe54LQtm42DGHc9
         lkLHfROWZ9/UVFLgPPr+m08/N5BYg1U07zAoHCQ/ABB1dkcyXTTMJX1wfka7M1LQlo51
         lL4WYly/CZcZbRaZM0tkMaQaYdXP2y/4nzOsYQEUeXPgbI5E+ZUq5000HDWnNhj5KkAF
         FxzQ==
X-Gm-Message-State: ACgBeo2bcOL5OVtbDnOW/Q94EH4XLnLWsA22pyJiclCJn+U3FFcw9/6E
        g4mbAM1md+AQ7TZlwHzdd4Jn2Dt120OlduX7
X-Google-Smtp-Source: AA6agR7mwNUrVGJA7N2W3aVndGP6lpplDqTbNb+JIuEo6FB8LzxfeywnlPeLzeZ0+DorUAyxbEP0FA==
X-Received: by 2002:a17:907:7388:b0:730:5c18:da68 with SMTP id er8-20020a170907738800b007305c18da68mr2070330ejc.389.1659633458805;
        Thu, 04 Aug 2022 10:17:38 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id j1-20020a17090623e100b0072abb95eaa4sm508615ejg.215.2022.08.04.10.17.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 10:17:38 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id j7so524673wrh.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 10:17:38 -0700 (PDT)
X-Received: by 2002:a5d:56cf:0:b0:21e:ce64:afe7 with SMTP id
 m15-20020a5d56cf000000b0021ece64afe7mr2010623wrw.281.1659633457704; Thu, 04
 Aug 2022 10:17:37 -0700 (PDT)
MIME-Version: 1.0
References: <Yut2otE1h2xtC79o@debian>
In-Reply-To: <Yut2otE1h2xtC79o@debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 Aug 2022 10:17:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjPF0dXvDeqPiSzpev4KhhWU0-R8muaYVF73vy2Vw=QTw@mail.gmail.com>
Message-ID: <CAHk-=wjPF0dXvDeqPiSzpev4KhhWU0-R8muaYVF73vy2Vw=QTw@mail.gmail.com>
Subject: Re: mainline build failure due to 6fdd2077ec03 ("drm/amd/amdgpu: add
 memory training support for PSP_V13")
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Chengming Gui <Jack.Gui@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 4, 2022 at 12:35 AM Sudip Mukherjee (Codethink)
<sudipm.mukherjee@gmail.com> wrote:
>
> I will be happy to test any patch or provide any extra log if needed.

It sounds like that file just needs to get a

    #include <linux/vmalloc.h>

there, and for some reason architectures other than alpha and mips end
up getting it accidentally through other headers.

Mind testing just adding that header file, and perhaps even sending a
patch if (when) that works for you?

                    Linus
