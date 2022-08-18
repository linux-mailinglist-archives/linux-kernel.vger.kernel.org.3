Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAE55987EE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344470AbiHRPxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344417AbiHRPxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:53:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC21C2EBB
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 08:51:50 -0700 (PDT)
Date:   Thu, 18 Aug 2022 17:51:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660837908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nw7zcDj+K9USz7cINsz+q440zF4WL2SEeYRL+F6oeq4=;
        b=W5bVU45yaUBCcySwbHbdCRRPvJ3OTrkvoJ+OsuC10wXLrO72ApR2N11QsoIgW2N1ZMflDq
        tkEEJuEXziI+GYsYBcWlZ3/spYjw7KnfQuZXKAGLA1ivr7DZtm0naqoafWHkzxzBAjfJuO
        MlFAiNcR3rbSc818cyNDJPwKGjMZF61SxhA3o+pUNWDI6fXkG+tQv1m4Va1P1LVhBgvmrk
        /8ozbkwbpldqLEju9GijDd/fSZNzw29q+ghqZCPtQXErKRi/Gdn1XASxlsEXq/HbYM2QJG
        94wzliQsq/zf/u3KvczS14LqpXN1ZB7SIceG52Jf1/+viO12UArCJcL19AqsOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660837908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nw7zcDj+K9USz7cINsz+q440zF4WL2SEeYRL+F6oeq4=;
        b=egSiFYlfaqS4GzSS5Aia6u4zl1o6hF3XimTq8zzurL87yOu3htE+gZ4e0E6q5TiHzr2UAh
        ll9BpVcj7kytXnBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Terrell <terrelln@fb.com>, linux-mm@kvack.org
Subject: Re: [PATCH 7/9] mm/compaction: Get rid of RT ifdeffery
Message-ID: <Yv5gEwlx6RmI+CWv@linutronix.de>
References: <20220817162703.728679-1-bigeasy@linutronix.de>
 <20220817162703.728679-8-bigeasy@linutronix.de>
 <54a68cad-f15d-bef2-8627-3d3bfb6f030d@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54a68cad-f15d-bef2-8627-3d3bfb6f030d@prevas.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-18 10:55:28 [+0200], Rasmus Villemoes wrote:
> > --- a/mm/compaction.c
> > +++ b/mm/compaction.c
> > @@ -1727,11 +1727,7 @@ typedef enum {
> >   * Allow userspace to control policy on scanning the unevictable LRU for
> >   * compactable pages.
> >   */
> > -#ifdef CONFIG_PREEMPT_RT
> > -int sysctl_compact_unevictable_allowed __read_mostly = 0;
> > -#else
> > -int sysctl_compact_unevictable_allowed __read_mostly = 1;
> > -#endif
> > +int sysctl_compact_unevictable_allowed __read_mostly = CONFIG_COMPACT_UNEVICTABLE_DEFAULT;
> 
> Why introduce a Kconfig symbol for this, and not just spell the
> initializer "IS_ENABLED(CONFIG_PREEMPT_RT) ? 0 : 1" or simply
> "!IS_ENABLED(CONFIG_PREEMPT_RT)"?

The idea was to remove the CONFIG_PREEMPT_RT. However if this IS_ENABLED
is preferred, we can certainly do this.

> And if you do keep it in Kconfig, shouldn't the symbol be "depends on
> COMPACTION" so it doesn't needlessly appear in .config when
> !CONFIG_COMPACTION.

Sure, if we keep the Kconfig.

> Rasmus

Sebastian
