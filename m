Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCBC55169A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241030AbiFTLH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241234AbiFTLHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:07:23 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAE71572B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:07:17 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id w19-20020a17090a8a1300b001ec79064d8dso7118181pjn.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0sGj0xCuJeJNCCPLHCLqdmxME5IfW++lXhxnglYboi8=;
        b=hoWVGpODBe/YKi9SbmUMRWfZQJopZdiyFsLI2U8DvbSKvA2tL/nSGGZQMpvN59k09M
         SkSvRyeC6dchTzsqKc2s19iHWCsYP9MBUHvEX8zNgzeOclL1hodoeZDWcSNTphc516dN
         dtirYjK+EQTfLbtOVfqp31nsfVl/CwOiek5szJVpv0rO+tyOEi7dPxGfUm4gT8cLiPX0
         VpaTfe9jDF7sDKI+gzNgojc91WHIAfMHGiJ27STOPLWAFd703qyYYOQBtMfDdpqWCCq9
         Qel7ZDV7nkgbAHf/9ME6xi65rdgEJ/p+gg77qHUru8c5pOWpZTnm1lBApsgJk5P/f9GH
         ZLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0sGj0xCuJeJNCCPLHCLqdmxME5IfW++lXhxnglYboi8=;
        b=u2fMkMwY7E2jZDgmMgqconMbUm2j9At16s68wi8fBEfytWLTRaSLa6Ng82pxzdAPMG
         YjefOGr0Hl+M5uh+kzq1X9pQhEo9W3zgeNWnM6N/26Od30tFXqc7DMaJLURAGOhLWyNm
         p0TmuL00Pmi5KvDI+sku0Xxr/2YGJ34Gcd4AMBzr7OvmAmKctiw+B7H2sZHlg8Fv4N0P
         +ODLL4ELWYqhUzLGNEBV5Kl/4GpScsc2J4cOqgolm31S/7gwTgKtQnoG8jo+QMBFTgck
         WXYPyYXcVNIo2/dx+OaQoxJXvbsPEf9tGnNOkVPZf4YEipfSXTYN3Q+h21v6RIdmWSzk
         aWVg==
X-Gm-Message-State: AJIora/fv4qK1c6v7NpgU6filBjx4eLLTqhMMduxAJ2fhjLIzj24o6hT
        Fag7v61nb7cqMg150WZB3HVX6w==
X-Google-Smtp-Source: AGRyM1suLGp4qjo9VDQHNPePbkZuz6/HSVjWExA6/4od6/EiLpwMBCaC4xzkmVvMSj7Q0DQ26y2tjA==
X-Received: by 2002:a17:902:ee55:b0:16a:5b2:a2b0 with SMTP id 21-20020a170902ee5500b0016a05b2a2b0mr16073492plo.133.1655723236602;
        Mon, 20 Jun 2022 04:07:16 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id iw10-20020a170903044a00b0016a214e4afasm2385962plb.125.2022.06.20.04.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 04:07:16 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, corbet@lwn.net, david@redhat.com,
        mike.kravetz@oracle.com, osalvador@suse.de, paulmck@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 0/2] make hugetlb_optimize_vmemmap compatible with memmap_on_memory
Date:   Mon, 20 Jun 2022 19:06:14 +0800
Message-Id: <20220620110616.12056-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series makes hugetlb_optimize_vmemmap compatible with memmap_on_memory
and is based on mm-stable.  The reason refers to the patch 2's commit log.

v5:
 - Replace enum to defines per David.
 - Walk vmemmap page tables to avoid false-positive.

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

 Documentation/admin-guide/kernel-parameters.txt | 22 ++++-----
 Documentation/admin-guide/sysctl/vm.rst         |  5 +-
 include/linux/memory_hotplug.h                  |  9 ----
 include/linux/mmzone.h                          | 41 +++++++++++----
 include/linux/page-flags.h                      | 11 +++++
 mm/hugetlb_vmemmap.c                            | 66 ++++++++++++++++++++++---
 mm/memory_hotplug.c                             | 33 +++++++------
 mm/sparse.c                                     |  2 +-
 8 files changed, 132 insertions(+), 57 deletions(-)

-- 
2.11.0

