Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B7B4F8404
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345114AbiDGPum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244584AbiDGPug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:50:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA0F13F0A;
        Thu,  7 Apr 2022 08:48:33 -0700 (PDT)
Date:   Thu, 07 Apr 2022 15:48:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649346512;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D10np9Fxcw/H9qvhVddoVVRVomltLLNcXei5XDaouJI=;
        b=jWg8H5/qHVCs68zQqE72YDyLnk7812K0jG84nIkyi2jubZiq3emmnjYGRWmQJOg0BQPxKB
        jH8lUKu+Cwc0djhzLNoT8jkdF4cvg7il/7SB9dkPGXVt7oi0WDZ3MXYPjns7Ww2I7F/hvF
        fMtqlfzGet8VHJ5SU/1zuJO17CZ3m6SRAGHTI8C98kig6T50930TZZ8y52wIFEj3eSDT6E
        mvU5li+j9hgIKHY9aiUpKxyRojGX6HOhQnhID2BKxVcxyZIgF8ZG5V18jxmM+Xbju7SKSX
        UWI0vik9Ptb5YrD2vZpodOhWRLqvNHhMh7fK7NuqDHzHYOY7E25+wDFUCPShDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649346512;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D10np9Fxcw/H9qvhVddoVVRVomltLLNcXei5XDaouJI=;
        b=B3OQD4joMSdN9SCL5/XBeQGj0NQ2Ro+joZDHn9shdsiOSeXbZDZ9Uu0AP2RvCDibHldrIa
        zmAIW5YpzHoGOVBw==
From:   "tip-bot2 for Mike Travis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Update TSC sync state for UV5
Cc:     Mike Travis <mike.travis@hpe.com>, Steve Wahl <steve.wahl@hpe.com>,
        Borislav Petkov <bp@suse.de>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220406195149.228164-3-steve.wahl@hpe.com>
References: <20220406195149.228164-3-steve.wahl@hpe.com>
MIME-Version: 1.0
Message-ID: <164934651091.389.14325435214778502729.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     bb3ab81bdbd53f88f26ffabc9fb15bd8466486ec
Gitweb:        https://git.kernel.org/tip/bb3ab81bdbd53f88f26ffabc9fb15bd8466486ec
Author:        Mike Travis <mike.travis@hpe.com>
AuthorDate:    Wed, 06 Apr 2022 14:51:48 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 07 Apr 2022 17:24:39 +02:00

x86/platform/uv: Update TSC sync state for UV5

The UV5 platform synchronizes the TSCs among all chassis, and will not
proceed to OS boot without achieving synchronization.  Previous UV
platforms provided a register indicating successful synchronization.
This is no longer available on UV5.  On this platform TSC_ADJUST
should not be reset by the kernel.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20220406195149.228164-3-steve.wahl@hpe.com
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index f5a48e6..a6e9c27 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -199,7 +199,13 @@ static void __init uv_tsc_check_sync(void)
 	int mmr_shift;
 	char *state;
 
-	/* Different returns from different UV BIOS versions */
+	/* UV5 guarantees synced TSCs; do not zero TSC_ADJUST */
+	if (!is_uv(UV2|UV3|UV4)) {
+		mark_tsc_async_resets("UV5+");
+		return;
+	}
+
+	/* UV2,3,4, UV BIOS TSC sync state available */
 	mmr = uv_early_read_mmr(UVH_TSC_SYNC_MMR);
 	mmr_shift =
 		is_uv2_hub() ? UVH_TSC_SYNC_SHIFT_UV2K : UVH_TSC_SYNC_SHIFT;
