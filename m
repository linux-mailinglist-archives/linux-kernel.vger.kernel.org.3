Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FFC4FA6C1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 12:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241422AbiDIKWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 06:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241404AbiDIKWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 06:22:48 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4ED3AAB43;
        Sat,  9 Apr 2022 03:20:40 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id o16so8445435ljp.3;
        Sat, 09 Apr 2022 03:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5QftsX1dgd5OMiDjNSHKc4sKfhDSWXlBSyJWmhsDORE=;
        b=lIcaIvVgQWhf4bm21WVG4xpWBPraOWyb1f6F59KYYAkMggzis7CkSLVbW6960O74u/
         el2jRgkdd2sXdTu7zCFrzGxuBYpP+pZ04sjx3fM5FvQHaXGdkKa8TSoJ/06Exx7rw43j
         bjAiH1puHxtVOPfC2t4JJo+1x8RS/QYeC9ZSxseviBh1fBzDdm2bg6wqAJ7RVxvFi5a4
         xsSHw8HDPTgNA3x8N+NzfCFOkgoJkByY/dzalIvn2bEvBX6iHWb7f9tAZm1yerigeM4x
         b6N3Ylh+F+y4pZuePJaBdZ/mad+RgxS2mwY7urf0ELWob8NzCy+2yhpoz6JXKw6vxfDR
         XZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5QftsX1dgd5OMiDjNSHKc4sKfhDSWXlBSyJWmhsDORE=;
        b=DpP7pD6+g3oQYilDkXZtkoclT84VVGn/gpBbQ/K0+Uv4qT+AYVqvb/PLpJg8Nknf4J
         v7OuABtX0wX4MfMQ3o3DGDNNk/628qUXCLiKXdtPHPHbSS3n/WNFl4ustjRQsdgH7+4D
         sXSpg6l1byonNJN/RJS19tupm+C1Eez4RZC6mr2fSSQELe4N8nMlVKJEE9b/9P8U9ieP
         OU08p2YvZ0vdLklysac5+53NNSr8jS7wuOksgWUFzRBvM2B+PdkPip2rdWZUxsm8IbKP
         enhKErl0SnDTf8I/+M/oAJAJHzXiKDyGkj7mm2AXqopWIOvhd2OU9h0V2mtjw1qx2MyX
         r0sg==
X-Gm-Message-State: AOAM5332aJj7i7OIQHcQdCa8BdRpV2OuU44e4sRPVdXD+nbegH10Govz
        qmx6tMwhxwZ1Gd2SzuNiPP4=
X-Google-Smtp-Source: ABdhPJwdqdeQNfPRzFlZMVy9U++8XAvooRz27TV4IDt40ZVMkyp9aNtRrPu1iD9L5v9gpgq2Z4XXOg==
X-Received: by 2002:a2e:700c:0:b0:24b:56ab:1ab8 with SMTP id l12-20020a2e700c000000b0024b56ab1ab8mr2089677ljc.357.1649499638896;
        Sat, 09 Apr 2022 03:20:38 -0700 (PDT)
Received: from morzel-asus.lan (static-91-225-135-18.devs.futuro.pl. [91.225.135.18])
        by smtp.gmail.com with ESMTPSA id h8-20020ac24da8000000b0046b8a03301bsm363680lfe.137.2022.04.09.03.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 03:20:38 -0700 (PDT)
From:   Michal Orzel <michalorzel.eng@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "Richard Russon (FlatCap)" <ldm@flatcap.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     Michal Orzel <michalorzel.eng@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, llvm@lists.linux.dev
Subject: [PATCH] block: Remove redundant assignments
Date:   Sat,  9 Apr 2022 12:19:32 +0200
Message-Id: <20220409101933.207157-2-michalorzel.eng@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220409101933.207157-1-michalorzel.eng@gmail.com>
References: <20220409101933.207157-1-michalorzel.eng@gmail.com>
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

Get rid of redundant assignments which end up in values not being
read either because they are overwritten or the function ends.

Reported by clang-tidy [deadcode.DeadStores]

Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>
---
 block/badblocks.c        |  2 --
 block/blk-map.c          |  5 ++---
 block/partitions/acorn.c |  4 ++--
 block/partitions/atari.c |  1 -
 block/partitions/ldm.c   | 15 +++------------
 5 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index d39056630d9c..3afb550c0f7b 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -65,7 +65,6 @@ int badblocks_check(struct badblocks *bb, sector_t s, int sectors,
 		s >>= bb->shift;
 		target += (1<<bb->shift) - 1;
 		target >>= bb->shift;
-		sectors = target - s;
 	}
 	/* 'target' is now the first block after the bad range */
 
