Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C81F52309F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 12:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbiEKKZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 06:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiEKKZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 06:25:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873E2419AB
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 03:25:32 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652264730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FvTtTosrdfTcQgZlaTKuPmjgkPSXixbHqYTPBhDJGnA=;
        b=onj834gkMoT7r6eNMXYpkSrGLmt+mLhhd5IX150TcfKDPs0PWlSPwgNELPg+/O/n+zwb8n
        sFDzugeq7H6p9iMRZmANrO4Ap47+SDjT2Q9IJ9Q6BA8XTK2h3A649YnEm0JdXEM+CyEEQt
        uv5T6p8og5wb4iBru+ZSo3fdjzONNkFO/mJWunp5cXagnZ2C/cKJpWEPSWdJcLcWd6l/3o
        smlCVKknzOrapu2ohYrQr/TikQiE3aUOy9eOhKE/lx4ANbKnG8aNsnMCJrJnhypdZ9SYT9
        n+66+a/TgFfrqhr4D6aySVQaK8IyUWJrAtEL1ZLTwCQa2bVgnHgdU9Trc/FAFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652264730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FvTtTosrdfTcQgZlaTKuPmjgkPSXixbHqYTPBhDJGnA=;
        b=ghfgmnlkCg25T3cbq+xGZ3xbsxD3AgQcHRtSi76bG89jYxwgnPEx9uYRSUBgmYFezRoICO
        1Z+2WiPl1POR93BA==
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH 2/7] x86/entry: Move PTI_USER_* to
 arch/x86/include/asm/processor-flags.h
In-Reply-To: <20220511072747.3960-3-jiangshanlai@gmail.com>
References: <20220511072747.3960-1-jiangshanlai@gmail.com>
 <20220511072747.3960-3-jiangshanlai@gmail.com>
Date:   Wed, 11 May 2022 12:25:30 +0200
Message-ID: <87h75wgycl.ffs@tglx>
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

On Wed, May 11 2022 at 15:27, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
>
> These constants will be also used in C file.
>
> Move them to arch/x86/include/asm/processor-flags.h which already has
> a kin X86_CR3_PTI_PCID_USER_BIT defined in it.
>
> Remove PTI_PGTABLE_SWITCH_BIT and replace it with PTI_USER_PGTABLE_BIT
> since they are the same in meaning and value.

Just from looking at the patch it's obvious that it breaks the 32bit
CONFIG_PAGETABLE_ISOLATION=y build. Sigh.

Thanks,

        tglx
