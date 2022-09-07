Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E675B0F7F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 23:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiIGVwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 17:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiIGVv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 17:51:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B932A570D
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 14:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662587515; x=1694123515;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H3KUXVJQNNP110a+603fcMPCmYPYLmydZeLg2k8GqE4=;
  b=fMV2qKU5KFEJ6vQ/lJnY3UrtZ4mKwj1qjnSYZfMyQ+T2tmVwFFituR8W
   l0T/UXNCOC23RGkATT5AFOmnth+uan57hwZUr6fmCOooqmqOuZb7/dy52
   ATNSDVqP1bd2g4mMGhdoZjZOTGn8PJvfBumTiCv/sGiSfBWVzfrCvIOWu
   INxIvxM1HUCUwRdWYVrCtzmSsUuR3n+b6Al7z/NhK2aN14Tad5YtYqePB
   sfhyGvgMgd4SjeMDH/tL0p6kx00RbtJy4bjSIA1OI0BPaQjw8Hwj7MzAw
   KrKyPsS2Wmray58bpSeksSpbBkWZsiyvuTKROcx3c8GwcHQDEznldM6JZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="295740272"
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="295740272"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 14:51:43 -0700
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="790207852"
Received: from twinkler-lnx.jer.intel.com ([10.12.87.143])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 14:51:39 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Subject: [PATCH v9 03/16] mei: add slow_firmware flag to the mei auxiliary device
Date:   Thu,  8 Sep 2022 00:51:00 +0300
Message-Id: <20220907215113.1596567-4-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220907215113.1596567-1-tomas.winkler@intel.com>
References: <20220907215113.1596567-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add slow_firmware flag to the mei auxiliary device info
to inform the mei driver about slow underlying firmware.
Such firmware will require to use larger operation timeouts.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
---
V9: Rebase

 include/linux/mei_aux.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/mei_aux.h b/include/linux/mei_aux.h
index a0cb587006d5..4894d8bf4159 100644
--- a/include/linux/mei_aux.h
+++ b/include/linux/mei_aux.h
@@ -12,11 +12,14 @@
  * @aux_dev: - auxiliary device object
  * @irq: interrupt driving the mei auxiliary device
  * @bar: mmio resource bar reserved to mei auxiliary device
+ * @slow_firmware: The device has slow underlying firmware.
+ *                 Such firmware will require to use larger operation timeouts.
  */
 struct mei_aux_device {
 	struct auxiliary_device aux_dev;
 	int irq;
 	struct resource bar;
+	bool slow_firmware;
 };
 
 #define auxiliary_dev_to_mei_aux_dev(auxiliary_dev) \
-- 
2.37.2

