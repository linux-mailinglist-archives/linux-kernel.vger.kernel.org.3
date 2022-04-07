Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1404F7989
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242944AbiDGIYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242928AbiDGIYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:24:35 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3ED5D5D5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 01:22:33 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9EB471EC0576;
        Thu,  7 Apr 2022 10:22:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649319747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5Hb/bWnnQF7B+DwLlDibGcNGX0QaOWAblGZu3fJEPkc=;
        b=grJh0Z2KtRu7pqvtr/Np+PhXKwilRe5qUTPemZGU7MQdQOBHNWleo0Y1vKlplBu8nTEMbk
        JO2oX5/9sKS0lnW+HDsjDTlp/PgUvkDBknXGeN5MesyTGWREZ0x4RgF1lMHx+tMRwFdTM4
        BUDYnKa4LCLeJ5voQvBe6qwWj5FQvPM=
Date:   Thu, 7 Apr 2022 10:22:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH V4 1/7] x86/traps: Move pt_regs only in fixup_bad_iret()
Message-ID: <Yk6fQfgo975pW3t0@zn.tnic>
References: <20220318143016.124387-1-jiangshanlai@gmail.com>
 <20220318143016.124387-2-jiangshanlai@gmail.com>
 <Yk3jVrXoVpxuR0Mp@zn.tnic>
 <CAJhGHyBFbtyUs-nf0+gWm2a3hiS5BxZ3jk=sbGNw-4ShB8AtzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJhGHyBFbtyUs-nf0+gWm2a3hiS5BxZ3jk=sbGNw-4ShB8AtzQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 03:03:08PM +0800, Lai Jiangshan wrote:
> sync_regs() is called before the return address of error_entry()
> popped into %r12 while fixup_bad_iret() is called with the return
> address of error_entry() still on the stack.  And the primitives of
> fixup_bad_iret() and sync_regs() are different which also means
> they are not the same way.
> 
> After this change, they become the same way.
> 
> IMO, sync_regs() is grace while fixup_bad_iret() is a bad C function
> or is not a pure C function because it is handling the return address
> of its parent function which is better done by the compiler or ASM
> code.

Maybe there was a reason it was done this way:

  b645af2d5905 ("x86_64, traps: Rework bad_iret")

although I don't see anything relevant in the text explaining this.

Andy?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
