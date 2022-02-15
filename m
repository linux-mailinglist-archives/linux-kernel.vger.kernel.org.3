Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C78D4B6DCA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 14:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238384AbiBONlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 08:41:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbiBONlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 08:41:07 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808C46E8F6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 05:40:57 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id z16so13040426pfh.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 05:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EB2YtpGsw2UK9GF+IclDWBvYrktnmSxVfjyLOWm4RCc=;
        b=it0+JgR3Tnw+GyF426mx276wP5fEzEVoclG67wjzctxG82ldZreRD6ZHTJSCnCd0tO
         lHlMcY+hx9s6mDdH3NbsXaWbZ+s70Mov0/YuoFhitBlwDZQMwj/V4Zcfzarrii7ZcArN
         UENLvrw2emllj2rPcJYrJw6f+xtBdRvw4wJWI3/WjptkCs0Qi342aPVhaLZGDgHHF4HL
         vqq3edQviKaPo5QLjjN89ksikoNCvh43ocsWXQ3SFAwRA/wXseWIZuOE2Saa0j3bPwlg
         0+q6/R5PmeoNilMQM2a4hp6qRy38cgVFhTTsgyy1nGVOVBCkWIkShE3XLuiB7ft4J0uB
         glMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EB2YtpGsw2UK9GF+IclDWBvYrktnmSxVfjyLOWm4RCc=;
        b=jWC3+8psonS+dTilUTx+7uvypsWz0yzgQYc2m2Bf3AZX7jc0Rq20P1b9Ig0nYR22vL
         u7IvFl6Dh9JpLmh7Bg2U+JiPrcuMV6nuNjSvnpRIdQ2KErPp6w7pAXwlS95DedBNJR2J
         Wr76EIlX+gP3Sy/gTmJlTcoVRRhUCyk43n9cafrikjBXMcxeX7kg4TKAibmC96VvSzys
         CFjtCVISKcijhW4UA10VNRAyF39UUzA+HwW5F4lMArBbB03Qp0XQK8PU5tw7MKpRFm/c
         ghO7Cp8wKOOQdpszLLLuKUOTj8Fdpgg7nzPtmOWpnPndJYmP9YMjrAy0fibnT0m8kglK
         fLHw==
X-Gm-Message-State: AOAM531h6LBlZgEqCyo5UHpRGWJ0/G49KLGUEZCR5RFa7KPkWpLxNvVb
        wZfgpMhXHmjCEjYDwiuj+m4E5dGvjxSWLrED
X-Google-Smtp-Source: ABdhPJwaJokt/EyUIDr4+WZi2lfdxC+jjQdisKRR2/ugx3If+XicBfuCADVDXTE92U6fTbSmXyIyMw==
X-Received: by 2002:a63:5550:: with SMTP id f16mr3660189pgm.24.1644932456904;
        Tue, 15 Feb 2022 05:40:56 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id z14sm36034055pfh.173.2022.02.15.05.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 05:40:56 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] tools/vm/page_owner: filter out pid and timestamp
Date:   Tue, 15 Feb 2022 21:40:45 +0800
Message-Id: <20220215134045.12004-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9cc7e96aa846 ("mm/page_owner: record timestamp and pid") introduces
timestamp and pid for page owner.  However, it is hard to aggregate the
stack since those are specific (especially timestamp).  Filter out those
information when aggregating.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 tools/vm/page_owner_sort.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/vm/page_owner_sort.c b/tools/vm/page_owner_sort.c
index 9ebb84a9c731..fc231749e0a9 100644
--- a/tools/vm/page_owner_sort.c
+++ b/tools/vm/page_owner_sort.c
@@ -45,6 +45,12 @@ int read_block(char *buf, int buf_size, FILE *fin)
 			return curr - buf;
 		if (!strncmp(curr, "PFN", 3))
 			continue;
+		if (!strncmp(curr, "Page allocated via order", 24)) {
+			char *end = strstr(curr, ", pid ");
+
+			if (end)
+				memcpy(end, "\n", 2);
+		}
 		curr += strlen(curr);
 	}
 
-- 
2.11.0

