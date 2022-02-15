Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF5F4B6E53
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238508AbiBOOHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:07:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbiBOOHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:07:34 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F96B7E6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:07:24 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id d10so44468688eje.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=RbqMYTvKbbP0bA9O4n+htjMrRBauJyHJkolAFKZS228=;
        b=SA1dXtxC+k1crifnstbr81ediDNmKKqyNGd+Fkymom7uezXPjDsFM9+GIhii9M2Wfs
         rkIwP49rM5ado9EauB9x3dlbIN9H8y6tazGmGbXWmUTacDF/LvD3FnngdM9Y7Q8H0n3l
         TnJYvAGF+ORGljjScdHKAufxMb+eyEM/1/WD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RbqMYTvKbbP0bA9O4n+htjMrRBauJyHJkolAFKZS228=;
        b=w6wc+mTD2M1NAqztjIdJ8xml0tsAVxWVW+8CN7/GwWMSvLlBwG+7IQhmDwMOTwAq8N
         YJR7jKW4j5uG7MCdk4Odg4vGIlJ1+9ItUKJ9WaetSzlSBICeNkuy6pNQhb1cmr4CYEG8
         mtNtYn3PWsp+GDC9QvYUm6SSJK2VknQR2AEB2rs9dCdZm99y/XcQQLy6BzXOUE86Ud32
         NPqPFHxumLjeji6KkItdyiN+grWnlv29UJFKHhKHTKcuMdRoXZQQ3bi6k7MrhKl2NEjW
         LK1EXL2CLjaN4M4KvadBkPrXHz/gQkMoC/lrYGNZNIhCwM+8ZlE0iyorO1nq9VaFPBY9
         TeWg==
X-Gm-Message-State: AOAM5305duYpuTgvqck3FVO41Z68sxzDHWiKH+VcJD/Dv/RqKqX+/kt9
        qMpGhCF2ZlvosEOKY6EntMwdgux9bGrOTAVm
X-Google-Smtp-Source: ABdhPJyIBqGKs64PcR1KqbJO/S/enqO4UHfl7Mz+CvXM9iJiRId6TKJaVg2rsmFAaaB51LhbRA3NSA==
X-Received: by 2002:a17:906:2cc4:: with SMTP id r4mr3088882ejr.393.1644934042641;
        Tue, 15 Feb 2022 06:07:22 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::5:fd97])
        by smtp.gmail.com with ESMTPSA id hh13sm11836952ejb.89.2022.02.15.06.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 06:07:22 -0800 (PST)
Date:   Tue, 15 Feb 2022 14:07:21 +0000
From:   Chris Down <chris@chrisdown.name>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org
Subject: [PATCH] x86/ioremap: Always incriminate the caller on failure
Message-ID: <YguzmS7umfiaSSHU@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2 (7160e05a) (2022-02-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On my T14s Gen2, I get the following on startup:

    e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connection
    e1000e 0000:00:1f.6 eth0: MAC: 14, PHY: 12, PBA No: FFFFFF-0FF
    sof-audio-pci-intel-tgl 0000:00:1f.3: warn: FW ABI is more recent than kernel
    ioremap error for 0x930bc000-0x930bd000, requested 0x2, got 0x0
    sof-audio-pci-intel-tgl 0000:00:1f.3: unknown sof_ext_man header type 3 size 0x30
    ucsi_acpi: probe of USBC000:00 failed with error -12

Notice the ioremap error which appears sandwiched between SOF driver
messages. Without more knowledge of the kernel, and due to the
interleaving of printk errors, it's not immediately obvious to the
system administrator where this message comes from (although in this
case tracing confirms that it comes from ucsi_acpi's ->probe, as one
might expect).

To avoid issues with printk interleaving, always incriminate the caller
on ioremap() failure since we have it. While we're here, also change
these from printk(KERN_FOO) to pr_foo(), which we already use elsewhere
in ioremap.c

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 arch/x86/mm/ioremap.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 026031b3b782..4051094e614b 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -195,8 +195,8 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
 		return NULL;
 
 	if (!phys_addr_valid(phys_addr)) {
-		printk(KERN_WARNING "ioremap: invalid physical address %llx\n",
-		       (unsigned long long)phys_addr);
+		pr_warn("%pS: ioremap: invalid physical address %llx\n",
+			caller, (unsigned long long)phys_addr);
 		WARN_ON_ONCE(1);
 		return NULL;
 	}
@@ -207,8 +207,8 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
 	 * Don't allow anybody to remap normal RAM that we're using..
 	 */
 	if (io_desc.flags & IORES_MAP_SYSTEM_RAM) {
-		WARN_ONCE(1, "ioremap on RAM at %pa - %pa\n",
-			  &phys_addr, &last_addr);
+		WARN_ONCE(1, "%pS: ioremap on RAM at %pa - %pa\n",
+			  caller, &phys_addr, &last_addr);
 		return NULL;
 	}
 
@@ -222,14 +222,15 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
 	retval = memtype_reserve(phys_addr, (u64)phys_addr + size,
 						pcm, &new_pcm);
 	if (retval) {
-		printk(KERN_ERR "ioremap memtype_reserve failed %d\n", retval);
+		pr_err("%pS: ioremap memtype_reserve failed %d\n",
+		       caller, retval);
 		return NULL;
 	}
 
 	if (pcm != new_pcm) {
 		if (!is_new_memtype_allowed(phys_addr, size, pcm, new_pcm)) {
-			printk(KERN_ERR
-		"ioremap error for 0x%llx-0x%llx, requested 0x%x, got 0x%x\n",
+			pr_err("%pS: ioremap error for 0x%llx-0x%llx, requested 0x%x, got 0x%x\n",
+				caller,
 				(unsigned long long)phys_addr,
 				(unsigned long long)(phys_addr + size),
 				pcm, new_pcm);
@@ -292,7 +293,7 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
 	 * tree.
 	 */
 	if (iomem_map_sanity_check(unaligned_phys_addr, unaligned_size))
-		pr_warn("caller %pS mapping multiple BARs\n", caller);
+		pr_warn("%pS: mapping multiple BARs\n", caller);
 
 	return ret_addr;
 err_free_area:
-- 
2.34.1

