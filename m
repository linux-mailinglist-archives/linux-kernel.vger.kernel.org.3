Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03336487E53
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 22:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiAGVd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 16:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiAGVd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 16:33:57 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0834C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 13:33:56 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id w16so26861852edc.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 13:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cl6ubDfyPf0bsIiZ+HAM7SA17QVqusHqEuiF6QMZ3Bg=;
        b=ABAD+YAbdjT5EUrLXHFKr67FkiWrHrUpU/iOotM2olGVkDHQ6usGgHURcWEsKJwSy9
         bvVZRAAiTAk3xiGj0rwDL82GmvRo8ER6JA/LIIUPdLunGOe30u2hBhVJDsCUO4Z4lGxN
         FbcJvMpH6iFpxiyPev64kNMEdeZrd2uZ+nvjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cl6ubDfyPf0bsIiZ+HAM7SA17QVqusHqEuiF6QMZ3Bg=;
        b=7eK74eK2X5Ysn1aiK9L7LKycDTsdyyOlq7YHd6/XtFrZ3r3FK5PC/Uh/xB1QhdkiVK
         Cha/a+TC/yRlnbyHZIrqpQxB05VAyezUai97rF1e/Rj1M9C3YyQXrruC3Qa/mkCdsuBp
         UP56uyd8gZiTBKFf5JAJ5qOEWyYyzUXFuiSg2OhwpkO056MRFxYmcqLQ+wLgRpX+2fWR
         s4RO+GPm8btNT8HdAbBwD6QmTSzcBkrlXieQxq54BPeZGlYpN1NGF+3Ey78e7LXP+WMn
         3SXG+3K0NujOo924KjJcBWOYL3hgyX4g8IzEqttMFuOab4vM02y5PY98HvhMRZP3UbSP
         rNxQ==
X-Gm-Message-State: AOAM530buQKp5VXuVTz+/lQ4JzPCm6Xc4aVgW7ivn9SrDCAB7t1nIhsx
        xTirE17f3LgywCIPy9qDulK2KuP8ujpZj7Ptlsc=
X-Google-Smtp-Source: ABdhPJydE28PBnPZjrGe/lMN8DKZPCLS+bqzixM225qPRyF7CWQl8YGdJui1h2D8PyigSXclmKprDA==
X-Received: by 2002:a17:906:4c1:: with SMTP id g1mr3503268eja.148.1641591235269;
        Fri, 07 Jan 2022 13:33:55 -0800 (PST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id qa30sm1719430ejc.54.2022.01.07.13.33.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 13:33:54 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id q8so13372089wra.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 13:33:53 -0800 (PST)
X-Received: by 2002:a05:6000:10d2:: with SMTP id b18mr55413119wrx.193.1641591233488;
 Fri, 07 Jan 2022 13:33:53 -0800 (PST)
MIME-Version: 1.0
References: <7cd73147-2170-a0cd-c64e-ded4bef645b0@leemhuis.info>
In-Reply-To: <7cd73147-2170-a0cd-c64e-ded4bef645b0@leemhuis.info>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Jan 2022 13:33:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wizbxtkFsWgR6v_24ksFE3ur6RHNg=X_PR5E5AM2XvC7w@mail.gmail.com>
Message-ID: <CAHk-=wizbxtkFsWgR6v_24ksFE3ur6RHNg=X_PR5E5AM2XvC7w@mail.gmail.com>
Subject: Re: Special regressions report for the pending 5.16 release
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Song Liu <songliubraving@fb.com>, Jens Axboe <axboe@kernel.dk>,
        Wolfram Sang <wsa@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 7, 2022 at 2:59 AM Thorsten Leemhuis <linux@leemhuis.info> wrote:
>
> [PATCH] md/raid1: fix missing bitmap update w/o WriteMostly devices

Merged.

> Wolfram (CCed) plans to revert a i2c commit to fix it, but I'm not sure
> if he plans to send in onwards for 5.16 (or if that would be a good idea
> at all):

So apparently I'm getting the pull tomorrow.

> * There are suspend and resume problems related to amdgpu:

Fix merged (and tested at least on my system).

          Linus
