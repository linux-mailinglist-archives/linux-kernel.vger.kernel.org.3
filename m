Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1CF47F2D8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 11:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhLYKGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 05:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhLYKGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 05:06:41 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F49DC061401
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 02:06:41 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 200so9450896pgg.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 02:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tr5XUUdLtNZAp31+iJJ7YFpkXDTAliU1rXFTU2oYGMU=;
        b=TdLQSmlB2gLGwclAt9mNo/9QYOsMYBTP6PtsssOCdDO8bqXtBVo4b82w9kiJMKhu2I
         KjXNz1BTS7KmgAcQV52Ax7V5/af0eW8lhhqJtf35K7XUK8bJ3KQYlSWVgMXt8spIm4Wp
         LStF6Jkn8THpepotqmceR60qAD5jCcB8YF8m0yuE/xuDU8ber2J5XsEIRvOA96zt8TpP
         4gk1v1tdzSeqRJmvvjVVtdmLlTeEik7uoRuPARjrb65yWgXmmFwO+shXIbgpDnjZLU6Q
         hip/z9SpD3R8d1+MFESviY3B93KqLgTIVX1vYOpj3dSl0BsV1sVGL9LdnlBOx4q3wh/Y
         vV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tr5XUUdLtNZAp31+iJJ7YFpkXDTAliU1rXFTU2oYGMU=;
        b=11sIRn6Cj0LAh+deQqr4hT+0cWqSj2xrwQJ7G4AwDSSLxZTWU+PWxsmSCCeT1GMn+N
         EkH5iS4ikLehk7vx6QId1mHtXlCRqshziEw5r4BEGp6+1hvQVwltwHO9S5qBqcpp3zVq
         43RsV6okpVQKhGST98h8CXwgDMLre9L8dbdqQsXMesk5vpC+T0osx4Adjyo7zDyZk9Fi
         r/SrYcn3MjNyxskhzlOYm9Z1pfZwN3kNuB2z/9X79c0efm0DGr1H3jIqRo7b148bcDnX
         bTvJhvLUW4NLmuYjS1Z2TLqZ5etddA2jbYNcs/QFFle6GCv53rQaM9b6ju3j4wBS8oNb
         tveA==
X-Gm-Message-State: AOAM533fc+6Gt4veqwz4TaWb9n14aXZdNn3Zns0LBpbcA6VXxzvLEmku
        zKireLkX2qGGVEAQUQvK8fw=
X-Google-Smtp-Source: ABdhPJykZ17Xl6Xri6yGAWosneOSr6CIeXWUESSCcoFY6BfxQ2EBaj2kpbkeORUEzSNLWQ439uyexg==
X-Received: by 2002:a65:6241:: with SMTP id q1mr8931713pgv.98.1640426800696;
        Sat, 25 Dec 2021 02:06:40 -0800 (PST)
Received: from localhost.localdomain (1-34-229-86.hinet-ip.hinet.net. [1.34.229.86])
        by smtp.gmail.com with ESMTPSA id ob8sm15980723pjb.38.2021.12.25.02.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Dec 2021 02:06:40 -0800 (PST)
From:   s921975628@gmail.com
To:     richard@nod.at, vigneshr@ti.com, miquel.raynal@bootlin.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        RinHizakura <s921975628@gmail.com>
Subject: [PATCH 1/3] mtd: rawnand: nandsim: Replace overflow check with kzalloc to single kcalloc
Date:   Sat, 25 Dec 2021 18:06:07 +0800
Message-Id: <20211225100607.118932-1-s921975628@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: RinHizakura <s921975628@gmail.com>

Instead of self-checking overflow and allocating an array of specific size
by counting the total required space handy, we already have existed kernel
API which responses for all these works.

Signed-off-by: RinHizakura <s921975628@gmail.com>
---
 drivers/mtd/nand/raw/nandsim.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsim.c
index 0750121ac..3698fb430 100644
--- a/drivers/mtd/nand/raw/nandsim.c
+++ b/drivers/mtd/nand/raw/nandsim.c
@@ -979,15 +979,8 @@ static int ns_read_error(unsigned int page_no)
 
 static int ns_setup_wear_reporting(struct mtd_info *mtd)
 {
-	size_t mem;
-
 	wear_eb_count = div_u64(mtd->size, mtd->erasesize);
-	mem = wear_eb_count * sizeof(unsigned long);
-	if (mem / sizeof(unsigned long) != wear_eb_count) {
-		NS_ERR("Too many erase blocks for wear reporting\n");
-		return -ENOMEM;
-	}
-	erase_block_wear = kzalloc(mem, GFP_KERNEL);
+	erase_block_wear = kcalloc(wear_eb_count, sizeof(unsigned long), GFP_KERNEL);
 	if (!erase_block_wear) {
 		NS_ERR("Too many erase blocks for wear reporting\n");
 		return -ENOMEM;
-- 
2.25.1

