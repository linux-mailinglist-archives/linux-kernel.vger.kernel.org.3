Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460C24B0E3A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 14:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242055AbiBJNQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 08:16:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237360AbiBJNQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:16:51 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DEF1142
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 05:16:53 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F0F4F1F391;
        Thu, 10 Feb 2022 13:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644499012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=YTZipR0AHH/3JqUp1siZN5/DeW54S/X1Be4gcHmMiN4=;
        b=ZMpsYB/5pf7AqZsawRLtReJBCSmGV1NOXBregl7I2VX/8IFUCBRWCAqojwbk3zRLGz/IXU
        9Ffw4CzRGx7Hxjt3BOemPLSQFBTj8YhYq3FvLu1cc39wJhoF1eMnJcrAK27j6c/Ie6Fv7m
        87Gzo/cxDw9Bgkih9srx1UXjaDJih5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644499012;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=YTZipR0AHH/3JqUp1siZN5/DeW54S/X1Be4gcHmMiN4=;
        b=kv3wNPpXOwpNUU7nJVaX0XP9kJxepzVGb0PzM2Ps4Z2L/UN34bsGylM5Okmk1lPoC6iBiR
        /lS4jXrJsYalLbDw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id 47B68A3B87;
        Thu, 10 Feb 2022 13:16:50 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     kexec@lists.infradead.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Colin Ian King <colin.king@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kexec: move KEXEC_SIG_FORCE from arch/x86 to arch
Date:   Thu, 10 Feb 2022 14:16:48 +0100
Message-Id: <20220210131648.16276-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is nothing x86-specific about KEXEC_SIG_FORCE

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/Kconfig     | 7 +++++++
 arch/x86/Kconfig | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 678a80713b21..dc2446f01ac1 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -24,6 +24,13 @@ config KEXEC_ELF
 config HAVE_IMA_KEXEC
 	bool
 
+config KEXEC_SIG_FORCE
+	bool "Require a valid signature in kexec_file_load() syscall"
+	depends on KEXEC_SIG
+	help
+	  This option makes kernel signature verification mandatory for
+	  the kexec_file_load() syscall.
+
 config SET_FS
 	bool
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9f5bd41bf660..3ea648dad6b6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2032,13 +2032,6 @@ config KEXEC_SIG
 	  verification for the corresponding kernel image type being
 	  loaded in order for this to work.
 
-config KEXEC_SIG_FORCE
-	bool "Require a valid signature in kexec_file_load() syscall"
-	depends on KEXEC_SIG
-	help
-	  This option makes kernel signature verification mandatory for
-	  the kexec_file_load() syscall.
-
 config KEXEC_BZIMAGE_VERIFY_SIG
 	bool "Enable bzImage signature verification support"
 	depends on KEXEC_SIG
-- 
2.31.1

