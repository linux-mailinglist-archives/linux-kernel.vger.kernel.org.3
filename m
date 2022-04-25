Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCE050D68A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 03:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240144AbiDYBaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 21:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240137AbiDYB37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 21:29:59 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94D6DAA3C;
        Sun, 24 Apr 2022 18:26:56 -0700 (PDT)
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id BA3F98E0B9F;
        Mon, 25 Apr 2022 01:26:55 +0000 (UTC)
Received: from pdx1-sub0-mail-a217.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 1F2C88E0E54;
        Mon, 25 Apr 2022 01:26:55 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1650850015; a=rsa-sha256;
        cv=none;
        b=AJTc5pceriIXzpoC45Di3Lyrr0fstNJmdAtNj0FOFOjfmUoNEZlWGppsZdGv/vI+ErZSAU
        E9+IgGK8EuoxIagX2zShgaAW30/IpPu7jSkh29Ek0es61WQzLNiu3vWOZ8FNMHgs53mu9R
        +1jcIVkI17uGpJWpompXlWCgca5AmPBLSkpbmfvcO/USapf1q2kfRFkIVaHOCEHCm1dnz5
        kPx+Gnu7TOib0ghbqEHE4pcz7Rk3+ktCcabaUo562QOuiXq3AlyHhlHsj6iX8KSewyDvWa
        5cnztJicF0ceNb70JgLDLRtBTbbYUyh3xCwH0QCQPgADl7bkHEdfkMT/Oj3WSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1650850015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=s5AE6U1EnsQ1lOXAx7PW4d2cLdYTvCRln/x/datINi8=;
        b=tjFrNQgRa6H/A/f8j9f9/NckO8ZAQJTgsrh2poA+2gaU/MFdywciJh53FFteIgjMssUaT6
        1rlxC5whnRs4CFw60nBt4HiO5iS/fWJVWVdGCLtviciGb8jvnK2Od2fpcoqOwQO6zCs2NK
        rL+LV1lAFmERvpsKOsRbU/i7170+ku/AuXrGW8lw6M0xcBm5b1rEjHhly4BLvOOyIDI8Xo
        um/KrKsoQjYfqen6h+193Tnm5vuK9Tbg70Dbl2HOex47zGnaU5lp9KeKepS0e/2TKrMBGT
        KGxLODZuCdL0JQMW4u+IBS8lZbkOrYzIeAT29XyYiZE/TwS4FMIgWZRDkhSHZg==
ARC-Authentication-Results: i=1;
        rspamd-6dfbdcb948-tsjnr;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=ian@linux.cowan.aero
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|ian@linux.cowan.aero
X-MailChannels-Auth-Id: dreamhost
X-Bored-Turn: 1d5ead037e07d7bd_1650850015369_2800847731
X-MC-Loop-Signature: 1650850015369:3213417145
X-MC-Ingress-Time: 1650850015369
Received: from pdx1-sub0-mail-a217.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.127.95.118 (trex/6.7.1);
        Mon, 25 Apr 2022 01:26:55 +0000
Received: from localhost.localdomain (unknown [69.12.38.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ian@linux.cowan.aero)
        by pdx1-sub0-mail-a217.dreamhost.com (Postfix) with ESMTPSA id 4KmnRf0lvBz1K1;
        Sun, 24 Apr 2022 18:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.cowan.aero;
        s=dreamhost; t=1650850014;
        bh=s5AE6U1EnsQ1lOXAx7PW4d2cLdYTvCRln/x/datINi8=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=QxjzROhG7uV5c6ih0J1Jn1MWnplsVCDqINNSVCJqBwTNgBPkF3mMPaT/Fuqmu5bAF
         bSmyXGk6wjDvguQuSUHEW1Kngf6qzZqjtiPKz7IwqNd+90k0+gbuPRYD3ged5qhNJM
         AXdvWqauKCDpa2WOhm7AqcdHQCVYt5BxKld0lskveDrDFn1LHKkYLPVCpKQQsBZnrF
         Df9tZN71Y9Jdat46jQdrGh3/tebpgkWQxDaFF2iVr98sMHRCxZ+mxJ6XY+X3JoMkWa
         f/O/UJBiQ6kI7VQ96DzcFWDwoQPelKmJGixPYCcVmQz/2hLgsOIsGRg0CPnt5uzjvW
         HiH8lfdH19Yog==
From:   Ian Cowan <ian@linux.cowan.aero>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mjpeg-users@lists.sourceforge.net, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ian Cowan <ian@linux.cowan.aero>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 2/4] staging: media: zoran: setup videocodec header for debugging macros
Date:   Sun, 24 Apr 2022 21:26:40 -0400
Message-Id: <20220425012640.440717-1-ian@linux.cowan.aero>
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

