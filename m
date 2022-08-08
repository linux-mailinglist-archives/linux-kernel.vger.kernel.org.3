Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B8B58BE9B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 02:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbiHHA5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 20:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbiHHA5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 20:57:04 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D783B49A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 17:57:04 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id e8-20020a17090a280800b001f2fef7886eso7674710pjd.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 17:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=trpRXvmFHTWKEanKbEL3EOrwzaz4Qg86JnLq2qjjATg=;
        b=k8q8F3O9itdWzfGswqCnLbH3LdJQWsxB24a5mOHYuuxQo4sIU6+andY8QM5Romn1Tf
         ++EIfoJuUbWsLq69dTxSQrE9pZQhuUQBYMbTtTe6lX2ebQPqeD3ONbzqxcs++qUrn/Dx
         duTwaBE/5Z0Ncp1xOw4Y7pIyMHpr9E1EbwTR7nelCBgemPer8luqneXgKcjhAhYi2wQK
         ZuVVkG41t2FQy017FfOB2W832CXfE1K3WiTKh5zjZhOtI6TjGZzI/nqEGy6tgrz7KTBV
         RHTeqyhKdHWlQNWafCqxzhLqPC0yzFED6kT5ICVy/xCDFSEIABShcN9WO4yigZUWlpzt
         LzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=trpRXvmFHTWKEanKbEL3EOrwzaz4Qg86JnLq2qjjATg=;
        b=n8LlLdpn//3nxz6NOxc4UFatfKYsvTugF1j1in8bWNlOJVYBby/Cm0QLG7a28y1GYw
         3awv5X4+90OQ1nQ5bvyV3JGZdoy44yo2CMwBIHAjojKlb95Fi3bYUYDvqses8Yv3B5mB
         lp4lSoiVPU45GgdQrNB1yf1s0iDAfdBQTPqSdZDIDNSzjpKCe10yAkuv1aIFjAi1rv1d
         t+TjQjyF40TmKuEXlOM83wf0UffTvjmRJG9E76oEbkpPYcGSg4FsJcgW6J6Ae/JvfHJ6
         h+aLihZrBwuCMMVUP2CnL5i7h9BWeZwYtPRU3p/JkO+iDzFDJ2ACFvgTeGHPSo3zSKpj
         intw==
X-Gm-Message-State: ACgBeo2lDCqQoUGLkchTQMZiPdFPNFrhbwF5Dy4f/lTrhloA3YRRObhl
        S9we8jcTEfmoqxofqT+5+c0=
X-Google-Smtp-Source: AA6agR5hq4HQHbrJUnjOtFv65LhemxGljkUyYobdG4D3SofKLFGEyz007HLPQPxDOwbHNY25IQFWhw==
X-Received: by 2002:a17:90b:4b89:b0:1f5:68b:b14e with SMTP id lr9-20020a17090b4b8900b001f5068bb14emr27524755pjb.30.1659920223538;
        Sun, 07 Aug 2022 17:57:03 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id j13-20020a170902da8d00b001709aea1516sm2278564plx.276.2022.08.07.17.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 17:57:02 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     akpm@linux-foundation.org, hannes@cmpxchg.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Yang <yang.yang29@zte.com.cn>
Subject: [PATCH v2] mm/vmscan: define macros for refaults in struct lruvec
Date:   Mon,  8 Aug 2022 00:56:45 +0000
Message-Id: <20220808005644.1721066-1-yang.yang29@zte.com.cn>
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

From: Yang Yang <yang.yang29@zte.com.cn>

The magic number 0 and 1 are used in several places in vmscan.c.
Define macros for them to improve code readability.

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
---
Change for v2:
 - fix compile error when CONFIG_NFSD is y
---
 include/linux/mmzone.h | 2 ++
 mm/vmscan.c            | 8 ++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index e24b40c52468..8f571dc7c524 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -306,6 +306,8 @@ static inline bool is_active_lru(enum lru_list lru)
 	return (lru == LRU_ACTIVE_ANON || lru == LRU_ACTIVE_FILE);
 }
 
+#define WORKINGSET_ANON 0
+#define WORKINGSET_FILE 1
 #define ANON_AND_FILE 2
 
 enum lruvec_flags {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b2b1431352dc..428f8fa60331 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3230,7 +3230,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 
 		refaults = lruvec_page_state(target_lruvec,
 				WORKINGSET_ACTIVATE_ANON);
-		if (refaults != target_lruvec->refaults[0] ||
+		if (refaults != target_lruvec->refaults[WORKINGSET_ANON] ||
 			inactive_is_low(target_lruvec, LRU_INACTIVE_ANON))
 			sc->may_deactivate |= DEACTIVATE_ANON;
 		else
@@ -3243,7 +3243,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 		 */
 		refaults = lruvec_page_state(target_lruvec,
 				WORKINGSET_ACTIVATE_FILE);
-		if (refaults != target_lruvec->refaults[1] ||
+		if (refaults != target_lruvec->refaults[WORKINGSET_FILE] ||
 		    inactive_is_low(target_lruvec, LRU_INACTIVE_FILE))
 			sc->may_deactivate |= DEACTIVATE_FILE;
 		else
@@ -3559,9 +3559,9 @@ static void snapshot_refaults(struct mem_cgroup *target_memcg, pg_data_t *pgdat)
 
 	target_lruvec = mem_cgroup_lruvec(target_memcg, pgdat);
 	refaults = lruvec_page_state(target_lruvec, WORKINGSET_ACTIVATE_ANON);
-	target_lruvec->refaults[0] = refaults;
+	target_lruvec->refaults[WORKINGSET_ANON] = refaults;
 	refaults = lruvec_page_state(target_lruvec, WORKINGSET_ACTIVATE_FILE);
-	target_lruvec->refaults[1] = refaults;
+	target_lruvec->refaults[WORKINGSET_FILE] = refaults;
 }
 
 /*
-- 
2.25.1

