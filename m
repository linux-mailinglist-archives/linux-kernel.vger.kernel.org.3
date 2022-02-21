Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72A84BEC9E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 22:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbiBUVZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 16:25:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbiBUVZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 16:25:44 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B39C12AE8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 13:25:20 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id w3so32034858edu.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 13:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hRNEJYkXr+PwSGSW5oI3rp0CXIsPeHFtIOlhCAUsWYo=;
        b=Og3vrovv6LTZwDBZk1v459NGVWUMEHl6mUBfs/6JKezdMuBldc2tHbo614J6H/39ec
         m8W+9YGfXZnCZ9xoYRGIBDqEBeJ8q90A8Vzgtxq2nqLgDwrBaitIZboNLsV9ks8mpR3z
         lfxw5Q3lJHJboK8Eu8qQC/G6BnSkJeWDayF3anq2zCAcDW2Gyv72QW+tAurVtle++97c
         4q98CoxPo2dW6A9FHJSJqmDCVGO3K/A4tBsnjElGHbeK3kTBn41nhOc4pe6zDz4MIMk8
         hV00lF7vi5VupVJYx5NUJzZpqjhydSagD1oCi8l/9ItkcEywO5SoibblZaL6GOJCwUDU
         dcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hRNEJYkXr+PwSGSW5oI3rp0CXIsPeHFtIOlhCAUsWYo=;
        b=WzN2w0N3juN+9PcztBTPFprJFM56mA3w/oJGQZqubynHKOQgZkLGBMBkfuktSlaXv5
         X58rL91YIXayCGVZ2c5vYLPiRohkajdV3oAzbsaXs+bz6hTEvJVxjrv4UJrOiBc8jkgv
         c5jCAjzKsoQIa2+Z6pVSyt2dZoSZCAcn9IxxbPzrmhLOzFX0B6BPRZ0UMLV+pyiaq7kp
         YeT2SbX5v60MQOavN0yc/WNbiBdPsdQrPChMwd93dU8qCXmHf/gSfLJrjH1igqawYTLc
         DeO3t2dX+sFkY4eQ9j6luxQix8aWkET8ANuOAOPP2bGsuFcASqd8bQTiXJVwfbpvnCzp
         G11w==
X-Gm-Message-State: AOAM532H+NOk0+pMzMkdKakmzRgisLjUwbaixTo3PoCLgXTWuN6wWyOx
        AEUqjuP3q+Mg9KCo+BBSm9o=
X-Google-Smtp-Source: ABdhPJzmtpRHxuS6X84WUIbiaEuDt83WewKyJDe0iPuKShXYAJZWJN9IGS53x868g7pBjR4OsBHlkw==
X-Received: by 2002:a05:6402:5209:b0:412:7cd8:a8fc with SMTP id s9-20020a056402520900b004127cd8a8fcmr23392496edd.51.1645478718822;
        Mon, 21 Feb 2022 13:25:18 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935aa6.dip0.t-ipconnect.de. [87.147.90.166])
        by smtp.gmail.com with ESMTPSA id ho34sm1660725ejc.122.2022.02.21.13.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 13:25:18 -0800 (PST)
Date:   Mon, 21 Feb 2022 22:25:16 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] staging: vt6656: Change macro to function and moved
 to better file
Message-ID: <fa37dde640cfe5093ff23ca0881aba4673751a49.1645477326.git.philipp.g.hortmann@gmail.com>
References: <cover.1645477326.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1645477326.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warning like:
- CHECK: Macro argument reuse 'uVar' - possible side-effects?
Moved the only twice used function to the file where it is used.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: Devided patch into three
---
 drivers/staging/vt6656/device.h |  7 -------
 drivers/staging/vt6656/wcmd.c   | 13 +++++++++++--
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/vt6656/device.h b/drivers/staging/vt6656/device.h
index 0ab2d60204e8..ca974d61d3f4 100644
--- a/drivers/staging/vt6656/device.h
+++ b/drivers/staging/vt6656/device.h
@@ -381,13 +381,6 @@ struct vnt_private {
 	struct ieee80211_low_level_stats low_stats;
 };
 
-#define ADD_ONE_WITH_WRAP_AROUND(var, modulo) {	\
-	if ((var) >= ((modulo) - 1))			\
-		(var) = 0;				\
-	else						\
-		(var)++;				\
-}
-
 int vnt_init(struct vnt_private *priv);
 
 #endif
diff --git a/drivers/staging/vt6656/wcmd.c b/drivers/staging/vt6656/wcmd.c
index e8ee2fbee76c..14b8aa587119 100644
--- a/drivers/staging/vt6656/wcmd.c
+++ b/drivers/staging/vt6656/wcmd.c
@@ -31,6 +31,15 @@ static void vnt_cmd_timer_wait(struct vnt_private *priv, unsigned long msecs)
 	schedule_delayed_work(&priv->run_command_work, msecs_to_jiffies(msecs));
 }
 
+static u32 add_one_with_wrap_around(u32 var, u8 modulo)
+{
+	if (var >= (modulo - 1))
+		var = 0;
+	else
+		var++;
+	return var;
+}
+
 static int vnt_cmd_complete(struct vnt_private *priv)
 {
 	priv->command_state = WLAN_CMD_IDLE;
@@ -42,7 +51,7 @@ static int vnt_cmd_complete(struct vnt_private *priv)
 
 	priv->command = priv->cmd_queue[priv->cmd_dequeue_idx];
 
-	ADD_ONE_WITH_WRAP_AROUND(priv->cmd_dequeue_idx, CMD_Q_SIZE);
+	priv->cmd_dequeue_idx = add_one_with_wrap_around(priv->cmd_dequeue_idx, CMD_Q_SIZE);
 	priv->free_cmd_queue++;
 	priv->cmd_running = true;
 
@@ -157,7 +166,7 @@ int vnt_schedule_command(struct vnt_private *priv, enum vnt_cmd command)
 
 	priv->cmd_queue[priv->cmd_enqueue_idx] = command;
 
-	ADD_ONE_WITH_WRAP_AROUND(priv->cmd_enqueue_idx, CMD_Q_SIZE);
+	priv->cmd_enqueue_idx = add_one_with_wrap_around(priv->cmd_enqueue_idx, CMD_Q_SIZE);
 	priv->free_cmd_queue--;
 
 	if (!priv->cmd_running)
-- 
2.25.1

