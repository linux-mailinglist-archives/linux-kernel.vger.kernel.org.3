Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9C04AA4D0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 01:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378598AbiBEAAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 19:00:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35328 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbiBEAAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 19:00:13 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644019211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mx9Em6t7Oq1XkCGBllE1H//5kNZjsQ4FsvjxDnQCdsI=;
        b=ZC/k4ygMJrw6KhHoq+lMoDt/kP5qXmR99l2FrtN0PFRAxhikYflsbFVcByf8t2HY+WsgUM
        rAsVLzDv/DH9qJ8MtCHpfPI2xZ0v/Q3ixkhH4MpDilGj6A4SiBWv76wZdNyQa1ZNoAcjYs
        6kf/Rvl6BRxpxlzmtvPV3I3aWmi66KIzLgtFGfJS4cPH6h/yYMQ1wh5XLQJwRRefTqdJN/
        0pUMmlNJptuNwr8/cMejjDrFJIjhbgNfuP+jKaDta+q4otsagp6p+wPNOSMUzL/lku3Q5N
        NfUWc26LHIszQxVS41725w6NdYp5ehCeF1pbSI7l2wpQzjHMTZ8qErO6Gw1DHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644019211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mx9Em6t7Oq1XkCGBllE1H//5kNZjsQ4FsvjxDnQCdsI=;
        b=fmhRS+PIT8HbTJahChStse4kensgIhjloMAre7/3TGNh+Th9f94mkf+siIs2XOjrYvgTz6
        JkWo3ipIJOarTdAg==
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v3 08/11] x86/traps: Demand-populate PASID MSR via #GP
In-Reply-To: <20220128202905.2274672-9-fenghua.yu@intel.com>
References: <20220128202905.2274672-1-fenghua.yu@intel.com>
 <20220128202905.2274672-9-fenghua.yu@intel.com>
Date:   Sat, 05 Feb 2022 01:00:11 +0100
Message-ID: <87iltub2t0.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28 2022 at 12:29, Fenghua Yu wrote:

> All tasks start with PASID state disabled. This means that the first
> time they execute an ENQCMD instruction they will take a #GP fault.
>
> Modify the #GP fault handler to check if the "mm" for the task has
> already been allocated a PASID. If so, try to fix the #GP fault by
> loading the IA32_PASID MSR.
>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
