Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC243552081
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243585AbiFTPWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244263AbiFTPW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:22:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54ABBC2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 08:16:34 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 91FEF1F8D4;
        Mon, 20 Jun 2022 15:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655738193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BAf076vfoeBSZ+0dOc1abGr7gkrgPSBGJwYFEHWAqLI=;
        b=T0jLZ/PBg41vLpGxlChwCCZROZomyYvZnF0w7/gzTFTZUIoAKrOO3NMzdye7JuPmyDKCQJ
        ET73fl9HvcMQte+TPBXiaZO8WsnbxQEEMB81tqOCHLU2UTvQ7qVjR/wxIn/7MqCoQoRQDZ
        hnZCllNnLUJ+Llir7j70MosC7Xqscoo=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6E5B92C141;
        Mon, 20 Jun 2022 15:16:33 +0000 (UTC)
Date:   Mon, 20 Jun 2022 17:16:33 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] printk/console: Enable console kthreads only when there
 is no boot console left
Message-ID: <YrCPUTah+Tu9P2V7@alley>
References: <20220619204949.50d9154d@thinkpad>
 <87r13kwawb.fsf@jogness.linutronix.de>
 <20220620112936.48fcb2a4@thinkpad>
 <YrBdjVwBOVgLfHyb@alley>
 <CAHk-=wgdquXVVE37CZooVK4X+YdSa7XoGtjr71CEYh8UsdKUow@mail.gmail.com>
 <YrCDNqsPrY+Hs9ju@alley>
 <YrCO04oNncE1xF5K@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrCO04oNncE1xF5K@alley>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-06-20 17:14:30, Petr Mladek wrote:
> The console kthreads uncovered several races in console drivers.
> All problems were in situation when a console was being properly
> initialized and registered while an early console, using the same
> port, was being used.
> 
> These problems are pretty hard to debug because they often result
> into silent boot crashes. It would be nice to fix them but it
> looks like a can of worms.
> 
> Prevent these problems by delaying the use of console kthreads
> after all early consoles are gone. It might later be optimized.
> But let's close this can of worms with a big hammer for now
> so that they do not break first impression on the kthreads
> that solve other real problems.

Marek, could you please try if this patch solves the problem
for you?

Best Regards,
Petr
