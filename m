Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7939C51D0A9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 07:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389143AbiEFFb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 01:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380574AbiEFFb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 01:31:56 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20919B54;
        Thu,  5 May 2022 22:28:14 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 61A432C0E70;
        Fri,  6 May 2022 05:28:13 +0000 (UTC)
Received: from pdx1-sub0-mail-a243.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id D74002C0F78;
        Fri,  6 May 2022 05:28:12 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1651814893; a=rsa-sha256;
        cv=none;
        b=Yg2xDVG4lFNdurDew2nkCoScQvcbN35P1j5R/YWLJE6ExSrTmSs70Fzf5Kd5/cBsc+yaeX
        Lz53rDTT89uralHWOz5MBChAwv9eE8yWcCCHR88MGTOKIvHN/r0yHFmG2J4/7ydyW5zED3
        OdTZGXJN/mxWZ38f80kkaUO9TbSqypT+8sjtQt4sXGI2Ice7t//DI2nYoAt43Qs4IQYQfo
        bnULBIyxlwIeiCTwRiX9oudSuX9j7iZI7y8bnAa/2rL/sVs9j3ezS8BneRkZNHEEYZRVr6
        dS7tQ42GXP+Yz6u4eP5Pup9enTny24GaziL+n1Noc85YJoArv17Vlor7esJohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1651814893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=0dA6jT+EL40ZJ+80iJLHF2mzSScBCF9xe9/bVhB5W28=;
        b=Dh8FTbUJUdfjHUmULAI8Q3XT9xaJ/G7D2xy476UYUEB3Ao9ezd8gjMW6VCtlyZN479r5WG
        EmphkvekoGLp3bDrnVABGZGEgc9gKsYMBBb2sdihg1pAmKcvqUPfeMWbAQbT6Vw4axav3M
        RkYo8se9/AP0RNVEmfO0cqZxwGrHPmoW5fTFTeAIqlcw1jpM7qIrkI1q9wVC4xp5m++WFJ
        RJdKvKkVUiMLyKDCKyZOVCWsiUdKsT/YwIZVRcITe1PjT0ft7x1fsuk6x82pgfvTjSXcSD
        613P213oAcZREPlSKmJxvWbIEmtjxtaoyZaWpNOzPNCX3kVZt89JI9JrztidyQ==
ARC-Authentication-Results: i=1;
        rspamd-fdd564cbf-jzqrc;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=ian@linux.cowan.aero
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|ian@linux.cowan.aero
X-MailChannels-Auth-Id: dreamhost
X-Bored-Descriptive: 396a819c38b86c9f_1651814893244_2034114551
X-MC-Loop-Signature: 1651814893244:2277536638
X-MC-Ingress-Time: 1651814893244
Received: from pdx1-sub0-mail-a243.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.38.172 (trex/6.7.1);
        Fri, 06 May 2022 05:28:13 +0000
Received: from localhost.localdomain (unknown [69.12.38.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ian@linux.cowan.aero)
        by pdx1-sub0-mail-a243.dreamhost.com (Postfix) with ESMTPSA id 4KvfH003mrz2M;
        Thu,  5 May 2022 22:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.cowan.aero;
        s=dreamhost; t=1651814892;
        bh=0dA6jT+EL40ZJ+80iJLHF2mzSScBCF9xe9/bVhB5W28=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=1gMNUGpJqSsaK7jLCkEZAv7l8lp1tF5c3N7tvJIPR4rI6v/QBZGWT0hOMbyl5RZT9
         s9N8oSmmkEiULdzfQPPXEhfMfxwmrtjDx3/j3wycroJAJ3+YGXNSJiQgQ2vCACEcfB
         /7NbMQ00PiyoKnMD5EV/AQnQXRlhxWZYVceNQRyclWvbk3sR3cA00O4xghsMPii1tF
         8oGmgkzeIH6Ng79NODYjuiuvVo7MxCFVGtJ27P7z1GW2sVZe96xAmJX4sBdR9CwVPP
         Uo/zcyF6p18eObAr7fxeiouZydyFErMm6Z6SaeCpJ9DKeKA1ipI0/WvcRHUE5zL+TA
         WMu3LPWlPfgbQ==
From:   Ian Cowan <ian@linux.cowan.aero>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mjpeg-users@lists.sourceforge.net, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ian Cowan <ian@linux.cowan.aero>
Subject: [PATCH v3 1/4] staging: media: zoran: add logging macros
Date:   Fri,  6 May 2022 01:28:00 -0400
Message-Id: <20220506052800.191910-1-ian@linux.cowan.aero>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the zrdev_dbg() (pointing to pci_dbg()), zrdev_err() (pointing
to pci_err()), and zrdev_info() (pointing to pci_info()) macros to the
zoran drivers. These are the preferred method for debugging and this
will allow to extract the device from the zoran struct to make the call.

Signed-off-by: Ian Cowan <ian@linux.cowan.aero>
---
 drivers/staging/media/zoran/zoran.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/staging/media/zoran/zoran.h b/drivers/staging/media/zoran/zoran.h
index 654c95fa5aba..4f7f71d8e93c 100644
--- a/drivers/staging/media/zoran/zoran.h
+++ b/drivers/staging/media/zoran/zoran.h
@@ -19,6 +19,7 @@
 #define _BUZ_H_
 
 #include <linux/debugfs.h>
+#include <linux/pci.h>
 #include <media/v4l2-device.h>
 #include <media/v4l2-ctrls.h>
 #include <media/videobuf2-core.h>
@@ -301,6 +302,18 @@ static inline struct zoran *to_zoran(struct v4l2_device *v4l2_dev)
 
 #endif
 
+/*
+ * Debugging macros
+ */
+#define zrdev_dbg(zr, format, args...) \
+	pci_dbg(zr->pci_dev, format, ##args) \
+
+#define zrdev_err(zr, format, args...) \
+	pci_err(zr->pci_dev, format, ##args) \
+
+#define zrdev_info(zr, format, args...) \
+	pci_info(zr->pci_dev, format, ##args) \
+
 int zoran_queue_init(struct zoran *zr, struct vb2_queue *vq, int dir);
 void zoran_queue_exit(struct zoran *zr);
 int zr_set_buf(struct zoran *zr);
-- 
2.35.1

