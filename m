Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A821C572F46
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbiGMHdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiGMHdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:33:17 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FE10E4774;
        Wed, 13 Jul 2022 00:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=+iaFH
        0XVV9VnTnS/vk4XmqXA2CqdtbQq885CFUjkLo8=; b=J+7JVxOrL+QHtxHXzsMzS
        DUZKTZz8DmwQCZnU+b6PD7I4jvC6De+rYG+Q2GGdyPyIoS/xDuia36tExekI00fV
        UZUjVMpWZ8FqaP43LqYXx41oZdLP+m5lkn4HLJB+WK4gCrw9Ec+X5OJBJNycD4kH
        0rK1SADHSnWk3alHBt2pHk=
Received: from localhost.localdomain (unknown [123.58.221.99])
        by smtp3 (Coremail) with SMTP id G9xpCgC39aEFdc5imZ1_Ow--.5085S2;
        Wed, 13 Jul 2022 15:32:22 +0800 (CST)
From:   williamsukatube@163.com
To:     linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     miklos@szeredi.hu, William Dean <williamsukatube@gmail.com>,
        Hacash Robot <hacashRobot@santino.com>
Subject: [PATCH] ovl: Fix a potential memory leak for kstrdup()
Date:   Wed, 13 Jul 2022 15:32:17 +0800
Message-Id: <20220713073217.2663078-1-williamsukatube@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgC39aEFdc5imZ1_Ow--.5085S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFyxur4kArWxurW3trWkZwb_yoW5Kw1DpF
        48ury3JrWUJFyfXr42kFykuFy5Kwn7GFy5C3W8Aa17J3ZIkry0yFy5Kr1a9Fy3AF98Xry0
        vFZ5KF1jgFsrZF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07brAp5UUUUU=
X-Originating-IP: [123.58.221.99]
X-CM-SenderInfo: xzlozx5dpv3yxdwxuvi6rwjhhfrp/xtbB0AY9g2EsrUz2EwAAsh
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Dean <williamsukatube@gmail.com>

kfree() is missing on an error path to free the memory
allocated by kstrdup():

config->redirect_mode = kstrdup(ovl_redirect_mode_def(), GFP_KERNEL);

So it is better to free it via kfree(config->redirect_mode).

Reported-by: Hacash Robot <hacashRobot@santino.com>
Signed-off-by: William Dean <williamsukatube@gmail.com>
---
 fs/overlayfs/super.c | 42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index b936e2c9226b..6e95ea078915 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -533,22 +533,28 @@ static int ovl_parse_opt(char *opt, struct ovl_config *config)
 		case OPT_UPPERDIR:
 			kfree(config->upperdir);
 			config->upperdir = match_strdup(&args[0]);
-			if (!config->upperdir)
-				return -ENOMEM;
+			if (!config->upperdir) {
+				err = -ENOMEM;
+				goto out_err;
+			}
 			break;
 
 		case OPT_LOWERDIR:
 			kfree(config->lowerdir);
 			config->lowerdir = match_strdup(&args[0]);
-			if (!config->lowerdir)
-				return -ENOMEM;
+			if (!config->lowerdir) {
+				err = -ENOMEM;
+				goto out_err;
+			}
 			break;
 
 		case OPT_WORKDIR:
 			kfree(config->workdir);
 			config->workdir = match_strdup(&args[0]);
-			if (!config->workdir)
-				return -ENOMEM;
+			if (!config->workdir) {
+				err = -ENOMEM;
+				goto out_err;
+			}
 			break;
 
 		case OPT_DEFAULT_PERMISSIONS:
@@ -624,7 +630,8 @@ static int ovl_parse_opt(char *opt, struct ovl_config *config)
 		default:
 			pr_err("unrecognized mount option \"%s\" or missing value\n",
 					p);
-			return -EINVAL;
+			err = -EINVAL;
+			goto out_err;
 		}
 	}
 
@@ -650,7 +657,7 @@ static int ovl_parse_opt(char *opt, struct ovl_config *config)
 
 	err = ovl_parse_redirect_mode(config, config->redirect_mode);
 	if (err)
-		return err;
+		goto out_err;
 
 	/*
 	 * This is to make the logic below simpler.  It doesn't make any other
@@ -664,7 +671,8 @@ static int ovl_parse_opt(char *opt, struct ovl_config *config)
 		if (metacopy_opt && redirect_opt) {
 			pr_err("conflicting options: metacopy=on,redirect_dir=%s\n",
 			       config->redirect_mode);
-			return -EINVAL;
+			err = -EINVAL;
+			goto out_err;
 		}
 		if (redirect_opt) {
 			/*
@@ -687,7 +695,8 @@ static int ovl_parse_opt(char *opt, struct ovl_config *config)
 			config->nfs_export = false;
 		} else if (nfs_export_opt && index_opt) {
 			pr_err("conflicting options: nfs_export=on,index=off\n");
-			return -EINVAL;
+			err = -EINVAL;
+			goto out_err;
 		} else if (index_opt) {
 			/*
 			 * There was an explicit index=off that resulted
@@ -705,7 +714,8 @@ static int ovl_parse_opt(char *opt, struct ovl_config *config)
 	if (config->nfs_export && config->metacopy) {
 		if (nfs_export_opt && metacopy_opt) {
 			pr_err("conflicting options: nfs_export=on,metacopy=on\n");
-			return -EINVAL;
+			err = -EINVAL;
+			goto out_err;
 		}
 		if (metacopy_opt) {
 			/*
@@ -730,11 +740,13 @@ static int ovl_parse_opt(char *opt, struct ovl_config *config)
 		if (config->redirect_follow && redirect_opt) {
 			pr_err("conflicting options: userxattr,redirect_dir=%s\n",
 			       config->redirect_mode);
-			return -EINVAL;
+			err =  -EINVAL;
+			goto out_err;
 		}
 		if (config->metacopy && metacopy_opt) {
 			pr_err("conflicting options: userxattr,metacopy=on\n");
-			return -EINVAL;
+			err = -EINVAL;
+			goto out_err;
 		}
 		/*
 		 * Silently disable default setting of redirect and metacopy.
@@ -747,6 +759,10 @@ static int ovl_parse_opt(char *opt, struct ovl_config *config)
 	}
 
 	return 0;
+
+out_err:
+	kfree(config->redirect_mode);
+	return err;
 }
 
 #define OVL_WORKDIR_NAME "work"
-- 
2.25.1

