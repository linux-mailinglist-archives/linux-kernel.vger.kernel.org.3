Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE1050D689
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 03:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240133AbiDYB3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 21:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbiDYB3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 21:29:36 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B23D117A;
        Sun, 24 Apr 2022 18:26:34 -0700 (PDT)
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id D5FC6801B70;
        Mon, 25 Apr 2022 01:26:33 +0000 (UTC)
Received: from pdx1-sub0-mail-a217.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 35B6A801A4A;
        Mon, 25 Apr 2022 01:26:31 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1650849991; a=rsa-sha256;
        cv=none;
        b=iRRJFa1e/JA+9YzA3x+wb3FEMytBTLDQ+5EXv21unfUDQA25oxtUOo7dEo0gp6aFacLqvO
        R7MDTX7x7BCrhOxRCK5YkY1wpcqsMWO44sod03NvgYXnUsvxX0Kb4hhV7dFqLQFjGaMtL2
        uPYGHfo7ur8aJ4dveSWJoW5s0q1bkAwpuT92rKhplSKyxibKwaVflSYPgJrzIISi8+qEgF
        n9v/U1dq4/HRU1hQ+36JAywcny6IH9Rqgn48y5UYKbO0SGm1cqJChAR2Hhi9O0FxHgusVs
        IbpR1YMSOdeik2cDWx6xIu0yaw5pfyfFkfXc2GRjSW5miKjNXZ6WBk5TuwtxBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1650849991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=03zhN+hBW8OaOUeJAmtwzMX7G3KCH/6OA0MvZT3k0A8=;
        b=nuAgkgp7Pg+Z3fN13uwNt1MdqXTy+X3VGumLIHT7D88iSV0AiMgM7j56H6GvNBm1LEV3vS
        b875xM//hAf4dW2acvVuJISV2AhehBuTllfX1r3DohJzsfN9IixRbMyJ+Ay4G/IIXctlE+
        KhcGkNtaJwyvHbEu2QjUDWbQ3UZ+OB9Tah+xCuvMFU2Br1GrCotf+7x0GtCPHIiI2b/LeA
        ieKKzNGR1V0P5LD3GKMSeIYsu7BaEx+LVRHtQrL0fRST6cK9+A0ESYlkkoe6MTqxNN95Hd
        8y6zr0aghBdElbaP9yLrCCtlqKhAncRBj95Fw8cj+dc3tkSvPrJYlBc8Z23MZg==
ARC-Authentication-Results: i=1;
        rspamd-67b64f579b-chnfp;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=ian@linux.cowan.aero
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|ian@linux.cowan.aero
X-MailChannels-Auth-Id: dreamhost
X-Daffy-Grain: 201401b6165c6f65_1650849993595_2915795923
X-MC-Loop-Signature: 1650849993595:373555036
X-MC-Ingress-Time: 1650849993595
Received: from pdx1-sub0-mail-a217.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.112.55.255 (trex/6.7.1);
        Mon, 25 Apr 2022 01:26:33 +0000
Received: from localhost.localdomain (unknown [69.12.38.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ian@linux.cowan.aero)
        by pdx1-sub0-mail-a217.dreamhost.com (Postfix) with ESMTPSA id 4KmnRB1WCMznZ;
        Sun, 24 Apr 2022 18:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.cowan.aero;
        s=dreamhost; t=1650849991;
        bh=03zhN+hBW8OaOUeJAmtwzMX7G3KCH/6OA0MvZT3k0A8=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=vchpmPZdFA4Ks5K5zDB+4D5GE7YuOWIy/yeW8O6dmBFHGJvUvKo5E3aj0PUxtg9nq
         hpzyyOkVqBdbdtj1T8ah7ZWokZKZ/SSEuh8mf6dQA70c0we0Bnh0RPS79yeyvC2vo8
         x7Og8PNrPqWHttmHw7hmBnODVGYnNZmzcazk4dG7uH/Q03Fxv8zklmF+A5FMrS+1E/
         gKuMA0deqXuHcz5YeyTGJOlGZ+t+ZTX54IE4row92B8WClQjrPO3F0e87DU8/afBB7
         AXQcMum/2mia6ZJrxVBS2fSv9iUKcnAI9OUH4UjwD3VGTz8FPxsVtAHSZLg697EuN4
         UrluQzBMa50zQ==
From:   Ian Cowan <ian@linux.cowan.aero>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mjpeg-users@lists.sourceforge.net, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ian Cowan <ian@linux.cowan.aero>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 1/4] staging: media: zoran: add logging macros
Date:   Sun, 24 Apr 2022 21:26:18 -0400
Message-Id: <20220425012618.440474-1-ian@linux.cowan.aero>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 
+/**
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