@@ -345,7 +344,6 @@ int badblocks_clear(struct badblocks *bb, sector_t s, int sectors)
 		s += (1<<bb->shift) - 1;
 		s >>= bb->shift;
 		target >>= bb->shift;
-		sectors = target - s;
 	}
 
 	write_seqlock_irq(&bb->lock);
diff --git a/block/blk-map.c b/block/blk-map.c
index c7f71d83eff1..fa72e63e18c2 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -260,10 +260,9 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 
 		npages = DIV_ROUND_UP(offs + bytes, PAGE_SIZE);
 
-		if (unlikely(offs & queue_dma_alignment(rq->q))) {
-			ret = -EINVAL;
+		if (unlikely(offs & queue_dma_alignment(rq->q)))
 			j = 0;
-		} else {
+		else {
 			for (j = 0; j < npages; j++) {
 				struct page *page = pages[j];
 				unsigned int n = PAGE_SIZE - offs;
diff --git a/block/partitions/acorn.c b/block/partitions/acorn.c
index 2c381c694c57..d2fc122d7426 100644
--- a/block/partitions/acorn.c
+++ b/block/partitions/acorn.c
@@ -282,13 +282,13 @@ int adfspart_check_ADFS(struct parsed_partitions *state)
 #ifdef CONFIG_ACORN_PARTITION_RISCIX
 		case PARTITION_RISCIX_SCSI:
 		case PARTITION_RISCIX_MFM:
-			slot = riscix_partition(state, start_sect, slot,
+			riscix_partition(state, start_sect, slot,
 						nr_sects);
 			break;
 #endif
 
 		case PARTITION_LINUX:
-			slot = linux_partition(state, start_sect, slot,
+			linux_partition(state, start_sect, slot,
 					       nr_sects);
 			break;
 		}
diff --git a/block/partitions/atari.c b/block/partitions/atari.c
index da5994175416..9655c728262a 100644
--- a/block/partitions/atari.c
+++ b/block/partitions/atari.c
@@ -140,7 +140,6 @@ int atari_partition(struct parsed_partitions *state)
 				/* accept only GEM,BGM,RAW,LNX,SWP partitions */
 				if (!((pi->flg & 1) && OK_id(pi->id)))
 					continue;
-				part_fmt = 2;
 				put_partition (state, slot,
 						be32_to_cpu(pi->st),
 						be32_to_cpu(pi->siz));
diff --git a/block/partitions/ldm.c b/block/partitions/ldm.c
index 27f6c7d9c776..38e58960ae03 100644
--- a/block/partitions/ldm.c
+++ b/block/partitions/ldm.c
@@ -736,7 +736,6 @@ static bool ldm_parse_cmp3 (const u8 *buffer, int buflen, struct vblk *vb)
 		len = r_cols;
 	} else {
 		r_stripe = 0;
-		r_cols   = 0;
 		len = r_parent;
 	}
 	if (len < 0)
@@ -783,11 +782,8 @@ static int ldm_parse_dgr3 (const u8 *buffer, int buflen, struct vblk *vb)
 		r_id1 = ldm_relative (buffer, buflen, 0x24, r_diskid);
 		r_id2 = ldm_relative (buffer, buflen, 0x24, r_id1);
 		len = r_id2;
-	} else {
-		r_id1 = 0;
-		r_id2 = 0;
+	} else
 		len = r_diskid;
-	}
 	if (len < 0)
 		return false;
 
@@ -826,11 +822,8 @@ static bool ldm_parse_dgr4 (const u8 *buffer, int buflen, struct vblk *vb)
 		r_id1 = ldm_relative (buffer, buflen, 0x44, r_name);
 		r_id2 = ldm_relative (buffer, buflen, 0x44, r_id1);
 		len = r_id2;
-	} else {
-		r_id1 = 0;
-		r_id2 = 0;
+	} else
 		len = r_name;
-	}
 	if (len < 0)
 		return false;
 
@@ -963,10 +956,8 @@ static bool ldm_parse_prt3(const u8 *buffer, int buflen, struct vblk *vb)
 			return false;
 		}
 		len = r_index;
-	} else {
-		r_index = 0;
+	} else
 		len = r_diskid;
-	}
 	if (len < 0) {
 		ldm_error("len %d < 0", len);
 		return false;
-- 
2.25.1

