Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619B94ED5A5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbiCaIcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbiCaIcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:32:18 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7023A3983A;
        Thu, 31 Mar 2022 01:30:31 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id m18so17862841plx.3;
        Thu, 31 Mar 2022 01:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=ivXMvvbs5/EJ/cA1YNvCsYZ5GhYYP7s+w/OiMvQ9vdM=;
        b=dmMQkLUbRxIWiMemllk8m4UN5qUqRLS4xMLW3zx/IMoev0AfAe/IRmrzEsLeT52WpK
         u6hvbrMY9LBPWcExkvT7L6xVN7G313RRkCpyCvKij0TeehtUKT9WxFWRzSg8uIe0RsLX
         vmDAlz8RBpAbFcvtABS+KkCsG+rxt6YPDuk1qw0F6KmGr/tFBc+wa8rfgY2HbaCftkoq
         YzdeHZL6bMmGEeWraSOrQEsPVaQ/m/8TsHJT2h5omb8lYnUdZTQn3yJF+J8M4zsJzlWG
         4dpPtfFBCsyE/15rZmbFjoQ4q0C59+QraJ2NelKF7xBwH/is8h6+l9IgWAFhUeDBN+DO
         gZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ivXMvvbs5/EJ/cA1YNvCsYZ5GhYYP7s+w/OiMvQ9vdM=;
        b=DGFVjN/WjVnmCJT5tWrD5XWi4X7WTtiagIm41oD6aWuufNw0bKXhKEVcDPpZuYILqP
         WwP3KiQPS4gA8vGMEW26YH271/S7KJ+Qr6zAqiJtQkdaUdR/FJUsyqiRCuhsLOp7AW/s
         7eYs+kZ4BGkMLnbvWH54Qla+0zV+fnTfL/pKFDZUmjSHSlqBe5UDG6W8Xccd0wxfK4qX
         MQgl3cWQprTgb7A/mLsaGhT9gsmBPF0OHvomsf0y3T/hK+ps3k+22Tubz26XRyIVoqL+
         DSHz+l7RSBQ0HY4JGl0eOnVjDo5gEEVYqo8lQ7FwJKoDGd7pJeKqssOQqvVYIt1jqvVE
         Vo7Q==
X-Gm-Message-State: AOAM530OrrtnHMTXNd1DOGG7bRkaXfaJzEdLOgk2v/Nm3Pa/bDQ77Yc+
        pZ9A2bD/FibhaK/nZoXTA3A=
X-Google-Smtp-Source: ABdhPJwyXgHtVxQarjOg5ftr1g/409/SafG6TRxjZhAqQaz8fVpUoKM+MSv+EvwnfibqtJWpqfIlkQ==
X-Received: by 2002:a17:90a:b307:b0:1bd:37f3:f0fc with SMTP id d7-20020a17090ab30700b001bd37f3f0fcmr4946733pjr.132.1648715430845;
        Thu, 31 Mar 2022 01:30:30 -0700 (PDT)
Received: from ubuntu.huawei.com ([119.3.119.18])
        by smtp.googlemail.com with ESMTPSA id j70-20020a638b49000000b003985b5ddaa1sm10950655pge.49.2022.03.31.01.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 01:30:30 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [PATCH v2] opp: use list iterator only inside the loop
Date:   Thu, 31 Mar 2022 16:30:18 +0800
Message-Id: <20220331083018.31995-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate dedicated pointer variable [1].

In this case, use a new variable 'iter' as the list iterator, while
use the old variable 'new_dev' as a dedicated pointer to point to the
found entry. And BUG_ON(!new_dev);.

[1]: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/

Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---

changes since v1:
 - use BUG_ON(!new_dev); instead of return; (Viresh Kumar)

v1: https://lore.kernel.org/lkml/20220331015818.28045-1-xiam0nd.tong@gmail.com/

---
 drivers/opp/debugfs.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
index 596c185b5dda..81b2bc4b5f43 100644
--- a/drivers/opp/debugfs.c
+++ b/drivers/opp/debugfs.c
@@ -187,14 +187,18 @@ void opp_debug_register(struct opp_device *opp_dev, struct opp_table *opp_table)
 static void opp_migrate_dentry(struct opp_device *opp_dev,
 			       struct opp_table *opp_table)
 {
-	struct opp_device *new_dev;
+	struct opp_device *new_dev = NULL, *iter;
 	const struct device *dev;
 	struct dentry *dentry;
 
 	/* Look for next opp-dev */
-	list_for_each_entry(new_dev, &opp_table->dev_list, node)
-		if (new_dev != opp_dev)
+	list_for_each_entry(iter, &opp_table->dev_list, node)
+		if (iter != opp_dev) {
+			new_dev = iter;
 			break;
+		}
+
+	BUG_ON(!new_dev);
 
 	/* new_dev is guaranteed to be valid here */
 	dev = new_dev->dev;
-- 
2.17.1

