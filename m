Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01E44CFEF0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237322AbiCGMj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiCGMj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:39:57 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F70D419A9;
        Mon,  7 Mar 2022 04:39:03 -0800 (PST)
Received: from nazgul.tnic (nat0.nue.suse.com [IPv6:2001:67c:2178:4000::1111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2C9DD1EC0373;
        Mon,  7 Mar 2022 13:38:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1646656736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rV0+tZuhGoDxY69jUN7iTJa185bniGGbHQV7C81Odz0=;
        b=izJE9st1GWUDeJQkgmfjNE3OplstXHOuFVJPLsXikqQYHJR8rD7PE0Ujs7MGP1IArmUpxj
        H7c/L/5pdnzUv01eBaaiIoZ32IsjcAYSBteNl2A9Lkkg4GRGJhO2DiROkupIaiVcXI/UmR
        EbKZ6EQ9pPtXNJYqAyTpV/l21ctnV8A=
Date:   Mon, 7 Mar 2022 13:38:59 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Youquan Song <youquan.song@intel.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        gwml@vger.gnuweeb.org, x86@kernel.org
Subject: Re: [PATCH v1 0/2] x86: Avoid using INC and DEC instructions on hot
 paths
Message-ID: <YiX81kD/668UdFBr@nazgul.tnic>
References: <20220307114558.1234494-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220307114558.1234494-1-ammarfaizi2@gnuweeb.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 06:45:56PM +0700, Ammar Faizi wrote:
> In order to take maximum advantage of out-of-order execution,
> avoid using INC/DEC instructions when appropriate. INC/DEC only
> writes to part of the flags register, which can cause a partial
> flag register stall. This series replaces INC/DEC with ADD/SUB.

"Improvements" like that need to show in benchmark runs - not
microbenchmark - that they bring anything. Just by looking at them, I'd
say they won't show any difference. But I'm always open to surprises.

Btw, you don't have to send all your patches directly to me - there are
other x86 maintainers. IOW, you can use scripts/get_maintainer.pl to
figure out who to send them to.

Also, I'd advise going over Documentation/process/ if you're new to this.
Especially Documentation/process/submitting-patches.rst.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
