Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621AF4C6FE8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbiB1OsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237376AbiB1Or7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:47:59 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763F97F6FF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:47:18 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id t13so9763278lfd.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GLLwg9Fhnlb38L2tvLtaEuKjOJI6ov8ETtoYyG5ZRfY=;
        b=Z/+pS6GgFR7zm4jLJc10kJpgAMBJgbwi0ldF1E1IIRJLou2mJu28USb16L76C1UteM
         spNeQalSMHsWeYetdWrCMI9Q+1K2XgVLaiOHoGj3WtzwUcZXL5i/iCBH48qtRQ5cYRux
         8jOx7z9LClaNjYVG7m1Ix4x47fYSB6etFDPDRv/zx1Ec1gj6h9tlUuQI3hTeoU1LBPue
         F3u2JPl7/L/4dMi+r9s7MVTDY7Dp/z26jKG+MmyHnmNTubTpEYSkpjhRXowZY4veAH07
         2/h+x+ZuTMONbwwKvlbKkFVAWbASwBPTjLJt6HscsT9rGfpvPL4CuGKKeC0CsKWkhN61
         TUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GLLwg9Fhnlb38L2tvLtaEuKjOJI6ov8ETtoYyG5ZRfY=;
        b=7x4eEhb2Zq53m0E3BgTIMzmo+NUwidFz7kZYm5b9XtxrnfTb0ITmBBjP8ShjUcEBm4
         0jcH6kLBYJmpy7KQ66VX9akjOsv1DUkuTWOCWCB6FF4OPcru4lSwWWVok57vPrbrkjpy
         1Vn54Ptw+A/NmDvPJFPtrSLFElvXLJq5lTO4EkXrlHe9ITAZc+iJvAsVyPB0V+SmaKx9
         kDTyr1kr9Qhfnibf3pX1jeL2xGrrxUjaCwb0YHr4bCPdkzJqd+pwfdoHytVeS8dabs9n
         W3IrD3tzEyEkF+EzsUeMxG10mJfUqGfCx9DFMuT2DvGVS2bD0PHROzdHR+Up46ySW4As
         JnSQ==
X-Gm-Message-State: AOAM5320GYw2gUVZWl4rNiMbBdXtJTYASIcA6+Nkl/mKIpBhRylR6Ow1
        Imzke4UlvKk2qjLhOIVntpum2tI59vY=
X-Google-Smtp-Source: ABdhPJx5rOLrb4DxrJhKqGG5ymfCovJvN4eC3oSniQJOAkJUanT5YKcq6AmbAdTYBtfZJHBBB2SlPg==
X-Received: by 2002:ac2:549a:0:b0:443:f15d:e582 with SMTP id t26-20020ac2549a000000b00443f15de582mr13323295lfk.90.1646059636694;
        Mon, 28 Feb 2022 06:47:16 -0800 (PST)
Received: from elysium.toya.net.pl (staticline-31-183-165-244.toya.net.pl. [31.183.165.244])
        by smtp.gmail.com with ESMTPSA id r14-20020ac252ae000000b00443f3cbc03asm993996lfm.6.2022.02.28.06.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 06:47:16 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     rppt@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 1/9] memblock tests: Split up reset_memblock function
Date:   Mon, 28 Feb 2022 15:46:43 +0100
Message-Id: <5cc1ba9a0ade922dbf4ba450165b81a9ed17d4a9.1646055639.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1646055639.git.karolinadrobnik@gmail.com>
References: <cover.1646055639.git.karolinadrobnik@gmail.com>
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

All memblock data structure fields are reset in one function. In some
test cases, it's preferred to reset memory region arrays without
modifying other values like allocation direction flag.

Extract two functions from reset_memblock, so it's possible to reset
different parts of memblock:
  - reset_memblock_regions    - reset region arrays and their counters
  - reset_memblock_attributes - set other fields to their default values

Update checks in basic_api.c to use new definitions. Remove
reset_memblock call from memblock_initialization_check, so the true
initial values are tested.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 tools/testing/memblock/tests/basic_api.c | 48 ++++++++++++------------
 tools/testing/memblock/tests/common.c    | 14 ++++---
 tools/testing/memblock/tests/common.h    |  3 +-
 3 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
