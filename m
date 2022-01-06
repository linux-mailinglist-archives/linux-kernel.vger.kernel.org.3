Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C270485F3D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 04:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiAFDb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 22:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiAFDb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 22:31:56 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FB3C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 19:31:56 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so6978276pjf.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 19:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+8eYojNJYLQOipkO9gITipj00BcP7O4ubmxOAp8bOKE=;
        b=Nqv9gnCWhDZsJ1FPK4p8Jc6YoQwRzALCu1rhlSydt2o68RF3hRR0sJnirV2XSn4fNE
         UxLeg/Ksk9fIibRq523VJN3CCoZZqzwrLzMACMyST7cZ4c9Y4C6mEIgU4ZnmXiViiPws
         ufeKPHJ4LOFfVdq6dX5+bvsIIbWNvI7ShsjW7FYDHW09w8OZs5vyCt61pZu56FCSs91U
         LGglcMwuQr2tysZeMq1IQDSPPPNGtv65Bqlm8AScXY/tPxDNpZxXApH4YDuckCZ2/Ha8
         r97o81vxF1qunQNXzQEyp+Edw2ZhG+UjnI8UTQp4dXmrVcf1x9cUdBnGGnb2K+N64plM
         BvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+8eYojNJYLQOipkO9gITipj00BcP7O4ubmxOAp8bOKE=;
        b=VVvsehGizFPGgtFqHLB/klUKOZUepoKjpBPXIwXdZuBFnfJ8O6tbwc61rZ2DpETSrJ
         Sk6GboqTkFg54hwv8/bsE6Rg/sC72SM5r+fq17ANx477hsmsjlOPMuGGBTAeF4z8pOQ2
         qXmAg6eTOdONTQ43luumyICrhPIzbk4DP7StC7QWd1V/PMQm8atw2Gjk2JEVpTpCZVMX
         z1VCWGMw6qZ6Fi2sc8vrytHrGBvIe5SujLVunstyu5vokataiWZ5UisLURvjqQTQ5P1M
         50KFb6LVt4t5G9nn13oIImHDbzPahaFRTuYIW2HY94xG8Y9XkViFIDQNl4SCfOsphZgx
         88zg==
X-Gm-Message-State: AOAM530aHCMRqfO3nwaSw6Byr8Hu32qxkzPcPFtOOLBGpa9aRA6HpIpb
        JKL/oNmbgQYS7aqX2fGnGaWUjUntCFwvNvOG
X-Google-Smtp-Source: ABdhPJz+K29wFZXLK2QGxwTLcyGnrL8jXJ1YP8ZlMELFQK6OiBBXH8oXBosONEY7i7JcffxQ4dLsvw==
X-Received: by 2002:a17:90b:4b41:: with SMTP id mi1mr7858842pjb.213.1641439915616;
        Wed, 05 Jan 2022 19:31:55 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.151])
        by smtp.googlemail.com with ESMTPSA id t31sm458612pfg.184.2022.01.05.19.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 19:31:55 -0800 (PST)
From:   Qinghua Jin <qhjin.dev@gmail.com>
To:     christian.brauner@ubuntu.com
Cc:     qhjin_dev@163.com, Qinghua Jin <qhjin.dev@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] minix: fix bug when opening a file with O_DIRECT will
Date:   Thu,  6 Jan 2022 11:30:41 +0800
Message-Id: <20220106033042.347301-1-qhjin.dev@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

