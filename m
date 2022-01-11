Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB62A48AB62
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 11:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348876AbiAKK32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 05:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236960AbiAKK30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 05:29:26 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00CDC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 02:29:25 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id s1so32059765wra.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 02:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OT2ScgAHFZvFT9FK0xgI4roqBQX72wkwsPKNNrCL1mE=;
        b=Sl1kCLBtavBFmZkLlGQA2unqA1WjEwN+5kgHuphnPLsQPTT32sjcnIu9w3medLtNP1
         xkW6HJ9jFmcXNigXAG53jVjy5TdTzV51muyVQEjSvhKa/96tTwimsKo5CPOXPUMIhOs2
         dltdKgxRiiDn6KPBsOgba1i77Jx5TtWE2ReK09dajsbPn82yYKtBdWotvmJMF3ckq8YB
         AQZTMH3VAByY3Zh5rZ96bg1DCLhglk+kr06V2nu/ZdNoWBRi6jQAnW6O5C8JWB/mRnJm
         K6ocsEcTAXfEQuIrqss7fEsUITDhMW1sVhcXraX9uPYrQFxIxwx8LaleMDlP/4g4a5X1
         APuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OT2ScgAHFZvFT9FK0xgI4roqBQX72wkwsPKNNrCL1mE=;
        b=g3nEVb4ZGVdHUtUpeM0M/C5/wvBRUyw1JMBXBkeqlumhQbtdhMdgETfssRcdmukLtf
         jiM1j1ZCnT0cy4smjfGu/mKdS3Cz3T3tkAolRydbmM+IgxpV4d1lv54o9EqpuYMlY5C9
         k3aeN5rnpWENYBJKnuMuXSgkfWeaqt+WBTryODLBfgD8m8V24tfOHp6ESvWGimjhiqAr
         CcneF/cP48hpdyw+nF06i1yjEUyodfbefm2upFVPca92b2YGLzkvrfaOjnuPFKZ04Yzr
         oLrz3lp7nXErq/732tsFHWY1351vIb1+nVFP/04myhjdqQxxDSq6G9Z+raxlYK3AU/8e
         pi2A==
X-Gm-Message-State: AOAM5326SQN9sxld9zqLHsaEaOeuTF8WkFQVLa3ejBT69/rEzZMHoWoi
        RI3koHikPXQ7QzbFPXpCv6gY7R9X7tQ=
X-Google-Smtp-Source: ABdhPJzWvOgTMnu2BMP+Br7/QmKsrfqpp32RVS2Onj6KiBwrz14yAEvHltQZls1CU5HavNeqyZQDbQ==
X-Received: by 2002:a5d:4d50:: with SMTP id a16mr1605630wru.264.1641896964154;
        Tue, 11 Jan 2022 02:29:24 -0800 (PST)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:fdaa:e573:6067:6ef5])
        by smtp.gmail.com with ESMTPSA id r11sm9739748wrz.78.2022.01.11.02.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 02:29:23 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org, rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH] memblock: Remove #ifdef __KERNEL__ from memblock.h
Date:   Tue, 11 Jan 2022 10:28:47 +0000
Message-Id: <20220111102847.673746-1-karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memblock.h is not a uAPI header, so __KERNEL__ guard can be deleted

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 include/linux/memblock.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 9dc7cb239d21..50ad19662a32 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -1,7 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 #ifndef _LINUX_MEMBLOCK_H
 #define _LINUX_MEMBLOCK_H
-#ifdef __KERNEL__
 
 /*
  * Logical memory blocks.
@@ -605,6 +604,5 @@ static inline void early_memtest(phys_addr_t start, phys_addr_t end)
 }
 #endif
 
-#endif /* __KERNEL__ */
 
 #endif /* _LINUX_MEMBLOCK_H */
-- 
2.30.2

