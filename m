Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAF958D795
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 12:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbiHIKt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 06:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbiHIKty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 06:49:54 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D06120A3
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 03:49:52 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id bb16so13330458oib.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 03:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wc4pc4XjzEcCEnj/rsl5k2xYOk9EdSwkRXBZHUsSZMk=;
        b=cNv9ey+nvgOoNPDu3fYAV530sBBW3pHAx4VkhkoMEqb4HXlxJJhwrYW2fhuoGEabOq
         GwEcSrUH8Ssfa8En8W/sqL4jkAziGYFUMu3Yw2lI2ohYSQLlk3XHeKcFDHqsmLfTOUT/
         MH+Xe1J4clCsuVxQnnKV9K1h8Tkqo9fsIuazgNSZWzSg2dgNzDpGt92vAOxeuWDRKwnA
         wUyMfb0rBy59VQx2S519n5z1HVIA+2+XlJyLAsM69t+G4iqI5j6o+SEM91l9SNcJEBcG
         6R70Z2EaXlFGVWFJrhsEKuHagQ8lmBHYM7LgfmSictkfHCyM3CGVM67k7qTcgRDM3qEe
         eP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wc4pc4XjzEcCEnj/rsl5k2xYOk9EdSwkRXBZHUsSZMk=;
        b=DffQGGn/vPm94zu+G9ufj1HFPa0DE4f3px5vUXBldVuvC9jsAMpr48ur4xqXyhltdy
         KBv74HCEKwzFVAUloDml3MI8xfgRumbHfOmFXxeK5O41D0+AB+9bifAhAgTBKvOCqXqN
         JNEt/uVuqOuC+yhfoMK9OrgB+zWfoTVvQ6d+ASQb6SkULXzP5aTF7nb6LUE8UKKm4AFY
         Gm+F59jtJbYurTqs6jtE2hXyIFvkpRoFcvFUN/abkUTAsdoaewG0BPFk/HEZDCaf6FFA
         QySYeb60BCOlkuWv1rE8TzHIqjtMIkALsGt6bcV3yGcIHq0gb+rpUzga7Cy3UgSF36da
         +xzg==
X-Gm-Message-State: ACgBeo0dbU5MhVmOEJ1TE5R/MRKMWmBgMwfkdgTIK49qawYNfLJf8Y9v
        yX70/YpTOnr3sauab6Nw8KzA1/7WiP/KbwwK
X-Google-Smtp-Source: AA6agR4PYo3SWTvvtd2qU1lQNNRTyI1XAdbmd19eqOVySGmVsFyA0jsDNS8hDoQ6wKTbK/2nUV0IEA==
X-Received: by 2002:a17:90b:4b4d:b0:1f5:164f:f7c4 with SMTP id mi13-20020a17090b4b4d00b001f5164ff7c4mr34144617pjb.131.1660042181117;
        Tue, 09 Aug 2022 03:49:41 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id b11-20020a62a10b000000b0052def2e20dasm10270377pff.167.2022.08.09.03.49.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Aug 2022 03:49:40 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH] mm/mempolicy: fix lock contention on mems_allowed
Date:   Tue,  9 Aug 2022 18:49:27 +0800
Message-Id: <20220809104927.44366-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mems_allowed field can be modified by other tasks, so it
isn't safe to access it with alloc_lock unlocked even in the
current process context.

Fixes: 78b132e9bae9 ("mm/mempolicy: remove or narrow the lock on current")
Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 mm/mempolicy.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d39b01fd52fe..ae422e44affb 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -855,12 +855,14 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
 		goto out;
 	}
 
+	task_lock(current);
 	ret = mpol_set_nodemask(new, nodes, scratch);
 	if (ret) {
+		task_unlock(current);
 		mpol_put(new);
 		goto out;
 	}
-	task_lock(current);
+
 	old = current->mempolicy;
 	current->mempolicy = new;
 	if (new && new->mode == MPOL_INTERLEAVE)
@@ -1295,7 +1297,9 @@ static long do_mbind(unsigned long start, unsigned long len,
 		NODEMASK_SCRATCH(scratch);
 		if (scratch) {
 			mmap_write_lock(mm);
+			task_lock(current);
 			err = mpol_set_nodemask(new, nmask, scratch);
+			task_unlock(current);
 			if (err)
 				mmap_write_unlock(mm);
 		} else
-- 
2.31.1

