Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CB947B689
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 01:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbhLUAsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 19:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbhLUAsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 19:48:13 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B15EC061574;
        Mon, 20 Dec 2021 16:48:12 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 185-20020a1c01c2000000b00345b7a50a7bso147232wmb.3;
        Mon, 20 Dec 2021 16:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/kPfUDXgs/I5bXAuQrDJgSbN/QtfIuaiRvGXMYN9BHs=;
        b=IpeqEo0vDIcG9LNaNsjUcUK7ecr2IjmvTO2xIbXXL831sIdXOxVN/8WNMb/n7zxcGJ
         Nrd37AD61C8usPSfKUTs8xEj34IFZmzpecXKkdpckcd6Yf0eDY6I8KZdxFIiSwmmQVbO
         moV/ISXcMG6kTovU3g70EjodnfJnKUZmRcUHEKXjX1a0znO96BL5zmaTvWGU/9wVBDvb
         jzzcIzZ2f76f+blbfe1X22GF5noBUmsVa2us3I4wHoJ6WA0P1Gu8ta20lt2CFncYAycD
         JualuUSkJK35OuvJI8lTcCSEi8XLq2FnTUYL+ULs8x5TIg6OE75P4konL26HRZen+6nJ
         CNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/kPfUDXgs/I5bXAuQrDJgSbN/QtfIuaiRvGXMYN9BHs=;
        b=jwgghIK69XD2BbKNrWKy4QEzb3mywahoOwuL74fPJyrQi3rEgtUmM4qL76XpfWWR6a
         NagI2HLSlG5zzh5QN/geJX36krzFCt+S1ZlG9O10+PaLD4bOm3nksOt7P9p6imcgKFs1
         ycK9REKB1weacNQzH/IEucvaA7CT6DfDwNvYT94acAiBJUICwL0iNWwDtyZDG2t5oZLl
         aR+yl9o34zNcarOk9M5wKTxV5+xwErJYiq1+P0WUnzAKQMzf1NRufnIvfvfuAAaokGia
         fJqYaIcklulsdU1T5ke1KJ2rUcc5g/Ps8yeW+CiWD+RasSqwTlH9W9hCc36IzQeUnxya
         TKuw==
X-Gm-Message-State: AOAM530yn8GcLKgPDbuzTkWf48DMeUGsXfJ9zeIVOxGmxWIx5thOrqn7
        V2rfdGBGPUBpWvGig1IF/ok=
X-Google-Smtp-Source: ABdhPJyXDI1q8mxV7GeqUWqzghf86fbpn8/L62NzGAUcAcp5DO7GgyRsexOq1rSdZcn1uo0X8y2PiQ==
X-Received: by 2002:a05:600c:33a5:: with SMTP id o37mr418327wmp.83.1640047690903;
        Mon, 20 Dec 2021 16:48:10 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id f18sm16498263wre.7.2021.12.20.16.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 16:48:10 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: remove redundant assignment to pointer p
Date:   Tue, 21 Dec 2021 00:48:09 +0000
Message-Id: <20211221004809.213602-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer p is being assigned with a value that is never read. The
pointer is being re-assigned a different value inside the do-while
loop. The assignment is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/cifs/cifsfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index d3f3acf340f1..61091eed8c65 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -775,7 +775,7 @@ cifs_get_root(struct smb3_fs_context *ctx, struct super_block *sb)
 
 	sep = CIFS_DIR_SEP(cifs_sb);
 	dentry = dget(sb->s_root);
-	p = s = full_path;
+	s = full_path;
 
 	do {
 		struct inode *dir = d_inode(dentry);
-- 
2.32.0

