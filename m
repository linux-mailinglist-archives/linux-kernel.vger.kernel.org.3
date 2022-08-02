Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1872758821E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 20:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiHBS4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 14:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiHBSzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 14:55:51 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF29140F3
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 11:55:50 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id o12-20020a170902d4cc00b0016e81c62cc8so6590078plg.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 11:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=30XQYa5vrUU1iEUJfeVFtkHZOATBPFqy9Zstl/P+5z8=;
        b=U/mM+hN/C9aAjBSxsdYTboDvUHBaLxpmZHMEt1gXXrEYG5YnjVUHfwWO9nmAq85hJz
         UTR5zjqMgwVwaTR19xC5TJQgFnhfameFuoB+lfYBuuUy4D1niJ6wZ62eikVApZlFeFMR
         aMkbolcOb6t6yrchlJNNedj2XApSOt6SyAvuW59QBWSHdtP+wZxcMH4hDFPeDtnsQqDp
         26zMYgyhgUITcYf/alnF6RyWJUb+YfMkL6RplnfXRVix8/5Fc+C7qHKzmdKo5Y4gDOJ+
         3coU4Y3V1OG2KybEjG/wLaR38gtHzJZU02zNzPgC4yTKLtWnyWb0lhzKO3Yty3Mfcvv0
         lyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=30XQYa5vrUU1iEUJfeVFtkHZOATBPFqy9Zstl/P+5z8=;
        b=4147/9pIA/ZSbmaddkjXTd9ZgQOEcTOZf/9MS4tW0cm5YzhcoSNQKSlr2hqN+lvTJM
         OuNY7KJpLowkzSQKGlmxcbghjiezhjU2L2u8bLgpWizcf4gFtmLyqkOZ2AuS2AtN2UOn
         0OEvQOMOPUO0HR8laNWbf90fjjoXfdUPM4Si/MqU8P9+y1OOA8dvMfg5ZPsPH9o1biGA
         qE8cHCxgrdwH5VFP4nxSQdNvcFS7N7R3FTbfKHVEwwZ08Eqj1sAvAVQA06dOF+crUgzF
         DqXrZ3J2uFvtNawJPXbXxh0SgeIdhyMHgigJJIboegUhV8XLx6FKEgN1y5907hmkVeBN
         Hybg==
X-Gm-Message-State: ACgBeo2Gxsr2s7XqDbRTvsGVq99Kkx95puT+GXBu64kfs+Yu3RY/hTcl
        zNgsB34EfHQzk13fOGL/lEzyMu87eXc=
X-Google-Smtp-Source: AA6agR6yQ+fa8aAJU91nirXEpLdJfvOKRCf8sGouwqrIk3ZQl0y+7CwvEhHK1EqDROOKe3AB5MwuoE4CU6hr
X-Received: from jackyli.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3b51])
 (user=jackyli job=sendgmr) by 2002:a17:90b:4b91:b0:1f4:e116:8f1 with SMTP id
 lr17-20020a17090b4b9100b001f4e11608f1mr870049pjb.121.1659466549678; Tue, 02
 Aug 2022 11:55:49 -0700 (PDT)
Date:   Tue,  2 Aug 2022 18:55:33 +0000
In-Reply-To: <20220802185534.735338-1-jackyli@google.com>
Message-Id: <20220802185534.735338-2-jackyli@google.com>
Mime-Version: 1.0
References: <20220802185534.735338-1-jackyli@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH 1/2] crypto: ccp - Initialize PSP when reading psp data file failed
From:   Jacky Li <jackyli@google.com>
To:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Marc Orr <marcorr@google.com>, Alper Gun <alpergun@google.com>,
        Peter Gonda <pgonda@google.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jacky Li <jackyli@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the OS fails the PSP initialization when the file specified at
'init_ex_path' does not exist or has invalid content. However the SEV
spec just requires users to allocate 32KB of 0xFF in the file, which can
be taken care of by the OS easily.

To improve the robustness during the PSP init, leverage the retry
mechanism and continue the init process:

