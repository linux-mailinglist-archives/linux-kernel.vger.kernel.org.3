Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34F2534123
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 18:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245417AbiEYQM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 12:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238863AbiEYQMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 12:12:44 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3AEB41F2
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 09:12:43 -0700 (PDT)
Received: from zn.tnic (p200300ea97465795329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:5795:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 33EEF1EC064E;
        Wed, 25 May 2022 18:12:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1653495162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bhZp5sw7frsYYj8/OoHw/3GuZNx/12J3ZfzOJ/qzK+E=;
        b=Jb+scEotriM3yibw3XNeCJorNgp65/RY+jpLlAlMKaqDIC4LpNgWKDl5G7EZmlP9hp0F6R
        1IQJ1TnRAifZZ5bim1K0EUu8wHKWV+r0oa9Ew9h5KsMfoLgLNSTgHTDcSH59T6RlF+IInQ
        Mhy5Ewb8OkHrTTNCbm7BB3K4bd8W/y4=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] x86/microcode: Taint and warn on late loading
Date:   Wed, 25 May 2022 18:12:31 +0200
Message-Id: <20220525161232.14924-4-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220525161232.14924-1-bp@alien8.de>
References: <20220525161232.14924-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Warn before it is attempted and taint the kernel.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/microcode/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index c717db6b6856..801b44ac3851 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -493,6 +493,9 @@ static int microcode_reload_late(void)
 {
 	int ret;
 
+	pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
+	pr_err("You should switch to early loading, if possible.\n");
+
 	atomic_set(&late_cpus_in,  0);
 	atomic_set(&late_cpus_out, 0);
 
@@ -541,6 +544,8 @@ static ssize_t reload_store(struct device *dev,
 	if (ret == 0)
 		ret = size;
 
+	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+
 	return ret;
 }
 
-- 
2.35.1

