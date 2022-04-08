Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2BF4F9065
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiDHILO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiDHILL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:11:11 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A165831DF1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 01:09:08 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 32so5026081pgl.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 01:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=uFufKq3ZAua0ubtYySbS47k42rwFOFYZ3iWJzF+8H7Y=;
        b=gWJQYtxKdz/QVHSGQFcGZyYnCZZxKuOiMyTgRLhMj0Q7qH0r9EFYptL2TW8ms/YlYL
         wcnoOjC0yJeayuBp/ic4BOmFT1qklw3saNbwuIXQoFIZtKDilNZZWuTtgvuU3X05GO1R
         DjqLB+IDsAfeF0ZoRbTja9DcThG9oUqFH4AvSooJclV7pex2i76g4wdj5R4Zn93/GLk6
         XuJvOxyKEc+aZuLrwiQKyKA2xlb3vXRxeQfJ6p9exOXbiYYCjMt07FfpgxlshxsVsmWC
         tJkpzonQCZ0WougTLcpER8Zw+la7LczbJHJ5TNY8fC7j2BYR64kXBubmlnlwO3pcYRX4
         Ktag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=uFufKq3ZAua0ubtYySbS47k42rwFOFYZ3iWJzF+8H7Y=;
        b=XgoVLpO6A2oskQ7p7VL1xn4mbYRfYURZgvNgudAqOu66lr5RMQm7kPYl19y84dqdur
         wJZ74XoW8Fyr0VnzLsk08VFrvbgeOt+xi5fl6RwGeO9hfg8AMfKU7QSAcF36eD0p0zIQ
         XQxvq82CuZVTfLBkz5csnlaHda0uY8uGINKn2DjxeEGsDXI32G/0Xbu0d/HVosDXKcKp
         zdsyoR35k6ZiXGAFFbvPAAlFtAr8sVOjBkASgsVIsZIPEp/RMVdRtyL0gMhayG9+kOoa
         ioVjS6vtyMXMccHXfma9yJbXV4Od0adJgfcJe8+oJRYRkRxgtRATPwQz9suauelEhKJg
         bSGQ==
X-Gm-Message-State: AOAM5330mIGhjVUWmNcd/miRdWULXgrHSXqIFvCoc3JCeKtAuqmDP2uR
        /MbJ/fTYN9WVShSYpPuLO72VyTDziq427arqk4Y=
X-Google-Smtp-Source: ABdhPJwqnCI/oqT7S3pXNLbBhhg0y+C/EC7zvjCGtu4zXywCugY76GPfCIpddxp93mxyBGrO97V2hw==
X-Received: by 2002:a63:78c3:0:b0:398:2d6d:c275 with SMTP id t186-20020a6378c3000000b003982d6dc275mr14510063pgc.565.1649405347942;
        Fri, 08 Apr 2022 01:09:07 -0700 (PDT)
Received: from localhost ([118.33.58.238])
        by smtp.gmail.com with ESMTPSA id d4-20020a17090ad3c400b001c65ba76911sm11032588pjw.3.2022.04.08.01.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 01:09:07 -0700 (PDT)
Date:   Fri, 8 Apr 2022 17:09:05 +0900
From:   Paran Lee <p4ranlee@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Craig Gallek <kraig@google.com>,
        Austin Kim <austindh.kim@gmail.com>
Subject: [PATCH] genirq: Refactor actions_show loop block using a common
 macro to go through the actions list
Message-ID: <20220408080905.GA23489@DESKTOP-S4LJL03.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have a macro defined in our IRQ subsystem internal functions to traverse the list of actions, how about refactoring this loop?
- genirq: Use a common macro to go through the actions list (f944b5a7aff05a244a6c8cac297819af09a199e4)

Signed-off-by: Paran Lee <p4ranlee@gmail.com>
---
 kernel/irq/irqdesc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 939d21cd55c3..34a0cefff712 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -246,12 +246,12 @@ static ssize_t actions_show(struct kobject *kobj,
 			    struct kobj_attribute *attr, char *buf)
 {
 	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
-	struct irqaction *action;
+	struct irqaction *action = NULL;
 	ssize_t ret = 0;
 	char *p = "";
 
 	raw_spin_lock_irq(&desc->lock);
-	for (action = desc->action; action != NULL; action = action->next) {
+	for_each_action_of_desc(desc, action) {
 		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
 				 p, action->name);
 		p = ",";
-- 
2.25.1

