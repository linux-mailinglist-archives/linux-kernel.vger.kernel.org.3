Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE57757BB3D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 18:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238669AbiGTQTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 12:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiGTQTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:19:39 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D0156BBE;
        Wed, 20 Jul 2022 09:19:38 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n12so13988260wrc.8;
        Wed, 20 Jul 2022 09:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EjQ9X1UjGVK0ekLcqOx1pwSEWHylQ1/QnduEAyjuRmc=;
        b=TByb/N/DHTn7/Z8JvsFqoLDpF8Ud+M5a3LoilYUmA/eyfKEx42r81eG6MYdOEfgT1b
         CyOLK1u3RyiMHhsl5/6FO7PYqJKe6sxhKsAM8Uld9SbQQI36YnFbtxuVWIuq/SxEl0Rr
         L9AmlXzOhJ9xDl7t2/vsIaL6hr6McskDftxnSeG6mW4hFGjj4+IRjwn6WzrN32tHV3hw
         lECz+WC6NQloeLCM0lHGCHaloIDT2og3ckuOwG+1g8OdLGB/ShhY+CK+WuBU+HaGG4Hi
         1d2gd0DC/4WBF/iXZFvoN8P6zsVLKSL23TDicgJ7Lm1HqGw5mfTo5G4Fv1vias2Z8R7g
         Cxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EjQ9X1UjGVK0ekLcqOx1pwSEWHylQ1/QnduEAyjuRmc=;
        b=MVc0fFv5fX8AkKnelFO5TBSZVkvVf9xS4z1Coox7urWEYp2/fL/7Km33kneBA7yaC/
         S/s2nY5V51swPLELDiWWUv1524s4WwE89I7reRO0sPOtNcixL1GcGGJsKaLi7sH7yC06
         f4qtRr/V9EOtBW2GKEDREK3HhQKBW2vW00Jda5du6hjePuO25fCSyQcS2SugzHdjLAp0
         R5T3602FPRWtlBt35mmxnrq2UVu1BY7W4CXTS3a/Byewt3fOsyQYxzI47q7Hwspcuwc2
         sCady3YgeSv+RSOQf+BQZBfCW/leiEClKgvtpWz2krOlv3yCiKY5Uc3iXi3UYl4KnCSn
         NsVw==
X-Gm-Message-State: AJIora+tAcKaChBR8HygejJtTN/Y3tU0OG30SVFfaE4CRq98iC50mGoT
        VPO9iqHpbaP6MEcagVB+nAc=
X-Google-Smtp-Source: AGRyM1u918blttAuw2LS6/j/k2GCPiyM7r0oBnDfCG5hlleh0SVlyUss6NQBeh38HtvQduCNetF+vQ==
X-Received: by 2002:adf:d1e8:0:b0:21d:ac9c:983d with SMTP id g8-20020adfd1e8000000b0021dac9c983dmr31067113wrd.629.1658333977372;
        Wed, 20 Jul 2022 09:19:37 -0700 (PDT)
Received: from localhost.localdomain (host-95-235-102-55.retail.telecomitalia.it. [95.235.102.55])
        by smtp.gmail.com with ESMTPSA id p20-20020a1c5454000000b003a30c3d0c9csm3044513wmi.8.2022.07.20.09.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 09:19:36 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, Song Liu <song@kernel.org>,
        Takashi Iwai <tiwai@suse.de>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Matthew Wilcox <willy@infradead.com>
Subject: [PATCH v2] module: Replace kmap() with kmap_local_page()
Date:   Wed, 20 Jul 2022 18:19:32 +0200
Message-Id: <20220720161932.9567-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmap() is being deprecated in favor of kmap_local_page().

Two main problems with kmap(): (1) It comes with an overhead as mapping
space is restricted and protected by a global lock for synchronization and
(2) it also requires global TLB invalidation when the kmap’s pool wraps
and it might block when the mapping space is fully utilized until a slot
becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
Tasks can be preempted and, when scheduled to run again, the kernel
virtual addresses are restored and still valid.

kmap_local_page() is faster than kmap() in kernels with HIGHMEM enabled.

Since the use of kmap_local_page() in module_gzip_decompress() and in
module_xz_decompress() is safe (i.e., it does not break the strict rules
of use), it should be preferred over kmap().

Therefore, replace kmap() with kmap_local_page().

Tested on a QEMU/KVM x86_32 VM with 4GB RAM, booting kernels with
HIGHMEM64GB enabled. Modules compressed with XZ or GZIP decompress
properly.

Cc: Matthew Wilcox <willy@infradead.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v1->v2: Add information which says that the pointers returned by
kmap_local_page() are still valid if tasks are preempted and then
rescheduled to run again (thanks to Luis Chamberlain).

 kernel/module/decompress.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
index 2fc7081dd7c1..4d0bcb3d9e44 100644
--- a/kernel/module/decompress.c
+++ b/kernel/module/decompress.c
@@ -119,10 +119,10 @@ static ssize_t module_gzip_decompress(struct load_info *info,
 			goto out_inflate_end;
 		}
 
-		s.next_out = kmap(page);
+		s.next_out = kmap_local_page(page);
 		s.avail_out = PAGE_SIZE;
 		rc = zlib_inflate(&s, 0);
-		kunmap(page);
+		kunmap_local(s.next_out);
 
 		new_size += PAGE_SIZE - s.avail_out;
 	} while (rc == Z_OK);
@@ -178,11 +178,11 @@ static ssize_t module_xz_decompress(struct load_info *info,
 			goto out;
 		}
 
-		xz_buf.out = kmap(page);
+		xz_buf.out = kmap_local_page(page);
 		xz_buf.out_pos = 0;
 		xz_buf.out_size = PAGE_SIZE;
 		xz_ret = xz_dec_run(xz_dec, &xz_buf);
-		kunmap(page);
+		kunmap_local(xz_buf.out);
 
 		new_size += xz_buf.out_pos;
 	} while (xz_buf.out_pos == PAGE_SIZE && xz_ret == XZ_OK);
-- 
2.37.1

