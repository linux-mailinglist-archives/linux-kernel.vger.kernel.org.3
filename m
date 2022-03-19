Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E164DEA6A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 20:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244037AbiCSTbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 15:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243484AbiCSTba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 15:31:30 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE0A248787
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 12:30:08 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id w27so18937417lfa.5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 12:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BD8eTbQPnsTfoe1mvwiTLzdxnue2WjbCfWcDnLGgtf4=;
        b=cjhwin7fvJu2x0gqeLQmRRL7aDSPnbUro6yyudk8a+1GQFXivQqj5eOThiGfCqs6ze
         hl9hpuLe5n2VUvoc+TTvWXkmp6SQTrM6yXCx8svk3ILuPTITm8/9NdpqZTD2FLQpjtcM
         LxdU664w4R7fLPQk9vPA6YBbVMz1eLGnfBlCFLaNCGqNDAYT6mEiXVHbRJlQCfsI3pSb
         PaexKD0rvIWUmk5wzYyowZR/TskrkZoWCKwhxuDkYaau0SSd34eJO+/nojer547mbT1F
         SPfHnMjlagXdRMySbB8+kUWWIz7eHSStRPVrhBdSUivdH+81zR8qcED+gO2Hbm9MvQQL
         +BMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BD8eTbQPnsTfoe1mvwiTLzdxnue2WjbCfWcDnLGgtf4=;
        b=MkTKvPhYMxzNQYjSUTGSZjyIDyCC2sbdmP9L5trS8a5pVs0L8VthNLYTf1eoVy6DUY
         V5Ps5+HNkZt3rZLslTR4dY+uWTqGWrpx6Q8UMKTHtoHYIBJyjGZhnNSXhcDfS+SGeJHX
         7mtzHPC82J4xfq4awv1gu+wNrY7cowx3Ec0W9X3r1Z4T50X+zjr1cn378sM3y6xisZco
         vVD13x62HRN5SUEifPujWTx8yyuNvqLviQjwjSZgs+Mk4CErDlEyJXVun/fhKOCOtL3u
         WnYWz7T6Gml32Yrzkt1TfUaTXX6KSr4EURNCUD88OPXn2gMTNvQLfVubnZR9GcEV1eHU
         HlSg==
X-Gm-Message-State: AOAM532uks/+9Rj8ojSLy07WkLXYY6yygFtCZnk6FNoIwBr48Mnn2HRv
        egq9m+ZKOfVkEHtZCH6Y/DQ=
X-Google-Smtp-Source: ABdhPJxjs9QSMiCTPtew4hwu4tpOKIPVKjE84UiX5vDayMirhgKFvZl/sGkcQi07Htu6+IRWRm0u0A==
X-Received: by 2002:a05:6512:1382:b0:445:9536:903 with SMTP id p2-20020a056512138200b0044595360903mr9996748lfa.89.1647718207006;
        Sat, 19 Mar 2022 12:30:07 -0700 (PDT)
Received: from localhost.localdomain ([46.235.67.145])
        by smtp.gmail.com with ESMTPSA id h2-20020a05651c124200b002492835aa87sm1616379ljh.118.2022.03.19.12.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 12:30:06 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     shaggy@kernel.org
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        syzbot+46f5c25af73eb8330eb6@syzkaller.appspotmail.com
Subject: [PATCH v2] jfs: fix divide error in dbNextAG
Date:   Sat, 19 Mar 2022 22:30:00 +0300
Message-Id: <20220319193000.6449-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220319191620.32372-1-paskripkin@gmail.com>
References: <20220319191620.32372-1-paskripkin@gmail.com>
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

Syzbot reported divide error in dbNextAG(). The problem was in missing
validation check for malicious image.

Syzbot crafted an image with bmp->db_numag equal to 0. There wasn't any
validation checks, but dbNextAG() blindly use bmp->db_numag in divide
expression

Fix it by validating bmp->db_numag in dbMount() and return an error if
image is malicious

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-and-tested-by: syzbot+46f5c25af73eb8330eb6@syzkaller.appspotmail.com
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---

Changes since v1:
	- Add missing clean up in case of error

---
 fs/jfs/jfs_dmap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 91f4ec93dab1..d8502f4989d9 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -148,6 +148,7 @@ static const s8 budtab[256] = {
  *	0	- success
  *	-ENOMEM	- insufficient memory
  *	-EIO	- i/o error
+ *	-EINVAL - wrong bmap data
  */
 int dbMount(struct inode *ipbmap)
 {
@@ -179,6 +180,12 @@ int dbMount(struct inode *ipbmap)
 	bmp->db_nfree = le64_to_cpu(dbmp_le->dn_nfree);
 	bmp->db_l2nbperpage = le32_to_cpu(dbmp_le->dn_l2nbperpage);
 	bmp->db_numag = le32_to_cpu(dbmp_le->dn_numag);
+	if (!bmp->db_numag) {
+		release_metapage(mp);
+		kfree(bmp);
+		return -EINVAL;
+	}
+
 	bmp->db_maxlevel = le32_to_cpu(dbmp_le->dn_maxlevel);
 	bmp->db_maxag = le32_to_cpu(dbmp_le->dn_maxag);
 	bmp->db_agpref = le32_to_cpu(dbmp_le->dn_agpref);
-- 
2.35.1

