Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D2C50DDD4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 12:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237981AbiDYK2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 06:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiDYK2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 06:28:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B15C2B6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 03:25:00 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650882298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LrjI0KpptlrY2LjgfgEGKZ7SyDu/CVkNe9NKigAr3ZQ=;
        b=XST4LB0QD50gHg+l/sr5c0tOYNFU/B5ftA6ufvUiumjDoeuiQGjBmaKHseFw0OasKAwtcW
        zLlFuEW63r91aGkmJwkKTKiy7fvQzBNpTbQXo57p0Gl2FORMbB3uJE1oVttQUSQxPPszvF
        yhEwYBHfRGH5Ev5oHXhO/oMYsHUuY8/1V1SRZwDpvKMIFqSiJZMnWFG4vnLWQfqR7Twcwa
        wDrWplfxtg4TV64FxbxZfcrfRWURvO2+Ue0A5cWCtQpXHStclOuFlpNAVILfA79xe1i1E9
        HUiBjYid5TNwN/xCfNuRMnst2wO4U3cOesj9TzeB1G4xdoUdffLsfCuB6ckl4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650882298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LrjI0KpptlrY2LjgfgEGKZ7SyDu/CVkNe9NKigAr3ZQ=;
        b=4M92YkAQVmcoIMZ6s4owRexwkEn05LMV1i/5tOhaGu04FPZj8ChyuahT2wFI6XGQGIhRcQ
        F0LVugcBy9UfIaCw==
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH V5 7/7] x86/entry: Use idtentry macro for
 entry_INT80_compat
In-Reply-To: <20220412121541.4595-8-jiangshanlai@gmail.com>
References: <20220412121541.4595-1-jiangshanlai@gmail.com>
 <20220412121541.4595-8-jiangshanlai@gmail.com>
Date:   Mon, 25 Apr 2022 12:24:57 +0200
Message-ID: <877d7d31fq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12 2022 at 20:15, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
>
> entry_INT80_compat is identical to idtentry macro except a special
> handling for %rax in the prolog.

Seriously?

> -	pushq	%rsi			/* pt_regs->si */
> -	xorl	%esi, %esi		/* nospec   si */

esi is not cleared in CLEAR_REGS. So much for identical.

Thanks,

        tglx


