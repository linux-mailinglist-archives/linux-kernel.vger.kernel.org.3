Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB994ACA95
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 21:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239391AbiBGUa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 15:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243033AbiBGU1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 15:27:55 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A7BC0401DA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 12:27:55 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 96C5D1EC01A8;
        Mon,  7 Feb 2022 21:27:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644265669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qfQlZszpnOZtjwDDKq/4Q/EBp4qQMckKH/pcJcQzPzs=;
        b=KglyvPlrbWnAs+VFCQB/Cz/6r59ZcLUi4TwxC0XRBbddxh6K4TqoGW07crfq4t4qhyXbUa
        Rn94p0mBx3gjF098KMMxieOpAZe2T5npYupxbl0Nb6v/xzpqjJExHP8QUeZs+X/TTW9l8U
        SSQFSLdKzcrTUEagcoA9qJz5uW/lxec=
Date:   Mon, 7 Feb 2022 21:27:43 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Jue Wang <juew@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [RFC] x86/mce: Add workaround for SKX/CLX/CPX spurious machine
 checks
Message-ID: <YgGAv/aCVG+RDADI@zn.tnic>
References: <20220207043640.2829295-1-juew@google.com>
 <YgFqiJOU5tZsHbY6@zn.tnic>
 <YgFyBRIOIquMI2ng@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YgFyBRIOIquMI2ng@agluck-desk2.amr.corp.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 11:24:53AM -0800, Luck, Tony wrote:
> I suggested breaking it out as a helper to make the
> code easier to read.

We have waaay too many small helpers. I guess it is just as readable if
you do in the function:

	bool is_intel_srar = mci_status &
			(MCI_STATUS_VAL|MCI_STATUS_OVER|MCI_STATUS_UC|MCI_STATUS_EN|
			(MCI_STATUS_ADDRV|MCI_STATUS_MISCV|MCI_STATUS_PCC|
			 MCI_STATUS_AR|MCI_STATUS_S)) ==
			(MCI_STATUS_VAL|MCI_STATUS_UC|MCI_STATUS_EN|MCI_STATUS_ADDRV|
			 MCI_STATUS_MISCV|MCI_STATUS_AR|MCI_STATUS_S);

> X86_FEATURE_FSRM is a different (but confusingly simlilar) feature.
> 
> The MSR is per-thread. So the write only disabled the fast string
> operation on this one logical CPU. So the per-cpu srar_dcu_signaled
> variable is just to avoid getting into a loop when this #MC isn't
> because of a REP MOVS peeking at things it shouldn't.

In that case, you can just as well test the MSR bit directly
MSR_IA32_MISC_ENABLE_FAST_STRING_BIT. If it set, you clear it, done.

> Maybe this would be more human friendly?
> 
> 		pr_err("CPU%d: Performance now degraded after applying machine check workaround\n",
> 			smp_processor_id());

Well, is there an erratum you can refer to in it instead?

Explaining the whole deal in a single error message is hard and almost
certainly insufficient.

Also, what's the use of that message issuing once on every CPU? Instead
of being a _once() message?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
