Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B41051827A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 12:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbiECKrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 06:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbiECKq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 06:46:59 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10B727CE1
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 03:43:27 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 44E9D1EC0455;
        Tue,  3 May 2022 12:43:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651574602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MGqs4lJQFbl8dfxZVnfsgWQmvaJvZeWQprjaPfY59bE=;
        b=JVySlEPVwHiLI1NMPoxu8dLNSD9HgyBnWkPY5uGka7q3URAKYMbmk7nagvSd+x3htjlGKV
        kWV8+XC/Sw1B+DWg+feoyXCCQordYkzC00GL5xeLTe5KoMFpw02l7PF0RJLIiP2H/OSglg
        EjRtjWHEp+8zPFOmWh+Elr6lzcMFRMI=
Date:   Tue, 3 May 2022 12:43:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH V6 6/8] x86/entry: Convert SWAPGS to swapgs and remove
 the definition of SWAPGS
Message-ID: <YnEHRc9f4wEm7OUc@zn.tnic>
References: <20220421141055.316239-1-jiangshanlai@gmail.com>
 <20220421141055.316239-7-jiangshanlai@gmail.com>
 <Ymu2XC7k8Xj/vMjG@zn.tnic>
 <3db51f9f-317a-352a-4214-0f159b6cd34c@suse.com>
 <YnAbQK9kLdCxxGSf@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YnAbQK9kLdCxxGSf@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 07:56:16PM +0200, Borislav Petkov wrote:
> Ok, simpler asm, cool, let's do it then.

Yeah, just tried it, it needs more ifdeffery:

ld: arch/x86/entry/entry_64.o:/home/boris/kernel/linux/arch/x86/entry/entry_64.S:129: undefined reference to `xenpv_restore_regs_and_return_to_usermode'
ld: arch/x86/entry/entry_64_compat.o:(.altinstr_replacement+0x1): undefined reference to `xenpv_restore_regs_and_return_to_usermode'
make: *** [Makefile:1158: vmlinux] Error 1

Oh well.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
