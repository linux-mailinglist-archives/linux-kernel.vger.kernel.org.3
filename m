Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839C2481DCD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 16:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239532AbhL3Pp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 10:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbhL3Pp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 10:45:56 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A99C061574;
        Thu, 30 Dec 2021 07:45:56 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a9so51105355wrr.8;
        Thu, 30 Dec 2021 07:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q0dNHTxLQtU5lBJjjHwy0CnTQzm5dF8G6GDH+GbnJMw=;
        b=pCAG6Adm4zyNQlY20t5Rnjz0DjXwALfZxQQFq2JZCAOZxowBGsu/7FPaY9Upf/juAg
         MrIhZ7fAKnLbJUzKbNiW8qhtbP8/Ef7+dVhVbK/4wJU03MRFSewFXh/kRKUxu//8hvnn
         F1Rgm/KxajpMpxtM4O4+PwEMxgDvyc1LYeMua/Be7L1KF9UHRgZw0bn0utPT3l+lQN2M
         CeEcqWzGt0DRImtnVfoFEqPG0gWe4dpoUDC35qeFUAEMPmS1SZqU3wh0oZLP0BQUopJ2
         cQ1xtfQlFLBdUK/+QMUtWtKuIFyIw7nYcP3CCs7OcHpXXNV+SCPPvoY6DgU8iWDDb/Si
         OJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q0dNHTxLQtU5lBJjjHwy0CnTQzm5dF8G6GDH+GbnJMw=;
        b=2SlTAfxvicnHbc7uK6Ht9NjajyPqun4lEq00p215ALvKV4JWw6oKpUnvRSywKeheLB
         77awA/C9vxtZZSjek89VMo/roX0HV7PVIze6MJl0X/UeJoD1xzXQ54WueP+L5UjF6rqY
         N0OTxD/FnsYLEC2LtNBkx9ufM+EOpBhCvsursz5t3SfuqiTOA+gn2KOIk3P1l9DFwa2w
         JhSVmMfsaoi8oLjOBwpDhyLsV9iy02reXD7a3lhjoAKBGs6lJKDIUCLpzcJMcYOcL69a
         3tJVg+CuVXR8G09iFDvAuOPJNCR6eJdISOjK8OW1tqJwFWu7hVa2S4Cxu/E7VMCvKl/1
         /vNA==
X-Gm-Message-State: AOAM533LC6rqh0bUn9f7ytxUVTA3ndDrudLXHGqb1qGI+L4Vs8r0c7S/
        gaPv9YVGFd/PZqhNJSSvy7k=
X-Google-Smtp-Source: ABdhPJxUcI0g7ZFDdWU+UXr/NItl1c+Ge4Ae193V0wZhWvZ13Cg/JyASMRDgQ7M3FsHlbBV2BSbJ3w==
X-Received: by 2002:adf:da4a:: with SMTP id r10mr24957924wrl.553.1640879155114;
        Thu, 30 Dec 2021 07:45:55 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id m6sm28366820wrp.34.2021.12.30.07.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 07:45:54 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ntfs: remove redundant variable idx
Date:   Thu, 30 Dec 2021 15:45:54 +0000
Message-Id: <20211230154554.307121-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable idx is being assigned a value but it is never read. The
variable is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/ntfs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 2ae25e48a41a..329fca1fa619 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -1772,11 +1772,11 @@ static ssize_t ntfs_perform_write(struct file *file, struct iov_iter *i,
 	last_vcn = -1;
 	do {
 		VCN vcn;
-		pgoff_t idx, start_idx;
+		pgoff_t start_idx;
 		unsigned ofs, do_pages, u;
 		size_t copied;
 
-		start_idx = idx = pos >> PAGE_SHIFT;
+		start_idx = pos >> PAGE_SHIFT;
 		ofs = pos & ~PAGE_MASK;
 		bytes = PAGE_SIZE - ofs;
 		do_pages = 1;
-- 
2.33.1

