Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713DD5AE0D1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 09:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238843AbiIFHTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 03:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbiIFHTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:19:21 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5CD74377
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 00:19:20 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id fs14so5556050pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 00:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=TM+CdNqSvUJq8RjCWX9SS8uu2mM48Yt8MlhJj2Gs6Ak=;
        b=FeXxDKPOjtUzqkwbv70fTVeIm+5VWurSEWn3UmqxM2xxL2yxAeHRE3vY1mBL31YmfA
         TCn1YnaFmP5nKpZRonMs5iU6m+5BDL6Zn42cPM4n7hdYKnYlPSFmNEAyUUYvzksEsbBM
         iG2H1AWtH5C9awoDq9qxL3qHr8lKGDi5U92yf37UmRHbhQRXOGJ9ZLEd2QUvWUGPwiTy
         f6DRQIjat4h6x78EER0Pz/g+z2z6XLYNlpTJLhbMBOwGF12cINHs6jZa8d7Gel1btnjy
         OAlJ4I7NuBhMOIXKwgTK6+JKdLk20L6gONdVSpEFxm4KlQJUC6WIpH1EhPo6DrrJ6+G3
         Yu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=TM+CdNqSvUJq8RjCWX9SS8uu2mM48Yt8MlhJj2Gs6Ak=;
        b=ZwXpWUpS0pjvCtafbMEDaqBhDcoB8Y+apezR5ndyi7VOsu0DZg1PIEm+bctk9FY5Sr
         t6JpUCvHwzx+y91uY/Lk8/NIa78OjFLJmAlkwNi32xowd7YeptRw0cOtLe8jCREJLtM0
         /XP3AG2H/b8p794oia02ie5jnFZZW9x7lWMPwtKUI8CHQ4ICT+FRBWZ6XD9aG2TIlPW7
         n5+uyFcKeL7UYmJY0gpYLTC9LRsvSXg8zBvVZ9t32fcG0gJYvyF0WM3SdIPSWHI8sfYh
         leVCrvQKeFLf00OrmQqKLM3RbnTfYzlxH5iE3OVyg5F251L9RufMtMVLtrddU1s+il79
         qJEA==
X-Gm-Message-State: ACgBeo0ddgZ4wAbrfbWyM17lBY7/gqimL9hLLiEr1e7ySThwB/lHtpXv
        3ZxQ8W1IrrMBRpXpe5lYbTc=
X-Google-Smtp-Source: AA6agR7vqq1QTi7igOOkGXVbjDkp08nRulzSASvLFJk+vjwaKFa0LNvfAfCb2LlljT+4o/btBqahTA==
X-Received: by 2002:a17:902:d2c3:b0:175:406f:5665 with SMTP id n3-20020a170902d2c300b00175406f5665mr30858501plc.76.1662448760477;
        Tue, 06 Sep 2022 00:19:20 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id u195-20020a6279cc000000b00537eb00850asm9293775pfc.130.2022.09.06.00.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 00:19:20 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     zackr@vmware.com
Cc:     linux-graphics-maintainer@vmware.com, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drm/vmwgfx: Remove the unneeded result variable
Date:   Tue,  6 Sep 2022 07:19:16 +0000
Message-Id: <20220906071916.337033-1-ye.xingchen@zte.com.cn>
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

Return the value vmw_cotable_notify() directly instead of storing it in
another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index f085dbd4736d..080c9c11277b 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -1263,7 +1263,6 @@ static int vmw_cmd_dx_define_query(struct vmw_private *dev_priv,
 	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdDXDefineQuery);
 	struct vmw_ctx_validation_info *ctx_node = VMW_GET_CTX_NODE(sw_context);
 	struct vmw_resource *cotable_res;
-	int ret;
 
 	if (!ctx_node)
 		return -EINVAL;
@@ -1275,9 +1274,8 @@ static int vmw_cmd_dx_define_query(struct vmw_private *dev_priv,
 		return -EINVAL;
 
 	cotable_res = vmw_context_cotable(ctx_node->ctx, SVGA_COTABLE_DXQUERY);
-	ret = vmw_cotable_notify(cotable_res, cmd->body.queryId);
 
-	return ret;
+	return vmw_cotable_notify(cotable_res, cmd->body.queryId);
 }
 
 /**
@@ -2576,7 +2574,6 @@ static int vmw_cmd_dx_so_define(struct vmw_private *dev_priv,
 		uint32 defined_id;
 	} *cmd;
 	enum vmw_so_type so_type;
-	int ret;
 
 	if (!ctx_node)
 		return -EINVAL;
@@ -2586,9 +2583,8 @@ static int vmw_cmd_dx_so_define(struct vmw_private *dev_priv,
 	if (IS_ERR(res))
 		return PTR_ERR(res);
 	cmd = container_of(header, typeof(*cmd), header);
-	ret = vmw_cotable_notify(res, cmd->defined_id);
 
-	return ret;
+	return vmw_cotable_notify(res, cmd->defined_id);
 }
 
 /**
-- 
2.25.1
