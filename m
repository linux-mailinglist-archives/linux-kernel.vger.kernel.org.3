Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561174DD7F7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbiCRKgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbiCRKgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:36:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B63021BC64
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647599682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kuGSMiWQ1weBzk6gT/GPrRoo3pCEcdrOBhI/gZQe7L8=;
        b=aBlHR0iPLv30lGiDm/Lr7Z2pBuASxmkH+fyZ3MibHvdJHiXmpfvH3BH0NsnwkdRGwdFFua
        9/M4z27eJTAqOPwCjM6WTOwt7I7ZJPmyLhxtSkbKcfXbl9Da+nOC95TXqT4/6WNGyvdvzV
        ko1q9flpBCVnK6RNixC1Gbmn0XY2G2A=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-kgNEwdFUOXyci25eOBvY6A-1; Fri, 18 Mar 2022 06:34:41 -0400
X-MC-Unique: kgNEwdFUOXyci25eOBvY6A-1
Received: by mail-pj1-f72.google.com with SMTP id gk23-20020a17090b119700b001c65a1baa01so4447804pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kuGSMiWQ1weBzk6gT/GPrRoo3pCEcdrOBhI/gZQe7L8=;
        b=xCRQPNKX2Om30o8q2odr3osnQerEphK1wVu54+rERdptJy8Pk1OD9ehW5SllZUtQ8A
         a2w/FfVrlZdBIRK8Ziix/k/kTr5cOd0IjeKjjV+LuBWWD4SEz0qaXPtygKluOXPbRv0z
         wuUsIkk0cTo/QLmF/S6Axz/j5cMw4rXrU4c30W2xlW3wOtVJIY20X/dtO78NwXUvvk64
         0DZXIeezlE/Xa49ZwWJ5nBF4B3ersHPKsDsWhFVHZAEBWnXtwHIBFUf/pCt2Qq2aWJSa
         vvixPxeqFsEr0jvZOIcpnL8Hr1hetidiH06LJiuiElnVQsUE6pXBxKTdKTkJ8N4frVRE
         dr6Q==
X-Gm-Message-State: AOAM533Yxr2tUB3//DL3r/5z+lspy1qH8IBOvGNFc63eFy7LjIBLjy+3
        65fZH4NsE1yDMieN1z8oUIKQZm3/Kj6Cyl3GlclwctxlhSsfaxD4y3/Dxnlmj9ucwjxEFEJ1TcB
        4E99ycrj/JG0pbHvBU8XeHGQt
X-Received: by 2002:a63:4560:0:b0:370:1f21:36b8 with SMTP id u32-20020a634560000000b003701f2136b8mr7182299pgk.181.1647599679836;
        Fri, 18 Mar 2022 03:34:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhyV5GISqvWydR24KI3Wp7EU8nU5i/FqatRN/HUbpQQsjZ2tGrMtTSM/bkqPiyk99D7Hj1wA==
X-Received: by 2002:a63:4560:0:b0:370:1f21:36b8 with SMTP id u32-20020a634560000000b003701f2136b8mr7182281pgk.181.1647599679569;
        Fri, 18 Mar 2022 03:34:39 -0700 (PDT)
Received: from localhost ([240e:3a1:2e5:800:f995:6136:f760:a3d0])
        by smtp.gmail.com with ESMTPSA id p125-20020a622983000000b004f6c5d58225sm9146730pfp.90.2022.03.18.03.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 03:34:39 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     Milan Broz <gmazyland@gmail.com>,
        Thomas Staudt <tstaudt@de.ibm.com>,
        Kairui Song <ryncsn@gmail.com>, dm-devel@redhat.com,
        Mike Snitzer <snitzer@redhat.com>, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
        Vivek Goyal <vgoyal@redhat.com>
