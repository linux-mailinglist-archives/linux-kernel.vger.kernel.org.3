Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83CB47F708
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 15:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbhLZNzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 08:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhLZNzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 08:55:11 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECACDC06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 05:55:10 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id jw3so11354486pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 05:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EIaMoqUxFiiUxyBq+wPrrTf5jUX6jSpbT47dWykk9D4=;
        b=qJ6HhOM4nEJ/vAU/1zGVzSteIJoAvH03kPWHDMScA1AICLZ39COnqKlVw0RwqyBrSS
         4+e6UjeI3Wrcxzj9l29/E6nUg0+7mlwWTvqVfG3FDMVT6FI/r4c6mGtatHgZOTIaPgq+
         E4hVzXW15DXnUbzt48aOaQ4uV2OuU7fS8VXxo3o7pxtzEZxF4jRtJ4VM0AehhMK42ey+
         rZsgjuq1pz+8biwPv77Wk3loETZLclimL/jd2ITaoEFm8sYtObscYD0gyhgd1pNPX3tI
         csDDJGC5RySaePXjmOnS5vldfpjJqjdzPLTzDR9DXwRh6NgUrcJRFYASe7TC5/8H2eSu
         gOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EIaMoqUxFiiUxyBq+wPrrTf5jUX6jSpbT47dWykk9D4=;
        b=6OU6RBgNGNhRH7oDwFlUVBdTiv/Vup/1gDlKvWR7axq70OaLve7iT0vOGWL6c/1Y2G
         Z0KswN6gyUbVtxnAz9PAHbplSgRt92q0Jg4Qbw5ZKcNjmeD0EA0NoRSbBZwU50VTsVf+
         B8WLqP55xGH68hRraT6HGXfkwnls16r6WrGB+LZ2uPRlyJBHk1oRCCR1aTz3TyxErTCK
         1r5nCk1chpoQ3Dh0OUvavLV1v3bCiF9pI9Abf1xXkUkgOnlIr2vXKvEucSyLAvojyuWg
         x05G52MT4SLHqop97G0ULUNvFG6e5OYlAKD4ZrZe22cs/Ttg4skpOCRsBhiPYbwagF78
         nl+w==
X-Gm-Message-State: AOAM531dDCwg/5rHONxS9C6W4VJBZLqjf7TWx30O2tlM1cm9CH0jeF+c
        pMInbeFRF7eYMp4Xngh9luBVOVDlVyo=
X-Google-Smtp-Source: ABdhPJwMORIXN8+a6PzVjBGzReSTLE1RuvvPpjPEObsJQH2lATNuMEfeIi6FWpmaf7Zz3nLWt7cipw==
X-Received: by 2002:a17:90b:3551:: with SMTP id lt17mr16844169pjb.1.1640526909797;
        Sun, 26 Dec 2021 05:55:09 -0800 (PST)
Received: from integral2.. ([180.254.126.2])
        by smtp.gmail.com with ESMTPSA id y65sm11990625pgd.79.2021.12.26.05.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 05:55:09 -0800 (PST)
From:   Ammar Faizi <ammarfaizi2@gmail.com>
To:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Ammar Faizi <ammarfaizi2@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Yang Li <yang.lee@linux.alibaba.com>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH] powerpc/xive: Add missing null check after calling kmalloc
Date:   Sun, 26 Dec 2021 20:54:02 +0700
Message-Id: <20211226135314.251221-1-ammar.faizi@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 930914b7d528fc ("powerpc/xive: Add a debugfs file to dump
internal XIVE state") forgot to add a null check.

Add it.

Cc: Cédric Le Goater <clg@kaod.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Fixes: 930914b7d528fc6b0249bffc00564100bcf6ef75 ("powerpc/xive: Add a debugfs file to dump internal XIVE state")
Signed-off-by: Ammar Faizi <ammarfaizi2@gmail.com>
---
 arch/powerpc/sysdev/xive/spapr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
index f143b6f111ac..1179632560b8 100644
--- a/arch/powerpc/sysdev/xive/spapr.c
+++ b/arch/powerpc/sysdev/xive/spapr.c
@@ -653,6 +653,9 @@ static int xive_spapr_debug_show(struct seq_file *m, void *private)
 	struct xive_irq_bitmap *xibm;
 	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);

+	if (!buf)
+		return -ENOMEM;
+
 	list_for_each_entry(xibm, &xive_irq_bitmaps, list) {
 		memset(buf, 0, PAGE_SIZE);
 		bitmap_print_to_pagebuf(true, buf, xibm->bitmap, xibm->count);
--
2.32.0

