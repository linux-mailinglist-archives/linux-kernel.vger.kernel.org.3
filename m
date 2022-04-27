Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F94511A18
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238727AbiD0Oyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238641AbiD0Oyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:54:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E734341986
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:51:41 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651071100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wvn9LwNNtiMBYYNla0pQisgNERbncoLZFjzZf3wEaBg=;
        b=uBgMpcZ3fiuFPxwc0FsdNKmhiEiq3aFTofHmvwGqcRfnuY744xoV7HNmCihFVP64SarZss
        Nkp6h5l3E8n7Xm3EpxaoC5AZM1s6Iv6RIqIXt3Hrkp13OCTaNk8yW81DuLPhhoEtDVgFMA
        Erab+9/PXMMTPWZ7hGlh13bRxV3lQhcc1N8i3zvKSrq6Nt148SMd3qHuR4NjUyTPNmzBrp
        zAhO2k2FAmOHmrXIaOplWg9DU529uwzm0q8E1BEZ/V2xuyndu4tbbrFnmIDiM4WY5QLZHx
        uatpQCGH70d+vA3C1nIU6X8VYN7cu6EfXZLfvyasuc8NQWM9He2tXplmHmyNbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651071100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wvn9LwNNtiMBYYNla0pQisgNERbncoLZFjzZf3wEaBg=;
        b=Xx0sWzCld9Q14vN2ZEsatuJCh5KYVNHy+z+N8WaglwEJPI5iT+B1LVMJbGEcyXAyMwXo7x
        wvVx1DXCcgCcXYAw==
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>, lkp@lists.01.org,
        lkp@intel.com, LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [x86/aperfmperf]  adabc53c25:
 WARNING:at_arch/x86/kernel/cpu/aperfmperf.c:#freq_invariance_enable
In-Reply-To: <20220426072238.GA613@xsang-OptiPlex-9020>
References: <20220426072238.GA613@xsang-OptiPlex-9020>
Date:   Wed, 27 Apr 2022 16:51:39 +0200
Message-ID: <8735hyy3yc.ffs@tglx>
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

On Tue, Apr 26 2022 at 15:22, kernel test robot wrote:
> [ 11.086251][ T1] WARNING: CPU: 4 PID: 1 at arch/x86/kernel/cpu/aperfmperf.c:431 freq_invariance_enable (arch/x86/kernel/cpu/aperfmperf.c:431) 
> [ 11.227178][ T1] init_freq_invariance_cppc (arch/x86/kernel/acpi/cppc.c:82 arch/x86/kernel/acpi/cppc.c:96) 
> [ 11.232574][ T1] acpi_cppc_processor_probe (drivers/acpi/cppc_acpi.c:832) 

Bah, the commit in question assumed that the CPPC muck is AMD only....

Fix below.

Thanks,

        tglx
---
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -91,6 +91,9 @@ void init_freq_invariance_cppc(void)
 	if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF))
 		return;
 
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+		return;
+
 	mutex_lock(&freq_invariance_lock);
 	if (!init_done)
 		amd_set_max_freq_ratio();
