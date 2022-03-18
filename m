Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E60C4DD7F9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbiCRKgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235004AbiCRKf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:35:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D5CDF3281
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647599679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EDf+Cue22NIq+++ettcFUZpGsy+wdzQQBWaXtBz9VhU=;
        b=gPcgEv8OHxrim7lrL/8J+Mug5yaSL35teVplXwedYFj/RpaOXlq3MHi/clJU+s/pxm745Q
        Q8atBqxgfbl4lhZeaF/mGHd59RrMSrD+UtrJ9F/HpP8TjdI/ZyWNAfIgx72YlpHbiI4ro4
        +o02VeaD043a+kWS2BmkeSk0kK47JaM=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-240-0mtlhistOFCYu4-Lvs7XCQ-1; Fri, 18 Mar 2022 06:34:38 -0400
X-MC-Unique: 0mtlhistOFCYu4-Lvs7XCQ-1
Received: by mail-pf1-f198.google.com with SMTP id w68-20020a62dd47000000b004f6aa5e4824so5094477pff.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EDf+Cue22NIq+++ettcFUZpGsy+wdzQQBWaXtBz9VhU=;
        b=sQEphs3T9Dw+3lk6qMeSjvl0ghWBK5Sfmj3VUrT2ABqITkFd67wVglq9U6kpr2BZD1
         OEiKG0pS/cCGYwYCwilEKj9kfhPQ8oeMogbbY/w2JZtJCZi/xMxtVnklZa4PM9WMY/4d
         TRabFoL35HDA/VZZHtxU6ykhQtFdIdjC6kjjGiu6sJzH0KqR+TXs2aBV6qtd+x/LugqK
         7BSzTbV0n1FFVIy6XIXrpWthf9+e/IEP9tIq5CgHxasg07eStjkaRyBTLoncZ9wCglCE
         KzhIvyVG+f7oo9rH5N6eaTaU8O8tWdGgJEhl+F5vHC4aA9BQiNDBv1mPjnXxdFiP71PD
         hieQ==
X-Gm-Message-State: AOAM532k6vYtFXPcdEhQjTLRdTECuqP6DVibyE3L0CwUPho3AT3ty4Y3
        WdrzbJOaK91+/eUYPibkhAUU7W6WTk4rzuojuDeA+DTSZP4EmPyUEedVR8c4XGwsSbP1+aUIVwa
        IPER7h4eskiPsquq/ZbWV8sXO
X-Received: by 2002:a17:902:db10:b0:151:ef9a:7e27 with SMTP id m16-20020a170902db1000b00151ef9a7e27mr9211897plx.39.1647599677355;
        Fri, 18 Mar 2022 03:34:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4eHzy4IQF50hT/ddKSZ0UY2J9cU8InbYVKChGw7aJVMkZmTYKHNSbfCTQcgf4H6bZpxJhpw==
X-Received: by 2002:a17:902:db10:b0:151:ef9a:7e27 with SMTP id m16-20020a170902db1000b00151ef9a7e27mr9211781plx.39.1647599675619;
        Fri, 18 Mar 2022 03:34:35 -0700 (PDT)
Received: from localhost ([240e:3a1:2e5:800:f995:6136:f760:a3d0])
        by smtp.gmail.com with ESMTPSA id pi10-20020a17090b1e4a00b001bf9749b95bsm12445631pjb.50.2022.03.18.03.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 03:34:34 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     Milan Broz <gmazyland@gmail.com>,
        Thomas Staudt <tstaudt@de.ibm.com>,
        Kairui Song <ryncsn@gmail.com>, dm-devel@redhat.com,
        Mike Snitzer <snitzer@redhat.com>, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: [RFC 2/4] kdump, x86: pass the LUKS master key to kdump kernel using a kernel command line parameter luksmasterkey
Date:   Fri, 18 Mar 2022 18:34:21 +0800
Message-Id: <20220318103423.286410-3-coxu@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220318103423.286410-1-coxu@redhat.com>
References: <20220318103423.286410-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kdump will build up the kernel command parameter luksmasterkey as
similar to elfcorehdr to pass the memory address of the stored info of LUKS
master key to kdump kernel.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/x86/include/asm/crash.h      |  1 +
 arch/x86/kernel/crash.c           | 42 ++++++++++++++++++++++++++++++-
 arch/x86/kernel/kexec-bzimage64.c |  7 ++++++
 include/linux/kexec.h             |  4 +++
 4 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/crash.h b/arch/x86/include/asm/crash.h
