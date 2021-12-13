Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428524734F7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242221AbhLMTaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbhLMT34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:29:56 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289E7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:29:56 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id r25so55138462edq.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U486OkAxbiMLLBZlcnYe2umGsEJM1XPggk3H0Cn1WFE=;
        b=OYzggf2Chu0oSzrpu+NHZIWXj+rsQjYdYWOxzWpThTNFvvbMMKtMtVx8nIKjneG4hG
         Ed0nJHi5Vd/kAPL2fuf76/9CpnxODlRgWD5cTBVraUErQquY+NbjjYtskz9jFx24EB9P
         dkh44qqinmRT6v83b4DodjlY9COlDrEwy9dz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U486OkAxbiMLLBZlcnYe2umGsEJM1XPggk3H0Cn1WFE=;
        b=Et6hYqwNS9nr9DF1ql4tXJQwi+p4HjUKAbRum9mKMHS2AEzCvH+4jyG8CfQh6ftbdP
         TGvYkc6X26RSdzRSEhpuKXDFRaEUb2NJbP4E/z8FQkdUKvIJZOTciFjoAUJ1SWlgDcrf
         qy5y02qnc0lCDDrrBS+QbtcHWn1UI3B6EY+FUwMP5UW9zJ+Ct2DpnLbDRuXYuuT2VnQz
         lHW7aqeEv3HfNIicEprEdEB8Z4nXvzO4xOvT+noj56sUV0gTt2og4tHgdiuvAdB1G6Y3
         GPi6Ea+z9S7JmS0q8zySOxZUamc95vgLGJPX0UD+ZCgluprRPah6fpZf2Wnggv9cmFER
         puxA==
X-Gm-Message-State: AOAM531KqYGPgaT3U0rTRDF/xNcXnQE3G2mr3NRdDsOsMLIfzFl0EU6B
        CmXAmc9qhczUpvWUy9Go5JeTnVmdCI2PHtN5
X-Google-Smtp-Source: ABdhPJw8AAKIeAASbaHg1hKVrATlSwp2eq7nRie2W6dq7hXWBIU22+2Np5C4h2zEt6P2U0ONOp7eOg==
X-Received: by 2002:a17:907:1b06:: with SMTP id mp6mr349539ejc.275.1639423794571;
        Mon, 13 Dec 2021 11:29:54 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id l16sm5670370edb.59.2021.12.13.11.29.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 11:29:53 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id 133so12753825wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:29:52 -0800 (PST)
X-Received: by 2002:a1c:a749:: with SMTP id q70mr131711wme.155.1639423792413;
 Mon, 13 Dec 2021 11:29:52 -0800 (PST)
MIME-Version: 1.0
References: <20211213191833.916632-1-tj@kernel.org> <20211213191833.916632-3-tj@kernel.org>
In-Reply-To: <20211213191833.916632-3-tj@kernel.org>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Mon, 13 Dec 2021 11:29:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgQQhQakEgKeCcDp==wk__pu32=k-1m63prWx+XjzyhHg@mail.gmail.com>
Message-ID: <CAHk-=wgQQhQakEgKeCcDp==wk__pu32=k-1m63prWx+XjzyhHg@mail.gmail.com>
Subject: Re: [PATCH 2/6] cgroup: Allocate cgroup_file_ctx for kernfs_open_file->priv
To:     Tejun Heo <tj@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Michal Koutny <mkoutny@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jim Newsome <jnewsome@torproject.org>,
        Alexey Gladkov <legion@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Jann Horn <jannh@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Security Officers <security@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 11:18 AM Tejun Heo <tj@kernel.org> wrote:
>
> v2: union dropped from cgroup_file_ctx and the procs iterator is embedded in
>     cgroup_file_ctx as suggested by Linus.

Thanks.

Looking at the patch, I mostly like the end result, although it
highlights how odd that __cgroup_procs_start() thing is.

I wonder if that 'started' flag could be removed, and the
css_task_iter_start() thing could be done at allocation time?

But I may just be confused. This is not a NAK, just a "that pattern
looks slightly odd to me".

               Linus
