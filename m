Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A014B69D3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 11:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbiBOKyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 05:54:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236766AbiBOKyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 05:54:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9DBD884F;
        Tue, 15 Feb 2022 02:54:35 -0800 (PST)
Date:   Tue, 15 Feb 2022 10:54:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644922474;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=23RokacYUudoZ7+eyw3MPcHrjY0pBUhtldoR3kVPp0k=;
        b=F8GgRnd9ZlCBlHF6XGATwxgfDDByumG60oZO4ZieWClsK4MNCvMfTIT46W39ygAS1/B8Ve
        +NwStRsuYfMUJKGNCCURW3OS5HaH6clZThpTw8NGKDY0PH9FjpyzQnIur1L6RL0gY6ZjpL
        zbIUfKuuC0SFiRegSs+17QOoIP3ytXfi/fyV4xVhneQSUNcCgzW1QQtNVIirNxRpZCOBuH
        m50VnWQxVmKWufFbyDpEOC9FOUUrI2ymL+SYoYqKWforXUKuNh2swpPOmrdtSXXndA25bw
        oqkZiLaCXolKTJ3FhmH9smcCegAC23XzeN39KHRESht9lBS5jOT6yfWgMP6Mmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644922474;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=23RokacYUudoZ7+eyw3MPcHrjY0pBUhtldoR3kVPp0k=;
        b=Y1arK0au/aku/2KHml4h94zTYSLc+VhD3BVjAgM703CORcrougvWzmi4d9YkgeXXqmBmlC
        92F0kQ/t5fJeVKAQ==
From:   "tip-bot2 for Fenghua Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/pasid] iommu/ioasid: Introduce a helper to check for valid PASIDs
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lu Baolu <baolu.lu@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220207230254.3342514-4-fenghua.yu@intel.com>
References: <20220207230254.3342514-4-fenghua.yu@intel.com>
MIME-Version: 1.0
Message-ID: <164492247228.16921.14756406633991839692.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/pasid branch of tip:

Commit-ID:     7a5fbc9bcba5325a45297a4ba00091f39a63a1ed
Gitweb:        https://git.kernel.org/tip/7a5fbc9bcba5325a45297a4ba00091f39a63a1ed
Author:        Fenghua Yu <fenghua.yu@intel.com>
AuthorDate:    Mon, 07 Feb 2022 15:02:46 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 14 Feb 2022 19:41:39 +01:00

iommu/ioasid: Introduce a helper to check for valid PASIDs

Define a pasid_valid() helper to check if a given PASID is valid.

  [ bp: Massage commit message. ]

Suggested-by: Ashok Raj <ashok.raj@intel.com>
Suggested-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20220207230254.3342514-4-fenghua.yu@intel.com
---
 include/linux/ioasid.h |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index e9dacd4..2237f64 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -41,6 +41,10 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
 int ioasid_set_data(ioasid_t ioasid, void *data);
+static inline bool pasid_valid(ioasid_t ioasid)
+{
+	return ioasid != INVALID_IOASID;
+}
 
 #else /* !CONFIG_IOASID */
 static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
@@ -78,5 +82,10 @@ static inline int ioasid_set_data(ioasid_t ioasid, void *data)
 	return -ENOTSUPP;
 }
 
+static inline bool pasid_valid(ioasid_t ioasid)
+{
+	return false;
+}
+
 #endif /* CONFIG_IOASID */
 #endif /* __LINUX_IOASID_H */
