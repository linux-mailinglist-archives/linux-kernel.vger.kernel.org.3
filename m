Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADBD58D895
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 14:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242997AbiHIMFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 08:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236541AbiHIMF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 08:05:29 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EC1B25
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 05:05:26 -0700 (PDT)
Received: from zn.tnic (p200300ea971b9800329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:9800:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E32821EC0426;
        Tue,  9 Aug 2022 14:05:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660046721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TkrtFJfURyVbLfACCforeqlFlEPRCCTHzagQfiGpr34=;
        b=DQW+acbHiI+DNWx8RxYLm1KMdzE1ftofn+nT8Wn9pfxe8ICYB90LU0QwnjRDuTzffn6J4I
        0Ex019K2lajoxalLZ8bpwmEF2bbLZL4F5XTkghGeLrYPfsGNItaoW/y9PcmV09ND4v2tmy
        Et3kBFW1fMchXcFikdXoXy7owTAH3Eo=
Date:   Tue, 9 Aug 2022 14:05:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     ira.weiny@intel.com
Cc:     Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 2/5] entry: Add calls for save/restore auxiliary
 pt_regs
Message-ID: <YvJNe2rzXfcogFFX@zn.tnic>
References: <20220805173009.3128098-1-ira.weiny@intel.com>
 <20220805173009.3128098-3-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220805173009.3128098-3-ira.weiny@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 10:30:06AM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Some architectures have auxiliary pt_regs space available to store
> information on the stack during exceptions.  This information is easier
> to obtain and store within C code rather than in arch specific assembly.

There are others?

Because I would've done this whole thing in arch/x86/ only...

> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index 8c0f334c4b75..a70a0f314aee 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -317,7 +317,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
>  
>  	if (user_mode(regs)) {
>  		irqentry_enter_from_user_mode(regs);
> -		return ret;
> +		goto aux_save;

Why do you have to goto and do the instrumentation sandwitch around it
at the goto label?

Why not simply do

	if (user_mode(regs)) {
		irqentry_enter_from_user_mode(regs);
		arch_save_aux_pt_regs(regs);
		return ret;

and so on?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
