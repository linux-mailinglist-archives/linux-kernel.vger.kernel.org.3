Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A7947355C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242602AbhLMT4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242598AbhLMT42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:56:28 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4489AC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:56:28 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id n8so11954703plf.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v/X0SnoPErHjRzX4+Xqq9PbpCrAW+7beI3BdzsbgarI=;
        b=M5PV2hAZg8lxvFwKRkLt43Bv0pE1vD5jI49S+fRPC7608xlHtq167lymr3zL7D02Ok
         qgwgTPWD0iEPc710uJkn9uuMmqLX+TIPA8ZD+PnGnKiJwANZtT/fz0T047kll2nDEyJE
         1WWzqB9X5dRVth/FiKydFr+uXannKgE/n0Ppu2/eHM4QFyvzooxysSeG2UKB4UCLFtyQ
         v3jjUuFRlslK09ZUOA1AtArNDgBtNoGg2LYHhtPcFpu+3Au1QoqLizo61lp4k5gdxngj
         rr7yoAH2rdWLwXNnzNAD1vPO34lyCiECMtN5q+wjETJ4Meu1lvfZRQ+DfWUcccZnf94n
         3J3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=v/X0SnoPErHjRzX4+Xqq9PbpCrAW+7beI3BdzsbgarI=;
        b=8AQ56cAv9eOdsmVN1y29en8qz8GlKjl8BlP7ldCzP2dxTYKh0THbHp/3GWKg+RymcZ
         4DQByx5E8Fs4E3wvKDtCTg6JFteu+izLIpiFnTQOAGpVK89/7/GC731pdpUIAn5gq36x
         C9Sa6ltEQ/vcmoVCgR3S3Gpwkw5p3YNC+jMUdXs+oIpFcoQZoIBEPbczqM2N6FiobhbD
         KxQR1+kqrR8qZvyXZLL57Pt6VholCvBimSIrz4blPGFvqamLivCp2D45NMB+6zw5Qoda
         LwXwZubBv7o2K93JTDe7ziy/jJG6pAFNULzKQ0lD41MVrDntW1zIzw996iDb+1+cRgJ2
         kIyQ==
X-Gm-Message-State: AOAM532thXFwyt2oBaECSNLNUsJG1YTO70zrUeoS5iWeBcjOgVplIOiG
        Gha+3Cr90AL1GEEhhmAntIU=
X-Google-Smtp-Source: ABdhPJwC8ApQP3XwfORCEcROX3Hr2x96ioDgTL/DF5vU2lpuCNbnh89lSbVeHVPlgDaGldyhKD1fKQ==
X-Received: by 2002:a17:90a:d357:: with SMTP id i23mr442384pjx.3.1639425387633;
        Mon, 13 Dec 2021 11:56:27 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id y190sm12932987pfg.153.2021.12.13.11.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 11:56:27 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 13 Dec 2021 09:56:26 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
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
Subject: Re: [PATCH 2/6] cgroup: Allocate cgroup_file_ctx for
 kernfs_open_file->priv
Message-ID: <Ybelaqt8uiyN+DkW@slm.duckdns.org>
References: <20211213191833.916632-1-tj@kernel.org>
 <20211213191833.916632-3-tj@kernel.org>
 <CAHk-=wgQQhQakEgKeCcDp==wk__pu32=k-1m63prWx+XjzyhHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgQQhQakEgKeCcDp==wk__pu32=k-1m63prWx+XjzyhHg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Dec 13, 2021 at 11:29:36AM -0800, Linus Torvalds wrote:
> Looking at the patch, I mostly like the end result, although it
> highlights how odd that __cgroup_procs_start() thing is.
> 
> I wonder if that 'started' flag could be removed, and the
> css_task_iter_start() thing could be done at allocation time?
> 
> But I may just be confused. This is not a NAK, just a "that pattern
> looks slightly odd to me".

Yeah, it's a bit odd. So...

css_task_iters are stateful and a bit expensive to initialize, so we don't
want to do it from generic open path. However, we can add an open method for
cgroup_files and then do it from there.

However, while these files don't allow random seeking, they do allow seeking
to 0 to re-read the whole content, so the iteration start path needs to
handle both the initial read and subsequent repeating reads. While this can
be handled by starting iter on open and then always restarting it on
seq_start, that isn't ideal given the prior point. So, if we want to handle
it in the seq_start path, we need to distinguish the initial read and
re-reads anyway.

This may be neater if we start the iter from open and restart from seek so
that the seq_start method doesn't have to distinguish the two. However,
kernfs doesn't forward the seek event downwards (yet anyway).

So, there's a bit of awkwardness but it at least isn't gratuitous given the
surroundings.

Thanks.

-- 
tejun
