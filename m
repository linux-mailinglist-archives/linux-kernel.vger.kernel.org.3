Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B7B4B77C4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241153AbiBOTku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:40:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243788AbiBOTkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:40:37 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926A2DEC8;
        Tue, 15 Feb 2022 11:40:21 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2966E212BF;
        Tue, 15 Feb 2022 19:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644954020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=68fQOLkRItMmWbD/0T7ms41beY9KItQEQd86yglltcA=;
        b=aKlJB4z2LkeDmU9Wa0mMaGs6IIOIRehwJLlbsagMlfiCcxE4Vmg8XMaKdc69NsJMOTP0kQ
        6m3gUONyR41Y1JsLuaRlHdm5T0T5CgDHBD4NKdU5H0EGbKgFCfdFIyPtAQQ9PdZVpMEtkw
        yrYtZluMYfIUqDwYid34Yoy17UJjae0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644954020;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=68fQOLkRItMmWbD/0T7ms41beY9KItQEQd86yglltcA=;
        b=zA2og9PY6JLNwNbmuaeKtddqBDmkioJbLp4aWfNO14CRENxwEHInpG/XdjAayhh6IrPC7d
        aDUWFnUPxNtd9/AA==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id E3D36A3B88;
        Tue, 15 Feb 2022 19:40:19 +0000 (UTC)
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
        linux-s390@vger.kernel.org, linux-modules@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        stable@kernel.org
Subject: [PATCH 4/4] module, KEYS: Make use of platform keyring for signature verification
Date:   Tue, 15 Feb 2022 20:39:41 +0100
Message-Id: <840433bc93a58d6dfc4d96c34c0c3b158a0e669d.1644953683.git.msuchanek@suse.de>
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

Commit 278311e417be ("kexec, KEYS: Make use of platform keyring for signature verify")
adds support for use of platform keyring in kexec verification but
support for modules is missing.

Add support for verification of modules with keys from platform keyring
as well.

Fixes: 219a3e8676f3 ("integrity, KEYS: add a reference to platform keyring")
Cc: linux-modules@vger.kernel.org
Cc: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: stable@kernel.org
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 kernel/module_signing.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/module_signing.c b/kernel/module_signing.c
index 8723ae70ea1f..5e1624294874 100644
--- a/kernel/module_signing.c
+++ b/kernel/module_signing.c
@@ -38,8 +38,14 @@ int mod_verify_sig(const void *mod, struct load_info *info)
 	modlen -= sig_len + sizeof(ms);
 	info->len = modlen;
 
-	return verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
-				      VERIFY_USE_SECONDARY_KEYRING,
-				      VERIFYING_MODULE_SIGNATURE,
-				      NULL, NULL);
+	ret = verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
+				     VERIFY_USE_SECONDARY_KEYRING,
+				     VERIFYING_MODULE_SIGNATURE,
+				     NULL, NULL);
+	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING))
+		ret = verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
+					     VERIFY_USE_PLATFORM_KEYRING,
+					     VERIFYING_MODULE_SIGNATURE,
+					     NULL, NULL);
+	return ret;
 }
-- 
2.31.1

