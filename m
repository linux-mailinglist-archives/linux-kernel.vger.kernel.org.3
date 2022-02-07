Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786394ABDEE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 13:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389544AbiBGLuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 06:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386708AbiBGLf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:35:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DF5C043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 03:35:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9EB160C8E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 11:35:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDECC340EB;
        Mon,  7 Feb 2022 11:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644233725;
        bh=jZLAyDkcm7SOKN14XylKxKlWQccrek46mpzsx9OCDhs=;
        h=From:To:Cc:Subject:Date:From;
        b=ID1EqxfW2EdGuXZwBb7DswAU119M2mTz7pU57nNmDQNoklNsoAUwY0eyUH2r67RSo
         rUiKD+oOqU5aukGsrw8dWFh5SqKljzyjQxJFMyV+3LIaw3cPt0XUbrXK5EeVVVYaS3
         QEGkz8BI1f1muPXovMlzD5m1TLAQEcopQQrC5uC+y877TLNPMWrKsUgKRGKr78iUfv
         ADfTiV/K38j2uYXOFwYlx4NMP8YxcH9GLlPqIpq2Z0WcRYV1oA8zQJHRueceDfxfmG
         5Bil1PHyNZLF5GoTJuLCF7fHX4SeBKzX6piKcm9AZO8Xn4LTGZJqNr0dEwjQxQ8og5
         diP1cPiCVo0BQ==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: avoid unneeded preflush during checkpoint()
Date:   Mon,  7 Feb 2022 19:35:16 +0800
Message-Id: <20220207113516.9489-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During checkpoint, we have committed preflush command via f2fs_flush_device_cache()
to persist all metadata pages except last #2 CP pack page, so we don't need to
commit another preflush command in commit_checkpoint(), remove it to avoid unneeded
write cache overhead.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8c417864c66a..15ac18bbbc8e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -598,7 +598,7 @@ static void __f2fs_submit_merged_write(struct f2fs_sb_info *sbi,
 		io->fio.op = REQ_OP_WRITE;
 		io->fio.op_flags = REQ_META | REQ_PRIO | REQ_SYNC;
 		if (!test_opt(sbi, NOBARRIER))
-			io->fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
+			io->fio.op_flags |= REQ_FUA;
 	}
 	__submit_merged_bio(io);
 	up_write(&io->io_rwsem);
-- 
2.32.0

