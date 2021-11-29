Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9567246170E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhK2NzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:55:12 -0500
Received: from cpanel.siel.si ([46.19.9.99]:49344 "EHLO cpanel.siel.si"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239971AbhK2NxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:53:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=8EAKb95gtXLKs+U0UB2Day1ckx1nOgESl8vDeQsMJJ4=; b=q/ZnZIy8p8ZOhMLcskFese8k+v
        Umc6a04g9brQmMyiVcPDuC6orVtf/4a7+7kOuqjuxtId3iF4a5JckuNgmctSvyDscDfnd7mUvs2O3
        fN8m6llgxVUA9EgPyR17CRY4KIUHxbkfuyulb5QjmgJXJEsRq/+wHtGfAhHqCNzgPTQlj7Wkz59mN
        BjjqJ5O0yCCZpsht/CivL91Njq7KllvA6b+31qM3G7coHFYK/Ef8MX9M3fHiGCj8vlrF9uyJ1MRsu
        yTxDRhpuVuB070O3RgeG3mu546wFahVryVpfUYi/0Lp3r9RBIDZQMdPlwA10Wm8aTbQ1QnCDpjGE/
        qnDYpOUA==;
Received: from [89.212.21.243] (port=33236 helo=localhost.localdomain)
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <andrej.picej@norik.com>)
        id 1mrh2M-00FLFR-3W; Mon, 29 Nov 2021 14:49:42 +0100
From:   Andrej Picej <andrej.picej@norik.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org
Cc:     y.bas@phytec.de, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: da9063: Add hard dependency on I2C
Date:   Mon, 29 Nov 2021 14:49:38 +0100
Message-Id: <20211129134938.3273289-1-andrej.picej@norik.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5ea29919c294 ("watchdog: da9063: use atomic safe i2c transfer in
reset handler") implements atomic save i2c transfer which uses i2c
functions directly. Add I2C hard dependency which overrides COMPILE_TEST.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 5ea29919c294 ("watchdog: da9063: use atomic safe i2c transfer in reset handler")
Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
 drivers/watchdog/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 9d222ba17ec6..3207085f799f 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -207,6 +207,7 @@ config DA9055_WATCHDOG
 config DA9063_WATCHDOG
 	tristate "Dialog DA9063 Watchdog"
 	depends on MFD_DA9063 || COMPILE_TEST
+	depends on I2C
 	select WATCHDOG_CORE
 	help
 	  Support for the watchdog in the DA9063 PMIC.
-- 
2.25.1

