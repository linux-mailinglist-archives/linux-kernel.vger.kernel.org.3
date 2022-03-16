Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607F04DAF08
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 12:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355456AbiCPLnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 07:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355437AbiCPLm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 07:42:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F96532D6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 04:41:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDD0FB81AB0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 11:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CE2C340F0;
        Wed, 16 Mar 2022 11:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647430904;
        bh=D7++y3nXwrhy+tZxPH4xS1jxkYfxfxPpCEaOAmFOtbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EKNiAEEQzCVwQJlgFTD9m7E7sMZFLMkzQ4OEUdC9HFrRA2slt3IOQeLND/1yHqEFr
         qIAB+rGc9xFenRylD5yK0F6INc1pCZiu/Oc9ks0ueDdnZvxKDhsybAEFft82smSlKW
         K0nU8JLGkvDiX82dOG+vS/Xbq1C5gXQueaYCy1nbhveBQO8QFI1VRFB9JK3l9+xPHf
         YiX3A40Iyu6q4CZard57lSW4mZVV9m7oKSKLut+VmF2BZaZTJJxDb/J+x/SB6fOnH2
         uLO6IEv91Dt+xjctLJ1cMoxUDLT5wErJuDbOEe3cR6I8XjKdhs5zByyNcD8XJ+TZ9p
         +9kGJu7crriVg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 08/11] habanalabs/gaudi: increase submission resources
Date:   Wed, 16 Mar 2022 13:41:26 +0200
Message-Id: <20220316114129.2520107-8-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220316114129.2520107-1-ogabbay@kernel.org>
References: <20220316114129.2520107-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

In order to allow user to have larger amount of submissions, we
increase the DMA and NIC queue depth to 4K.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudiP.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index 54de7c599072..4fbcf3f0afe5 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -148,14 +148,14 @@
 #define MME_QMAN_LENGTH			1024
 #define MME_QMAN_SIZE_IN_BYTES		(MME_QMAN_LENGTH * QMAN_PQ_ENTRY_SIZE)
 
-#define HBM_DMA_QMAN_LENGTH		1024
+#define HBM_DMA_QMAN_LENGTH		4096
 #define HBM_DMA_QMAN_SIZE_IN_BYTES	\
 				(HBM_DMA_QMAN_LENGTH * QMAN_PQ_ENTRY_SIZE)
 
 #define TPC_QMAN_LENGTH			1024
 #define TPC_QMAN_SIZE_IN_BYTES		(TPC_QMAN_LENGTH * QMAN_PQ_ENTRY_SIZE)
 
-#define NIC_QMAN_LENGTH			1024
+#define NIC_QMAN_LENGTH			4096
 #define NIC_QMAN_SIZE_IN_BYTES		(NIC_QMAN_LENGTH * QMAN_PQ_ENTRY_SIZE)
 
 
-- 
2.25.1

