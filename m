Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8640251109C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 07:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243435AbiD0Fpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 01:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357925AbiD0Fpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 01:45:32 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A00157812
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 22:42:21 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b24so656821edu.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 22:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7Twn2M/aG8ry6M+Vp8Ty89zIl1BTO6nNE/uGo9m1G2I=;
        b=IvSlC5IeQ61BTR+fxOTMquh3dwuQQfW1I+isdOGbUdT49h/y64bYg1Ty+GvEVNOhv8
         31+qIsY8xdKeex8USo8QV/0IXc4KYuxzwqa9CZC0cJkMauWZ0PuGXMCx3rCbwoYLkFjS
         4xOPWR+3A/qsz6qGddKAA02IteAE8/4O+rV+Q89lqVPXX6CQ4PpdY1T1fhmad34vvKiD
         zb3nw4sLrMMGvkCNaaKkPXQsL/RF29f+6i4cSngwybyXhrxy7LHRjGHwbVVcEqFBQmUS
         omzGwZwjawsUkir7wKaGII2hmJp0F2MAZ9kfYjw4/4mHfAzW+RyB3c77pvbx9h7aNuzw
         +TeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7Twn2M/aG8ry6M+Vp8Ty89zIl1BTO6nNE/uGo9m1G2I=;
        b=lQuJ2PGkhiziekk2BM64cq7jtEMqGIpPNwHyH4XYCp6FZUJ0ou2i4LY6Coweu0tlMi
         Y8QASbe7uHpRQvHt/mRwUF1oUk9x20z5my6oGgMJfv8jgmBxNUK8WFfmzvs0w760N1Tx
         NZ6tqeI6IWKMFwpSMpxjtjnJJ/233k5qaYumi25j66QgLWXK1F8XuB4lhqxalQRwVuAD
         FfxlNV/N17VbPsHQzSa0y+xoaMy5yWaMAIsPTfDvA1HhLaOhM4HkcJGvvmm342yZgpmv
         +633DA30YsbB8xmd1kED1ZyLNUpXYqPHm5vRjjGKPpyeQn6gjqZHd6jokiRFopV6ZLkf
         VyBw==
X-Gm-Message-State: AOAM532gIot+LsGpND3WuOh6KJoFGAAwUGWuctJKzew+Uyh5ZxX8sv9k
        lCAbN9IbFj/hEING1MWugLCEahfela6UQg==
X-Google-Smtp-Source: ABdhPJxaCxDvGhtQBBVE51ECwdwSwARlL6R5jtujsL7EP4+OhDh2fnTtoq8VMJ9KPoplaOsUtCgR8w==
X-Received: by 2002:aa7:d310:0:b0:425:f22f:763f with SMTP id p16-20020aa7d310000000b00425f22f763fmr12066122edq.163.1651038140447;
        Tue, 26 Apr 2022 22:42:20 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id y3-20020a50ce03000000b00425bfb7f940sm7571748edi.11.2022.04.26.22.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 22:42:20 -0700 (PDT)
Date:   Wed, 27 Apr 2022 07:42:18 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] staging: vt6655: Replace MACvReadISR with VNSvInPortD
Message-ID: <ddd403a3f590cb81403197442b12c3986c98ba25.1651036713.git.philipp.g.hortmann@gmail.com>
References: <cover.1651036713.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1651036713.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace macro MACvReadISR with VNSvInPortD and as it was the only
user, it can now be removed.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: Shorted and simplified patch description
V2 -> V3: Added missing version in subject
---
 drivers/staging/vt6655/device_main.c | 4 ++--
 drivers/staging/vt6655/mac.h         | 3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 7cceb57a5139..c21787f32252 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1029,7 +1029,7 @@ static void vnt_interrupt_process(struct vnt_private *priv)
 	u32 isr;
 	unsigned long flags;
 
-	MACvReadISR(priv->port_offset, &isr);
+	VNSvInPortD(priv->port_offset + MAC_REG_ISR, &isr);
 
 	if (isr == 0)
 		return;
@@ -1116,7 +1116,7 @@ static void vnt_interrupt_process(struct vnt_private *priv)
 		    ieee80211_queue_stopped(priv->hw, 0))
 			ieee80211_wake_queues(priv->hw);
 
-		MACvReadISR(priv->port_offset, &isr);
+		VNSvInPortD(priv->port_offset + MAC_REG_ISR, &isr);
 
 		MACvReceive0(priv->port_offset);
 		MACvReceive1(priv->port_offset);
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 74b45e1f0963..5aaa0de20e67 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -666,9 +666,6 @@ do {									\
 	VNSvOutPortB(iobase + MAC_REG_STICKHW, byOrgValue);		\
 } while (0)
 
-#define MACvReadISR(iobase, pdwValue)				\
-	VNSvInPortD(iobase + MAC_REG_ISR, pdwValue)
-
 #define MACvWriteISR(iobase, dwValue)				\
 	VNSvOutPortD(iobase + MAC_REG_ISR, dwValue)
 
-- 
2.25.1

