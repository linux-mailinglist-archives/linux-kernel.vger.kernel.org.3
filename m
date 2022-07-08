Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4016956BF72
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238223AbiGHRGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 13:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbiGHRGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 13:06:00 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A4D5C9F8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 10:05:59 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id z12so21757530wrq.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 10:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bt+4nv2sa8rIkkr4HRdL5sYHgKzM1uGantvwYECVYmU=;
        b=FTJHfZBe1EnZtdYr0Cx5m+8NDBd/EQh77Kd/04oV1qWBTeNY9t1V3zeOL+nB1AluxK
         eUV13zDJe2F9OT7aGpieJfbffoYRas4dzkfe+3SWQnwR1MTuM3lf3hd32hc1Oh36P/pS
         IVLScqH9z+P568TmULtxJ8bC8QI4sEKU2yFcC810q8WDrERDHbZCYRVSnBrts1dlUBoe
         9EU7nB8TG3LS6MCRmJx6LuX4BSAZAc3U3AMPl3eItGuoWEnTmyf4uLnbuYIKJgtpfQc4
         Nw6hIkXbxtWGjey0HmaoJ++P+LkaMQJFsxFL9Ma2uxFASL7RH+ldpBfI+u676CU3lAlM
         QgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bt+4nv2sa8rIkkr4HRdL5sYHgKzM1uGantvwYECVYmU=;
        b=swyRoJYtzoyNWkJOyXB89NGsGK6xWMDCEY82eK4XCPbUpaRTi5P1a4g+D9pMJX4vUq
         FlKO9p7VYPDCKuRGVrQGuXm/Y6oBKe6Dos1Jg0cZUCtZji5iqqS/H0ND4fkYs7uMGNro
         vU+KpcsKOz0czWLv/uP6m1nZ4DXHCSkgc33YW55f/xTdMFu45AC5kUxhKY121CwKkNl/
         xB7O+3FKy3CcFKxynfLlOKhj9s5tQmejEPjQbNnIP6AK8rW8VnLvw5AtbOL3cmp9cjI/
         mPuN+kR9nJcbxYyg4SeX5pN6Iaao+AHKi0gVJ6czK2pn9n4/tvF0Bor7Oa9q7YMOjm8H
         hJnQ==
X-Gm-Message-State: AJIora+I0SDEVPCtpSnlhZZxWQJ+nDi7B08hD2FmqT0KBNYz+xSDrYSc
        ZOoOkAsajLYvfaT/ikJq/2aECCMQeJa+mWFn
X-Google-Smtp-Source: AGRyM1tDvDSp/h7Ofxro79wnACQWKUMULF6t9Z4GTWxRVRjMVcAXz9P9hakHGsqz+8LIZ8CaUhMgeg==
X-Received: by 2002:a5d:5983:0:b0:21b:b7cb:f84e with SMTP id n3-20020a5d5983000000b0021bb7cbf84emr4339164wri.654.1657299957747;
        Fri, 08 Jul 2022 10:05:57 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id j2-20020a5d4522000000b0021d6ac977fasm13717078wra.69.2022.07.08.10.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 10:05:57 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH] devres: show which resource was invalid
Date:   Fri,  8 Jul 2022 18:05:54 +0100
Message-Id: <20220708170554.270405-1-ben.dooks@sifive.com>
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

If we do find a resouce that's not valid, print it to aid
identifying the issue.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
 lib/devres.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/devres.c b/lib/devres.c
index 14664bbb4875..df5ed06908f0 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -143,7 +143,7 @@ __devm_ioremap_resource(struct device *dev, const struct resource *res,
 	BUG_ON(!dev);
 
 	if (!res || resource_type(res) != IORESOURCE_MEM) {
-		dev_err(dev, "invalid resource\n");
+		dev_err(dev, "invalid resource (%pR)\n", res);
 		return IOMEM_ERR_PTR(-EINVAL);
 	}
 
-- 
2.35.1

