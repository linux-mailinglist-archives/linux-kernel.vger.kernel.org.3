Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C6250EC25
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbiDYWgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 18:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiDYWgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 18:36:47 -0400
X-Greylist: delayed 458 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Apr 2022 15:33:40 PDT
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4886BDC996
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 15:33:39 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 413BB8011DB;
        Mon, 25 Apr 2022 22:25:38 +0000 (UTC)
Received: from pdx1-sub0-mail-a217.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id CB72980109A;
        Mon, 25 Apr 2022 22:25:37 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1650925537; a=rsa-sha256;
        cv=none;
        b=F/wx94kfenO3fjgrOI4AwghZ2n50+gkSoBpcoeuKVOps8GDk/wksfJdK1gTo2o/YmR10Zl
        snTx6m4Kk4VkkWXmZWDC0s0U44l2lS5+Vhao2g/AJQrM7wllhzFMWmBZvcEKfSF/r0vc7W
        cZg37BUMYP9x2YUcKLTImQ3X66KNobn5eFvtr35hBQFAAyTPowk54+ermY6ljgGLCUqJtY
        0pqXbHe1ifwz1zht4xPlnUkP1lR7Ci8JU51OofmGHp8Adk7YICEpODyjKiUO2ViYuoppON
        ZvasyIC2KVZordPsG/W65YvA2Mq/K6onTpG0cF+kziSuOBCtBLyoyrODXSgNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1650925537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=qrIAaUSjnb2wlp86fkBj4QhxXpIqPeoU2r+zy2bjOXo=;
        b=ndFeoIBj6LZ+Q528R9oyeR+sLkyYniiI7odjOr8tJ8WsYZCs16YDLJUWckkVWO0ZFdkBMR
        YxnRqq7WYWLkBVnzXAX6tZ0yOhTeF0034tSieTmivsnvV+UNO8N29pE5QGQiBPmbBeHqdG
        02U9KQIoF6rOKTtvay2YUoxEZ/qnFNuSfS/UNu47ZAGpjvLimSFP3Jy3HwbsVumQSlJolP
        Axj0kT4pul4C7I3AX7Qf1iIpCvCNWK9FbVNiTcCk4I32aHONRzTpPcsPNTq2zAD/LPiGwM
        bGH6DLQ2uYgH8CPFFNK92f/RKnBDoFR3oVoxAhw26nTqdHiu1NLwspFXpqTk5w==
ARC-Authentication-Results: i=1;
        rspamd-67b64f579b-dhxks;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=ian@linux.cowan.aero
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
Received: from pdx1-sub0-mail-a217.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.96.96.48 (trex/6.7.1);
        Mon, 25 Apr 2022 22:25:38 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|ian@linux.cowan.aero
X-MailChannels-Auth-Id: dreamhost
X-Irritate-Descriptive: 173270db09277b4f_1650925538102_2579386843
X-MC-Loop-Signature: 1650925538102:2428176500
X-MC-Ingress-Time: 1650925538101
Received: from localhost.localdomain (unknown [69.12.38.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ian@linux.cowan.aero)
        by pdx1-sub0-mail-a217.dreamhost.com (Postfix) with ESMTPSA id 4KnKMz0bNjz3D;
        Mon, 25 Apr 2022 15:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.cowan.aero;
        s=dreamhost; t=1650925535;
        bh=qrIAaUSjnb2wlp86fkBj4QhxXpIqPeoU2r+zy2bjOXo=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=wi/qHUUa+5Xgij1xZFcQcG1fs5arzExUI+HRyTxGN2Nk/QU2JwZ7ORPGbWbJ1BpSv
         2EwTOsm49ZxieGyjmaJFIInkv6cozpBjXdI1qvl5papF9GCgK7zn3DvbOeeyk/hnop
         zoyr9hZopx0pqhOxGAzst6NCCHfxX2ldeNWTI8a6Ijstkup5/n4QmQKlppPeIIy7Us
         9ECXa4NtwFuavYKBE9lZKI3n+t/x9rd4njCFQwwB5pjR7gIXSyjozt+3tGJKn9mINV
         obNmq40tZTQwQVFoh5uO7M5v04jwsRhSnicqpX6SfZmEkWjnqBYiGjU2VdY22GFkKU
         7lOZGNKKNR2cQ==
From:   Ian Cowan <ian@linux.cowan.aero>
To:     Sven Van Asbroeck <TheSven73@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ian Cowan <ian@linux.cowan.aero>
Subject: [PATCH v2] staging: fieldbus: remove unnecessary double negation
Date:   Mon, 25 Apr 2022 18:25:26 -0400
Message-Id: <20220425222526.6023-1-ian@linux.cowan.aero>
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

The values that are being double negated in this case are booleans to begin
with, so the double negation has no effect on the result.

Signed-off-by: Ian Cowan <ian@linux.cowan.aero>
---
 drivers/staging/fieldbus/dev_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fieldbus/dev_core.c b/drivers/staging/fieldbus/dev_core.c
index 5aab734606ea..6766b2b13482 100644
--- a/drivers/staging/fieldbus/dev_core.c
+++ b/drivers/staging/fieldbus/dev_core.c
@@ -28,7 +28,7 @@ static ssize_t online_show(struct device *dev, struct device_attribute *attr,
 {
 	struct fieldbus_dev *fb = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%d\n", !!fb->online);
+	return sprintf(buf, "%d\n", fb->online);
 }
 static DEVICE_ATTR_RO(online);
 
@@ -39,7 +39,7 @@ static ssize_t enabled_show(struct device *dev, struct device_attribute *attr,
 
 	if (!fb->enable_get)
 		return -EINVAL;
-	return sprintf(buf, "%d\n", !!fb->enable_get(fb));
+	return sprintf(buf, "%d\n", fb->enable_get(fb));
 }
 
 static ssize_t enabled_store(struct device *dev, struct device_attribute *attr,
-- 
2.35.1

