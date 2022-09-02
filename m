Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF96C5AAE28
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 14:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbiIBMJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 08:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235590AbiIBMJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 08:09:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE3AFEA;
        Fri,  2 Sep 2022 05:09:49 -0700 (PDT)
Date:   Fri, 02 Sep 2022 12:09:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662120587;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T7JMdo81tx57FsIn/BeO5digRbPEXiss62XmWva1Qgs=;
        b=a0FDc91tSCh8vMPM/zNAaZsO9Vb9TmgG7y/7G2PRBwKsxJgxwdZ+onlehm8fbpouSbauTi
        21NkzwB/WMAElKpMDKEzGF3LWv28HpDNNI77KtfFXNmEm7ia4kYNoW9O5z0Krwd04JoVYu
        m0rs4DA2bCPLv//czTjBPsxWTeU2NKucSxgjvF+fw3AA2Rk+4I6yMqnBMLkEERb+mylA+C
        26YAd9wVuZYCYOucDDcujsjW7OG68UL0YnQ64fjcBO2l2GRsYj1IQR9CkbW0gaaTR1v7Ws
        eclLZZAXawy+XFf8/uN08UEg6lk1yWBSOOunG/aEqo1QloZSmAE70XM/eLDvAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662120587;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T7JMdo81tx57FsIn/BeO5digRbPEXiss62XmWva1Qgs=;
        b=i19MqZtOx22ZclVJJy3caLn9fokZJn1y1FwYPaSZfKCCULIocZWilUu5HUoM4jZFV3ljfv
        Zy5N82Hx1tBpM8Cw==
From:   "tip-bot2 for Like Xu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/core: Completely disable guest PEBS via
 guest's global_ctrl
Cc:     Like Xu <likexu@tencent.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220831033524.58561-1-likexu@tencent.com>
References: <20220831033524.58561-1-likexu@tencent.com>
MIME-Version: 1.0
Message-ID: <166212058570.401.17913971277193913469.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     f2aeea57504cbbc58da3c59b939fc16150087648
Gitweb:        https://git.kernel.org/tip/f2aeea57504cbbc58da3c59b939fc16150087648
Author:        Like Xu <likexu@tencent.com>
AuthorDate:    Wed, 31 Aug 2022 11:35:24 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 01 Sep 2022 11:19:42 +02:00

perf/x86/core: Completely disable guest PEBS via guest's global_ctrl

When a guest PEBS counter is cross-mapped by a host counter, software
will remove the corresponding bit in the arr[global_ctrl].guest and
expect hardware to perform a change of state "from enable to disable"
via the msr_slot[] switch during the vmx transaction.

The real world is that if user adjust the counter overflow value small
enough, it still opens a tiny race window for the previously PEBS-enabled
counter to write cross-mapped PEBS records into the guest's PEBS buffer,
when arr[global_ctrl].guest has been prioritised (switch_msr_special stuff)
to switch into the enabled state, while the arr[pebs_enable].guest has not.

Close this window by clearing invalid bits in the arr[global_ctrl].guest.

Fixes: 854250329c02 ("KVM: x86/pmu: Disable guest PEBS temporarily in two rare situations")
Signed-off-by: Like Xu <likexu@tencent.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220831033524.58561-1-likexu@tencent.com
---
 arch/x86/events/intel/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index e8eb936..c20d8cd 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4061,8 +4061,9 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 		/* Disable guest PEBS if host PEBS is enabled. */
 		arr[pebs_enable].guest = 0;
 	} else {
-		/* Disable guest PEBS for cross-mapped PEBS counters. */
+		/* Disable guest PEBS thoroughly for cross-mapped PEBS counters. */
 		arr[pebs_enable].guest &= ~kvm_pmu->host_cross_mapped_mask;
+		arr[global_ctrl].guest &= ~kvm_pmu->host_cross_mapped_mask;
 		/* Set hw GLOBAL_CTRL bits for PEBS counter when it runs for guest */
 		arr[global_ctrl].guest |= arr[pebs_enable].guest;
 	}
