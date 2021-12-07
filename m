Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4834246C7C8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 23:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242355AbhLGW5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 17:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbhLGW5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 17:57:14 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AE7C061574;
        Tue,  7 Dec 2021 14:53:43 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a9so753910wrr.8;
        Tue, 07 Dec 2021 14:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZK3s8Av4bPqpJYSEgcMIEDCp3LprqI7QXlbouiexF64=;
        b=DmiMJfW2DNxWs4g2BximzSUfaH4s0cWWf5zSJJpwDm4PUBYv+f2wqOhk4mqp94DORC
         hy1zI2iXx3VmJ89emF7hn+GE1/QBlb3k7YwMEeGcy0xrWdwlTmxxuTvUwgywKCsvQaBM
         9TCAnaS5iFUQK2QietG6/AZ3c22fihfcbSIdHYnDy1JVbVdBWFxqQXj5iY2/aILrIdQA
         J1gfxm46AJy+9quDMYG2hiqKTtuyNU2BYdUXs1VrWyvwjx3Z8QvrrXb13kalN3ArWAsP
         oWZCnQkRLgJGjRRuFJW7d8LTHBlYnGujAEmPbgVjnnyHh/oOrZvIiwxxTvrN3yHQ5dlF
         KXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZK3s8Av4bPqpJYSEgcMIEDCp3LprqI7QXlbouiexF64=;
        b=7th+Ib/IeTVwJO3XEfCEsJlW8mwvaDZbzpx/qP+3muUJeNx0FPtzmQO4RJR4KrGsUB
         PaMAp3Kdwe8ecY/kkiUmehEgw0/gp0K7ZSt9IohF1fjDQWMWTTg2ZUJxzcaLqtuxdrCQ
         SqlkNnBl66L8tDff4llGS0ouSUGo7h2NljrZtie+borG/6hi+pzqI3A/rUwRwFbiB5dt
         iId5q+Al0LiygwLJnh66iuYN+OhYYBiZuVcnky1+UyEy4T61E+wVkF0qiwqrGQ/pcmcm
         UnYptNfnM7o8DE4SOGWERXvz1XMDKAFs/tsZbQgYvxYLsUHLjvQbiWSWIBffLnhLcKZL
         /3tw==
X-Gm-Message-State: AOAM5309EIzRv2vplXDe1E7qhbkzWIKXfa7/E7OJu+J1k4aWeXNG73Vf
        PDn6sYFM1rbqKEv55iR8XVo=
X-Google-Smtp-Source: ABdhPJwfkVUsz+KfsP5NQDRkczNlMfg0uqEogRRtMLpe9+Fge9yQAzaKaBFnq5wryj8y0w3v/Zh7Dw==
X-Received: by 2002:adf:82f7:: with SMTP id 110mr54962031wrc.111.1638917621766;
        Tue, 07 Dec 2021 14:53:41 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id 138sm4104915wma.17.2021.12.07.14.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 14:53:41 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: remove redundant assignment to pointer p
Date:   Tue,  7 Dec 2021 22:53:40 +0000
Message-Id: <20211207225340.83827-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer p is assigned a value that is never read, it is being
re-assigned later. The assignment is redundant and can be removed.

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
2.33.1

