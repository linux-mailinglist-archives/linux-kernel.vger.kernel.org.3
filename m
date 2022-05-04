Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B69519C7F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 12:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347658AbiEDKHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 06:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiEDKHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 06:07:18 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDB827FDD
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 03:03:42 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F3F881EC0455;
        Wed,  4 May 2022 12:03:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651658617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=s/3cncJOU4qM0gcfLHppWGqYw6qMtIl+q32RQ0tTaLg=;
        b=S4uCDmhv3rGIw+PB4eH6XR2CsSs7u0TZ7oZEtAqMdOHOOjHHh7ettK57tHeO66fHZQ7H8d
        3QouXbXAYgnZLhOCJtKr3Bia32Ypn31Lns00iXEror4RaSD0d8qjZYY+b67Hg1ueew4NoN
        0M26cKxDNPZyddAlggZoicY8HohObcU=
Date:   Wed, 4 May 2022 12:03:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/mm: Simplify RESERVE_BRK()
Message-ID: <YnJPdwQMQ7c+fAUP@zn.tnic>
References: <0e001c79794c46d619714d122c262147ed83f658.1651176151.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0e001c79794c46d619714d122c262147ed83f658.1651176151.git.jpoimboe@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 01:04:25PM -0700, Josh Poimboeuf wrote:
> RESERVE_BRK() reserves data in the .brk_reservation section.  The data
> is initialized to zero, like BSS, so the macro specifies 'nobits' to
> prevent the data from taking up space in the vmlinux binary.  The only
> way to get the compiler to do that (without putting the variable in .bss
> proper) is to use inline asm.
> 
> The macro also has a hack which encloses the inline asm in a discarded
> function, which allows the size to be passed (global inline asm doesn't
> allow inputs).
> 
> Remove the need for the discarded function hack by just stringifying the
> size rather than supplying it as an input to the inline asm.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  arch/x86/include/asm/setup.h | 30 +++++++++++-------------------
>  1 file changed, 11 insertions(+), 19 deletions(-)

Nice.

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
