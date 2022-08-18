Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6EB5980FD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 11:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240930AbiHRJmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 05:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236969AbiHRJmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 05:42:07 -0400
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E18B14EE
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 02:42:03 -0700 (PDT)
Received: by gentwo.de (Postfix, from userid 1001)
        id E8493B002B2; Thu, 18 Aug 2022 11:42:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1660815720; bh=zhSk3gUIK+mDi9XiV4NGeRbdkgpqWbv2DEwABjWuxDQ=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=MOziH+YXigIkZ5JoZLci/yn9Gsmc5kVya7ebi8NlUx2Mk+PUFJzY6Pd9zDtq2u4ge
         HL5vzZwPLJJbtVtfiJHfbNJ2ZMX2wiIYJHr0EsvZMMIpl8eOJI52sU/DEScOsn6PSl
         X2ZGEaOwB7usppzCAszgv2dEF8pieXdlntgSGnVUL/OecgcrnoeM0akruQbsrtdFPC
         Qx6OWJtinEgPo28VEmfu3aB8KF4jfe31R3f9Ty00MssEDM4iYDbEhBgkvmxE0yaHcy
         kMFwttrnRmayXK04n4Seo5h32BPHNRDkP+M5p37qrByLFNc3SKkqLM0U3JXtFH+Gba
         u5pkcG1JMDpZw==
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id E48CDB00210;
        Thu, 18 Aug 2022 11:42:00 +0200 (CEST)
Date:   Thu, 18 Aug 2022 11:42:00 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Subject: Re: [PATCH 1/9] slub: Make PREEMPT_RT support less convoluted
In-Reply-To: <20220817162703.728679-2-bigeasy@linutronix.de>
Message-ID: <alpine.DEB.2.22.394.2208181136560.1901102@gentwo.de>
References: <20220817162703.728679-1-bigeasy@linutronix.de> <20220817162703.728679-2-bigeasy@linutronix.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2022, Sebastian Andrzej Siewior wrote:

> + *   On PREEMPT_RT, the local lock neither disables interrupts nor preemption
> + *   which means the lockless fastpath cannot be used as it might interfere with
> + *   an in-progress slow path operations. In this case the local lock is always
> + *   taken but it still utilizes the freelist for the common operations.

The slub fastpath does not interfere with slow path operations and the
fastpath does not require disabling preemption or interrupts if the
processor supports local rmv operations. So you should be able to use the
fastpath on PREEMPT_RT.

If the fastpath is not possible then you need to disable preemption and
eventually take locks etc and then things may get a bit more complicated.


