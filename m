Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098F05908CA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 00:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236442AbiHKWzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 18:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiHKWzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 18:55:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C190A9E2E7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 15:55:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80228B822B6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 22:55:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA759C433D6;
        Thu, 11 Aug 2022 22:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660258499;
        bh=ycUQg3EfV3v4qlL6WPECdZb5Kbc9wh21Vkk4bXPCQE8=;
        h=From:To:Cc:Subject:Date:From;
        b=ZfGRPM+5Hbj+TjCjF2RdOsqXvKIrZw4ySN6OMBRbjqaC/OMnx2GDyjQVWH3rdAzZ6
         e8YvFuhtNGzDU+X873B2+VZB4vHoQ5hPil55vppAunZ5XmLWuV6G5xYGSBAjS1u9n3
         Wkb8vLKSRHuxHgrPHLTm+lzXx7J5bQdpOS3OO9LWkF5iOJB92nTu2yjas/9YhpCgWf
         91r9kozclbD8+ApDDsoHBSr7oNBb24OhF1XfyH836cfjLWFFoRTMn7l/rL/KoEQJnU
         dBV/hov2FubePJx9E9MF9+kZapE8eKrROpfGIzqwt0o01MS46ggGChzeerwTSRq45c
         xZ6fTloK9PxFQ==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: zoned device does not support ATGC
Date:   Thu, 11 Aug 2022 15:54:54 -0700
Message-Id: <20220811225454.2125297-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ATGC is using SSR which violates zoned device.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2451623c05a7..212ec2b4926b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1298,6 +1298,10 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			F2FS_OPTION(sbi).discard_unit =
 					DISCARD_UNIT_SECTION;
 		}
+		if (test_opt(sbi, ATGC)) {
+			f2fs_err(sbi, "Zoned block device doesn't support ATGC.");
+			return -EINVAL;
+		}
 	}
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-- 
2.37.1.559.g78731f0fdb-goog

