Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473C44DEA91
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 21:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244099AbiCSUQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 16:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240604AbiCSUQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 16:16:48 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B5A2AC0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 13:15:25 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id k10so125846edj.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 13:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3YwWZFhg7UWstMrRCwlcxc9hwqJ8DgIkZgGqDdCvp/s=;
        b=CqjAnraf2j40US4bIqaMuBjTbZNE2dWIW6dRpLcH/RknDJQltshT08SrDxHNZfMXBb
         6DTPHJ15jCHRVs9GtjKf2TymtTicbmangneULvUaH8Su1oC31jeASi6DLh4/pytr5SpJ
         brTDMajWoy3qSArEzAXiQnT2fY0QIK+d/UwWwOb3qlGGaHgbR6bCdcEfhik75LPamoqG
         DQcbSE79HewCJER1lOZonRt32LCU0NJRF28l6zQGAgpdDI4AoX3GLJgN/KqXWNXISzf0
         DeyuOP6O3rNf2mswiiVVJLr/QXnrzipk4yisevUeYZWtyA69HEKQFzuza/5kzwO4c4OI
         H8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3YwWZFhg7UWstMrRCwlcxc9hwqJ8DgIkZgGqDdCvp/s=;
        b=idINS3Na0Ihof3iY7glnZohYcM4cTzZjqJ3SuD5+nbU2Q0o+vByY6XCTMgbZklNwFi
         I9wO77wFsaDygt9xTj+XZo3AH61d9o24PKNYGd6xd8ZtMOP7poFYPY3yg0oXy808TD1m
         U2Kixw9Pv0hjQHjMnbTtkVzXCOXgvgw11g4sgwsO05ytoCCQIdTvi82tScwKPWHQeDNu
         L9kkls1ZUnoMzK52LOatT/VBzn8rwddhgMzV9shxNjG88DqR4XK7JWNs/0bdUTJFehq4
         ogzKyAnJKmsQWUIDztW636SVwFaJ4ymRgykqSvmiy1cK6ejG/E8utZL5N9imyuJ3iXhG
         mGNA==
X-Gm-Message-State: AOAM532cHAgGnzHU0hADR5+20k0ClzHtSm05mxoukKjqdR4xQFTugDIx
        qnEoL2T3ywNJxFxPL/2ND+k=
X-Google-Smtp-Source: ABdhPJxFO5/c2FCGt2c30YkvTbkUWkYhgnULgWPdhw8kY6UjypOHYZumxS5gDKOWaI0T07Xg37mEaw==
X-Received: by 2002:a50:c00a:0:b0:418:f10f:b27c with SMTP id r10-20020a50c00a000000b00418f10fb27cmr15505539edb.204.1647720923695;
        Sat, 19 Mar 2022 13:15:23 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id js24-20020a170906ca9800b006c8aeca8fe8sm5166332ejb.58.2022.03.19.13.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 13:15:23 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jakob Koschel <jakobkoschel@gmail.com>,
        linux-kernel@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: [PATCH] char: misc: remove usage of list iterator past the loop body
Date:   Sat, 19 Mar 2022 21:14:54 +0100
Message-Id: <20220319201454.2511733-1-jakobkoschel@gmail.com>
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

In preparation to limit the scope of the list iterator to the list
traversal loop, use a dedicated pointer pointing to the found element [1].

Link: https://lore.kernel.org/all/YhdfEIwI4EdtHdym@kroah.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/char/misc.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index ca5141ed5ef3..cba19bfdc44d 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -100,17 +100,18 @@ static const struct seq_operations misc_seq_ops = {
 static int misc_open(struct inode *inode, struct file *file)
 {
 	int minor = iminor(inode);
-	struct miscdevice *c;
+	struct miscdevice *c = NULL, *iter;
 	int err = -ENODEV;
 	const struct file_operations *new_fops = NULL;

 	mutex_lock(&misc_mtx);

-	list_for_each_entry(c, &misc_list, list) {
-		if (c->minor == minor) {
-			new_fops = fops_get(c->fops);
-			break;
-		}
+	list_for_each_entry(iter, &misc_list, list) {
+		if (iter->minor != minor)
+			continue;
+		c = iter;
+		new_fops = fops_get(iter->fops);
+		break;
 	}

 	if (!new_fops) {
@@ -118,11 +119,12 @@ static int misc_open(struct inode *inode, struct file *file)
 		request_module("char-major-%d-%d", MISC_MAJOR, minor);
 		mutex_lock(&misc_mtx);

-		list_for_each_entry(c, &misc_list, list) {
-			if (c->minor == minor) {
-				new_fops = fops_get(c->fops);
-				break;
-			}
+		list_for_each_entry(iter, &misc_list, list) {
+			if (iter->minor != minor)
+				continue;
+			c = iter;
+			new_fops = fops_get(iter->fops);
+			break;
 		}
 		if (!new_fops)
 			goto fail;

base-commit: 34e047aa16c0123bbae8e2f6df33e5ecc1f56601
--
2.25.1

