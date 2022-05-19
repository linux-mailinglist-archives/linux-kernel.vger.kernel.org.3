Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D4252D2E1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 14:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238022AbiESMrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 08:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiESMrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 08:47:20 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC55B41C3
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 05:47:19 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d22so4676959plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 05:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MYyQzWIkXnUbU1T1yV7uK/sxU37R6l9GZVdK4va9skk=;
        b=ob80Nu+DvgBQqlGy9viAvvN+Y1H0mwtXx4Pges6V0kIBMypwpwyU7ngXS1hY4rCv4S
         2+hn+fRPoo0mzqjyXh8RNxmH/2RNBLxRpuiK2qdMy8hJea5OEgZ9uFyGH9SB1q6ZB/7M
         dC3C14yvbbkfLxwVghh9hjXeh9Lk1ajHkS3DoeMfRMbXXrnqLUxqluzMQ/92ljh1Y6WS
         fTUxvteiaDTG7x5Y+5p4GgHINsCQiiigukNYGq+zz6A0CwAqjIIZwnCpKtldYkpklino
         kAxW5yG+LbYanEKaIczWYa0DTZJqnelRbUQujHjI+Jr4Iuhdav0NGSnW8O/YjtB9VSKr
         rMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MYyQzWIkXnUbU1T1yV7uK/sxU37R6l9GZVdK4va9skk=;
        b=vqKdSIY+jnVWfbAJh21kPze/2SRbZn1lLLfP1eYn84PEOjc5yEkf49DBAM3TYSaTHP
         S7JOgcgaDV5kr8zucqLHRnx49YsRFFPS1MwYENnphr5VWkBY2lzh5KLPJ7HbwTH4FqbF
         fBVfW6wkNS0FvV7T0DSepL5Y/2xq4a0Y5zTxgMy8N5x0NcFJlSGVH6r+rf+q+9/EaMbi
         8a1odn4BrGiPZ50vg4TLp/1LW3koOepEC7wdCEYU5qH3cZxVmr9r296XJT1mQFZpwgbs
         w5UHZJbO4qwiop1+ISW7nA00fZNA/clAdIpQy3EqqKEoLquD/S9Q3wY25t0ILGC4aYiG
         9sdA==
X-Gm-Message-State: AOAM532SjNokk89M1gtOgxMzRfPmOlc6yH4HGGZFWnGEUO8OsAco+wlA
        Ben21OW4PY0Grg234zhVG2DQahhbOSBOLw==
X-Google-Smtp-Source: ABdhPJycf0UwFL4j5UsDQkKQ5X/wvf0fu1bLu6kuYhyo6aK3RZdKkzJvN6bnL9bmKHDTC1Nvt3teRw==
X-Received: by 2002:a17:90a:9b0d:b0:1dc:e81d:6c18 with SMTP id f13-20020a17090a9b0d00b001dce81d6c18mr5134445pjp.72.1652964438708;
        Thu, 19 May 2022 05:47:18 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id t5-20020a17090ad14500b001d960eaed66sm3441296pjw.42.2022.05.19.05.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 05:47:18 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, akpm@linux-foundation.org, paulmck@kernel.org,
        mike.kravetz@oracle.com, osalvador@suse.de, david@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 0/2] make hugetlb_optimize_vmemmap compatible with memmap_on_memory
Date:   Thu, 19 May 2022 20:46:30 +0800
Message-Id: <20220519124632.92091-1-songmuchun@bytedance.com>
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
and is based on next-20220518.
The reason refers to the patch 2's commit log.

Muchun Song (2):
  mm: memory_hotplug: enumerate all supported section flags
  mm: memory_hotplug: introduce SECTION_CANNOT_OPTIMIZE_VMEMMAP

 Documentation/admin-guide/kernel-parameters.txt | 22 ++++-----
 Documentation/admin-guide/sysctl/vm.rst         |  5 +-
 include/linux/kconfig.h                         |  1 +
 include/linux/memory_hotplug.h                  |  9 ----
 include/linux/mmzone.h                          | 64 +++++++++++++++++++++----
 mm/hugetlb_vmemmap.c                            | 28 ++++++++---
 mm/memory_hotplug.c                             | 28 +++++------
 mm/sparse.c                                     |  8 ++++
 8 files changed, 112 insertions(+), 53 deletions(-)

-- 
2.11.0

