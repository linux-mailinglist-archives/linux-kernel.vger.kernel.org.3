Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B9D5967CC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 05:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiHQDqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 23:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiHQDqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 23:46:40 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B4072B78
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 20:46:39 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id h28so11023082pfq.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 20:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=ES4XSV6um0uYgsYcFmKj7KuYCP2ajc5QcgQlnvm8VA4=;
        b=LNDDdT6zVhPPnzuEb9FR7yQ+IIT5NQfFf3mbhp1cCV1hWogez4of+apjE42XruIj/r
         Ud/HxxN0Je5glx+Hyg5WEoQ3PycFC2StiDVpc0F0llcS3p3qq2lDXA6COThvzPYHxctj
         B/Yit3d2G4YeOo2br4R3SjM2jZ/wYR7OCyQoDHt2s3SyK4+JDR8/NGJlrRpPWIRnA0VS
         YuoJS7sQz4fP6pAr+GGMB9oSTo2dpu9/OmIRisujdGjhzgWhcorgo7UqtfwF1SlgzJBm
         lObgAmqLUuvZI2cPYsVNFExlk+lEHI2mf6d0JJRCUj6k+4siJt8MDaO+q8coTJx96KqD
         M94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ES4XSV6um0uYgsYcFmKj7KuYCP2ajc5QcgQlnvm8VA4=;
        b=Rt+LaTGBQ9ykpIX4XECo8fl4Fg+3+HD5/+bp+gtQ+EqRLekwa07euQOjSI1EmExlBw
         jLG+sBwn/ntbZOpfNdOqYZVfpo8OymSrs6CT2STrtt7ABAJ+RoIjFYodg71ODfwoe1lF
         3YkodeUQ/gNRh/f6+4uTiNiwN6jE4leyFilsuNrNKRWZ6fyrgQxAH04JbQFfwNrB27iQ
         Mvy9HZw7xy10bkxwejdJf4CUGh0TRrf5i7SuC09dA29ELwj71V7JOVnFPlTDZPty25xw
         jO/St1mgW7WjyOIZfylRzafp5ABPuo6AA4VEeEJAxYt3hrlx1z/wMwk1tMh9RbsB/WNC
         xitQ==
X-Gm-Message-State: ACgBeo1UtgvArq9lX3i9/CqvQkVdPGCWp3mwaC2TYxzFrgGS+JtyhAxQ
        gJWYCao0Il1bUsl0EChASDRnDzMBEWRiLdk5
X-Google-Smtp-Source: AA6agR6aRxQIbONcFxrCU95ThiH0UjJgVVAGX9S3Tg4MiWbsz3OtXxNOrzYlfy6gkAkb+X15aN37RQ==
X-Received: by 2002:a65:4205:0:b0:429:b155:4945 with SMTP id c5-20020a654205000000b00429b1554945mr3737562pgq.572.1660707998729;
        Tue, 16 Aug 2022 20:46:38 -0700 (PDT)
Received: from J23WFD767R.bytedance.net ([61.120.150.74])
        by smtp.gmail.com with ESMTPSA id z7-20020a1709027e8700b001725a63746dsm179999pla.186.2022.08.16.20.46.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 16 Aug 2022 20:46:38 -0700 (PDT)
From:   Zhang Tianci <zhangtianci.1997@bytedance.com>
To:     miklos@szeredi.hu
Cc:     Zhang Tianci <zhangtianci.1997@bytedance.com>,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Subject: [PATCH] ovl: Do not override fsuid and fsgid in ovl_link()
Date:   Wed, 17 Aug 2022 11:45:59 +0800
Message-Id: <20220817034559.44936-1-zhangtianci.1997@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
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

ovl_link() did not create a new inode after commit
51f7e52dc943 ("ovl: share inode for hard link"), so
in ovl_create_or_link() we should not override cred's
fsuid and fsgid when called by ovl_link().

Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
---
 fs/overlayfs/dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 6b03457f72bb..568d338032db 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -595,9 +595,9 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 	err = -ENOMEM;
 	override_cred = prepare_creds();
 	if (override_cred) {
-		override_cred->fsuid = inode->i_uid;
-		override_cred->fsgid = inode->i_gid;
 		if (!attr->hardlink) {
+			override_cred->fsuid = inode->i_uid;
+			override_cred->fsgid = inode->i_gid;
 			err = security_dentry_create_files_as(dentry,
 					attr->mode, &dentry->d_name, old_cred,
 					override_cred);
-- 
2.32.1 (Apple Git-133)

