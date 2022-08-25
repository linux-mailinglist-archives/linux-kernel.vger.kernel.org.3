Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9A85A0A2B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237337AbiHYH03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiHYH0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:26:12 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDFC3BC
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:26:12 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id f4so15302613pgc.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=bB+kl0UO6V9N3NFWsUEUpn1LfY2EWq3USxIajhWcPWE=;
        b=k6+RcAStH3GaJraz+IAKrP++kdlO6WprMeuJkv+OG49ShppS2aIwXW6I7NgXkH2LAj
         tnwiZCOIiGWssLCiZHihtoQK0A0f2lDCADat84vYJqfhfd1FMluTTLZz+qcY0BkvWZcg
         dbt1nD6U2YWcp/4lGYSn/p1/njsaerLf1niHBP/qhttameyfdmtMOjOzQ2AGZsMdIWbd
         wavlQU0U7V36nb1QdQj5v9dNeC1aVxk7vhrUIZoac5nuoAj6HNWqkisSl10DFuUR55gw
         TLvQ7sNA4HORqyJctGCjliECsV5mR96KCL/cD4mSbhz7n1Bivrmgi1xcY+ZlsHAjvBlg
         H89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=bB+kl0UO6V9N3NFWsUEUpn1LfY2EWq3USxIajhWcPWE=;
        b=erzeHkTJ64E3m1i7doKCt7VKMw8u53Mycw4EkPfimC+9S2eAOQ8x+nYORxtJ6SNM5Q
         aGukY1qlSAImSttlmKQI9l145g61wkewcAi+ABvXq8g36JO1wH4H5yW/xusmAf7paeIL
         NGCr7PG0+z4alR75hw9txFMLeZsMDUBx4rCtxhH8HqKUfMMaiggud+RIfpO/xZQZPrIj
         hUbl1k2/yfKoAEB3OdSM2HrN+jkTC2i0oKVfit1tf0wIS1pyaQpiYzSB6oenkG+cALa6
         LMlFB8loqKsN8gXLGmOYDy2E8LpjpmFm4+CUhkKGwGE37jo1ZBF6fUIPUjdayUzc9efC
         oRYQ==
X-Gm-Message-State: ACgBeo3uhv46qM21QXVy1SLipRKuePIUxaO/5q2vBtwcoXFBHcnbnUYf
        hRmusUThf1rZP1toJkLRXFQ=
X-Google-Smtp-Source: AA6agR62WgWPj66ZHKu/4JE+3BnY1A/vfqxFlKaGUeioeZTT4Q376fwszuRwx3PxjNEXGrWkqEWVsg==
X-Received: by 2002:a63:f0e:0:b0:429:54d7:238 with SMTP id e14-20020a630f0e000000b0042954d70238mr2190257pgl.620.1661412371701;
        Thu, 25 Aug 2022 00:26:11 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 1-20020a620501000000b0052d481032a7sm14284630pff.26.2022.08.25.00.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 00:26:11 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     asmadeus@codewreck.org
Cc:     ericvh@gmail.com, lucho@ionkov.net, linux_oss@crudebyte.com,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] 9p: Remove the unneeded result variable
Date:   Thu, 25 Aug 2022 07:26:07 +0000
Message-Id: <20220825072607.229093-1-ye.xingchen@zte.com.cn>
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value v9fs_vfs_mkspecial() directly instead of storing it in
another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 fs/9p/vfs_inode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 4d1a4a8d9277..d939b32da201 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -1370,7 +1370,6 @@ v9fs_vfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	       struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(dir);
-	int retval;
 	char name[2 + U32_MAX_DIGITS + 1 + U32_MAX_DIGITS + 1];
 	u32 perm;
 
@@ -1387,9 +1386,8 @@ v9fs_vfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 		*name = 0;
 
 	perm = unixmode2p9mode(v9ses, mode);
-	retval = v9fs_vfs_mkspecial(dir, dentry, perm, name);
 
-	return retval;
+	return v9fs_vfs_mkspecial(dir, dentry, perm, name);
 }
 
 int v9fs_refresh_inode(struct p9_fid *fid, struct inode *inode)
-- 
2.25.1
