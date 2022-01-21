Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2165B49680D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 00:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbiAUXBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 18:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiAUXBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 18:01:30 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EBDC06173D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 15:01:30 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id a8so4812090pfa.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 15:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PYphm4+4iS9SAoeVlv+LsUbA1aLD+SqyiCj3OPowf64=;
        b=Dq+SOs17hUZ7jkqGt87h5phHUHLlR8aLu0VIPmtsQs5G0niRVjhQWWCzA0PT3PBHkC
         hIqrPVaFJclYGYgRvAcvcwfZMELL7djjEB+faolNIABAFzb6gFJViRRb6EWaCaNmu+gp
         PSxWWshifVNbDTtYwW8YftBra40Lv4/nybtMfeH3c3gtE/Drgcg3h52JmtZT0plAlNsc
         Y7ptxf0oLZ3SeL9OdszF7OGeKKbhd/QdQFttVVOr0+a8z8qULGt96ELG1Sp2SFw/BucS
         0dRbAkS2SYhEegpCpH9t63PN8rr+O9YM5lCHRYQ2oYVxJHPUc3pRC9CHjcwrpATNhmHD
         yu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PYphm4+4iS9SAoeVlv+LsUbA1aLD+SqyiCj3OPowf64=;
        b=zeydu1xgA8rBebc6Tv9GDSf5MXMQzrKkcTwSyvDUKJtRY4atJ9UZs1E/de3IS/M7zM
         aqx2z6n1S6KFRp37X++5xuAJCDwl+bvKFTWIJZoDlkV26Xbt1xA9IuAD+di4vzc+y2Tq
         0i9fLPOHp7kWyJk9UaDlGvG0oeTOTMoQnyCt5ndlOaRiLc5lq8xYIIDSF+quLyTH8S6j
         EUze6n2xAxCesyIYGqoLwAGctEMe7k+8lYV7JYoY0cvI4xMtxTM+tEcDJYE4AyITyxXZ
         CncwLu1BEli+t/JvtOE76MaRbnCCEvgHKbrf8iuBcXNPKAKJhJuoHzG1CtsynwXG3f3w
         nFpg==
X-Gm-Message-State: AOAM530s3UMYxJg8ta/XI6X1ZjsKfYr0ACrpA7bGNWu3YTnDVQTU5fFv
        Ild2jkKQZfZrv2262jPZ1//wyfG4bIvCgUYo0VL6BQ==
X-Google-Smtp-Source: ABdhPJxaAdubDugrQEvvUGVtqIvv7Vu9kGzTezzTWcrI90O9URb2rxf/ZBKjDWIah6IuL4jcNuk30fOtzpDTtBP17Rw=
X-Received: by 2002:a63:1157:: with SMTP id 23mr4319202pgr.12.1642806089188;
 Fri, 21 Jan 2022 15:01:29 -0800 (PST)
MIME-Version: 1.0
References: <20220113165931.451305-1-dlatypov@google.com> <20220113165931.451305-5-dlatypov@google.com>
In-Reply-To: <20220113165931.451305-5-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 21 Jan 2022 18:01:18 -0500
Message-ID: <CAFd5g47Ae31FZBnF84Mv=WK9-7kYyODVDAfU03qQSP_O-qfmkA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] kunit: factor out kunit_base_assert_format() call
 into kunit_fail()
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 11:59 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> We call this function first thing for all the assertion `format()`
> functions.
> This is the part that prints the file and line number and assertion type
> (EXPECTATION, ASSERTION).
>
> Having it as part of the format functions lets us have the flexibility
> to not print that information (or print it differently) for new
> assertion types, but I think this we don't need that.
>
> And in the future, we'd like to consider factoring that data (file,
> line#, type) out of the kunit_assert struct and into a `static`
> variable, as Linus suggested [1], so we'd need to extract it anyways.
>
> [1] https://groups.google.com/g/kunit-dev/c/i3fZXgvBrfA/m/VULQg1z6BAAJ
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
