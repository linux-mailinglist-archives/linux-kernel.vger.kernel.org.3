Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1A54F6B98
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbiDFUuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiDFUuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:50:07 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0013C3DD3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 12:05:28 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id n6so6158708ejc.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 12:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CYx1gEnJeFhX0hcBMvC6AbJqvsenlxSyXFJsv+MoaHE=;
        b=kUkwYXgtmkDRKIJ/rtwUxe+JUh+m7l723YKS7NVAlM4StAuUXqmH8xc+3BCN0MHlEz
         ojUrzjlZiFQQfaOPd7p38msq28KtcXjTX2T0LDE+zuKmbsIV6oiasyOfB92H7rflKIhP
         FtXo2rFXLOuuuqU/qujPVFyIjJfqmql0/7CkgL+Sx+7g2k6kN06saRQS2fvCF0CBeQLL
         BQP4oIlfAOTN069s/oiVibATpiZ6X9l85PUOlK61LmXbnx+vxR3ktqtGotc28uLJOSwH
         U5red2z2ZKWt2Ob2iwMGMDdsUBvYSUwuiPJHwjkIyo9HdpdVIbfguhVU7uGPxqLTKBRh
         yrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CYx1gEnJeFhX0hcBMvC6AbJqvsenlxSyXFJsv+MoaHE=;
        b=0dtiFOGzxDF754eeyILe1Ckpi91MN5Nemc3W+ZUc8EiNwT4RhDJXob4w60mh52AFeq
         fFUdOrdIsBhju7m4KP1VuAIBB101B5DWl7HK7qXZt0NUTRYN2aumbN7MeTDhJvcGf0Bs
         GRUIDU30BWvtzqgG65KECZC+hnMhL2gBTFzdXir5Zode34aMyrePNmANwJIlLuCV/qLK
         UXYB/xbTMmDMWToymcxR41wQXZ1eWMun2AqZjrBkYeZl4m4pRvuZ8P6wb1XE0a6dPTlw
         96hxw4G6szwPerb01okAaBKdH7t+bWi7IGbFoxEY/d2ty3mkGkf1QIwARaqKvrAcMcAA
         i7/A==
X-Gm-Message-State: AOAM531BF1Jaxss7YDvcieYoEiCiIcgDfCsX2oRlbU+kWMRDVmTQtYrL
        bS+xyss8xG9nZPK4uICdS3E0Ug==
X-Google-Smtp-Source: ABdhPJx2iJvY96w2dmyQ/WbuQP4igjP3LilGuDdSc+3WWSR6MKk809HJ8Ox4pZZZnwIVh0jaGqwoNA==
X-Received: by 2002:a17:907:8a09:b0:6df:f1c6:bfc4 with SMTP id sc9-20020a1709078a0900b006dff1c6bfc4mr9926952ejc.550.1649271926937;
        Wed, 06 Apr 2022 12:05:26 -0700 (PDT)
Received: from localhost (85-127-190-169.dsl.dynamic.surfer.at. [85.127.190.169])
        by smtp.gmail.com with ESMTPSA id n27-20020a1709062bdb00b006da975173bfsm6973025ejg.170.2022.04.06.12.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 12:05:26 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>, stable@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 2/3] drbd: fix an invalid memory access caused by incorrect use of list iterator
Date:   Wed,  6 Apr 2022 21:04:44 +0200
Message-Id: <20220406190445.1937206-3-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406190445.1937206-1-christoph.boehmwalder@linbit.com>
References: <20220406190445.1937206-1-christoph.boehmwalder@linbit.com>
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

From: Xiaomeng Tong <xiam0nd.tong@gmail.com>

The bug is here:
	idr_remove(&connection->peer_devices, vnr);

If the previous for_each_connection() don't exit early (no goto hit
inside the loop), the iterator 'connection' after the loop will be a
bogus pointer to an invalid structure object containing the HEAD
(&resource->connections). As a result, the use of 'connection' above
will lead to a invalid memory access (including a possible invalid free
as idr_remove could call free_layer).

The original intention should have been to remove all peer_devices,
but the following lines have already done the work. So just remove
this line and the unneeded label, to fix this bug.

Cc: stable@vger.kernel.org
Fixes: c06ece6ba6f1b ("drbd: Turn connection->volumes into connection->peer_devices")
Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Reviewed-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 9676a1d214bc..d6dfa286ddb3 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2773,12 +2773,12 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 
 	if (init_submitter(device)) {
 		err = ERR_NOMEM;
-		goto out_idr_remove_vol;
+		goto out_idr_remove_from_resource;
 	}
 
 	err = add_disk(disk);
 	if (err)
-		goto out_idr_remove_vol;
+		goto out_idr_remove_from_resource;
 
 	/* inherit the connection state */
 	device->state.conn = first_connection(resource)->cstate;
@@ -2792,8 +2792,6 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 	drbd_debugfs_device_add(device);
 	return NO_ERROR;
 
-out_idr_remove_vol:
-	idr_remove(&connection->peer_devices, vnr);
 out_idr_remove_from_resource:
 	for_each_connection(connection, resource) {
 		peer_device = idr_remove(&connection->peer_devices, vnr);
-- 
2.35.1

