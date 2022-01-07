Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A02B487776
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 13:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238402AbiAGMLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 07:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbiAGMLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 07:11:01 -0500
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C146C061245
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 04:11:01 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id d189so3555984vkg.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 04:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=maXmEDQIldazO5h4bVSueIIOyBVkiIcZL+W9u+RSkqo=;
        b=VYx0lxJtdeDn2m5uHMfpdtolLT4Skey7E94tSCg+elLde/0gae5nX0kXmFyfCwAc6L
         aS9fh9kQCYyB2rzcFv2Vr2rCRvH+ynH1Er1rXkDoKvw2Rw1hG7vCDFNYIO/eKQ32UDGX
         /sR55aJNm7HMj6nG+AWifNN0X07DI54Oll7Ud+ik0tKsdj9fCtjLGktUqgWAzCS53Iao
         rR8UjP1SsShYv8cm17IzJxCEBH7JTHk2rYo877wRSeh+4d8jJDjBBxqld10be7ERqP0Y
         dveqVaBYUJEhnZ54H4U3CZaBFlf2RXGjTcaYfDnAQZgv9YhjsrIX5FbAV7NRoAoXcGSq
         70Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=maXmEDQIldazO5h4bVSueIIOyBVkiIcZL+W9u+RSkqo=;
        b=MJe8TImMWXhLiPMJYR0zTKos8My/YZMfUCA2lJA5aLiODBOrAbURnkdMsJ21nNJ+hp
         5GhbuOIIFZ1e8G6Tt3WMOvz9kNIXadH0eUvSWJdCYEN1+W+PWvB0+WPEpdbGS23oM5tW
         CnugN4YIDIVIpMukzVIdDWciIU/ylUOTpmfyW1N1WhBWUZ1Xg1WnySYlkQeMdOpzQEJr
         LD7YTmm2h3Q9A7mFLFVDXs98m9V4HY5YVm1+uiNpdGeQLdjQQ0cE78I+eAMJYhCO59/j
         61X6GjBVNZzw+BANzEW14bZJaEZmr2SucyqhAKadKQyrWVCCdpsShqnWGl3QsMVSw5Oc
         5ixw==
X-Gm-Message-State: AOAM530gMHdLJlcF/Uz0RHKev1iJgFPVntgBKkxHTTwcnde7aH/BdAWt
        SnGotOAmpNUFfn8uzZd7WvIL+6dTTMqwOWnKk/g=
X-Google-Smtp-Source: ABdhPJzm1ciXt5avUmSf3tfVsL+DDp61VqUev49ZcaKXqe+xoAc8P4ZQJF3+Y0ciCZGDl8ZaiKYtPFH1njTgHXohUbk=
X-Received: by 2002:a05:6122:a07:: with SMTP id 7mr21727151vkn.8.1641557460688;
 Fri, 07 Jan 2022 04:11:00 -0800 (PST)
MIME-Version: 1.0
References: <1641488717-13865-1-git-send-email-quic_charante@quicinc.com>
In-Reply-To: <1641488717-13865-1-git-send-email-quic_charante@quicinc.com>
From:   Mark Hemment <markhemm@googlemail.com>
Date:   Fri, 7 Jan 2022 12:10:49 +0000
Message-ID: <CANe_+UipVZRZeWqzXezacPaVb9UeC6a_ZhQp8GkrvftbRktotg@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED
 for shmem
To:     Charan Teja Reddy <quic_charante@quicinc.com>
Cc:     hughd@google.com, Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>, vbabka@suse.cz,
        rientjes@google.com, mhocko@suse.com, surenb@google.com,
        shakeelb@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Charan Teja Reddy <charante@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2022 at 17:06, Charan Teja Reddy
<quic_charante@quicinc.com> wrote:
>
> From: Charan Teja Reddy <charante@codeaurora.org>
>
> Currently fadvise(2) is supported only for the files that doesn't
> associated with noop_backing_dev_info thus for the files, like shmem,
> fadvise results into NOP. But then there is file_operations->fadvise()
> that lets the file systems to implement their own fadvise
> implementation. Use this support to implement some of the POSIX_FADV_XXX
> functionality for shmem files.
>
> [snip]

> +static int shmem_fadvise_willneed(struct address_space *mapping,
> +                                pgoff_t start, pgoff_t long end)
> +{
> +       XA_STATE(xas, &mapping->i_pages, start);
> +       struct page *page;
> +
> +       rcu_read_lock();
> +       xas_for_each(&xas, page, end) {
> +               if (!xa_is_value(page))
> +                       continue;
> +               xas_pause(&xas);
> +               rcu_read_unlock();
> +
> +               page = shmem_read_mapping_page(mapping, xas.xa_index);
> +               if (!IS_ERR(page))
> +                       put_page(page);
> +
> +               rcu_read_lock();
> +               if (need_resched()) {
> +                       xas_pause(&xas);
> +                       cond_resched_rcu();
> +               }
> +       }
> +       rcu_read_unlock();
> +
> +       return 0;

I have a doubt on referencing xa_index after calling xas_pause().
xas_pause() walks xa_index forward, so will not be the value expected
for the current page.
Also, not necessary to re-call xas_pause() before cond_resched (it is
a no-op).  Would be better to check need_resched() before
rcu_read_lock().

As this loop may call xas_pause() for most iterations, should consider
using xa_for_each() instead (I *think* - still getting up to speed
with XArray).

Mark
