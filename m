Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF61E5A679E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 17:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiH3PpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 11:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiH3PpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:45:10 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE8B13F12;
        Tue, 30 Aug 2022 08:45:09 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y64so2948353ede.2;
        Tue, 30 Aug 2022 08:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=r07HdbcTRJqdbh3cWaW41NcbNQKCl2B9quXv/+dnoSo=;
        b=cq2gGQzxbdjFfdxrGHyCVd028uwEJ82nJR07xJap1ia3+EneTuNU+Lj0PdF8+xEQTr
         ZTPTtf6z+LelclvmA/SQS1J1kZUHPrXsVM7tdNhwjyPHlELGUt1CpvM3dajYn4K3HYn9
         +S44Mq9Io6ohOdGwUWlgvm978ERHp2dYGBBxRHrSW98wTalKY5vegO8vM3g6GlYBpByi
         7HN/VOUnVPiFhpTs/+LIWMnfb2jJ7q8463MHSOyohd/KtzRpXDBxJEGZPBBU90+op+I4
         RSwWaJE9w6o9N3pELzmaQnu0lFHv+jq9hBWM+8pGuzcAYORzY00JgbY+mf1fgjlrPA7K
         Qluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=r07HdbcTRJqdbh3cWaW41NcbNQKCl2B9quXv/+dnoSo=;
        b=hIPNhjFB7AxUMNGh9O+fOG24hphQBlwIGe0xDO4VvxklGJZ3Hm3aXCYs+5yO9C3D07
         88GYq6HTw3BTRjactW0yNhQMaSiqje5TigwroIlJtzGokRM4qLIrumwCNtQ96T3z+KKv
         Sw9fB7saFW/m+u1bwkstQigpLK2edrL97GPolCgn+Njxrg1K7vIpooJtDcw4owZeM7ZN
         MnsapoOuqDgDr2VVvqEXB5UZm1Gd9jrclS38S/VenANyFBMnf0MUw1DWsd2WIpYktdpV
         TCGo61O0cdCzbD1T8wp66ydk6f0YsEAkTuQBFmeU9H3wN8q1krN8o5iPohpBLdcC3bNF
         ZbiA==
X-Gm-Message-State: ACgBeo3y5zKxXKQV2s1Ren/j+Xp5LGwYP5IdVW8ubQoheqYXzHz/zfCR
        2jGN92qKrVsF7UFwLKZGJLJRM1NR66Boeg==
X-Google-Smtp-Source: AA6agR56Gjo9mhuycsBkRuqidJ5EVMXp71xtRrK7IKdrPu3E40IqyKuW9bDoiWk/rRBRCbL1bUrObw==
X-Received: by 2002:a05:6402:40cb:b0:448:627d:90d6 with SMTP id z11-20020a05640240cb00b00448627d90d6mr9440525edb.233.1661874307410;
        Tue, 30 Aug 2022 08:45:07 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-163-172.95.116.pool.telefonica.de. [95.116.163.172])
        by smtp.gmail.com with ESMTPSA id fe15-20020a1709072a4f00b0073da4b623e8sm5853962ejc.152.2022.08.30.08.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 08:45:06 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selinux: use int arrays for boolean values
Date:   Tue, 30 Aug 2022 17:45:00 +0200
Message-Id: <20220830154500.18165-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Do not cast pointers of signed integers to pointers of unsigned integers
and vice versa.

It should currently not be an issue since they hold SELinux boolean
values which should only contain either 0's or 1's, which should have
the same representation.

Reported by sparse:

    security/selinux/selinuxfs.c:1485:30: warning: incorrect type in assignment (different signedness)
    security/selinux/selinuxfs.c:1485:30:    expected unsigned int *
    security/selinux/selinuxfs.c:1485:30:    got int *[addressable] values
    security/selinux/selinuxfs.c:1402:48: warning: incorrect type in argument 3 (different signedness)
    security/selinux/selinuxfs.c:1402:48:    expected int *values
    security/selinux/selinuxfs.c:1402:48:    got unsigned int *bool_pending_values

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
Previous patch proposal: https://patchwork.kernel.org/project/selinux/patch/20220502135907.31035-1-cgzones@googlemail.com/
---
 security/selinux/selinuxfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 8fcdd494af27..f0b1aafd67aa 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -71,7 +71,7 @@ struct selinux_fs_info {
 	struct dentry *bool_dir;
 	unsigned int bool_num;
 	char **bool_pending_names;
-	unsigned int *bool_pending_values;
+	int *bool_pending_values;
 	struct dentry *class_dir;
 	unsigned long last_class_ino;
 	bool policy_opened;
@@ -356,7 +356,7 @@ static const struct file_operations sel_policyvers_ops = {
 /* declaration for sel_write_load */
 static int sel_make_bools(struct selinux_policy *newpolicy, struct dentry *bool_dir,
 			  unsigned int *bool_num, char ***bool_pending_names,
-			  unsigned int **bool_pending_values);
+			  int **bool_pending_values);
 static int sel_make_classes(struct selinux_policy *newpolicy,
 			    struct dentry *class_dir,
 			    unsigned long *last_class_ino);
@@ -527,7 +527,7 @@ static const struct file_operations sel_policy_ops = {
 };
 
 static void sel_remove_old_bool_data(unsigned int bool_num, char **bool_names,
-				unsigned int *bool_values)
+				int *bool_values)
 {
 	u32 i;
 
@@ -545,7 +545,7 @@ static int sel_make_policy_nodes(struct selinux_fs_info *fsi,
 	struct dentry *tmp_parent, *tmp_bool_dir, *tmp_class_dir, *old_dentry;
 	unsigned int tmp_bool_num, old_bool_num;
 	char **tmp_bool_names, **old_bool_names;
-	unsigned int *tmp_bool_values, *old_bool_values;
+	int *tmp_bool_values, *old_bool_values;
 	unsigned long tmp_ino = fsi->last_ino; /* Don't increment last_ino in this function */
 
 	tmp_parent = sel_make_disconnected_dir(fsi->sb, &tmp_ino);
@@ -1423,7 +1423,7 @@ static void sel_remove_entries(struct dentry *de)
 
 static int sel_make_bools(struct selinux_policy *newpolicy, struct dentry *bool_dir,
 			  unsigned int *bool_num, char ***bool_pending_names,
-			  unsigned int **bool_pending_values)
+			  int **bool_pending_values)
 {
 	int ret;
 	ssize_t len;
-- 
2.37.2

