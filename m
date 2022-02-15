Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149274B7554
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243781AbiBOTke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:40:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243767AbiBOTk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:40:28 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015E0DEC8;
        Tue, 15 Feb 2022 11:40:18 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B09F61F39A;
        Tue, 15 Feb 2022 19:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644954016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DGUOnL4eb1J1D0pFPnIDYxSa1sO10AgM2xSKYQcLTEE=;
        b=cJW1P+L/QmgeUUEz9Y1zUVPpfhejzLydDhiK0Cc6eEsg6uQXBZKz40P+/8Q9YXX9k8rlKl
        b625pXH+7QEP3FIWByvk6RX88OrNb8fb/aWIQwc83tugiYUwfnswwsUP7m1XjmUP8CAYH7
        rvEAZyB/vHMtreosWGpWVajiTQU8Wfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644954016;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DGUOnL4eb1J1D0pFPnIDYxSa1sO10AgM2xSKYQcLTEE=;
        b=35x2kEA8v1pCAlROHWtUCn3jRUAIkHXiQlViAb1mQH9R9pLnO9oXX85jcsbsf9lrd58AKJ
        95W7LBx68H5TqZAQ==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id 7D68DA3B83;
        Tue, 15 Feb 2022 19:40:16 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Philipp Rudo <prudo@redhat.com>, Baoquan He <bhe@redhat.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Dave Young <dyoung@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Kairui Song <kasong@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kexec@lists.infradead.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        stable@kernel.org
Subject: [PATCH 2/4] kexec, KEYS, arm64: Make use of platform keyring for signature verification
Date:   Tue, 15 Feb 2022 20:39:39 +0100
Message-Id: <7581dcfe676024aa438beddecbf162e4ec81ccfc.1644953683.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1644953683.git.msuchanek@suse.de>
References: <cover.1644953683.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 278311e417be ("kexec, KEYS: Make use of platform keyring for signature verify")
adds platform keyring support on x86 kexec but not arm64.

Add platform keyring support on arm64 as well.

Fixes: 278311e417be ("kexec, KEYS: Make use of platform keyring for signature verify")
Cc: kexec@lists.infradead.org
Cc: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: stable@kernel.org
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/arm64/kernel/kexec_image.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index 1fbf2ee7c005..3dee7b2d8336 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -133,9 +133,17 @@ static void *image_load(struct kimage *image,
 #ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
 static int image_verify_sig(const char *kernel, unsigned long kernel_len)
 {
-	return verify_pefile_signature(kernel, kernel_len,
-				       VERIFY_USE_SECONDARY_KEYRING,
-				       VERIFYING_KEXEC_PE_SIGNATURE);
+	int ret;
+
+	ret = verify_pefile_signature(kernel, kernel_len,
+				      VERIFY_USE_SECONDARY_KEYRING,
+				      VERIFYING_KEXEC_PE_SIGNATURE);
+	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
+		ret = verify_pefile_signature(kernel, kernel_len,
+					      VERIFY_USE_PLATFORM_KEYRING,
+					      VERIFYING_KEXEC_PE_SIGNATURE);
+	}
+	return ret;
 }
 #endif
 
-- 
2.31.1

