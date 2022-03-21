Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BA14E24F5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346649AbiCULFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243646AbiCULFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:05:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A901B62FC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:04:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5489AB81235
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 11:04:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977F7C340E8;
        Mon, 21 Mar 2022 11:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647860647;
        bh=D3oOnJL3ER3AhmHVihwXtjtzCXw5YuehlUnZ0nc5tuo=;
        h=From:To:Cc:Subject:Date:From;
        b=mqgEbYvkgcuc5/SpK5BrlryWPa5naquSU1m2uV0mWyqm8k2J0/Lju0XAFBPQD03JK
         6GX5hDW1RZeaEAPyduJDXi5S4w2P3ku2XOTwQBksKyQ2gFDyj1mQNesVP78UFhSRR4
         A9+AsgDsIKO8aLXHj/Xryt2bNgv9nn3vl2Uj9zRucG1X6MWDH81Jr24qBgUoPBtyAE
         GHyuBxOcNuhxPnssoXDPDRTcgFMNJ0Rqdd3YXFdQFu5VIkruYp/lRQs4VdSgsPIBRo
         +cBxHfGcjtlN/nPkwNDc9fF8LXSK/kGyrVoFI9HHSXKoJ6VvIqsam/5sKwNXObN3Yj
         mTQSabAI0R8Mw==
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vincent Shih <vincent.sunplus@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/3] nvmem: bcm-ocotp: mark ACPI device ID table as maybe unused
Date:   Mon, 21 Mar 2022 12:03:24 +0100
Message-Id: <20220321110326.44652-1-krzk@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"bcm_otpc_acpi_ids" is used with ACPI_PTR, so a build with !CONFIG_ACPI
has a warning:

  drivers/nvmem/bcm-ocotp.c:247:36: error:
    ‘bcm_otpc_acpi_ids’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/nvmem/bcm-ocotp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/bcm-ocotp.c b/drivers/nvmem/bcm-ocotp.c
index a8097511582a..dfea96c52463 100644
--- a/drivers/nvmem/bcm-ocotp.c
+++ b/drivers/nvmem/bcm-ocotp.c
@@ -244,7 +244,7 @@ static const struct of_device_id bcm_otpc_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, bcm_otpc_dt_ids);
 
-static const struct acpi_device_id bcm_otpc_acpi_ids[] = {
+static const struct acpi_device_id bcm_otpc_acpi_ids[] __maybe_unused = {
 	{ .id = "BRCM0700", .driver_data = (kernel_ulong_t)&otp_map },
 	{ .id = "BRCM0701", .driver_data = (kernel_ulong_t)&otp_map_v2 },
 	{ /* sentinel */ }
-- 
2.32.0

