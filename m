Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCC0558EF3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 05:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiFXDLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 23:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbiFXDLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 23:11:20 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15E764780;
        Thu, 23 Jun 2022 20:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656040232; x=1687576232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qW/cR2eXQHqeZ6k4AqktxUZ09Y7huKZmVwx1/JlcCS4=;
  b=nOWPApKqmZGH2k/WSzbZ9aMMZiajknc+sbuq009h0Eph09vIGmCLfheG
   17HNk0TZb8B4fQMhGrzfi5BhnZNb8/JOBLtLOKA3F9s9e6gEzav4igefw
   IoVXBQOq4vYPbVmWcyWXgKmgmVxd1RCFpPpUwu93NIAPbvU98JFqjHYQn
   no1+dncZbgAMNF3f+ehu4P/AH+j6HQrOwhGLi3qD9wDg9DxjmVJBVZTxi
   F8PQpZaX+p2sMk2DOClWYMqitHkPnzEIyEBDftV3iCzfCvk3ogfwFGtI6
   FN1hvekHbhMWD+/iC5XKitvA9zwDGfrShWi0VPpRqT97uIanMD/jh2GUs
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="261335672"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="261335672"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 20:10:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="563700591"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by orsmga006.jf.intel.com with ESMTP; 23 Jun 2022 20:10:30 -0700
From:   niravkumar.l.rabara@intel.com
To:     dinguyen@kernel.org
Cc:     devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, niravkumar.l.rabara@intel.com,
        robh+dt@kernel.org
Subject: Re: [PATCH] arm64: dts: altera: socfpga_stratix10: move clocks out of soc node
Date:   Fri, 24 Jun 2022 11:10:17 +0800
Message-Id: <20220624031017.3247656-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <b111c356-ee6a-bd68-d08f-fbe2a67d2f55@kernel.org>
References: <b111c356-ee6a-bd68-d08f-fbe2a67d2f55@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Take that back. Your changes are fine, but you need to update the board 
>files as well. i.e socfpga_stratix10_socdk.dts
>
>
>--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
>+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
>@@ -52,12 +52,6 @@ ref_033v: regulator-v-ref {
>         };
>
>         soc {
>               clocks {
>                       osc1 {
>                               clock-frequency = <25000000>;
>                       };
>               };
>
>                eccmgr {
>                         sdmmca-ecc@ff8c8c00 {
>                                 compatible = "altr,socfpga-s10-sdmmc-ecc",
>@@ -113,6 +107,10 @@ &mmc {
>         bus-width = <4>;
>  };
>
>+&osc1 {
>+       clock-frequency = <25000000>;
>+};
>+

Sorry I missed this change, will update in v2 patch.

Thanks,
Nirav

