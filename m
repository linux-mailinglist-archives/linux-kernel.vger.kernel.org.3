Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825765209B0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 01:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbiEIXvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 19:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiEIXvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 19:51:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954C91FE3CF;
        Mon,  9 May 2022 16:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=dgdRyp/JBCn6piYyPx/l1p92/pmnYiL1beMOZMUW7Ko=; b=Y8FAAWKcTSgXAmFq5Pz8d7HiUQ
        b6Hm2Mye9RLEAJKjdiWXt2quqC/I50dzbdz6BCqzHGLztnSzsvXdQH0auiZ5Pv1lponQmcAeTh6ZQ
        +Mg/wTq/QdClDc0F1muZ1hBRblHjTthEI6OdmVSNjMlNvXycpdDY/6yx34i14LdFyV+yIO0QH2IWB
        1q2okaqHsGVBfQRJyXrjF2QutRwS1amqgnooWkCKzakdyRDa/41fr5rc+j9QG3yiHyt/WJpmhQOJV
        vEkaSMSjxBFIjGtWpM2MojhkdDQnHkH9AlH7Tdy+lHIGdfvqFxya1owg+T9tgtaZ7X1n/61FaIk4p
        6/IZ36/Q==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1noD6M-00Goh4-Mw; Mon, 09 May 2022 23:47:42 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Florian Eckert <fe@dev.tdt.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: [PATCH] hwmon: ltq-cputemp: restrict it to SOC_XWAY
Date:   Mon,  9 May 2022 16:47:40 -0700
Message-Id: <20220509234740.26841-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with SENSORS_LTQ_CPUTEMP=y with SOC_FALCON=y causes build
errors since FALCON does not support the same features as XWAY.

Change this symbol to depend on SOC_XWAY since that provides the
necessary interfaces.

Repairs these build errors:

../drivers/hwmon/ltq-cputemp.c: In function 'ltq_cputemp_enable':
../drivers/hwmon/ltq-cputemp.c:23:9: error: implicit declaration of function 'ltq_cgu_w32'; did you mean 'ltq_ebu_w32'? [-Werror=implicit-function-declaration]
   23 |         ltq_cgu_w32(ltq_cgu_r32(CGU_GPHY1_CR) | CGU_TEMP_PD, CGU_GPHY1_CR);
../drivers/hwmon/ltq-cputemp.c:23:21: error: implicit declaration of function 'ltq_cgu_r32'; did you mean 'ltq_ebu_r32'? [-Werror=implicit-function-declaration]
   23 |         ltq_cgu_w32(ltq_cgu_r32(CGU_GPHY1_CR) | CGU_TEMP_PD, CGU_GPHY1_CR);
../drivers/hwmon/ltq-cputemp.c: In function 'ltq_cputemp_probe':
../drivers/hwmon/ltq-cputemp.c:92:31: error: 'SOC_TYPE_VR9_2' undeclared (first use in this function)
   92 |         if (ltq_soc_type() != SOC_TYPE_VR9_2)

Fixes: 7074d0a92758 ("hwmon: (ltq-cputemp) add cpu temp sensor driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Florian Eckert <fe@dev.tdt.de>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: linux-hwmon@vger.kernel.org
---
 drivers/hwmon/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -977,7 +977,7 @@ config SENSORS_LTC4261
 
 config SENSORS_LTQ_CPUTEMP
 	bool "Lantiq cpu temperature sensor driver"
-	depends on LANTIQ
+	depends on SOC_XWAY
 	help
 	  If you say yes here you get support for the temperature
 	  sensor inside your CPU.
