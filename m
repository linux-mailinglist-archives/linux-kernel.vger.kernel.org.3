Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1904C9F6B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239124AbiCBIjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238447AbiCBIi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:38:57 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6D3574BA
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 00:38:14 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id z15so1282791pfe.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 00:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vuEh+AI7I41MHfBSDW5EnBJuRobxoamBcasQOIbr9mQ=;
        b=sfEqtVNUj5HIF8CigOLeWbLBoDWueQR0b20mz1nn9AqoSfduKJKT70rSGeiEqEzhBf
         yV1Cq1xlHEDEYGCnRq25O/4AaRGD9mZ0gtZ4DUciOazXXLhAranVxaL1KeGaflg+qegU
         dSXS2PGsDrKiJg/gHZklR4CF5f0SGkpS4IGSRievgS07uJDno19REjORMY7s2P06TST/
         z/QfCQFFr8i+63CsYezyN+v2CtW25vdY8hGpoWdwVj1HaO/pxE8wqOqPcf09CFSStKeD
         NfTV9Nx69m00GA0AJXa1M3znvHypHqbYlfliibNuheLupZ2QhxMzmm5NdNSjPSk/9Pam
         /m+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vuEh+AI7I41MHfBSDW5EnBJuRobxoamBcasQOIbr9mQ=;
        b=FdZL9yTj6itNNi0rogVDA1y/0/Rh0pV5EQ3dJ6CkxRCt4Fodx5PtqymCEHqkCzRrU0
         8Pm4ttCTfqiVcaP1aAqFqAOR3nwltoQ0rJl92cPzg0TkTbz2Hi/NiPWKWZZ35OlHxe8N
         UygeINFTz8K4xFXkVqOw0UKwWsqrUfm6w5daQTN8o0+HkBWqoGAnXmZyaKUPd/+PNWih
         cZiD27oWar0hjtnOg8KeQmKBpuzJazFkJkXmAybiLmQG+yU2BXLX4ScxyibgyopBG0V3
         SFKHMgu1OsG1z2LoTVpA2EO1A2OjswlKv7NnDj26hP3AlAMAeseBaN+BbN65O4gXfGjh
         MY7Q==
X-Gm-Message-State: AOAM533CY3T6H1I1hw7rsYJViGWjO+KvdtVCCpBNuayap3MkB7omeW0P
        pbDjjCofGDOoX5ZZxgGEyJckWw==
X-Google-Smtp-Source: ABdhPJyU/gzUwFPTrqmH05EFsV7a1BMv2sPR5Joj21ZAEsQWWG5rtcN1Y9u5yF57S/oKVnjRhx/VQw==
X-Received: by 2002:a05:6a00:2cd:b0:4e1:1989:5b7f with SMTP id b13-20020a056a0002cd00b004e119895b7fmr31678105pft.3.1646210293519;
        Wed, 02 Mar 2022 00:38:13 -0800 (PST)
Received: from FVFYT0MHHV2J.bytedance.net ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id 17-20020a056a00071100b004f0f941d1e8sm18705141pfl.24.2022.03.02.00.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 00:38:13 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 0/3] add hugetlb_free_vmemmap sysctl
Date:   Wed,  2 Mar 2022 16:37:55 +0800
Message-Id: <20220302083758.32528-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series amis to add hugetlb_free_vmemmap sysctl to enable the feature
of freeing vmemmap pages of HugeTLB pages.

v2:
  - Fix compilation when !CONFIG_MHP_MEMMAP_ON_MEMORY reported by kernel
    test robot <lkp@intel.com>.
  - Move sysctl code from kernel/sysctl.c to mm/hugetlb_vmemmap.c.

Muchun Song (3):
  mm: hugetlb: disable freeing vmemmap pages when struct page crosses
    page boundaries
  sysctl: allow to set extra1 to SYSCTL_ONE
  mm: hugetlb: add hugetlb_free_vmemmap sysctl

 Documentation/admin-guide/sysctl/vm.rst | 13 ++++++++++
 include/linux/memory_hotplug.h          |  9 +++++++
 kernel/sysctl.c                         |  2 +-
 mm/hugetlb_vmemmap.c                    | 43 ++++++++++++++++++++++++++++++++-
 mm/hugetlb_vmemmap.h                    |  4 ++-
 mm/memory_hotplug.c                     |  5 ++++
 6 files changed, 73 insertions(+), 3 deletions(-)

-- 
2.11.0

