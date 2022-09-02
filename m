Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E32C5AA8C6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 09:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbiIBHcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 03:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIBHci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:32:38 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7C4B5147;
        Fri,  2 Sep 2022 00:32:37 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id v4so1232589pgi.10;
        Fri, 02 Sep 2022 00:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=z9kAPseJetbuZBdM95ehLDErpmOHHqA6j0W1oEZy7Mo=;
        b=a4HIf/Upa39kXBIx139TT2Uo/S1foBoH7hX/9egihEfdPTSFYrBShRUjPeNE4aAYw4
         FU9Xz+zFdSfmn7+vwDmd3Ub9dZahFc2Ao0Mo+N6gb3lZnyIL+tnNeqsCQU1ZvdNRsQuq
         9s96Go99K/3ROfxkLy3fB/QxgMtn1gFWBZ4u4U0GUqu3CWXJZpUv2Y/9qqo9SaSRN/nN
         hO9pbl9ng6ArUGJbR6Q6eqfL2cqIn+dV96BYjYQNCmXdz2etU0STrCPdtKmHYuU7D2Lb
         lASINEVZPK7CycihwSj1LlmW5uNR6xSNbYOiLQISsSZd6XbE8MffEoOnL0C40oMOj7s7
         IlJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=z9kAPseJetbuZBdM95ehLDErpmOHHqA6j0W1oEZy7Mo=;
        b=X1p8C4WPMnWDrcbNNkyU0uPd7ArXfrsFEpY87tdhCAGk7K4XOk6/kOAp5YNsj64Z36
         UT/09MVkSh2OWiAJ6seJCDcqnumiKrx+MNiyk2fuXsFGSJNX2+QADi5VjM/GZbarIE17
         Gy/Nwm/BSR4Cs5kgfMFshEUZMnoVdeqHCGprVyrwfqx3l8QacJ1+GjmEZhdeRCPSgjbg
         7oSlcOV5u+G8Lwe8CBtxrYiMU9LSCdi3LITfgDXTzxCt8Xa282PKYYBNPUUHJBrb6xpA
         7R4HuE2YZqVI5/f13ZBKn1QcZbB+2U9665r84FQ9R+3DCDHbAQkGZ1+PXS9jet1okYv4
         RBAw==
X-Gm-Message-State: ACgBeo20TMfD9CDVOdVA6YhRESC8aYJDNUS7pMtEPYWlFosNXiVyZeLd
        YxtM3AqFiQP/yQac0PpQpfY=
X-Google-Smtp-Source: AA6agR7E4UC4nbW5TsTctTGTWE7CcyiGWLlvlDZNq3vvFfl3HPSSslwtBu7SqB/xv6b+venqkA37uw==
X-Received: by 2002:a63:4608:0:b0:41a:617f:e194 with SMTP id t8-20020a634608000000b0041a617fe194mr30476071pga.152.1662103956983;
        Fri, 02 Sep 2022 00:32:36 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902da8300b001752216ca51sm891235plx.39.2022.09.02.00.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 00:32:36 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     djwong@kernel.org
Cc:     dchinner@redhat.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] xfs: Remove the unneeded result variable
Date:   Fri,  2 Sep 2022 07:32:32 +0000
Message-Id: <20220902073232.319601-1-ye.xingchen@zte.com.cn>
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

Return the value xfs_dir_cilookup_result() directly instead of storing it
in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 fs/xfs/libxfs/xfs_dir2_sf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_dir2_sf.c b/fs/xfs/libxfs/xfs_dir2_sf.c
index 003812fd7d35..8cd37e6e9d38 100644
--- a/fs/xfs/libxfs/xfs_dir2_sf.c
+++ b/fs/xfs/libxfs/xfs_dir2_sf.c
@@ -865,7 +865,6 @@ xfs_dir2_sf_lookup(
 	struct xfs_inode	*dp = args->dp;
 	struct xfs_mount	*mp = dp->i_mount;
 	int			i;		/* entry index */
-	int			error;
 	xfs_dir2_sf_entry_t	*sfep;		/* shortform directory entry */
 	xfs_dir2_sf_hdr_t	*sfp;		/* shortform structure */
 	enum xfs_dacmp		cmp;		/* comparison result */
@@ -929,8 +928,7 @@ xfs_dir2_sf_lookup(
 	if (!ci_sfep)
 		return -ENOENT;
 	/* otherwise process the CI match as required by the caller */
-	error = xfs_dir_cilookup_result(args, ci_sfep->name, ci_sfep->namelen);
-	return error;
+	return xfs_dir_cilookup_result(args, ci_sfep->name, ci_sfep->namelen);
 }
 
 /*
-- 
2.25.1
