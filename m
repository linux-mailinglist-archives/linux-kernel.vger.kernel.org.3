Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DB959FC44
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236994AbiHXNxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238455AbiHXNxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:53:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266AC80021
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 06:50:14 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661349011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lxmXEz446Sqnmo7KcG5N2T9SivEVa9HXVqWIhBMNFOU=;
        b=Y9CwXl5tI8nfTomEGv6Q9MVs29s0Z8X0LJa8+17fJLSyiEQRNRR+VznWk5IUfFk95tBXaS
        hupXwKDgw3G6gkKoNZoia0z2eIgo/rXSMH3seBRJ9Ya1pgAwyZFG7F1Th0nVC+9CLvHJ95
        9auRsgWWrdPZWF+lKb9uKB1jOXvI167FHB/8vn5vqMweEPBrxyfjpI8dfdlTqqpj8F74st
        qTKRmN00sSe5KEdXBhoNN+vsNegYIVCwRCG7MRZfbJvggc/zo2uf6IDOrUABVAqwuDoea9
        XcyNQTl2v5oiNUvxkHH9jtxf6rMSMGltf2G/75SakfYLdG6LxOT5/1t8jpHGow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661349011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lxmXEz446Sqnmo7KcG5N2T9SivEVa9HXVqWIhBMNFOU=;
        b=QAKKYr/DzS3nyL69DUgS/aGsBL0v0xdMxE+TpnUuI3oliBHyJW7GbWwMX1QYAAcpf1iWDf
        O8b+HdQL5nzs5ZCQ==
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Terrell <terrelln@fb.com>, linux-mm@kvack.org
Subject: Re: [PATCH 7/9] mm/compaction: Get rid of RT ifdeffery
In-Reply-To: <54a68cad-f15d-bef2-8627-3d3bfb6f030d@prevas.dk>
References: <20220817162703.728679-1-bigeasy@linutronix.de>
 <20220817162703.728679-8-bigeasy@linutronix.de>
 <54a68cad-f15d-bef2-8627-3d3bfb6f030d@prevas.dk>
Date:   Wed, 24 Aug 2022 15:50:10 +0200
Message-ID: <871qt5zr71.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18 2022 at 10:55, Rasmus Villemoes wrote:
> On 17/08/2022 18.27, Sebastian Andrzej Siewior wrote:
>> -#ifdef CONFIG_PREEMPT_RT
>> -int sysctl_compact_unevictable_allowed __read_mostly = 0;
>> -#else
>> -int sysctl_compact_unevictable_allowed __read_mostly = 1;
>> -#endif
>> +int sysctl_compact_unevictable_allowed __read_mostly = CONFIG_COMPACT_UNEVICTABLE_DEFAULT;
>
> Why introduce a Kconfig symbol for this, and not just spell the
> initializer "IS_ENABLED(CONFIG_PREEMPT_RT) ? 0 : 1" or simply
> "!IS_ENABLED(CONFIG_PREEMPT_RT)"?

The reason for the config symbol is that Linus requested to have
semantically obvious constructs which can be utilized even without RT
and clearly spell out what the construct does. When RT selects this then
it's a documented requirement/dependency.

> And if you do keep it in Kconfig, shouldn't the symbol be "depends on
> COMPACTION" so it doesn't needlessly appear in .config when
> !CONFIG_COMPACTION.

Sure.

Thanks,

        tglx
