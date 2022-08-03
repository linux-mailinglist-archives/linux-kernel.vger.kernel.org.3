Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAA558894F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbiHCJXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiHCJXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:23:20 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9664719C09
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 02:23:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1659518528; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=SzxExxF41r8xJbjYBAxHqwNZWS/Ssh/9WBvq+2Gtd00hAo198E4JT31rAYkmDw86v78xUmcR0tU5SeGrAQ4sAiKk8xE46IM52zwuM16uwooNb6YSAHZ2gUph69jtFU9afOlIVgG9pwsM9msi9tcowhygGUUS1zQCtsF42RiVa6M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1659518528; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=q93C79sxRnF4sFFm2T+KqOAm96p2y3qDReUpm9q0LJ0=; 
        b=cNC7Z7LQKOI1+CahMUn2YzdJnnyEz8ElHhuk9YAcIV32Lh1WENQINuuBp1Z55+zFrOeg1qZwP9wzsiVzzT+rIuPAE7sovxnRaqXoLcVivx5ZcCqymk11neHxfda/2t4qAFoIuUQAb9rrKSWit9PNTU6eYkTAk4b28KwsjE0LRts=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1659518528;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=q93C79sxRnF4sFFm2T+KqOAm96p2y3qDReUpm9q0LJ0=;
        b=c2CT/HK4lMxHAskVAhHR2ECPKlso2vtKy8o2kk0F81AFTb/TqGY9jEvdTcNW5KUv
        kOhFXFNGY/6Moo7L5NTdPvmj6b9oZEtCTKKI1D1uU9KaTodb7Nm40sa/izK2uBBdje9
        duUjDI8a2HmIwOiVPljDKYx0095Uwoyb7nyYVNnE=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1659518517817516.3995624024521; Wed, 3 Aug 2022 14:51:57 +0530 (IST)
Date:   Wed, 03 Aug 2022 14:51:57 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Ingo Molnar" <mingo@kernel.org>
Cc:     "x86" <x86@kernel.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Message-ID: <18263030220.8a990e82436929.3216192040531777412@siddh.me>
In-Reply-To: <Yuo7A0KYoNnbgwWT@gmail.com>
References: <20220731160913.632092-1-code@siddh.me>
 <YukFgFTaq4Aw+uht@gmail.com>
 <1825f63b142.8968bde3116633.1242410031840350968@siddh.me>
 <Yuo2UkkyaYtZ3rMZ@gmail.com>
 <18262ed2459.44b0d74d434377.3690496800292832933@siddh.me> <Yuo7A0KYoNnbgwWT@gmail.com>
Subject: Re: [PATCH] x86/numa: Use cpumask_available instead of hardcoded
 NULL check
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Aug 2022 14:38:19 +0530  Ingo Molnar <mingo@kernel.org> wrote:
> 
> * Siddh Raman Pant <code@siddh.me> wrote:
> > There is no reason why allmodconfig would trigger the warning, [...]
> 
> Well, unless I'm misreading your changelog, all the warning needs to 
> trigger is CONFIG_CPUMASK_OFFSTACK=y.
> 
> > as it has CONFIG_CPUMASK_OFFSTACK=y, but the warning is because of the 
> > other case.
> 
> What 'other case'? I've re-read the discussion and don't see it, but maybe 
> I'm a bit daft this morning ...
 
No, the warning is happening because CONFIG_CPUMASK_OFFSTACK is not set. This
is because in that case cpumask_var_t type is not a pointer, and thus the var
can never be NULL, which leads gcc to warn us when comparing with NULL.

The chain of events are like:

        #ifdef CONFIG_CPUMASK_OFFSTACK
                typedef struct cpumask *cpumask_var_t;
        #else
                typedef struct cpumask cpumask_var_t[1];
        endif

        cpumask_var_t node_to_cpumask_map[MAX_NUMNODES];
        ...
        if (node_to_cpumask_map[node] == NULL) {


The fix works because:

        #ifdef CONFIG_CPUMASK_OFFSTACK
                static inline bool cpumask_available(cpumask_var_t mask)
                {
                        return mask != NULL;
                }
        #else
                static inline bool cpumask_available(cpumask_var_t mask)
                {
                        return true;
                }
        endif


The conditional definitions, as pointed out earlier, can be seen from line 700
of include/linux/cpumask.h file.

> > Did you try the config file I had linked to earlier?
> 
> Yes, and it didn't trigger the warning.
> 
> Thanks,
> 
>     Ingo
> 

 Thanks,
 Siddh