index 8b6bd63530dc..757374389296 100644
--- a/arch/x86/include/asm/crash.h
+++ b/arch/x86/include/asm/crash.h
@@ -4,6 +4,7 @@
 
 struct kimage;
 
+int crash_load_luks_key(struct kimage *image);
 int crash_load_segments(struct kimage *image);
 int crash_setup_memmap_entries(struct kimage *image,
 		struct boot_params *params);
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index e8326a8d1c5d..6d117da62da4 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -304,6 +304,7 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
 				 unsigned long long mend)
 {
 	unsigned long start, end;
+	int r;
 
 	cmem->ranges[0].start = mstart;
 	cmem->ranges[0].end = mend;
@@ -312,7 +313,19 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
 	/* Exclude elf header region */
 	start = image->elf_load_addr;
 	end = start + image->elf_headers_sz - 1;
-	return crash_exclude_mem_range(cmem, start, end);
+	r = crash_exclude_mem_range(cmem, start, end);
+
+	if (r)
+		return r;
+
+	/* Exclude LUKS master key region */
+	if (image->luks_master_key_addr) {
+		start = image->luks_master_key_addr;
+		end = start + image->luks_master_key_sz - 1;
+		return crash_exclude_mem_range(cmem, start, end);
+	}
+
+	return r;
 }
 
 /* Prepare memory map for crash dump kernel */
@@ -383,6 +396,33 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 	return ret;
 }
 
+int crash_load_luks_key(struct kimage *image)
+{
+	int ret;
+	struct kexec_buf kbuf = { .image = image, .buf_min = 0,
+				  .buf_max = ULONG_MAX, .top_down = false };
+
+	image->luks_master_key_addr = 0;
+	ret = kexec_pass_luks_master_key(&kbuf.buffer, &kbuf.bufsz);
+	if (ret)
+		return ret;
+
+	kbuf.memsz = kbuf.bufsz;
+	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
+	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+	ret = kexec_add_buffer(&kbuf);
+	if (ret) {
+		vfree((void *)kbuf.buffer);
+		return ret;
+	}
+	image->luks_master_key_addr = kbuf.mem;
+	image->luks_master_key_sz = kbuf.bufsz;
+	pr_debug("Loaded LUKS master key at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+		 image->luks_master_key_addr, kbuf.bufsz, kbuf.bufsz);
+
+	return ret;
+}
+
 int crash_load_segments(struct kimage *image)
 {
 	int ret;
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 170d0fd68b1f..64ea3b6a5768 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -76,6 +76,10 @@ static int setup_cmdline(struct kimage *image, struct boot_params *params,
 	if (image->type == KEXEC_TYPE_CRASH) {
 		len = sprintf(cmdline_ptr,
 			"elfcorehdr=0x%lx ", image->elf_load_addr);
+
+		if (image->luks_master_key_addr != 0)
+			len += sprintf(cmdline_ptr + len,
+					"luksmasterkey=0x%lx ", image->luks_master_key_addr);
 	}
 	memcpy(cmdline_ptr + len, cmdline, cmdline_len);
 	cmdline_len += len;
@@ -372,6 +376,9 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 		ret = crash_load_segments(image);
 		if (ret)
 			return ERR_PTR(ret);
+		ret = crash_load_luks_key(image);
+		if (ret)
+			pr_debug("Either no LUKS master key or error to retrieve the LUKS master key\n");
 	}
 
 	/*
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 91507bc684e2..456a5bc28518 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -316,6 +316,10 @@ struct kimage {
 	void *elf_headers;
 	unsigned long elf_headers_sz;
 	unsigned long elf_load_addr;
+
+	/* LUKS master key buffer */
+	unsigned long luks_master_key_addr;
+	unsigned long luks_master_key_sz;
 };
 
 /* kexec interface functions */
-- 
2.34.1

