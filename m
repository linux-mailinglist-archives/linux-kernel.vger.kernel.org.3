Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359A65253FE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357221AbiELRqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357223AbiELRp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:45:56 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E639FC6
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 10:45:54 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id l11so5222833pgt.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 10:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OSHOn8AD50fQNdDvnnCPyCnTAz1Ztb2Lto+TID48AdM=;
        b=bGCK0VIVkh5sODitLTjTvH48DFLUzYQ67s0FaQhbO15ZF+zJ9eltLkCOZ8q15ufcKJ
         HfYoHJFeirejxeuRQ994CbeuvwPKtp3j2aCwamWEL+0DuxhuQcK3Gh6W3ol6MMMVZunN
         AxjzSBs6bLQuKGx1mKNRr9YSkRp0mokj3oDREUNb2AGp8FMsigsyHas7DXPc8xAm+UCs
         l14sciRRQb9W8b8YCxKZAYRUGf29LlwhEkZYyL2iYzK/NPNjhsJ07NrpXqFPlqCHqMUC
         HZN2j91L3W5ksxkhfpBs2be9nqrnfxsW6ii9VtwFPQEdL2r2WPp/DOlx8AM5VlUp+cl9
         J8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OSHOn8AD50fQNdDvnnCPyCnTAz1Ztb2Lto+TID48AdM=;
        b=Yk+wCnkDkK9SnzUHWqzTuiC/xKyLPRT9EG2ncSyhkZ7w5gT67D9QyGGYldx5e22egb
         KAOqKys7MoGqFM9dqVuHuaU+LB6CyjuZ/WpDGEtC86u4gqJfhPxtcgWxL02guPwllaHI
         tt9GwkkbUXzp1K0nbYN5k5vzaj5/Wpictm3v1ky9PJ2TB8QhsKOCPvTmZedare4c3Doi
         BE7w3k54208uf/qLCdakXbLgEcay3vtWC4UoNlTEQodNFYuFo34xRYR/ifVVqinCfN+z
         CWrbSo1MBeCsua6aBNThJLfyAlBgH5UHBIkdjEvneC9tRxK5EXmfegY+xsGF32v1D5fv
         dUVg==
X-Gm-Message-State: AOAM531KV0F+hcK0+MXc63jTU1U/Evl4clCvHFSrEHCJjS4GlyuxYYlq
        mOeDWomZFVTHVY/3iWT6JDUSSemaUHA=
X-Google-Smtp-Source: ABdhPJzZ2pkh84Xs7giiuJYzryaLE1Sfm/N6dNt+o5E4Yg/OPMusEnPCaFMHncjfA5rlxn7atwNzaA==
X-Received: by 2002:a65:5acd:0:b0:399:24bc:bbfd with SMTP id d13-20020a655acd000000b0039924bcbbfdmr604051pgt.323.1652377553663;
        Thu, 12 May 2022 10:45:53 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id f123-20020a62db81000000b00512d84548c7sm121950pfg.53.2022.05.12.10.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 10:45:52 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     willy@infradead.org, songmuchun@bytedance.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm: rmap: use the correct parameter name for DEFINE_PAGE_VMA_WALK
Date:   Thu, 12 May 2022 10:45:50 -0700
Message-Id: <20220512174551.81279-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameter used by DEFINE_PAGE_VMA_WALK is _page not page, fix the
parameter name.  It didn't cause any build error, it is probably because
the only caller is write_protect_page() from ksm.c, which pass in page.

Fixes: 2aff7a4755be ("mm: Convert page_vma_mapped_walk to work on PFNs")
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/rmap.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index cbe279a6f0de..d4f1c0bdd084 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -320,8 +320,8 @@ struct page_vma_mapped_walk {
 #define DEFINE_PAGE_VMA_WALK(name, _page, _vma, _address, _flags)	\
 	struct page_vma_mapped_walk name = {				\
 		.pfn = page_to_pfn(_page),				\
-		.nr_pages = compound_nr(page),				\
-		.pgoff = page_to_pgoff(page),				\
+		.nr_pages = compound_nr(_page),				\
+		.pgoff = page_to_pgoff(_page),				\
 		.vma = _vma,						\
 		.address = _address,					\
 		.flags = _flags,					\
-- 
2.26.3

