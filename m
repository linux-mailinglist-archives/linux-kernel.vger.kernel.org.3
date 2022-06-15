Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A8654BF8E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 04:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237284AbiFOCFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 22:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiFOCE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 22:04:59 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D983CFC2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 19:04:58 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o33-20020a17090a0a2400b001ea806e48c6so687828pjo.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 19:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZTEMzb2kbxmOG0IPL3JzkaKv5Etit65wHTgVH613vdo=;
        b=fEMFad+WsFNW5s4GCMXNnrGnm51i8mcLj5tEebvYOSSV2mSrZwh71Z+6oKwQ6pP9S0
         X7blX5ZHMrUUA3V+dpqXCntWfyddlG312G0BGBrl3f4zi4rrYILu3Td8cGEhPe+PeIHz
         SIy0pgZzazC4YpYJHyH+hjVOJjjDW2gY2vT1c5Aw34yUclx7QoIdavhWV1XF+pInqmTt
         vX8D057nm1gCKYBXo8xjPhjdvGJJmwD6mrtmgmqXDUp0yxx04dVKuig5ZhvYVSX2+Kub
         D3YNpIqgIdaNzvEqZCmfrKTfj5U7HpmRK/O2f/gR5aPRXgXuXK7b/lk0Izu2Jnl+hrw/
         9OHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZTEMzb2kbxmOG0IPL3JzkaKv5Etit65wHTgVH613vdo=;
        b=JaPp0rLqH1jo4GJnIHkzw0cxs54h364By0GzQN45lwttZqJBvPyHpSMIuAObmC57qx
         rquwnFfrol5akc1n1+bkXBGdnueibdOu0nz/8cBUrrfCwD5GjwYzjmu/805JYpyIamQR
         j9XqueQ8r0l5mW10Hf37KEgShQdxBSfL35PrfWG/FVOpFkillTQCe8k4lzdPBi+HBtq5
         MWQK7gG+rPT2GMnAYstul2VYY+LTx62OvollcqkWoITCNPgcJ4tNvPTekMOoYbusQUK8
         ve5TCOOIE86AaxcEvWjdYfoDGCjFjkHY09KMEdLWc72bFtNDm1vcLN0haCtc8I0Hf8yS
         tvdQ==
X-Gm-Message-State: AJIora8WtsN8ozaj5bxpJoCiP51x27RXJxsDMq2kD5OEcy80dkOWc+PN
        4Wc8ZtjojAd5wERmpHWJqJcn0QfEuDp84A==
X-Google-Smtp-Source: AGRyM1uJyUuCwXbIFrRgLXDqQaPfg7gcua0Z8rHf5H2q6M1easfzctdebPrsI2SuOMxgkyUcoVbo7w==
X-Received: by 2002:a17:902:7806:b0:168:d336:dda9 with SMTP id p6-20020a170902780600b00168d336dda9mr7054423pll.83.1655258698239;
        Tue, 14 Jun 2022 19:04:58 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id f17-20020aa79691000000b00518d06efbc8sm8538290pfk.98.2022.06.14.19.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 19:04:57 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     pizhenwei@bytedance.com, naoya.horiguchi@nec.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com,
        linmiaohe@huawei.com, gregkh@linuxfoundation.org
Subject: [PATCH v5 0/1] mm/memory-failure: don't allow to unpoison hw corrupted page
Date:   Wed, 15 Jun 2022 10:00:04 +0800
Message-Id: <20220615020005.246295-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
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

v4 -> v5:
- Add mf_flags 'MF_SW_SIMULATED' to distinguish SW/HW memory failure,
  and use a global variable to record HW memory failure, once HW
  memory failure happens, disable unpoison.

v3 -> v4:
- Add debug entry "hwpoisoned-pages" to show the number of hwpoisoned
  pages.
- Disable unpoison when a read HW memory failure occurs.

v2 -> v3:
- David pointed out that virt_to_kpte() is broken(no pmd_large() test
  on a PMD), so drop this API in this patch, walk kmap instead.

v1 -> v2:
- this change gets protected by mf_mutex
- use -EOPNOTSUPP instead of -EPERM 

v1:
- check KPTE to avoid to unpoison hardware corrupted page

zhenwei pi (1):
  mm/memory-failure: disable unpoison once hw error happens

 Documentation/vm/hwpoison.rst |  3 ++-
 drivers/base/memory.c         |  2 +-
 include/linux/mm.h            |  1 +
 mm/hwpoison-inject.c          |  2 +-
 mm/madvise.c                  |  2 +-
 mm/memory-failure.c           | 12 ++++++++++++
 6 files changed, 18 insertions(+), 4 deletions(-)

-- 
2.20.1

