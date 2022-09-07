Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C16E5AFAEA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 06:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiIGEAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 00:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIGEAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 00:00:34 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4052F74DEA;
        Tue,  6 Sep 2022 21:00:33 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id u22so13219118plq.12;
        Tue, 06 Sep 2022 21:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=57J/EEp91gk5r1fKfgsfX2mJbEtzuldBmUenWamQxDI=;
        b=ZUeY3YOn7RTdrP+Gfi4LwfgzsZ+V8MfB75CP/JUUFpaHlzLWwB4Bj3jh4qS0Hz8K7O
         Oj/y5axK61NVWaQnljLnsGEr/qzFiX2bvxgFcPxTGFlJSqB0vptuZXPqLRmKTxT8d6ab
         B37LIhGeXN2K1HIJli//0pQeJ5+YFTdmbo4frcQkGutKdY3CYLSTic+isEF7ynyO+PqC
         ckyZLGhEnL2Z1Zb5NdvdynSqedgzvxolJS46GmvGH1GgKtRbR2etJzMDdIY04DMiQJiU
         CkJr+3/2I8Af9eNR8RzgsUfFPTa9yMqxiHg6lo8ilZxbvQcgOvOWcrZOzrEefuab7tOi
         bVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=57J/EEp91gk5r1fKfgsfX2mJbEtzuldBmUenWamQxDI=;
        b=JRolULSiwCIL2gk4recIZa1E1EQJmeBgKwaX3FYEFSwHZvHtOyT4bxCapR2XQkMykD
         Hq2hyWsvb8jRTk162uWfwFqR75qdKjx85OHVwJm5YLEw8n0Jte13qGVTDEMTMTpRcChm
         f2yZZ9pjQFznE3sm+R9y1v54xFcqcLI6N/6aS/HVA3PKBiR99aaz3WZTkMsctyh1PX7H
         7OupDeBjzCLOEaiL6FToaKAlIHCKpwTkL5wAzpjfozhLvffz17NzOGTNA+5txjLEkrmM
         fxhQpBwF98x9PumUgzWiddneGE7YcQT8oJl4YWyf1qZi1scVPABWSfPRmZL0CGYoPQpD
         bkcA==
X-Gm-Message-State: ACgBeo0iMkX8KvhuMgkWADqn4qET2JVlkrsQSdC0cKlaSLpsaZV1FPLJ
        Q9h3P5CEGpqTiQNN4IerJGlWU86dI5KM5NPU
X-Google-Smtp-Source: AA6agR7S6I5bbPFn5rMRUqzmNth81u7qPMLEOKS1tMTFwMljz+6D0HgBU5PrpTCe4JpGPCVux3bbGw==
X-Received: by 2002:a17:903:11d2:b0:172:6ea1:b6e6 with SMTP id q18-20020a17090311d200b001726ea1b6e6mr1789122plh.72.1662523232814;
        Tue, 06 Sep 2022 21:00:32 -0700 (PDT)
Received: from xm06403pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902e84c00b0016d5b7fb02esm10967618plg.60.2022.09.06.21.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 21:00:32 -0700 (PDT)
From:   Wenchao Chen <wenchao.chen666@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhang.lyra@gmail.com, lzx.stg@gmail.com
Subject: [PATCH Vx 5/5] mmc: sdhci: Fix host->cmd is null
Date:   Wed,  7 Sep 2022 11:58:47 +0800
Message-Id: <20220907035847.13783-1-wenchao.chen666@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenchao Chen <wenchao.chen@unisoc.com>

When data crc occurs, the kernel will panic because host->cmd is null.

Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
---
 drivers/mmc/host/sdhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7689ffe..2511728 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3928,7 +3928,7 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
 
 	if (intmask & (SDHCI_INT_INDEX | SDHCI_INT_END_BIT | SDHCI_INT_CRC)) {
 		*cmd_error = -EILSEQ;
-		if (!mmc_op_tuning(host->cmd->opcode))
+		if (!mmc_op_tuning(SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND))))
 			sdhci_err_stats_inc(host, CMD_CRC);
 	} else if (intmask & SDHCI_INT_TIMEOUT) {
 		*cmd_error = -ETIMEDOUT;
@@ -3938,7 +3938,7 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
 
 	if (intmask & (SDHCI_INT_DATA_END_BIT | SDHCI_INT_DATA_CRC)) {
 		*data_error = -EILSEQ;
-		if (!mmc_op_tuning(host->cmd->opcode))
+		if (!mmc_op_tuning(SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND))))
 			sdhci_err_stats_inc(host, DAT_CRC);
 	} else if (intmask & SDHCI_INT_DATA_TIMEOUT) {
 		*data_error = -ETIMEDOUT;
-- 
2.7.4

