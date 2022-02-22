Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4068E4BF692
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 11:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbiBVKuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 05:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiBVKtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 05:49:53 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F1A155C0B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 02:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645526967; x=1677062967;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=563hB/rXHNGZzJHbLZ19JTAegWPlZpDTmnNbjcAniLA=;
  b=hIyySVOEkHfTnDBLKDtqvGpQGPOLJO9RnQyYPLo2P1o2mu6FuFTPnjz3
   V7SwhPtNG/5zxYHS504UvIUelUcV26Egn1J7vDSNDqbX6yI2chiYVRwGf
   /cvhUzZuntnyrbNyeuBGyUkbf1EwkyFUDZmmRKFPPqCsMPcZexvAUOqNw
   EGqMM4RvMbs3AbI+DZ0mbhMlIFUIfRi3sDUjx4ATTNXL50Hd/+UjB/9eK
   Kc1ybulfDzctN2PMpsMzXD8HJPpHLf+YZ302UqJPMIIwK9U5uS/aJim6q
   kGOMbmpqtolDOI0IwjQ/n0oDtNpuuVyaEcl5RyLQsY8jSf9OOZDbhlzsh
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="249248511"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="249248511"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 02:49:27 -0800
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="706569575"
Received: from sannilnx.jer.intel.com ([10.12.231.79])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 02:49:24 -0800
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
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] drm/i915/gsc: add slow_fw flag to the mei auxiliary device
Date:   Tue, 22 Feb 2022 12:48:49 +0200
Message-Id: <20220222104854.3188643-3-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220222104854.3188643-1-alexander.usyskin@intel.com>
References: <20220222104854.3188643-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

