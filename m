Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8635E537620
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbiE3H5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbiE3Hyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:54:32 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC4E74DC4
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:54:30 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u3so13460195wrg.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3kcYg8SvftZ4Pv8K6+My0zsHrpG5RiRd2GgL3qZs2gI=;
        b=oOHy+1wa0Y1QWiyS+VCO8OYEDSfeb4P6rKwugYGCN7bpah1DiWveZ7BFpagsJ7/B5p
         OFcsrtoRriPmcS4y0Xfdrn28EYWxIU5YJq872nY+HwsO1qmuE/QtQjFI64s2uIjoTiEj
         0peNA3xx6oibsD+QlQydo71XbCH7+zX6x8zZ72Djnya0nWIeZyRmhSIZtC/AbU2/DAbZ
         05Ycpn6SQdheX229ZnQMYOcTXVVZNOTHXRjJXt6IJVLIh6Fl+CdQFhb92g0QWIJRnvF8
         K3t02JPLJ6733jL3PdmtIoU//SZXX8NcRJOXrPll3iUMbHyRhB3j/DEivj0AZzZURgyx
         feRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3kcYg8SvftZ4Pv8K6+My0zsHrpG5RiRd2GgL3qZs2gI=;
        b=MPOKJpvvogQz/5rA9I7uyL5I9DN4Z/lWRe1Rp01TF4yXdboPAOg9qcrD+vDrBP4L+K
         NxtcqWE7B9bGqBaYqgGfu5ObsnLHXXGoNj3lEfX+1FjFHaEjQU6Qbam4AKnmO/jN82GN
         WQrGquG8K9ZoojfqA66DB/oq1jNGkPFay6uLf9Drn4zAftEEQMTJ+8vjZ9nXGnawb5av
         1rTzkWV6R/DDBDBvifN6T2ouzPwcxQXwqtb5moTgJlQfWxUOQHONRtJkn47/R7A2cTQG
         3CIrilZamUa/5pRlH+oZ64OEy+QPX3cXTvWapjxOPt8+hFv12fkU69/NDrCLJN9Njjnb
         YUrA==
X-Gm-Message-State: AOAM533bHAiDWA2KfZ5K3BWkSu/G1vtnL3MK7hfVg7iqDe7Ggn/c1pmW
        acEVgxE7HLEWmN2jc0YsY5bl0f3GLvhM8QoL
X-Google-Smtp-Source: ABdhPJw6xnN8Iy6RqczuscjkcuqNxwqXuNH9d2cQ78QPMlE0uD4bsefwpWemYj8HuHLpLpqQB6LkUg==
X-Received: by 2002:a05:6000:2cf:b0:20d:c9f:63d0 with SMTP id o15-20020a05600002cf00b0020d0c9f63d0mr46629276wry.45.1653897269034;
        Mon, 30 May 2022 00:54:29 -0700 (PDT)
Received: from ownia.. ([103.105.48.166])
        by smtp.gmail.com with ESMTPSA id n21-20020a05600c3b9500b003974860e15esm10578642wms.40.2022.05.30.00.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 00:54:28 -0700 (PDT)
From:   Weizhao Ouyang <o451686892@gmail.com>
To:     Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Weizhao Ouyang <o451686892@gmail.com>
Subject: [PATCH] erofs: fix 'backmost' member of z_erofs_decompress_frontend
Date:   Mon, 30 May 2022 15:51:14 +0800
Message-Id: <20220530075114.918874-1-o451686892@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize 'backmost' to true in DECOMPRESS_FRONTEND_INIT.

Fixes: 5c6dcc57e2e5 ("erofs: get rid of `struct z_erofs_collector'")
Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
---
 fs/erofs/zdata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 95efc127b2ba..94d2cb970644 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -214,7 +214,7 @@ struct z_erofs_decompress_frontend {
 
 #define DECOMPRESS_FRONTEND_INIT(__i) { \
 	.inode = __i, .owned_head = Z_EROFS_PCLUSTER_TAIL, \
-	.mode = COLLECT_PRIMARY_FOLLOWED }
+	.mode = COLLECT_PRIMARY_FOLLOWED, .backmost = true }
 
 static struct page *z_pagemap_global[Z_EROFS_VMAP_GLOBAL_PAGES];
 static DEFINE_MUTEX(z_pagemap_global_lock);
-- 
2.34.1

