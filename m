Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55B5497E34
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 12:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237873AbiAXLpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 06:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237737AbiAXLp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 06:45:29 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD35C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 03:45:29 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id bf5so25059992oib.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 03:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HDkM4IiHfUKgbkZ+J9zwOceHsfDsj5OClEazZRmTBPg=;
        b=HvPmu/lBdXu8USCBrVJHyisE10/1/FUkHikq4c8GIPsSYm3FNw2nsTcVpUYzL2eImy
         KRPCPFeV3Tshd07oaAWPdk9SbLFOvylwUAsPbprhOKo5XBBCQVw+ScTKVlvUFG++Y6/1
         lx1VV1kGsX0K6v4MLt6YPphNRqfd5UmLF/xPVH+FKQ2w2y98JLaQVx0keZYxGWAremLp
         3RnysEQLgZsQDKLK8OXiTKhyGADOnXG0jhLcvOZFW3vrzauSMpNf7aQzJKdPM2WnUAf/
         CBoN+6qEVRT5y+mVYWx1EEGhzGYS4d65LMa8tApwuPNuKBw3dvCFWzs8xcM9ZAkDH3By
         hwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HDkM4IiHfUKgbkZ+J9zwOceHsfDsj5OClEazZRmTBPg=;
        b=50H8c3JVtqdp/GTxg/g6t3ESxqavLdf170C8HOdZUgXB1MTF4Ned7iRogWBCAP6Pno
         VvDZMinqpzV1OLzhuLmz6yQZ/AImxG+SqhI76P0ADLsKF+RT3VUxcPU8Hr+P9PRNvnj2
         f0yibcqmXaintMscYVMzu4Wz6vuJkhm0P7KpfmVIVAe2yvQLmHr7y8j2TrhHzK9FXNRt
         pkO9DEwRkMtjfjV2C6hF54FXRjXGnaiXiHvXHRYAoU7wEletnhNk0XX3KTWx1tzz6MtE
         iEpNTb5C+EkU7Z/tusG0QS+7lDvlq4fPzEPO73spQH8jUs6YMKlEXLaAkwURqqhGYRJI
         bYOg==
X-Gm-Message-State: AOAM5318ALwSWx0LyNoTFEjsDGtsKjM98LkbXvKvuCor56JXzNqA8FQs
        IeeQluz9DAxT5bwb69yl498t+LvwcoT+Nt51xXQR2A==
X-Google-Smtp-Source: ABdhPJwBMtKEh5aO3egIkRpWsViFdiWPOJARwDxK8cU1P6n8YVfos+OGKcyJYOYZ2OYex3TBjPKT8taDFYlkk/vEf2U=
X-Received: by 2002:a05:6808:15a6:: with SMTP id t38mr1044668oiw.154.1643024728284;
 Mon, 24 Jan 2022 03:45:28 -0800 (PST)
MIME-Version: 1.0
References: <20220124025205.329752-1-liupeng256@huawei.com>
 <20220124025205.329752-2-liupeng256@huawei.com> <Ye5hKItk3j7arjaI@elver.google.com>
 <6eb16a68-9a56-7aea-3dd6-bd719a9ce700@huawei.com>
In-Reply-To: <6eb16a68-9a56-7aea-3dd6-bd719a9ce700@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 24 Jan 2022 12:45:16 +0100
Message-ID: <CANpmjNM_bp03RvWYr+PaOxx0DS3LryChweG90QXci3iBgzW4wQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] kfence: Add a module parameter to adjust kfence objects
To:     "liupeng (DM)" <liupeng256@huawei.com>
Cc:     glider@google.com, dvyukov@google.com, corbet@lwn.net,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        akpm@linux-foundation.org, kasan-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ FYI, your reply was not plain text, so LKML may have rejected it. I
advise that you switch your email client for LKML emails to plain
text. ]

On Mon, 24 Jan 2022 at 12:24, liupeng (DM) <liupeng256@huawei.com> wrote:
[...]
> > I think the only reasonable way forward is if you add immediate patching
> > support to the kernel as the "Note" suggests.
>
> May you give us more details about "immediate patching"?
[...]
> Thank you for your patient suggestions, it's actually helpful and inspired.
> We have integrated your latest work "skipping already covered allocations",
> and will do more experiments about KFENCE. Finally, we really hope you can
> give us more introductions about "immediate patching".

"Immediate patching" would, similar to "static branches" or
"alternatives" be based on code hot patching.

https://www.kernel.org/doc/html/latest/staging/static-keys.html

"Patching immediates" would essentially patch the immediate operands
of certain (limited) instructions. I think designing this properly to
work across various architectures (like static_keys/jump_label) is
very complex. So it may not be a viable near-term option.

What Dmitry suggests using a constant virtual address carveout is more
realistic. But this means having to discuss with arch maintainers
which virtual address ranges can be reserved. The nice thing about
just relying on memblock and nothing else is that it is very portable
and simple. You can have a look at how KASAN deals with organizing its
shadow memory if you are interested.

Thanks,
-- Marco
