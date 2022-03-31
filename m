Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBCE4EE3B6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 00:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242214AbiCaWEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 18:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiCaWEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 18:04:07 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E431EE8E0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:02:19 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z92so820752ede.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zVX+ni+qIlknEI/UHZP1JghyHCXyos1MEYHumXUzMdo=;
        b=S9D4MJkYyQDK3oLILyCxZZyKRV6OVbtlSGbJuuU6xJtN1vOjdthqSlJTktw0BTDwbw
         uJw0uxWYmEzYnEnMUUejdmD7wM1QqfsiFffqIs/vGntK1gS7/C5+JqgMXfmrQNJ7XfS4
         Zu1s9QUDg+NTrWCIiWdIhXOZJHOUmOaPs7WBgv0+/HOksljjt7N/D2t8W4YT6MPRMD0x
         1tv6pAJSfnkl6Hk1cjgOopUnuKOIlP1JUXdGl7EWDMWpNA7Qg99fCUJpUhLunfSCqei4
         pnmeeM10uh9B4xgX8UTYoCN6P/n9Aocr7nk/IK6U1z4czy8njWiaO7ZcmwViE0Ya3Xs7
         m/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zVX+ni+qIlknEI/UHZP1JghyHCXyos1MEYHumXUzMdo=;
        b=v6gI9Wdt1oJ1Y8Iimn5DQTPxIbsOKXIUCt/s9iC3Z9uGTMrF1fI3lAMCU7P3LZMoVu
         AZ5yJMN7Iw1sSKyWuWs3/HyhUt/cTAn6O2PYbDOXyy+8E19P1UekJjwwevZ1GE6m/d70
         fL7ADKQ/5vZiYVKfXELvPyFL+mRNa/wO2FammfqRDv4ViviIp14qe39CXrBJLz9M8MR/
         7aAIB0XfD0xpEMzR1aDGkm2UHaEid/wxeKUIIQTKPnncO+ajiH1OUpeDs8ZRgdQ1uLSG
         S1q+ZQX4hBGe7O08q4pA0I4wSkNO6A2fEt66N6e7YOPEqxo3HhlkvR0KtUwmOZbb5oav
         13iA==
X-Gm-Message-State: AOAM533+14tLbkFredCBymL86/f2qzjs7+aar7h1MG9udRLNytBqg5Hj
        PyCs5GcJ/u8zqHAnGDSnztE=
X-Google-Smtp-Source: ABdhPJy13+OSM+bS9OkKiQ3oVJ1rBRV700cQePPUmDvgd04hMxGLRlCzZdxaK4VZTe3hrAU1uVJHuQ==
X-Received: by 2002:aa7:d445:0:b0:41b:5835:c6da with SMTP id q5-20020aa7d445000000b0041b5835c6damr15266061edr.309.1648764138136;
        Thu, 31 Mar 2022 15:02:18 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id n21-20020a170906725500b006e10a7d6d03sm238050ejk.219.2022.03.31.15.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 15:02:17 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Christine Caulfield <ccaulfie@redhat.com>
Cc:     David Teigland <teigland@redhat.com>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH 1/2] dlm: remove usage of list iterator for list_add() after the loop body
Date:   Fri,  1 Apr 2022 00:00:12 +0200
Message-Id: <20220331220013.884633-1-jakobkoschel@gmail.com>
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

In preparation to limit the scope of a list iterator to the list
traversal loop, use a dedicated pointer to point to the found element [1].

Before, the code implicitly used the head when no element was found
when using &pos->list. Since the new variable is only set if an
element was found, the list_add() is performed within the loop
and only done after the loop if it is done on the list head directly.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 fs/dlm/lock.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index bdb51d209ba2..66e92617d7ea 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1306,13 +1306,17 @@ static inline void unhold_lkb(struct dlm_lkb *lkb)
 static void lkb_add_ordered(struct list_head *new, struct list_head *head,
 			    int mode)
 {
-	struct dlm_lkb *lkb = NULL;
+	struct dlm_lkb *lkb = NULL, *iter;
 
-	list_for_each_entry(lkb, head, lkb_statequeue)
-		if (lkb->lkb_rqmode < mode)
+	list_for_each_entry(iter, head, lkb_statequeue)
+		if (iter->lkb_rqmode < mode) {
+			lkb = iter;
+			list_add_tail(new, &iter->lkb_statequeue);
 			break;
+		}
 
-	__list_add(new, lkb->lkb_statequeue.prev, &lkb->lkb_statequeue);
+	if (!lkb)
+		list_add_tail(new, head);
 }
 
 /* add/remove lkb to rsb's grant/convert/wait queue */

base-commit: f82da161ea75dc4db21b2499e4b1facd36dab275
-- 
2.25.1

