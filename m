Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF163527F4F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 10:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241521AbiEPIKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 04:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235893AbiEPIK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 04:10:27 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FAD3586A;
        Mon, 16 May 2022 01:10:26 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id a11so13384013pff.1;
        Mon, 16 May 2022 01:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ewwDGiDvoSbqJDxqbyxplwfzhpSVEU4MwD5LupBWqs8=;
        b=WDVdOV9pCSiGWAFrn+I+uVxvg665Qa16eEMMP/WPiFdAbtCb1FVMdeTuTPvRwuy4bB
         8S1ES06d3buhk0r52SiTQan+NeHh+SeL1bHB/ESE4/M8+b7HUOazTkvbUxvxni/gZEdX
         IYTaFsbYxfk8vZBtoC2dhYRe0sQrZVzmBo3fchX9iSMTchHAF9+SyjTXcNpf4tghvVTo
         an2lQCp3sVFWDpHBDccUTCxX8iD57eXGiMihAnKBNawGqMGx9HOxIwUm+hgjco95wqY+
         pZNtcJ27gAEipl8kz7nIs4S0dXI9AYuqj21uAFgi7LtkilSBFoKohm+1wDJjPFFOSYLW
         nelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ewwDGiDvoSbqJDxqbyxplwfzhpSVEU4MwD5LupBWqs8=;
        b=ZXYesAwz20XoTkiZVrZs3ZKsQeWb5eDlkXTU9ISu1OZYoVlbG8H+KwoGwEYwQTEk3s
         0Nx4Gj7PJXRbBGqVaxOQF2UUR2PS9tRt+G2gALmCu+30h4SR9w3JNTh3fXxqCMmbPZso
         WJDv4VEhu6SoUMvPwwh1L6VPxVKLN13nCLQD5f2fvQ1NBVEMtdZ870Xcne8/XM7k+xzW
         0hsH1WsboSnaADYmOTLIMSajKxttza4SErKGlCemNgflvRmKxgWR9u8uR3hCB0JteBAn
         kQkKyBya0ARLOc2IRgPHHcCEL9hGOEpyAQKatBHKKbBLkQSnkf0d69aNWspfe/9Mi1Oi
         19lw==
X-Gm-Message-State: AOAM533f57pHTyyZ96KobtGsqQ5DKc/8L8oTq6NwFyzXntejFgZxd3CN
        IhIy5D6/SPGsTNEFZmTsG6tDTPovD8OthjeI
X-Google-Smtp-Source: ABdhPJzmkxTSrk6XaE27ZCUJvbJocJvynakIipnPvzkCo5ZSTqWgBLQZaKKdcT2FuQCBiQIHJFABdw==
X-Received: by 2002:a05:6a00:198a:b0:50e:a2a:32e9 with SMTP id d10-20020a056a00198a00b0050e0a2a32e9mr16361441pfl.82.1652688626284;
        Mon, 16 May 2022 01:10:26 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id x12-20020a170902a38c00b0015e8d4eb1d2sm6337096pla.28.2022.05.16.01.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 01:10:25 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: sparcspkr: Fix refcount leak in bbc_beep_probe
Date:   Mon, 16 May 2022 12:10:16 +0400
Message-Id: <20220516081018.42728-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
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

of_find_node_by_path() calls of_find_node_opts_by_path(),
which returns a node pointer with refcount
incremented, we should use of_node_put() on it when done.
Add missing of_node_put() to avoid refcount leak.

Fixes: 9c1a5077fdca ("input: Rewrite sparcspkr device probing.")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/input/misc/sparcspkr.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/sparcspkr.c b/drivers/input/misc/sparcspkr.c
index fe43e5557ed7..6a86900aa1fb 100644
--- a/drivers/input/misc/sparcspkr.c
+++ b/drivers/input/misc/sparcspkr.c
@@ -206,11 +206,11 @@ static int bbc_beep_probe(struct platform_device *op)
 	info = &state->u.bbc;
 	info->clock_freq = of_getintprop_default(dp, "clock-frequency", 0);
 	if (!info->clock_freq)
-		goto out_free;
+		goto out_put;
 
 	info->regs = of_ioremap(&op->resource[0], 0, 6, "bbc beep");
 	if (!info->regs)
-		goto out_free;
+		goto out_put;
 
 	platform_set_drvdata(op, state);
 
@@ -218,11 +218,14 @@ static int bbc_beep_probe(struct platform_device *op)
 	if (err)
 		goto out_clear_drvdata;
 
+	of_node_put(dp);
+
 	return 0;
 
 out_clear_drvdata:
 	of_iounmap(&op->resource[0], info->regs, 6);
-
+out_put:
+	of_node_put(dp);
 out_free:
 	kfree(state);
 out_err:
-- 
2.25.1

