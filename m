Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2627847B830
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 03:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbhLUCFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 21:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbhLUCFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 21:05:06 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8DDC0698D8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 18:04:31 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id v16so11093838pjn.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 18:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nWPde3tzt7xylrW1USSXNq+Y9DG8jtidKkwOW3Iawog=;
        b=SqLXukmGnFMqbNvJgW5kr7H1Tt1i/SO0zeEbFh3eBmN/l0/V8IAEGpa23IXqENHOyW
         K0IQzsb29u8LuhYEfN0EHs0BnAUHLl7mfZ3Pbg3+ye2L0pugZBSCYJqWSbKZFckGu2F1
         zQVmka8s6d06GmQ7cU2yg+z/n2wJTT8Op2PAYbB/Use516Mc/H5SVmWTojyd1mtNfify
         abGyiDOG+mDnjXkQ5pSPlDPr8j4jK4cXy3yWbM9200+FSkGYQj9p4zdIBmn0A3RC+M/x
         MJWLHfBPNc+0bhjzS4vJj6qmjTJuTYnMkcPj9uk4Rp0y6JUsyiMO9pBDjDkrUjflPeRm
         xFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nWPde3tzt7xylrW1USSXNq+Y9DG8jtidKkwOW3Iawog=;
        b=Hfakeqbj1nJ7WSynv/Rax0sm/vO9XaiVQ/uVZwKzulB72LBCEmFvoZBALqdzW2ARzq
         CSgIt31WYhh9jHgoeO+kDAViXKSl5k0lrvQS35G4DrWKNbLmj1G4kGKMXZ45lHBUfFJc
         ZYnEmOu4lNVxOk7Te9UG2Z8KUmyyflnCw8DFllm/PqvlJltae6iCMGo2D84zf7DbC2+V
         WQEV+pjFEHzJ1eIp5JHUeGaUA0dzism4hqVQ9LOmpdhh8iS/udjg35nk5SesFKDqtLVO
         WqPY+fvUUewtMnsaV4BCpBxaDpMwbXMiwWiL3sBEQ2Pue7DiATu1gVphXc/YiW6k/kDx
         p1Gw==
X-Gm-Message-State: AOAM531HzdNxeAKZlVRW2nCpl8UpiAudo/b1yLTbSb9ezaV/FogD6tmI
        Wtpw86luEe8W5qIFlUJDiyijTl4bZ7s=
X-Google-Smtp-Source: ABdhPJzkauxcOzwk0IMiwMCRFlxdCRzOXRCL1D4kZkmlWmG9iSqUzTtw+vW95c3bDTxnlGwHkF7kLg==
X-Received: by 2002:a17:902:b08f:b0:148:b5d3:96d9 with SMTP id p15-20020a170902b08f00b00148b5d396d9mr748493plr.66.1640052271008;
        Mon, 20 Dec 2021 18:04:31 -0800 (PST)
Received: from FLYINGPENG-MB0.tencent.com ([103.7.29.30])
        by smtp.gmail.com with ESMTPSA id s24sm19002594pfm.100.2021.12.20.18.04.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Dec 2021 18:04:30 -0800 (PST)
From:   Peng Hao <flyingpenghao@gmail.com>
X-Google-Original-From: Peng Hao <flyingpeng@tencent.com>
To:     phillip@squashfs.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH]  fs/squashfs: handle possible null pointer
Date:   Tue, 21 Dec 2021 10:03:47 +0800
Message-Id: <20211221020347.46021-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 in squashfs_fill_super:

        msblk->decompressor = supported_squashfs_filesystem(
                        fc,
                        le16_to_cpu(sblk->s_major),
                        le16_to_cpu(sblk->s_minor),
                        le16_to_cpu(sblk->compression));
        if (msblk->decompressor == NULL)
                goto failed_mount;
        ...

failed_mount:
	...
	squashfs_decompressor_destroy(msblk);

in squashfs_decompressor_destroy:
	if (stream) {
        	msblk->decompressor->free(stream->stream);
msblk->decompressor is NULL.

so add a judgment whether a null pointer.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 fs/squashfs/decompressor_single.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/squashfs/decompressor_single.c b/fs/squashfs/decompressor_single.c
index 4eb3d083d45e..a155452bbc54 100644
--- a/fs/squashfs/decompressor_single.c
+++ b/fs/squashfs/decompressor_single.c
@@ -54,7 +54,8 @@ void squashfs_decompressor_destroy(struct squashfs_sb_info *msblk)
 	struct squashfs_stream *stream = msblk->stream;
 
 	if (stream) {
-		msblk->decompressor->free(stream->stream);
+		if (msblk->decompressor)
+			msblk->decompressor->free(stream->stream);
 		kfree(stream);
 	}
 }
-- 
2.27.0

