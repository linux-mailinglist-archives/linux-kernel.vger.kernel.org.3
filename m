Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0D0483727
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 19:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbiACSpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 13:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235753AbiACSpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 13:45:42 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D43C061784
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 10:45:42 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id g13so44892590ljj.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 10:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bon2TzEaMZw9jM9XFv0NkWrGKfLJEYEyxT5WK0i6Teo=;
        b=T0+jz4Nr1t/1nhvRN719ZQEzSnmTKGHWI14rsGCizTeJ9+Pq3NHRf5WGkkBIO3ig2R
         WEsBXXSQUumOIlOM7VuWzBFKL3XVzl9phxO8l1rI60pEVA/jSbtEaqxaJ5xr+AqjiaTt
         V9YIkBrs6otgasLbADTppCmlu1+FupQanbqJzLXAR5Eb9dk4wSNwxdb2YVBB6/edLiSM
         yP6IneGgi3bV2TB7qc7sEDq7nMdaK0G8wYCotW4G9m8bxica4CM8Nj1zV09OSfnYcZEf
         CoWh/VuEeptwK1vuokWGTagQcKog6rUY02+q62DhRTQirM0coloCuZSgJV1+0r1q9z2e
         8n5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bon2TzEaMZw9jM9XFv0NkWrGKfLJEYEyxT5WK0i6Teo=;
        b=PRJ9MTRgsrSX3dEij57aVdhrtsSYRdv8Yx4iv+0sIKQsKjJH7tIQ+Dw0yloR3m2eNj
         7EajQF0gUG92/aqN1LGzlwhNpUPLf3YV5IfurHACEMf+z3cY3pczRII982UsnRvb0nnH
         j07ANPRYg8KkN0uSrlighbd8yiyM29fwkEZbbmS8z6LdpcNwvWDzko8ADjjJ4F6/uYIG
         kZoEakL/6e/Hh+t+WwSXOVtIuj3WLirkg/HNP4GouOiD9BNIsLlRJkSpwiDJYjSYk+Zy
         K8uuZ05ZOK24n9HPUHgkC1PP4jMgglQIlQsUwU9BLIrF/j+c0rH6G7ph9SrNWOIipvXi
         R7QA==
X-Gm-Message-State: AOAM5310Bx7gb0gMD4vCL74/eBSLvWvtaxPicJil1OZJgudfVcmsCBPp
        g0ckv5buZ0Fymit+wB9l/24yBH7THN5begMuZlZazQ==
X-Google-Smtp-Source: ABdhPJxEiB7uEhwcBh4Wz3syBaOYchuUr3Jz8MrBaTyqxDV1Dd7a0xiGHe0W7YzjhL4RNXWQ2n1CRmRoSgK8Vl+S02s=
X-Received: by 2002:a2e:2e18:: with SMTP id u24mr11896473lju.492.1641235540346;
 Mon, 03 Jan 2022 10:45:40 -0800 (PST)
MIME-Version: 1.0
References: <20211229070713.218548-1-o451686892@gmail.com>
In-Reply-To: <20211229070713.218548-1-o451686892@gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 3 Jan 2022 10:45:28 -0800
Message-ID: <CALAqxLXtUcign2gETHg=z24qYOFSALRjWNnJqqY6rk=gsfVwaw@mail.gmail.com>
Subject: Re: [PATCH RESEND] dma-buf: heaps: Fix mutex lock area and generalize
 struct dma_heap_attachment
To:     Weizhao Ouyang <o451686892@gmail.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@kernel.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        christian.koenig@amd.com, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 11:09 PM Weizhao Ouyang <o451686892@gmail.com> wrote:
>
> Fix cma_heap_buffer mutex lock area to protect vmap_cnt and vaddr. And
> move struct dma_heap_attachment to dma-heap.h so that vendor dma heaps
> can use it, the same behaviour as struct dma_buf_attachment.
>

Hey!
  Thanks for submitting this patch! Apologies for the slow reply (was
out for the holidays).

This patch is combining two changes in one patch, so they need to be
split up. The locking change looks sane, but moving the
dma_heap_attachment may need some extra justification as changing
upstream code just to support out of tree code isn't usually done (if
there was some benefit to the in-tree code, that would be fine
though).

I'd also be eager to try to get the vendor heap to be merged, assuming
we can also merge an upstream user for it.

thanks
-john
