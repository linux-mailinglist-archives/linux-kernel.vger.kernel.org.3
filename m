Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E06459A9C1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 02:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243785AbiHSXxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 19:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243670AbiHSXxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 19:53:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE613627B
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:53:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 614ADB816D8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 23:53:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB216C433D7;
        Fri, 19 Aug 2022 23:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660953191;
        bh=pyyvju2kzZjvlECXi51yn2sTNYvHyXWrgTW5UX6N7E0=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=PhWo60zanBY7v7wkKDTYq61Cs0yUI0haNL/WxtIKlO/7l5BROCMu2UiKsVKN4H1wC
         /OStgAe4OCFNzbIU68wWJIi9SHDxyVD5g9nqodnTNXfcBsWhvkVkJKPh0N5Icvu23z
         V9d5g4JosCcOQHEpK1V0s85vPGW8nx+p0Cu/kffGFHEL+gFiumyPASiLmqAZNQljmC
         ZEVHwBFCrG1IO5DmMPuFS0+5/1mDq6Kz2VQ2InG2CouZiIQXfoa5hEC1TxD6G8m+Xq
         iM9YdYtmtjie1lTD8t+ePkOOq1pZBGeYVPyqXL2KmVRfqEv6+thP+jRS1Cz6XhZaaL
         1Y4oHdtKxmr+Q==
Date:   Fri, 19 Aug 2022 16:53:09 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] f2fs: LFS mode does not support ATGC
Message-ID: <YwAiZTYkFi/EP/Ls@google.com>
References: <20220811225454.2125297-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811225454.2125297-1-jaegeuk@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ATGC is using SSR which violates LFS mode used by zoned device.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

 Change log from v1:
  - check LFS mode

 fs/f2fs/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2451623c05a7..fe462484f5fa 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1342,6 +1342,11 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		return -EINVAL;
 	}
 
+	if (test_opt(sbi, ATGC) && f2fs_lfs_mode(sbi)) {
+		f2fs_err(sbi, "LFS not compatible with ATGC");
+		return -EINVAL;
+	}
+
 	if (f2fs_sb_has_readonly(sbi) && !f2fs_readonly(sbi->sb)) {
 		f2fs_err(sbi, "Allow to mount readonly mode only");
 		return -EROFS;
-- 
2.37.1.595.g718a3a8f04-goog

