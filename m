Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523065310C1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbiEWLMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbiEWLM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:12:27 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7771E3E6;
        Mon, 23 May 2022 04:12:25 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id q4so12768280plr.11;
        Mon, 23 May 2022 04:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tvtv+8gGUo5bBgwDT2gc4m2BjX3ye0s9BLu1V3Pf3EA=;
        b=jkhLW35duY5rNVAmt9T11mn+zYgUU2FHnaT8NmNX6QVSGUMc+vBG5z128l3XGx1yFu
         yt1Rm+cAWA6wsSLxcZ5r4ARhNdH/C+CnC3snrmANAbRPdKBi2BvMp3CeAyNtRN7P0PZU
         9PfFQP2AIP5l/WwVIdthKqnYAmvycAytTLQkoU7sG1COJd8P1SNetKzvuFj4GL2rDPud
         o8Z8oBdaYqU2n6/3yoKuwcZwl8eZYBpywEHLMz0ke25FHzxiJiG4xV0ygjDTtUSzcdiB
         snG1mqAeZDXQeCCqNZDxZkuFazc+G6ueqLcXRyNBH10+ThAdluNCotcRpwcZIY7JT3IG
         OXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tvtv+8gGUo5bBgwDT2gc4m2BjX3ye0s9BLu1V3Pf3EA=;
        b=JRktLlxRT+7vEleWoIVzWNBm4+qXNntD+XShLVJ0vI9fX4pLtvmhB3qxfquTRGL/W9
         a9RBcQso7d4968xSIYCzKB4ynLIRgDGd1KK9/yNPrRZn3UFsoyOjq33Qw7wXQ7WN2pnG
         EPTaJwXKtNbPw+L8aekfcvPT/OwexDuGjf+rxCkJEdY9LPwHgNgtaCqpxSwUamIev4jO
         ZwF1HOI3YHnbIeZT2z7N6inLlIbiwUH/0BS+c0OO/3neY0WALBLQULxkiER2KSm/qOau
         4119CdJFj9R7/PV4CwX5xumSvBIwBYgfegILNedtfLVhbSZzVQnN72Ci5w2m4a9zj63M
         sC2w==
X-Gm-Message-State: AOAM53315bgpDa9jLdDeftB75UpQo2X4HRaysU4uk5bCELyYvrBQOr4B
        bSaE5c8ttv6niPf9e3AmtWl5cbBIkcI=
X-Google-Smtp-Source: ABdhPJxtm3zxWpI5laF+eJKY91zbgrUI0wMHAJEJWXkEDdBDpgPuGuc/hAKPLkLNwqC4H4ffF+68LQ==
X-Received: by 2002:a17:90a:b88:b0:1df:2b03:20c with SMTP id 8-20020a17090a0b8800b001df2b03020cmr25652487pjr.46.1653304345429;
        Mon, 23 May 2022 04:12:25 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a15-20020a170902eccf00b0016170bb6528sm4897010plh.113.2022.05.23.04.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 04:12:25 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     thierry.reding@gmail.com
Cc:     jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] soc/tegra: Avoid leak OF node on error
Date:   Mon, 23 May 2022 11:12:21 +0000
Message-Id: <20220523111221.3045-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi <chi.minghao@zte.com.cn>

The OF node should be put before returning error in tegra_init_soc(),
otherwise node's refcount will be leaked.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/soc/tegra/fuse/fuse-tegra.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index b0a8405dbdb1..ab3e4dc6dc6e 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -612,11 +612,10 @@ static int __init tegra_init_soc(void)
 
 	/* make sure we're running on Tegra */
 	np = of_find_matching_node(NULL, tegra_fuse_match);
+	of_node_put(np);
 	if (!np)
 		return 0;
 
-	of_node_put(np);
-
 	soc = tegra_soc_device_register();
 	if (IS_ERR(soc)) {
 		pr_err("failed to register SoC device: %ld\n", PTR_ERR(soc));
-- 
2.25.1


