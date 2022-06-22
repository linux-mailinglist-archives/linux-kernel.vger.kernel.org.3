Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E654D5540E1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 05:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356582AbiFVD1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 23:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiFVD1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 23:27:09 -0400
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECDE5A464;
        Tue, 21 Jun 2022 20:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=11otV
        2IKFMQ94iOaeDl79qLoQpeapOIdGaJ+c5b79DA=; b=UFMoHA40MSc7vHhf/2oxt
        ZPvWFhKWj94CHtmarvHPXadk2JMky69DOb1l1cAW1eJwP2vhUAvgHbFgwGwwCp+y
        wNoq7LwUI3qd5paBiLcgDTZgowcUbGHtLUb//HRcUl8mgiQEDI30QOAjo0fRLQ5S
        GbK1aYFzA2gCAc9oAEghac=
Received: from localhost.localdomain (unknown [43.134.191.38])
        by smtp4 (Coremail) with SMTP id HNxpCgAHdu28i7JiFXqbKg--.1384S2;
        Wed, 22 Jun 2022 11:25:52 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     mani@kernel.org, quic_hemantk@quicinc.com
Cc:     gregkh@linuxfoundation.org, loic.poulain@linaro.org,
        dnlplm@gmail.com, bbhatt@codeaurora.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH v2] bus: mhi: host: pci_generic: Add Cinterion MV31-W with new baseline
Date:   Wed, 22 Jun 2022 11:25:44 +0800
Message-Id: <20220622032544.17713-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgAHdu28i7JiFXqbKg--.1384S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZr1xKF15JFWkWrWfKr1fXrb_yoWDGFc_Cr
        93WrsrCw18GrnFvw1vgw13Z340k3WxXFykJF48tas3C34Du395Xw4FqFWYyrn5KrZ8CF9x
        Ar1fu3sYkw129jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRWT5QJUUUUU==
X-Originating-IP: [43.134.191.38]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbivwEoZFWB0E6UXgAAsy
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cinterion MV31-W modem with a new baseline (firmware) is sold as a separate
product with different device ID. So add support for the same reusing the
config.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/bus/mhi/host/pci_generic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 841626727f6b..062662b3778b 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -578,6 +578,9 @@ static const struct pci_device_id mhi_pci_id_table[] = {
 	/* MV31-W (Cinterion) */
 	{ PCI_DEVICE(0x1269, 0x00b3),
 		.driver_data = (kernel_ulong_t) &mhi_mv31_info },
+	/* MV31-W (Cinterion), based on new baseline */
+	{ PCI_DEVICE(0x1269, 0x00b4),
+		.driver_data = (kernel_ulong_t) &mhi_mv31_info },
 	/* MV32-WA (Cinterion) */
 	{ PCI_DEVICE(0x1269, 0x00ba),
 		.driver_data = (kernel_ulong_t) &mhi_mv32_info },
-- 
2.25.1

