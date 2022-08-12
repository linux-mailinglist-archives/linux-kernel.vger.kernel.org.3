Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1387591122
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 15:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238879AbiHLNEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 09:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237763AbiHLNDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 09:03:42 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F4124BC2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 06:03:38 -0700 (PDT)
Received: from zn.tnic (p200300ea971b98b3329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98b3:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0B4AF1EC054C;
        Fri, 12 Aug 2022 15:03:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660309413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rxVLkbvNBovfojpBImP7y+g3dx0vMBlRsKjLna4naQc=;
        b=YB48Q+9PKC7TayFIL/Rda/07y5czDrfWi0t1pm0NuddPJBaykm0wpz63l6N3+ATOxCDk9X
        iaE9a6hFhNnH7Jd93pl26FKUzEyddFL+h09JG0kENcigpkx3xFLjA+j9G7wTM3kt1tHJef
        7oAIsQgumVOcOuq1TdDKDbIiupBhD7c=
Date:   Fri, 12 Aug 2022 15:03:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 1/2] x86/sev: Put PSC struct on the stack in prep for
 unaccepted memory support
Message-ID: <YvZPoEm6PSeoflAz@zn.tnic>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <cover.1659978985.git.thomas.lendacky@amd.com>
 <21d5d55640ee1c5d66501b9398858b6a6bd6546f.1659978985.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21d5d55640ee1c5d66501b9398858b6a6bd6546f.1659978985.git.thomas.lendacky@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 12:16:24PM -0500, Tom Lendacky wrote:
> In advance of providing support for unaccepted memory, switch from using
> kmalloc() for allocating the Page State Change (PSC) structure to using a
> local variable that lives on the stack. This is needed to avoid a possible
> recursive call into set_pages_state() if the kmalloc() call requires
> (more) memory to be accepted, which would result in a hang.

I don't understand: kmalloc() allocates memory which is unaccepted?

> The current size of the PSC struct is 2,032 bytes. To make the struct more
> stack friendly, reduce the number of PSC entries from 253 down to 64,
> resulting in a size of 520 bytes. This is a nice compromise on struct size
> and total PSC requests.

Why can't you simply allocate that one PSC page once at boot, accept the
memory for it and use it throughout? Under locking, ofc, if multiple PSC
calls need to happen in parallel...

Instead of limiting the PSC req size.

> @@ -1254,6 +1260,8 @@ void setup_ghcb(void)
>  		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
>  			snp_register_per_cpu_ghcb();
>  
> +		ghcb_percpu_ready = true;

You know how I can't stand those random boolean vars stating something
has been initialized?

Can't you at least use some field in struct ghcb.reserved_1[] or so
which the spec can provide to OS use so that FW doesn't touch it?

And then stick a "percpu_ready" bit there.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
