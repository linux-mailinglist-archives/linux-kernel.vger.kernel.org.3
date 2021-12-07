Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA75F46C41A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 21:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241004AbhLGUGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 15:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236442AbhLGUGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 15:06:43 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3C8C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 12:03:13 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id g19so379211pfb.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 12:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SPlDrqxX9glsFDNE5urmxcji6mmh27t1zhykSBzc3+4=;
        b=DwYKDw7mrISzgN6YcNSbjtcTvRqlGK4z7W8Abkgm4r+GH4t4tWUekayNyjAjqTigGX
         cAkH+JYp1lEZYn7hAmn9qWqg9Q/Rdc2r2QNtNbJdRk6ftjCjY/hdlc1LzCF6V40YwF3o
         5o2+DFXg8rqVm4RhZ3Z8srZkDBWW8MpsJZNDEzkTuy8D6YtLg+2RPKdH17UwXMBGW/AK
         Rpm7lNXYVEaJFICxargBMVPWw5zrkWH5KAKyGjPeEJu02a1i4bRquWVH5xyRFymBkI+x
         1tbTdP4bAYapQAS15k/TBfgYY8lEZt+YukA1TOXAqBH/AZoBEbIgdJ9i0UvqFJJH8Z2S
         rCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SPlDrqxX9glsFDNE5urmxcji6mmh27t1zhykSBzc3+4=;
        b=eO84qYddyIIZ8A7NhnzXPF8cnJg3BgB0wO/8bnRj6lM5YkrHHvY+TvkIN5trCPwU5o
         fvXRXuAN+zB15oEekPzug0Q2tL+WKohDCnopW+9axyqXtrZfT52b9PP/Hr0AWx4FzEn5
         LwHguhQP0YlhPVJRHxZHdh7rycCV/xqS1qty2Xq7SV//KZSr0wHwLa2MX2uxxqETxIDN
         0q3jkvydHft9/I7EO0u+MGtG6f2wklJ+vlZc0z7wjzpjtIDYQrZz5dwshWGbh911HKyk
         qzg0WA5GqGl0v6ldXdevZjNN+MwhkSuDCe6g1J7Xueg1P2xb2+Xa9MUUWbBxpRadYZ1m
         8f3g==
X-Gm-Message-State: AOAM532mnz1nrx3RzBVICyUdvGiAJLvxhuBjWVFvacNBqPKS3l2WfyQw
        JG1F4/ic9QRw8FNuI/t2zaGXeuHKVe/aWSlVjNHrGVdSH77alQ==
X-Google-Smtp-Source: ABdhPJyrqyvDyR8ElGMsnU8zJbfhfxnOetzt8CQ7ogfrSz4HwYRUxG/SEdosfDHN9tpGr24CjLFOVjCW/8O3KZbSatE=
X-Received: by 2002:a63:3fcb:: with SMTP id m194mr17010266pga.407.1638907391992;
 Tue, 07 Dec 2021 12:03:11 -0800 (PST)
MIME-Version: 1.0
References: <20211008232421.1264857-1-dlatypov@google.com>
In-Reply-To: <20211008232421.1264857-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 7 Dec 2021 15:03:00 -0500
Message-ID: <CAFd5g45o4B=qxsLqrcSWfs19JBBFVhwYUxYMET7NoL9zFBaNxQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: fix --json output for skipped tests
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 8, 2021 at 7:24 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Currently, KUnit will report SKIPPED tests as having failed if one uses
> --json.
>
> Add the missing if statement to set the appropriate status ("SKIP").
> See https://api.kernelci.org/schema-test-case.html:
>   "status": {
>       "type": "string",
>       "description": "The status of the execution of this test case",
>       "enum": ["PASS", "FAIL", "SKIP", "ERROR"],
>       "default": "PASS"
>   },
> with this, we now can properly produce all four of the statuses.
>
> Fixes: 5acaf6031f53 ("kunit: tool: Support skipped tests in kunit_tool")
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
