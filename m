Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CD859ED32
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 22:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiHWUMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 16:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiHWUMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 16:12:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAA6A1A5D
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 12:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661283156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=H+uuhl1NN5QAxVTi9BhvP08GGdmaB2im78PYqW4VJEw=;
        b=g73jjnCRYW9OPCeITfXxKAxiExbo4HukFtdBb3B5MFJU5rE3PuF0bm3fewVr1CVUnAKzHu
        S5guLp0K4GklVVsk8pWqX7OyO9dSSesLmslXoPdHeIeIaizDR7pa1VU8bV+Tc/7uAXthW6
        mdSHp7IlViPWyUX+Gi560mV8EvPIIyA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-656-TKBR8D5JOBmEfNHWaDeX0g-1; Tue, 23 Aug 2022 15:32:29 -0400
X-MC-Unique: TKBR8D5JOBmEfNHWaDeX0g-1
Received: by mail-wr1-f72.google.com with SMTP id k20-20020adfb354000000b0022556a0b8cbso1222122wrd.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 12:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=H+uuhl1NN5QAxVTi9BhvP08GGdmaB2im78PYqW4VJEw=;
        b=rek40fL/MGKh0zEG9+pnMMH/Jc215ZRO6HsfzF3IDfabiSm8NMKVKtuH+KIgfhV5e3
         TwFS3TQlBNsyTYRtBIrbdmfupByHUWAdZ4XU6NXun4K1HKUVVQbYXVmR9EuG8y3Q8JWt
         9wMTKblb5yKXKaiJ9icLDfrU85YYHmr3LwSUQr1GPLxJi6iCEhqV7VzZmntrWKeUrwfq
         bAV1pOIMjZ1J0viomj/Glr31bUKv03Yl56XFvUwH+FylacP8NPGZgsYqOLvLhgUMJQWc
         zlfNc/uvZkPVS7z0dd+8RnKv0x7G4l5e6ImOv6G5eI5Yh6eAWMSdTaVYYVEntKZMJkzE
         cbjw==
X-Gm-Message-State: ACgBeo0If7Mq/BbORfWi/F6nplEd7TCzUvuQWOkvfl9OLlsSqU7RAXMR
        x5ba35tAtNoMIMLeFjMSdkTrleSxlRLxufhXOkW+Dw0eur7njb764SJmqaLg9z4eXwENcOhCUi4
        QXyEnAGWukKmCd5K3LT0em+I=
X-Received: by 2002:a05:600c:3514:b0:3a5:dc71:d9c4 with SMTP id h20-20020a05600c351400b003a5dc71d9c4mr3164884wmq.42.1661283147972;
        Tue, 23 Aug 2022 12:32:27 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6vhXh7wc08Je7KJIA0KF0gMVDREzyVEI+mbql4xGLu+MnUDvZwRlIZchn/+sMZztXegMEpMg==
X-Received: by 2002:a05:600c:3514:b0:3a5:dc71:d9c4 with SMTP id h20-20020a05600c351400b003a5dc71d9c4mr3164879wmq.42.1661283147767;
        Tue, 23 Aug 2022 12:32:27 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c1d9000b003a5fcae64d4sm19528005wms.29.2022.08.23.12.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 12:32:26 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, atomlin@atomlin.com
Subject: [PATCH modules-next] module: Add debugfs interface to view unloaded tainted modules
Date:   Tue, 23 Aug 2022 20:32:25 +0100
Message-Id: <20220823193225.2072649-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides debug/modules/unloaded_tainted file to see
a record of unloaded tainted modules.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/tracking.c | 66 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/kernel/module/tracking.c b/kernel/module/tracking.c
index 7f8133044d09..015e641bc346 100644
--- a/kernel/module/tracking.c
+++ b/kernel/module/tracking.c
@@ -10,6 +10,7 @@
 #include <linux/printk.h>
 #include <linux/slab.h>
 #include <linux/list.h>
+#include <linux/debugfs.h>
 #include <linux/rculist.h>
 #include "internal.h"
 
@@ -59,3 +60,68 @@ void print_unloaded_tainted_modules(void)
 		}
 	}
 }
+
+#ifdef CONFIG_DEBUG_FS
+static void *unloaded_tainted_modules_seq_start(struct seq_file *m, loff_t *pos)
+{
+	mutex_lock(&module_mutex);
+	return seq_list_start_rcu(&unloaded_tainted_modules, *pos);
+}
+
+static void *unloaded_tainted_modules_seq_next(struct seq_file *m, void *p, loff_t *pos)
+{
+	return seq_list_next_rcu(p, &unloaded_tainted_modules, pos);
+}
+
+static void unloaded_tainted_modules_seq_stop(struct seq_file *m, void *p)
+{
+	mutex_unlock(&module_mutex);
+}
+
+static int unloaded_tainted_modules_seq_show(struct seq_file *m, void *p)
+{
+	struct mod_unload_taint *mod_taint;
+	char buf[MODULE_FLAGS_BUF_SIZE];
+	size_t l;
+
+	mod_taint = list_entry(p, struct mod_unload_taint, list);
+	l = module_flags_taint(mod_taint->taints, buf);
+	buf[l++] = '\0';
+
+	seq_printf(m, "%s (%s) %llu", mod_taint->name, buf, mod_taint->count);
+	seq_puts(m, "\n");
+
+	return 0;
+}
+
+static const struct seq_operations unloaded_tainted_modules_seq_ops = {
+	.start = unloaded_tainted_modules_seq_start,
+	.next  = unloaded_tainted_modules_seq_next,
+	.stop  = unloaded_tainted_modules_seq_stop,
+	.show  = unloaded_tainted_modules_seq_show,
+};
+
+static int unloaded_tainted_modules_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &unloaded_tainted_modules_seq_ops);
+}
+
+static const struct file_operations unloaded_tainted_modules_fops = {
+	.open = unloaded_tainted_modules_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static int __init unloaded_tainted_modules_init(void)
+{
+	struct dentry *dir;
+
+	dir = debugfs_create_dir("modules", NULL);
+	debugfs_create_file("unloaded_tainted", 0444, dir, NULL,
+			    &unloaded_tainted_modules_fops);
+
+	return 0;
+}
+module_init(unloaded_tainted_modules_init);
+#endif /* CONFIG_DEBUG_FS */

base-commit: 554694ba120b87e39cf732ed632e6a0c52fafb7c
-- 
2.37.1

