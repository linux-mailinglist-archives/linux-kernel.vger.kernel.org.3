Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFBF47610C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 19:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343990AbhLOSti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 13:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239049AbhLOSth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 13:49:37 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEA3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 10:49:37 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id y13so78026832edd.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 10:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ioQNwWnn8zu15g3q6NqfPbntMWNJmrSIj3rvfVHrjSE=;
        b=KNHat9EeioCinC7A61YJSGi9IQ01eVMzXVpIF4Ctwlgg/hk3+hXCwrM3GMPR+tvYWW
         xCjAG/aSXfIAihAdYO8BXxw2mXVxi0Deloh0SD8l0E+9OKuJXc0bURpUC1jw2vHg6CLg
         L1qNR+6otCa31dWsXa7Z/jeeVrUE1WE0zmGLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ioQNwWnn8zu15g3q6NqfPbntMWNJmrSIj3rvfVHrjSE=;
        b=mEOa5yc4ZHZ9i7//de8a3OiFLMbiw89zLINU6dpPVKAlzDVmu1OK5T73NayudLM9Ld
         mV0MCQ57K2cQkfaR7ofEkDOnTvyUAfIrpmcSS6of9tqMcGkpukU3zawUxFlRUWRLhNsy
         ZIRW3xNGh/Bg5CHNKCMAbSjniTC/6LuMPDdCiF34dalpaJ4K/TUpN0EHkDI7JptcrBXU
         Nkau6Di3BWimODXx8dTn2NLO3BlyxoXonZXDqn1HD/iWBOLVQkhh70nVdhV8tkWdAgG4
         9Qvq6QaKCw+N2zvTcGnTvrkvyA7P6DuR7M4/jsXhjmIHcHHyIY/bz0xEXl1EMQ6AeiEF
         2h0A==
X-Gm-Message-State: AOAM532AZtw11wyQ/dBheohLZeHEzMzFwhBoKiNqZAm576cF54PZe2Zi
        43gh84tWKxk1sj8enXdDyOy96IX+HZ7mbq0s
X-Google-Smtp-Source: ABdhPJxwVc/+yUk+M4Z2TsLiPNq+iscn8E8dzdKumWMLUsddhEET7qe5dog0yXazqDesLG870ws1MA==
X-Received: by 2002:a05:6402:51c6:: with SMTP id r6mr16227443edd.365.1639594175730;
        Wed, 15 Dec 2021 10:49:35 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id 14sm986976ejk.215.2021.12.15.10.49.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 10:49:35 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so19166563wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 10:49:35 -0800 (PST)
X-Received: by 2002:a05:600c:1d97:: with SMTP id p23mr1405405wms.144.1639594174938;
 Wed, 15 Dec 2021 10:49:34 -0800 (PST)
MIME-Version: 1.0
References: <20211215111917.GB16765@willie-the-truck> <YboRETjutObrQTHH@arm.com>
In-Reply-To: <YboRETjutObrQTHH@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Dec 2021 10:49:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgDdM8zbqf+8_NYsAmGG=AmK78ce0hKQwWk2zxw=hygQg@mail.gmail.com>
Message-ID: <CAHk-=wgDdM8zbqf+8_NYsAmGG=AmK78ce0hKQwWk2zxw=hygQg@mail.gmail.com>
Subject: Re: [GIT PULL] arm64 fixes for -rc6
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Qian Cai <quic_qiancai@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 8:02 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> I you haven't pulled this yet, please discard the request.

Discarded. Thanks,

                 Linus
