Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8B6487848
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 14:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238848AbiAGNhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 08:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238475AbiAGNhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 08:37:18 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CCEC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 05:37:18 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id c9-20020a17090a1d0900b001b2b54bd6c5so12014040pjd.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 05:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vtkNWuyheWVSf68PWKxrLpobqQHGirx2hOFiSE7ChDM=;
        b=J/a1oXzpAVBVL83H3AIMREpjgTXahGdH1QDPZMRPhS2QZo/e9FhuDDTMued19ICsv8
         zLp8hRUAWjQ3CtHw5A9c85SEeLxKIuQv9QcPThoMeRKRF30GaFuPoYDoW5Xw6AFiz5rF
         I6PX+5WQkwm0syfIqQLTCFvBZUjV68yPzyshVYCXfE7zgDBM4HE3JPGCqHeguXd9vRUX
         V/FcmHzVx+zUE71h5b4qN1Xq9ooWRK9UObBPcplSNTMcnRhg3hUWpLdTgQuEX1ffRsC5
         CiQ+abEK7KHTdrKORBTj6WVJNHHyghgH6lzO86KhJ70o1MBYNX/z7j7zvRSutegNmgfQ
         vxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vtkNWuyheWVSf68PWKxrLpobqQHGirx2hOFiSE7ChDM=;
        b=ArfDrcnJONOd0HABBNsQIh7em+QfpY7H9McdS6meGJyKo9gzB4AHa1KF/hNAEl41hl
         oK/o8OJR3oFl69QDimGu9h997AL+dgHimTPdlvybn3fQOnMKJQRIAk5LzycAChB50taN
         0rncd5XEaX0qpK3UZzqXJegeheIQf4wwfBJSvR7UAMSj26nNk6ykRyvAyvZ+2cMB+k7O
         pTOh5jKiJIS7z82zKFfbcCKTyuNLk8IruarmmBh+f5V9o+lXvqe6goDL2axV/EgupukD
         trPLiu97qYiKjUY1w1AOtPnvsHosrFqipxxlLPrJlrIMjSN5LyFfvhJnxr1QVoEZqaTN
         0wlw==
X-Gm-Message-State: AOAM533k5C/dSDR2bRQqt/knikTAFbQKrX3raZUPnvqcAzq5SY1i2f0b
        Ne7W8ir0xW2ncuKtnrpPbYA=
X-Google-Smtp-Source: ABdhPJxaJvviRqH2N90C3l0TfERl3azSjtGZzzymuRYYOhuM/LECebZRtdBjeOoeGZnERSZl7HJa7Q==
X-Received: by 2002:a17:902:bd4b:b0:149:460a:9901 with SMTP id b11-20020a170902bd4b00b00149460a9901mr63289863plx.44.1641562637852;
        Fri, 07 Jan 2022 05:37:17 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.38])
        by smtp.googlemail.com with ESMTPSA id h4sm8282441pjk.2.2022.01.07.05.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 05:37:17 -0800 (PST)
From:   Qinghua Jin <qhjin.dev@gmail.com>
Cc:     Qinghua Jin <qhjin.dev@gmail.com>,
        Colin Ian King <colin.king@intel.com>,
        Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morris <jamorris@linux.microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] minix: fix bug when opening a file with O_DIRECT
Date:   Fri,  7 Jan 2022 21:36:25 +0800
Message-Id: <20220107133626.413379-1-qhjin.dev@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220107113254.bkfpud453zivotov@wittgenstein>
References: <20220107113254.bkfpud453zivotov@wittgenstein>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Testcase:
1. create a minix file system and mount it
2. open a file on the file system with O_RDWR|O_CREAT|O_TRUNC|O_DIRECT
3. open fails with -EINVAL but leaves an empty file behind. All other
open() failures don't leave the failed open files behind.

It is hard to check the direct_IO op before creating the inode. Just as
ext4 and btrfs do, this patch will resolve the issue by allowing to
create the file with O_DIRECT but returning error when writing the file.

Reported-by: Colin Ian King <colin.king@intel.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Qinghua Jin <qhjin.dev@gmail.com>
---
 fs/minix/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index a71f1cf894b9..d4bd94234ef7 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -447,7 +447,8 @@ static const struct address_space_operations minix_aops = {
 	.writepage = minix_writepage,
 	.write_begin = minix_write_begin,
 	.write_end = generic_write_end,
-	.bmap = minix_bmap
+	.bmap = minix_bmap,
+	.direct_IO = noop_direct_IO
 };
 
 static const struct inode_operations minix_symlink_inode_operations = {
-- 
2.30.2

