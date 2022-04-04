Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F234F1045
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 09:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356349AbiDDHtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 03:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239741AbiDDHtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 03:49:14 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD13917ABF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 00:47:18 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id g15-20020a17090adb0f00b001caa9a230c7so833756pjv.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 00:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0eeT6kPw0yLPrANsQAxwIxRSWeGtxpHd9u+X7Wv3pGE=;
        b=Y+9H/px8pBLuWwNc5mNdxkF+MHWQsFi8MXFzKzIQ3IphDkradk32peIA372HJM9sRd
         9/XBzNydfRNBjL5g9VPofLauSg2M2l4JUCRcYRwPZS2JRyjTa6a8AlAZJ5lm2xRbPnEy
         x3iwBrrBPNLSPWiYGWPsmYyohRHk/1gYItdb0su6o/MLCgVnVv54ScrZxgrW1YzinsoT
         lVyrD0Z+gis08MqKFLrepPq98OAR08Q0iPrJR5DRlObxKLoKQg5gVsksn/Ja32+TAGE7
         NMCB8aWB91vGlYUr1mDCyxwcE9b6UIE2xfIGl7lHxhN1FRWNztQM83ZI4UJY9ifWwzck
         v2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0eeT6kPw0yLPrANsQAxwIxRSWeGtxpHd9u+X7Wv3pGE=;
        b=ladcT5X1TkMttymUE64auDuf0x9tLhNTlKFB60+Lm+fXH3cTax5FdgMPBg0WOZ2xIJ
         KoUNiQ/ATjLd/I5EF/wIKMlVn0DS/64Aq3w7Kj71LH3Rim4pq48tEjlWK5zIc5Xl/d/U
         gGxkLsZgxSqY4ZX8ie/GSs99yUWrjCCf/2wUgh3VYb/6dRhOYqSsAc2U0o5G51XJB4ZH
         jAMuruEKrB3UdrIJD8zH+yepHnURgYXlA3kqDTtgwcz8RzINuIKUnvqy6N/FOj4/nQWE
         aSIC1oHj/PXaI/StUkoBiUlvHwGhOysH+RR5Jkx7ilwFOo6EKsJ1K8SBna8+mMdCnhDj
         whwQ==
X-Gm-Message-State: AOAM533cqlEK0rSVpXm8JRB4EZTNMUQvEUjE+PxTndsmgAAPBZwlD7hW
        /wu7tata77A82TEsx6C7ZNeu2A==
X-Google-Smtp-Source: ABdhPJzRe/n6k0xdw97giJs6QEXkVJSOZ+CF0WqVP2yuW58cDTjgrcK3nXt32NvZ4ILaeG4XXrjPog==
X-Received: by 2002:a17:902:e193:b0:156:a04a:40d0 with SMTP id y19-20020a170902e19300b00156a04a40d0mr4453833pla.125.1649058437835;
        Mon, 04 Apr 2022 00:47:17 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id g70-20020a636b49000000b003823dd39d41sm9376579pgc.64.2022.04.04.00.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 00:47:17 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        david@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        smuchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 0/3] cleanup hugetlb_vmemmap
Date:   Mon,  4 Apr 2022 15:46:49 +0800
Message-Id: <20220404074652.68024-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on next-20220404.

The word of "free" is not expressive enough to express the feature of optimizing
vmemmap pages associated with each HugeTLB, rename this keywork to "optimeze" is
more clear.  In this series, cheanup related codes to make it more clear and
expressive.  This is suggested by David.

Muchun Song (3):
  mm: hugetlb_vmemmap: cleanup hugetlb_vmemmap related functions
  mm: hugetlb_vmemmap: cleanup hugetlb_free_vmemmap_enabled*
  mm: hugetlb_vmemmap: cleanup CONFIG_HUGETLB_PAGE_FREE_VMEMMAP*

 Documentation/admin-guide/kernel-parameters.txt |  4 +-
 Documentation/admin-guide/mm/hugetlbpage.rst    |  2 +-
 arch/arm64/Kconfig                              |  2 +-
 arch/arm64/mm/flush.c                           |  4 +-
 arch/x86/Kconfig                                |  2 +-
 arch/x86/mm/init_64.c                           |  2 +-
 fs/Kconfig                                      | 16 +++----
 include/linux/hugetlb.h                         |  4 +-
 include/linux/mm.h                              |  2 +-
 include/linux/page-flags.h                      | 18 ++++----
 mm/Makefile                                     |  2 +-
 mm/hugetlb.c                                    | 10 ++---
 mm/hugetlb_vmemmap.c                            | 56 ++++++++++++-------------
 mm/hugetlb_vmemmap.h                            | 24 +++++------
 mm/memory_hotplug.c                             |  2 +-
 mm/sparse-vmemmap.c                             |  4 +-
 16 files changed, 76 insertions(+), 78 deletions(-)

-- 
2.11.0

