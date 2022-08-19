Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5835999C2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 12:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348354AbiHSKY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 06:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348356AbiHSKYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 06:24:53 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12DCACA1F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 03:24:51 -0700 (PDT)
Received: from zn.tnic (p200300ea971b9849329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:9849:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A40851EC064A;
        Fri, 19 Aug 2022 12:24:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660904685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=S0FizUmau6S1/DFtsPjVCVKdQ3LYW9X4CqTGEwR9ThQ=;
        b=StdfTqkTYWlewpTxDSdX/L4oSdjbKynEMLmaLzQ6nmxy5d3Jgd0XfbLwfLYtsn344gN6R9
        HFG0uVBFutcpYfNEEXqK/pP1KBFaeJcWO2nfad9JRg3yb/1uGcIOnDNw+v2hraz5FeBuqS
        JsEI9vAG2q5FoQP7pAQTUjGUZOfb1yw=
Date:   Fri, 19 Aug 2022 12:24:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>
Subject: Re: [PATCH v3 1/5] x86/microcode/intel: Check against CPU signature
 before saving microcode
Message-ID: <Yv9k6fqRANu4ojK6@zn.tnic>
References: <20220817051127.3323755-1-ashok.raj@intel.com>
 <20220817051127.3323755-2-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220817051127.3323755-2-ashok.raj@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 05:11:23AM +0000, Ashok Raj wrote:
> When save_microcode_patch() is looking to replace an existing microcode in
> the cache, current code is *only* checks the CPU sig/pf in the main

Write those "sig/pf" things out once so that it is clear what that is.

> header. Microcode can carry additional sig/pf combinations in the extended
> signature table, which is completely missed today.
> 
> For e.g. Current patch is a multi-stepping patch and new incoming patch is
> a specific patch just for this CPUs stepping.
> 
> patch1:
> fms3 <--- header FMS
> ...
> ext_sig:
> fms1
> fms2
> 
> patch2: new
> fms2 <--- header FMS
> 
> Current code takes only fms3 and checks with patch2 fms2.

So, find_matching_signature() does all the signatures matching and
scanning already. If anything, that function should tell its callers
whether the patch it is looking at - the fms2 one - should replace the
current one or not.

I.e., all the logic to say how strong a patch match is, should be
concentrated there. And then the caller will do the according action.

> saved_patch.header.fms3 != new_patch.header.fms2, so save_microcode_patch
> saves it to the end of list instead of replacing patch1 with patch2.
> 
> There is no functional user observable issue since find_patch() skips
> patch versions that are <= current_patch and will land on patch2 properly.
> 
> Nevertheless this will just end up storing every patch that isn't required.
> Kernel just needs to store the latest patch. Otherwise its a memory leak
> that sits in kernel and never used.

Oh well.

> Cc: stable@vger.kernel.org

Why?

This looks like a small correction to me which doesn't need to go to
stable...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
