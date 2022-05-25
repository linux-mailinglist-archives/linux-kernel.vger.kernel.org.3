Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C38533E51
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242812AbiEYN4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiEYN4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:56:08 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBEB8AE4A
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:56:03 -0700 (PDT)
Received: from zn.tnic (p200300ea97465795329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:5795:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2D5411EC064C;
        Wed, 25 May 2022 15:55:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1653486958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RST4dh8t+hX/JhPHQNoOfLjLfAPVxCOqSiSb2TTlSF4=;
        b=O4cEM2JjmeIFIigPuE5BI9738GQ+xaMWwJil9+wWYH9Vpe+G74PCNAvvPwe20GeH9NAlj1
        50GgLTAp/e/oZZ34PzG/51hYw0OpsCMYWpRqF1DFbP9Gg4ag7ke9Xrp6djF+7xqwd9XGDJ
        vRrPzySY4acOnCMO+5aMfTiEAeN1BLo=
Date:   Wed, 25 May 2022 15:55:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/3] x86/microcode: Remove unnecessary perf callback
 default-disable late loading
Message-ID: <Yo41ahlGTxyyZ/7o@zn.tnic>
References: <20220524185324.28395-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220524185324.28395-1-bp@alien8.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

c93dc84cbe32 ("perf/x86: Add a microcode revision check for SNB-PEBS")
checks whether the microcode revision has fixed PEBS issues.

This can happen either:

1. At PEBS init time, where the early microcode has been loaded already

2. During late loading, in the microcode_check() callback.

So remove the unnecessary call in the microcode loader init routine.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/microcode/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 801b44ac3851..ad57e0e4d674 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -756,10 +756,7 @@ static int __init microcode_init(void)
 
 	cpus_read_lock();
 	mutex_lock(&microcode_mutex);
-
 	error = subsys_interface_register(&mc_cpu_interface);
-	if (!error)
-		perf_check_microcode();
 	mutex_unlock(&microcode_mutex);
 	cpus_read_unlock();
 
-- 
2.35.1


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
