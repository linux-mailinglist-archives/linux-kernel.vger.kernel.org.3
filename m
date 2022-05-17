Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395F152AA2B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351938AbiEQSMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352080AbiEQSME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:12:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B68518E3F;
        Tue, 17 May 2022 11:12:02 -0700 (PDT)
Date:   Tue, 17 May 2022 18:11:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652811120;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2dK1b3gnvWzB30FrYlVqyL4QjaG6ljPHKn4EyMVGiPU=;
        b=feFr094iQSxl25E3vX86r6jDqq2qyUNJ07OYbra4bpXZhQKY3mxKOHo4W71GKrPe8NTtUd
        T4x7TxACTnh2bf1Aw1rpbq86SbJYEbSEF3MYsH4GlZAclHAXn1jw4K7IiCzBkpjYMAf1xS
        2vYjwBNNg9VWMBUEwD7FHCs+LigRX7JVSUBjH97+yDYwktaLbqc7nsqo2A34rck7kDL59E
        L41teWz6dgAxpt8l3rlzujLRaXqtzbag3p6wFob0dsputt6xg6yicpr0JK5hsVqsIP9Zs0
        zOfBsFezsMdBYm9+pzh4Kl2i/MDq/YNq1iWm2rNdkzrERgcMGr++Ot4kSGBzUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652811120;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2dK1b3gnvWzB30FrYlVqyL4QjaG6ljPHKn4EyMVGiPU=;
        b=AwY65UdllYU35deQQhMWWCc2nOgOXgj0DN4pmB+NfBleCZRKU59BXATJZrYQybN8nG+C1a
        /yZIe5EImu/0M7BQ==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Ensure no data in PCMD page after truncate
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Haitao Huang <haitao.huang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C6495120fed43fafc1496d09dd23df922b9a32709=2E16523?=
 =?utf-8?q?89823=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C6495120fed43fafc1496d09dd23df922b9a32709=2E165238?=
 =?utf-8?q?9823=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165281111949.4207.13292386419056952708.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     e3a3bbe3e99de73043a1d32d36cf4d211dc58c7e
Gitweb:        https://git.kernel.org/tip/e3a3bbe3e99de73043a1d32d36cf4d211dc58c7e
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Thu, 12 May 2022 14:51:01 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 16 May 2022 15:17:57 -07:00

x86/sgx: Ensure no data in PCMD page after truncate

A PCMD (Paging Crypto MetaData) page contains the PCMD
structures of enclave pages that have been encrypted and
moved to the shmem backing store. When all enclave pages
sharing a PCMD page are loaded in the enclave, there is no
need for the PCMD page and it can be truncated from the
backing store.

A few issues appeared around the truncation of PCMD pages. The
known issues have been addressed but the PCMD handling code could
be made more robust by loudly complaining if any new issue appears
in this area.

Add a check that will complain with a warning if the PCMD page is not
actually empty after it has been truncated. There should never be data
in the PCMD page at this point since it is was just checked to be empty
and truncated with enclave mutex held and is updated with the
enclave mutex held.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Haitao Huang <haitao.huang@intel.com>
Link: https://lkml.kernel.org/r/6495120fed43fafc1496d09dd23df922b9a32709.1652389823.git.reinette.chatre@intel.com
---
 arch/x86/kernel/cpu/sgx/encl.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 243f3bd..3c24e61 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -187,12 +187,20 @@ static int __sgx_encl_eldu(struct sgx_encl_page *encl_page,
 	kunmap_atomic(pcmd_page);
 	kunmap_atomic((void *)(unsigned long)pginfo.contents);
 
+	get_page(b.pcmd);
 	sgx_encl_put_backing(&b);
 
 	sgx_encl_truncate_backing_page(encl, page_index);
 
-	if (pcmd_page_empty && !reclaimer_writing_to_pcmd(encl, pcmd_first_page))
+	if (pcmd_page_empty && !reclaimer_writing_to_pcmd(encl, pcmd_first_page)) {
 		sgx_encl_truncate_backing_page(encl, PFN_DOWN(page_pcmd_off));
+		pcmd_page = kmap_atomic(b.pcmd);
+		if (memchr_inv(pcmd_page, 0, PAGE_SIZE))
+			pr_warn("PCMD page not empty after truncate.\n");
+		kunmap_atomic(pcmd_page);
+	}
+
+	put_page(b.pcmd);
 
 	return ret;
 }
