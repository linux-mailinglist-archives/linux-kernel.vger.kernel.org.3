Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B7B4DD7F6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbiCRKgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbiCRKfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:35:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D82EB255A0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647599675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PODFzb3mjImlWQPxxoECM7lRSKqdrL/May27LmTIUmk=;
        b=TnppTak9YM95yoJsPt9n0JEIKOasxvJ7jqw00wNvZIm7qs4iXLE9oobtGnUQZH0SHxo2tG
        iQr7CYfHVOceekEbshaO4S6izRZKycCn/A6z10+6T3ZCTPjkVUW2rmyuzCYJVCgZg96+bX
        cHDe1NP+E+H/PCl1QbLiwxIhW8Zn8UM=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-227-Aq4d69K9MqirLeG7oJgbhw-1; Fri, 18 Mar 2022 06:34:33 -0400
X-MC-Unique: Aq4d69K9MqirLeG7oJgbhw-1
Received: by mail-pf1-f197.google.com with SMTP id s3-20020aa78bc3000000b004fa59ef2a34so2143351pfd.19
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PODFzb3mjImlWQPxxoECM7lRSKqdrL/May27LmTIUmk=;
        b=hp3PWRXK58OLg1GifACZJKCCc3AC9IB8WMMVHfUaLtnJgmvhw/yElFoqdzclmzIKL3
         wrhVNomCpbs0AalVp3RfMjM47zpdT3L4c9NvSu4Ii7OBSmuvtaSowZTdKSszaVxI+/l7
         wmCdXixz4hw9bOx4uc0XKdac+34aPoOFSdewgLvfJbYrrFLAWqDFu6IqqUJd25acP0cU
         M3NyZmbySoq8caTJbGKd9AJE/W+yyKqu3ia3nkK2UO8qtxFIqKBpVkGx6lzQLq8rfmWA
         qFmZvp2plTKOzAxRKvSxuRLHU5CwiPc71Da/xf6+PyZVnEu6A6cfWPIDKXEsDpnUHcYN
         UljQ==
X-Gm-Message-State: AOAM5311ghNTzbQVan8eUX7j5G12SAOoUFnpYHmx1ZBpfQpKN6KEy1Z+
        Ie9Lz8y3ZICoz0YRqoy2IgDYd8NtDS+qcluHo5ApnpkQPgf/6m8Wx2ZisCLMbAOEvdBNxYC/22F
        yCpVGlZUuw7xXD3FBovXHfR4w
X-Received: by 2002:a05:6a00:1152:b0:4be:ab79:fcfa with SMTP id b18-20020a056a00115200b004beab79fcfamr9598492pfm.3.1647599671395;
        Fri, 18 Mar 2022 03:34:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVqCTYHmMvd/+g0VOR29gw2GmqZvnV0UPmluByeNafGkhNa+o3V1s2U3kyohRsqW5FHTDTeA==
X-Received: by 2002:a05:6a00:1152:b0:4be:ab79:fcfa with SMTP id b18-20020a056a00115200b004beab79fcfamr9598457pfm.3.1647599671120;
        Fri, 18 Mar 2022 03:34:31 -0700 (PDT)
Received: from localhost ([240e:3a1:2e5:800:f995:6136:f760:a3d0])
        by smtp.gmail.com with ESMTPSA id s20-20020a056a00179400b004f709998d13sm9657970pfg.10.2022.03.18.03.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 03:34:30 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     Milan Broz <gmazyland@gmail.com>,
        Thomas Staudt <tstaudt@de.ibm.com>,
        Kairui Song <ryncsn@gmail.com>, dm-devel@redhat.com,
        Mike Snitzer <snitzer@redhat.com>, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
        Alasdair Kergon <agk@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: [RFC 1/4] kexec, dm-crypt: receive LUKS master key from dm-crypt and pass it to kdump
Date:   Fri, 18 Mar 2022 18:34:20 +0800
Message-Id: <20220318103423.286410-2-coxu@redhat.com>
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

After receiving the LUKS master key from driver/md/dm-crypt, kdump has 1
hour at maximum to ask kexec to pass the key before the key gets wiped by
kexec. And after kdump retrieves the key, the key will be wiped
immediately.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 drivers/md/dm-crypt.c |  5 +++-
 include/linux/kexec.h |  3 ++
 kernel/kexec_core.c   | 66 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index d4ae31558826..41f9ca377312 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -41,6 +41,7 @@
 #include <keys/trusted-type.h>
 
 #include <linux/device-mapper.h>
