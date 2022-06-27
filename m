Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABBC55D962
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239339AbiF0QlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 12:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbiF0QlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:41:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C50EB1AF15
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656348067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mmtu6sGZISHFbuV/9DFRuThUAmo/IEgFbvkJ55YDBQk=;
        b=CK1XhdA1PZ+aD03S5xxNV5j9dHHZAZuzE042lcr1bN6V4EgSpvbMbGZJrefUPLQybDUh4s
        ipbajYUTKSbU1Rpq6GG5uv4bk+EVhDzbdB1Xrf3FChnJ0n7gKAIQ19OhgzmOGEzIZZhqFt
        T9OEWIqusrHwB9+An0H4h0nUXyvnxwA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-acsONk69MXOyzyBc81GmDg-1; Mon, 27 Jun 2022 12:40:59 -0400
X-MC-Unique: acsONk69MXOyzyBc81GmDg-1
Received: by mail-wr1-f71.google.com with SMTP id t13-20020adfe10d000000b0021bae3def1eso1293873wrz.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mmtu6sGZISHFbuV/9DFRuThUAmo/IEgFbvkJ55YDBQk=;
        b=SRlJ2DWrDwKQhuiN+nXg9ZgzxRci9DXvijFOnPM8947obw57l2EtjBRCiQnbjTtAMd
         gcvMhKA6oPRjVrB/MBkZGEyTsC5/MDWYU2bhnBFKTsuIjqhJmjxMiCbm4kycX2QHyYWo
         ZN6d6NKZphWBiR7yThKRLAS3vLwUgSM3EBFYP00YP4arQgwBfJcRVp5DgItiu4DwtsdZ
         JRGdb0KbPQNNvMllKioa0hQ+RmLpLBsRGzASOK2Uba7xEZflZFhF+3Y0QNpsjaPA3O1I
         9woHDoMma6CObgzveD6kAH11fNHqT+u2F0LX0jYTMCeHaC/7rgIAtFw1S38KeVLz7a1V
         CVGQ==
X-Gm-Message-State: AJIora9o70UcFPBradTPw457XEnDJ6iMorbXTsvD8mgCeBL+h5SHDUes
        qn/QVhVggepmT2fSradYClfXQN7ztFD/ZooosbXisU0B4BX3BqlTbliWg75n5IlONDdMF2quu3E
        YGjMKQzJLBS6JPsCWd/B99Vw=
X-Received: by 2002:a05:600c:b46:b0:3a0:4a51:bb1d with SMTP id k6-20020a05600c0b4600b003a04a51bb1dmr6902205wmr.168.1656348056350;
        Mon, 27 Jun 2022 09:40:56 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uf1D9edbDGWlaOoBkfKKagim3AhPqi7BL5FVkNGElHCF/EiWHy1LGL+pVfZHkDgBe53dYR5A==
X-Received: by 2002:a05:600c:b46:b0:3a0:4a51:bb1d with SMTP id k6-20020a05600c0b4600b003a04a51bb1dmr6902190wmr.168.1656348056151;
        Mon, 27 Jun 2022 09:40:56 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id d18-20020adfe852000000b0021ba3d1f2a0sm10803679wrn.48.2022.06.27.09.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 09:40:55 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] module: Show the last unloaded module's taint flag(s)
Date:   Mon, 27 Jun 2022 17:40:52 +0100
Message-Id: <20220627164052.2416485-2-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220627164052.2416485-1-atomlin@redhat.com>
References: <20220627164052.2416485-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For diagnostic purposes, this patch, in addition to keeping a record/or
track of the last known unloaded module, we now will include the
module's taint flag(s) too e.g: " [last unloaded: fpga_mgr_mod(OE)]"

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index dcb83cf18d84..0ca6fd38b903 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -524,7 +524,12 @@ static struct module_attribute modinfo_##field = {                    \
 MODINFO_ATTR(version);
 MODINFO_ATTR(srcversion);
 
-static char last_unloaded_module[MODULE_NAME_LEN+1];
+/*
+ * Maximum number of characters written by module_flags()
+ * without a module's state information.
+ */
+#define LAST_UNLOADED_MODULE_NAME_LEN (MODULE_NAME_LEN + MODULE_FLAGS_BUF_SIZE - 2 + 1)
+static char last_unloaded_module[LAST_UNLOADED_MODULE_NAME_LEN];
 
 #ifdef CONFIG_MODULE_UNLOAD
 
@@ -694,6 +699,7 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
 {
 	struct module *mod;
 	char name[MODULE_NAME_LEN];
+	char buf[LAST_UNLOADED_MODULE_NAME_LEN];
 	int ret, forced = 0;
 
 	if (!capable(CAP_SYS_MODULE) || modules_disabled)
@@ -753,8 +759,8 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
 
 	async_synchronize_full();
 
-	/* Store the name of the last unloaded module for diagnostic purposes */
 	strlcpy(last_unloaded_module, mod->name, sizeof(last_unloaded_module));
+	strcat(last_unloaded_module, module_flags(mod, buf, false));
 
 	free_module(mod);
 	/* someone could wait for the module in add_unformed_module() */
-- 
2.34.3

