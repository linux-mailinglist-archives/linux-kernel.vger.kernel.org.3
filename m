Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC89459C99E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 22:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbiHVUJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 16:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiHVUJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 16:09:04 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505BC50714
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661198943; x=1692734943;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FZlZNnLntdAc6dq6GYaLZUJ2/390X4kLPdz2Q4ZKkfg=;
  b=XB86WlIBWGHuWgbjpj7Bg0KiJ/uRsLvxVfUNxqabNq5oe2O40k4Eg5VS
   a1HOAL31VNqrm0LRP3bZibDiCFtk6io7jZn708C88wUF5s5sYm1YOAkPj
   CtjvQeVv6QFMDALMACeb5vXwd4YpTsUw2qGl9tdv4aM8TkhfWFp8eDESQ
   zjOvALXaWpCM4et/Fp0a2ngCgke8V0LNFwlHtOqjjyjhM6HGLLD+6R1Yx
   lpS46NMRtYYt1C6M0ZDEwJ8q8FH1ZxiJxbv7hJloHjn+rD/8sRW9u6L0f
   cytLtMz+Q7P/Dd7Ygz/U0NzjhPSgsk61FNkK/yKIbOZj6ppEP956hrsK8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="276539351"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="276539351"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 13:09:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="698414214"
Received: from otc-wp-03.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.79])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Aug 2022 13:09:02 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>
Cc:     Raj Ashok <ashok.raj@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "Borislav Petkov" <bp@alien8.de>, "Ingo Molnar" <mingo@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 0/2] Use the correct page tables for SVA under PTI
Date:   Mon, 22 Aug 2022 13:12:11 -0700
Message-Id: <20220822201213.352289-1-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.0 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shared virtual addressing allows DMA to user virtual address, But the
x86 IOMMU drivers are using the kernel copy of the process page tables
when PTI is enabled. This patchset tightens the security intended by
PTI by performing SVA binding with the appropriate process PGDs.

I have tested on Intel platform only, would appreciate itif someone
could help with testing SVA-KPTI on an AMD system.

Jacob Pan (2):
  x86: mm: Allow PTI helpers to be used outside x86/mm
  iommu: Use the user PGD for SVA if PTI is enabled

 arch/x86/include/asm/pgtable.h | 5 +++++
 drivers/iommu/amd/iommu_v2.c   | 4 +++-
 drivers/iommu/intel/svm.c      | 5 ++++-
 3 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.25.1

