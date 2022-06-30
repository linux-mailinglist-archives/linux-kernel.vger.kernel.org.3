Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F525618C3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 13:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbiF3LKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 07:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiF3LKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:10:15 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7D9457B4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 04:10:13 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d17so21109712wrc.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 04:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jamieiles.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rCzYJxLU9wcyLu+uhOEd7PVf6eOKzZ5fBAU0Uureukc=;
        b=G1GMK8L3SefrT8qZ1K3pfa3DKIc1iPfzXRDO7+lZPmgVaJwPIFNt3kPsk9cdcR3MRC
         l+A0xkoKCIDx1QXnzWe3TnVnTXGDwIQyVKjsCZiuYGipnf+k/4f7shIhB7GHTjA42DrH
         tZwCpdG5ntb4Z/oqtxwZQtuUAVI0IyHICTb2t+rNaXwv082lhGIm9c5watfNZFZyT222
         JsokI2s+Hx89P+uP44RV/W97d9LPVsOESOMJJB0Crx9OGRJ4x51X5kCe0gwhgGvCqUhz
         HIzsN1Q+idBBTdergimDvEpsWIm6EPgvczDpLzT6d1K9BZPOT1y8h3co+CjBzjjY5ddF
         gBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rCzYJxLU9wcyLu+uhOEd7PVf6eOKzZ5fBAU0Uureukc=;
        b=ZoPAm9wIHcaUhSloopM3dyUpIhXRq36jteAblolWFJbNWj5p9n0i6mYRWjfD+hcqbn
         NM1PXAYlFkIEtgI3Vl2r9fI3IJaTo16FXLnUVsKkMrnf9cpwuP5VGfdvomFt/30hxBlO
         A1GfHWIJrlV+OV0pPXxfFwS3nQx4c2QbOnuPz9QCUbSCGM95tG+Bi6xOLD9istengeKN
         m0Ct9YE0DEW1RtmveOEs48FtiIs5CyE5J4QRIOc5UrwziHz8nYjUtc+ratCGWw0F5Bk7
         QK0Io/npaCe62ztNN4kMEcdozc4zGsrj7R7H5k6Ff2RRro54veMwtujplx8dvM+Llyae
         my9w==
X-Gm-Message-State: AJIora9Q7kHT1AujEQJShv5eTAnNCtz2/iN4o4Yv4471zMJAoj21xOiu
        0y3R0s3/0Lk8GWdwZnu4Z98y5A==
X-Google-Smtp-Source: AGRyM1uWr+0Iab6n0EUMjtF+F8m7nPeSZ1FxM8bh1kbhD5Z5m0CjtgLUrx112XxemSIpDhu0lDEUzQ==
X-Received: by 2002:adf:d1e1:0:b0:21b:b852:e801 with SMTP id g1-20020adfd1e1000000b0021bb852e801mr7599865wrd.479.1656587411697;
        Thu, 30 Jun 2022 04:10:11 -0700 (PDT)
Received: from localhost ([5.181.106.148])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c4e8700b003a17ab4e7c8sm2728802wmq.39.2022.06.30.04.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 04:10:10 -0700 (PDT)
From:   Jamie Iles <jamie@jamieiles.com>
To:     maz@kernel.org
Cc:     michal.simek@amd.com, linux-kernel@vger.kernel.org,
        Jamie Iles <jamie@jamieiles.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] irqchip/xilinx: add explicit dependency on OF_ADDRESS
Date:   Thu, 30 Jun 2022 12:10:08 +0100
Message-Id: <20220630111008.3838307-1-jamie@jamieiles.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b84dc7f0e364 ("irqchip/xilinx: Remove microblaze+zynq
dependency") relaxed the dependencies on the Xilinx interrupt controller
to be OF only, but some OF architectures (s390 for example) do not
support OF_ADDRESS and so a build of the driver will result in undefined
references to of_iomap/iounmap and friends.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 drivers/irqchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 1f23a6be7d88..bbb11cb8b0f7 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -298,7 +298,7 @@ config XTENSA_MX
 
 config XILINX_INTC
 	bool "Xilinx Interrupt Controller IP"
-	depends on OF
+	depends on OF_ADDRESS
 	select IRQ_DOMAIN
 	help
 	  Support for the Xilinx Interrupt Controller IP core.
-- 
2.34.1

