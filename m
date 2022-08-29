Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3CA5A4F4A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiH2OcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiH2OcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:32:07 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E4A9018D
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 07:32:07 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id i5-20020a17090a2a0500b001fd8708ffdfso5655874pjd.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 07:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=VxHvmbc/lBdRfA4ap1J+aJWHAOnddONgv856K5nzXe4=;
        b=SDTwVfFbyXwNSrRpny1mr9l89IK5bk6lTYXbTHbnX4AqrYfJExtEOYNP4DSZ+HpeeW
         aMDvxAGFqzQudjkelHF4dJ4ohqDxLZPrmo4x6xstMJOJEe1lUR/0IvhKfuZ9pkCEtqGi
         YpmmP41eqBmgMh/jnsypoXJ4e7N00sgVFNJ8vNORqJw3dJFpU+Ys8gI4Zulp0V/fhcdw
         MtGbX9seBRzHHPF8FJt2U9CSIru1y+8oxNpa6fxcBaTYm/J7dX5s1cczjANcpPzYN/BX
         24BjJPqI2o1al501/6O4p0rVbxYPuR3Mmbf0yn9SIAbtMkaaYoX3xkiA1g5q1wbYuVYF
         RRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=VxHvmbc/lBdRfA4ap1J+aJWHAOnddONgv856K5nzXe4=;
        b=oCNtaeDSeEojooAauuEdqrglDLLW44xYMmQy4LxSGW99OMfY7PDYYMEmO1ABWoZO55
         HNRKeOsn+bP8UkBXRuClvZ2pPRHXL3kt/C42Mhg4ccwztoggQNDDOfvt9BMLfTXG0awI
         ANyynl9vpcPQSSYtE35UBxwmI74P68FxpFf81bIZqKYfHAfQnPSua85TPQ9x/u6+JLQ6
         pi/BzmApIA+I7DB/gCrdSJOiIoAHoPyfVRoJcxuisHQLlEI0+6kVgF7LBLS/ZmSwsiQu
         Y+WupOQAWY8hlaQ9Lmknj23LylZtLYkx1XnrdLLfbtCohLpJPE9CHtP8WgkLz2UGxoNJ
         KYJw==
X-Gm-Message-State: ACgBeo2mnGKNv7wGenrnzzYPBbmZNejRwCNIbZBsZd/sixPw7rzwD+L4
        eGYkagLuMfBEdf211IDSaZGyZg==
X-Google-Smtp-Source: AA6agR6KRX0hB7clcZbineaxTaIDvcoWyzk5+jZFBvnvTwoj3q28uzUudWnvIqB4yHOJef3n9ImQOA==
X-Received: by 2002:a17:902:7c0b:b0:174:abfc:f5 with SMTP id x11-20020a1709027c0b00b00174abfc00f5mr6543887pll.124.1661783526523;
        Mon, 29 Aug 2022 07:32:06 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id x128-20020a626386000000b0052d200c8040sm7259327pfb.211.2022.08.29.07.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 07:32:05 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, willy@infradead.org, vbabka@suse.cz,
        hannes@cmpxchg.org, minchan@kernel.org, rppt@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 0/7] add common struct mm_slot and use it in THP and KSM
Date:   Mon, 29 Aug 2022 22:30:48 +0800
Message-Id: <20220829143055.41201-1-zhengqi.arch@bytedance.com>
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

