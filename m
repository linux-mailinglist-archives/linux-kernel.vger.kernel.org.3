Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66814598FB8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 23:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347000AbiHRVk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 17:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344440AbiHRVkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 17:40:53 -0400
Received: from mail-il1-x149.google.com (mail-il1-x149.google.com [IPv6:2607:f8b0:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452AEBD292
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 14:40:53 -0700 (PDT)
Received: by mail-il1-x149.google.com with SMTP id q10-20020a056e020c2a00b002dedb497c7fso1956698ilg.16
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 14:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=ggYZcW/jiHht2+YSvHf2xzH9Vi0hSCfs2RkxdmXJjMU=;
        b=nejJkqLn39bRDQq7wbN19Ph5a2ZdHTa4Sd2es/UeWHwznTnN+IgKm9+hJKcYJK/zsi
         axeEP4d4aVZMHLgZ4TFSrj7qsbSrsiflvI3BmQW1l4+zR08ZElug1lMTRzZoukpt+aZv
         i8NvIdeiRCGOKsEMqlknSUrlH0z+hNn/FfK8WxNE6PKCKd/63862nyp7MlZHD88Bpqqh
         Sw4YQ1L1kfJBczrSy60QlE6wfbHa08MTkkQCQJXbHsogjeBoBf72TGi4aG8BfRzWNrdi
         FPRJrpfuJSLjkxldNomRCjr2nudoKJLyjQFU9/7/PXoI4xqdpvNQtJXhOHuFXu25H/Kr
         peBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=ggYZcW/jiHht2+YSvHf2xzH9Vi0hSCfs2RkxdmXJjMU=;
        b=zFrkU38/o65Op5FzJvGcc6n0iNaYsx0t9ndgeRw0eaMxLBk4MHnmK/cqPdZgmI6qYl
         udYK1WNiqItxHu+jQka091SYmGL0S+MULv4IY9O/LxNZdmy2J2NkfZFKh9Q7u+TefTjh
         sajgL+kkVmVxAMi4o5bpx/IDEAUHp+VgoXqU8ZSsqSOnK4lxq/3RNPuC0YWqXP+aPEpw
         NMAReo0fXHCRSngMqmVXbBTQ2nfEeNWm+rW0nOmnbLavvcxvp3SsCVkZlYKrJ1OCBKrN
         leioZ8c2QdtrwV8E5fPoE6M6+qkw6glq9qto2r/8kWr68ZBFe794UIM6DopzPEdeRehd
         j/sA==
X-Gm-Message-State: ACgBeo1YIPYksTuV8Tudrh/CT8sKxS014VHOA/0gKIXlFUXVvvjlDsaj
        BmtRDw50/HT1YkufOHYLGezUcP6E1UtBfqpP
X-Google-Smtp-Source: AA6agR76jW71LoHot4oYwaCwArah91ZBIVUMk461/DWSHQ4gWA7HioWs5nxJIJHYT6GietUGrPQKS405pFDnBIXR
X-Received: from lalithkraj-spec-glinux.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:b94])
 (user=lalithkraj job=sendgmr) by 2002:a05:6e02:661:b0:2e2:be22:67f0 with SMTP
 id l1-20020a056e02066100b002e2be2267f0mr2327973ilt.91.1660858852679; Thu, 18
 Aug 2022 14:40:52 -0700 (PDT)
Date:   Thu, 18 Aug 2022 21:40:49 +0000
Message-Id: <20220818214049.1519544-1-lalithkraj@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH] ext4: Make ext4_lazyinit_thread freezable.
From:   Lalith Rajendran <lalithkraj@google.com>
To:     tytso@mit.edu, dilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Lalith Rajendran <lalithkraj@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ext4_lazyinit_thread is not set freezable. Hence when the thread calls
try_to_freeze it doesn't freeze during suspend and continues to send
requests to the storage during suspend, resulting in suspend failures.

Signed-off-by: Lalith Rajendran <lalithkraj@google.com>
---
 fs/ext4/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 9a66abcca1a85..d77e0904a1327 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3767,6 +3767,7 @@ static int ext4_lazyinit_thread(void *arg)
 	unsigned long next_wakeup, cur;
 
 	BUG_ON(NULL == eli);
+	set_freezable();
 
 cont_thread:
 	while (true) {
-- 
2.31.0

