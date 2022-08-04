Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4061D58966D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 05:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbiHDDQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 23:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiHDDQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 23:16:24 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754CF5E30B
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 20:16:23 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id m8so23647191edd.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 20:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=wj0kgv0pnjnnbWFGkf+hEd4TCjrKHOM5nUix2QrFsQw=;
        b=bpDvUsZA0TLrUjL8H2WcV1GfxfOqks5KNFE4Hq0lW07or+QMD6LEMvvn3eE0frYDSK
         OMMHG1YR7BpMjYSuqaU55EU8q+I5Kos5EmrrzzxbaYou6iJOD1on17NCVFWzaW0Z2z/p
         TXp+yaSJmcpSy7WeCzT87R1HZEhrs8gJYEtzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=wj0kgv0pnjnnbWFGkf+hEd4TCjrKHOM5nUix2QrFsQw=;
        b=dHeMeGRLpg6QOD+TM8coK9UYJO1HRXgefr3BLj3BuzJ6QbZzKuWT6hAUcU7qgBZeyp
         RxXnP8fjJd3DDGqiKTqrfg4kP+tzxJQbWc8BhWtdh7nMnOVkEqtMUMs9k03RQja80si/
         0Kqe9VeT9bxwtQptlhEMMzO+6Cxc76fwMOMRPpyLa4xBh3JJsONFlDCDd1UPECwCG21q
         XVfpLgY2u1GexH0l3b4TR6bGGjX+IONrs4u+we5gA41Q4/sT6BGyoB/UJhkPghD03xpF
         Rd/yWp157CI5BAxJVicIopVbniXCyWniVzETaq5URNC3b5FkdMqCdKxzLQdmkWvAW/Qt
         5PMw==
X-Gm-Message-State: AJIora/XR/ew7y8Nr0UnnUKhsYrdUfqTqzGAqvq/9SwsfAOba5c7KXwL
        oOmnCEraB976vGLDps37Bpio2nLH2D09Vd1U
X-Google-Smtp-Source: AGRyM1v2lmrE+FgJdyF9NImU+mw6oSnIffDP2rWafkx2NqgHbK28J52ck9eQrkH7gcXqOo6orEor3w==
X-Received: by 2002:a05:6402:2d1:b0:43c:bb20:71bf with SMTP id b17-20020a05640202d100b0043cbb2071bfmr28737602edx.59.1659582981789;
        Wed, 03 Aug 2022 20:16:21 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id by17-20020a0564021b1100b00437d3e6c4c7sm10350809edb.53.2022.08.03.20.16.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 20:16:21 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id l4so23717072wrm.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 20:16:21 -0700 (PDT)
X-Received: by 2002:a5d:6dae:0:b0:220:8005:7dff with SMTP id
 u14-20020a5d6dae000000b0022080057dffmr1710958wrs.442.1659582980728; Wed, 03
 Aug 2022 20:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9twFEv8AcRQG-WXg5owy_Xhxy3DqnvVCFHgtd4TYCcKWEQ@mail.gmail.com>
 <CAHk-=whXSt2N0GcoPC6XxXXLMpXm-34ua+X4AhPsLoqBcF6Xqg@mail.gmail.com>
In-Reply-To: <CAHk-=whXSt2N0GcoPC6XxXXLMpXm-34ua+X4AhPsLoqBcF6Xqg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Aug 2022 20:16:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj8UHvjsVPohpRA1RJo1upyKoSnjcsys+=vbRVbpPvBMg@mail.gmail.com>
Message-ID: <CAHk-=wj8UHvjsVPohpRA1RJo1upyKoSnjcsys+=vbRVbpPvBMg@mail.gmail.com>
Subject: Re: [git pull] drm for 5.20/6.0
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Wed, Aug 3, 2022 at 7:46 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I think I have it resolved, am still doing a full build test, and will
> then compare against what your suggested merge is.

Hmm.

I end up with *almost* the same thing.

Except I ended up with a

        select DRM_BUDDY

for the DRM_AMDGPU config entry, and you don't have that.

I *think* my version is correct, in that clearly the amdgpu driver now
uses that buddy logic (just doing a random "grep drm_buddy_block" to
see).

But this was messy enough to resolve that I think people should
double-check my end, and maybe I just got confused at some point in
the process.

And while I seem to have gotten the same result as you did on the i915
firmware side too, again, I'd like people to re-verify.

                       Linus
