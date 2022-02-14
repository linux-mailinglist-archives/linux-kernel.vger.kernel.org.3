Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CE94B54D4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355883AbiBNPdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:33:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352973AbiBNPdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:33:13 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99BE47567;
        Mon, 14 Feb 2022 07:33:02 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id u6so31381386lfc.3;
        Mon, 14 Feb 2022 07:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V+BZ9l4nxYyVbWiP19qpOCcVdcferaufovGSXxHYlGM=;
        b=fMdJoRgwwpjfoOvUZWdzrXKf5lxk21do/fH8LT7Zkd2hgMr8pzwp6GP6P6RKv5E9Rv
         OyVbOZl5n45vgkdiyVUKKjCv1+pik/MMCpG5Pic7UvibFUpldwMdZlUqAnG+S4FffeLa
         7o+jpSbWcUZW/YhpmzlKM/VJ25OJHWsx1yq6/uVXx4COHLUXEDiQre0tAQimanWnl32N
         bUX7GakS10z76tePFL5B+UaRlU0QapIXKJoFarJa8Dmsuh8An1GbMksrRDKl4lTWIiA0
         0FJYZIl+vtOX5JIxbBJ9cOkZABLDV0r38wnb/mXDNNEm3s0p3emwYKVl0lXbcdbs9i/y
         QcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V+BZ9l4nxYyVbWiP19qpOCcVdcferaufovGSXxHYlGM=;
        b=SsroewCTNOm0kOlIsNAqMdUOuSVOP9nYF6jBCQ4RgLpMwi6hxhKD/y3Qub8ijanOb1
         L5o2AyNXOa/GQO4j9006g4rFAIjn7s681DElKyNiIKS6uR+DlUX4NOFodiCwfGzsoCg6
         G4qXncsIEV03TfC6utbBxVDTNF3yskgnyQ78+kOq8xjZ6bFps0X6wKpyQVvkGvBTpfjp
         lz/IFgzhkiR6JGS0hM4kfihbC3yFEYQLmVkm7UClr+ZjZwnhDuDz5C1VOakAFfWPDhuE
         GkR/kRsnBHwVW5n5X1MXZOj5k6Mb5n+jJTPtY2Bh/uQ2M0TLJnFpnicWrXWNn3Pz3Vdo
         xRaw==
X-Gm-Message-State: AOAM531iZtsUWp/e/GwfGN+j0OTP5yuLQRWnmVa4ntLzHDUibbyAPOeL
        ZVnBb4AeqJGBVpYi5DzbHqxYwEzU56j1yw==
X-Google-Smtp-Source: ABdhPJxQxoPfNXjl+WJ2hdTaOjuAOkK2pKeBqFw4r/OHj5wqqE3XWfTUozKbQV5BvC2MlwwiswWH/A==
X-Received: by 2002:ac2:4c50:: with SMTP id o16mr162186lfk.114.1644852781002;
        Mon, 14 Feb 2022 07:33:01 -0800 (PST)
Received: from localhost ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id bp3sm4161693lfb.53.2022.02.14.07.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 07:33:00 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Pekka Pessi <ppessi@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mailbox: tegra-hsp: Flush whole channel
Date:   Mon, 14 Feb 2022 16:32:56 +0100
Message-Id: <20220214153256.162261-1-thierry.reding@gmail.com>
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

Signed-off-by: Pekka Pessi <ppessi@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
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

