Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B005A0D90
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241092AbiHYKMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240998AbiHYKMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:12:01 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47208A7A82
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:11:49 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id p13so6736883pld.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=5x32MEDCgaNmHcojCpTje6cvDrY80Yxg7sYtN2i0CQc=;
        b=Te/5IP11Lj2J2v23eu1UQFcoUwv4dykJGHh99WiFfsij/0Rki7IrrrZUo2uCyGFclm
         KhwIUXnn/hCKxxGZSDmvctNWutsnfG2jiFI6EDBMTtnQjsqUp8zty5btb0T2U1eMYaAw
         ZVGUNnbi1YLmhRT0hSrmnwApJbI2JEFFLm4Yz/v7Ft2oQvMGdrYASN7qLEC84irUpsWv
         2BDeF6FZ7a0sXvUOV84T7gAfIJ4GiTQhwC0IvEgp5Rl+atGvYh3T4qDETv2PIwGprzon
         T94RtbPTcLwAJjd733YMYjkH9R1j/Sboj7Ln2UWI1Ee7eUSezRk7pfGK6VaMatgi1JCf
         DWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=5x32MEDCgaNmHcojCpTje6cvDrY80Yxg7sYtN2i0CQc=;
        b=75yhL6T7QkdvwsIZOtm6CnhzgwSiVHDfCa+h3pdCdkOjZJN1X/cx6fvF2ZPkVDY3Zn
         upNVmsfmOYKhBfZ1Gl+RfRc6jIcojCTxbGLrwwdg0SFBK04f9+5nQs2qngqCTOEh+f9A
         9JSiATRgWQGFhZq0r8/bZTbumADmgwa2JtUG/GV7+ky7UFGvzK3kUfHAnXCxjLdfHR3R
         cap4Icp6zzorMav9kAZSrxT51Zf6Dca7Q0MSDm7HJ0247HL60k0OGAQgrTN+Ro/gvnjY
         k+HubSiJs0Be7N4R2S/+9MtWOz1n/5tG8GJ66am/iQpwp/HjLC18fyzciPEMuZrmLyUM
         8ebA==
X-Gm-Message-State: ACgBeo2+s02uUCmZvqBmxhry64f5K5cJ4rtm6ZBN3E2okGkU240JfeRB
        dTJIEEchBeiJ/vOjURkDRg6Ynw==
X-Google-Smtp-Source: AA6agR7hp40eC3wRY8MGPaoNXwGLwbdIDjNQybY0ITEEfTLXjmMgba4xFQhcMKQZ1dlMtlSOnHbvOg==
X-Received: by 2002:a17:902:d2c5:b0:172:8d5f:bf01 with SMTP id n5-20020a170902d2c500b001728d5fbf01mr3089264plc.119.1661422308812;
        Thu, 25 Aug 2022 03:11:48 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id b10-20020a170903228a00b001714c36a6e7sm8477581plh.284.2022.08.25.03.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 03:11:47 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@redhat.com,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        jgg@nvidia.com, tglx@linutronix.de, willy@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        muchun.song@linux.dev, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH 3/7] mm: add pte_to_page() helper
Date:   Thu, 25 Aug 2022 18:10:33 +0800
Message-Id: <20220825101037.96517-4-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220825101037.96517-1-zhengqi.arch@bytedance.com>
References: <20220825101037.96517-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pte_to_page() helper similar to pmd_to_page(), which
will be used to get the struct page of the PTE page table.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/pgtable.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 9745684b0cdb..c4a6bda6e965 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -86,6 +86,14 @@ static inline unsigned long pud_index(unsigned long address)
 #define pgd_index(a)  (((a) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
 #endif
 
+#ifdef CONFIG_FREE_USER_PTE
+static inline struct page *pte_to_page(pte_t *pte)
+{
+	unsigned long mask = ~(PTRS_PER_PTE * sizeof(pte_t) - 1);
+	return virt_to_page((void *)((unsigned long) pte & mask));
+}
+#endif
+
 #ifndef pte_offset_kernel
 static inline pte_t *pte_offset_kernel(pmd_t *pmd, unsigned long address)
 {
-- 
2.20.1

