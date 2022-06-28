Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8DB55C37B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244121AbiF1Jqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239715AbiF1Jqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:46:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E64625C40;
        Tue, 28 Jun 2022 02:46:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8573617B2;
        Tue, 28 Jun 2022 09:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28169C341CD;
        Tue, 28 Jun 2022 09:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656409590;
        bh=Dobj9yjTJrK/J/vsMeQNCoBHeBjpfx+RuR+DAv7rT1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o7beWfPaBf1rEDF4k2UDO6dCfuzGVu1HCxgPmE3qcE2bkfMHR28T1TkkbSZNXqdUh
         udQdVnK26VXUdQC/K6QAQmUDVQlxqjMpX5Scj9HJxICuPaH8SCluoqD3FPek/H93Dp
         rvItpW/a91giX5JJPfYhD2s8/7wjAp5JPyyU0p0xwPpwC0FzqyKJnkkdRWWJ9VXtLw
         X+8RpZgk4mrpsiUXmLwUXzO3ItM/7tEtp1MGAqc2+XpE9z2QdPC661aNPIhOoqHktZ
         6u8It/mxBmrNnr9PH3sbyyyWJRe9nY8hURf1gfne11k3884iRqKdFSFrR3SZHs+YME
         PRECThEbNa/hg==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o67nf-005HEv-Me;
        Tue, 28 Jun 2022 10:46:27 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH 04/22] x86/sgx: fix kernel-doc markups
Date:   Tue, 28 Jun 2022 10:46:08 +0100
Message-Id: <49f0900ca467867917182a4428b731e55608ca67.1656409369.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656409369.git.mchehab@kernel.org>
References: <cover.1656409369.git.mchehab@kernel.org>
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

There are a couple typos there, violating kernel-doc syntax.

Also, on a function typedef, the register snapshots aren't
documented.

This should fix those warnings:

	arch/x86/include/uapi/asm/sgx.h:19: warning: Enum value 'SGX_PAGE_MEASURE' not described in enum 'sgx_page_flags'
	arch/x86/include/uapi/asm/sgx.h:97: warning: Function parameter or member 'rdi' not described in 'sgx_enclave_user_handler_t'
	arch/x86/include/uapi/asm/sgx.h:97: warning: Function parameter or member 'rsi' not described in 'sgx_enclave_user_handler_t'
	arch/x86/include/uapi/asm/sgx.h:97: warning: Function parameter or member 'rdx' not described in 'sgx_enclave_user_handler_t'
	arch/x86/include/uapi/asm/sgx.h:97: warning: Function parameter or member 'rsp' not described in 'sgx_enclave_user_handler_t'
	arch/x86/include/uapi/asm/sgx.h:97: warning: Function parameter or member 'r8' not described in 'sgx_enclave_user_handler_t'
	arch/x86/include/uapi/asm/sgx.h:97: warning: Function parameter or member 'r9' not described in 'sgx_enclave_user_handler_t'
	arch/x86/include/uapi/asm/sgx.h:124: warning: Function parameter or member 'reserved' not described in 'sgx_enclave_run'

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/22] at: https://lore.kernel.org/all/cover.1656409369.git.mchehab@kernel.org/

 arch/x86/include/uapi/asm/sgx.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
index f4b81587e90b..e0e6a3ebc941 100644
--- a/arch/x86/include/uapi/asm/sgx.h
+++ b/arch/x86/include/uapi/asm/sgx.h
@@ -10,7 +10,7 @@
 
 /**
  * enum sgx_page_flags - page control flags
- * %SGX_PAGE_MEASURE:	Measure the page contents with a sequence of
+ * @SGX_PAGE_MEASURE:	Measure the page contents with a sequence of
  *			ENCLS[EEXTEND] operations.
  */
 enum sgx_page_flags {
@@ -81,6 +81,12 @@ struct sgx_enclave_run;
 /**
  * typedef sgx_enclave_user_handler_t - Exit handler function accepted by
  *					__vdso_sgx_enter_enclave()
+ * @rdi:	snapshot of DI register at enclave exit
+ * @rsi:	snapshot of SI register at enclave exit
+ * @rdx:	snapshot of DX register at enclave exit
+ * @rsp:	snapshot of SP register at enclave exit
+ * @r8:		snapshot of R8 register at enclave exit
+ * @r9:		snapshot of R9 register at enclave exit
  * @run:	The run instance given by the caller
  *
  * The register parameters contain the snapshot of their values at enclave
@@ -104,7 +110,7 @@ typedef int (*sgx_enclave_user_handler_t)(long rdi, long rsi, long rdx,
  * @exception_addr:		The address that triggered the exception
  * @user_handler:		User provided callback run on exception
  * @user_data:			Data passed to the user handler
- * @reserved			Reserved for future extensions
+ * @reserved:			Reserved for future extensions
  *
  * If @user_handler is provided, the handler will be invoked on all return paths
  * of the normal flow.  The user handler may transfer control, e.g. via a
-- 
2.36.1

