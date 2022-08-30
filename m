Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936F95A5E57
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbiH3Ilg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiH3Ild (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:41:33 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4B2A59A7;
        Tue, 30 Aug 2022 01:41:32 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o4so10453515pjp.4;
        Tue, 30 Aug 2022 01:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=ArSRMVql55TxcTsneNf3jqqeKKniG2So9vFeYTehnhY=;
        b=IkNNJfjCG6omPuj3mMH+AHyCIheopsFNXkE2XR9JvrTgQb4qfW/UDXOeWY41+fxvKa
         4baZL8h4GAY/MK6wgoZajNJyzz23Ae/65RIWal535mVXGmRPVyfF3DEk4K4SLjQA6rsZ
         vDlWTZ2/EyZhUxZhyju/pg23mJDD524wOAo6fM/f4ii880KtOVVee8Rqno9HG2WhE80H
         m1ZiCiaGh7qS493A+8BoS+XNxKa4q2HPO1uIy3QQDsdH6qN+p/WnKoKH+PyOHhzkSNPC
         zCGE3GXbkK9rZtEYMnDjiwNI3osSwxNQK+J/kDe0k8/awYo2crrvgwS9sHzr61hwHswH
         OSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ArSRMVql55TxcTsneNf3jqqeKKniG2So9vFeYTehnhY=;
        b=zqImqH/p8Ig1oiT/3dVmxT8YHBRwsZXky5F69p0O9cAEJ4Tf6HWTvojpAesONJ2L00
         4d569bjp47AWJOLYXW/4JlpOrhtOUuaBcUlYW2DmIZThkWbPoyZ7moDuLGcNf1ilCCcJ
         8JhM60TYFcoqHc5ffMsflIaglMbb8MNjCcGPqqZHa+9KeLbFpJqXEL2YSqKBKJhTPl7P
         7gfRiAk6c3St4bp8Pd7y2hNqxiIk4+2p0nTeCZ5IoSIV3SkcuoudOfXHqjS3IPgO9NFb
         lb53fGOnBPgWV777XwdxCI9I0yAs55TMsFfNHq/JCV6mLA263o+NNtTydETqOekp8nE5
         qjsg==
X-Gm-Message-State: ACgBeo1KHZTFWvnehhZzULxKt5d/jYUr8BoWrSV9jJXdA1iMETr4bhFi
        1/DNQmW3oeTufuj7PoJc0hY=
X-Google-Smtp-Source: AA6agR4qocb33j0uoyG1y36/vj7yV8YFZZqn2x6E2Z37n2xcys7zJO8oC64PWHxJQg0g1aBu9mjSyw==
X-Received: by 2002:a17:90a:ce12:b0:1fb:b6d5:8c4e with SMTP id f18-20020a17090ace1200b001fbb6d58c4emr23063263pju.244.1661848891931;
        Tue, 30 Aug 2022 01:41:31 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d8-20020a170903230800b0016c50179b1esm2371745plh.152.2022.08.30.01.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 01:41:31 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     paul@paul-moore.com
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] selinux: Remove the unneeded result variable
Date:   Tue, 30 Aug 2022 08:41:24 +0000
Message-Id: <20220830084124.284688-1-ye.xingchen@zte.com.cn>
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value sel_make_perm_files() directly instead of storing it
in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
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
