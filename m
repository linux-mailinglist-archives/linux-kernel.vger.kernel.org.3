Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04EE514A9A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351569AbiD2NkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359809AbiD2NkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:40:02 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3799BCB018
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:36:41 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id cq17-20020a17090af99100b001dc0386cd8fso1902492pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VfzL8+rKvBDkdHAWJz+BdGeabJSdieMoCyrARJf31C8=;
        b=Dqjg2bggCbl33T/45lA7Ve3w9lBbtFVa1mXx8Ejbfs5Il/fK1BO/bf2J+ibvJhiS+Y
         l23GVOPL2ey3vEhQd+FUJsO23dOCMwlDnUhlsabAJNQ3g/BLU+l3S8kF5q8xLqzcTLa9
         N+2i4eoix1OJOltamNeXZ/RGg3nTxJmJ0nzjpfCx0serQBaJh+6ocZmzJ/QUqMKiG8zZ
         C7mOsKzMS1pHhUig4gWLkDlR56bIK6XpC/halFlOpppKGwDWVvjdEs/vIuYtRhDEisEk
         ZvmIPR0cAqycBsaDnGQH53owG2POMRJWUrpPJ9xjBwVSchPUFsRwPJYuD3dyOj2bgPPh
         wFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VfzL8+rKvBDkdHAWJz+BdGeabJSdieMoCyrARJf31C8=;
        b=tL/w34+FnF2wShsZWyEGHcY1FsaY1CkCymOkMR//wd+h8WqaEqbtuY4liVg1PBbjiS
         jfdwCbg/rFK0BmNCIWYdO9xow87khZiTUShWyU1attd1Gm77yjYTkhh25muu0NBsQL9z
         5jPGvXc762JmULqRqCzHZcEkyl50O5P6ajJRQWdgz3RH0gLlu94vcW9NPM1elp1HEvOU
         iIObH13LZy2jJ/4+spntcj9MfXoLqlPn5krjY2tWnivjRk+kFDXSUhFtDp+rh46F0rrD
         o9r3+NWoJLYv/dMW+rgMaFJgHO3rG9Y9SPxQXqGckIW3l91SDMVanyXiE5/V63YXMAdh
         raog==
X-Gm-Message-State: AOAM532zJYSK9+WjunmbR4y3KJ5wG+5QhfPrGxwl7vNO7wJVP0vVFip3
        DUsPWxMLGAXuTyhQ0ps8WVo3Sg==
X-Google-Smtp-Source: ABdhPJwdG27EhVPvJrwtYvxik6bbTXqrOGosOq9mejsaq+voyl0UgeehoOYZEA+LTuFQKgY2z1Cn4A==
X-Received: by 2002:a17:903:1051:b0:15c:f02f:cd0e with SMTP id f17-20020a170903105100b0015cf02fcd0emr31282057plc.81.1651239400770;
        Fri, 29 Apr 2022 06:36:40 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id m8-20020a17090a414800b001d81a30c437sm10681977pjg.50.2022.04.29.06.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 06:36:40 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, jgg@nvidia.com, tj@kernel.org, dennis@kernel.org,
        ming.lei@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH 04/18] mm: convert to use ptep_clear() in pte_clear_not_present_full()
Date:   Fri, 29 Apr 2022 21:35:38 +0800
Message-Id: <20220429133552.33768-5-zhengqi.arch@bytedance.com>
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

After commit 08d5b29eac7d ("mm: ptep_clear() page table helper"),
the ptep_clear() can be used to track the clearing of PTE page
table entries, but pte_clear_not_present_full() is not covered,
so also convert it to use ptep_clear(), we will need this call
in subsequent patches.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index f4f4077b97aa..bed9a559d45b 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -423,7 +423,7 @@ static inline void pte_clear_not_present_full(struct mm_struct *mm,
 					      pte_t *ptep,
 					      int full)
 {
-	pte_clear(mm, address, ptep);
+	ptep_clear(mm, address, ptep);
 }
 #endif
 
-- 
2.20.1

