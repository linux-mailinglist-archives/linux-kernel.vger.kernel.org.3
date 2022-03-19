Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5224DEA5F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 20:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244002AbiCSTRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 15:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235662AbiCSTRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 15:17:48 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8BE3E5C0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 12:16:26 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id w7so18903472lfd.6
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 12:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=734S21LskhdoeX+gSiKckHrnBjf5Gz5LFF95lcT9dR8=;
        b=pF3K/NfP9GIaTIVLn3LReKklwQ1JaBC9F6llUZLuoOGaRZNC+yXBCqYArApm9JVTd6
         Evn0lGdwM7BdyLCwz6Be9gCGEbitzAOmraepUbxSVzXnjijYVuvyKy71JHmqPGVyUJ9X
         3I9pGDPkP00sclKC5KoufrWtkFpwdHlIa+vW1IjPsew67o82YvT3owAjfwfXXJ1u+dkR
         +8thlmZljNH5I8QLiD0plG6eLyjJ9cGMgKKjjmMqjszIJLNsKoM7BCQG4ltnZGgclTp7
         GwY3jx6lMTKCBP+7ylRacprPIpZ3k8fGP5QQ17aV6YvQtxNKqmBhP2aeiGu8YOeKqE0i
         BT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=734S21LskhdoeX+gSiKckHrnBjf5Gz5LFF95lcT9dR8=;
        b=kzlgd4THLcDZaxpfpRFTeVMitA7fpldU4R9sceUlM2UArl3u1DPuj8FYNsN9ha5Yx6
         P4AkhtMESNmqV64bKDFqN4f3IIZwtMSpOZ+dm/BE+l6qTtLOHa8+9Qo/CAwG1Ap4bV0c
         dUEHEqkMmYdXBRX15K/pq3JTU+8dOV0GHAIriQqN4tln9yh/5ZYFuCAS2HTW4xnx3Ftn
         tz4AebXnPRpJmHhf02HAOUeUoMUG1GWDcaMl720v72LTmB1oCRII2uYyDwU69qlq8m25
         MvnfrEU4aWlU8Q094/gBGaX1AAnG5JJX+6qjhFf0o2G69YlAGeOLOstDUNbYhFdcjVtU
         X7ww==
X-Gm-Message-State: AOAM532tAY2vJkUvL369FBFb+q4ZMRrOsug1h0FqOP6KCGN5BPa/I6b/
        zKM4y9N57uVQvZE5+GT27qA=
X-Google-Smtp-Source: ABdhPJyz3BXLyIWMqqxM7+wNLeyW57MuZ4mDdgYeU6EnVq8Twb3qLE+TbToSTDS4ACca6/1Pnhr9wA==
X-Received: by 2002:a05:6512:3fa2:b0:445:a29b:b0d8 with SMTP id x34-20020a0565123fa200b00445a29bb0d8mr9584752lfa.163.1647717384702;
        Sat, 19 Mar 2022 12:16:24 -0700 (PDT)
Received: from localhost.localdomain ([46.235.67.145])
        by smtp.gmail.com with ESMTPSA id bu39-20020a05651216a700b004484a8cf5f8sm1354668lfb.302.2022.03.19.12.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 12:16:24 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     shaggy@kernel.org
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        syzbot+46f5c25af73eb8330eb6@syzkaller.appspotmail.com
Subject: [PATCH] jfs: fix divide error in dbNextAG
Date:   Sat, 19 Mar 2022 22:16:20 +0300
Message-Id: <20220319191620.32372-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.35.1
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
 fs/jfs/jfs_dmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 91f4ec93dab1..633a9aff0868 100644
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
@@ -179,6 +180,9 @@ int dbMount(struct inode *ipbmap)
 	bmp->db_nfree = le64_to_cpu(dbmp_le->dn_nfree);
 	bmp->db_l2nbperpage = le32_to_cpu(dbmp_le->dn_l2nbperpage);
 	bmp->db_numag = le32_to_cpu(dbmp_le->dn_numag);
+	if (!bmp->db_numag)
+		return -EINVAL;
+
 	bmp->db_maxlevel = le32_to_cpu(dbmp_le->dn_maxlevel);
 	bmp->db_maxag = le32_to_cpu(dbmp_le->dn_maxag);
 	bmp->db_agpref = le32_to_cpu(dbmp_le->dn_agpref);
-- 
2.35.1

