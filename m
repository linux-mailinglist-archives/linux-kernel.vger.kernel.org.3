Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8EB51D0AB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 07:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389157AbiEFFcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 01:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389116AbiEFFcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 01:32:18 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC29521A6
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 22:28:34 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 823B7121C95;
        Fri,  6 May 2022 05:28:30 +0000 (UTC)
Received: from pdx1-sub0-mail-a243.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id CED19120F26;
        Fri,  6 May 2022 05:28:29 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1651814910; a=rsa-sha256;
        cv=none;
        b=MCs2RtuUlcayRwTLZO/DUNafNnHJthrAELGG3uUIeGxWkD+aA5XSrsW25HBWV16MmCj237
        o41sw1Y4spiNjrAvnobP10c+d2AEppvYQhfvJLgN5RsE1Q6D7T2t/VudVhIR/c5a6+2InO
        zy/nTjG2Qz+SK9DOwSgeluyIGE3GWZegNBipe0+tIChVI1ZxCltQvvfGiZFv6PP1w3KcHk
        rC5KlUAEdzZHegcT8ug/xwnO1Sf/OmnAlMSWicI0zIz1cLVXkfC4YwEcBhIS1T5H4H2O+0
        NpClnaSAYMtUTjuUxEVhXPtkijOHFvxyl3JBhbwIKj2eLfVc37BVFVwF3LxfrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1651814910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=Akyb2XJfQ+IAzgEmanOrD6MMLzBWKctRb82PKzfcvQg=;
        b=hAkVe6RoxMgCc8R5pFF2z/eTZXb5MFXgs//RxvFhun3RLDnsM/HouTgIInVi1qBko392Gn
        qodcpXUSMM4UV7ynT6/8X/aWGtJQQDseI2Owk4MQ9cWTHflkLfLQIDLnblnugKB4oCTKJP
        WYbRGvEOqWGpp5WbPGb+yLVGpZNzhQn4CnT7mlXI3U7dK0CPWDQEMcDh8ZZd7ELjVIcI6w
        Sy2nHKsBWyTNBIR6PwSTcq6YCPxcTuxYU+giybyL9UINpiOZMtAjTA2FDYa7r6facUtHh/
        5lSDhEzMXfbH8fG/pdTitxdG3pOZSw5KDttUHuYCOd9lN60L2ZsKY8oar0hRIg==
ARC-Authentication-Results: i=1;
        rspamd-fdd564cbf-x7f5k;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=ian@linux.cowan.aero
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|ian@linux.cowan.aero
X-MailChannels-Auth-Id: dreamhost
X-Trail-Shelf: 1aaf0c2d4d529953_1651814910349_2794654197
X-MC-Loop-Signature: 1651814910349:1402094156
X-MC-Ingress-Time: 1651814910349
Received: from pdx1-sub0-mail-a243.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.112.55.199 (trex/6.7.1);
        Fri, 06 May 2022 05:28:30 +0000
Received: from localhost.localdomain (unknown [69.12.38.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ian@linux.cowan.aero)
        by pdx1-sub0-mail-a243.dreamhost.com (Postfix) with ESMTPSA id 4KvfHJ6nWJz2M;
        Thu,  5 May 2022 22:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.cowan.aero;
        s=dreamhost; t=1651814909;
        bh=Akyb2XJfQ+IAzgEmanOrD6MMLzBWKctRb82PKzfcvQg=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=c+X01cZGY+qHqs9NRak5k7m5nR7uG37z0E9STqOlUwqe/ih0QdNBokDLFKex58sir
         7ipiQiz7kh47f8SEIzSTrB6MzXnHcxMXTbwSOnFrYpOP8ZfaoctliNIcveyadQR3jM
         b5DInGuxkWgcul+z03bmxBxK0SnM4XZY0p5r5vw4NSO/6JxTnR5tcMqVAb6vTkvRWc
         cgH1Tj3681WiXc3qNnfJzjHmhbMxOdwd+9sy5nG+qJFh4N4ekNm6Ck2TiZLV3VSLEJ
         dDoxfZAPFQYsltZcLYfNGypsYbs1BNQS+y6BrEBEiQB2eTWOwqQMdxeFsdZAHg8/zk
         oJM3QtpNv6JEw==
From:   Ian Cowan <ian@linux.cowan.aero>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mjpeg-users@lists.sourceforge.net, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ian Cowan <ian@linux.cowan.aero>
Subject: [PATCH v3 2/4] staging: media: zoran: setup videocodec header for debugging macros
Date:   Fri,  6 May 2022 01:28:19 -0400
Message-Id: <20220506052819.192151-1-ian@linux.cowan.aero>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds inline functions in the videocodec header file to convert the
videocodec and videocodec_master structs to their respective contained
zoran struct. This will be used to pass the zoran struct to the
zrdev_XXX() macros defined in the zoran header.

In the zoran header, the new include is added to ensure all variables
can be completely defined with the zoran and videocodec includes where
they are located.

Signed-off-by: Ian Cowan <ian@linux.cowan.aero>
---
 drivers/staging/media/zoran/videocodec.h | 15 +++++++++++++++
 drivers/staging/media/zoran/zoran.h      |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/staging/media/zoran/videocodec.h b/drivers/staging/media/zoran/videocodec.h
index 9dea348fee40..5e6057edd339 100644
--- a/drivers/staging/media/zoran/videocodec.h
+++ b/drivers/staging/media/zoran/videocodec.h
@@ -307,4 +307,19 @@ extern int videocodec_unregister(const struct videocodec *);
 
 int videocodec_debugfs_show(struct seq_file *m);
 
+#include "zoran.h"
+static inline struct zoran *videocodec_master_to_zoran(struct videocodec_master *master)
+{
+	struct zoran *zr = master->data;
+
+	return zr;
+}
+
+static inline struct zoran *videocodec_to_zoran(struct videocodec *codec)
+{
+	struct videocodec_master *master = codec->master_data;
+
+	return videocodec_master_to_zoran(master);
+}
+
 #endif				/*ifndef __LINUX_VIDEOCODEC_H */
diff --git a/drivers/staging/media/zoran/zoran.h b/drivers/staging/media/zoran/zoran.h
index 4f7f71d8e93c..2a8635d08b73 100644
--- a/drivers/staging/media/zoran/zoran.h
+++ b/drivers/staging/media/zoran/zoran.h
@@ -20,6 +20,7 @@
 
 #include <linux/debugfs.h>
 #include <linux/pci.h>
+#include <linux/i2c-algo-bit.h>
 #include <media/v4l2-device.h>
 #include <media/v4l2-ctrls.h>
 #include <media/videobuf2-core.h>
-- 
2.35.1

