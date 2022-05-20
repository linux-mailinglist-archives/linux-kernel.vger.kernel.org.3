Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365AD52F4DB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 23:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353609AbiETVQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 17:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348920AbiETVQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 17:16:14 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC4B18378
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:16:12 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id gg20so9068417pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JIyZA5gCg5CAXtiIl9V3hnV4Plu8dZEF0XJ46lUoDcI=;
        b=fNZazHP6x/Jx1uUnoCCiU6V+dnJ+e35vigaFSLc8Rh4Zp7YU1YB06XnrNL1HX4eNyb
         PRYSUmNFUGkS6wq1DBbJCfx67xSfa/VLiP4ZDQAtJpJqLqRt2Bo3E89Mh9L8WnlAZOEB
         htEyOyZvjbMO+RyoJ2ZHu0aSOEKUCr57e3Gh6nFy0Y1BXhnZlNMuzIonX45ejLOEudXE
         1CAOehb+DNyJAnqayOLCOPGpJWcNn2CdmnmbknuAQtOF+UnlZr6uY4PkFk93uN25v9vN
         /szl806U81vvy1KM4V5T9QlkxCS8yeDBFSSWONZKkR29YVcsDF0DYT6v8K3I7c5uu/jg
         Tl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JIyZA5gCg5CAXtiIl9V3hnV4Plu8dZEF0XJ46lUoDcI=;
        b=nIPRCboH/wzh/+yOIYtFFT6dz+WJTZJAbu+eHwqZWARLhtFZY3V6jrULYOA9DyqvLQ
         0KJjMq9bnvmhV4X1I6PiaQL+aBooEEYSNs/qHRUSMSPU1yecYQJRb1fAK7yMP1mgPJ+2
         9isRx0hEQfEapEoz/1X44KGSkpgu1faFgIFcs8QWuU7lFr0Mlp32tidEOc1YVoubTfGn
         7+TrbXv+I80yMptaiI8Z/sNh8UGY9EV6DC09Me6OFNf9PcAFXxt/o2WKKxQipa5DUGtb
         nTlYVm9F24FKZdImrzIY/2oNmaMbJ5oKjKO6x2OQuPas0UWrHyZ6T+3AHNapvDjhtsY1
         /TbA==
X-Gm-Message-State: AOAM532Bz++IDns16TlmLoxqZo4ZEryQMhBwCRqoUg3iUyPIZIpe+xZ9
        YK8qQnszNSLNy13z9svICArvgZ2dJHM=
X-Google-Smtp-Source: ABdhPJyVmX+ajQFQxfZoPz3mdfjK2di45T69FoT0OU9SHu0WufoGwM4/9rD/TcimX9HzPDNzTNOa4Q==
X-Received: by 2002:a17:903:41c1:b0:161:bec6:b308 with SMTP id u1-20020a17090341c100b00161bec6b308mr11808346ple.161.1653081371803;
        Fri, 20 May 2022 14:16:11 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902748100b0015e8d4eb2c2sm167620pll.268.2022.05.20.14.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 14:16:10 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [mm-unstable PATCH 0/7] Cleanup transhuge_xxx helpers
Date:   Fri, 20 May 2022 14:15:58 -0700
Message-Id: <20220520211605.51473-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series is the follow-up of the discussion about cleaning up transhuge_xxx
helpers at https://lore.kernel.org/linux-mm/627a71f8-e879-69a5-ceb3-fc8d29d2f7f1@suse.cz/.

THP has a bunch of helpers that do VMA sanity check for different paths, they
do the similar checks for the most callsites and have a lot duplicate codes.
And it is confusing what helpers should be used at what conditions.

This series reorganized and cleaned up the code so that we could consolidate
all the checks into hugepage_vma_check().

The transhuge_vma_enabled(), transparent_hugepage_active() and
__transparent_hugepage_enabled() are killed by this series.

Added transhuge_vma_size_ok() helper to remove some duplicate code.


 b/fs/proc/task_mmu.c         |    4 +-
 b/include/linux/huge_mm.h    |  102 ++++++++++++++++++++++++++-----------------------------------------
 b/include/linux/khugepaged.h |   21 +------------
 b/mm/huge_memory.c           |   74 ++++++++++++++++++++++++++++++++++++------------
 b/mm/khugepaged.c            |   92 ++++++++++++++++--------------------------------------------
 b/mm/memory.c                |    6 ++-
 6 files changed, 129 insertions(+), 170 deletions(-)

