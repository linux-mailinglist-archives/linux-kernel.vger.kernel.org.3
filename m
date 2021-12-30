Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363B8481DE8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 16:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240531AbhL3P74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 10:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236262AbhL3P7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 10:59:54 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819DAC061574;
        Thu, 30 Dec 2021 07:59:54 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id f134-20020a1c1f8c000000b00345c05bc12dso13545811wmf.3;
        Thu, 30 Dec 2021 07:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8ElIR6SV1fiPS3Db/Lzyt+T8zyl4XcGvw2nOq8Z4FEE=;
        b=NQlx2zcOwB4ZlmjL8sh8qtALR9ZAIL7hqYDT012U86kTOdj2R7cb2rY/RR3nCj+19G
         dscWE1hNfj7ypnj4wqHsgHxT9nS1x0Jzt9rxEFTuD1Dgl/SLa0UJdsuPqIZAiRO3J2ew
         Rhqdg5uKBDhFwpZ2I3irFWdI3AIQSRCfvHPcA5M7wzqEQZRbANWDfJjYoeCeopfuaRqk
         yULVdN7mK6LMkOfWZ8VfZo4omTmLH0haX/fCracCKeBDxC4mwcwxNQk0/Lx8ZIfcrrPv
         xJmLNAuqbg1VY6TRv06psO8PXtdB3nwT6JK+6ccRMZeLukBUYlw+du50lMkaGTBiUkwL
         NeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8ElIR6SV1fiPS3Db/Lzyt+T8zyl4XcGvw2nOq8Z4FEE=;
        b=g0wOItTvjnhWn1mWg78v6uxBdny8tVkbXLN1qAw2U2AJQCSjjvkfVWk/8P7c/UsJ7P
         AexuJG5dOtViqSAd3HnaOoq3eSSijzhD/NA854RT4tj1uzVqaenZXxvFTIK53YPH6act
         3UGfAyk7QyeE8IkZUPxRIGl/h0YHLzglwn+dLe55EKWnULBXPeYR7x1A6ddNN2jBTDQ3
         1s1TrqNqF6FmJozorJOHEr1OM/ztJIqWs/wygxzGXBhWM+l7wbI0a9I7D5uvCmol2Pn8
         v5bSDxKYG2dJRtS8Wgc6vldoi3GqaUWb+MvGQnlANuY4j3JjAtA3FnFd8OJmuNVuHciz
         IqGg==
X-Gm-Message-State: AOAM533rJtvMPn6Zw8lcwhdWZT06yd6yY2iYL4Ny338cpDWgBeyzLww3
        X+oDWWgs9/cBatO/PiWkfROXBZeTmnUwQr9p
X-Google-Smtp-Source: ABdhPJwlVTezB17og28kivWq3KhIcT1izqy5mOu9TzI+W/ETJQFvP+0PwaMlPC0ejKF9v5U4hlBUdA==
X-Received: by 2002:a05:600c:1c9f:: with SMTP id k31mr26653681wms.170.1640879993149;
        Thu, 30 Dec 2021 07:59:53 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id m17sm28645320wms.25.2021.12.30.07.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 07:59:52 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] fs/ntfs3: remove redundant assignment to variable frame
Date:   Thu, 30 Dec 2021 15:59:52 +0000
Message-Id: <20211230155952.379721-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable frame is assigned a value that is never read. The
assignment is redundant and can be removed. Cleans up the
clang-scan build warning:

fs/ntfs3/file.c:995:3: warning: Value stored to 'frame' is
never read [deadcode.DeadStores]
                frame = pos >> frame_bits;

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/ntfs3/file.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 3bae76930e68..27c32692513c 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -992,7 +992,6 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 		if (bytes > count)
 			bytes = count;
 
-		frame = pos >> frame_bits;
 		frame_vbo = pos & ~(frame_size - 1);
 		index = frame_vbo >> PAGE_SHIFT;
 
-- 
2.33.1

