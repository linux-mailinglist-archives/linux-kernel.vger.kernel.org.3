Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E85F550AF8
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 15:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237084AbiFSNjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 09:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237781AbiFSNjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 09:39:12 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E96DE003
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 06:39:02 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id k5-20020a17090a404500b001e8875e6242so7964577pjg.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 06:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NJUThxAbJyqHo4wAO0WvoWToQ66mp7p8ZN8chIB/8WE=;
        b=y3Z8mKnOqPCBt5vg+KEZFQlp14jVAC0tlThNRZKuaqBPKHkl9D0vVDjZW7rPfrb00n
         ZoxvEe+DNEO3XJGDJ52QKjbRGPJw7w4sUe5+m5Fi0U8NMl13TepVQ99W9TE1xh374/DZ
         9r6ZvDv5TLJCjmAMgBnTCvCmKjo2/w3COAu5ZLKtbsk2EZuTVJl1PrbgGJwcPOoxP+N/
         nZTCTT98GlMO5r1gXApmtO756g7JBWNxVi2GJNChJYsrV9fcVzyJkpu9QSH4j54Agfjx
         6NgIiDynKEnSLwFarHV74U6a1BfCXKQorjAg7mcgJ+QV6W8fEj8arG6cK1js63YL5pL8
         txgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NJUThxAbJyqHo4wAO0WvoWToQ66mp7p8ZN8chIB/8WE=;
        b=yVui9B8OuCgRkk3hMzpVt9n35FvrLLKo+MZJg/97ZqnN+FGxRg3fy3IBjoVjCOaC/g
         hAGK9kFmoh11bpsdY00+jfH5dZErey6emhhmpSL1R0LhEFkLoFJ0HWlJxn5eS2y04R8A
         cBGUzQ+SmlHYjU96J9ILEBWToNPKjUQwX5t7Ztcv+fPXfzCsSrSUeb1MtLq97335dMaX
         8OEJb/R8GOtGzHYeK0yEigUu2h5HjGJqFOdNpfA8WNjnWDc9s69FwMoeP9p4KWTHBJ7+
         5gTWhySpMysh2g26bg8oGJHTKZ3oe1EIkk0GF55ySkB7ZSE9mEVIAu9tqkf0HXgNVxDc
         kGTQ==
X-Gm-Message-State: AJIora+gTosMHA7gavEWGpNbctDQAaAejbQOkzRXMPy+B7jClD/gzqca
        vwSGJxO88AIxrVGIFPhQ9330gg==
X-Google-Smtp-Source: AGRyM1trK4VDxsHco8/FgKM3jmUSM6Dk0Rt9A9V6YAAja/YFFDkZ1NRQTotG6djtdn5Tx8s4INAUpQ==
X-Received: by 2002:a17:903:2012:b0:16a:856:96a7 with SMTP id s18-20020a170903201200b0016a085696a7mr11566495pla.109.1655645942149;
        Sun, 19 Jun 2022 06:39:02 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id y23-20020a056a001c9700b0051b95c76752sm6990982pfw.153.2022.06.19.06.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 06:39:01 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, corbet@lwn.net, david@redhat.com,
        mike.kravetz@oracle.com, osalvador@suse.de, paulmck@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 0/2] make hugetlb_optimize_vmemmap compatible with memmap_on_memory
Date:   Sun, 19 Jun 2022 21:38:49 +0800
Message-Id: <20220619133851.68184-1-songmuchun@bytedance.com>
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
and is based on mm-stable.  The reason refers to the patch 2's commit log.

v4:
 - Fix compiling error when CONFIG_MEMORY_HOTPLUG is disabled reported by kernel test robot.
 - Fix a bug when memory_block_size_bytes() is not equal to section size.

v3:
 - Switch complicated enumeration magic (David).
 - Introduce PageVmemmapSelfHosted to make both parameters compatible (David and Oscar).

v2:
 - Fix compile error when !CONFIG_ZONE_DEVICE reported by kernel test robot.

Muchun Song (2):
  mm: memory_hotplug: enumerate all supported section flags
  mm: memory_hotplug: make hugetlb_optimize_vmemmap compatible with
    memmap_on_memory

 Documentation/admin-guide/kernel-parameters.txt | 22 +++++------
 Documentation/admin-guide/sysctl/vm.rst         |  5 +--
 include/linux/memory_hotplug.h                  |  9 -----
 include/linux/mmzone.h                          | 44 ++++++++++++++++-----
 include/linux/page-flags.h                      | 11 ++++++
 mm/hugetlb_vmemmap.c                            | 52 +++++++++++++++++++++----
 mm/memory_hotplug.c                             | 33 ++++++++--------
 mm/sparse.c                                     |  2 +-
 8 files changed, 121 insertions(+), 57 deletions(-)

-- 
2.11.0

