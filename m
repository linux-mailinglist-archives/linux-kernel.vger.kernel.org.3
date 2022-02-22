Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCAE4BFF9A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbiBVREG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 12:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbiBVREF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:04:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911E3522FA;
        Tue, 22 Feb 2022 09:03:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B97461255;
        Tue, 22 Feb 2022 17:03:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19AEC340E8;
        Tue, 22 Feb 2022 17:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645549418;
        bh=J2CURahxnVv8b6eRRfjW/3jnd2IJWphDlftdm3zmD0U=;
        h=From:To:Cc:Subject:Date:From;
        b=Nh8sJNEB0hscdsctvswYJN1g1szpTYkym4RdoK060CK+YVjzLAsurKkPxf4Dm6st2
         hLhwjMCgn+RNw+DiCEMq6HjvYNlvmL1Inr4I0pwgZDjLOt+Uxo3ZOBpJvbw4BEZq78
         v8D6ue4QvVaYSojDKbL5tbD87q7d9vT/VvB6ZPjnAPFcB89mP2Io9VPYIOWkTOcYot
         k6cMGkTuVms43N76emcqEhJDbN1XxRwic+EtzUvwKuFfxvpJDES17XX2nW3YCDl+/a
         1iCJ04Aa3IXymFx+mazzHaBvQhVE/ZvsWtgIbVmXPLZA8Cvha8Yg6iQHinfOgGw5Bs
         Xgqi2d2YgH27g==
From:   broonie@kernel.org
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Matt Roper <matthew.d.roper@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: linux-next: manual merge of the drm tree with the drm-intel-fixes tree
Date:   Tue, 22 Feb 2022 17:03:33 +0000
Message-Id: <20220222170333.694165-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/i915/display/intel_snps_phy.c

between commit:

  28adef861233c ("drm/i915/dg2: Print PHY name properly on calibration error")

from the drm-intel-fixes tree and commit:

  c5274e86da5fe ("drm/i915/snps: convert to drm device based logging")

from the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/gpu/drm/i915/display/intel_snps_phy.c
index 92ff654f54f56,8573a458811a0..0000000000000
--- a/drivers/gpu/drm/i915/display/intel_snps_phy.c
+++ b/drivers/gpu/drm/i915/display/intel_snps_phy.c
@@@ -28,13 -29,13 +29,13 @@@ void intel_snps_phy_wait_for_calibratio
  	enum phy phy;
  
  	for_each_phy_masked(phy, ~0) {
- 		if (!intel_phy_is_snps(dev_priv, phy))
+ 		if (!intel_phy_is_snps(i915, phy))
  			continue;
  
- 		if (intel_de_wait_for_clear(dev_priv, ICL_PHY_MISC(phy),
+ 		if (intel_de_wait_for_clear(i915, ICL_PHY_MISC(phy),
  					    DG2_PHY_DP_TX_ACK_MASK, 25))
- 			DRM_ERROR("SNPS PHY %c failed to calibrate after 25ms.\n",
- 				  phy_name(phy));
+ 			drm_err(&i915->drm, "SNPS PHY %c failed to calibrate after 25ms.\n",
 -				phy);
++				phy_name(phy));
  	}
  }
  
