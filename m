Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32200571A2A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiGLMjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiGLMjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:39:05 -0400
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5674F19A;
        Tue, 12 Jul 2022 05:39:04 -0700 (PDT)
Received: by mail-pg1-f193.google.com with SMTP id bh13so7449638pgb.4;
        Tue, 12 Jul 2022 05:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=asdqH+VTqD8An65Icv4mO0/09GyJU+rORHfaAe937t0=;
        b=txraCPwWGiYW4cSb53IbxwSNn8F/RkjE6Xu/j2QqQj66AkJd6kYpMHlvdZnyuRZs+3
         QDZzJnU1qyF4O9lSHY2csbzeP11E/ZirJxbaP1P0+MqfJCCV9BibIHYHKDueA0/eMM90
         wQ8pyj8h2of3rOrAM5Wb37amukSHjzggqY7fXxst9agUHlwV4woXuiRoxdc11biEURnE
         rCe+r+CygH5Tm6VD065lrjnNKDE+2ORBSuMk1Uv2X/Li69BgJyTQy2o+yYzEL/x8IzRs
         OtF6s9Tvt+8fvxkQWwCXwNZ4zLAlqwFbxk9wNzDqiJGmDv/eYCfZPBHSk4bRJH8GMENr
         NC0A==
X-Gm-Message-State: AJIora+nFdHVe8C5sLUmFOQxpFhmU/rxJvXZIYJpVcoVm1qD+6ZB1cbF
        V3X/lzIuZlL/3dcOzVw3BA==
X-Google-Smtp-Source: AGRyM1ti6PNvouBhgW1RNcNJ+7mZ35PPBsjfKc236dVWR2wqGNshfsSu1F44vHecs93QS92q84964g==
X-Received: by 2002:a63:fd0b:0:b0:415:f76b:a2cd with SMTP id d11-20020a63fd0b000000b00415f76ba2cdmr9995874pgh.440.1657629544226;
        Tue, 12 Jul 2022 05:39:04 -0700 (PDT)
Received: from localhost.localdomain ([156.146.53.107])
        by smtp.gmail.com with ESMTPSA id t20-20020a62d154000000b0052850947cf8sm6921302pfl.171.2022.07.12.05.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 05:39:04 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     hch@lst.de, djwong@kernel.org, dchinner@redhat.com
Cc:     sunliming@kylinos.cn, kelulanainsley@gmail.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] xfs: fix for variable set but not used warning
Date:   Tue, 12 Jul 2022 20:38:52 +0800
Message-Id: <20220712123852.813904-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below kernel warning:

fs/xfs/scrub/repair.c:539:19: warning: variable 'agno' set but not used [-Wunused-but-set-variable]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 fs/xfs/scrub/repair.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/xfs/scrub/repair.c b/fs/xfs/scrub/repair.c
index a02ec8fbc8ac..2c8d7e7ef9af 100644
--- a/fs/xfs/scrub/repair.c
+++ b/fs/xfs/scrub/repair.c
@@ -533,14 +533,11 @@ xrep_reap_block(
 {
 	struct xfs_btree_cur		*cur;
 	struct xfs_buf			*agf_bp = NULL;
-	xfs_agnumber_t			agno;
 	xfs_agblock_t			agbno;
 	bool				has_other_rmap;
 	int				error;
 
-	agno = XFS_FSB_TO_AGNO(sc->mp, fsbno);
 	agbno = XFS_FSB_TO_AGBNO(sc->mp, fsbno);
-	ASSERT(agno == sc->sa.pag->pag_agno);
 
 	/*
 	 * If we are repairing per-inode metadata, we need to read in the AGF
-- 
2.25.1

