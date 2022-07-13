Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFB9572C92
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbiGME3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbiGME25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:28:57 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BD22CDE7;
        Tue, 12 Jul 2022 21:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657686531; x=1689222531;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=CUOQ3MTsrIQPtqhO8Ly+54TTEamCTAfU40O4qkARrq0=;
  b=cw2PZBY672voIlwjzq8qxVOZa4Eh/4DQRpgRO/DM+seK0MonfuvX0es+
   nypjMtSBO5v1c3Rf4BA4wfD7esdt0Jj2u6j98F30Ngl+spEM1tF7rw2RF
   LxxmmJCCdLT6G32i3boRdBXKMn/XbUvBCazf6KzIVkF5BaNLdsqzBQ8Xi
   hx3CWc/RJ8BUGdkV2S16VGAUIJPutSgA7CQYShyvbWhVR96Ei6lz8JCWV
   otNtgZ2OPzDJLGfG+l6mpZ54ZRu1ymOT+QNrb4sxpUkZv7w/JFMKegW+r
   oCmyAOzv11jg+lnH+JfzfoSbAUQpJJvVbx9WxYNOCCVs1aUb0zyhDTkUb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="264894382"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="264894382"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 21:28:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="570463222"
Received: from srikandan-ilbpg12.png.intel.com ([10.88.229.69])
  by orsmga006.jf.intel.com with ESMTP; 12 Jul 2022 21:28:43 -0700
From:   nandhini.srikandan@intel.com
To:     fancer.lancer@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, mgross@linux.intel.com,
        kris.pan@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        mahesh.r.vaidya@intel.com, nandhini.srikandan@intel.com,
        rashmi.a@intel.com
Subject: [PATCH v6 1/4] spi: dw: Fix IP-core versions macro
Date:   Wed, 13 Jul 2022 12:22:20 +0800
Message-Id: <20220713042223.1458-2-nandhini.srikandan@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220713042223.1458-1-nandhini.srikandan@intel.com>
References: <20220713042223.1458-1-nandhini.srikandan@intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nandhini Srikandan <nandhini.srikandan@intel.com>

Add the missing underscore in IP version macro to avoid compilation issue.
The macro is used for IP version comparison in the current patchset.

Fixes: 2cc8d9227bbb ("spi: dw: Introduce Synopsys IP-core versions interface")
Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>
---
 drivers/spi/spi-dw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index d5ee5130601e..79d853f6d192 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -23,7 +23,7 @@
 	((_dws)->ip == DW_ ## _ip ## _ID)
 
 #define __dw_spi_ver_cmp(_dws, _ip, _ver, _op) \
-	(dw_spi_ip_is(_dws, _ip) && (_dws)->ver _op DW_ ## _ip ## _ver)
+	(dw_spi_ip_is(_dws, _ip) && (_dws)->ver _op DW_ ## _ip ## _ ## _ver)
 
 #define dw_spi_ver_is(_dws, _ip, _ver) __dw_spi_ver_cmp(_dws, _ip, _ver, ==)
 
-- 
2.17.1

