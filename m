Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9B3579026
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 03:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbiGSBy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 21:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGSBy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 21:54:56 -0400
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32B8DFA1;
        Mon, 18 Jul 2022 18:54:54 -0700 (PDT)
Received: by mail-pg1-f195.google.com with SMTP id bh13so12218234pgb.4;
        Mon, 18 Jul 2022 18:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B8upiZS5al/5wRAnmjWIGAyvh6FRI4kM94MofET1E6A=;
        b=bag8KY9apw2bpIcs6iF+Kc/fYfMt7GpD7pkwU8yVHFRbSDAA9vCWxkPKho9CXBsvGN
         MsoqoH3P6GHW06qq6+KMnNmA8W8ReDW0dIg8mQan8oRGrobOL70mIY7MT/j9ItZlniW1
         2XWT2wQSqeg2/sLIBOij7W/gzVGsSpv3rJIIBkqaK2ou6H9kOqMEAfJpHiM311GSrasf
         kN/jZl7qMen4icwXMSz670ZDsKGYnrq90bGL0wy5lE5r6FIYZiIkN0rG2nTf32Vrl4cS
         4zzGLGBFRzazaWokdy/9U6knwjYAjO89a7wSpeI7zX7QoxnO+lbB54wuhv45DQLRFiMk
         A7wg==
X-Gm-Message-State: AJIora8GBEDSrvB19yrGmQuzxRjMEHOzuu0ZpkNuOKuW9QYpxY+I+S0L
        RsapG3zNJxjtNYjN8+wNzw==
X-Google-Smtp-Source: AGRyM1sWSClpRg5b5nrJUXGJrwpyiDXXFo3zzkwosxsTeT+hYd3tSjeZy3MRIidcgKbgO0mQzKdbog==
X-Received: by 2002:a63:500c:0:b0:412:a56c:9ac with SMTP id e12-20020a63500c000000b00412a56c09acmr27797159pgb.158.1658195694366;
        Mon, 18 Jul 2022 18:54:54 -0700 (PDT)
Received: from localhost.localdomain ([156.146.53.107])
        by smtp.gmail.com with ESMTPSA id x1-20020a656aa1000000b0041a37441825sm1822137pgu.72.2022.07.18.18.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 18:54:53 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     hch@lst.de, djwong@kernel.org, dchinner@redhat.com
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kelulanainsley@gmail.com, sunliming <sunliming@kylinos.cn>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH RESEND] xfs: fix for variable set but not used warning
Date:   Tue, 19 Jul 2022 09:54:42 +0800
Message-Id: <20220719015442.646442-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below kernel warning:

fs/xfs/scrub/repair.c:539:19: warning: variable 'agno' set but not used [-Wunused-but-set-variable]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: sunliming <sunliming@kylinos.cn>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/scrub/repair.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/xfs/scrub/repair.c b/fs/xfs/scrub/repair.c
index a02ec8fbc8ac..032de115e373 100644
--- a/fs/xfs/scrub/repair.c
+++ b/fs/xfs/scrub/repair.c
@@ -533,14 +533,12 @@ xrep_reap_block(
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
+	ASSERT(XFS_FSB_TO_AGNO(sc->mp, fsbno) == sc->sa.pag->pag_agno);
 
 	/*
 	 * If we are repairing per-inode metadata, we need to read in the AGF
-- 
2.25.1

