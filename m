Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7354FC102
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348070AbiDKPjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240237AbiDKPjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:39:52 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3A33A5E7;
        Mon, 11 Apr 2022 08:37:38 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t1so5918923wra.4;
        Mon, 11 Apr 2022 08:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XynkJF5/tDNj210GbAEuyHTgO4xrEQFboF9g0CngvhM=;
        b=TcdFyn/pxbgxLWoLfzplhGxofZcbi77a7AxnJibbvUBt1UEVyiq8LXH9CG3JwId/LX
         WThRwMHCCAyhOOe13ysUxfQ7HQ9frbJ+Iw+dJ34dg5y/DeG9uvvs/DV0KKPr+onQolJB
         0CZ6rW+r/cU/0t6fZQT/qpvLqMgW27hGGQiTMHwvj32zdDfHfxM7jymPfxR1saawoydy
         d+hsB+UNcLjpTdJhUVLlhcwpdNvCgV8SbPwPcfwSjoBq+299/UaTsqKitZKw/3AB4qZ+
         dC0h8RfPGBjUavNzXr0rjqw9yYZaw32O5P95plikhJACrw4m6Xm1NNTUnEiO13tWSzGl
         e1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XynkJF5/tDNj210GbAEuyHTgO4xrEQFboF9g0CngvhM=;
        b=1oW0JhuJFby0cyn4I64SDcZl/ZTL2tUOL+iHaHJPcG838Vb0VorhO+k6kBANEsRlyq
         4WDTk+mQijqWHL9Uujsc3MghXannWqB7u1oCYUljH5ibGvUq8TohgO9bonPqhNj8dEV2
         QQimfM2Q0KPX/SSifQHxtCOHr/Oqr+tU1UDmac4/BJExEG1INycNOynoVeRdWXdcFRN5
         jlCJqmrvBN4nfxOkUeEtXj3SUlbKl2P7byFfvUcTyT8b1i6g0Wvfoc/m7HG1qjcun9LT
         0M8QmlVvCvN1dKqcuK4t/X3Kj6DVzF/FkWj4ZwDZlzLFs2nX8mf153/4MGjlysnImlML
         ayqg==
X-Gm-Message-State: AOAM531HGHNfiiD1/youGYWaWbMkHoVH7uuHMPwrRzl4wEmTnKYi3NuW
        Te9YKFbdLQaRECOsaZqfVq2n4vssyn/taw==
X-Google-Smtp-Source: ABdhPJxwzNG+yEG+/rRMEfyd4DjC9tcEcRWRocqOeFgwph6rD5rmPMhBWfDXRqvYq61H6lCjVh4nCw==
X-Received: by 2002:a5d:4306:0:b0:207:9e49:a1d3 with SMTP id h6-20020a5d4306000000b002079e49a1d3mr9748738wrq.188.1649691456762;
        Mon, 11 Apr 2022 08:37:36 -0700 (PDT)
Received: from localhost (92.40.202.92.threembb.co.uk. [92.40.202.92])
        by smtp.gmail.com with ESMTPSA id bs12-20020a056000070c00b00207a2c698b1sm4831432wrb.40.2022.04.11.08.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:37:36 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, ulf.hansson@linaro.org
Cc:     linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: jz4740: Apply DMA engine limits to maximum segment size
Date:   Mon, 11 Apr 2022 16:37:53 +0100
Message-Id: <20220411153753.50443-1-aidanmacdonald.0x0@gmail.com>
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

Do what is done in other DMA-enabled MMC host drivers (cf. host/mmci.c) and
limit the maximum segment size based on the DMA engine's capabilities. This
is needed to avoid warnings like the following with CONFIG_DMA_API_DEBUG=y.

------------[ cut here ]------------
WARNING: CPU: 0 PID: 21 at kernel/dma/debug.c:1162 debug_dma_map_sg+0x2f4/0x39c
DMA-API: jz4780-dma 13420000.dma-controller: mapping sg segment longer than device claims to support [len=98304] [max=65536]
CPU: 0 PID: 21 Comm: kworker/0:1H Not tainted 5.18.0-rc1 #19
Workqueue: kblockd blk_mq_run_work_fn
Stack : 81575aec 00000004 80620000 80620000 80620000 805e7358 00000009 801537ac
        814c832c 806276e3 806e34b4 80620000 81575aec 00000001 81575ab8 09291444
        00000000 00000000 805e7358 81575958 ffffffea 8157596c 00000000 636f6c62
        6220646b 80387a70 0000000f 6d5f6b6c 80620000 00000000 81575ba4 00000009
        805e170c 80896640 00000001 00010000 00000000 00000000 00006098 806e0000
        ...
Call Trace:
[<80107670>] show_stack+0x84/0x120
[<80528cd8>] __warn+0xb8/0xec
[<80528d78>] warn_slowpath_fmt+0x6c/0xb8
[<8016f1d4>] debug_dma_map_sg+0x2f4/0x39c
[<80169d4c>] __dma_map_sg_attrs+0xf0/0x118
[<8016a27c>] dma_map_sg_attrs+0x14/0x28
[<804f66b4>] jz4740_mmc_prepare_dma_data+0x74/0xa4
[<804f6714>] jz4740_mmc_pre_request+0x30/0x54
[<804f4ff4>] mmc_blk_mq_issue_rq+0x6e0/0x7bc
[<804f5590>] mmc_mq_queue_rq+0x220/0x2d4
[<8038b2c0>] blk_mq_dispatch_rq_list+0x480/0x664
[<80391040>] blk_mq_do_dispatch_sched+0x2dc/0x370
[<80391468>] __blk_mq_sched_dispatch_requests+0xec/0x164
[<80391540>] blk_mq_sched_dispatch_requests+0x44/0x94
[<80387900>] __blk_mq_run_hw_queue+0xb0/0xcc
[<80134c14>] process_one_work+0x1b8/0x264
[<80134ff8>] worker_thread+0x2ec/0x3b8
[<8013b13c>] kthread+0x104/0x10c
[<80101dcc>] ret_from_kernel_thread+0x14/0x1c

---[ end trace 0000000000000000 ]---

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/mmc/host/jz4740_mmc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 7ab1b38a7be5..b1d563b2ed1b 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -247,6 +247,26 @@ static int jz4740_mmc_acquire_dma_channels(struct jz4740_mmc_host *host)
 		return PTR_ERR(host->dma_rx);
 	}
 
+	/*
+	 * Limit the maximum segment size in any SG entry according to
+	 * the parameters of the DMA engine device.
+	 */
+	if (host->dma_tx) {
+		struct device *dev = host->dma_tx->device->dev;
+		unsigned int max_seg_size = dma_get_max_seg_size(dev);
+
+		if (max_seg_size < host->mmc->max_seg_size)
+			host->mmc->max_seg_size = max_seg_size;
+	}
+
+	if (host->dma_rx) {
+		struct device *dev = host->dma_rx->device->dev;
+		unsigned int max_seg_size = dma_get_max_seg_size(dev);
+
+		if (max_seg_size < host->mmc->max_seg_size)
+			host->mmc->max_seg_size = max_seg_size;
+	}
+
 	return 0;
 }
 
-- 
2.35.1

