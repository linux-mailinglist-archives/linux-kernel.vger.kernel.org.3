Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F8C5B2CC5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 05:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiIIDLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 23:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIIDLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 23:11:17 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D7A12FBA5;
        Thu,  8 Sep 2022 20:08:04 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o2-20020a17090a9f8200b0020025a22208so4112384pjp.2;
        Thu, 08 Sep 2022 20:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=tfo8TYu87tsXI35iIDHFqgjxZ2aTN0d14oH0zZ3h950=;
        b=NOi6w8xaArh8KWMXSGsdqISbwMcvrjhaQoHVAE7Cr5ohwX2GRUmDAXFyZczvOV7MzL
         EIlizR3DJ1vSfWvsMmAO28hoQgdDVRWDuiuOPrp6ikl3aiR4zlY9qMz7Hy8xSeX46udL
         eO5ZlqaaOSQSw/QRNHEESfy7BSq2kSYDQ2VI+chOhiml0q3yBc68IwmIZDY34Sq7NKlW
         LGXQLa8ujQuKEObWXS6baztCZXh/wRmT0yUcGdgDGciqC6NoTaykv/0gkt524KfiX/WK
         hvXHFfwe8A415G+RcU6N5EFQu9hnOjW8ruvI7fBYc4fb64JLt4lOuOSUsR3/MvjYEwcA
         344Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=tfo8TYu87tsXI35iIDHFqgjxZ2aTN0d14oH0zZ3h950=;
        b=3dYpYvB4qWXBoxtEhWuWCRyKZv5aTY/C+bPZV143SFLVcQT1/90k6fkC1nm5h1O5MA
         1L+8LfW0Etr1jTr6aTQ0pOsvd5eP4mwRffnBkec5jE5B2oS6TTSYLBFqVvEB4sd5LrL6
         MYe5Lqepu2Yx6xJ3LwfR0n+LJijTnIh3Ng0QdeoFE4Z83UnhUR7FmueRcanCcjQ53dU7
         i8RcLnJ1RNXYaGM0yQvvDT8JByEEAP7Ubz4/5DOWxpLXqhSRHP/1P41Y3unc+rVYC1CC
         HRUdCN00pnEqnolcwrs9FD8yVP7kKceJaUSdML3FrDHEIL6EMWRaADrqDSC0vkOLdMih
         hwtw==
X-Gm-Message-State: ACgBeo1z1T7F7b2y8ykwPV9NmOLvx7tiBxiEvFyVl6bQOU1pyV+R0pOP
        DezxKOZaoUVxxuZjEKgAQAg=
X-Google-Smtp-Source: AA6agR6dazOvdkxB0hx4/JSPMNTl81X7/daOsgoGNQL6cNLll+TXNduM8XxJnhyqCmKO6FFMaoSoMg==
X-Received: by 2002:a17:902:bd49:b0:172:df88:8981 with SMTP id b9-20020a170902bd4900b00172df888981mr12063778plx.120.1662692883336;
        Thu, 08 Sep 2022 20:08:03 -0700 (PDT)
Received: from localhost.localdomain ([165.154.253.46])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902714b00b0017544b55277sm254125plm.126.2022.09.08.20.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 20:08:02 -0700 (PDT)
From:   Stephen Zhang <starzhangzsd@gmail.com>
X-Google-Original-From: Stephen Zhang <zhangshida@kylinos.cn>
To:     djwong@kernel.org, dchinner@redhat.com, chandan.babu@oracle.com
Cc:     zhangshida@kylinos.cn, starzhangzsd@gmail.com,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH] xfs: remove the redundant check in xfs_bmap_first_unused
Date:   Fri,  9 Sep 2022 11:07:56 +0800
Message-Id: <20220909030756.3916297-1-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given that
        max >= lowest,
hence if
        got.br_startoff >= max + len,
then, at the same time,
        got.br_startoff >= lowest + len,

So the check here is redundant, remove it.

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 fs/xfs/libxfs/xfs_bmap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index e56723dc9cd5..f8a984c41b01 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -1230,8 +1230,7 @@ xfs_bmap_first_unused(
 		/*
 		 * See if the hole before this extent will work.
 		 */
-		if (got.br_startoff >= lowest + len &&
-		    got.br_startoff - max >= len)
+		if (got.br_startoff - max >= len)
 			break;
 		lastaddr = got.br_startoff + got.br_blockcount;
 		max = XFS_FILEOFF_MAX(lastaddr, lowest);
-- 
2.25.1