index fbb989f6ddbf..d5035a3dcce8 100644
--- a/tools/testing/memblock/tests/basic_api.c
+++ b/tools/testing/memblock/tests/basic_api.c
@@ -8,8 +8,6 @@

 static int memblock_initialization_check(void)
 {
-	reset_memblock();
-
 	assert(memblock.memory.regions);
 	assert(memblock.memory.cnt == 1);
 	assert(memblock.memory.max == EXPECTED_MEMBLOCK_REGIONS);
@@ -43,7 +41,7 @@ static int memblock_add_simple_check(void)
 		.size = SZ_4M
 	};

-	reset_memblock();
+	reset_memblock_regions();
 	memblock_add(r.base, r.size);

 	assert(rgn->base == r.base);
@@ -72,7 +70,7 @@ static int memblock_add_node_simple_check(void)
 		.size = SZ_16M
 	};

-	reset_memblock();
+	reset_memblock_regions();
 	memblock_add_node(r.base, r.size, 1, MEMBLOCK_HOTPLUG);

 	assert(rgn->base == r.base);
@@ -110,7 +108,7 @@ static int memblock_add_disjoint_check(void)
 		.size = SZ_8K
 	};

-	reset_memblock();
+	reset_memblock_regions();
 	memblock_add(r1.base, r1.size);
 	memblock_add(r2.base, r2.size);

@@ -151,7 +149,7 @@ static int memblock_add_overlap_top_check(void)

 	total_size = (r1.base - r2.base) + r1.size;

-	reset_memblock();
+	reset_memblock_regions();
 	memblock_add(r1.base, r1.size);
 	memblock_add(r2.base, r2.size);

@@ -190,7 +188,7 @@ static int memblock_add_overlap_bottom_check(void)

 	total_size = (r2.base - r1.base) + r2.size;

-	reset_memblock();
+	reset_memblock_regions();
 	memblock_add(r1.base, r1.size);
 	memblock_add(r2.base, r2.size);

@@ -225,7 +223,7 @@ static int memblock_add_within_check(void)
 		.size = SZ_1M
 	};

-	reset_memblock();
+	reset_memblock_regions();
 	memblock_add(r1.base, r1.size);
 	memblock_add(r2.base, r2.size);

@@ -249,7 +247,7 @@ static int memblock_add_twice_check(void)
 		.size = SZ_2M
 	};

-	reset_memblock();
+	reset_memblock_regions();

 	memblock_add(r.base, r.size);
 	memblock_add(r.base, r.size);
@@ -290,7 +288,7 @@ static int memblock_reserve_simple_check(void)
 		.size = SZ_128M
 	};

-	reset_memblock();
+	reset_memblock_regions();
 	memblock_reserve(r.base, r.size);

 	assert(rgn->base == r.base);
@@ -321,7 +319,7 @@ static int memblock_reserve_disjoint_check(void)
 		.size = SZ_512M
 	};

-	reset_memblock();
+	reset_memblock_regions();
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);

@@ -364,7 +362,7 @@ static int memblock_reserve_overlap_top_check(void)

 	total_size = (r1.base - r2.base) + r1.size;

-	reset_memblock();
+	reset_memblock_regions();
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);

@@ -404,7 +402,7 @@ static int memblock_reserve_overlap_bottom_check(void)

 	total_size = (r2.base - r1.base) + r2.size;

-	reset_memblock();
+	reset_memblock_regions();
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);

@@ -440,7 +438,7 @@ static int memblock_reserve_within_check(void)
 		.size = SZ_64K
 	};

-	reset_memblock();
+	reset_memblock_regions();
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);

@@ -465,7 +463,7 @@ static int memblock_reserve_twice_check(void)
 		.size = SZ_2M
 	};

-	reset_memblock();
+	reset_memblock_regions();

 	memblock_reserve(r.base, r.size);
 	memblock_reserve(r.base, r.size);
@@ -511,7 +509,7 @@ static int memblock_remove_simple_check(void)
 		.size = SZ_4M
 	};

-	reset_memblock();
+	reset_memblock_regions();
 	memblock_add(r1.base, r1.size);
 	memblock_add(r2.base, r2.size);
 	memblock_remove(r1.base, r1.size);
@@ -545,7 +543,7 @@ static int memblock_remove_absent_check(void)
 		.size = SZ_1G
 	};

-	reset_memblock();
+	reset_memblock_regions();
 	memblock_add(r1.base, r1.size);
 	memblock_remove(r2.base, r2.size);

