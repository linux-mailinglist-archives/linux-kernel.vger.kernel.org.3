Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928DD57F402
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 10:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiGXIZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 04:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiGXIZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 04:25:05 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16B31A399
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 01:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658651103; x=1690187103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zi+3kAHT5OVOEpn54U5DuoHE41mjFvXLjo/wuWmQPjA=;
  b=CDahshmi4buGpXQ3LC80Qdem69xSjQIkppoTGV0W+jM1p6vOOtxTQ0hp
   IVlhq34HhamSSTiV451NN+tnqdh9n5+v7uMt19khbq6CLTrWe1qVTJJML
   AF6g7uud+tPWS/SjYtF+C/oB1SO+8UXD9Kzhi1NuwSaATZPn+0bfxSSCV
   bUErkNJWldYDh5/5mmTQiifB8O49gHXcpaQbaLGaNfLOVljWx3J2Qp6cf
   czeky6l6MqgPRa2erjVxRTmmbzWbXBVtPOY8AXtOdHpA2mcOMw9yED/0a
   JJBYFEu3Ym0mluHY3PYrrxGemJh8Huj0vryRFrkGPdBzPUV0ClYW8IeBh
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="313267949"
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="313267949"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 01:24:56 -0700
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="657756213"
Received: from twinkler-lnx.jer.intel.com ([10.12.87.143])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 01:24:52 -0700
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
Subject: [PATCH v6 02/14] mei: add slow_fw flag to the mei auxiliary device
Date:   Sun, 24 Jul 2022 11:24:16 +0300
Message-Id: <20220724082428.218628-3-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220724082428.218628-1-tomas.winkler@intel.com>
References: <20220724082428.218628-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

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
2.35.3

