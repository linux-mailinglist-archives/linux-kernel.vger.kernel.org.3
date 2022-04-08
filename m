Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0164F9460
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 13:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbiDHLoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 07:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbiDHLn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:43:58 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46664185031
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 04:41:55 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id f10so7630914plr.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 04:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=wNWEcSrKlxJuH4GZJyDl7c4LCfxhxQo771KnU/vvIE4=;
        b=mJx4btV80XGeJpkYkKhUPa+zAaEkD5oe/5qBgfaYaZ58esY9JlS4mqBWm1igbZBRvf
         O5ptWnbbEBMCjE5NSXWDg3yOdsRfcibc7BpN+zMLn+eed66o7kqm7sAj9HxwOEkVl5rJ
         GR7HKJ2JAIWNbdEG7zd1r/tw+P2utwWyCdM6d2lUqJdlCIdCxjGWgMyfWJ0Cr20d80q9
         XdCpAXIfOYTdlHqpxwxxr4p/4ma9roQm4LaYD4/olmciglNduNYoSPbPfFtBvKk/5wO3
         9kvLx5R+/La416VYS9EhezUzJi7msyTSbe+9AFd+ujBFp1oeHZQS4d1bo0NMMllnzDdR
         CE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=wNWEcSrKlxJuH4GZJyDl7c4LCfxhxQo771KnU/vvIE4=;
        b=U8PLYZPEeQNeNrcXlpDcTmRPjLK+K4vTEgteXZn/cin6JNc6nLfSN4TRGl37filgU6
         nl3I+7wCrDHHvUjRWwvdKtAl39gxq/Bw4Oq0ZIiFwM6zdjtgqpPs5/2hKleS4n+NHKPj
         wQ/R3ej/nzdvfEKakOx9Zyg40svkv1cIRYRugrrsb+Q3nJXG8GSnCqJqQ3bPDiIRmiMq
         rGqiGNthJVoQOxLvPAnTNSeh6kGSvkK6zVs0nw4cDMjcgVOMjU8w0/vx03JVzGI/5KfA
         n73YrwY+IJdeCKFWNVhWERab9f1AYqukYc+CRSQQ/L74chWnjTQIz3L8TeBvyhhVONaI
         GGNw==
X-Gm-Message-State: AOAM5300Fb9SGmzUN8HyOrgBDYX6QVtVtaPzV5IC+XyAQsYcjRRnaYb2
        YuV2tU7j2lSyevhUejAGqVk=
X-Google-Smtp-Source: ABdhPJywka83yA8lsztjbSp6Yr3cIT2QDO2ZRxvveG6rRgyBhgVMK3Giwndh8fOiFQey1YiNaG13Cw==
X-Received: by 2002:a17:90b:1e47:b0:1c6:d5a9:b147 with SMTP id pi7-20020a17090b1e4700b001c6d5a9b147mr21204158pjb.223.1649418114706;
        Fri, 08 Apr 2022 04:41:54 -0700 (PDT)
Received: from localhost ([118.33.58.238])
        by smtp.gmail.com with ESMTPSA id 8-20020a056a00070800b004e14ae3e8d7sm24425953pfl.164.2022.04.08.04.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 04:41:54 -0700 (PDT)
Date:   Fri, 8 Apr 2022 20:41:53 +0900
From:   Paran Lee <p4ranlee@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Craig Gallek <kraig@google.com>,
        Austin Kim <austindh.kim@gmail.com>
Subject: [PATCH] genirq: Refactor actions_show loop block using a common
 macro to go through the actions list
Message-ID: <20220408114153.GA1955@DESKTOP-S4LJL03.localdomain>
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

Hello, I am Paran Lee.

Since we have a macro defined in our IRQ subsystem internal functions to
traverse the list of actions, how about refactoring this loop?

- genirq: Use a common macro to go through the actions list
(f944b5a7aff05a244a6c8cac297819af09a199e4)

have a good day!
Paran Lee.

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

