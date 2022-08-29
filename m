Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2255B5A44AC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiH2ILi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiH2ILV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:11:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14BC50729;
        Mon, 29 Aug 2022 01:11:13 -0700 (PDT)
Date:   Mon, 29 Aug 2022 08:11:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661760670;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FNkj2Cwu39FkpzSR+XX6CPYsrzYX8zE8OPeMOPRN6zk=;
        b=EbWhfMiz+xN1kQjsKbPWHLcYMupeeVHRinv36mP8dUEzRhJyOtbq9O9YfuAYgMQp3skCE/
        gkozx3Cc+Pb736/c37e/LE8Q3LQ2brYuRY4ga22nIMvGRC7xe/klI1cBuS74Z3IzUhn7Sq
        bszLUJLUljPOtpXvgANEOMa06zdKHnMiIUF0QlOlFq6KVZ/7W98b3W2aOEr0U9mMKxVL5f
        MqoXnPYowDJy3cga5NMH1uVwyfCZrmcuK5hSgp1b86AvxoywaW9idTKtsSNmJ5gdTY7bPw
        TlJe6rPcxcjUo4YK6A0nZTQ3jnz5DfCFy0lGwY1NIoXFmPjslB2aalPXOPELTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661760670;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FNkj2Cwu39FkpzSR+XX6CPYsrzYX8zE8OPeMOPRN6zk=;
        b=4XTY+mnl7rG9LZI8CwixYx8SKUsNiesE+lDMolP65RxOjM2ePy3xlkAC5Wjbk20yJ53/AV
        36TpDURbG8txy0Cw==
From:   "tip-bot2 for Jane Chu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Retrieve poison range from hardware
Cc:     Jane Chu <jane.chu@oracle.com>, Borislav Petkov <bp@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <7ed50fd8-521e-cade-77b1-738b8bfb8502@oracle.com>
References: <7ed50fd8-521e-cade-77b1-738b8bfb8502@oracle.com>
MIME-Version: 1.0
Message-ID: <166176066946.401.17043823201433426666.tip-bot2@tip-bot2>
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

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     f9781bb18ed828e7b83b7bac4a4ad7cd497ee7d7
Gitweb:        https://git.kernel.org/tip/f9781bb18ed828e7b83b7bac4a4ad7cd497ee7d7
Author:        Jane Chu <jane.chu@oracle.com>
AuthorDate:    Fri, 26 Aug 2022 17:38:51 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 29 Aug 2022 09:33:42 +02:00

x86/mce: Retrieve poison range from hardware

When memory poison consumption machine checks fire, MCE notifier
handlers like nfit_handle_mce() record the impacted physical address
range which is reported by the hardware in the MCi_MISC MSR. The error
information includes data about blast radius, i.e. how many cachelines
did the hardware determine are impacted. A recent change

  7917f9cdb503 ("acpi/nfit: rely on mce->misc to determine poison granularity")

updated nfit_handle_mce() to stop hard coding the blast radius value of
1 cacheline, and instead rely on the blast radius reported in 'struct
mce' which can be up to 4K (64 cachelines).

It turns out that apei_mce_report_mem_error() had a similar problem in
that it hard coded a blast radius of 4K rather than reading the blast
radius from the error information. Fix apei_mce_report_mem_error() to
convey the proper poison granularity.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/7ed50fd8-521e-cade-77b1-738b8bfb8502@oracle.com
Link: https://lore.kernel.org/r/20220826233851.1319100-1-jane.chu@oracle.com
---
 arch/x86/kernel/cpu/mce/apei.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 7171929..8ed3417 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -29,15 +29,26 @@
 void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 {
 	struct mce m;
+	int lsb;
 
 	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
 		return;
 
+	/*
+	 * Even if the ->validation_bits are set for address mask,
+	 * to be extra safe, check and reject an error radius '0',
+	 * and fall back to the default page size.
+	 */
+	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK)
+		lsb = find_first_bit((void *)&mem_err->physical_addr_mask, PAGE_SHIFT);
+	else
+		lsb = PAGE_SHIFT;
+
 	mce_setup(&m);
 	m.bank = -1;
 	/* Fake a memory read error with unknown channel */
 	m.status = MCI_STATUS_VAL | MCI_STATUS_EN | MCI_STATUS_ADDRV | MCI_STATUS_MISCV | 0x9f;
-	m.misc = (MCI_MISC_ADDR_PHYS << 6) | PAGE_SHIFT;
+	m.misc = (MCI_MISC_ADDR_PHYS << 6) | lsb;
 
 	if (severity >= GHES_SEV_RECOVERABLE)
 		m.status |= MCI_STATUS_UC;
