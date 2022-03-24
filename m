Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393354E5F39
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348448AbiCXHUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiCXHUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:20:11 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2442FFEB;
        Thu, 24 Mar 2022 00:18:40 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id h1so4561336edj.1;
        Thu, 24 Mar 2022 00:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X5MxsJIW13g5Ml9bzDstsPAf9bJYg5y1K0yw/cJ/HtA=;
        b=nmr9Nrffg3IcY4vnc/LUHjidEioGBcyiEkVcUZTI2iRw52NBR7RDNnCWACvriKGfrS
         WDRHp3Hrvkm5RQU6aPoFD4xCdQtrKcstglJzITSX2P7drrcPDPxshMZ9XPX4GcleSR0U
         YZlB2eodrzAQDK5GyZuELnbkj87DTb/ZOgWkdeBEEO+Nlg4ew6ZTpE2OfzmAE13Itpxx
         JbZt0fozY2UJw0KbMz1y6hFp98c+dYMR8tGkKgCmLYhkv0BqP5zlWctI/+wRKNy5qyhr
         pUVXHPqibHt8z3aKJhWxG4QjS79nECddHc8R9lSar1JWyRptX1EVmQn9Gl0vf0+ipvA0
         pbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X5MxsJIW13g5Ml9bzDstsPAf9bJYg5y1K0yw/cJ/HtA=;
        b=BaUJo+P2QxxCLZh+HKZsL91hZHQxvYVbRJu9WaGgvD5+42orRNESyBTZiatSXOhhSC
         FKZcoYLqKPYwhatSogkOpoJxiSM3+2n/27Qx8N5ePfbDukreIsR3jcUsigoq9S6tAmW8
         X7gss1Gnw2L7iqJ8E8Q1mAmbhDfoJZDWsCf3ldZqrFN9FNlB/Ann0uRBx8hkCeMBhiQH
         dlO1IsfSMkxLE+iR0dAgATjnDuyy//ZIxjej+YtiOOx+O5nGpe585kFnTDyqVPLOwq0q
         BH/x1yxSwpwfkcs6VKoz4vmocM6iDsfsWBKe7RA1OYh06cHwaJd2WCkQutDHyqlv18Fv
         QDTg==
X-Gm-Message-State: AOAM531mM0fX977n7TeVsKsXk/hiUdPQIkzeV1LQbwdjR2bzobnLFYS2
        xh+w8Zz+UciZYarOtY+OFHs=
X-Google-Smtp-Source: ABdhPJz1JVVypceHMCiXC+9mOe+zt1tZ98RJh0mruVQ/aIxglEhWnPNRu4ZuYQ8wsAKa3XSIKFu/iQ==
X-Received: by 2002:a05:6402:9:b0:419:3c6e:b0d5 with SMTP id d9-20020a056402000900b004193c6eb0d5mr4993260edu.216.1648106319041;
        Thu, 24 Mar 2022 00:18:39 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id qb24-20020a1709077e9800b006e029bd4c24sm761408ejc.193.2022.03.24.00.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 00:18:38 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Viresh Kumar <vireshk@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH] opp: replace usage of found with dedicated list iterator variable
Date:   Thu, 24 Mar 2022 08:18:15 +0100
Message-Id: <20220324071815.61405-1-jakobkoschel@gmail.com>
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
 drivers/opp/core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 3057beabd370..2dc3755a4f36 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1461,9 +1461,8 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_put);
  */
 void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 {
-	struct dev_pm_opp *opp;
+	struct dev_pm_opp *opp = NULL, *iter;
 	struct opp_table *opp_table;
-	bool found = false;
 
 	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table))
@@ -1471,16 +1470,16 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 
 	mutex_lock(&opp_table->lock);
 
-	list_for_each_entry(opp, &opp_table->opp_list, node) {
-		if (opp->rate == freq) {
-			found = true;
+	list_for_each_entry(iter, &opp_table->opp_list, node) {
+		if (iter->rate == freq) {
+			opp = iter;
 			break;
 		}
 	}
 
 	mutex_unlock(&opp_table->lock);
 
-	if (found) {
+	if (opp) {
 		dev_pm_opp_put(opp);
 
 		/* Drop the reference taken by dev_pm_opp_add() */

base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
2.25.1

