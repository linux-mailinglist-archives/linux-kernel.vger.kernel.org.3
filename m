Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB71F54032A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344543AbiFGP4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344631AbiFGP4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:56:09 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F9328E12
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 08:56:05 -0700 (PDT)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1654617363;
        bh=UwJaoAVoa61DCnp3vhNmUCc8wPxbMXJadrTLt8SmqCQ=;
        h=From:To:Cc:Subject:Date:From;
        b=qrntoUTld+NGDiE5Bqw7eLxramszHrt0peuvaCimeBz3YqtUbTTA+OPnBTPFsxOvW
         xAFMmjL6upk/fe1S282aPfDeyezCHZgCk1j1MJ9Hq0MJXUFW4B1SmzedqWbC63lU7h
         Xr+KWNhLEUQwNO3rOAW+51Vl1yMAXWDGytoXvPo8=
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH] nvme: add device name to warning in uuid_show()
Date:   Tue,  7 Jun 2022 17:55:55 +0200
Message-Id: <20220607155555.8623-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1654617355; l=1083; s=20211113; h=from:subject; bh=UwJaoAVoa61DCnp3vhNmUCc8wPxbMXJadrTLt8SmqCQ=; b=bg7FhTgM0Iz/uy954ZRKT/GOeWkKox3seP2mKi3+lLyDYj2x7go1RWrifrHKufOY7qmjOXAYWuMl qbOACxxkCX5BXmHEPExMMa7l1rkPmecuQiP15JaPCGZWCZx0R+M/
X-Developer-Key: i=linux@weissschuh.net; a=ed25519; pk=9LP6KM4vD/8CwHW7nouRBhWLyQLcK1MkP6aTZbzUlj4=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This provides more context to users.

Old message:

[   00.000000] No UUID available providing old NGUID

New message:

[   00.000000] block nvme0n1: No UUID available providing old NGUID

Fixes: d934f9848a77 ("nvme: provide UUID value to userspace")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/nvme/host/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 24165daee3c8..189bbd6c0c29 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3285,8 +3285,7 @@ static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
 	 * we have no UUID set
 	 */
 	if (uuid_is_null(&ids->uuid)) {
-		printk_ratelimited(KERN_WARNING
-				   "No UUID available providing old NGUID\n");
+		dev_warn_ratelimited(dev, "No UUID available providing old NGUID\n");
 		return sysfs_emit(buf, "%pU\n", ids->nguid);
 	}
 	return sysfs_emit(buf, "%pU\n", &ids->uuid);

base-commit: e71e60cd74df9386c3f684c54888f2367050b831
-- 
2.36.1

