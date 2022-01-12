Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35AF048CB8C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356575AbiALTJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344106AbiALTJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:09:43 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A768C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 11:09:43 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id c71so13882707edf.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 11:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S0Bi+PWU2J4PuOPK6RgZxdh0OQGveZD1PdBvsl6+KPU=;
        b=TIlaOXnsdGNm15sqxJCKY5LqIYqszIlxboCLdApQ73MhYdu65t9R86g0zWelDUDQ1K
         0JsHoAejAK2zKwTz52pXsFfxkgB/+jYwb1f9ZJGBMW1/UfomXvFq04/pZLakvQc+5I0l
         /DLGay7ikSX1uDR4BqigoPmVj96TSQgtKx+BU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S0Bi+PWU2J4PuOPK6RgZxdh0OQGveZD1PdBvsl6+KPU=;
        b=SwFB0ynsPtDq1ql5UwYGLFoIJCPmQl03OQ3GdZeFg41dfykpS9DUjQgWpZpxKjSDJl
         5QGItU/u6T+Mw/1PWu4JOSrV7Cww/0WsgkPre/IUERsbq0as+EcGOpmypkeZFPossCqb
         ryD1dFgxqnLh4vJhHqvZgF0dw3FbEu2TWQ71dZU+ZsIzdkqMLGzDdYruF+DxECFGMeo6
         i/OYsKFKisc1C+cHFCiawc7nMg3D/4CnxVQkzrw0HFaugTlsVtVCM0uFneAdBvX+a/Mx
         ZnQfjuE494Z6j4bShqE6afct6lzoDk+shf4/wxuVAWd1w6wsGPKKYmyevPoCsn/I8Evj
         08GQ==
X-Gm-Message-State: AOAM530aCkHos9bJbTLcNv8e3o6lU/onsAoOV53/yqpBTcTkeyRTB9SM
        z15qTDECStt+vgnVjTEsGFRrerLHAs3/27Q7RbY=
X-Google-Smtp-Source: ABdhPJx9DpWyqDM2gEtUT/toIJ3VtLV+59KdarcCXSRxL+kYKJ9gcT/Ul6n2+nlsdqQvzPSZwuUKVg==
X-Received: by 2002:a17:907:3e12:: with SMTP id hp18mr863736ejc.576.1642014581420;
        Wed, 12 Jan 2022 11:09:41 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id j13sm241405edw.89.2022.01.12.11.09.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 11:09:40 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso4056295wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 11:09:39 -0800 (PST)
X-Received: by 2002:a05:600c:4c94:: with SMTP id g20mr8030335wmp.26.1642014579646;
 Wed, 12 Jan 2022 11:09:39 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdaVGwu=Bo5bxVQYZXD-k+x++SuOTApGoK2a_S-1M4Q+nQ@mail.gmail.com>
In-Reply-To: <CACRpkdaVGwu=Bo5bxVQYZXD-k+x++SuOTApGoK2a_S-1M4Q+nQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Jan 2022 11:09:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=whcTsfaQWjNKP+DUSqfo+3rf1o8-N9CpjpogMhAxiJZ=Q@mail.gmail.com>
Message-ID: <CAHk-=whcTsfaQWjNKP+DUSqfo+3rf1o8-N9CpjpogMhAxiJZ=Q@mail.gmail.com>
Subject: Re: [GIT PULL] pin control changes for v5.17
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 3:23 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> - There will be conflicts! Kconfig and Makefile conflicts due to
>   some RISC-V Starfive patches getting merged through the
>   SoC tree while we were tidying up the Kconfig and Makefile
>   (to avoid merge conflicts, heh) there is a resolution in linux-next
>   which was discussed and reviewed to be correct.

Whoever sorted the Makefile entries (yeah, it was Andy) isn't very good at it.

The broken sorting put CONFIG_PINCTRL_STMFX before CONFIG_PINCTRL_ST,
and I have no idea how you can sort that way.

I left the broken sorting in place, because changing the sort order in
the merge would just be even *more* confusing.

There may be other cases of that kind of oddity, I just happened to
notice that one because the 'starfive' thing ended up having that same
'st' beginning, and I went D'Oh when trying to make sure my merge kept
the ordering.

The sort order is fine in the Kconfig file. Maybe some odd sorting got
confused by the next non-letter character (either ')' after the config
name, or '.o' of the object file name).

Obviously not a big deal, but it's an oddity.

               Linus
