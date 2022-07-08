Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C61256BF2F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238820AbiGHQty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238099AbiGHQtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:49:52 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748B124964
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 09:49:51 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id o4so31319207wrh.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 09:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xpYvopWRDye1t/WPhr4FZs4vO+X9s+WDCsuSJIPNESw=;
        b=WNli1ysfgn5wKLkAfGWIaJTBAb2A0tDwa/HWFDA5ky1HT4sAhOAeKoSDCDDQdR0cbp
         ZZCy30UFwFJB8DgYofwVJcOIpBjs9BQfw+FI5h0dFfn32S9KyD79G1UpMgqsBKIwFZyM
         rHfwWRfjD5PjzCv3xEIc/RoLyJYPqCXjN35cCF+TQL/QQRyTBKNcCc4bBTqCwBNhjvqb
         XpjRl9g4+ytg+wW+NfmItvB/lkKBGfcoi/GL/2Q+TVUktKh2HnqOkrfhC2ryiM+9c4ux
         6ty0PoV1W+8QxiMm8d0UqesxyrE+VB/75rpt6eEk5Jf2rRlg2vIg5nrtJVejVpJy290t
         dUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xpYvopWRDye1t/WPhr4FZs4vO+X9s+WDCsuSJIPNESw=;
        b=3+n3zLuRzk+kUBwKsGeQZ/7g2Y9JfVyjioGAjkwCxrmzo8tFYTxWjcVXPm+/pbDwr8
         5X9GqYM09ElWKsKjqzPt/51Dkyg7u7wZ63pby2YWjvwjVTufAWAiOg9AfHL1LtX7W+f2
         LemsXtaB5QAOHPu19xCHqUlY88sJu52G7aMGG7AJLE+BYXY0g5dz++yGHEmX8TKrcHDV
         sHz13vCF3NQPOi4S0VOuew5O0cpOqp1EcrCT05VbXr+bPnE3Zt78jcDuxtHvdy4W2Aak
         zrKBXgEnP5oV+jDwYdBlhXqm+P4lj6vApsNIH6WcEYsQJyZn9fJ+R/nsy1TJaff3X8QK
         B9pQ==
X-Gm-Message-State: AJIora+Tmp2c2uwU61lUNr1DGUkB/e/BeUWxKAe7gi4BAR0IJSWQbzuh
        1h8xePcDy7XIY7vvUhwP95dNXg==
X-Google-Smtp-Source: AGRyM1tmsAifgz0ssa4G0nm5T1k8cUa1tdtM3m6GOkSyiG1S4urJX2rMNelVNljOAuONla02M/qFTg==
X-Received: by 2002:a5d:6d07:0:b0:21d:1ee6:16c0 with SMTP id e7-20020a5d6d07000000b0021d1ee616c0mr4186192wrq.63.1657298990092;
        Fri, 08 Jul 2022 09:49:50 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id i8-20020a05600c480800b0039c5a765388sm2472041wmo.28.2022.07.08.09.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 09:49:49 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-i3c@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, alexandre.belloni@bootlin.com,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH] i3c: master; add error print for invalid node
Date:   Fri,  8 Jul 2022 17:49:48 +0100
Message-Id: <20220708164948.268930-1-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show an error if the OF code in the i3c master setup
failed to read the register, so that if an incorrect
node is supplied there is an error print to make it
clear what the problem is

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
 drivers/i3c/master.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 7850287dfe7a..271d687d0d07 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2082,8 +2082,10 @@ static int of_i3c_master_add_dev(struct i3c_master_controller *master,
 		return -EINVAL;
 
 	ret = of_property_read_u32_array(node, "reg", reg, ARRAY_SIZE(reg));
-	if (ret)
+	if (ret) {
+		dev_err(&master->dev, "i3c: invalid reg for %pOF\n", node);
 		return ret;
+	}
 
 	/*
 	 * The manufacturer ID can't be 0. If reg[1] == 0 that means we're
-- 
2.35.1

