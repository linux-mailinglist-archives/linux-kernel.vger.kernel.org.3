Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915594A51F1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 22:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiAaV6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 16:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiAaV6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 16:58:16 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C78C061741
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:58:16 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id o64so15258960pjo.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r+qz8LPHQIQwZUdRcGVFAMk3kc6GZI9/0WNZBupSYfo=;
        b=B3KTZmMoOvCD4glVbDQHvSqx5s7Q0PX9O/L+S7MKjYyAvjQXvgPZWdd6pOmEcjyg8+
         Tnk2gUIBJ8581A2QemwSXSVDIPmuQW/7MB2g3o48mD3hqMUDBhZ6R1hJ2L3+2XaiH2j2
         f/4laO0zGZGxhTSZkbAqajzlb2hmzxP+DMc70wnTOIoIwJFIudxai1hQIW8MDeoAp81w
         HaCPVN6RGwSEgpFmhGWjHHp1ztoc4QJvxqw9+7h0QvwTbv1JaxKc3Pax8lZXq7g3tUi6
         vDEpEkxfUO+LKAoOdJbPiFVGqQArNJ4aTlN6H7eAz01C5v/H5X5WBfCLsR+6yBdLsMBl
         sXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r+qz8LPHQIQwZUdRcGVFAMk3kc6GZI9/0WNZBupSYfo=;
        b=6div6t2p94HzH0Oe2fkPhwRuGytTC80B0pLGCxnHV1bD7jc4U9G4qHD2Wc9o1rTYOR
         35+RnCU4FQi0UQ1+151hNOk71drcpTtEI7RqjH3TBDnV28+wEEUt8aKF9PWpYlLz9c21
         ATcDAOA8bSMqSjdGC+dVNIltZq/Lle/ZtFkyidJGwAlQX1Jjn8AOzFYa76H/xTx3VmrI
         Xcvf6e6/oUEfq75S15/+4oJfQCrfbdIcrUy8Aq0nBE/ut1CDlkSe1Aq31+Mb3gqu/pCD
         djHbSn4sP70rbAO4Blbb7IA5hmp3P2sM+VUJzyRCRhSazG8nhcAz84y31MsSVSVFRa7M
         i1zw==
X-Gm-Message-State: AOAM532vBnu2emP3ZY1SObzmjAHZk44dXJxLJuTQGLBuSPe83E7Tz05n
        k2PHbvzPU9VDIyC0YAGvrbYDKg==
X-Google-Smtp-Source: ABdhPJzymI3Tq53cUvOVF3y2/y/zhJknu2+Jy2/NvdzzAJkqvY7u8YiqOYZyFcLFAklTkmScgBd1uA==
X-Received: by 2002:a17:902:c702:: with SMTP id p2mr22405735plp.140.1643666295519;
        Mon, 31 Jan 2022 13:58:15 -0800 (PST)
Received: from google.com ([2620:15c:2c5:11:4532:8bb4:72bd:3289])
        by smtp.gmail.com with ESMTPSA id o5sm19873991pfk.172.2022.01.31.13.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 13:58:15 -0800 (PST)
Date:   Mon, 31 Jan 2022 13:58:10 -0800
From:   Igor Pylypiv <ipylypiv@google.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, Tejun Heo <tj@kernel.org>,
        linux-modules@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Changyuan Lyu <changyuanl@google.com>
Subject: Re: [PATCH] Revert "module, async: async_synchronize_full() on
 module init iff async is used"
Message-ID: <Yfhbcr7Ow/HGmHIo@google.com>
References: <20220127233953.2185045-1-ipylypiv@google.com>
 <CAHk-=whM5sHbOboEnPSfBZPQrLB-KCtzE+JXFxFRNgT95i37bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whM5sHbOboEnPSfBZPQrLB-KCtzE+JXFxFRNgT95i37bw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 09:39:12AM +0200, Linus Torvalds wrote:
> On Fri, Jan 28, 2022 at 1:40 AM Igor Pylypiv <ipylypiv@google.com> wrote:
> >
> > This reverts commit 774a1221e862b343388347bac9b318767336b20b.
> 
> Whee. That's from early 2013, more than 9 years ago.
> 
> > This works when modprobe thread is calling async_schedule(), but it
> > does not work if module dispatches init code to a worker thread which
> > then calls async_schedule().
> 
> Hmm.
> 
> You make a good argument:
> 
> > Commit 21c3c5d28007 ("block: don't request module during elevator init")
> > fixed the deadlock issue which the reverted commit 774a1221e862 ("module,
> > async: async_synchronize_full() on module init iff async is used") tried
> > to fix.
> >
> > Since commit 0fdff3ec6d87 ("async, kmod: warn on synchronous
> > request_module() from async workers") synchronous module loading
> > from async is not allowed.
> 
> This does seem to imply that limiting it to PF_USED_ASYNC is largely
> pointless, at least for the originally stated reason of deadlocks with
> other module loading.
> 
> However, we've done this for *so* long that I wonder if there might be
> situations that have ended up depending on the lack of synchronization
> for pure performance reasons.
> 
> If *this* module loading process started the async work, then we'd
> wait for it, but what if there's other async work that was started by
> others? This revert would now make us wait for that async work too,
> and that might be a big deal slowing things down at boot time.

Thanks Linus! It is not like we have no wait at all today, we have it
for drivers that call async directly (not through a worker). A potential
future refactor of some driver to start using async may also "suddenly"
enable synchronization through PF_USED_ASYNC.

In case someone encounters a noticeable boot time slowdown they can pass
the 'async_probe' parameter to probe a waiting module asynchronously.

> 
> Looking at it, this is all under the 'module_mutex', so I guess we are
> already single-threaded at least wrt loading other modules, so the
> amount of unrelated async work going on is presumably fairly low and
> that isn't an issue.
> 
> Anyway, I think this patch is the right thing to do, but just the fact
> that we've avoided that async wait for so long makes me a bit nervous
> about fallout from the revert.
> 
> Comments? Maybe this is a "just apply it, see if somebody screams" situation?
> 
>                    Linus
