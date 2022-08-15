Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A72592A8F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 10:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241045AbiHOHnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiHOHnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:43:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF70175B6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xvEuimPI9WdX6SDCYZklFCMp8CvSiZr5wMIfecd10Rk=; b=wQnP/vp5OhvqTdXNVB3uANqKWK
        sk63ppLqkCrIjjQHp8g3KftE/9lSpdzbDn5PR1NvqkcXnqWbmR94BtZTDbjfqwpCkfpsE+qGPXD05
        /aflIUbgKa6cYjbQ0JiET2iHr+ICXPs2qmh7Q7WkC5yLIYZmwKK9MwnHoHtOhhepo5M7l4Jrum9A9
        4huqXccz56iMobwnNnEBfho+nAr9Xy32uoTU5RGOvKt+b3PvVmZavpD0HNfplYeGzwxdNTOR7udN7
        FsS7OG6PzLD0vUXSi5ntQ3FEeH06pi1fD5G8rNCRfxtQ132xS1bltedabI8dlaN1Bdkhix5uedH7u
        IrTekRsg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNUkX-005Wm4-IG; Mon, 15 Aug 2022 07:43:01 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B8746980264; Mon, 15 Aug 2022 09:43:00 +0200 (CEST)
Date:   Mon, 15 Aug 2022 09:43:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 3/5] x86/microcode/intel: Allow a late-load only if a min
 rev is specified
Message-ID: <Yvn5BNXfOm3uA7WA@worktop.programming.kicks-ass.net>
References: <20220813223825.3164861-1-ashok.raj@intel.com>
 <20220813223825.3164861-4-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220813223825.3164861-4-ashok.raj@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 13, 2022 at 10:38:23PM +0000, Ashok Raj wrote:

> The proposal here is an even simpler option. The criteria for a microcode to
> be a viable late-load candidate is that no CPUID or OS visible MSR features
> are removed with respect to an earlier version of the microcode.
> 
> Pseudocode for late-load is as follows:
> 
> if header.min_required_id == 0
> 	This is old format microcode, block late-load
> else if current_ucode_version < header.min_required_id
> 	Current version is too old, block late-load of this microcode.
> else
> 	OK to proceed with late-load.

What about ucode that adds CPUID bits? Since the kernel will not re-init
it will not pick up on those. But userspace might.

Should we at all time enable CPUID intercept to ensure user visible
CPUID doesn't change?
