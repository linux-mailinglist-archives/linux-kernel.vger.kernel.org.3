Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526D04BBBD4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 16:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236793AbiBRPHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 10:07:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236785AbiBRPHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 10:07:30 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7811FA5E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:07:11 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 29CCA1EC0453;
        Fri, 18 Feb 2022 16:07:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645196826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4dgrVhY1zhSIpJ67A/qW0ekCgb8tkD1wGOZsXKygGvI=;
        b=BtcpeqG9GRvEK/cadYcIC9HJIHGD3pgA8AuAa7ojK/+CEMs0QtVTqam4AeeqHVNCZX4w7n
        JjJjZoKg6leeI8XSdmdG6SdzLCEk3Qn/imzg4N+NDeWvQMTEUC3akhJiFxd2ie/q+YDQ7H
        Yuooou/A67KcZu+7spNLKDZsDl4N1ls=
Date:   Fri, 18 Feb 2022 16:07:09 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jue Wang <juew@google.com>, Tony Luck <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v2] x86/mce: work around an erratum on fast string copy
 instructions.
Message-ID: <Yg+2Hc78nfSRmh/j@zn.tnic>
References: <Yg54nse5qNQO3sbW@zn.tnic>
 <20220218013209.2436006-1-juew@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220218013209.2436006-1-juew@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 05:32:09PM -0800, Jue Wang wrote:
> +static noinstr bool quirk_skylake_repmov(void)
> +{
> +	u64 mcgstatus = mce_rdmsrl(MSR_IA32_MCG_STATUS);
> +	u64 misc_enable = __rdmsr(MSR_IA32_MISC_ENABLE);
> +
> +	/*
> +	 * Apply the quirk only to local machine checks, i.e., no broadcast
> +	 * sync is needed.
> +	 */
> +	if ((mcgstatus & MCG_STATUS_LMCES) &&
> +	    unlikely(misc_enable & MSR_IA32_MISC_ENABLE_FAST_STRING)) {
> +		u64 mc1_status = mce_rdmsrl(MSR_IA32_MCx_STATUS(1));
> +
> +		/* Check for a software-recoverable data fetch error. */
> +		if ((mc1_status &
> +		     (MCI_STATUS_VAL | MCI_STATUS_OVER | MCI_STATUS_UC | MCI_STATUS_EN |
> +		      MCI_STATUS_ADDRV | MCI_STATUS_MISCV | MCI_STATUS_PCC |
> +		      MCI_STATUS_AR | MCI_STATUS_S)) ==
> +		     (MCI_STATUS_VAL |                   MCI_STATUS_UC | MCI_STATUS_EN |
> +		      MCI_STATUS_ADDRV | MCI_STATUS_MISCV |
> +		      MCI_STATUS_AR | MCI_STATUS_S)) {
> +			misc_enable &= ~MSR_IA32_MISC_ENABLE_FAST_STRING;
> +			__wrmsr(MSR_IA32_MISC_ENABLE,
> +				(u32)misc_enable, (u32)(misc_enable >> 32));

"You're going to have to use the mce_{rd,wr}msrl() routines."

I actually really meant that.

And I went and simplified this a bit more so that it is more readable,
diff ontop.

Also, Tony, I think the clearing of MCG_STATUS should happen last.

---
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index c1a41da99975..1741be9b9464 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -831,34 +831,35 @@ quirk_sandybridge_ifu(int bank, struct mce *m, struct pt_regs *regs)
  */
 static noinstr bool quirk_skylake_repmov(void)
 {
-	u64 mcgstatus = mce_rdmsrl(MSR_IA32_MCG_STATUS);
-	u64 misc_enable = __rdmsr(MSR_IA32_MISC_ENABLE);
+	u64 mcgstatus   = mce_rdmsrl(MSR_IA32_MCG_STATUS);
+	u64 misc_enable = mce_rdmsrl(MSR_IA32_MISC_ENABLE);
+	u64 mc1_status;
 
 	/*
 	 * Apply the quirk only to local machine checks, i.e., no broadcast
 	 * sync is needed.
 	 */
-	if ((mcgstatus & MCG_STATUS_LMCES) &&
-	    (misc_enable & MSR_IA32_MISC_ENABLE_FAST_STRING)) {
-		u64 mc1_status = mce_rdmsrl(MSR_IA32_MCx_STATUS(1));
-
-		/* Check for a software-recoverable data fetch error. */
-		if ((mc1_status &
-		     (MCI_STATUS_VAL | MCI_STATUS_OVER | MCI_STATUS_UC | MCI_STATUS_EN |
-		      MCI_STATUS_ADDRV | MCI_STATUS_MISCV | MCI_STATUS_PCC |
-		      MCI_STATUS_AR | MCI_STATUS_S)) ==
-		     (MCI_STATUS_VAL |                   MCI_STATUS_UC | MCI_STATUS_EN |
-		      MCI_STATUS_ADDRV | MCI_STATUS_MISCV |
-		      MCI_STATUS_AR | MCI_STATUS_S)) {
-			misc_enable &= ~MSR_IA32_MISC_ENABLE_FAST_STRING;
-			__wrmsr(MSR_IA32_MISC_ENABLE,
-				(u32)misc_enable, (u32)(misc_enable >> 32));
-			mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
-			mce_wrmsrl(MSR_IA32_MCx_STATUS(1), 0);
-			pr_err_once("Errata detected, disable fast string copy instructions.\n");
-			return true;
-		}
+	if (!(mcgstatus & MCG_STATUS_LMCES) ||
+	    !(misc_enable & MSR_IA32_MISC_ENABLE_FAST_STRING))
+		return false;
+
+	mc1_status = mce_rdmsrl(MSR_IA32_MCx_STATUS(1));
+
+	/* Check for a software-recoverable data fetch error. */
+	if ((mc1_status &
+	     (MCI_STATUS_VAL | MCI_STATUS_OVER | MCI_STATUS_UC | MCI_STATUS_EN |
+	      MCI_STATUS_ADDRV | MCI_STATUS_MISCV | MCI_STATUS_PCC |
+	      MCI_STATUS_AR | MCI_STATUS_S)) ==
+	     (MCI_STATUS_VAL |                   MCI_STATUS_UC | MCI_STATUS_EN |
+	      MCI_STATUS_ADDRV | MCI_STATUS_MISCV |
+	      MCI_STATUS_AR | MCI_STATUS_S)) {
+		misc_enable &= ~MSR_IA32_MISC_ENABLE_FAST_STRING;
+		mce_wrmsrl(MSR_IA32_MISC_ENABLE, misc_enable);
+		mce_wrmsrl(MSR_IA32_MCx_STATUS(1), 0);
+		pr_err_once("Erratum detected, disable fast string copy instructions.\n");
+		return true;
 	}
+
 	return false;
 }
 
@@ -1432,7 +1433,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		return unexpected_machine_check(regs);
 
 	if (mce_flags.skx_repmov_quirk && quirk_skylake_repmov())
-		return;
+		goto clear;
 
 	/*
 	 * Establish sequential order between the CPUs entering the machine
@@ -1576,6 +1577,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 out:
 	instrumentation_end();
 
+clear:
 	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
 }
 EXPORT_SYMBOL_GPL(do_machine_check);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
