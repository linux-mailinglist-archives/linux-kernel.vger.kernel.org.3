Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EC45A66C4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 17:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiH3PBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 11:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiH3PBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:01:05 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDA6AA3EF;
        Tue, 30 Aug 2022 08:01:04 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q63so10905397pga.9;
        Tue, 30 Aug 2022 08:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=f9e3VM+myeBrA9VERSeK8dF/6d15WanDkkJ9Z+qhWxo=;
        b=Ce/ACRzrYvuTrrXwtDRWHUTtR2jjGTTWzwVQMgKKGXfUqm8XwOOnfqGO4kReIQj4EA
         YxJiRG6zHihUuGjGTKNJukfWCNB4hpetA5g4m957bxL8zdl+3TAZgWXtxdMHpIOVkk4d
         qkacsB9GuROoCuGo25QDaK7aBS6HHbNsTCa1OEUU55V8+6I3jLeCr5mcHO1G148bq+k7
         FuoY5U1qJ4qLtxHZbA4gX4J18QwOM932gYugiOlDQF4K0iUIqmquiocFefqlCTLKNuFW
         3ixkhwfqFeUmWHbggmd5gBVlmxWPbWA147NlwlENsE4l39egd+ST2ACtHfzsN5SDN7lC
         9Kdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=f9e3VM+myeBrA9VERSeK8dF/6d15WanDkkJ9Z+qhWxo=;
        b=8KW11CS9oIKwYcx/P5Hd2EHHhYfW1f+JveQ7mA5OjfxPe3ORTknRtUwpkkqvg5LWOl
         dfVeE7kjGWgB6jD40D3+gO+JXWAI1vo19YXGHEUyQRAAzEale1VCuFBsw8qm+Qp5tfqR
         bgGnh2uvxQqfAmw5sJJJPfQl7CiXsPpIxSuXZTdmQV/CM84glQ4tn0lnXgLJY/OzDhNY
         E0b73dMg2D0LNBFU6Zpr3TB+LtFljcMQnvtfkuXgL+O/8I/ksDB1DTu+4/wKDPmuJfGP
         FIWH7MVCs9ZaoL5yKxlRtKS7OMeVK2xfkWKGL9AUjSD86bvWKqmNJZaT2PbcMI9cjKDQ
         +qAQ==
X-Gm-Message-State: ACgBeo2qLioytK/merwq/5+vaWYdy1Cp7zAOgFkHSnoQtfIl7Mq4yvwF
        BAZo/FvS0m7WBbtDsxtgh+PgEWkXN0Q=
X-Google-Smtp-Source: AA6agR7ehrSDW0aq4+tSEiikLUvX+ymaQgCBf1Ht/gduHvIttTNLSEPoKEezKnCAXxg4FMZZv288yA==
X-Received: by 2002:a65:6d0b:0:b0:42a:19dc:e76e with SMTP id bf11-20020a656d0b000000b0042a19dce76emr18085356pgb.6.1661871663722;
        Tue, 30 Aug 2022 08:01:03 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id u15-20020a170902714f00b0017532e01e3fsm1088393plm.276.2022.08.30.08.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 08:01:03 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: cui.jinpeng2@zte.com.cn
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] selinux: remove redundant variables rc
Date:   Tue, 30 Aug 2022 15:00:58 +0000
Message-Id: <20220830150058.300327-1-cui.jinpeng2@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>

Rturn value directly from sel_make_perm_files() instead of
getting value from redundant variable rc.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
---
 security/selinux/selinuxfs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 8fcdd494af27..66610eb3d317 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1917,7 +1917,6 @@ static int sel_make_class_dir_entries(struct selinux_policy *newpolicy,
 	struct selinux_fs_info *fsi = sb->s_fs_info;
 	struct dentry *dentry = NULL;
 	struct inode *inode = NULL;
-	int rc;
 
 	dentry = d_alloc_name(dir, "index");
 	if (!dentry)
@@ -1937,9 +1936,7 @@ static int sel_make_class_dir_entries(struct selinux_policy *newpolicy,
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
-	rc = sel_make_perm_files(newpolicy, classname, index, dentry);
-
-	return rc;
+	return sel_make_perm_files(newpolicy, classname, index, dentry);
 }
 
 static int sel_make_classes(struct selinux_policy *newpolicy,
-- 
2.25.1

