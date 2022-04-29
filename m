Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBAA514A9D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359832AbiD2Nka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359821AbiD2NkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:40:16 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8159CCB01A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:36:52 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso10556326pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mtrvfydE+wjlh8q+BDcMPZBC4jr9kvSALqoUY6wVrYg=;
        b=k8n9XhC/kWX+O8zBpqQG6cpY+9Tk08Geziwyjeu7tMaVC30yvyM7eOUm07SBr/4qEX
         xGqxG4TTH1PT6oqMgQaRTtltsursPhk1i+MdgOQ1+/JIIumQOzWrxXnaddl/A1Tn59BI
         cgiuxGNjxUI1TWVPKG3eDAjqjWUBdRQBpMufheg8/dbNPMOFvTm1MSRw1X4GaUzRJLAi
         68ZJScRb/+LlLB4Z4jQd070JkFSQskomWSs4klopW+l35QRFY/XgBDVCI8aVPLQramu0
         VklkPI8+1fbvC+YaQ6exBpg29zS3OdVQh36+iqKyd4OEuTm0Yh9T6sP0mw9P1ytkJmvV
         B+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mtrvfydE+wjlh8q+BDcMPZBC4jr9kvSALqoUY6wVrYg=;
        b=fmHmZdLrqnGoQqA9DjHp8QmfRUwwjguaHx1Cx9C25R3mBwgjhXa6TBa+TEJ9Age0RT
         9p6HiKhQ35EE+599O4fSOpPj4S1ITzvCNv/jQtay5Y18hp5iuK+BYhmt7o/QGfhtWfE+
         grX7NrW/Ji2epmOxgnXkKb/yE6mSodrUoqExDsGnaedOiLmPBpariIKT6lKLRT9tNDw/
         aOvkaMyPGWK7Or/N5DVUqEXsZ8E0bOOQ6CmQlR1ARSVABZq9Sb18oTbcUEr0kqcWqwxd
         4nOd/SjcsmSO7JvkQ00RmCD25mYU45mlcUMRKxG7uZ533MFhz3YjRqTXRg4CMfMOVWEb
         7ijQ==
X-Gm-Message-State: AOAM531DzLdHkRCSfO+Sq039Sdfy/lcFjwWM8fLDZBZL3V4UnUodgnCC
        OHY8TLnTPgh4Ma/sXCYLTx0yFg==
X-Google-Smtp-Source: ABdhPJxkwZhomXI1CyZvZSH/IPeC0YUXjZY29+uiw0fkUp1dwm5zxcysMSj/RCsHmgPONsDBh4zerQ==
X-Received: by 2002:a17:90b:1a8b:b0:1d9:971d:4269 with SMTP id ng11-20020a17090b1a8b00b001d9971d4269mr4032863pjb.65.1651239412204;
        Fri, 29 Apr 2022 06:36:52 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id m8-20020a17090a414800b001d81a30c437sm10681977pjg.50.2022.04.29.06.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 06:36:51 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, jgg@nvidia.com, tj@kernel.org, dennis@kernel.org,
        ming.lei@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH 06/18] mm: introduce CONFIG_FREE_USER_PTE
Date:   Fri, 29 Apr 2022 21:35:40 +0800
Message-Id: <20220429133552.33768-7-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220429133552.33768-1-zhengqi.arch@bytedance.com>
References: <20220429133552.33768-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This configuration variable will be used to build the code needed to
free user PTE page table pages.

The PTE page table setting and clearing functions(such as set_pte_at())
are in the architecture's files, and these functions will be hooked to
implement FREE_USER_PTE, so the architecture support is needed.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 034d87953600..af99ed626732 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -909,6 +909,16 @@ config ANON_VMA_NAME
 	  area from being merged with adjacent virtual memory areas due to the
 	  difference in their name.
 
+config ARCH_SUPPORTS_FREE_USER_PTE
+	def_bool n
+
+config FREE_USER_PTE
+	bool "Free user PTE page tables"
+	default y
+	depends on ARCH_SUPPORTS_FREE_USER_PTE && MMU && SMP
+	help
+	  Try to free user PTE page table page when its all entries are none.
+
 source "mm/damon/Kconfig"
 
 endmenu
-- 
2.20.1

