Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2A5464B75
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 11:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348557AbhLAKVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 05:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbhLAKVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 05:21:12 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F59C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 02:17:51 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id m6so47524504oim.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 02:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1xwgqeU8rL0dgKvQk92ba6HbkP4Iw9sf96rR49Y78qQ=;
        b=fhQy3rld6iV7AuBPpbF8c4QxFGe7i0NXmZFYPPRSgIDhukONdXVBes258jMMBAhnpe
         /QkVIUK6fScEMyxD3CR0MOUWhUGXyVlv8Zj7fHsJ1NY1ZMU0QeSNnM7Tw37zwsY6kxaj
         V16NEZslHZgC6TzAJ5dkLGGHreFxFwy4LuPTg+Ru6Dx/9MeDoesWNG1MSByehxGuY96S
         VVoKJOqPjlnH2cd2OmPuabaJIf/VGT32r/ISGci0fBhZWqMqm9oucm+RyMpsiby2EJan
         xqqYXdEox8gdRBTkLvVG9u0+Hxzm43OPd6MaUESTg2kzS5I8gVkPVDkCpMN/I5VfeGPJ
         ijVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1xwgqeU8rL0dgKvQk92ba6HbkP4Iw9sf96rR49Y78qQ=;
        b=5V3l7SwCIYR5GUWEbGSzOmJLVkyJT+q1Yv8uPZjPZBGmu6PSACIGKPj84DJ6kNDkBf
         ZUyWtNtjA2S1rTYOHnfXc6HB8Q7tnUYy+MS3rG4O6yHv+uPxYJJZj7/mC0RC0kW63tA5
         pOhwZaqax18m31b7+u1YNUNOs5nlVvsxLBp1l2FFxV/6M9RGdL3hgEqRcfUGc/htVgwz
         2w/iWnOsJniNTiI2XwoJAA1oVF9tc9Ta4cFB6PMPh1PcLWI3gEuqzRJqwIaTZ0ylEoK9
         j3i8CK6anq8VK6TJq5TQBdWTzDz32nSs71E+5aIvbui3JdajgarL+rqdKre2UnNPckBg
         KUWg==
X-Gm-Message-State: AOAM533sv41wP/U6ndghZnGhH0bgynvuqTnKf6NwokCLrSGeMhEi3Khg
        RzxacutZEfFKFzBNCQSiiX78JvnaZc9mOuTlmEWghQ==
X-Google-Smtp-Source: ABdhPJzf8Kg5owMgIaFexMLYCA/E6tDR9IB67AZ17kkwKzrTH0vWoviYNETy/2NDs+ZO/KSw8PTFTtNZzoom/eShsi0=
X-Received: by 2002:a05:6808:118c:: with SMTP id j12mr5036212oil.65.1638353870323;
 Wed, 01 Dec 2021 02:17:50 -0800 (PST)
MIME-Version: 1.0
References: <20211129145732.27000-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20211129145732.27000-1-wangkefeng.wang@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 1 Dec 2021 11:17:38 +0100
Message-ID: <CANpmjNMtGXk07Pm5GS76yHdCDg-p5iateCey3Q8YaqsVpweX_w@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: Enable KCSAN
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2021 at 15:46, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> This patch enables KCSAN for arm64, with updates to build rules
> to not use KCSAN for several incompatible compilation units.
>
> Resent GCC version(at least GCC10) made outline-atomics as the
> default option(unlike Clang), which will cause linker errors
> for kernel/kcsan/core.o.
>
> Disables the out-of-line atomics by no-outline-atomics to fix
> the linker errors.
>
> Tested selftest and kcsan_test(built with GCC11 and Clang 13),
> and all passed.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Acked-by: Marco Elver <elver@google.com> # kernel/kcsan

However, you need to wait for Mark to respond, because he'd know best
what might be missing.
This thread might give some clues:
https://groups.google.com/g/kasan-dev/c/4ySdJfedzso/m/e4CzdfWWBQAJ
(can't find LKML copy)

Thanks,
-- Marco
