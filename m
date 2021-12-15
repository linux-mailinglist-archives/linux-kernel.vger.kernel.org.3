Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FCC47527B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 07:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhLOGEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 01:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhLOGEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 01:04:44 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC5EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 22:04:44 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id gu12so19406059qvb.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 22:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2R5OeRRbE3oFvfnQ6EkZyxFAy5mgz3HVPN8knpgRZ+4=;
        b=j66aG4va2AEf5a1Tg6TnnySxzXSk/TojXjsiXYw/cLsBi9ppRIfHI8dkr4sfgZq0gP
         FnYFLdYXXaICFTm+/BRikIVOPfie847o0a895FY71HhfKMfMt3nxCh6DgjPMw5hDhZCO
         8j7bfg9SYEfSIPzm1HtzGHrrSJtRMNvXNJB49hUOnUJf6pHyh60aR+BNW3w/Iw/81fua
         qmJg04DcI5IjnUNcRRDfBWbOFUAQJ8ePKTpDaQYzaOz3fDO06mrn7u7AM0Ym5I+Wwrpn
         na7f7CQDeuERZpkW6BQu4GU1hN/RyLLcS4DG95SeK4lMQS5Z6BrvQiHa4SDltuytfyaG
         qyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2R5OeRRbE3oFvfnQ6EkZyxFAy5mgz3HVPN8knpgRZ+4=;
        b=vepwkB8WwpRNmQPocBnzQ1rtP/iZ0IGTX4sV/NqBLM0TvgVdhe4ZodliT7X+xSWRiG
         AVjMR/2BgzPAU7BwtSRnImJcF/mWD1LKkzwUyzHohjaPBmwFG/+Qa7agouSHITBnMK+V
         Bk+qSIG+tl73OQgrldi89+uosC2aC0PYKdB0syGn3cOZftCHV3vfxbhiKBaXbgC4mKQO
         kVMC8FIe5Ld4u+7pjL/S+Izc52SyOhuDoY77NVQ5N2SO8By9VBKPGxnaX8oSHTm3uUZn
         haj5Ey68QcKsa1wlAvERokSxyM/KvcbZlTqXAlrGBydukQ4EYBcqOmiH0vXv8G6Q8/Mb
         IIpw==
X-Gm-Message-State: AOAM533hvkNlmUNriKzuq/NPu2SlHsA1xlraTM4vamJE1y6oRJFRTR7J
        peqs0I+R8W/f+edIW8wpAQ33OxMTSYU=
X-Google-Smtp-Source: ABdhPJysi/QemswnOvlwmBX+VdVLw9Xg1SigpRarxG7fxAwRCV2cUswrZ/m+trtWu/kkApevLcjCgA==
X-Received: by 2002:a0c:c710:: with SMTP id w16mr9508506qvi.114.1639548283626;
        Tue, 14 Dec 2021 22:04:43 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y16sm17017qkj.69.2021.12.14.22.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 22:04:43 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     fbarrat@linux.ibm.com
Cc:     ajd@linux.ibm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH misc-next] drivers/misc: remove redundant rc variable
Date:   Wed, 15 Dec 2021 06:04:38 +0000
Message-Id: <20211215060438.441918-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value from ocxl_context_attach() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/misc/ocxl/file.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
index e70525eedaae..d881f5e40ad9 100644
--- a/drivers/misc/ocxl/file.c
+++ b/drivers/misc/ocxl/file.c
@@ -74,7 +74,6 @@ static long afu_ioctl_attach(struct ocxl_context *ctx,
 {
 	struct ocxl_ioctl_attach arg;
 	u64 amr = 0;
-	int rc;
 
 	pr_debug("%s for context %d\n", __func__, ctx->pasid);
 
@@ -86,8 +85,7 @@ static long afu_ioctl_attach(struct ocxl_context *ctx,
 		return -EINVAL;
 
 	amr = arg.amr & mfspr(SPRN_UAMOR);
-	rc = ocxl_context_attach(ctx, amr, current->mm);
-	return rc;
+	return ocxl_context_attach(ctx, amr, current->mm);
 }
 
 static long afu_ioctl_get_metadata(struct ocxl_context *ctx,
-- 
2.25.1

