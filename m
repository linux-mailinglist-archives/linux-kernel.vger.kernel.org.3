Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5648592DE4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 13:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiHOLHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 07:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiHOLHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 07:07:30 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AE62624
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 04:07:29 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id l4so8642704wrm.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 04:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=0w9+PjA609EvTdhJ21FdPZXkjOwyQWsh3sVgxJTFZ6o=;
        b=mpIQlUx8naMiLfDubLm93ghNfu2hM9q79depVhpdHOHndayUW+ZQqz3R6VCFDtTWaV
         dqU1RsDPCKbEvO772qY0rFXbU0jSZmMJbIws0Afa9Bxo1bJOaTbAd1pZQSmP5vEOCKsK
         i/c4Id14Mu91nbCJVk1FfQoyoi+guS86d8/S9yGGmg35o8bhJiUpqZUuxHEuBfJQACw3
         jXH9qSKAUvBsYHJ+ZegPDcZAJ7xOQHAKOCHGKEHkNLqSkqIFJF18l7sPDEGolyOMgRnL
         52+CvGaw8LTAZt2LjjNWTPFJnJArztIZry18J1ZzHAVhy/Lvp1RYVNs2m7WtFU4iR+f3
         NUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=0w9+PjA609EvTdhJ21FdPZXkjOwyQWsh3sVgxJTFZ6o=;
        b=QXFyBTtT2cGdVyA5E9SoqVEybafMaA1JM0dexVTITZ4P/gqITI3DBxBry9yZPxTCBl
         tWN28pXPFwSxpzCkxVVot1H4VjWtqDwO2Cw17+h4JOlRkY9iT5T855DsJvAuYNdB0knD
         VYspjY8dKIM6H7mJYirvsIhQfNmBn076vt2a2SWexYhyYVS0mL5noPladFH5t1c5NWDX
         lWVGvxHwaCzZMQ9Ix0qqSBNdVPIV924d9TjonCrZHawsSgegLyrAMrzSgANm/6z+Sftj
         E/xnbYL/qREzH9Xa7/yno7sPsf/2cBvHc/A33jGzgzCnWiBCoAV6qMqjpvqqgdKJq57T
         XFtQ==
X-Gm-Message-State: ACgBeo0+7QXS+iDGlOHZqesIKRIxg3/KzAFFOx6nhAcXJ81JH6QsuuXU
        TcinxOMyJrjIC+qZq2eX1FjD/X0uQk3aWQ==
X-Google-Smtp-Source: AA6agR7i31Xj+ZM9+1J0Djq7tauEnM82gZdc579QUNS1r4rvynLN98xgq8/gthUZVGoQ9ljutmcSQA==
X-Received: by 2002:adf:eb50:0:b0:21e:3d13:3a91 with SMTP id u16-20020adfeb50000000b0021e3d133a91mr8213168wrn.484.1660561647708;
        Mon, 15 Aug 2022 04:07:27 -0700 (PDT)
Received: from localhost.localdomain (bzq-233-168-31-62.red.bezeqint.net. [31.168.233.62])
        by smtp.gmail.com with ESMTPSA id d2-20020adffbc2000000b002206203ed3dsm6996651wrs.29.2022.08.15.04.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 04:07:27 -0700 (PDT)
From:   Alon Zahavi <zahavi.alon@gmail.com>
X-Google-Original-From: Alon Zahavi <zahavi.alon@gmail.com
To:     almaz.alexandrovich@paragon-software.com, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Alon Zahavi <zahavi.alon@gmail.com>,
        Tal Lossos <tallossos@gmail.com>
Subject: [PATCH] ntfs3: Fix attr_punch_hole() null pointer derenference
Date:   Mon, 15 Aug 2022 14:07:12 +0300
Message-Id: <20220815110712.36982-1-zahavi.alon@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alon Zahavi <zahavi.alon@gmail.com>

The bug occours due to a misuse of `attr` variable instead of `attr_b`.
`attr` is being initialized as NULL, then being derenfernced
as `attr->res.data_size`.

This bug causes a crash of the ntfs3 driver itself,
If compiled directly to the kernel, it crashes the whole system.

Signed-off-by: Alon Zahavi <zahavi.alon@gmail.com>
Co-developed-by: Tal Lossos <tallossos@gmail.com>
Signed-off-by: Tal Lossos <tallossos@gmail.com>
---
 fs/ntfs3/attrib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index e8c00dda42ad..4e74bc8f01ed 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -1949,7 +1949,7 @@ int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes, u32 *frame_size)
 		return -ENOENT;
 
 	if (!attr_b->non_res) {
-		u32 data_size = le32_to_cpu(attr->res.data_size);
+		u32 data_size = le32_to_cpu(attr_b->res.data_size);
 		u32 from, to;
 
 		if (vbo > data_size)
-- 
2.25.1