+#include <linux/kexec.h>
 
 #include "dm-audit.h"
 
@@ -2388,6 +2389,8 @@ static int crypt_setkey(struct crypt_config *cc)
 	unsigned subkey_size;
 	int err = 0, i, r;
 
+	/* save master key to kexec */
+	kexec_save_luks_master_key(cc->key, cc->key_size);
 	/* Ignore extra keys (which are used for IV etc) */
 	subkey_size = crypt_subkey_size(cc);
 
@@ -3580,6 +3583,7 @@ static int crypt_message(struct dm_target *ti, unsigned argc, char **argv,
 			DMWARN("not suspended during key manipulation.");
 			return -EINVAL;
 		}
+
 		if (argc == 3 && !strcasecmp(argv[1], "set")) {
 			/* The key size may not be changed. */
 			key_size = get_key_size(&argv[2]);
@@ -3587,7 +3591,6 @@ static int crypt_message(struct dm_target *ti, unsigned argc, char **argv,
 				memset(argv[2], '0', strlen(argv[2]));
 				return -EINVAL;
 			}
-
 			ret = crypt_set_key(cc, argv[2]);
 			if (ret)
 				return ret;
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 0c994ae37729..91507bc684e2 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -205,6 +205,9 @@ int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
 extern int kexec_add_buffer(struct kexec_buf *kbuf);
 int kexec_locate_mem_hole(struct kexec_buf *kbuf);
 
+extern int kexec_pass_luks_master_key(void **addr, unsigned long *sz);
+extern int kexec_save_luks_master_key(u8 *key, unsigned int key_size);
+
 /* Alignment required for elf header segment */
 #define ELF_CORE_HEADER_ALIGN   4096
 
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 68480f731192..86df36b71443 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1218,3 +1218,69 @@ void __weak arch_kexec_protect_crashkres(void)
 
 void __weak arch_kexec_unprotect_crashkres(void)
 {}
+
+
+static u8 *luks_master_key;
+static unsigned int luks_master_key_size;
+
+void wipe_luks_master_key(void)
+{
+	if (luks_master_key) {
+		memset(luks_master_key, 0, luks_master_key_size * sizeof(u8));
+		kfree(luks_master_key);
+		luks_master_key = NULL;
+	}
+}
+
+static void _wipe_luks_master_key(struct work_struct *dummy)
+{
+	wipe_luks_master_key();
+}
+
+static DECLARE_DELAYED_WORK(wipe_luks_master_key_work, _wipe_luks_master_key);
+
+static unsigned __read_mostly wipe_key_delay = 3600; /* 1 hour */
+
+int kexec_save_luks_master_key(u8 *key, unsigned int key_size)
+{
+	if (luks_master_key) {
+		memset(luks_master_key, 0, luks_master_key_size * sizeof(u8));
+		kfree(luks_master_key);
+	}
+
+	luks_master_key = kmalloc(key_size * sizeof(u8), GFP_KERNEL);
+
+	if (!luks_master_key)
+		return -ENOMEM;
+	memcpy(luks_master_key, key, key_size * sizeof(u8));
+	luks_master_key_size = key_size;
+	pr_debug("LUKS master key (size=%u): %64ph\n", key_size, luks_master_key);
+	schedule_delayed_work(&wipe_luks_master_key_work,
+			      round_jiffies_relative(wipe_key_delay * HZ));
+	return 0;
+}
+EXPORT_SYMBOL(kexec_save_luks_master_key);
+
+int kexec_pass_luks_master_key(void **addr, unsigned long *sz)
+{
+	unsigned long luks_key_sz;
+	unsigned char *buf;
+	unsigned int *size_ptr;
+
+	if (!luks_master_key)
+		return -EINVAL;
+
+	luks_key_sz = sizeof(unsigned int) + luks_master_key_size * sizeof(u8);
+
+	buf = vzalloc(luks_key_sz);
+	if (!buf)
+		return -ENOMEM;
+
+	size_ptr = (unsigned int *)buf;
+	memcpy(size_ptr, &luks_master_key_size, sizeof(unsigned int));
+	memcpy(size_ptr + 1, luks_master_key, luks_master_key_size * sizeof(u8));
+	*addr = buf;
+	*sz = luks_key_sz;
+	wipe_luks_master_key();
+	return 0;
+}
-- 
2.34.1

