Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3454E5F2F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348441AbiCXHQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348439AbiCXHQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:16:44 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D464E186E3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:15:12 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id r13so7286534ejd.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zkIzcEi1qH2OtuZqABo8GJfJ+wmDwLruJeazIXQywV4=;
        b=BlF5osJ2E5wrXcjQGPPI7WJs6Gd9NF1iKFe/7trbek8m6nCZtxzYSZRiXd9W79x4uS
         FuLJZ1UUID8lSTNrv3IkiOjRQ0qmyMNljRDKZQ9ofEd2QF13DBAOhB8LuOWDi/QBAEAQ
         5fsay7vUo23vFdnVW7+zDE+nk1yH5og4eRLjSEnEMG6crTFuGnxXWfOPQu4IOqj7wCwD
         Sbz+Pk5QsfaEU8nkfqZ0VQNW//5LsSEdAg25K/fX+tZpVDTDAp2nyqaNZME8NTaUnp1Z
         WMtWWBajPVJ+npThJvtc0qlzdJG5NcyrJNe9mZVgP9TpIs1Du5mHwUIbggA0igjEK78X
         nRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zkIzcEi1qH2OtuZqABo8GJfJ+wmDwLruJeazIXQywV4=;
        b=isLPUr2Y5s9Ojknwh8CBE85PzrOivrqgb2rP4fE7f1ajR4p8GI3GcaA3ZuSJbAQOs9
         IHDH18kLI71gJhoQ1n/0Pj43JIqQAPBZ6UcopirOLxu4KNB68QzSkUQeAAbDgk7+75G9
         s1taDsvcUFkPloBxA1xGH6h+TowEOBRwMVtUbtDRVYyRFatOG+PwYDlVBLHz5cSCJtzj
         P3Y2W+ZJmNTYb8fz4wLk+TrDybSUq8EvAePQxe/i1pCggjGJUcxewfMZJ9Dbhmi6TZj+
         IZXNTeKonp7DvkEstGlFn5Izc86wUol+rUJ58UCNPqI2qX5KJAVGV5m1Efh298oW0hgB
         ir+Q==
X-Gm-Message-State: AOAM530x48k89F7yxvP59vnOzJ5iUDEYs0cak5cbk9XX/l0H5NEmb515
        z8rjkvi96RqrqmQgBXXCdlCaZjR7EPBmFg==
X-Google-Smtp-Source: ABdhPJxEjkhMTB7hmnRB9K7JMKxwds5soeieMEZZQa4YKfW3GInbKmOUnLunsTdqIazTimUeXi0pUg==
X-Received: by 2002:a17:906:64ca:b0:6e0:1648:571c with SMTP id p10-20020a17090664ca00b006e01648571cmr4068208ejn.477.1648106111323;
        Thu, 24 Mar 2022 00:15:11 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id hg11-20020a1709072ccb00b006cee4fb36c7sm760780ejc.64.2022.03.24.00.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 00:15:10 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH] mfd: dln2: replace usage of found with dedicated list iterator variable
Date:   Thu, 24 Mar 2022 08:14:51 +0100
Message-Id: <20220324071451.60616-1-jakobkoschel@gmail.com>
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

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable instead of a
found boolean [1].

This removes the need to use a found variable and simply checking if
the variable was set, can determine if the break/goto was hit.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/mfd/dln2.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
index 852129ea0766..741e8ae2d89d 100644
--- a/drivers/mfd/dln2.c
+++ b/drivers/mfd/dln2.c
@@ -163,23 +163,22 @@ EXPORT_SYMBOL(dln2_register_event_cb);
 void dln2_unregister_event_cb(struct platform_device *pdev, u16 id)
 {
 	struct dln2_dev *dln2 = dev_get_drvdata(pdev->dev.parent);
-	struct dln2_event_cb_entry *i;
+	struct dln2_event_cb_entry *i = NULL, *iter;
 	unsigned long flags;
-	bool found = false;
 
 	spin_lock_irqsave(&dln2->event_cb_lock, flags);
 
-	list_for_each_entry(i, &dln2->event_cb_list, list) {
-		if (i->id == id) {
-			list_del_rcu(&i->list);
-			found = true;
+	list_for_each_entry(iter, &dln2->event_cb_list, list) {
+		if (iter->id == id) {
+			list_del_rcu(&iter->list);
+			i = iter;
 			break;
 		}
 	}
 
 	spin_unlock_irqrestore(&dln2->event_cb_lock, flags);
 
-	if (found) {
+	if (i) {
 		synchronize_rcu();
 		kfree(i);
 	}

base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
2.25.1

