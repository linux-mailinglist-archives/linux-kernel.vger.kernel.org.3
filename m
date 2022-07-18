Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE852577908
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 02:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbiGRA0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 20:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiGRA0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 20:26:53 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAB01055E;
        Sun, 17 Jul 2022 17:26:52 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id e15so13290233edj.2;
        Sun, 17 Jul 2022 17:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eaG7tyasUDLNkZr0c2b2Yhmdm4fYw+hdDjVnZoqV5T8=;
        b=OZMxnHtHjiYLYyG6v7GLc3yQu6T8jwNSCFJLo6Ddw/WlHYQGfp4mRQNpWupEio9D7I
         DY6kCQep3MsWsGpMMkZaYveAOd65NWMPSHk3MAXeM3olcJwIw9mc6nTAyAQ9V/GpEFFl
         nhHP9r5YjIuz7v8p623RmwbW6+ahpxyRjn5AtN1RqRpdespeIrQzTtq/GKjF+P6D7VWD
         GU65nDEWWj5viBtBviAIMiB/GI5TuKKuO3fNsh1BsHGx5H3NT6UKwNTRX6Se7SXCPz2w
         8RDuEl0+/NjatP1+ktR1RZd4seiHrlzsMr/Sq3NqOCyb7vR/APMxXy6iwqlxV5sRpV05
         1mTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eaG7tyasUDLNkZr0c2b2Yhmdm4fYw+hdDjVnZoqV5T8=;
        b=wDvFwC/isDJpKhRxsspUyg0MIKz+jLnLD163I49ImSOoPPJdglj4HxHO8+yBz3EgmO
         v1R+ZNa2ZX6fBF9doi3/mgIfzXY7NAAaOzEkR5yUmNT7EnGXwuIzNgSPPWPbsTlak4Pe
         jw5lGEkIl5zuO/UBIikuHt8Ti0Mz+IpPCb2occ4sa+kMVLJBPWAMC+v9E7bY1S8x0Zl/
         wYMVqXEW3pjoyqvtY4MbCirynN1FNJZSJW9BDt7kPT62URpw9NXjitBHa/DqeiV70obN
         XTbI4Y0Rw1sgBkl14zKsX92GsBZw2FT2XBA2MgTM5zwx1ld2hlLs2uivyOjtNCE7I4B2
         jZgw==
X-Gm-Message-State: AJIora/3Lmd51l5qwynKcbUzBFFCP1Df6qiwzUPeloey0gao3RfzgnqA
        iBzHpQ6VW1Pa0ZTuQsg8tvc=
X-Google-Smtp-Source: AGRyM1tUlWXSAG3vrAO0/0Gx206xr2vrIc7LwVKsfFTWiNBvmgvkcI1hMkR0HrurK3R/xTOxTLht6A==
X-Received: by 2002:a05:6402:3511:b0:43a:cb79:e7cb with SMTP id b17-20020a056402351100b0043acb79e7cbmr33159314edd.43.1658104010753;
        Sun, 17 Jul 2022 17:26:50 -0700 (PDT)
Received: from localhost.localdomain (host-95-235-102-55.retail.telecomitalia.it. [95.235.102.55])
        by smtp.gmail.com with ESMTPSA id ah8-20020a1709069ac800b00722d5b26ecesm4831748ejc.205.2022.07.17.17.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 17:26:49 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] module: Replace kmap() with kmap_local_page()
Date:   Mon, 18 Jul 2022 02:26:45 +0200
Message-Id: <20220718002645.28817-1-fmdefrancesco@gmail.com>
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
It is faster than kmap() in kernels with HIGHMEM enabled. Its use in
module_gzip_decompress() and in module_xz_decompress() is safe and
should be preferred.

Therefore, replace kmap() with kmap_local_page().

Tested on a QEMU/KVM x86_32 VM with 4GB RAM, booting kernels with
HIGHMEM64GB enabled. Modules compressed with XZ or GZIP decompress
properly.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
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

