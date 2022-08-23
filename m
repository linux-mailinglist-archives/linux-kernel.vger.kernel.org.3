Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D3459EBE5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbiHWTLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbiHWTKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:10:43 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7CE69F67
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 10:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661276918; x=1692812918;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3DXsFiehmOWjIK0HPPx03C/izDXYsGR9JU9dpMMy13M=;
  b=m+/MX7+K/Ch1/xI9qdlFaYQho6syurCb2PqEB0g69ci/MQ+yNLM1Rd36
   640ejGmK+Rb6rOhTe7YLrrFfAIm6zZzBd96FOoTMoseJMX2hpy2jpJpJK
   yr16aSGiLh7H0klZnCuvXe/zcO1TEs05uajVQISSdr9fq1cu7ewF5qX2h
   cF+8jMeyBczMLOd7mEPLNIdQseNn2kR+sI3r0dq7O/yFeTg93lP39NMO4
   fIqSyA4sET1CUCVDag+pdqtm2X4xNRyR/3Hu9r37wkRiab8l/lybhMftZ
   vnFVNTIF6ATXlZLij6KrD7WXEsndE3rzcbVZRn0PH0R+Q9SmRDI9rzLdg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="291317767"
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="291317767"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 10:48:36 -0700
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="612493072"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 10:48:35 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH] x86/cpu: Add new Raptor Lake CPU model number
Date:   Tue, 23 Aug 2022 10:48:19 -0700
Message-Id: <20220823174819.223941-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note1: Model 0xB7 already claimed the "no suffix" #define for a regular
client part, so add (yet another) suffix "S" to distinguish this new
part from the earlier one.

Note2: the RAPTORLAKE* and ALDERLAKE* processors are very similar from a
software enabling point of view.  There are no known features that have
model-specific enabling and also differ between the two.  In other words,
every single place that list *one* or more RAPTORLAKE* or ALDERLAKE*
processors should list all of them.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/intel-family.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index def6ca121111..aeb38023a703 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -27,6 +27,7 @@
  *		_X	- regular server parts
  *		_D	- micro server parts
  *		_N,_P	- other mobile parts
+ *		_S	- other client parts
  *
  *		Historical OPTDIFFs:
  *
@@ -112,6 +113,7 @@
 
 #define INTEL_FAM6_RAPTORLAKE		0xB7
 #define INTEL_FAM6_RAPTORLAKE_P		0xBA
+#define INTEL_FAM6_RAPTORLAKE_S		0xBF
 
 /* "Small Core" Processors (Atom) */
 
-- 
2.35.3

