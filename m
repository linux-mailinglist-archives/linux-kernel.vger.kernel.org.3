Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6316B597FFB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 10:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239901AbiHRIVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 04:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238360AbiHRIVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 04:21:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31A97B29E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 01:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mL8X4OfaQTXVA+tf8yVDYsC95eKOM5LzgeI9p9+rv7I=; b=YHCU+z5Lmko23UOfe1eFovOzUl
        97UK7R6qPDomeoNJxCi1HHg0Y8JgEiMof5RTkIBDhjHV7s1ClznNdq45SoyH47asLc2VT4fL4JINo
        j2MVz3WPRSjpUayfGorQYg3lDOsaf9coCs9UMzdQrhAERwEtT7ShafPu7B6BrMUgy+T5WYWe1+E/E
        j0A4veiGPeidSaoOlf4Mz22j/5/lIZGwCtK797d69ujal+fy9uECOXpWBfFm+SE/FS2mFKDzngjgg
        cNff3K0C7MO+FMfXdxG8DbSBN184Ydp6/e7mbphvMUROJXZ1LQM8Obi4X2XP/chugR4m+VSB5crVv
        Na0i3feQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oOalv-009VxK-J1; Thu, 18 Aug 2022 08:20:59 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D5B669801D4; Thu, 18 Aug 2022 10:20:57 +0200 (CEST)
Date:   Thu, 18 Aug 2022 10:20:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 0/9] Replace PREEMPT_RT ifdefs with
 preempt_[dis|en]able_nested().
Message-ID: <Yv32aXMKwqmVMR1F@worktop.programming.kicks-ass.net>
References: <20220817162703.728679-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817162703.728679-1-bigeasy@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 06:26:54PM +0200, Sebastian Andrzej Siewior wrote:
> Folks,
> 
> this is the follow up to the "vfs.git pile 3 - dcache" pull request [0].
> It was concluded that the introduction of
> 	preempt_disable_nested()
> 
> in general makes sense and should be used in places where preemption on
> !RT is disabled by other means and PREEMPT_RT need to explicitly disable
> it.
> 
> This series introduces the macro and converts already existing users to
> that macro. The u64_stat interface was simplified to make the change
> simpler and code easier to follow.
> 
> [0] https://lore.kernel.org/all/YurA3aSb4GRr4wlW@ZenIV/

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
