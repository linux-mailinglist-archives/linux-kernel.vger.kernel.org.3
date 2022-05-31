Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D01538C06
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 09:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244573AbiEaHfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 03:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244362AbiEaHfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 03:35:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD23B8198B;
        Tue, 31 May 2022 00:34:51 -0700 (PDT)
Date:   Tue, 31 May 2022 07:34:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653982490;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vHJgr4BBWd6Z98utL6HtgTcAG/hunnfJqVIM/AGb8xE=;
        b=Ppw7Bhylz2Y6FCLpKfCG8+8F/mY67Qacwa2GlkLx/rW4+dFnTe2WtTuAgzdvRkwFZ6QDn7
        ckm85XnAtz0mfDxvbNrk9ovwApcUNWq8lG13y/lQuWBGoEpOBuL4VDwRCsug9ytQCGmFEn
        jhoDWDE2/tBl5/Zk40reqBZEo3rEe056/wBkTJmjxkQLPTFmqnyrAz2RIKU30KKJUWkTS8
        psdUAeDGtbrqnbx3MQBays4146oI7F2EDqqOXJsSpshIbhPJCECqDcMWL+4yp9AI3Bk88x
        kkrdgDotT9N4t+V61dAgw7enH7jGvkDWBD9dK9urqvpnjIOhBAPtGpXUHpL8UA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653982490;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vHJgr4BBWd6Z98utL6HtgTcAG/hunnfJqVIM/AGb8xE=;
        b=jBcHaF82tdjnl7sNeyy84qhwjAMmZw8ZQQ5KIeGWPRIOM6QYNFj0K/ZGsvjDNestk2tFQN
        7yC3eAqN+ypHgdDQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Taint and warn on late loading
Cc:     Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220525161232.14924-4-bp@alien8.de>
References: <20220525161232.14924-4-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <165398248872.4207.18184101421580014984.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     d23d33ea0fcdc4bbb484990bf53867f99c63ccab
Gitweb:        https://git.kernel.org/tip/d23d33ea0fcdc4bbb484990bf53867f99c63ccab
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Wed, 25 May 2022 18:12:31 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 31 May 2022 09:31:19 +02:00

x86/microcode: Taint and warn on late loading

Warn before it is attempted and taint the kernel. Late loading microcode
can lead to malfunction of the kernel when the microcode update changes
behaviour. There is no way for the kernel to determine whether its safe or
not.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20220525161232.14924-4-bp@alien8.de

---
 arch/x86/kernel/cpu/microcode/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index c717db6..801b44a 100644
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
 
@@ -541,6 +544,8 @@ put:
 	if (ret == 0)
 		ret = size;
 
+	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+
 	return ret;
 }
 
