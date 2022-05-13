Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB50525CA1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377894AbiEMHtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 03:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377890AbiEMHtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 03:49:47 -0400
X-Greylist: delayed 1025 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 13 May 2022 00:49:42 PDT
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49DE13C377;
        Fri, 13 May 2022 00:49:42 -0700 (PDT)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=71464b001b=fe@dev.tdt.de>)
        id 1npPmm-000Mf9-8i; Fri, 13 May 2022 09:32:28 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1npPml-0008PU-9e; Fri, 13 May 2022 09:32:27 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 8A531240049;
        Fri, 13 May 2022 09:32:26 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 13B94240040;
        Fri, 13 May 2022 09:32:26 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id 687B22750E;
        Fri, 13 May 2022 09:32:25 +0200 (CEST)
From:   Florian Eckert <fe@dev.tdt.de>
To:     linux@roeck-us.net
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eckert.Florian@googlemail.com,
        kernel testrobot <lkp@intel.com>
Subject: [PATCH] hwmon: (ltq-cputemp) restrict build to SOC_XWAY
Date:   Fri, 13 May 2022 09:32:21 +0200
Message-ID: <20220513073221.48744-1-fe@dev.tdt.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Content-Transfer-Encoding: quoted-printable
X-purgate-type: clean
X-purgate-ID: 151534::1652427147-F32576BE-22BD198C/0/0
X-purgate: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver can only be built if the target is set to SOC_XWAY, because
only then the used macros 'ltq_cgu_*'  are available.

To clarify this, the Kconfig is adjusted so that the driver can only be
selected when the SOC_XWAY is also selected.

Reported-by: kernel testrobot <lkp@intel.com>
Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---

This is a fix for an issue, that was reported by the 'kernel testrobot'.

 drivers/hwmon/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 68a8a27ab3b7..1122c0519410 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -960,7 +960,7 @@ config SENSORS_LTC4261
=20
 config SENSORS_LTQ_CPUTEMP
 	bool "Lantiq cpu temperature sensor driver"
-	depends on LANTIQ
+	depends on LANTIQ && SOC_XWAY
 	help
 	  If you say yes here you get support for the temperature
 	  sensor inside your CPU.
--=20
2.30.2

