Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0CB46802A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 00:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376419AbhLCXK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 18:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359288AbhLCXK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 18:10:56 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65A8C061353
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 15:07:31 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id j11so4516860pgs.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 15:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qps8M5bSDAi5Q/914l2cfQDiLlViTnJTKxc8U86feRQ=;
        b=adcl6Mc1QsWqQRP3cfEqZExs7vUs7EuqBZ5lKSW/ZJo6yAWGLKQ6xRz37JKhgSw3LQ
         T385wuCCIiO98gAJZbKAzdk53aIJbBRPdcIKroeH58oDRtplyTJ5QMVdsJb5jEv2nOHi
         NYS8dBfQNjRKVteyfZf7CW3rPylemhiykHmoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qps8M5bSDAi5Q/914l2cfQDiLlViTnJTKxc8U86feRQ=;
        b=xnr+aE3BiZWKdsakfRIQewZlNUlIB6FLNVGY2Ge41LnEQ8Wjg/wRZvINzpY6dQPJrf
         jrLM1BV3S+6Yj1DBIhhflZFtabp4XFMO6r8l1OV27q+BEFJ5yB7iJ4UhMHsgn/2ctOBX
         r2Yu9OYJaOOo0ee9F3W8OjFCWbBtsmLgScfVCHOtU53iv0rFSgWGSXY0VlKm05tj6RKd
         TR7836A0HTJkAEFxuhukFhPSZo/Vd++EjnsdCHU0vc0jpmsZmqIfuigICfwAc4jN8Owq
         WZX9Ajk2nqR18UL3p4Hw+5LoRkYXWzO6g7B7D2xj283PjF+RvtXOx6wChz/cPghz2MT/
         SUxg==
X-Gm-Message-State: AOAM533X99YHndyjvfYrPArJjiGJUs+wVNTRAHHWPtmlMWuUjE/vnRdC
        Q5b4ATHSG92v+IcDoqcbN18wlOeMHNyRYA==
X-Google-Smtp-Source: ABdhPJxr48vARuVniU9y+aeIqbkmC2eSocwGNSzT8P50d/Ftqyztjgpc0pCz90FFq+Vd4H1WQ2S17g==
X-Received: by 2002:a63:d101:: with SMTP id k1mr6810983pgg.607.1638572851370;
        Fri, 03 Dec 2021 15:07:31 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v19sm6120521pju.32.2021.12.03.15.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 15:07:30 -0800 (PST)
Date:   Fri, 3 Dec 2021 15:07:30 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lib/test_ubsan: Silence compile-time array bounds
 warnings
Message-ID: <202112031506.D0FF887C1@keescook>
References: <20211203093000.3714620-1-keescook@chromium.org>
 <CANpmjNPCjXp_0iQjdznpvS2vF-VvDkxJrtWnBAoj6TAU488VAQ@mail.gmail.com>
 <CE7F1A95-67C7-4BDA-B803-D93901EC2378@chromium.org>
 <CANpmjNMCrLU0J3W+-=wihEaHXMytSfNy=iu-8-oO8JDvEUYAJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMCrLU0J3W+-=wihEaHXMytSfNy=iu-8-oO8JDvEUYAJw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 05:53:15PM +0100, Marco Elver wrote:
> On Fri, 3 Dec 2021 at 17:21, Kees Cook <keescook@chromium.org> wrote:
> > On December 3, 2021 2:49:53 AM PST, Marco Elver <elver@google.com> wrote:
> [...]
> > >Are there other warnings or only the one for the fsanitize=object-size
> > >test? I think this is fine if there are other warnings.
> >
> > I will double check, but I think it's only the object-size test, which seems to confirm my suspicion that -Warray-bounds provides sufficient coverage and object-size can be removed.
> >
> > I have another patch I intend to send today for the sk_buff/sk_buff_head issue, as -Warray-bounds warns for that as well.
> 
> Nice.
> 
> Do you want to send the patch removing UBSAN_OBJECT_SIZE, or shall I
> do it? Perhaps it ties in better with the rest of your patches which I
> have no state of.

Sure; I'll tear it out. :) Thanks for doing the deep inspection on what
it is actually doing! That had been my main open question while digging
through all the -Warray-bounds warnings.

-- 
Kees Cook
