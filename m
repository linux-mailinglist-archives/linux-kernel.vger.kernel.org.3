Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9154D0181
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243288AbiCGOhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiCGOhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:37:23 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AC27E590;
        Mon,  7 Mar 2022 06:36:28 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id j26so13262778wrb.1;
        Mon, 07 Mar 2022 06:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CeIhj+xlbNH1tbRacxDrcMILHX0PhWKDMIaEBWJrU/0=;
        b=L9Yy9MzJkNzV/4C4etsj7XGiuZUF21kwtAR0Kpsb8xVBwxFXRDOY0SHCeC9pHGeCIr
         eXS7pcBvdlYH+iYGPPnCfKfgnuUANcL66LChHy+NdG2AcBhTVSH+2pwiTszUh1RQEt35
         VmcuZCb+Wkfsx8x1GLdfUT990PIwmIi2z0014LwVppPzA01QJ+6KrohYMnoI1l1KQnzu
         kUeqz/ibg2YsIXINHBcwCdiH/EAYyugzNK7sjhbbAtP00I65BX5N8a3+ZaKTezIkQck9
         pXfV4lcBRtdV7tj5MQz61/zpG0ucxZySFwtCjUpmFEQ00CnYOQIRhTaoQ9snz4kPTlj0
         vTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CeIhj+xlbNH1tbRacxDrcMILHX0PhWKDMIaEBWJrU/0=;
        b=2xCMe/KosgvNIprVKQS8J74tqsA1nDVt4OP5TAkiu+42epWWQ29qlfUpNT2ClGayBM
         HFwWbLKo6plDB2PTUljbKmP59Fi5FWKKUFzjweiT2mXhchqM1Q6Oh98xKmm+bT2SKSIO
         QS+k4gFK1CPBBEqhE3yB21IjHlsTpUNE/OzznWrFed53diSmUqTzhHqGzGh+tWvsXmg2
         bpXInC7c9yO8vC3aR9e15g8+Xl7jH//ShykbIDtR+FVeG0c2EJJK16mKWj1wZ+jOyiGR
         fJ58AUnIrkcd+xb5AIMN8rkrsZoO3fXl5GT55y4Lq4oBq2Vh2LdPSo3+Q2ZuqcWDDsN9
         AM+Q==
X-Gm-Message-State: AOAM531FTLvotrPxJ15N3Aou0kE0/pYVI1IgayawzIT8KPQP/mnCfpp/
        sbrCWnzmABOVSZkyt5xLEbE=
X-Google-Smtp-Source: ABdhPJzAxxaAb26zhaHLIkISgqgjxNtoRShsy26CNag6U+fVlySw7Ij39E5P0na4aYKZjESTeF9bLA==
X-Received: by 2002:adf:fc08:0:b0:1f0:48ef:cec7 with SMTP id i8-20020adffc08000000b001f048efcec7mr8170366wrr.540.1646663786801;
        Mon, 07 Mar 2022 06:36:26 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id l1-20020a05600c4f0100b00387369f380bsm14428800wmq.41.2022.03.07.06.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 06:36:26 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6655: remove redundant assignment of pointer tx_key
Date:   Mon,  7 Mar 2022 14:36:25 +0000
Message-Id: <20220307143625.136189-1-colin.i.king@gmail.com>
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

Pointer tx_key is being assigned a value that is never read, it is
being re-assigned a new value later. The assignment is redundant
and can be removed.

Cleans up clan scan build warning:
drivers/staging/vt6655/rxtx.c:1311:3: warning: Value stored
to 'tx_key' is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/staging/vt6655/rxtx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 0de801b666da..53506e242a96 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -1308,8 +1308,6 @@ int vnt_generate_fifo_header(struct vnt_private *priv, u32 dma_idx,
 			cpu_to_le16(ieee80211_get_hdrlen_from_skb(skb) << 10);
 
 	if (info->control.hw_key) {
-		tx_key = info->control.hw_key;
-
 		switch (info->control.hw_key->cipher) {
 		case WLAN_CIPHER_SUITE_WEP40:
 		case WLAN_CIPHER_SUITE_WEP104:
-- 
2.35.1

