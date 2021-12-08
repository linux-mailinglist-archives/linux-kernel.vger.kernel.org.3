Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D009746DD5E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 21:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbhLHVBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 16:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbhLHVBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 16:01:47 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B173BC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 12:58:14 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id q3so6269395wru.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 12:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XImvS0AivrcTluJmzsJvUDHysjyJJ90wGivbIDW8rd0=;
        b=JtV0eyIK+OgfZmZYOT0K/0RAiPmP9KCGKS8hQ5GPhKqtDOMy7a+qBNJ6FN56XkOj0u
         GHW4Xu429EXLq99Cx2EcVFQqfUNS02/X8kqK+eZnxZfMfNunsAILmfB8W1/hVhZKuoAE
         fIb0r+JMMUOOpHQInPpq/s25EQ7xkmcmjoo2b8cLignYP74zqGds1i9J8JlE6lGYXa4e
         iJ0cwjOTxPM3SxY+8pmJsJU747X4nwbw8St78CtIFbK8xnc4GJ494XX8wHE5z7gY41T8
         yh9I9DwFKOc7obYcxtB/9lgNB1i6s8lUq20KN2H4SdRO+o8U1+fF/cjkPtpSVRRN2GtV
         7OHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XImvS0AivrcTluJmzsJvUDHysjyJJ90wGivbIDW8rd0=;
        b=VW33qUZvz5BR53gnNvNy12yUQavfmG3+ZzoT+CJbd17bbum0W4LxRtgThm1cFS0wIN
         ihuJIMYoOGixiOK5y3ptGB6JtVkAVePEue6OIwXE2MhoPS03pNc7yVUmDKgAvw0SHNWQ
         JGbaENUfl2MYfNGHmhuHd3fZfWVGv4c+uqkoRyl2n0PjbDNDEXtAWZ9VpnIsxfEiFo2D
         xF+XXrUdRDclB3YBzdRTLSHvTKEBES64tAxX6NGoKV8adsT8dy/P9FOlQ9mRzaLD/6/+
         tnTYP7JOrEbQRbOzRRF0azIzAuo47Vcc8yqCVsXlTGsiWdjEaRVOq2FKLhZZhP1O/PSs
         Z/Cw==
X-Gm-Message-State: AOAM532KS9QZuSanvhQjn7eOEp6bQ7C2u1kzdtz71OSAP2665TUHi8Gg
        G60CxL6dD8FtUyU/9SzRJ4R3u+I6HJ5RfI2ojVHolA==
X-Google-Smtp-Source: ABdhPJzvLET5aV2F4EdW/oKY6X7XLgqz5o7p6aS4WEKvMtrHTxjAu/JDs3ibeZ1FCI8e9KuWIhhPJSbNZ906HG2WfqU=
X-Received: by 2002:adf:fbd0:: with SMTP id d16mr1303658wrs.107.1638997093085;
 Wed, 08 Dec 2021 12:58:13 -0800 (PST)
MIME-Version: 1.0
References: <20211208183711.390454-1-isabbasso@riseup.net>
In-Reply-To: <20211208183711.390454-1-isabbasso@riseup.net>
From:   David Gow <davidgow@google.com>
Date:   Thu, 9 Dec 2021 04:58:01 +0800
Message-ID: <CABVgOSkqnRtGrFh4=bbeKqSeHjOVdnFT81sct=HuSERsCFGuog@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 0/5] test_hash.c: refactor into KUnit
To:     Isabella Basso <isabbasso@riseup.net>
Cc:     geert@linux-m68k.org, brendanhiggins@google.com,
        dlatypov@google.com, akpm@linux-foundation.org,
        skhan@linuxfoundation.org, ferreiraenzoa@gmail.com,
        augusto.duraes33@gmail.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        ~lkcamp/patches@lists.sr.ht, rodrigosiqueiramelo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 9, 2021 at 2:37 AM Isabella Basso <isabbasso@riseup.net> wrote:
>
> We refactored the lib/test_hash.c file into KUnit as part of the student
> group LKCAMP [1] introductory hackathon for kernel development.
>
> This test was pointed to our group by Daniel Latypov [2], so its full
> conversion into a pure KUnit test was our goal in this patch series, but
> we ran into many problems relating to it not being split as unit tests,
> which complicated matters a bit, as the reasoning behind the original
> tests is quite cryptic for those unfamiliar with hash implementations.
>
> Some interesting developments we'd like to highlight are:
>
> - In patch 1/5 we noticed that there was an unused define directive that
>   could be removed.
> - In patch 4/5 we noticed how stringhash and hash tests are all under
>   the lib/test_hash.c file, which might cause some confusion, and we
>   also broke those kernel config entries up.
>
> Overall KUnit developments have been made in the other patches in this
> series:
>
> In patches 2/5, 3/5 and 5/5 we refactored the lib/test_hash.c
> file so as to make it more compatible with the KUnit style, whilst
> preserving the original idea of the maintainer who designed it (i.e.
> George Spelvin), which might be undesirable for unit tests, but we
> assume it is enough for a first patch.
>
> This is our first patch series so we hope our contributions are
> interesting and also hope to get some useful criticism from the
> community. :)
>
> Changes since v2:
> - Added comments on struct elements.
> - Removed unecessary __init bits from KUnit test functions.
> - Change KUnit's "EXPECT_FALSE"s for "EXPECT_EQ"s.
> Changes since v1:
> - Fixed compilation on parisc and m68k.
> - Fixed whitespace mistakes.
> - Renamed a few functions.
> - Refactored globals into struct for test function params, thus removing
>   a patch.
> - Reworded some commit messages.
>
> [1] - https://lkcamp.dev/
> [2] - https://lore.kernel.org/linux-kselftest/CAGS_qxojszgM19u=3HLwFgKX5bm5KhywvsSunuBAt5RtR+GyxQ@mail.gmail.com/

This series still works fine for me, and is still:

Tested-by: David Gow <davidgow@google.com>
Reviewed-by: David Gow <davidgow@google.com>

Hopefully we can get this in soon!

Thanks,
-- David
