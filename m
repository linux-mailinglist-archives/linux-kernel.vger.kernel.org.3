Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9D7591247
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 16:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237772AbiHLOdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 10:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236950AbiHLOdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 10:33:21 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271C2A4B37
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 07:33:18 -0700 (PDT)
Received: from zn.tnic (p200300ea971b98b3329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98b3:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6DB971EC054C;
        Fri, 12 Aug 2022 16:33:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660314793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FunQRTUpDRWrn775UlH9qw4r9DD2TH89OT1Qf+BxEAU=;
        b=gEOZE9gv6b/i2qzz94i4sFzqm5XYoFNfTia14Mre5p0A2pq1D5rQl4bsWjHgCTtRxN0d72
        BCIkmJmxwOFPvL3w+KAFCUrFCDmzOaLGsd3rugBXlbuLI1HMW3MURckOIS2/gsHF64Jm1r
        DloTXwtsSbOXX5MqhVKRZ6jwBKZ1dyg=
Date:   Fri, 12 Aug 2022 16:33:09 +0200
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
Message-ID: <YvZkpYRfrgPLLoJV@zn.tnic>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <cover.1659978985.git.thomas.lendacky@amd.com>
 <21d5d55640ee1c5d66501b9398858b6a6bd6546f.1659978985.git.thomas.lendacky@amd.com>
 <YvZPoEm6PSeoflAz@zn.tnic>
 <6d9d433f-779d-7531-02b5-382796acceef@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6d9d433f-779d-7531-02b5-382796acceef@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 09:11:25AM -0500, Tom Lendacky wrote:
> There was a whole discussion on this

Pointer to it?

> and I would prefer to keep the ability to parallelize PSC without
> locking.

So smaller, on-stack PSC but lockless is still better than a bigger one
but with synchronized accesses to it?

> Well when we don't know which GHCB is in use, using that reserved area in
> the GHCB doesn't help.

What do you mean?

The one which you read with

	data = this_cpu_read(runtime_data);

in snp_register_per_cpu_ghcb() is the one you register.

> Also, I don't want to update the GHCB specification for a single bit
> that is only required because of the way Linux went about establishing
> the GHCB usage.

Linux?

You mean, you did it this way: 885689e47dfa1499b756a07237eb645234d93cf9

:-)

"The runtime handler needs one GHCB per-CPU. Set them up and map them
unencrypted."

Why does that handler need one GHCB per CPU?

As to the field, I was thinking along the lines of

	struct ghcb.vendor_flags

field which each virt vendor can use however they like.

It might be overkill but a random bool ain't pretty either. Especially
if those things start getting added for all kinds of other things.

If anything, you could make this a single u64 sev_flags which can at
least collect all that gunk in one variable ... at least...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
