Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9134C4CA8C3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 16:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243351AbiCBPFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 10:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239644AbiCBPFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 10:05:19 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DCC427C1;
        Wed,  2 Mar 2022 07:04:35 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id m14so3314373lfu.4;
        Wed, 02 Mar 2022 07:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PqvW/Mb3KnE9g+cGLNfX7KJR06/Flo7vnw52A4Z7zOk=;
        b=I2TDsTdTd0t/n7WwJccRK0QUKlws/dMoPReFYNY+TJwfmf3lv1BWIf6UE8U+p2l9VY
         NMzhepWRFqHIenxEiMLnv1Vd7THPOmiJG4sjM1LLHQ1u5KJJH23N7LqrhyLGKS0XcSBA
         UPesRIVsqF9GI0v+PKHvCVUC3VLHmnzHo6ss2+F00nfyOUO7WLT+OZgM7Sqhp2kvxtAP
         r5enN1xbK4KYGCdJG74/l5RKLupHYKcZ9zSvYqj1LSt65LuXrymmi7mmX2ik+qiM6edx
         23KBrihRpcv3oxzoBrFNSCsDmZap5pABUKO0Gh+hx/j63trlK0SEMPG9mfWMiBQXSZWG
         dfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PqvW/Mb3KnE9g+cGLNfX7KJR06/Flo7vnw52A4Z7zOk=;
        b=ckQo4pfs8rHZk2Z1I75NaedIFamt8WD+gkpqj2xwfyb7PjFd3LO5xOWzJa/LoXmbev
         hc0LkN41ornuaAt7BIElgnxyEf7ZI5obICDr+aMWSLLB+6n8yG8C85pUH+mUCwmyM7AE
         WNi82rWUZJ+AddBUaZUb7senFSjhcRRlMLpj1clSU4D7v4JnG3JyWmsnZPJyCR4bSeq/
         ATbA77kQWSVlP9jM/LWLMqdb5MPB0fWoSrwD/rJCXKRyxj8XBQi+/5XXjsQWEEY0XA69
         sk8W1n2qvGkvMW1SFkM5yPZorDmzobu0Z9Gcw/epsxTlkX/4F7CcfWzocse3UtCZRJi9
         ehZw==
X-Gm-Message-State: AOAM530BLUWXiYo2N+KOjtuYijqQwSOfLJPrPgYhErq2g/kxYwem5BQN
        V9BFWFIBLc6UYXzFxw62PeQ=
X-Google-Smtp-Source: ABdhPJzE65q4hhTof31MlD3dDz2xv06CS0vMv25ttXIl8Oc1OSvF5ye9dTJffA3+8Kb1YG/XFtIN0Q==
X-Received: by 2002:a05:6512:220a:b0:443:1140:7ffc with SMTP id h10-20020a056512220a00b0044311407ffcmr17905269lfu.566.1646233471382;
        Wed, 02 Mar 2022 07:04:31 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id q11-20020ac24a6b000000b0044313bd60f8sm2086675lfp.292.2022.03.02.07.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 07:04:30 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mailbox: tegra-hsp: Flush whole channel
Date:   Wed,  2 Mar 2022 16:04:24 +0100
Message-Id: <20220302150424.1305301-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.35.1
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

From: Pekka Pessi <ppessi@nvidia.com>

The txdone can re-fill the mailbox. Keep polling the mailbox during the
flush until all the messages have been delivered.

This fixes an issue with the Tegra Combined UART (TCU) where output can
get truncated under high traffic load.

Signed-off-by: Pekka Pessi <ppessi@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Fixes: 91b1b1c3da8a ("mailbox: tegra-hsp: Add support for shared mailboxes")
Cc: stable@vger.kernel.org
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- add Fixes: line
- Cc stable

 drivers/mailbox/tegra-hsp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
index acd0675da681..78f7265039c6 100644
--- a/drivers/mailbox/tegra-hsp.c
+++ b/drivers/mailbox/tegra-hsp.c
@@ -412,6 +412,11 @@ static int tegra_hsp_mailbox_flush(struct mbox_chan *chan,
 		value = tegra_hsp_channel_readl(ch, HSP_SM_SHRD_MBOX);
 		if ((value & HSP_SM_SHRD_MBOX_FULL) == 0) {
 			mbox_chan_txdone(chan, 0);
+
+			/* Wait until channel is empty */
+			if (chan->active_req != NULL)
+				continue;
+
 			return 0;
 		}
 
-- 
2.35.1

