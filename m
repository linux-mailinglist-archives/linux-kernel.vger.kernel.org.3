Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525394F1F03
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378924AbiDDV6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380526AbiDDUVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 16:21:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CC317E19;
        Mon,  4 Apr 2022 13:19:14 -0700 (PDT)
Date:   Mon, 04 Apr 2022 20:19:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649103553;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QZQaYr09f3K/gGOi6unzAYjbezIKt+jwMzKppsteJ8g=;
        b=di7iGq60peohiF1pGjIv56WNkKgziqE8Wge457uTEcrV+4r33kTjcbKK416KzLj6jKutKi
        akPJGxr+Xjop0R6Ij/OV2cwyVVv7jpxg52rO784tx0OnWSOXcrseXW4L4qx7SFEjx5bqVw
        QqD+LaTP0bXiRh3fF3Vrw9TjK3LTbMQhjeDCtlNgOj8tKuHjiVfwHXqFnSs8rr3pGxBBqN
        e+KIb7C09JzZ/4/B7H0qJUlgbynHM1fo4duneeqk0I5v/1IuR3EaCmVY0+qtVPUBics1Fl
        DgOQaiNzXa7xsQGDVE6HnbCLBVL7Czlx9HDLsV4kBMX88gN70ndSkXpl4KUblw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649103553;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QZQaYr09f3K/gGOi6unzAYjbezIKt+jwMzKppsteJ8g=;
        b=SgycpArjwOUpnjfW/PUk1RLKscUzwcYD9WsWHR12s51VvMpG8xytI1Knbvggq8u+z8fMBO
        awZzRGTNCWR1PLBg==
From:   "tip-bot2 for Mike Travis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Update TSC sync state for UV5
Cc:     Mike Travis <mike.travis@hpe.com>, Borislav Petkov <bp@suse.de>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220318224304.174967-3-mike.travis@hpe.com>
References: <20220318224304.174967-3-mike.travis@hpe.com>
MIME-Version: 1.0
Message-ID: <164910355241.389.1602942943819019467.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     4395de040d24b40fb3cd7fb4f0b013748abe0a72
Gitweb:        https://git.kernel.org/tip/4395de040d24b40fb3cd7fb4f0b013748abe0a72
Author:        Mike Travis <mike.travis@hpe.com>
AuthorDate:    Fri, 18 Mar 2022 17:43:03 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 04 Apr 2022 20:21:44 +02:00

x86/platform/uv: Update TSC sync state for UV5

Update TSC to not check TSC sync state for uv5+ as it is not available.
It is assumed that TSC will always be in sync for multiple chassis and
will pass the tests for the kernel to accept it as the clocksource.
To disable this check use the kernel start options tsc=reliable
clocksource=tsc.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Link: https://lore.kernel.org/r/20220318224304.174967-3-mike.travis@hpe.com
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index f5a48e6..387d653 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -199,10 +199,16 @@ static void __init uv_tsc_check_sync(void)
 	int mmr_shift;
 	char *state;
 
-	/* Different returns from different UV BIOS versions */
+	/* UV5+, sync state from bios not available, assumed valid */
+	if (!is_uv(UV2|UV3|UV4)) {
+		pr_debug("UV: TSC sync state for UV5+ assumed valid\n");
+		mark_tsc_async_resets("UV5+");
+		return;
+	}
+
+	/* UV2,3,4, UV BIOS TSC sync state available */
 	mmr = uv_early_read_mmr(UVH_TSC_SYNC_MMR);
-	mmr_shift =
-		is_uv2_hub() ? UVH_TSC_SYNC_SHIFT_UV2K : UVH_TSC_SYNC_SHIFT;
+	mmr_shift = is_uv2_hub() ? UVH_TSC_SYNC_SHIFT_UV2K : UVH_TSC_SYNC_SHIFT;
 	sync_state = (mmr >> mmr_shift) & UVH_TSC_SYNC_MASK;
 
 	/* Check if TSC is valid for all sockets */
