Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74EDB46DB8B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239396AbhLHSyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 13:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239388AbhLHSyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:54:01 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65AFC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 10:50:28 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id l25so11462176eda.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 10:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cVu+O4vH5omtpZHli6o4+BSn/vNd8K1dVv76VMkPfw0=;
        b=hxpEnYwFcKlq8sBmKIy6fV/wFHJP+w//gnub12IeP/XY+A4StkFrp8oYTzStdwgW+e
         o5K6lPylJLMKsMrMhwkRVwQUt4NRetfVjq5mpMK9ZdxxBjsDPZMBtpGFmuTRsWxdQO4g
         ltDPV4sSnrogfkVl24vXLNkHxLbxQ1Henxlkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cVu+O4vH5omtpZHli6o4+BSn/vNd8K1dVv76VMkPfw0=;
        b=dQH3WwOUpM7bfapFKOedXiN34mVKduVF1mRpCco5b6SWLTjIkKhfpvr1Tc5z2NtOaj
         2Hpld0lIrw6aFsmBz7LpKTvB9GCaWm32nqY3RRYtvNO+/fCCzzBXJEYitaHHJ6XgSsSq
         a3z9VJy2ei6P9x/Yjba509jGANg6lZ93aAVNJ5gS77qNdRWODvwcJ8EADjpAvKpSYPsY
         fBsyuY91QLHzJtlBbvpW3yT1sMJa1RfeKSdEsdcPvHL9xfQVJ/FnxayS4AXEKgOS7p+R
         p0wU2V078z60/FvaRPvU+LSGFC7Ctezdqc6hN+UFPdgGhY+sqMedP3zyptwZ1i/yUscH
         reGA==
X-Gm-Message-State: AOAM532dquVQtrnbBu0qAATw0MtHpR4mcIqrGYzIdKeo1YpMFJ7j40nN
        PQ3a/rILINTMn640D63VkWTwZbK6aDCaw09B/54=
X-Google-Smtp-Source: ABdhPJxhnd6sbG7pjpk5o8P89YEzyhz0Z1NdzwFE98q0q9DgCh7nHAUksuoLG/48UkJKsRFPpAxZXw==
X-Received: by 2002:a17:907:6e0d:: with SMTP id sd13mr9631330ejc.90.1638989427299;
        Wed, 08 Dec 2021 10:50:27 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id e12sm1810443ejs.86.2021.12.08.10.50.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 10:50:26 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id t9so5702890wrx.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 10:50:26 -0800 (PST)
X-Received: by 2002:adf:e5c7:: with SMTP id a7mr580297wrn.318.1638989426416;
 Wed, 08 Dec 2021 10:50:26 -0800 (PST)
MIME-Version: 1.0
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org> <Ya9E4HDK/LskTV+z@hirez.programming.kicks-ass.net>
 <Ya9hdlBuWYUWRQzs@hirez.programming.kicks-ass.net> <20211207202831.GA18361@worktop.programming.kicks-ass.net>
 <CAHk-=wg=yTX5DQ7xxD7xNhhaaEQw1POT2HQ9U0afYB+6aBTs6A@mail.gmail.com>
 <YbDmWFM5Kh1J2YqS@hirez.programming.kicks-ass.net> <CAHk-=wiFLbv2M9gRkh6_Zkwiza17QP0gJLAL7AgDqDArGBGpSQ@mail.gmail.com>
 <20211208184416.GY16608@worktop.programming.kicks-ass.net>
In-Reply-To: <20211208184416.GY16608@worktop.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Dec 2021 10:50:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg6reEPRY6ZDNA=3=cGRyK1csKhw0p3Ug57Z9by_Ev9Hw@mail.gmail.com>
Message-ID: <CAHk-=wg6reEPRY6ZDNA=3=cGRyK1csKhw0p3Ug57Z9by_Ev9Hw@mail.gmail.com>
Subject: Re: [PATCH] block: switch to atomic_t for request references
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 8, 2021 at 10:44 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> From testing xadd had different flags from add; I've not yet looked at
> the SDM to see what it said on the matter.

That should not be the case. Just checked, and it just says

  "The CF, PF, AF, SF, ZF, and OF flags are set according to the
result of the addition, which is stored in the destination operand"

which shows that I was confused about 'xadd' - I thought it returned
the old value in the register ("fetch_add"). It doesn't. It returns
the new one ("add_fetch"). And then 'fetch_add' ends up undoing it by
doing a sub or whatever.

So the actual returned value and the flags should match on x86.

Other architectures have the "return old value" model, which does mean
that my "different architectures can have different preferences for
which one to test" argument was right, even if I got xadd wrong.

               Linus