During the first INIT_EX call, if the content is invalid or missing,
continue the process by feeding those contents into PSP instead of
aborting. PSP will then override it with 32KB 0xFF and return
SEV_RET_SECURE_DATA_INVALID status code. In the second INIT_EX call,
this 32KB 0xFF content will then be fed and PSP will write the valid
data to the file.

In order to do this, it's also needed to skip the sev_read_init_ex_file
in the second INIT_EX call to prevent the file content from being
overwritten by the 32KB 0xFF data provided by PSP in the first INIT_EX
call.

Co-developed-by: Peter Gonda <pgonda@google.com>
Signed-off-by: Peter Gonda <pgonda@google.com>
Signed-off-by: Jacky Li <jackyli@google.com>
Reported-by: Alper Gun <alpergun@google.com>
---
 .../virt/kvm/x86/amd-memory-encryption.rst    |  5 ++--
 drivers/crypto/ccp/sev-dev.c                  | 29 +++++++++++++------
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/Documentation/virt/kvm/x86/amd-memory-encryption.rst b/Documentation/virt/kvm/x86/amd-memory-encryption.rst
index 2d307811978c..935aaeb97fe6 100644
--- a/Documentation/virt/kvm/x86/amd-memory-encryption.rst
+++ b/Documentation/virt/kvm/x86/amd-memory-encryption.rst
@@ -89,9 +89,8 @@ context. In a typical workflow, this command should be the first command issued.
 
 The firmware can be initialized either by using its own non-volatile storage or
 the OS can manage the NV storage for the firmware using the module parameter
-``init_ex_path``. The file specified by ``init_ex_path`` must exist. To create
-a new NV storage file allocate the file with 32KB bytes of 0xFF as required by
-the SEV spec.
+``init_ex_path``. If the file specified by ``init_ex_path`` does not exist or
+is invalid, the OS will create or override the file with output from PSP.
 
 Returns: 0 on success, -negative on error
 
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 799b476fc3e8..5bb2ae250d38 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -75,6 +75,7 @@ static void *sev_es_tmr;
  */
 #define NV_LENGTH (32 * 1024)
 static void *sev_init_ex_buffer;
+static bool nv_file_loaded;
 
 static inline bool sev_version_greater_or_equal(u8 maj, u8 min)
 {
@@ -211,18 +212,19 @@ static int sev_read_init_ex_file(void)
 	if (IS_ERR(fp)) {
 		int ret = PTR_ERR(fp);
 
-		dev_err(sev->dev,
-			"SEV: could not open %s for read, error %d\n",
-			init_ex_path, ret);
+		if (ret != -ENOENT) {
+			dev_err(sev->dev,
+				"SEV: could not open %s for read, error %d\n",
+				init_ex_path, ret);
+		}
 		return ret;
 	}
 
 	nread = kernel_read(fp, sev_init_ex_buffer, NV_LENGTH, NULL);
 	if (nread != NV_LENGTH) {
-		dev_err(sev->dev,
-			"SEV: failed to read %u bytes to non volatile memory area, ret %ld\n",
+		dev_info(sev->dev,
+			"SEV: could not read %u bytes to non volatile memory area, ret %ld\n",
 			NV_LENGTH, nread);
-		return -EIO;
 	}
 
 	dev_dbg(sev->dev, "SEV: read %ld bytes from NV file\n", nread);
@@ -417,9 +419,18 @@ static int __sev_init_ex_locked(int *error)
 	data.nv_address = __psp_pa(sev_init_ex_buffer);
 	data.nv_len = NV_LENGTH;
 
-	ret = sev_read_init_ex_file();
-	if (ret)
-		return ret;
+	/*
+	 * The caller of INIT_EX will retry if it fails. Furthermore, if the
+	 * failure is due to sev_init_ex_buffer being invalid, the PSP will have
+	 * properly initialized the buffer already. Therefore, do not initialize
+	 * it a second time.
+	 */
+	if (!nv_file_loaded) {
+		ret = sev_read_init_ex_file();
+		if (ret && ret != -ENOENT)
+			return ret;
+		nv_file_loaded = true;
+	}
 
 	if (sev_es_tmr) {
 		/*
-- 
2.37.1.455.g008518b4e5-goog

