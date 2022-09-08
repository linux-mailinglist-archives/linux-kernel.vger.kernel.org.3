Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759305B17A9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbiIHIuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbiIHIuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:50:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C661152
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:49:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 235EF1F8A3;
        Thu,  8 Sep 2022 08:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662626964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FRQlMbR3LekauN/VGAqwz3/4iPTsfJTb9AkfSRaurK0=;
        b=Hd9Ngqvs9Q7HjcnnFHdEJnluFdjs2Wj0yx7QF7U6WlXYjs7VkdqwdTeiOTJdFoIUG+LQfF
        4GbxxQll8c0/5O+q2qlKl7gbNHHZP05WdF57KoK55JwvRKci1L2aeMv9LnUQ4xXNTmGKW3
        77gVzi15lfi7uuJQtkiQDGwKbuzddZg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D98F31322C;
        Thu,  8 Sep 2022 08:49:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FLzdM5OsGWNFNgAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 08 Sep 2022 08:49:23 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3 01/10] x86/mtrr: add comment for set_mtrr_state() serialization
Date:   Thu,  8 Sep 2022 10:49:05 +0200
Message-Id: <20220908084914.21703-2-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220908084914.21703-1-jgross@suse.com>
References: <20220908084914.21703-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a comment how set_mtrr_state() is needing serialization.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
V3:
- new patch instead of old patch 1
---
 arch/x86/kernel/cpu/mtrr/generic.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 558108296f3c..cd64eab02393 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -684,7 +684,10 @@ static u32 deftype_lo, deftype_hi;
 /**
  * set_mtrr_state - Set the MTRR state for this CPU.
  *
- * NOTE: The CPU must already be in a safe state for MTRR changes.
+ * NOTE: The CPU must already be in a safe state for MTRR changes, including
+ *       measures that only a single CPU can be active in set_mtrr_state() in
+ *       order to not be subject to races for usage of deftype_lo (this is
+ *       accomplished by taking set_atomicity_lock).
  * RETURNS: 0 if no changes made, else a mask indicating what was changed.
  */
 static unsigned long set_mtrr_state(void)
-- 
2.35.3

