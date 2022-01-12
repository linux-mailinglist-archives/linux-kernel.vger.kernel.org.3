Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F039848C623
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354139AbiALOhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344321AbiALOhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:37:13 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032A4C061756
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 06:37:12 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id kc16so3119299qvb.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 06:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gN6nYxQ+pi+EX1rhDvVBrSftakRyc+dgBWa+b+GYGOw=;
        b=mUYM4mY5CMZFdZf8LoZxSmr2HrBtGWy/OuRuqq61O/YzMtji9cyv80GCzVs3+/yBQM
         ea8h1TgnQuxezzPUpv+dYIPkHwYXJi8s8RLc3/qoVBJIdyMcJhSjmxQmUkiMYq3Ma/mk
         FCYSRjNlYgSsNDINKB5/QzVJm37I8VUcYMKVK1npArHn3Q6M8h3+azxH7i00hNJ3x5GH
         /MOIqnam32dgIasH341bE3XTjvVfDKCVLNSfwExXT1QlmErmH+Ao3P6BgqP5XnvYn4WD
         4jkB6eQQ2fqopSlJvC4a/kF34giBDtsHPoVyc1PJ8OLUBC1+AAZopBx4/zXrVog6uTYo
         wZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gN6nYxQ+pi+EX1rhDvVBrSftakRyc+dgBWa+b+GYGOw=;
        b=etT7UWovQPwtxz9s4ZaJdnwhw4NaugQ3zqPOz3Q0vBaZCAJWa59Kf++pSQhumlQxn4
         J7DvGjzUwDjloEwxZBF2EXI10tqXcIZvEVe2XiPvWRym4obgfEKLRniCssWr2t/QibPR
         jCVpBrO0e1dOrhRnNeGExcpnUFoPgCUFbHbg1J6hKtN1h0K9fUqqvuzkyZNqOjCFmJjI
         l50REJ9PROi8uT185wThSwtm5LY8hnYo5Lg93Y32X2fhkfs2CmBoHkDEsPXvj3gHLKl7
         ns5AFtK9KdeHeBAb1lrVHRJLAthFhGqvrUbijeiItn9SRvC0LLWokJB8oxo69oqye+th
         Zg7w==
X-Gm-Message-State: AOAM533XA1eWxJ62/xrBzPJYkUy/bNTJQ04Zw4YW0FUrROV6F5+5QBqg
        MiA/xudasyfo2LGUw7faAp8IJw==
X-Google-Smtp-Source: ABdhPJxY1HshUCe33M5fQkNV7QxIC9vh6OAlDMc4ZVnOi5TLVs7F8THYxcCWfsxToe3z3GOWAGLkKg==
X-Received: by 2002:a05:6214:300a:: with SMTP id ke10mr8262318qvb.98.1641998232082;
        Wed, 12 Jan 2022 06:37:12 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id c17sm8211262qkl.90.2022.01.12.06.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 06:37:11 -0800 (PST)
Date:   Wed, 12 Jan 2022 09:37:10 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     torvalds@linux-foundation.org, ebiggers@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@android.com,
        syzbot+cdb5dd11c97cc532efad@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/1] psi: Fix uaf issue when psi trigger is destroyed
 while being polled
Message-ID: <Yd7nlpb5C1asdT9p@cmpxchg.org>
References: <20220111071212.1210124-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111071212.1210124-1-surenb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 11:12:12PM -0800, Suren Baghdasaryan wrote:
> With write operation on psi files replacing old trigger with a new one,
> the lifetime of its waitqueue is totally arbitrary. Overwriting an
> existing trigger causes its waitqueue to be freed and pending poll()
> will stumble on trigger->event_wait which was destroyed.
> Fix this by disallowing to redefine an existing psi trigger. If a write
> operation is used on a file descriptor with an already existing psi
> trigger, the operation will fail with EBUSY error.
> Also bypass a check for psi_disabled in the psi_trigger_destroy as the
> flag can be flipped after the trigger is created, leading to a memory
> leak.
> 
> Fixes: 0e94682b73bf ("psi: introduce psi monitor")
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+cdb5dd11c97cc532efad@syzkaller.appspotmail.com
> Analyzed-by: Eric Biggers <ebiggers@kernel.org>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

That looks good to me, thanks Suren.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Peter, would you mind picking this up and routing this to Linus
through the sched tree, please?
