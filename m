Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A640250E375
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242472AbiDYOnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242419AbiDYOny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:43:54 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8037E1C93C;
        Mon, 25 Apr 2022 07:40:49 -0700 (PDT)
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id C75B0121ADB;
        Mon, 25 Apr 2022 14:40:44 +0000 (UTC)
Received: from pdx1-sub0-mail-a217.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id CCCC6120E91;
        Mon, 25 Apr 2022 14:40:43 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1650897643; a=rsa-sha256;
        cv=none;
        b=pzn09w4erkwNvrwR9LXn6lwlyZ9J99IwIRoCpO5e5B4KfStKgfhWHeu1lgFUFQ4bkQGpJW
        wdXvG2WH+RaogjEAa5nwn3+YEFg0hUc+2libiPQsLb2m7HhBQ1rpkSO6nbfNNB3qTihrBy
        4mH44qATtYZ1VXIiJEnu+QwToGOUy47akzSrO0vUppvk08znAKE4MXtMp3Q1/nzoQbpad+
        rSOmlnAniMMFstheur7XibIyJPy73ESNh6ubCAW4TLbGeak1py4sM/b0qB1aO5mF35tcVP
        9bQBk58I/M8GLTcCYLzgXvQyNwbxr8nhnyqSepY3ukKDWZZ8gEnP+fyjGqqEEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1650897643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=s5AE6U1EnsQ1lOXAx7PW4d2cLdYTvCRln/x/datINi8=;
        b=uzZOqqgxbLoOGHgaiQYiKHnkTUmNo/luOeYKivI/9hx9NS6yUKsWkbr7emdS0cdfkGF5jP
        WB357sPxss2uGoAEsqerwv8dDHsIEZE+FmfF5AtY7xd0973ASa7XRHVTHyg+3HUuRKijmN
        Qs3dUPLN72vptBUV+1vhvvGVVzR00VAVEv7lG+XvXdbIOBMI8XUCo8KtEH246Ug/ywJ9Xy
        2BdEB5ubGe//jTeqOE62suqnbZ33fbtaXsyHJaID5QgF8cxQQlI9yIc8ND1iHZDcYGAw/J
        i6/ynlVrIL3tcxdJ/dWpAxOvZmqwbDwhcFP7zUFzmOKJTQAXUrjvL4jm3IEI8A==
ARC-Authentication-Results: i=1;
        rspamd-67b64f579b-dkhm9;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=ian@linux.cowan.aero
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|ian@linux.cowan.aero
X-MailChannels-Auth-Id: dreamhost
X-Skirt-Oafish: 772a72b76a7ff4c9_1650897644185_2468377285
X-MC-Loop-Signature: 1650897644185:3122545546
X-MC-Ingress-Time: 1650897644185
Received: from pdx1-sub0-mail-a217.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.112.55.255 (trex/6.7.1);
        Mon, 25 Apr 2022 14:40:44 +0000
Received: from localhost.localdomain (unknown [69.12.38.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ian@linux.cowan.aero)
        by pdx1-sub0-mail-a217.dreamhost.com (Postfix) with ESMTPSA id 4Kn73Z46qRz2d;
        Mon, 25 Apr 2022 07:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.cowan.aero;
        s=dreamhost; t=1650897643;
        bh=s5AE6U1EnsQ1lOXAx7PW4d2cLdYTvCRln/x/datINi8=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=60CnaySCcFNllPkqZb0ujrtLqTey6CLl+vSwXOGPi5LntkMcThyBaofV+KdrVQUTe
         z+WfAylHlobJ45fZn/LTbHQ8DnbMR4yzUko1nV+pMgRysGWjmDB+N0JuuSBo4GF1QH
         +XRCuX7TtA1sjVgJI+R7Cnbqz22KkqGsEQAQ7stnWkevTsFQpP8/TeCmiDi/z9CIeN
         2/G3cHvaytG5C8GbEBU5mkb9EplsHBQ7oHzud0U7rnc4dKEjkIyNT6HQ2yCzjjiaTI
         vBEhKThZWlLAtg3+L3Luj87xVcsjhubnkJ/D7avJDSFYHviB/Jqia8wl6M13+jIVUu
         Oakig734dQWjg==
From:   Ian Cowan <ian@linux.cowan.aero>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mjpeg-users@lists.sourceforge.net, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ian Cowan <ian@linux.cowan.aero>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v2 2/4] staging: media: zoran: setup videocodec header for debugging macros
Date:   Mon, 25 Apr 2022 10:40:30 -0400
Message-Id: <20220425144030.132898-1-ian@linux.cowan.aero>
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
index 42b86356c022..674658154e88 100644
--- a/drivers/staging/media/zoran/zoran.h
+++ b/drivers/staging/media/zoran/zoran.h
@@ -20,6 +20,7 @@
 
 #include <linux/debugfs.h>
 #include <linux/dev_printk.h>
+#include <linux/i2c-algo-bit.h>
 #include <media/v4l2-device.h>
 #include <media/v4l2-ctrls.h>
 #include <media/videobuf2-core.h>
-- 
2.35.1

