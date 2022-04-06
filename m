Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEC04F6BA7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiDFUwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbiDFUvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:51:35 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D149F21C059
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 12:07:32 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a6so6360844ejk.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 12:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OeMtijpkibGaog7F58AuM7SBlMK2GtUfrLCNQpMtHag=;
        b=x+LhGUsW+0qT4WfR+xdfEVx4Wb4G/SZfdzhW8JpwU9lryyw+1poelkt7BcXTx9n2M1
         FkPy9BlGuV5o30zZ1i4WKuN1GtFcdJ41HO8iPDQum6ma/u+qqkle49MrIQDSOXP/Bi3Q
         G7It2UxXLxl1Xel03xFsrb61xso0PqJGuYVDSj5R2JA94iUUQ/wfdQF1qBDkmEWwGa5C
         2qWuxWeHtOSBVaSTZI++qvXlur6gUIDBhEMDnGRenUS/5M8kZ9HnIf1hpEbW4bflMcKM
         +ZhTbpXBtEsUnOKKpwzgzw/gSwJH9mRcoXVRnXmRmsld4l93NDOdEjDicU54wv9AOcM4
         ZJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OeMtijpkibGaog7F58AuM7SBlMK2GtUfrLCNQpMtHag=;
        b=sIx8Bt3Dv2cRUfLvDNtpKmzfjXB7r42YJgtFbZquhAuB8IakXPS5+csFzt5DwqF+p0
         3vEdzqr3yjhUU0Vw3y0THBajCjYjY6bjry/N40VygXgIIjuLm+Iusr4g63rhXwpkjnZw
         g0+zFW9AeEfH4AXqUptL5oAdUvFKPe8suuyAK2fvVr4+i4wJOAVFjdtHcd4zAroVo9nA
         g7TE+9sItc9ZJ/csgdFHNq0NRJQkle7FLfUyN0A1TJe4nLdBeFTQXvEzdkTn4iu5ZHMw
         RcsZXZ+shmI9t1rX43LYNt4Cexp2uFQ6Q2kZ/EDcWR38wNLwpoZC8l1MO5aQVMuMx4F8
         CINg==
X-Gm-Message-State: AOAM533ymCIGDk2FCa8aWIa+N+JVJ+5BciTNlAACPZGsUqPJtkRvJxpC
        pP0wT0onkB3CVFdAcYN52eC2VA==
X-Google-Smtp-Source: ABdhPJyeoQlMZGBzfnq9pnEc5goeLQqQ6V5UkPlAs8RjqvSnU53g3p7zUbSHqMEGb8+2kQh2EtAllw==
X-Received: by 2002:a17:907:1ca4:b0:6da:86a4:1ec7 with SMTP id nb36-20020a1709071ca400b006da86a41ec7mr9942094ejc.556.1649272051333;
        Wed, 06 Apr 2022 12:07:31 -0700 (PDT)
Received: from localhost (85-127-190-169.dsl.dynamic.surfer.at. [85.127.190.169])
        by smtp.gmail.com with ESMTPSA id o3-20020aa7c7c3000000b00410d407da2esm7960722eds.13.2022.04.06.12.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 12:07:30 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 1/7] drbd: fix duplicate array initializer
Date:   Wed,  6 Apr 2022 21:07:09 +0200
Message-Id: <20220406190715.1938174-2-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406190715.1938174-1-christoph.boehmwalder@linbit.com>
References: <20220406190715.1938174-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

There are two initializers for P_RETRY_WRITE:

drivers/block/drbd/drbd_main.c:3676:22: warning: initialized field overwritten [-Woverride-init]

Remove the first one since it was already ignored by the compiler
and reorder the list to match the enum definition. As P_ZEROES had
no entry, add that one instead.

Fixes: 036b17eaab93 ("drbd: Receiving part for the PROTOCOL_UPDATE packet")
Fixes: f31e583aa2c2 ("drbd: introduce P_ZEROES (REQ_OP_WRITE_ZEROES on the "wire")")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_main.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 9676a1d214bc..90a0814343df 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3587,9 +3587,8 @@ const char *cmdname(enum drbd_packet cmd)
 	 * when we want to support more than
 	 * one PRO_VERSION */
 	static const char *cmdnames[] = {
+
 		[P_DATA]	        = "Data",
-		[P_WSAME]	        = "WriteSame",
-		[P_TRIM]	        = "Trim",
 		[P_DATA_REPLY]	        = "DataReply",
 		[P_RS_DATA_REPLY]	= "RSDataReply",
 		[P_BARRIER]	        = "Barrier",
@@ -3600,7 +3599,6 @@ const char *cmdname(enum drbd_packet cmd)
 		[P_DATA_REQUEST]	= "DataRequest",
 		[P_RS_DATA_REQUEST]     = "RSDataRequest",
 		[P_SYNC_PARAM]	        = "SyncParam",
-		[P_SYNC_PARAM89]	= "SyncParam89",
 		[P_PROTOCOL]            = "ReportProtocol",
 		[P_UUIDS]	        = "ReportUUIDs",
 		[P_SIZES]	        = "ReportSizes",
@@ -3608,6 +3606,7 @@ const char *cmdname(enum drbd_packet cmd)
 		[P_SYNC_UUID]           = "ReportSyncUUID",
 		[P_AUTH_CHALLENGE]      = "AuthChallenge",
 		[P_AUTH_RESPONSE]	= "AuthResponse",
+		[P_STATE_CHG_REQ]       = "StateChgRequest",
 		[P_PING]		= "Ping",
 		[P_PING_ACK]	        = "PingAck",
 		[P_RECV_ACK]	        = "RecvAck",
@@ -3618,23 +3617,25 @@ const char *cmdname(enum drbd_packet cmd)
 		[P_NEG_DREPLY]	        = "NegDReply",
 		[P_NEG_RS_DREPLY]	= "NegRSDReply",
 		[P_BARRIER_ACK]	        = "BarrierAck",
-		[P_STATE_CHG_REQ]       = "StateChgRequest",
 		[P_STATE_CHG_REPLY]     = "StateChgReply",
 		[P_OV_REQUEST]          = "OVRequest",
 		[P_OV_REPLY]            = "OVReply",
 		[P_OV_RESULT]           = "OVResult",
 		[P_CSUM_RS_REQUEST]     = "CsumRSRequest",
 		[P_RS_IS_IN_SYNC]	= "CsumRSIsInSync",
+		[P_SYNC_PARAM89]	= "SyncParam89",
 		[P_COMPRESSED_BITMAP]   = "CBitmap",
 		[P_DELAY_PROBE]         = "DelayProbe",
 		[P_OUT_OF_SYNC]		= "OutOfSync",
-		[P_RETRY_WRITE]		= "RetryWrite",
 		[P_RS_CANCEL]		= "RSCancel",
 		[P_CONN_ST_CHG_REQ]	= "conn_st_chg_req",
 		[P_CONN_ST_CHG_REPLY]	= "conn_st_chg_reply",
 		[P_PROTOCOL_UPDATE]	= "protocol_update",
+		[P_TRIM]	        = "Trim",
 		[P_RS_THIN_REQ]         = "rs_thin_req",
 		[P_RS_DEALLOCATED]      = "rs_deallocated",
+		[P_WSAME]	        = "WriteSame",
+		[P_ZEROES]		= "Zeroes",
 
 		/* enum drbd_packet, but not commands - obsoleted flags:
 		 *	P_MAY_IGNORE
-- 
2.35.1

