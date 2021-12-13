Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41CDD473687
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 22:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239169AbhLMVZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 16:25:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37322 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhLMVZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 16:25:39 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639430737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=kKg/Ru1mrL3CRca/rHYFA47EBFxk/C1mwXG1abQmNqE=;
        b=FbEIN5jmaluARWY/P3b1TVgydkUlmjs25YbsUXRn1Rko/JDfG9LeEWfVMxD5Rc8NzxHGxy
        LlVK7+FNf8hnq3wMw0KQXag40R0EadYDxLpAApX18Ja6BSsO218gJBrzgSdVgEJyyFEYMx
        ZElEhUE83IRdbt6v0E5jqzC+eLCjniKIsQc4gdXHsnTJYYLmyvAewgIaOxToV0KOGFU382
        PSefB02cgouvGKBUf80itxBOs1yHZaESGGTSf2NDA2z+BJ2z3jf1eF3rQCXvvVMnKWWPad
        GQa9EXBKwDnbtkIWjAAEywrHBPBOvpdKKEa7JpSwYUWiIePwlWueFN8dpbrPSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639430737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=kKg/Ru1mrL3CRca/rHYFA47EBFxk/C1mwXG1abQmNqE=;
        b=zXac47gig5VRS+mHQdSUzN/tcg39ejTyu+3k4fxbcu8eR+LATKvhDomMPIc2O6LnjgLy3r
        zugUeSiusbpYFVDg==
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, ebiederm@xmission.com,
        oleg@redhat.com, bp@alien8.de, x86@kernel.org,
        chang.seok.bae@intel.com
Subject: Re: [PATCH v2] signal: Skip the altstack update when not needed
In-Reply-To: <20211210225503.12734-1-chang.seok.bae@intel.com>
Date:   Mon, 13 Dec 2021 22:25:37 +0100
Message-ID: <87pmq0tcxa.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10 2021 at 14:55, Chang S. Bae wrote:
> do_sigaltstack() acquires sigaltstack_lock() and is used for both
> sys_sigaltstack() and restoring the sigaltstack in sys_sigreturn().
> Check for changes to the sigaltstack before taking the lock.  If no
> changes were made, return before acquiring the lock.
>
> This removes lock contention from the common-case sigreturn path.
>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> [1] https://lore.kernel.org/lkml/20211207012128.GA16074@xsang-OptiPlex-9020/
> Fixes: 3aac3ebea08f ("x86/signal: Implement sigaltstack size validation")
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
