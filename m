Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A088046C4EE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 21:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241452AbhLGU5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 15:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241441AbhLGU5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 15:57:39 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A64DC061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 12:54:09 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id u11so90069plf.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 12:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VMPoqsoId6HWsPFw69vGUFoNsyz/LMMcBs3MC/wfdeY=;
        b=jRFhTTXNtqYsIZI1JEosgsPdAzsOUjmz5xu1yZsmwWUTaHAb4apJ0WOzg4jucgF5/L
         SdHBHDeVzqhbT81RD4gyWeOWbvlHsN/oPhoOxMWunbs6kvUH3anKpdL0FUN9rWpnLWpR
         NotedaBP3/jPDtg5JmXubVa0ofHKJ3k+jskwaJOQ9E/qKMC1Uo0DZs6iUmNgvsUYAvqH
         j9gX59LadC/sguKp+iYnTuBuKCKSxzM3DEIYdQHoJ1KeHRQke1dKlOz400tJI7zURL/M
         cj6Pwvje/V5T58h5atih4omfgxChtcwK58TaWMXbnHfaBDQE4BKJ8k3fTrs4Ucn7yjJW
         DrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VMPoqsoId6HWsPFw69vGUFoNsyz/LMMcBs3MC/wfdeY=;
        b=jsmn/vBtTlRCRLeAWpJDkx8i0V8iSXcO/BZbqZUngg9okTJsEStN5P36AqIb6It0bW
         QQpSJaIqGPy/4JZkwKPkZrOSDQ3jWH/kRmm7/c1oXf1oO/Gx1MQLreGGsv7q3/6jp8nN
         sFCi7u2XKYGUvRgsg/20eU60gYc0VLuP2qhq7lP8NRdxcNeD86rSKAARyZpnTcSev0Gy
         tzXBZccDIeO5CW/ePX/0m1PQx5GTLhXL9W4ZSWWXJWcmYAXNnbhulzQdbDmoEWoLdUCg
         QRMRfJcnhfIXGGI6iK0N8f5ln3MpzgyOm81AA3R+ATK/RMz+B6I9gi8j69poPA/GpspV
         4Ukg==
X-Gm-Message-State: AOAM5313CE2gKG0g2haailPR2bqHhXUr+1ZCcxGdJESo5bSU8nkCtl5z
        PLeXyt7AEKmvfct+QWDWv+W9u5Yc7ury4uhKHSovJw==
X-Google-Smtp-Source: ABdhPJxGOX9jRrRoXCbwqewVjhX8JMcCh8Le9ks7gtD+qaihDusUQXxVlQl4+wBikjYMLbSX+3jM95lWCDZTPbPfTh8=
X-Received: by 2002:a17:90b:230c:: with SMTP id mt12mr1898428pjb.63.1638910448209;
 Tue, 07 Dec 2021 12:54:08 -0800 (PST)
MIME-Version: 1.0
References: <20211007211417.728268-1-dlatypov@google.com>
In-Reply-To: <20211007211417.728268-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 7 Dec 2021 15:53:57 -0500
Message-ID: <CAFd5g44yfd_K1KTeatUGkBu+STX-mGkWQsMQDBCgzZ7aPz4x7Q@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: tool: print parsed test results fully incrementally
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 7, 2021 at 5:14 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> With the parser rework [1] and run_kernel() rework [2], this allows the
> parser to print out test results incrementally.
>
> Currently, that's held up by the fact that the LineStream eagerly
> pre-fetches the next line when you call pop().
> This blocks parse_test_result() from returning until the line *after*
> the "ok 1 - test name" line is also printed.
>
> One can see this with the following example:
> $ (echo -e 'TAP version 14\n1..3\nok 1 - fake test'; sleep 2; echo -e 'ok 2 - fake test 2'; sleep 3; echo -e 'ok 3 - fake test 3') | ./tools/testing/kunit/kunit.py parse
>
> Before this patch [1]: there's a pause before 'fake test' is printed.
> After this patch: 'fake test' is printed out immediately.
>
> This patch also adds
> * a unit test to verify LineStream's behavior directly
> * a test case to ensure that it's lazily calling the generator
> * an explicit exception for when users go beyond EOF
>
> [1] https://lore.kernel.org/linux-kselftest/20211006170049.106852-1-dlatypov@google.com/
> [2] https://lore.kernel.org/linux-kselftest/20211005011340.2826268-1-dlatypov@google.com/
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
