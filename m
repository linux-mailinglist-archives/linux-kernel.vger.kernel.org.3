Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E60148BE03
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 06:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiALFCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 00:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiALFCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 00:02:50 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1EBC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 21:02:49 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id kl12so1736626qvb.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 21:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=KFpreeJOa09J1P7gf+hNJT3B4ZftF/zoJ3KRQCsPlho=;
        b=dIiVlGHbDok+X9s/PRCVB6Le+sratTCI0QwBWS7FwNTnNfSoNx0QZey6wtG+BXwY/E
         QczVy3mCSI0piwZShY3ZcVUZsGtLOgqfprfGfpAwuHjpUJ3HiqJzYSLzgnoK5c8DV7WS
         2khZAllAvWZZCsp5iqxGCyY52JF9rq8w0JqfrXzISpHgdNH8tmE+2nW7R4NQwkNZe1Ma
         XPUcex/WCTOYh/CHASd2HwnGnaj1QMSQ3safUVTnxKfuI5bOQ+OoyXPqh05zzeMu2Jqd
         i6ivLGrmtTeNmcunngr8vOsOYCKw4rT7NE8SQxhwaq9VQqmzgki53ehdzUc1PQmqzByE
         IcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=KFpreeJOa09J1P7gf+hNJT3B4ZftF/zoJ3KRQCsPlho=;
        b=PwZ1lUuTrGhgF2C9EdygpNdFq737FAmD1lrylG2OWYJUWSgA65PDtnvc13KZ/g+hP+
         oMrLW2wCwxKL8IKxQ/eA8zrJzBootZbxBk8aLeaRMQ77LWNuilY4SkQU18W1nTsNQBEq
         5UyjLLwKlw0cF2MWloauO3xIWYuQZU+h2DZ5q91b9BC81dpr+MdCYS6ERr1V8l74RL5R
         lrYKFLQ1RLLPDi+Vk4xWidxKexilNIorSCy7beD9lZWyoUlaioNyy3G7YPtADH82fYHc
         +avRz6HvAIGzzlidVfGzqLgXKV6SNksdm4eg7Wnod6ju3wiVLjBA6jyM5x/kKvcnE2P3
         JHDg==
X-Gm-Message-State: AOAM5330+y7blOqL1iPauwr/hd45SuafgVfa/o72stKwZZ6EZURHb0ev
        ihVSQWV8rYMZG5A2jcwwoz6aig==
X-Google-Smtp-Source: ABdhPJwDc/NA9+I44clTwhOqDnbPfHIMXSZmMJ123HgmVJsI8rz3BzUH6xKNeXXt/7sENuW0Twf4Ww==
X-Received: by 2002:a05:6214:d45:: with SMTP id 5mr6663620qvr.66.1641963767989;
        Tue, 11 Jan 2022 21:02:47 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t6sm7967728qkj.33.2022.01.11.21.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 21:02:47 -0800 (PST)
Date:   Tue, 11 Jan 2022 21:02:45 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Yang Shi <shy828301@gmail.com>
cc:     Hugh Dickins <hughd@google.com>,
        Peng Liang <liangpeng10@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        xiexiangyou@huawei.com, zhengchuan@huawei.com,
        wanghao232@huawei.com
Subject: Re: [RFC 0/1] memfd: Support mapping to zero page on reading
In-Reply-To: <CAHbLzkrt_3vA7h=jYf-RjPv3Myh-Duz62WqsjHmR30csM8MQzQ@mail.gmail.com>
Message-ID: <9e96fc57-6810-9efd-c1fc-4c8a54b125@google.com>
References: <20211222123400.1659635-1-liangpeng10@huawei.com> <4b1885b8-eb95-c50-2965-11e7c8efbf36@google.com> <CAHbLzkrt_3vA7h=jYf-RjPv3Myh-Duz62WqsjHmR30csM8MQzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022, Yang Shi wrote:
> On Tue, Jan 11, 2022 at 6:30 PM Hugh Dickins <hughd@google.com> wrote:
> >
> > But I have to say that use of ZERO_PAGE for shmem/memfd/tmpfs read-fault
> > might (potentially) be very welcome.  Not as some MFD_ZEROPAGE special
> > case, but as how it would always work.  Deleting the shmem_recalc_inode()
> > cruft, which is there to correct accounting for the unmodified read-only
> > pages, after page reclaim has got around to freeing them later.
> 
> I'm wondering if we could use ZERO_PAGE for shmem_getpage() too so
> that we have simpler return value? Currently shmem_getpage() returns:
> #1. errno and NULL *pagep
> #2. 0 and valid *pagep
> #3. 0 and NULL *pagep if SGP_READ
> 
> Using ZERO_PAGE should be able to consolidate #2 and #3 so that we
> know there must be valid *pagep if 0 is returned.

At an earlier stage of mm/shmem.c's life, shmem_getpage() did return
ZERO_PAGE rather than NULL for that case; but I found it works out
better the way it is now (despite I'm not a fan of *pagep generally).

So I've no zest for messing with that now - though it's possible that
if we did extend the use of ZERO_PAGE, I'd look again and decide that
your change is then the best.

One reason for NULL rather than ZERO_PAGE was actually to help avoid
the cache-dirtying get_page/put_page on the thing; but that appears
to have gone missing at some point.  I have a patch in my tree which
fixes that, but held back from sending it in because it also used
iov_iter_zero() instead of copy_page_to_iter().  Obviously a good
improvement... except that whenever I timed it I found the opposite.
So, set aside on a shelf, to look into some other time.

> This should make read-fault use ZERO_PAGE automatically.

But I don't want to make read-fault use ZERO_PAGE automatically:
I want to be rather careful about that change!

Hugh
