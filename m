Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E45851831B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 13:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbiECLQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 07:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbiECLQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 07:16:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263A135A9D;
        Tue,  3 May 2022 04:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651576359; x=1683112359;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h3g8eorJz4802t5ftV/zPjq8HQXG/+FZUXPCQKtK8mQ=;
  b=SJ42f9krUSQgeRwqdVqIm/fThchC5gjV/2ZAGEPYhYSFRl8LZMaXWO/6
   neiDq4eDyXV33FgvizKrzFTVEv8qLoqcjEQKXmXF3WeWjn7wo8B+W4tNq
   0dSjwCPyGAlrzjlnibRRrzeo6KiYNrq4R3aRjDm7WStkDPvAcHTfUQGIt
   nqsTqQ3o+SkmeoN9sWNWGYtVIKykOJ9eGg/ikN450PtzJhor1SHaUuz+w
   rtoF+inYlLXxaCe0rA9oL+slh28Q1/kFcylhAvBAbXTsCSs9Xpl9lG6v4
   y5zstw/ftp/n8yrX9pIqTnbs9ITTFhLiPPqXeqhxTmc5VX4rXoUrW/6mN
   w==;
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="162129457"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 May 2022 04:12:39 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 3 May 2022 04:12:33 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 3 May 2022 04:12:28 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] media: atmel: atmel-sama7g5-isc: fix warning in configs without OF
Date:   Tue, 3 May 2022 14:12:16 +0300
Message-ID: <20220503111216.54352-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All warnings (new ones prefixed by >>):

>> drivers/media/platform/atmel/atmel-sama7g5-isc.c:610:34: warning: unused variable 'microchip_xisc_of_match' [-Wunused-const-variable]
   static const struct of_device_id microchip_xisc_of_match[] = {
                                    ^
   13 warnings generated.

vim +/microchip_xisc_of_match +610 drivers/media/platform/atmel/atmel-sama7g5-isc.c

   609
 > 610  static const struct of_device_id microchip_xisc_of_match[] = {
   611          { .compatible = "microchip,sama7g5-isc" },
   612          { }
   613  };
   614  MODULE_DEVICE_TABLE(of, microchip_xisc_of_match);
   615

Fixed warning by guarding the atmel_isc_of_match by CONFIG_OF.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: c9aa973884a1 ("media: atmel: atmel-isc: add microchip-xisc driver")
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/media/platform/atmel/atmel-sama7g5-isc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/atmel/atmel-sama7g5-isc.c b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
index 638af8da2694..0cbe84d05eb1 100644
--- a/drivers/media/platform/atmel/atmel-sama7g5-isc.c
+++ b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
@@ -621,11 +621,13 @@ static const struct dev_pm_ops microchip_xisc_dev_pm_ops = {
 	SET_RUNTIME_PM_OPS(xisc_runtime_suspend, xisc_runtime_resume, NULL)
 };
 
+#if IS_ENABLED(CONFIG_OF)
 static const struct of_device_id microchip_xisc_of_match[] = {
 	{ .compatible = "microchip,sama7g5-isc" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, microchip_xisc_of_match);
+#endif
 
 static struct platform_driver microchip_xisc_driver = {
 	.probe	= microchip_xisc_probe,
-- 
2.25.1