Subject: [RFC 3/4] crash_dump: retrieve LUKS master key in kdump kernel
Date:   Fri, 18 Mar 2022 18:34:22 +0800
Message-Id: <20220318103423.286410-4-coxu@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220318103423.286410-1-coxu@redhat.com>
References: <20220318103423.286410-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kdump will retrieve the LUKS master key based on the luksmasterkey
command line parameter.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/crash_dump.h |  4 +++
 kernel/crash_dump.c        | 69 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 620821549b23..24acb84b716e 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -15,6 +15,8 @@
 extern unsigned long long elfcorehdr_addr;
 extern unsigned long long elfcorehdr_size;
 
+extern unsigned long long luks_master_key_addr;
+
 #ifdef CONFIG_CRASH_DUMP
 extern int elfcorehdr_alloc(unsigned long long *addr, unsigned long long *size);
 extern void elfcorehdr_free(unsigned long long addr);
@@ -32,6 +34,8 @@ extern ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf,
 
 void vmcore_cleanup(void);
 
+int retrive_kdump_luks_master_key(u8 *buffer, unsigned int *sz);
+
 /* Architecture code defines this if there are other possible ELF
  * machine types, e.g. on bi-arch capable hardware. */
 #ifndef vmcore_elf_check_arch_cross
diff --git a/kernel/crash_dump.c b/kernel/crash_dump.c
index 92da32275af5..ee32de300b9e 100644
--- a/kernel/crash_dump.c
+++ b/kernel/crash_dump.c
@@ -15,6 +15,8 @@
 unsigned long long elfcorehdr_addr = ELFCORE_ADDR_MAX;
 EXPORT_SYMBOL_GPL(elfcorehdr_addr);
 
+unsigned long long luks_master_key_addr;
+EXPORT_SYMBOL_GPL(luks_master_key_addr);
 /*
  * stores the size of elf header of crash image
  */
@@ -39,3 +41,70 @@ static int __init setup_elfcorehdr(char *arg)
 	return end > arg ? 0 : -EINVAL;
 }
 early_param("elfcorehdr", setup_elfcorehdr);
+
+static int __init setup_luksmasterkey(char *arg)
+{
+	char *end;
+
+	if (!arg)
+		return -EINVAL;
+	luks_master_key_addr = memparse(arg, &end);
+	if (end > arg)
+		return 0;
+
+	luks_master_key_addr = 0;
+	return -EINVAL;
+}
+
+early_param("luksmasterkey", setup_luksmasterkey);
+
+/*
+ * Architectures may override this function to read LUKS master key
+ */
+ssize_t __weak luks_key_read(char *buf, size_t count, u64 *ppos)
+{
+	return read_from_oldmem(buf, count, ppos, 0, false);
+}
+
+int retrive_kdump_luks_master_key(u8 *buffer, unsigned int *sz)
+{
+	unsigned int key_size;
+	size_t lukskeybuf_sz;
+	unsigned int *size_ptr;
+	char *lukskeybuf;
+	u64 addr;
+	int r;
+
+	if (luks_master_key_addr == 0) {
+		pr_debug("LUKS master key memory address inaccessible");
+		return -EINVAL;
+	}
+
+	addr = luks_master_key_addr;
+
+	/* Read LUKS master key size */
+	r = luks_key_read((char *)&key_size, sizeof(unsigned int), &addr);
+
+	if (r < 0)
+		return r;
+
+	pr_debug("Retrieve LUKS master key: size=%u\n", key_size);
+	/* Read in LUKS maste rkey */
+	lukskeybuf_sz = sizeof(unsigned int) + key_size * sizeof(u8);
+	lukskeybuf = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
+					      get_order(lukskeybuf_sz));
+	if (!lukskeybuf)
+		return -ENOMEM;
+
+	addr = luks_master_key_addr;
+	r = luks_key_read((char *)lukskeybuf, lukskeybuf_sz, &addr);
+
+	if (r < 0)
+		return r;
+	size_ptr = (unsigned int *)lukskeybuf;
+	memcpy(buffer, size_ptr + 1, key_size * sizeof(u8));
+	pr_debug("Retrieve LUKS master key (size=%u): %48ph...\n", key_size, buffer);
+	*sz = key_size;
+	return 0;
+}
+EXPORT_SYMBOL(retrive_kdump_luks_master_key);
-- 
2.34.1

