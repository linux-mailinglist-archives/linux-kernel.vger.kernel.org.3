Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B38D5AA6A2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 05:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbiIBDs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 23:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbiIBDsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 23:48:40 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC494B2D80
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 20:48:19 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r22so881113pgm.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 20:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Jk44PJvjdjdt0bhfpwnVqhAy54lOcNkatPLUifUkm78=;
        b=3ABmY31NCtPUK9+d/tEAiUK1Sw5n0PbCBRGKhZIiWLQozhGHRFk5d1ZbZAv7HW0e94
         qj6LLPcP0RLVr3Lxe2Vg3yZyHRrsKEumnCGkXHpdDdgPZFb6O3BPlwrXgOWJwDitJ3H4
         PQ6EeKpWHEU8O3M50XZCT8yBKE9rzr2h/bzIoZW44Spga5UTqeCH2eMZcHTL3f6WhH4Q
         mAZKmwn6WtZgc3ftU8Dwlhpx9+72E4iXoZUd4QbrY4iXMJQJlAhyCOUkO8JMUYPQHqTJ
         eiOD3DVVkMWK3tI0AJ0q+sTjCRH/RM5yPgsZ0XlZiYoAyJNVLyd4Mb0QRmopGcau6G5F
         JJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Jk44PJvjdjdt0bhfpwnVqhAy54lOcNkatPLUifUkm78=;
        b=tU6gJ1rBUdSf/KfOCDByc6JxR1oT0dcfCOB9lbocVyPOXve4mNMXYbE/SnMUcjizkQ
         1fo0vCMOMiwLLEjAh8xmxSvfRPkjfGEt7H4HDxDYvnepel6wMY3FHvMeePKrzvuITfV4
         T/BVCjvRvKS8xtycYAUDO8btH7npgTZh0BbIchbhrRUV/F6f8T4Dv8K8/VFHcpWaOJDH
         e9eDqBnLCiAYbic4FSWbqKwm6Osljix0p9o1ETviW/mcATXSr78eNTTOS2YJ2mbHSx/1
         c0Gt4Y9ueH5t3pTUEZsDHIVi/qH44Av6pxtPcvuTxZQOR1tT5J2dEsKtKeot+0IeqN9/
         LENA==
X-Gm-Message-State: ACgBeo1Ocqm0t+i9La8V/LW85ixWCJ66j4GLoKujFLH4YcMPr+RHTQZ+
        JsuUnk/GeG28jHsHts1lHJlthw==
X-Google-Smtp-Source: AA6agR6H1cxQnoOXHM2ER5sKinUb9hmkg3InKS5W80qghzWeHrK3nt3kYIKXJVHuFnBwjRiKLdGdzg==
X-Received: by 2002:a65:620c:0:b0:431:25fe:277 with SMTP id d12-20020a65620c000000b0043125fe0277mr15252pgv.413.1662090499304;
        Thu, 01 Sep 2022 20:48:19 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902e88800b0016c4546fbf9sm376152plg.128.2022.09.01.20.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 20:48:19 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        huyue2@coolpad.com, Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V1 3/5] erofs: add 'domain_id' prefix when register sysfs
Date:   Fri,  2 Sep 2022 11:47:46 +0800
Message-Id: <20220902034748.60868-4-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220902034748.60868-1-zhujia.zj@bytedance.com>
References: <20220902034748.60868-1-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In shared domain mount procedure, add 'domain_id' prefix to register
sysfs entry. Thus we could distinguish mounts that don't use shared
domain.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/erofs/sysfs.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index c1383e508bbe..c0031d7bd817 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -201,12 +201,21 @@ static struct kobject erofs_feat = {
 int erofs_register_sysfs(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	char *name = NULL;
 	int err;
 
+	if (erofs_is_fscache_mode(sb)) {
+		name = kasprintf(GFP_KERNEL, "%s%s%s", sbi->opt.domain_id ?
+				sbi->opt.domain_id : "", sbi->opt.domain_id ? "," : "",
+				sbi->opt.fsid);
+		if (!name)
+			return -ENOMEM;
+	}
 	sbi->s_kobj.kset = &erofs_root;
 	init_completion(&sbi->s_kobj_unregister);
 	err = kobject_init_and_add(&sbi->s_kobj, &erofs_sb_ktype, NULL, "%s",
-			erofs_is_fscache_mode(sb) ? sbi->opt.fsid : sb->s_id);
+			name ? name : sb->s_id);
+	kfree(name);
 	if (err)
 		goto put_sb_kobj;
 	return 0;
-- 
2.20.1

