Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15084A029C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 22:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343738AbiA1VV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 16:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239231AbiA1VVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 16:21:25 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF515C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 13:21:24 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id v74so7319993pfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 13:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kYog/BqFDWNUevncRZPSz/7DuXyTbwEtBR6tVJ1Z7ec=;
        b=JTdfELdG5DjgJJA5MLvURWVhN3HOJkymfEO2b46OC3Y9DCLTR6HA/ak2T1AKpLMJEK
         BBCMnl4VT84crQCyuMVSXFfEmkYn2VQLHTBx+75VvEOc7YYXynUoDx60pxBZf8yLhHvh
         h8LMUUEUVhEXePjKNBWe5pnc4GiMoYODg+kshlC5MZ1Ciu/lNtdovB+f3W5eIVwRjADR
         dNO3Z0U2posO7lwRWqMjZnMKPa4ZZNIRovwFsdGUEq5fxPB1Jyn/6I8EVYBuoaWM1MN9
         PLbcagmWKrOnbobyfj+HCzVJ0tGwygqcBZYyPsUMhOm7cxyAp0PqQbw+7F1qPa8e0HdI
         VSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kYog/BqFDWNUevncRZPSz/7DuXyTbwEtBR6tVJ1Z7ec=;
        b=3w23txl5GIoQMFbG1ov+kctW9Z2JzqY+RKcHsJA/sL2ADY/SqnVl9+s18YcgujtcPk
         vHabxlV75V2W6FMg7JqfkN3HTKPgoIN/248FuvXBTDuynSrt6oqKO41ZtEQzx5MAtIgF
         0kJxuUbVg+RxGg7S+qX9KbQFqVxGGcn/nFTlvjq8ZDBgHpH8lFYDcsmVUI5WuA97gTrh
         3t+7sf7+7eK/XRi5RAzk/J9HQ9g5hi9d4E/OcOHds63IdJmP6tuScqjHdkm3UDTpiQ91
         FTVxKyqo9Irj8Qnw58am+JoyA+iJo4hkKPv7ZMIudVtK2asUn7nOCrrRmZ4SjIEPoRXy
         0+Gg==
X-Gm-Message-State: AOAM530xB08KSy6UaZd/swh2LdTu5pDJaoNG9CloCwu2Gg8Mgo0a7Vmz
        QpzetfNzUsvjAgndhDajM6ut0i+99kLdvuyvuGjFRg==
X-Google-Smtp-Source: ABdhPJzbpNIre/OilPR86TNoXJzaHM5vK9Oqem5lcugnKToTZ8sd15K4YCPa4UhDD+gJ4UfSvBoXLn8/ATvLduhboJQ=
X-Received: by 2002:a63:184a:: with SMTP id 10mr7861393pgy.609.1643404884224;
 Fri, 28 Jan 2022 13:21:24 -0800 (PST)
MIME-Version: 1.0
References: <20220127215222.159049-1-dlatypov@google.com>
In-Reply-To: <20220127215222.159049-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 28 Jan 2022 16:21:13 -0500
Message-ID: <CAFd5g47imcBAPNqrX+ZpmVzw8mgaPiBX_ip0euFAgmTA3cxitA@mail.gmail.com>
Subject: Re: [PATCH] kunit: cleanup assertion macro internal variables
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 4:52 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> All the operands should be tagged `const`.
> We're only assigning them to variables so that we can compare them (e.g.
> check if left == right, etc.) and avoid evaluating expressions multiple
> times.
>
> There's no need for them to be mutable.

Agreed.

> Also rename the helper variable `loc` to `__loc` like we do with
> `__assertion` and `__strs` to avoid potential name collisions with user
> code.

Probably not necessary since we create a new code block (we are inside
of an if-statement, do-while-loop, etc), but I don't really care
either way.

> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
