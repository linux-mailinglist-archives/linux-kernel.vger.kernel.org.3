Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72505A219A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245015AbiHZHTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244483AbiHZHTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:19:11 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5750D2E84
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 00:19:10 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id z187so761129pfb.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 00:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=mujhyhflTSHBMZ6M+FlaiVGD/9sUOC8oxd5fz31ysDM=;
        b=nXbk6Xa7ljhTr+XpcTgwjQLVifDZi0r6YmywVy2E4uN9ZB2LuLIiQL0eMft4U10UMd
         VbVbC6HHGhcH8eCpRAnr/5ZWniwrMVVfNA3tV1c7zOZNiNuhbrGxwmU/O3Og/wiYd9kt
         WnyWu8uPsy/3JvJ5u3H+msCNzJa7C1q4wPMVRsnCk5XjFBNkLUQ8BUo5zVZ7t+eKxGmf
         ltWJ7iH06DYKcIp20W4nXFi4yaSKdfk7x8yUcYZdWESvwFqdqALooDpT5IXXjQTgn491
         eORND/IHqkZ96MZ3+I+oAsSxcivltlNcgvLq1pqcDaHlxFmUgjled49zRPjR53+YIQhF
         nyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=mujhyhflTSHBMZ6M+FlaiVGD/9sUOC8oxd5fz31ysDM=;
        b=kVG26dkx3VmXRQNJWVqF6CbCsp5/1F28a1DPS0hCPQ7aedNua/4QCs0UXjkn/Bine3
         QnF+luiUkR0QaqgZLBwH+1/fO6Uz57AUqXstTGULSCiTvDoXw0psEYQkhun2v3pnhtIE
         qzWOPG+nbUH1kye7/zfJycMVAZ9gU1Relj0M8c8mN9OSAqTTCtMzu1MlG+0UfztuqXsX
         zkDzz+PF5x9rhv6YwP6juiCdGvmrnA9nUvRFmd3Bkqeg5gWIDmWia+mdGrXQgVBvgsUu
         qeqCaexD06Lf1tDN4iOli2aCoNDG11F2pTzaspfxE9VFKVE/QzSllAdmg0z8uvBG3Gvb
         oHAA==
X-Gm-Message-State: ACgBeo3vGBILa8p0mk6282Pcf6ZPciRXbRec1R5yvRxM66RUFX3L2dyG
        R15s+MOEpr5HNxn3r6DatDqWDYao0ac=
X-Google-Smtp-Source: AA6agR5hspO+joqEkdhIjD3vEkFNquPzvu/3aHDWt6Zr3KBQv/hUgo8ISs+7yCwTe8npD/1YfGbf8g==
X-Received: by 2002:a05:6a00:ad1:b0:530:2cb7:84de with SMTP id c17-20020a056a000ad100b005302cb784demr2728749pfl.3.1661498350189;
        Fri, 26 Aug 2022 00:19:10 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id z14-20020a1709027e8e00b00172f0184b54sm773002pla.156.2022.08.26.00.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 00:19:09 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] mm: backing-dev: Remove the unneeded result variable
Date:   Fri, 26 Aug 2022 07:19:06 +0000
Message-Id: <20220826071906.252419-1-ye.xingchen@zte.com.cn>
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value cgwb_bdi_init() directly instead of storing it in another
 redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 mm/backing-dev.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 95550b8fa7fe..e1e6f293a0cd 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -776,8 +776,6 @@ static void cgwb_remove_from_bdi_list(struct bdi_writeback *wb)
 
 int bdi_init(struct backing_dev_info *bdi)
 {
-	int ret;
-
 	bdi->dev = NULL;
 
 	kref_init(&bdi->refcnt);
@@ -788,9 +786,7 @@ int bdi_init(struct backing_dev_info *bdi)
 	INIT_LIST_HEAD(&bdi->wb_list);
 	init_waitqueue_head(&bdi->wb_waitq);
 
-	ret = cgwb_bdi_init(bdi);
-
-	return ret;
+	return cgwb_bdi_init(bdi);
 }
 
 struct backing_dev_info *bdi_alloc(int node_id)
-- 
2.25.1
