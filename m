Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E0D58F402
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 23:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbiHJV4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 17:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiHJVz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 17:55:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04EEB80F6D
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 14:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660168555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=oF/qmSrdMlmPWxsKHR15ccpRopHUBKiPd2DHFQyuT+k=;
        b=Jqd5+cACRObgbHBiEgZNPdNWqGKezYWjB0KdhsXPZ2XH7JzxMtYBp0FXS7B5CBGgJt6Cms
        qcbFJaS2tQW+PqsYwJW9VCtC53DV1I1qzEudAuYjmJOimMWlHkbyjubyE1mybUoJ08Vbdo
        BbxWwPZrMjpcP5iiJUlKFmeA7xsJlGs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-567-CtpeTOq5Poa6xto48eWGZA-1; Wed, 10 Aug 2022 17:55:50 -0400
X-MC-Unique: CtpeTOq5Poa6xto48eWGZA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 66FFE80231E;
        Wed, 10 Aug 2022 21:55:49 +0000 (UTC)
Received: from [172.30.41.16] (unknown [10.22.18.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCB94492CA4;
        Wed, 10 Aug 2022 21:55:48 +0000 (UTC)
Subject: [PATCH] i915/gvt: Fix Comet Lake
From:   Alex Williamson <alex.williamson@redhat.com>
To:     zhenyuw@linux.intel.com, zhi.a.wang@intel.com
Cc:     intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com, linux-kernel@vger.kernel.org
Date:   Wed, 10 Aug 2022 15:55:48 -0600
Message-ID: <166016852965.780835.10366587502693016900.stgit@omen>
User-Agent: StGit/1.5.dev2+g9ce680a52bd9
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to the commit below the GAMT_CHKN_BIT_REG address was setup for
devices matching (D_KBL | D_CFL), where intel_gvt_get_device_type()
returns D_CFL for either Coffee Lake or Comet Lake.  Include the missed
platform.`

Link: https://lore.kernel.org/all/20220808142711.02d16782.alex.williamson@redhat.com
Fixes: e0f74ed4634d ("i915/gvt: Separate the MMIO tracking table from GVT-g")
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/gpu/drm/i915/intel_gvt_mmio_table.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/intel_gvt_mmio_table.c b/drivers/gpu/drm/i915/intel_gvt_mmio_table.c
index 157e166672d7..5595639d0033 100644
--- a/drivers/gpu/drm/i915/intel_gvt_mmio_table.c
+++ b/drivers/gpu/drm/i915/intel_gvt_mmio_table.c
@@ -1076,7 +1076,8 @@ static int iterate_skl_plus_mmio(struct intel_gvt_mmio_table_iter *iter)
 	MMIO_D(GEN8_HDC_CHICKEN1);
 	MMIO_D(GEN9_WM_CHICKEN3);
 
-	if (IS_KABYLAKE(dev_priv) || IS_COFFEELAKE(dev_priv))
+	if (IS_KABYLAKE(dev_priv) ||
+	    IS_COFFEELAKE(dev_priv) || IS_COMETLAKE(dev_priv))
 		MMIO_D(GAMT_CHKN_BIT_REG);
 	if (!IS_BROXTON(dev_priv))
 		MMIO_D(GEN9_CTX_PREEMPT_REG);


