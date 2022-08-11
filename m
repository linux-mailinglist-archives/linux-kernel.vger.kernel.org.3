Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC3158F878
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 09:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbiHKHlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 03:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbiHKHlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:41:13 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83885883C7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 00:41:12 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id gj1so17028486pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 00:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=6An2Bm+HRPw2jUsWUGxg/yl4JgWAUg6zKT2TE/IRa6U=;
        b=Mgt2J/+MHwKThQVs4oQVlJ8IJylX4tgDxpCXs30fmcHRr9HtTapNkMYFGxVkdgvhVo
         8rzvRirxvqXUlreSEsyVs9eOBBBF6F2c7aaqG7KPcTnfDa/YhrOCBBpUa/cr8fW8VMNZ
         MWcxXWtf3+HoplgGjV6d8U4blhDqYMAK+Zrf9zS0OR4HDccctwXbvBd86SW2Af6ZyVFN
         Gu4lo+Bj8/zCuIsdtu+5a7BZN+WkXNtoPQDnGyEjwObfKVMdLJabr032AFkBOEWd+tVa
         CzQh2WChZsbW9CC5sDm93Fls26AXVlfi2gn5xYmAPZRyDJ9DNapUnt+1eCsiRi0xV1wl
         NHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=6An2Bm+HRPw2jUsWUGxg/yl4JgWAUg6zKT2TE/IRa6U=;
        b=Lv+68ADwXzC0cc2T5kT3UiBvfhUV7Ry1sboRKGiJHnkYdpK5Nm8j7qyZjs98ASw3ir
         /dRU4OLOYav1G33yYM6pDYXsrvoQEKZW4lheU+n+LF4JKv6/3CmEiJQik6+g99zoKH4S
         /fJaHEzuk0Yj7QaULSU6LM3UR82fVZASPxwqza1aEAIyRs3FAxS4jGhxhxH4fGfkDIq5
         A4BsnDykNzqQYwe2+m5YLCzDXbpS7lmeda3adHnWGxFIfdlDwJUyA837qT35ZJ+kQJpd
         bAooLaFFdSr7+cOfw0BkrvdG6uLiDZhp91Amb9EqlbHgBW6h27b+Ly90CVow4v7r6l7V
         cAEw==
X-Gm-Message-State: ACgBeo0rKsuvpEeuxgCLAxlk0vsblpzAUmptubs0dCvy3P/GP4Hxf2FY
        n1yoWVYzXXUpsEGRfS+eO3A=
X-Google-Smtp-Source: AA6agR7VSlLFYJgVPQvtmdBK/65Cg1unbT4ey6bZY1xdRJuabobdK218dzhUg+yfhId/cXLGQwhY9Q==
X-Received: by 2002:a17:902:cece:b0:16e:ea30:6287 with SMTP id d14-20020a170902cece00b0016eea306287mr31152370plg.104.1660203671995;
        Thu, 11 Aug 2022 00:41:11 -0700 (PDT)
Received: from localhost.localdomain ([101.82.148.241])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902654e00b0016d12adc282sm14207411pln.147.2022.08.11.00.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 00:41:11 -0700 (PDT)
From:   Linjun Bao <meljbao@gmail.com>
Cc:     Linjun Bao <meljbao@gmail.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: add comment for unaligned "fake" nqn
Date:   Thu, 11 Aug 2022 15:40:24 +0800
Message-Id: <20220811074024.4382-1-meljbao@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220810140812.GA24773@lst.de>
References: <20220810140812.GA24773@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current "fake" nqn field is "nqn.2014.08.org.nvmexpress:", it is
not aligned with the canonical version for history reasons.

Signed-off-by: Linjun Bao <meljbao@gmail.com>
---
 drivers/nvme/host/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index af367b22871b..e72021212971 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2704,7 +2704,11 @@ static void nvme_init_subnqn(struct nvme_subsystem *subsys, struct nvme_ctrl *ct
 			dev_warn(ctrl->device, "missing or invalid SUBNQN field.\n");
 	}
 
-	/* Generate a "fake" NQN per Figure 254 in NVMe 1.3 + ECN 001 */
+	/*
+	 * Generate a "fake" NQN per Figure 254 in NVMe 1.3 + ECN 001,
+	 * the NSS field is different from the canonical version 
+	 * "nqn.2014-08.org.nvmexpress:" for historic reasons. 
+	 */
 	off = snprintf(subsys->subnqn, NVMF_NQN_SIZE,
 			"nqn.2014.08.org.nvmexpress:%04x%04x",
 			le16_to_cpu(id->vid), le16_to_cpu(id->ssvid));
-- 
2.25.1

