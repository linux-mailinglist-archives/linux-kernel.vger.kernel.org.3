Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0388156AAAD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbiGGS2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236421AbiGGS1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:27:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4655C96C;
        Thu,  7 Jul 2022 11:27:44 -0700 (PDT)
Date:   Thu, 07 Jul 2022 18:27:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657218463;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=52SUY6JyZbG8WEnJVe6XQ8+BKvMMWN5FT6AcmkzBpIc=;
        b=T1EHs88mdZJNW3ghcilubzxPwGrE+4aotP6SfzH9+3WVfKYGworA3LEA3SjLELyJKqwOUB
        Rq1rf+hzvpbnlnZoSkXsTCneVZDXnip4bjWmNefwLBbZVb5AbwaZFIReixbXrr0X4hDK0E
        6ClebmlrnnN4XIOcqcY7IpIeTsDBYldzhjbFMYcGukxiSwsvuDM3hMMipGwejVzlElW5fx
        XlP/RFiYLixos7+QTpN2Nt+kes6pFCy9MIXGbn+/8JE9KvbSlDWhxAfcPxx6kd6Q9dsNl3
        JOE/tVIlY+v/BDNen3QtR1Dxgn8d89neVKAT2/mvoG/QosR6gj7fkBnTRNSb3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657218463;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=52SUY6JyZbG8WEnJVe6XQ8+BKvMMWN5FT6AcmkzBpIc=;
        b=jj+BsNsinuWEYX8fYmg5uWHu0Uldpfa81xnfH5iLn/apO1IBgrF6YfF082SIcdolCRrBbL
        5COug3J7+aSJcHAA==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Tighten accessible memory range after enclave
 initialization
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C6391460d75ae79cea2e81eef0f6ffc03c6e9cfe7=2E16521?=
 =?utf-8?q?37848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C6391460d75ae79cea2e81eef0f6ffc03c6e9cfe7=2E165213?=
 =?utf-8?q?7848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165721846233.15455.10093640973103141578.tip-bot2@tip-bot2>
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

Commit-ID:     7b013e723a1f689077347b30778d8831b6d92969
Gitweb:        https://git.kernel.org/tip/7b013e723a1f689077347b30778d8831b6d92969
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Tue, 10 May 2022 11:08:53 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Jul 2022 10:13:03 -07:00

x86/sgx: Tighten accessible memory range after enclave initialization

Before an enclave is initialized the enclave's memory range is unknown.
The enclave's memory range is learned at the time it is created via the
SGX_IOC_ENCLAVE_CREATE ioctl() where the provided memory range is
obtained from an earlier mmap() of /dev/sgx_enclave. After an enclave
is initialized its memory can be mapped into user space (mmap()) from
where it can be entered at its defined entry points.

With the enclave's memory range known after it is initialized there is
no reason why it should be possible to map memory outside this range.

Lock down access to the initialized enclave's memory range by denying
any attempt to map memory outside its memory range.

Locking down the memory range also makes adding pages to an initialized
enclave more efficient. Pages are added to an initialized enclave by
accessing memory that belongs to the enclave's memory range but not yet
backed by an enclave page. If it is possible for user space to map
memory that does not form part of the enclave then an access to this
memory would eventually fail. Failures range from a prompt general
protection fault if the access was an ENCLU[EACCEPT] from within the
enclave, or a page fault via the vDSO if it was another access from
within the enclave, or a SIGBUS (also resulting from a page fault) if
the access was from outside the enclave.

Disallowing invalid memory to be mapped in the first place avoids
preventable failures.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lkml.kernel.org/r/6391460d75ae79cea2e81eef0f6ffc03c6e9cfe7.1652137848.git.reinette.chatre@intel.com
---
 arch/x86/kernel/cpu/sgx/encl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index e5b61a5..295a9c9 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -503,6 +503,11 @@ int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
 
 	XA_STATE(xas, &encl->page_array, PFN_DOWN(start));
 
+	/* Disallow mapping outside enclave's address range. */
+	if (test_bit(SGX_ENCL_INITIALIZED, &encl->flags) &&
+	    (start < encl->base || end > encl->base + encl->size))
+		return -EACCES;
+
 	/*
 	 * Disallow READ_IMPLIES_EXEC tasks as their VMA permissions might
 	 * conflict with the enclave page permissions.
