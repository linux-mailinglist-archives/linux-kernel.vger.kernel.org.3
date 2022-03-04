Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446664CD13E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237642AbiCDJi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239141AbiCDJhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:37:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB841A8CBA;
        Fri,  4 Mar 2022 01:36:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68681617F0;
        Fri,  4 Mar 2022 09:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8B3C340E9;
        Fri,  4 Mar 2022 09:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646386576;
        bh=4uTKe1JGywslwsGE4l2G1XqtfPGk1rXc/fU95S0qp2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VDZkk7dwNX7PG02qC7JlFPOXH5SQq2Ddek8pRIqFQcdvipsS1KfXIv2JJBDIoxH2w
         RcrS3gvIEZ/8JoIBwvrOMIeMfqJzci2ISDFNGzFljtekKNPEPR8FHvYBhkl6LIQTS2
         GwAe5WiFK9v0PMlo/BaNuQVU1diE7WTekeQOchBb6PbnhbBWSRBNn+7DXlepVhWELa
         NhVPOqdqVYKHZPUUv16lOvtdQT2wjeUJgLZdCqvjj7xxrrK7LyHK4olPC4bTvh+YQY
         iFRhmNuEDjlu+63nOYB/LXXSGrOjTLdd1cgZOjcimOjn4EmsI1A3+LcdbFwgBpcb8F
         qLSuzxVq1W/LQ==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [RFC PATCH v2.1 02/30] x86/sgx: Add wrapper for SGX2 EMODPR function
Date:   Fri,  4 Mar 2022 11:34:56 +0200
Message-Id: <20220304093524.397485-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304093524.397485-1-jarkko@kernel.org>
References: <20220304093524.397485-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Reinette Chatre <reinette.chatre@intel.com>

Add a wrapper for the EMODPR ENCLS leaf function used to
restrict enclave page permissions as maintained in the
SGX hardware's Enclave Page Cache Map (EPCM).

EMODPR:
1) Updates the EPCM permissions of an enclave page by treating
   the new permissions as a mask - supplying a value that relaxes
   EPCM permissions has no effect.
2) Sets the PR bit in the EPCM entry of the enclave page to
   indicate that permission restriction is in progress. The bit
   is reset by the enclave by invoking ENCLU leaf function
   EACCEPT or EACCEPTCOPY.

The enclave may access the page throughout the entire process
if conforming to the EPCM permissions for the enclave page.

After performing the permission restriction by issuing EMODPR
the kernel needs to collaborate with the hardware to ensure that
all logical processors sees the new restricted permissions. This
is required for the enclave's EACCEPT/EACCEPTCOPY to succeed and
is accomplished with the ETRACK flow.

Expand enum sgx_return_code with the possible EMODPR return
values.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/include/asm/sgx.h      | 5 +++++
 arch/x86/kernel/cpu/sgx/encls.h | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
index 3f9334ef67cd..d67810b50a81 100644
--- a/arch/x86/include/asm/sgx.h
+++ b/arch/x86/include/asm/sgx.h
@@ -65,17 +65,22 @@ enum sgx_encls_function {
 
 /**
  * enum sgx_return_code - The return code type for ENCLS, ENCLU and ENCLV
+ * %SGX_EPC_PAGE_CONFLICT:	Page is being written by other ENCLS function.
  * %SGX_NOT_TRACKED:		Previous ETRACK's shootdown sequence has not
  *				been completed yet.
  * %SGX_CHILD_PRESENT		SECS has child pages present in the EPC.
  * %SGX_INVALID_EINITTOKEN:	EINITTOKEN is invalid and enclave signer's
  *				public key does not match IA32_SGXLEPUBKEYHASH.
+ * %SGX_PAGE_NOT_MODIFIABLE:	The EPC page cannot be modified because it
+ *				is in the PENDING or MODIFIED state.
  * %SGX_UNMASKED_EVENT:		An unmasked event, e.g. INTR, was received
  */
 enum sgx_return_code {
+	SGX_EPC_PAGE_CONFLICT		= 7,
 	SGX_NOT_TRACKED			= 11,
 	SGX_CHILD_PRESENT		= 13,
 	SGX_INVALID_EINITTOKEN		= 16,
+	SGX_PAGE_NOT_MODIFIABLE		= 20,
 	SGX_UNMASKED_EVENT		= 128,
 };
 
diff --git a/arch/x86/kernel/cpu/sgx/encls.h b/arch/x86/kernel/cpu/sgx/encls.h
index 0e22fa8f77c5..2b091912f038 100644
--- a/arch/x86/kernel/cpu/sgx/encls.h
+++ b/arch/x86/kernel/cpu/sgx/encls.h
@@ -215,4 +215,10 @@ static inline int __ewb(struct sgx_pageinfo *pginfo, void *addr,
 	return __encls_ret_3(EWB, pginfo, addr, va);
 }
 
+/* Restrict the EPCM permissions of an EPC page. */
+static inline int __emodpr(struct sgx_secinfo *secinfo, void *addr)
+{
+	return __encls_ret_2(EMODPR, secinfo, addr);
+}
+
 #endif /* _X86_ENCLS_H */
-- 
2.35.1

