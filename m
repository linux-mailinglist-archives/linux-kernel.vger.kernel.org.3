Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6B24C63A9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 08:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbiB1HMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 02:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbiB1HMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 02:12:05 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803C8673F1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 23:11:27 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id q11so9915601pln.11
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 23:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RCfkkHTFTbBZWN4MRRKByw8vOmHdfbN0IqiaDPGeNOg=;
        b=dOgU94T9dxNIYWE9VHh0hdTmT7ifAkOngLUMR8I3WSTsC9oIxFotYVEIZwliIXZcFQ
         VZ/UqJK22p8kBOQ/eeqe7CyK+HfhgDua9J6jUBt5qUd1XPStDXacH7kCI/NEdpwiTVgM
         RL2YaMCNt8hCeMRUzhCGOvX1DYB+ccEVpULIh90TIZotoY8GISEBZGnQsWizLZ0Lh2j5
         hdCbnIkrBpRzhoNUk1w2CFGYkhm1lqNtWV0cDzDSK34PoZm+JbHkgrjPZRkBIX1Jf8Ml
         hA9jEH3wCC4ktKvZu9Qw+DFhJ1G1zrusDWH9mJv/C8R4iaEZuL+eDSj9sOsRc1S3m+0B
         qbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RCfkkHTFTbBZWN4MRRKByw8vOmHdfbN0IqiaDPGeNOg=;
        b=u6N/HxlSFoahDZhUc9LKzzrE5vYu3/BGJVrz2mByvYeJqCy2cQONdk5sbgB+JaDmZ1
         5aN1cL5NRFgSL135111JLjUYspwVRLWAcrS9vwK0FHT7f88uwViUvx4Yc6ZsdGG0qk6S
         I7p6+1aRWN52oUd/CBIr1ePJBC3O+2VWt19ZR+TVmyCiiSXiWtHgEoTveyUoPeNeMqnT
         tfk+YuqucLwweYeW+3HKMKWG2KvfDfU1U1bVpOIjSQnTAqHnpPRyCAGWBGUrHQDmGTaw
         9j3U7GngVydWXDTJNnUaEdpeCGJSnVVbdiYSDuSwXm0uF+vSOURShpFB7VfvjmcBldpr
         BhkQ==
X-Gm-Message-State: AOAM531yBa/Zd7dpVI/G8zNcWLPNtZ8SGyqbbZlXOoQZzTl2GD630zG0
        85onkWh6RsFJSmluc8g5eshyzg==
X-Google-Smtp-Source: ABdhPJwNiUWUQVyDl1VtKFWZYCiwhMGUytWFPX3AfhkBPGNgEoCG83MO5Y+CgnGGRhEqgdFkaMO6CQ==
X-Received: by 2002:a17:90b:3cc:b0:1bc:692b:ad8 with SMTP id go12-20020a17090b03cc00b001bc692b0ad8mr15139329pjb.90.1646032287064;
        Sun, 27 Feb 2022 23:11:27 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090a65c700b001b936b8abe0sm16240390pjs.7.2022.02.27.23.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 23:11:26 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 0/3] add hugetlb_free_vmemmap sysctl
Date:   Mon, 28 Feb 2022 15:10:19 +0800
Message-Id: <20220228071022.26143-1-songmuchun@bytedance.com>
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

This series amis to add hugetlb_free_vmemmap sysctl to enable the feature
of freeing vmemmap pages of HugeTLB pages.

Muchun Song (3):
  mm: hugetlb: disable freeing vmemmap pages when struct page crosses
    page boundaries
  sysctl: allow to set extra1 to SYSCTL_ONE
  mm: hugetlb: add hugetlb_free_vmemmap sysctl

 Documentation/admin-guide/sysctl/vm.rst | 13 +++++++++++++
 include/linux/hugetlb.h                 |  5 +++++
 include/linux/memory_hotplug.h          |  1 +
 kernel/sysctl.c                         | 13 ++++++++++++-
 mm/hugetlb_vmemmap.c                    | 24 +++++++++++++++++++++++-
 mm/hugetlb_vmemmap.h                    |  4 +++-
 mm/memory_hotplug.c                     |  2 +-
 7 files changed, 58 insertions(+), 4 deletions(-)

-- 
2.11.0

