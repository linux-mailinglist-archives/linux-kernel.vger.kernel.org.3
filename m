Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1706A5A9BA7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbiIAP2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbiIAP2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:28:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4767549B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 08:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662046108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L8f4s5rqo1zwV3cO5t7nG7LhzQRJNI558jhBcTgE3u0=;
        b=T30M1WzxFpLQg55bDUl1vG9HgLZAteuJhJvSA5aoXFiCkVummT9NaACGVGJSKm0RAfgMVG
        a5E6agCteIIE1jsKc6MnW7Xh4MokSFbn3QPWWR1FACYYjpxBauJbqe5L0uH5Q/DH4l3eQ9
        CvZIIDUlzzQuIyOrf8H3kjQEwF4e69k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-377-FMWSnnjNOQm5dVDtoAt1bQ-1; Thu, 01 Sep 2022 11:25:45 -0400
X-MC-Unique: FMWSnnjNOQm5dVDtoAt1bQ-1
Received: by mail-wr1-f70.google.com with SMTP id j12-20020adfff8c000000b002265dcdfad7so3111655wrr.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 08:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=L8f4s5rqo1zwV3cO5t7nG7LhzQRJNI558jhBcTgE3u0=;
        b=VFDbQBLzoasaZxWYtKvLNn/ZAJkWh3wYlNYjQHDH1J7FrrUPGwyw/Gtm1ulDWFyeHT
         mEAMPTz1BnO8gaPITNnWaikOtyO2rlTiyBQIH0FJ+vilg24nldepQnyfoqaaXk92EdCQ
         KX9NOSFBRGZcrMUS4KjKqoGT8AA03O+xTawAP0G/r2KfqpKqkgMn3PnOv9tp/kSfE4bM
         ULWkNfOP+9iKFGujhDjkImEZCOAbuoZqakHLTxVxgtv7gLoofIvhK79vJGWJKEBkWMc9
         46/Wrl6K+qUGvayBKN5J8ccT56sEd9oIjcZmyE5T3MFI80D8Jwwih3KSUHh5rCHdAaxp
         +S6w==
X-Gm-Message-State: ACgBeo2xcXPKMfcS+W8kgAJObBNER5DG97veBnlTTcmmNKC47fVcnRcj
        nexoFRlNKGfJ4gU1ty2ZLmcJXbzYIFq28+noXCJvuib/T+UVXqe5tJC27hwX8w7OGSZD7g0LhVe
        uGcS9gSSoh/S2STJbw6Nw6cY=
X-Received: by 2002:a05:600c:40d5:b0:3a5:3d9f:6e7f with SMTP id m21-20020a05600c40d500b003a53d9f6e7fmr5534142wmh.21.1662045902190;
        Thu, 01 Sep 2022 08:25:02 -0700 (PDT)
X-Google-Smtp-Source: AA6agR52P3HlyK/lb9QikJKrVE3z2Tzfd31k/wfWxA+g+0yktZAJ4Y33BhiH/+VnAxRZ+FZJssSfTA==
X-Received: by 2002:a05:600c:40d5:b0:3a5:3d9f:6e7f with SMTP id m21-20020a05600c40d500b003a53d9f6e7fmr5534136wmh.21.1662045901983;
        Thu, 01 Sep 2022 08:25:01 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id o8-20020a05600c4fc800b003a54f1d007csm6005807wmq.10.2022.09.01.08.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 08:25:00 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     petr.pavlu@suse.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com
Subject: [PATCH v2 modules-next 1/1] module: Add debugfs interface to view unloaded tainted modules
Date:   Thu,  1 Sep 2022 16:24:54 +0100
Message-Id: <20220901152454.2394228-2-atomlin@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220901152454.2394228-1-atomlin@redhat.com>
References: <20220901152454.2394228-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides debug/modules/unloaded_tainted file to see a
record of unloaded tainted modules.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/tracking.c | 68 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/kernel/module/tracking.c b/kernel/module/tracking.c
index 7f8133044d09..a139e63b6f20 100644
--- a/kernel/module/tracking.c
+++ b/kernel/module/tracking.c
@@ -10,6 +10,7 @@
 #include <linux/printk.h>
 #include <linux/slab.h>
 #include <linux/list.h>
+#include <linux/debugfs.h>
 #include <linux/rculist.h>
 #include "internal.h"
 
@@ -59,3 +60,70 @@ void print_unloaded_tainted_modules(void)
 		}
 	}
 }
+
+#ifdef CONFIG_DEBUG_FS
+static void *unloaded_tainted_modules_seq_start(struct seq_file *m, loff_t *pos)
+	__acquires(rcu)
+{
+	rcu_read_lock();
+	return seq_list_start_rcu(&unloaded_tainted_modules, *pos);
+}
+
+static void *unloaded_tainted_modules_seq_next(struct seq_file *m, void *p, loff_t *pos)
+{
+	return seq_list_next_rcu(p, &unloaded_tainted_modules, pos);
+}
+
+static void unloaded_tainted_modules_seq_stop(struct seq_file *m, void *p)
+	__releases(rcu)
+{
+	rcu_read_unlock();
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
-- 
2.37.1

