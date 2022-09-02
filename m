Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB275ABB55
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 01:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiIBXmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 19:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiIBXmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 19:42:21 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72298E39B7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 16:42:17 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j9-20020a17090a3e0900b001fd9568b117so3506014pjc.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 16:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=yLY1ejrRMFBfwfiTLCUWmHI559ulys0U/bajbSkKPRA=;
        b=lI3k1MvqFtz0RmNR86j11DAck9+4Yt2ox89NAsHGWkHjeDGyZuqjFbw8k0HwcNxyrF
         OWteMND8jXbAm0dKHOFMq4wOcamDnga4W1npPuLx7yXMVXV3jM3yFtOTblzuHDPqkeNb
         NcfQJ2bz8X+LpJzjdJrbfbAxxCcJ5PBnWWqvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=yLY1ejrRMFBfwfiTLCUWmHI559ulys0U/bajbSkKPRA=;
        b=QJHbddjLeMQHlbxDlzjiq3nM7DJW2cNCogWVli3jizWkHmPDH76exALW2SoxTcYsnq
         Y6NIu/uwB1HRv1s91DYQCHONJCGTCYTTJC3+LaZZXD0j7/nIUdGPTou3urrvS0sKBjbk
         bzF6ydbi/ddAXUo28tEfZp6/KyAHlyFu6/cfgxu64MPKhkbUT2EP9w3gs1aBdruQlmr3
         D9gMVAScSjjRLWI27qnEeDJCNY18JjpJvm74eTPJWYyO7HrkaoLpxT1Sbvacl3y+ArrY
         KXM4EC8xd4wcO47mOM0SCywGHFWiXoz/OMNE1c3eGHG2npcJbVgHXX49f64wCCM10i3P
         q74w==
X-Gm-Message-State: ACgBeo0md1/Wn3RTDRu0kh9AZjGMqc2z6mT7Otblbt8GliPXKC44g5Wk
        Ypf3qW4q+wGQYr7NVmVWPhRXJG69j0Eeyg==
X-Google-Smtp-Source: AA6agR5onhP71dq8nqAUQs3ys+4lKThdEj5Rk73p5/KLhwxW0zPWs+OiG8CWpGbMXIbfcQJY76uy5Q==
X-Received: by 2002:a17:902:ce88:b0:174:e20a:8ef2 with SMTP id f8-20020a170902ce8800b00174e20a8ef2mr23853927plg.51.1662162137001;
        Fri, 02 Sep 2022 16:42:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r12-20020aa7988c000000b0053612ec8859sm2346490pfl.209.2022.09.02.16.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 16:42:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] x86/Kconfig: Enable kernel IBT by default
Date:   Fri,  2 Sep 2022 16:42:13 -0700
Message-Id: <20220902234213.3034396-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1152; h=from:subject; bh=QnLzs1GDPCKo06FTPfmk5xw+8Ls7C8rAgTMmLburhjw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjEpTVMyugRDWXY06xWHTBIcEYvUEirn6Nof13Xwku Cp5eGcWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYxKU1QAKCRCJcvTf3G3AJo4ND/ 9tN+2yiM4HJZNfQ+uIxziGc3CXz2sK3A1WmppXH1QlAGlq5OPGOBE5VQRgu6sHaPZmDo78CCieJ9oq +4zGAIqsXTSi1YNaEHjHcnmfkAxd9HPKWfsV3nHYjpi2kP8uy37GILkBoiqYKxnsJw3oMcoghroFUZ Cq/6mduend+DJdSd1TXQxKwlfEfT0KVMgB5IQyQvJJUXXJqa8ERbvE2V46JiPfdi8XiB9qRHdMXeLu 8gRYWszUyUVF5SSFzL7bKIKLPvBTbaQ6/NmOoMW75l6xpqCY6a3JmqfUpVe374SDUyNoIPM9rhlWFE zOGZB19kjDfqItJK1OIdN39oRfAMm9CFe11e4zdZbs/UnKcYgOkxZJIcRnvesXXE3YYgB5cVAqpyFa AHXPufl7pkI4LbYc6j6aBCjsbs/HuFi5IoqAN9kM+CJBzAukiw+mxD74CpFZ1PVIULlC0ilHSAws+l iEQ0TDZ3QLVC9b0b76IF3OUgpdwc/wBtEcsDiZKNCN4uDbXIWAZW8483da+qHH0417Rbn8kQwalk0v acAM/HUGnE8cSFUPQH0kZe8zddK2osWKvlHbI174zBp1+iwDvDrfiogFQ1dt8BA8rHe+asMdFjrjJ2 Vr9aGqPssTMZSBWy5WS5y0PBVSDVnt2Dr5ABlIGwOWFtNCUNg0kd9lqc64Rw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This security defense is runtime enabled via CPU ID, so build it in by
default. It will be enabled if the CPU supports it. The build takes
2 seconds longer, which seems a small price to pay for gaining this
coverage by default.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Suggested-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f9920f1341c8..b48fd28cba4a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1837,7 +1837,7 @@ config CC_HAS_IBT
 
 config X86_KERNEL_IBT
 	prompt "Indirect Branch Tracking"
-	bool
+	def_bool y
 	depends on X86_64 && CC_HAS_IBT && HAVE_OBJTOOL
 	# https://github.com/llvm/llvm-project/commit/9d7001eba9c4cb311e03cd8cdc231f9e579f2d0f
 	depends on !LD_IS_LLD || LLD_VERSION >= 140000
-- 
2.34.1

