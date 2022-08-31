Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9855A7467
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 05:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiHaDUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 23:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbiHaDUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 23:20:21 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1616510FED
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 20:20:09 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 202so12397904pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 20:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=v7Q+HHnOQCPwmVlfrZr6AImldFLltmX8PsInykk2xfI=;
        b=U65jboiY95Cmqy2YaTAbsIibfhChRdktNV1Du22CPObuhxwOnA8eyc1SxFlUMa5kWG
         GNMayYyOHqpYZ92tPKgGQnPJJT2yDPjgEmK0MC2U6SJxlA7rvM93Bz4H4JWiYIKwX8DP
         Hc0AFB3MrtvutmvE3wBnNpxI0V9C7gaL+x/A/bqc+IudJigVLqGOOO/RSwLU89dvdpcr
         vkxMuMBgHZ+gtCPYWJ75zBPfJV6gW0tjplLBOGQ//toIStK2aWYpTbvOL4/mWdnhCi9n
         6zgw/rFvswBkTxEIfRrF5N/tyZjynT91saOsslEnNX+3QTxwFW7mHlHBOA7ICxG4H/JV
         tdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=v7Q+HHnOQCPwmVlfrZr6AImldFLltmX8PsInykk2xfI=;
        b=0TpHolHrmxquDhhPT2SlM0JTFtXdM0VgmEhxCVYw/EXcvyCBk/C6hqGcWIcRASmxC/
         ePhVwnHbcxKIOGmCy5QmhHXIh6cAFW2hCy2D4xjdZ0rlUXJHQUItHjf0eqDTu3o8w53o
         oTy7VJynpwy9iFkfdTPpjcnOKbpE/Fa2mlbxHwZmon8xreafaXir/BSe/Pk1HDWC5Qjb
         TTPO9KA9bqwzFnSwegci4eWvI6gVVKBp47KLDxuqM2eEcu+zYOZQ272kAHMMIEflXu9P
         RKmETDBICPWoLPYgCaUGizu1/5kSzVq0Kzd5qagWFbKgrhIDqgbmNDc3PXQvWiSfVgmW
         sIXg==
X-Gm-Message-State: ACgBeo0g6z/L01M89hD4QJeEUqYwzh80/3Rb7n/vpVinQgQ0BV5vULAD
        /VN/GlRjLF839CvWbwLySVYEJYnYkIl8AQ==
X-Google-Smtp-Source: AA6agR7e935S+GyysaLfzhD2W1iEFkDAPWWkN74h5pwx87iu5LAlQQ/LsctQuqZ2LVy/sicAR/Unbg==
X-Received: by 2002:aa7:8393:0:b0:537:701d:e7f3 with SMTP id u19-20020aa78393000000b00537701de7f3mr24416745pfm.50.1661916008151;
        Tue, 30 Aug 2022 20:20:08 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id i13-20020a170902c94d00b0015e8d4eb1d5sm8633535pla.31.2022.08.30.20.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 20:20:07 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, shy828301@gmail.com,
        willy@infradead.org, vbabka@suse.cz, hannes@cmpxchg.org,
        minchan@kernel.org, rppt@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 0/7] add common struct mm_slot and use it in THP and KSM
Date:   Wed, 31 Aug 2022 11:19:44 +0800
Message-Id: <20220831031951.43152-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

At present, both THP and KSM module have similar structures mm_slot for
organizing and recording the information required for scanning mm, and
each defines the following exactly the same operation functions:

 - alloc_mm_slot
 - free_mm_slot
 - get_mm_slot
 - insert_to_mm_slots_hash

In order to de-duplicate these codes, this patchset introduces a common
struct mm_slot, and lets THP and KSM to use it.

This series is based on next-20220829.

Comments and suggestions are welcome.

Thanks,
Qi.

Changelog in v1 -> v2:
 - change the names of these mm_slot related operation functions
   (suggested by Andrew)

Qi Zheng (7):
  mm: introduce common struct mm_slot
  mm: thp: convert to use common struct mm_slot
  ksm: remove redundant declarations in ksm.h
  ksm: add the ksm prefix to the names of the ksm private structures
  ksm: convert ksm_mm_slot.mm_list to ksm_mm_slot.mm_node
  ksm: convert ksm_mm_slot.link to ksm_mm_slot.hash
  ksm: convert to use common struct mm_slot

 Documentation/mm/ksm.rst |   2 +-
 include/linux/ksm.h      |   3 -
 mm/khugepaged.c          | 121 ++++++---------
 mm/ksm.c                 | 326 ++++++++++++++++++---------------------
 mm/mm_slot.h             |  55 +++++++
 5 files changed, 260 insertions(+), 247 deletions(-)
 create mode 100644 mm/mm_slot.h

-- 
2.20.1

