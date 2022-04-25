Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A370750DA80
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241400AbiDYHxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241008AbiDYHw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:52:26 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6407FD0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650872963; x=1682408963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WIOdvRXs3F6Uqx0OZDzS9V+TAi03ig5lUw0omN1iKg0=;
  b=RuR3iCNQWfEjT0iPt25y/VZSQ7QVBPMOaWiFtUcpyvl5FuUy2M6H+9Em
   MyRoQM0lsA1nBy+YYyIK2Rk0wzNELQAzjK+y5XIb0eE+rlt9mI1LPg5mD
   3Eo8TanhS7rf5vM5VkB3w4OuHrt5/sFfs+Rr6Vgl3icY4ATfpkPR8UwtE
   VO0h/r9xEFE6y/XXylat4s/Iw7xn26CG0y1XdIxXHe/KiCMC8Xh1yRbBT
   MQ7KIe8GIy4c2sBkg/MA0E/mgsK3vSKZLn1qAsIseYmvzMUzEaSbNbEKh
   ERfifVVhTLclholL6V+/mDgdmaHo9RxsEgePK6/sBONhdpkdTc850EQCA
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="264973665"
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="264973665"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 00:49:23 -0700
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="557599890"
Received: from sannilnx.jer.intel.com ([10.12.231.73])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 00:49:20 -0700
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Subject: [PATCH v2 03/14] drm/i915/gsc: add slow_fw flag to the mei auxiliary device
Date:   Mon, 25 Apr 2022 10:48:50 +0300
Message-Id: <20220425074901.3991274-4-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220425074901.3991274-1-alexander.usyskin@intel.com>
References: <20220425074901.3991274-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add slow_fw flag to the mei auxiliary device info
to inform the mei driver about slow underlying firmware.
Such firmware will require to use larger operation timeouts.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
---
 include/linux/mei_aux.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mei_aux.h b/include/linux/mei_aux.h
index 587f25128848..a29f4064b9c0 100644
--- a/include/linux/mei_aux.h
+++ b/include/linux/mei_aux.h
@@ -11,6 +11,7 @@ struct mei_aux_device {
 	struct auxiliary_device aux_dev;
 	int irq;
 	struct resource bar;
+	bool slow_fw;
 };
 
 #define auxiliary_dev_to_mei_aux_dev(auxiliary_dev) \
-- 
2.32.0

