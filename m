Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F3E4FE3DC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 16:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356559AbiDLOdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 10:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356534AbiDLOdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 10:33:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD53F4A3CB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 07:31:03 -0700 (PDT)
Received: from zn.tnic (p200300ea971b584e329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:584e:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8282A1EC0554;
        Tue, 12 Apr 2022 16:30:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649773858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=azouk53nbJymdhnkRXMO6BvyBEYbFc3lbiaLs5eBsUo=;
        b=qKintlyHvkAAcSiK+ECfAX1eM0lC6K5OjVhRUZA0wnDi+m8L+W73NmNoYzh9bJnT4j63oH
        3tzcGGjCJMswwztIXC3B4p83VGVzZmAWoFYzEFjyOf2W0+GZUkbryEC9gtMj99x8k99jhF
        VhHbZFBR/fJZAH9wj64QnxjWQPmCapA=
Date:   Tue, 12 Apr 2022 16:30:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH V5 3/7] x86/entry: Move PUSH_AND_CLEAR_REGS out of
 error_entry()
Message-ID: <YlWNIj198mKM3hMG@zn.tnic>
References: <20220412121541.4595-1-jiangshanlai@gmail.com>
 <20220412121541.4595-4-jiangshanlai@gmail.com>
 <YlV+B8faRD2lDoO3@zn.tnic>
 <CAJhGHyAsPZAeXUoOa5LJ5bxuMOWzg=cvYNYPVT9kpBM7Tsf3xA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJhGHyAsPZAeXUoOa5LJ5bxuMOWzg=cvYNYPVT9kpBM7Tsf3xA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 09:52:44PM +0800, Lai Jiangshan wrote:
> The mapped size for the text is always 2M when the kernel is booted
> since it is 2M-aligned.  So I don't think the size is a concern.

This is not how this argumentation works: you add 0.01% size increase
here, 0.01% slowdown there and it all soon adds up into a bloated
kernel. Besides, nowadays the kernel runs a lot as a guest and guest
kernel size does matter.

So no, just because you want to turn error_entry() into C code and for
that you'll add some bloat doesn't justify it in my book. All changes to
core code need to be absolutely needed and justifiable.

> For example, a heavy page fault and IPI or timer at the same time.
> I'm not sure if it is a real case.

I wouldn't be surprised if it shows in some perf profiles.

> I'm Okay with asm_error_entry().  And also we can use an ASM function
> containing PUSH_AND_CLEAR_REGS only.

Just do the necessary and minimal thing - this is core code and in asm
for that matter, so be conservative pls. This is not some random driver.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
