Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C6B4D9779
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346507AbiCOJTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346501AbiCOJTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:19:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1095C13D3F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 02:18:24 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7FFBD2190B;
        Tue, 15 Mar 2022 09:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647335903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1rQtbpI9yXo7d/IEWUrA6KgT48bWf5DibIth9r8UJJ4=;
        b=LFYLxsGcYYxphngnjanBQl3HelQ95Kv0KQEKnEgQfN5p5rIEkKaC27Wzyf2pfntijdEn/a
        bm1nYO8N2oKXnuXdwDFzdFeYGMIHUlDUHzW6Xshuq9lSLOLdw6M+noYdgbEHl0QO6PynkJ
        y6DIS1QjTK+PISKX9LxI1WJRw0feeO4=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 15D02A3B8A;
        Tue, 15 Mar 2022 09:18:22 +0000 (UTC)
Date:   Tue, 15 Mar 2022 10:18:20 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Cai Huoqing <caihuoqing@baidu.com>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linux/kthread.h: remove unused macros
Message-ID: <YjBZ3Ir3H7IM9Pfj@alley>
References: <20220314145343.494694-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314145343.494694-1-linux@rasmusvillemoes.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-03-14 15:53:42, Rasmus Villemoes wrote:
> Ever since these macros were introduced in commit b56c0d8937e6
> ("kthread: implement kthread_worker"), there has been precisely one
> user (commit 4d115420707a, "NVMe: Async IO queue deletion"), and that
> user went away in 2016 with db3cbfff5bcc ("NVMe: IO queue deletion
> re-write").
> 
> Apart from being unused, these macros are also awkward to use (which
> may contribute to them not being used): Having a way to statically (or
> on-stack) allocating the storage for the struct kthread_worker itself
> doesn't help much, since obviously one needs to have some code for
> actually _spawning_ the worker thread, which must have error
> checking. And these days we have the kthread_create_worker() interface
> which both allocates the struct kthread_worker and spawns the kthread.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Makes sense.

Acked-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
