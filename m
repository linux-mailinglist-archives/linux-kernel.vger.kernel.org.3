Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A895C4F6BAE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbiDFUwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbiDFUvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:51:35 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614123CBF30
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 12:07:35 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id l26so6294069ejx.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 12:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0vcoWpko5M6BsO9WO6BZaEztSvAjnr2wIhZH0Y0nwWU=;
        b=mi8paDeGJ9FgOE5KAUIYIDlCD6t9WRIXW8Zbxzongj6zFKj7quoAet0fhWDUc5SmZZ
         xayddIqSEyI7Dea/HQIrpqGu5yheJHlfO1suXNQxYPDr5klhiDG31V04CeBKUxei7+ca
         0uTdz7MsCQGNpsEQ70paHowFP/DBIK5J6Fj6tWvzXh/hUpmCtlYstrUvlG+Xi7Rdloz/
         N3iDKbQcXbxEI5pj/fUur06ak9ZOnuD6GrGbyxTMSB+111T9S1hz1sv8/cNJS7W1FVSm
         rbKM2LzDMGzWgcX65SRXCJqlKq3vguzKAH5r7POFaeMyJ13qps80aqz+e8GmhQpmmike
         4C4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0vcoWpko5M6BsO9WO6BZaEztSvAjnr2wIhZH0Y0nwWU=;
        b=5qyWNB70FYQ9HHJsiRXZ7wIKwIgdGEfRNjuHHfwIiQqRzymyb40QwvTpTyr79zPktB
         J/kNXNDRoxfDcrRWrgwaablabzivaDIv3DBH8uJHyMQ7eM0KgAUBaw+uaek1F8BWj01v
         U1VCdbV5yddPLjjiX68pE4FX+xOTmaHcCdexM61CL1GxuJJLIa+rGhUzgSeJ+fZ/bb6n
         rKwEO48OLGPHtCa/P0rM1DFnVwpOynLJPdtWQjR5nW1iQ6yc/4C/fT6lgUui/q9deI3g
         Ls7CKMar1KtdQIuSLoUmPpTz3IUgCXdOY0qDydSRcnvX1Dm4uYBYOVOQbfoIgpxBMOXI
         AaTQ==
X-Gm-Message-State: AOAM530bsS7a5E8T/KR0Z7wo3CLFgTlH/1dchNdOtg01eztpqkmXb+JB
        v+bQvbGCiC0EHJ9lvcj3PiQ3/Q==
X-Google-Smtp-Source: ABdhPJwS75mCEvIsWowddkngt4NmRn8+jLBJvmrzPpQ7wLwXC5KAdkj6Vik6DmpRxwMlJAQJjznehg==
X-Received: by 2002:a17:907:6da3:b0:6e6:ec5e:c2f7 with SMTP id sb35-20020a1709076da300b006e6ec5ec2f7mr9677283ejc.309.1649272053940;
        Wed, 06 Apr 2022 12:07:33 -0700 (PDT)
Received: from localhost (85-127-190-169.dsl.dynamic.surfer.at. [85.127.190.169])
        by smtp.gmail.com with ESMTPSA id n5-20020a1709065e0500b006e4dae9b1besm6503475eju.145.2022.04.06.12.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 12:07:33 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 3/7] block: drbd: drbd_receiver: Remove redundant assignment to err
Date:   Wed,  6 Apr 2022 21:07:11 +0200
Message-Id: <20220406190715.1938174-4-christoph.boehmwalder@linbit.com>
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

From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Variable err is set to '-EIO' but this value is never read as
it is overwritten or not used later on, hence it is a redundant
assignment and can be removed.

Clean up the following clang-analyzer warning:

drivers/block/drbd/drbd_receiver.c:3955:5: warning: Value stored to
'err' is never read [clang-analyzer-deadcode.DeadStores].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 08da922f81d1..911c26753556 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3903,7 +3903,6 @@ static int receive_SyncParam(struct drbd_connection *connection, struct packet_i
 				drbd_err(device, "verify-alg of wrong size, "
 					"peer wants %u, accepting only up to %u byte\n",
 					data_size, SHARED_SECRET_MAX);
-				err = -EIO;
 				goto reconnect;
 			}
 
-- 
2.35.1

