Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D658852E2C1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 04:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344899AbiETC4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 22:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiETC4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 22:56:30 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7FC5F8D4
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 19:56:27 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id ev18so6867410pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 19:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=arFWL10Ch1n8yhdI9Mk3g6bNs91IYU+HlkP+JS3nOtc=;
        b=wizXH2T4i0hpvyt1QyLKg8TJlFJ0pfc6am4wF+te/O3S9glO8olN0SHXNgf4XMOoeA
         vV2Wnl58mBKeekoB6US+vMjbV3r6LPQEj/7d2af5doeUV7LO3RAnChsoB+paO63F+lE3
         gIPtQB8Ee/hMqlf28gB6G0/OTsSEN7FhLi5vHK0GQNb2sbI+CJfs5nHoUTlVCtnj/TYK
         Sk6i6HD1cC+PTtTSSAi94V29xLQ7WhlBol3au+V0pxZ3UHwyuy4gCQv6l6w5VW3jZVFl
         E8eSg2aW86VGC044TmzYkarO+G2YkcYUswMF/Gshk+GKcHuvJgULhv9XTs+YgMxXR6w6
         3fBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=arFWL10Ch1n8yhdI9Mk3g6bNs91IYU+HlkP+JS3nOtc=;
        b=2LEPa815dyjj8KiXnEcMQP3MB6y3RYcvzPAoi/2QjMifQJHmpKAgnFqvV4paQofHN6
         vpWJFMLqwQk4zrZiTs+1U/oEXo4nF9inyXO5URmWILfuk2lrteUKVrHs0/gGjDNox2P2
         99AeE+SBVDlJxjTmMR5dnU1u4nGVqgjwaZhiaEkt/BBzZy6/n+TrMHcdHPqeFPR+6scl
         Yss4kphmFYQvnmm9JHmTf6iKC9ONUCcDcaKLdzWD2387g7yJitZ8BA666tf02NitqFdw
         WKoPDdnvygLuFhc/6e1WEhzHjApavw96SZTUAnafID7WwUbfnSmZtok4gq47cdW4AF+k
         atig==
X-Gm-Message-State: AOAM531w8u+YxY792CHoQNFs6V8k+f6IKVShY3EiREIo5/Vd2++G/rxy
        5uzlLJ0qffoW6K+uQ9Vwe5RJsg==
X-Google-Smtp-Source: ABdhPJzmfzbWN5y+2+2LQpGTfqGvPCPq3Ax+cTXuRcr74nqsBxj1mht756PZTm11HL7tsYT9gkMvYw==
X-Received: by 2002:a17:90b:4d0c:b0:1df:c9a6:84d8 with SMTP id mw12-20020a17090b4d0c00b001dfc9a684d8mr8900143pjb.231.1653015386971;
        Thu, 19 May 2022 19:56:26 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id o10-20020a62f90a000000b0050dc76281a5sm225675pfh.127.2022.05.19.19.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 19:56:26 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, akpm@linux-foundation.org, paulmck@kernel.org,
        mike.kravetz@oracle.com, osalvador@suse.de, david@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 0/2] make hugetlb_optimize_vmemmap compatible with memmap_on_memory
Date:   Fri, 20 May 2022 10:55:36 +0800
Message-Id: <20220520025538.21144-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
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

This series makes hugetlb_optimize_vmemmap compatible with memmap_on_memory
and is based on next-20220518.  The reason refers to the patch 2's commit log.

v2:
 - Fix compile error when !CONFIG_ZONE_DEVICE reported by kernel test robot.

Muchun Song (2):
  mm: memory_hotplug: enumerate all supported section flags
  mm: memory_hotplug: introduce SECTION_CANNOT_OPTIMIZE_VMEMMAP

 Documentation/admin-guide/kernel-parameters.txt | 22 ++++----
 Documentation/admin-guide/sysctl/vm.rst         |  5 +-
 include/linux/kconfig.h                         |  1 +
 include/linux/memory_hotplug.h                  |  9 ----
 include/linux/mmzone.h                          | 71 ++++++++++++++++++++++---
 mm/hugetlb_vmemmap.c                            | 28 +++++++---
 mm/memory_hotplug.c                             | 28 +++++-----
 mm/sparse.c                                     |  8 +++
 8 files changed, 119 insertions(+), 53 deletions(-)

-- 
2.11.0

