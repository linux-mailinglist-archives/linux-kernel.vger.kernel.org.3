Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C320451056B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 19:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbiDZRbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 13:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242618AbiDZRbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 13:31:15 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEC16EB32;
        Tue, 26 Apr 2022 10:28:07 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6A2C71EC04F9;
        Tue, 26 Apr 2022 19:28:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1650994082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WAOGG0OkpdT6SFUFkDwSRCJIK2b9iJROhZINeRXHsyQ=;
        b=TZENyvqdhyawlUAK9vwmhZucaAdPMq8m7nHO78qFioNOuw664oY33uTH5tXWyfhB+mkA7d
        3PG+BxTIQxlkjlNkUdy7OEeWwJlvrZgHk231FeeXbSY7YgTBf9qWQDH4SElg4yh6oagqrq
        c/+lRxdH/edHObAUi/zQRiY3s2W09GI=
Date:   Tue, 26 Apr 2022 19:27:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Chen Yu <yu.c.chen@intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/pm: fix false positive kmemleak report in
 msr_build_context()
Message-ID: <Ymgrn03YqecDlPOB@zn.tnic>
References: <20220423182410.1841114-1-matthieu.baerts@tessares.net>
 <YmgOP1FFmidS9ecJ@zn.tnic>
 <CAJZ5v0gzvOagiYsMxznksrjmtZFV873DaLAiOo4YHkoUq5qTTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gzvOagiYsMxznksrjmtZFV873DaLAiOo4YHkoUq5qTTA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 06:24:04PM +0200, Rafael J. Wysocki wrote:
> So can the comment be dropped entirely?

Looks like it to me. All the accesses in wakeup_64.S are done through
those offsets which are computed at build-time so they should always be
valid.

OTOH, I wouldn't mind having there some text making any future person
touching this, aware of where to look when making changes.

Some changes like removing a struct member are nicely caught, ofc,
see below. But for something else which is a lot more subtle having a
comment say "hey, have a look at where this is used in wakeup_64.S and
make sure everything is still kosher" is better than having no comment
at all. IMHO.

Thx.

In file included from arch/x86/kernel/asm-offsets.c:14:
arch/x86/kernel/asm-offsets_64.c: In function ‘main’:
./include/linux/stddef.h:16:33: error: ‘struct saved_context’ has no member named ‘gdt_desc’
   16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
      |                                 ^~~~~~~~~~~~~~~~~~
./include/linux/kbuild.h:6:69: note: in definition of macro ‘DEFINE’
    6 |         asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
      |                                                                     ^~~
./include/linux/kbuild.h:11:21: note: in expansion of macro ‘offsetof’
   11 |         DEFINE(sym, offsetof(struct str, mem))
      |

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
