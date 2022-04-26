Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17625101CE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344702AbiDZPZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347763AbiDZPZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:25:56 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470FE140B4;
        Tue, 26 Apr 2022 08:22:48 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 991441EC050D;
        Tue, 26 Apr 2022 17:22:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1650986562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MiyVowPK2hZlIKasSYAvE3SnRxXRBC3uvjngpKcSNns=;
        b=PMojOBU+k5aEJqxWh5hhGrd66DheMBQyYIe5EzbwXn0aux6LMi2JD/r0SB3la5wWJY23tR
        BtJR7dkdu94HUM0Iitc9EUzx96lXlqZsYbBt5hgdq325zYkkV+c+0caUm08/KbtNuqEHzh
        20ZBQDXPy90GfpaRhP7ol+LiNQBtkIQ=
Date:   Tue, 26 Apr 2022 17:22:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Chen Yu <yu.c.chen@intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/pm: fix false positive kmemleak report in
 msr_build_context()
Message-ID: <YmgOP1FFmidS9ecJ@zn.tnic>
References: <20220423182410.1841114-1-matthieu.baerts@tessares.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220423182410.1841114-1-matthieu.baerts@tessares.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 08:24:10PM +0200, Matthieu Baerts wrote:
> diff --git a/arch/x86/include/asm/suspend_64.h b/arch/x86/include/asm/suspend_64.h
> index 35bb35d28733..bb7023dbf524 100644
> --- a/arch/x86/include/asm/suspend_64.h
> +++ b/arch/x86/include/asm/suspend_64.h
> @@ -14,9 +14,13 @@
>   * Image of the saved processor state, used by the low level ACPI suspend to
>   * RAM code and by the low level hibernation code.
>   *
> - * If you modify it, fix arch/x86/kernel/acpi/wakeup_64.S and make sure that
> - * __save/__restore_processor_state(), defined in arch/x86/kernel/suspend_64.c,
> - * still work as required.
> + * If you modify it before 'misc_enable', fix arch/x86/kernel/acpi/wakeup_64.S

Why does before misc_enable matter?

arch/x86/kernel/asm-offsets_64.c computes the offsets and there is a
member like saved_context_gdt_desc which will get moved after your
change but that's not a problem because the offset will get recomputed
at build time.

Hm?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
