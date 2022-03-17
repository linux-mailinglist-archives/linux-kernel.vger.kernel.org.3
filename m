Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098C54DD140
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 00:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiCQXsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 19:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiCQXsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 19:48:07 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA2226133B;
        Thu, 17 Mar 2022 16:46:49 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r10so9607132wrp.3;
        Thu, 17 Mar 2022 16:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=44jSVu9ViGX65V2KV4sJoKN91g8S2sbZ550L2N5DUJ4=;
        b=l/0VWzdsq+0tapKmp9GM2+I2R4GUGVKdkGWYWuAwvHzKLPI3p5TshglsScGVDa6NFW
         DaUSL0XENlAwNhjU9nCyUGZAAKbuLTE5fPZkTuqREBsP1ImFELxbCE3lmp3Tj4nI/jZy
         9MwmBjSZpXSmwI4DVJZDYjtVulXynQRqIUs3I7K0QsW9YAidOZSK0Tv9Ac8x3k42NYBa
         rI6tO6VGSjlkuhdZoQ0C6BU3ba7i/97qKi1VIMAusTrJVubzZfr5sUa8Dru53eP9ebuz
         wQGxh7PiQr4lqSAjy9LGqm91YM5rAGN3LoMMnC2WtFXix6zXjBdx0Wr+n4qempHJNmVk
         hZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=44jSVu9ViGX65V2KV4sJoKN91g8S2sbZ550L2N5DUJ4=;
        b=sPUOJTii9xSjQLTLtiE9pAUEoyRZQ97p9muRYglQ8XeP08eSzXK+xguUdunXn0d7WS
         wVpb8MrYYI+0t75LPg1n+CtVhWjapuI9RQSkFske7aIIRvBsUNPwviB8wVBSD8ppXr+1
         rOMoFfV9wCA7CuEHjwAtVOClA4K5EGYlkgb+qpWWqSH7NY3Do9olkGBqI5DgyNBrpn94
         L8ASrm77fkUD7j4pyCEg8BCe27j+7/pA8vzYasdRCeBwuEndc5JvLqztBoD2u/OfvXtz
         JIw+rGwLfXl6d4BXPC7gYH920dFy5UMh8dFAeBJ/1ZR/tQoOtYRP37mohKxm2SoTOzXA
         R/kg==
X-Gm-Message-State: AOAM533QnNUUji0luwbIBmqt0dLmZ8/kWiHDtEizzgV7z3a8Lr0MKx2m
        cUDK0wkJNEdEa8kRwzXm+oY=
X-Google-Smtp-Source: ABdhPJxdH/WN2xf224PSCmdD+V5oRw0iLxFKpaeNeTNgCZ9Kx3jYO0+gAPl3kcA/9A7EbQbNAzpyng==
X-Received: by 2002:adf:efd2:0:b0:203:db42:c56c with SMTP id i18-20020adfefd2000000b00203db42c56cmr5842974wrp.698.1647560808002;
        Thu, 17 Mar 2022 16:46:48 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id v5-20020adfe4c5000000b001edc1e5053esm4860565wrm.82.2022.03.17.16.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 16:46:47 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] xen-blkback: remove redundant assignment to variable i
Date:   Thu, 17 Mar 2022 23:46:46 +0000
Message-Id: <20220317234646.78158-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Variable i is being assigned a value that is never read, it is being
re-assigned later in a for-loop. The assignment is redundant and can
be removed.

Cleans up clang scan build warning:
drivers/block/xen-blkback/blkback.c:934:14: warning: Although the value
stored to 'i' is used in the enclosing expression, the value is never
actually read from 'i' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/block/xen-blkback/blkback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index d1e26461a64e..de42458195bc 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -931,7 +931,7 @@ static int xen_blkbk_parse_indirect(struct blkif_request *req,
 	if (rc)
 		goto unmap;
 
-	for (n = 0, i = 0; n < nseg; n++) {
+	for (n = 0; n < nseg; n++) {
 		uint8_t first_sect, last_sect;
 
 		if ((n % SEGS_PER_INDIRECT_FRAME) == 0) {
-- 
2.35.1

