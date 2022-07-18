Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E758577E78
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 11:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbiGRJO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 05:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbiGRJOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:14:52 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1C0101D4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:14:50 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id oy13so20038148ejb.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pwFbbauDX9gsZYxtY8fxgYizduNV3aBKsO3yUHiYWcA=;
        b=lOzYBZxkWa12PFEYxuRa3esea0uZmAzb/unlVnlRnHnhGEcFOCjG5X8DbepRn1wyTe
         JoxJDTxc5gvW/Gs1ToHLdEEEHD/HuuzW/ZZFtax6eEzY0qPDWja14ZRctGByO3HY9bbb
         8GQETaShmaNthrEDIDz5sk72HoLj45JDd4chLJlosTfzpiG0MJMWsXlZXMlOS9/W2Vy6
         nwOD7j0J64i/6T3zM/DnxFniv+zu7SL+KLPl/kR2adbEsVCLomFDOlIV/Rvj0oqGSSHb
         J5kYntdMLrmzpvbmIUOTB62LeN4drnmiHLsEPXJEqU1wDXIUmLbycaKfos5QQcNiI10u
         Icgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pwFbbauDX9gsZYxtY8fxgYizduNV3aBKsO3yUHiYWcA=;
        b=wJhgMglSoTD1qlRnWiqpWCNRrWTDN+5KAh9PbiRpn7Ioh9YTAxs7hMC0I21Ui03Gvz
         Kcc8+DR9xVCeEplBQ+OFwOORCt8oaZG/nLp2SIwwdN+xnrdhB6KFhk1WOTzS5vosPVQ3
         cTlxLbT5PuyJOQ+TaMbPfdswa+pm9n/VCgGvqFbWIcYuQYykCfkSd+Y7lnY51rRh3mvJ
         +SIOmLFsof3Urftn8MIQcp8qM7uHYqrMhzXAbZdZEVhU+5K7I3+o9o1iWwShgULvdSZz
         zSrLlh46g3mLnK/UFLwaSW0ES3oN8BTjS0IvlEOHway8gxIjsayElbW/o9W9qjB/laKK
         /94w==
X-Gm-Message-State: AJIora+9voy/LgvpvqqGvNfLCbYMyxz/r3v9aCLEXOfUboxt/GgMtOZt
        tGfjPxRMOaB5EqvK/+qkqXFOqaAGFOot/jyxLw6Vow==
X-Google-Smtp-Source: AGRyM1tCH5IixWtJI6STLtZK5K2JWPfTCLpcSnp75RgNnuxfWdyUFS3S8v9F4PaWSdnjzvnIzUM7VsEodFwZl4fW2Sc=
X-Received: by 2002:a17:906:58c8:b0:6fe:91d5:18d2 with SMTP id
 e8-20020a17090658c800b006fe91d518d2mr24964642ejs.190.1658135688605; Mon, 18
 Jul 2022 02:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220713110020.85511-1-lihuafei1@huawei.com>
In-Reply-To: <20220713110020.85511-1-lihuafei1@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jul 2022 11:14:37 +0200
Message-ID: <CACRpkdYmwojupt_024LKA2B0e7zBKmreYYX3ZMC56i5Vrr3fFA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] ARM: Convert to ARCH_STACKWALK
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk, ardb@kernel.org,
        will@kernel.org, broonie@kernel.org, mark.rutland@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, arnd@arndb.de, rostedt@goodmis.org,
        nick.hawkins@hpe.com, john@phrozen.org, mhiramat@kernel.org,
        ast@kernel.org, linyujun809@huawei.com, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 1:02 PM Li Huafei <lihuafei1@huawei.com> wrote:

> This series mainly updates the ARM stack trace code to use the newer and
> simpler arch_stack_walk() interface. Two issues were fixed before that
> (see patch 1 and 2), as well as allowing stack_trace_save_tsk() to
> trace non-current tasks (see patch 3).
>
> v2:
>  - As suggested by Mark, the commit logs for patch 4 and 5 were
>    refined for easy review.

I see I reviewed v1 when v2 was already out but think the
comments still stand.

I think you can already add patches 1 & 2 to Russells patch tracker,
they are straight-forward fixes.

Patches 3-5 may need some elaboration but I trust that you have
done some serious testing since you found the snags in
patches 1 & 2.

Yours,
Linus Walleij