@@ -585,7 +583,7 @@ static int memblock_remove_overlap_top_check(void)
 	r2_end = r2.base + r2.size;
 	total_size = r1_end - r2_end;

-	reset_memblock();
+	reset_memblock_regions();
 	memblock_add(r1.base, r1.size);
 	memblock_remove(r2.base, r2.size);

@@ -623,7 +621,7 @@ static int memblock_remove_overlap_bottom_check(void)

 	total_size = r2.base - r1.base;

-	reset_memblock();
+	reset_memblock_regions();
 	memblock_add(r1.base, r1.size);
 	memblock_remove(r2.base, r2.size);

@@ -665,7 +663,7 @@ static int memblock_remove_within_check(void)
 	r2_size = (r1.base + r1.size) - (r2.base + r2.size);
 	total_size = r1_size + r2_size;

-	reset_memblock();
+	reset_memblock_regions();
 	memblock_add(r1.base, r1.size);
 	memblock_remove(r2.base, r2.size);

@@ -715,7 +713,7 @@ static int memblock_free_simple_check(void)
 		.size = SZ_1M
 	};

-	reset_memblock();
+	reset_memblock_regions();
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 	memblock_free((void *)r1.base, r1.size);
@@ -749,7 +747,7 @@ static int memblock_free_absent_check(void)
 		.size = SZ_128M
 	};

-	reset_memblock();
+	reset_memblock_regions();
 	memblock_reserve(r1.base, r1.size);
 	memblock_free((void *)r2.base, r2.size);

@@ -787,7 +785,7 @@ static int memblock_free_overlap_top_check(void)

 	total_size = (r1.size + r1.base) - (r2.base + r2.size);

-	reset_memblock();
+	reset_memblock_regions();
 	memblock_reserve(r1.base, r1.size);
 	memblock_free((void *)r2.base, r2.size);

@@ -824,7 +822,7 @@ static int memblock_free_overlap_bottom_check(void)

 	total_size = r2.base - r1.base;

-	reset_memblock();
+	reset_memblock_regions();
 	memblock_reserve(r1.base, r1.size);
 	memblock_free((void *)r2.base, r2.size);

@@ -867,7 +865,7 @@ static int memblock_free_within_check(void)
 	r2_size = (r1.base + r1.size) - (r2.base + r2.size);
 	total_size = r1_size + r2_size;

-	reset_memblock();
+	reset_memblock_regions();
 	memblock_reserve(r1.base, r1.size);
 	memblock_free((void *)r2.base, r2.size);

diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
index 03de6eab0c3c..dd7e87c589fe 100644
--- a/tools/testing/memblock/tests/common.c
+++ b/tools/testing/memblock/tests/common.c
@@ -5,23 +5,25 @@
 #define INIT_MEMBLOCK_REGIONS			128
 #define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS

-void reset_memblock(void)
+void reset_memblock_regions(void)
 {
 	memset(memblock.memory.regions, 0,
 	       memblock.memory.cnt * sizeof(struct memblock_region));
-	memset(memblock.reserved.regions, 0,
-	       memblock.reserved.cnt * sizeof(struct memblock_region));
-
 	memblock.memory.cnt	= 1;
 	memblock.memory.max	= INIT_MEMBLOCK_REGIONS;
-	memblock.memory.name	= "memory";
 	memblock.memory.total_size = 0;

+	memset(memblock.reserved.regions, 0,
+	       memblock.reserved.cnt * sizeof(struct memblock_region));
 	memblock.reserved.cnt	= 1;
 	memblock.reserved.max	= INIT_MEMBLOCK_RESERVED_REGIONS;
-	memblock.reserved.name	= "reserved";
 	memblock.reserved.total_size = 0;
+}

+void reset_memblock_attributes(void)
+{
+	memblock.memory.name	= "memory";
+	memblock.reserved.name	= "reserved";
 	memblock.bottom_up	= false;
 	memblock.current_limit	= MEMBLOCK_ALLOC_ANYWHERE;
 }
diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
index 48efc4270ea1..b864c64fb60f 100644
--- a/tools/testing/memblock/tests/common.h
+++ b/tools/testing/memblock/tests/common.h
@@ -10,6 +10,7 @@ struct region {
 	phys_addr_t size;
 };

-void reset_memblock(void);
+void reset_memblock_regions(void);
+void reset_memblock_attributes(void);

 #endif
--
2.30.2

