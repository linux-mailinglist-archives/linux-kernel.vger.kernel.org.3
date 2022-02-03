Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CB44A7D5C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 02:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348666AbiBCBL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 20:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347916AbiBCBLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 20:11:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7FFC061714;
        Wed,  2 Feb 2022 17:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hOhBEfGKJL5dh/rxk/8eoA7ifF1eXVxecJDpKir0EBg=; b=WbqtMNLydw8158tplU3bFDJ3z6
        Lbswcon7/7iW3KzzgNBMWBDSzH7m0equSARWFZNekgjXa+0pRMQKVeVQkAXSrTYfH5iRCE2M+Q/1c
        +YhLpXx6VcjD7fCM3X3tVQvAlKWDn5K6KhK7tlzpE48HGH9BiWJPs2QWZljsakjZ8rQaIrYO/GPr8
        i5tOsis+fpqQreFeksBrJFYW/VYoBT0XxKqdj+FJC1Qxh5wt4RhkOS8VXbG6dcyFYzCiGLyItNeSf
        ugIbEdyeky+QIRKGf76aTPl6OZUnV+3gTqsMkscQRnLlQdJ8TKsRb4Uof0ZdoDd8J7au6RCQ+534x
        L4XaPScg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFQee-00HHqw-AI; Thu, 03 Feb 2022 01:11:20 +0000
Date:   Wed, 2 Feb 2022 17:11:20 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Aaron Tomlin <atomlin@redhat.com>
Cc:     Igor Pylypiv <ipylypiv@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changyuan Lyu <changyuanl@google.com>
Subject: Re: [PATCH] Revert "module, async: async_synchronize_full() on
 module init iff async is used"
Message-ID: <YfsruBT19o3j0KD2@bombadil.infradead.org>
References: <20220127233953.2185045-1-ipylypiv@google.com>
 <YflxP28HlVrrNBU2@slm.duckdns.org>
 <Yfly0P4e84373mGF@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yfly0P4e84373mGF@slm.duckdns.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 07:50:08AM -1000, Tejun Heo wrote:
> On Tue, Feb 01, 2022 at 07:43:27AM -1000, Tejun Heo wrote:
> > That's quite a walk down the memory lane and I agree with your analysis. The
> > PF_USED_ASYNC is redundant for correctness with the removal of synchrnous
> > loading from iosched path and the WARN_ON guarantees that nothing in kernel
> > is creating a similar situation.
> > 
> > Acked-by: Tejun Heo <tj@kernel.org>
> 
> BTW, I can route this through workqueue tree but -mm or going to Linus's
> tree directly might be a better option. Any opinions?

FWIW, although I was not working on modules when the reverted commit was
merged, my take on this is concern for a regression, much more than
others. However I do agree that async probe can help for any slowdown,
and the idea was that folks would eventually strive slowly to make more
and more modules default to async probe as they can verify that's fine.

With that said,

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

And I'd prefer this go through Linus' tree since this is a fix and
can be merged already. That would help with Aaron's kernel/module.c
refactor work (no functional changes) too as that will soon slice and
dice that to a kernel/module/*.c files.

 Luis
