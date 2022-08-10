Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8B458F4F7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 01:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbiHJXlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 19:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbiHJXlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 19:41:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4FB01151
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 16:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660174872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ESKhhHvhyTk1a8IG7YRAI0kEcN37WFQWTM/sPGqUCUU=;
        b=BqmbUw45NiGj+WkltP0eoIs5g2vObwDBuqADJzrzcG4xaBg8WXibD2GW10t/kpNxEop1uD
        KBrCh5MkVub7EDjnZZ8nHq9xnU6fQT1LSh6BVZq37qxzFDqQX+7SseA0RO0QsIuW/Hnnlj
        JElVmk7/jCJPvzC7jkH616l69qVJcDo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-190-t7_zJCnoO76MlruHlSPMxw-1; Wed, 10 Aug 2022 19:41:06 -0400
X-MC-Unique: t7_zJCnoO76MlruHlSPMxw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C61D03C0F376;
        Wed, 10 Aug 2022 23:41:05 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.22.8.107])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 963D52166B26;
        Wed, 10 Aug 2022 23:41:01 +0000 (UTC)
From:   Nico Pache <npache@redhat.com>
To:     kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, davidgow@google.com
Cc:     skhan@linuxfoundation.org, dlatypov@google.com,
        brendan.higgins@linux.dev, alcioa@amazon.com, lexnv@amazon.com,
        andraprs@amazon.com, YehezkelShB@gmail.com,
        mika.westerberg@linux.intel.com, michael.jamet@intel.com,
        andreas.noever@gmail.com
Subject: [PATCH] kunit: fix Kconfig for build-in tests USB4 and Nitro Enclaves
Date:   Wed, 10 Aug 2022 19:40:56 -0400
Message-Id: <20220810234056.2494993-1-npache@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the USB4 and Nitro Enclaves KUNIT tests are now able to be compiled
if KUNIT is compiled as a module. This leads to issues if KUNIT is being
packaged separately from the core kernel and when KUNIT is run baremetal
without the required driver compiled into the kernel.

Fixes: 635dcd16844b ("thunderbolt: test: Use kunit_test_suite() macro")
Fixes: fe5be808fa6c ("nitro_enclaves: test: Use kunit_test_suite() macro")
Signed-off-by: Nico Pache <npache@redhat.com>
---
 drivers/thunderbolt/Kconfig         | 3 +--
 drivers/virt/nitro_enclaves/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/Kconfig b/drivers/thunderbolt/Kconfig
index e76a6c173637..f12d0a3ee3e2 100644
--- a/drivers/thunderbolt/Kconfig
+++ b/drivers/thunderbolt/Kconfig
@@ -29,8 +29,7 @@ config USB4_DEBUGFS_WRITE
 
 config USB4_KUNIT_TEST
 	bool "KUnit tests" if !KUNIT_ALL_TESTS
-	depends on (USB4=m || KUNIT=y)
-	depends on KUNIT
+	depends on USB4 && KUNIT=y
 	default KUNIT_ALL_TESTS
 
 config USB4_DMA_TEST
diff --git a/drivers/virt/nitro_enclaves/Kconfig b/drivers/virt/nitro_enclaves/Kconfig
index ce91add81401..dc4d25c26256 100644
--- a/drivers/virt/nitro_enclaves/Kconfig
+++ b/drivers/virt/nitro_enclaves/Kconfig
@@ -17,7 +17,7 @@ config NITRO_ENCLAVES
 
 config NITRO_ENCLAVES_MISC_DEV_TEST
 	bool "Tests for the misc device functionality of the Nitro Enclaves" if !KUNIT_ALL_TESTS
-	depends on NITRO_ENCLAVES && KUNIT
+	depends on NITRO_ENCLAVES && KUNIT=y
 	default KUNIT_ALL_TESTS
 	help
 	  Enable KUnit tests for the misc device functionality of the Nitro
-- 
2.36.1

