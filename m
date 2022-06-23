Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45E9557F04
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 17:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbiFWPyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 11:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiFWPx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 11:53:59 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9741F2CA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 08:53:58 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r20so8149959wra.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 08:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AzWkSdITxtKnuLuZL/Fv67AsU2AcECJXh+BQCDnwU0M=;
        b=QjCRDVEecT4fKPe08R9H3SnfHguAeQ0sfPjqNoFw1jNO21QGhoXTXhCWNFzso1F9/W
         lT4vPdhfruLPa+wRrFodYrqSuexHG87/0L4ycTyJmo61Mr7vmCf7w9uGPv17ga3Q9Fbl
         L0gTT1VJfrFbOVXTKRHQsTJlg2r07DGfOn4BHBhb3vevXaPHs8pu4grEIQdhnkgY3ixG
         1sEEzASz+FG1D5dVae7ReYlb4eRIdvtbFeFvxC1raox2+bvEmfW54qfP+fYJCzRk1HtR
         dpe1CJlASnfmjqo6GdoEJ3NQNOWfSKzjsgMg52mMGUJUEuZ7h2zGccLb1e/bjYtsMu3V
         pN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AzWkSdITxtKnuLuZL/Fv67AsU2AcECJXh+BQCDnwU0M=;
        b=2tzJjQq2tiQam3sQZzTh+DAauGc5RSsd0183UDEruOYadvG8Xv3XgsujKtq6o+kHmY
         Nr2A8dxR9f3sizuUzB/gsRUG5d7hPlOL2NQeca2+s9Nx5VjbPkPVwgpJJqH8ynbogy2x
         DiA5+xs+oXKO+AjNFAFttewkqjIW1mu8TKGDdwaC43mA5zlRmxLjwTMFORoyHx7Pfm+k
         F+jDeoMRP4tqhdHt/gTGMBeakJWXGNZzGliCDGjJbmVo7arRd5oOou3etdTmIgHASQ2O
         ikX+NnAwjvaxg0W99RAjiKBg7WNTJUpbCuChjDMX9T5tXQaU/NXqwq1Yx0tVn6UmaRt5
         xIHg==
X-Gm-Message-State: AJIora+j272XWoAhpmZYZVKb03s44K7+5KjaSpv5qdwn2d//zB9IDQCo
        +o0jQgqhQ8BNVQuMTL48dXJZaQ==
X-Google-Smtp-Source: AGRyM1uPP+8LNOjo6dYC2uhTTph4CWTUWdFGOV9OIlsAc02wQb1TWjMdfga7aPdMgqj7aahLlJSMpw==
X-Received: by 2002:a05:6000:381:b0:21b:9a20:6543 with SMTP id u1-20020a056000038100b0021b9a206543mr9166495wrf.127.1655999636670;
        Thu, 23 Jun 2022 08:53:56 -0700 (PDT)
Received: from OPPO-A74.station (net-37-182-48-184.cust.vodafonedsl.it. [37.182.48.184])
        by smtp.gmail.com with ESMTPSA id n10-20020adffe0a000000b0021b5861eaf7sm20650830wrr.3.2022.06.23.08.53.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jun 2022 08:53:56 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, andrea.righi@canonical.com, glen.valante@linaro.org,
        arie.vanderhoeven@seagate.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 2/8] block, bfq: forbid stable merging of queues associated with different actuators
Date:   Thu, 23 Jun 2022 17:53:29 +0200
Message-Id: <20220623155335.6147-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220623155335.6147-1-paolo.valente@linaro.org>
References: <20220623155335.6147-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If queues associated with different actuators are merged, then control
is lost on each actuator. Therefore some actuator may be
underutilized, and throughput may decrease. This problem cannot occur
with basic queue merging, because the latter is triggered by spatial
locality, and sectors for different actuators are not close to each
other. Yet it may happen with stable merging. To address this issue,
this commit prevents stable merging from occurring among queues
associated with different actuators.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 98e0c454f5bc..52fc3930b889 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5695,9 +5695,13 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
 	 * it has been set already, but too long ago, then move it
 	 * forward to bfqq. Finally, move also if bfqq belongs to a
 	 * different group than last_bfqq_created, or if bfqq has a
-	 * different ioprio or ioprio_class. If none of these
-	 * conditions holds true, then try an early stable merge or
-	 * schedule a delayed stable merge.
+	 * different ioprio, ioprio_class or actuator_idx. If none of
+	 * these conditions holds true, then try an early stable merge
+	 * or schedule a delayed stable merge. As for the condition on
+	 * actuator_idx, the reason is that, if queues associated with
+	 * different actuators are merged, then control is lost on
+	 * each actuator. Therefore some actuator may be
+	 * underutilized, and throughput may decrease.
 	 *
 	 * A delayed merge is scheduled (instead of performing an
 	 * early merge), in case bfqq might soon prove to be more
@@ -5715,7 +5719,8 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
 			bfqq->creation_time) ||
 		bfqq->entity.parent != last_bfqq_created->entity.parent ||
 		bfqq->ioprio != last_bfqq_created->ioprio ||
-		bfqq->ioprio_class != last_bfqq_created->ioprio_class)
+		bfqq->ioprio_class != last_bfqq_created->ioprio_class ||
+		bfqq->actuator_idx != last_bfqq_created->actuator_idx)
 		*source_bfqq = bfqq;
 	else if (time_after_eq(last_bfqq_created->creation_time +
 				 bfqd->bfq_burst_interval,
-- 
2.20.1

