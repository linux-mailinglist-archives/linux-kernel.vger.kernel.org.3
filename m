Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FC6539D2A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 08:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349818AbiFAGWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 02:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348202AbiFAGWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 02:22:15 -0400
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DADF674EE;
        Tue, 31 May 2022 23:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=yLlbj
        t+XVP8933Xv+3/nCXfakQkhbPbZd5pvp6pFQ8o=; b=hzeIUUXVKmH0C0FeYtGNZ
        rMBgI+HSyfKAXYldC8BPPW7FhMGNc62l5QYvIdL5EAugiV4gGV/Ic2363GrwttJ/
        Bnx9FA6cv6k7oMxGk/uyLikv92eUUVRU5C6dGiIjDnxWWwmiyDARnxwOghLdTVVJ
        UGeUq0JlGK8U1eRJb5S4g4=
Received: from localhost.localdomain (unknown [112.97.51.18])
        by smtp2 (Coremail) with SMTP id GtxpCgAHROEbBZdipGWdFw--.6115S2;
        Wed, 01 Jun 2022 14:20:13 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     mani@kernel.org, quic_hemantk@quicinc.com
Cc:     gregkh@linuxfoundation.org, loic.poulain@linaro.org,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] bus: mhi: host: Add support for Cinterion MV31-W with new device ID
Date:   Wed,  1 Jun 2022 14:19:15 +0800
Message-Id: <20220601061915.10946-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgAHROEbBZdipGWdFw--.6115S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZryDJw48XFyfZrykXFW8JFb_yoWfZrX_Cr
        Z3Wr9rCwsrWrnFqw1vq3ZxZ3y0k3WxXFykGF48tF95C3sru395Xw4FqF9Iyr9YgrZ3CF9x
        Ar17u3sYkwsFkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRGNt3UUUUUU==
X-Originating-IP: [112.97.51.18]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiJR0TZGAJoTobjAAAsq
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Thales would use a new baseline, so we need to add
a new device ID to separate it from previous.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/bus/mhi/host/pci_generic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 6fbc5915ea36..a2a4fd2cd13d 100644
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

