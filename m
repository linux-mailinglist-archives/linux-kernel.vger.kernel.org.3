Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA8D5898A0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 09:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239151AbiHDHrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 03:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiHDHrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:47:35 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AABF33A03
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 00:47:34 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id r186so17253101pgr.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 00:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc;
        bh=7tcCc1HXDiltKOsKG0LhJndyX0Ozk+UGCrcm5eA/Ky8=;
        b=U8X78CLZM79QXisWFnZ5405VtyFR7FqLFDhV7QPrLomfUmf+ZqotwUmc0OXuCuJf4E
         xFRTLHES1yT4ERdCZd3arOQvJn0blUbJ991OM6O3H+PsYOZz/EEi/4i8JO3kL5+pvkd3
         NapP8iStNpMSCvst7rN5yfWfCNfhOxMe8O7Q8ls5Tev3yXCeg6IgI5tDBNce5giFsFpT
         xdKYCIMRGW4Y4ZF/bf2sZi6V9q1TIqaYICy+u+iI2Z7reVH8+z7jAyyrL9QHI/O5guLS
         lrNPO66eCxGxN7KNtVHiHZoP6i8FFde+CpkDBas9GXhaigqx4zEnOz+83RMA+eRwLPAT
         hEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc;
        bh=7tcCc1HXDiltKOsKG0LhJndyX0Ozk+UGCrcm5eA/Ky8=;
        b=uOe2tpaCH5WBAQ1/0qxZvVs8+EmDBZefdTdsRKBJn6MOKlJIqohIN4nz+JBcBT0x2k
         bTpD3GegUQpkZDpWh1TwerF3YCSROZ0AlzfnL3Lh73kUj1pjjm2RWUwtIMYS9RlNCr5R
         kV6sk5xHlhMIp5jIqHaREOsTLVeKC3zCzqktHPS0KllAuJLVxe4ju/5nBthe39/Z+lUj
         48IVsK7OO8g3kOxQeCzLpPkoDpDzth3nAFQ34F1gQcJAtZrEP3+IRaPfz37coAVxN/bK
         5GccAhq2G79i1OZ4veESO+xMrW9dhlu3NFCwx0mk5s4BEHun4n0OwGdzZUCDwjkx57xq
         Ylwg==
X-Gm-Message-State: ACgBeo3yGxo99Fw6R1bDKDKTNfFyfIl++E3C3B5QfD/7GjHr+BSGUTmo
        ryym1pQ3j71XwML1jFg1OXpMf91Mq1c=
X-Google-Smtp-Source: AA6agR4qD+uuXyUM5evi3dnEV0EKH6Ed9kcArUhkruGsOeyWsG5Qem0FmA1uzRrwqyRpMEXLpjr8OQ==
X-Received: by 2002:a63:e4f:0:b0:41a:9472:eca0 with SMTP id 15-20020a630e4f000000b0041a9472eca0mr617331pgo.623.1659599253624;
        Thu, 04 Aug 2022 00:47:33 -0700 (PDT)
Received: from haolee.io ([2600:3c01::f03c:91ff:fe02:b162])
        by smtp.gmail.com with ESMTPSA id y18-20020a170902b49200b0016bdcb8fbcdsm205697plr.47.2022.08.04.00.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 00:47:32 -0700 (PDT)
Date:   Thu, 4 Aug 2022 07:47:30 +0000
From:   Hao Lee <haolee.swjtu@gmail.com>
To:     akpm@linux-foundation.org
Cc:     david@redhat.com, yang.shi@linux.alibaba.com, hannes@cmpxchg.org,
        haolee.swjtu@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] mm: add DEVICE_ZONE to FOR_ALL_ZONES
Message-ID: <20220804074730.GA3269@haolee.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FOR_ALL_ZONES should be consistent with enum zone_type. Otherwise,
__count_zid_vm_events have the potential to add count to wrong
item when zid is ZONE_DEVICE.

Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
---
 include/linux/vm_event_item.h | 9 ++++++++-
 mm/vmstat.c                   | 9 ++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 7b2363388bfa..bcd57ab55413 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -20,7 +20,14 @@
 #define HIGHMEM_ZONE(xx)
 #endif
 
-#define FOR_ALL_ZONES(xx) DMA_ZONE(xx) DMA32_ZONE(xx) xx##_NORMAL, HIGHMEM_ZONE(xx) xx##_MOVABLE
+#ifdef CONFIG_ZONE_DEVICE
+#define DEVICE_ZONE(xx) xx##_DEVICE
+#else
+#define DEVICE_ZONE(xx)
+#endif
+
+#define FOR_ALL_ZONES(xx) (DMA_ZONE(xx) DMA32_ZONE(xx) xx##_NORMAL, \
+	HIGHMEM_ZONE(xx) xx##_MOVABLE, DEVICE_ZONE(xx))
 
 enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		FOR_ALL_ZONES(PGALLOC),
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 4057372745d0..5ccaeac44e61 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1167,8 +1167,15 @@ int fragmentation_index(struct zone *zone, unsigned int order)
 #define TEXT_FOR_HIGHMEM(xx)
 #endif
 
+#ifdef CONFIG_ZONE_DEVICE
+#define TEXT_FOR_DEVICE(xx) xx "_device",
+#else
+#define TEXT_FOR_DEVICE(xx)
+#endif
+
 #define TEXTS_FOR_ZONES(xx) TEXT_FOR_DMA(xx) TEXT_FOR_DMA32(xx) xx "_normal", \
-					TEXT_FOR_HIGHMEM(xx) xx "_movable",
+					TEXT_FOR_HIGHMEM(xx) xx "_movable", \
+					TEXT_FOR_DEVICE(xx)
 
 const char * const vmstat_text[] = {
 	/* enum zone_stat_item counters */
-- 
2.35.1

