Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D67553A310
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 12:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352291AbiFAKqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 06:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352269AbiFAKpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:45:44 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C227E1FF;
        Wed,  1 Jun 2022 03:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654080343; x=1685616343;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=O2yg0I20nG+oUK+kNJ2d1RGgrkEmhPuBlC/mEvavGQQ=;
  b=Im/7K/n5nTKdBirGInFJ4MXhVodpTpXVcZt7sWsdyNFd44OTcnnKVYa5
   +WrUk+wjyv9tJMF5AFe18MgRYRy8nIMFjhatIzG3fLsgFxRz/+IgP942W
   wdpXAalHv7h6UPP7NIprl4pZKR3FUE1QJWakwVfsJi7EWyqV9Fub8uQ4I
   4=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 01 Jun 2022 03:45:43 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 01 Jun 2022 03:45:41 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg01-blr.qualcomm.com with ESMTP; 01 Jun 2022 16:15:23 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 732EB3FCD; Wed,  1 Jun 2022 16:15:22 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wim@linux-watchdog.org,
        linux@roeck-us.net
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        manivannan.sadhasivam@linaro.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 08/11] ARM: dts: qcom: sdx65-mtp: Increase the vmalloc size
Date:   Wed,  1 Jun 2022 16:15:09 +0530
Message-Id: <1654080312-5408-9-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654080312-5408-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1654080312-5408-1-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase the size of vmalloc using the bootargs in sdx65
mtp board.
It is failing to alloacte the size needed for firmware and
giving the error logs due to actual vmalloc region lesser than requested.

cat /proc/meminfo shows the size of VmallocTotal as 245760 kB.

[ 10.980356] vmap allocation for size 268439552 failed: use vmalloc=<size> to increase size
[ 10.980505] qcom_q6v5_pas 4080000.remoteproc: unable to map memory region: 0x90800000+10000000
[ 10.988542] In adsp alloc memory: adsp_probe 482
[ 10.988592] remoteproc remoteproc0: releasing 4080000.remoteproc
[ 11.001598] qcom_q6v5_pas: probe of 4080000.remoteproc failed with error -16

Thus, increasing the size to 300000000 as modem is not the only one using vmalloc region.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm/boot/dts/qcom-sdx65-mtp.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
index 85ea02d..966385f 100644
--- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
+++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
@@ -21,6 +21,7 @@
 
 	chosen {
 		stdout-path = "serial0:115200n8";
+		bootargs = "vmalloc=300000000";
 	};
 
 	reserved-memory {
-- 
2.7.4

