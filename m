Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3294B5600AA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 15:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbiF2NIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 09:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbiF2NH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 09:07:57 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B342D369F8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 06:07:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D78CACE270A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 13:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE56C34114;
        Wed, 29 Jun 2022 13:07:24 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="B5QtNPf0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656508043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SnMXErXt+rMf3KJCJYgaEK3EzOpUUV36Y/gL6ZP2l5A=;
        b=B5QtNPf0Wq69e1z33McatNU0GR0nAt49RaesZP+nWj3WXvuUJ8gHPcH+yTwHNaMRHL1yPP
        Ylm0kieXxq7SoyijDcPmRByAA/Y0oNwhStY6rFnIZOAJ4IEvXxIrqEv/ddMtfjIQ4OpWNW
        h5xKyvUTrnYwoAYwmwUG6WUKkGkt5BI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 14c2538b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 29 Jun 2022 13:07:23 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v3 7/7] vfio: do not set FMODE_LSEEK flag
Date:   Wed, 29 Jun 2022 15:07:02 +0200
Message-Id: <20220629130702.954310-8-Jason@zx2c4.com>
In-Reply-To: <20220629130702.954310-1-Jason@zx2c4.com>
References: <20220629130702.954310-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file does not support llseek, so don't set the flag advertising it.

Acked-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/vfio/vfio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index 61e71c1154be..d194dda89542 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -1129,7 +1129,7 @@ static struct file *vfio_device_open(struct vfio_device *device)
 	 * Appears to be missing by lack of need rather than
 	 * explicitly prevented.  Now there's need.
 	 */
-	filep->f_mode |= (FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE);
+	filep->f_mode |= (FMODE_PREAD | FMODE_PWRITE);
 
 	if (device->group->type == VFIO_NO_IOMMU)
 		dev_warn(device->dev, "vfio-noiommu device opened by user "
-- 
2.35.1

