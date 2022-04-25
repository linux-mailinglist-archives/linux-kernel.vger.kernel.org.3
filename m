Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418B550E2AA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242362AbiDYOJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242356AbiDYOJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:09:13 -0400
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DD417E22
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:06:06 -0700 (PDT)
Received: by gentwo.de (Postfix, from userid 1001)
        id C740DB007C2; Mon, 25 Apr 2022 16:06:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1650895564; bh=nDKTXvgIrS0KW55Y8bufayt9wZdLWKMW/+y5ICeabUg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=HUuJvmqsL7jRfNorE28mQo/poBW1j2BTtD+bAkVS0T2ya8XCyVi6D6LmbvBwM9ZTQ
         w7uRR+5vOektZFT775qvqH1rkaDOXVQadFuq5m7fcwiMI8X+mttqoaJounXE2plgKJ
         zgbkKdWGpTyGl9KPIjyXN06vx0uesngoxynakt5ApbNgzkR4dr55macmGAIyf0YG7t
         18z5bg6hMaAJHJt9CaTI6UhZLiqE1RsBp7ll/UBEEaqxxewjCncuX2+LQFA9DrkPyj
         fxZYsmCL0d8dEfO0Ij8cXUEC+hipz/sIRRWwDT7Mzzn1EfLylaF1xkICRIz74FMT/E
         1gUlxM8QLcUpw==
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id C5F84B0072F;
        Mon, 25 Apr 2022 16:06:04 +0200 (CEST)
Date:   Mon, 25 Apr 2022 16:06:04 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Aaron Tomlin <atomlin@redhat.com>, frederic@kernel.org,
        mtosatti@redhat.com, tglx@linutronix.de, mingo@kernel.org,
        pauld@redhat.com, neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v3] tick/sched: Ensure quiet_vmstat() is called when
 the idle tick was stopped too
In-Reply-To: <20220425132700.GK2731@worktop.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.22.394.2204251603570.25814@gentwo.de>
References: <20220422193647.3808657-1-atomlin@redhat.com> <alpine.DEB.2.22.394.2204250919400.2367@gentwo.de> <20220425113909.u3smtztp66svlw4o@ava.usersys.com> <alpine.DEB.2.22.394.2204251406370.13839@gentwo.de>
 <20220425132700.GK2731@worktop.programming.kicks-ass.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022, Peter Zijlstra wrote:

> > Folding the vmstat diffs *always* when entering idle prevents unnecessary
> > wakeups and processing in the future and also provides more accurate
> > counters for the VM allowing better decision to be made on reclaim.
>
> I'm thinking you're going to find a ton of regressions if you try it
> though; some workloads go idle *very* shortly, doing all this accounting
> is going to be counter-productive.

Well there is usually not much to do in terms of accounting. If there are
a lot of updates then it is worthwhile because if the numbers are off too
much then the VM has trouble assessing its own situation.

It may depend though on how long the idle periods are. Do we have
statistics on the duration? Always folding the vmstat deltas may also
increase the length of the idle periods.


