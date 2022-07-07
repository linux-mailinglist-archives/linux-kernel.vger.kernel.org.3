Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4100056A100
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 13:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbiGGLUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 07:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiGGLUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 07:20:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CD713CEF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 04:20:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DD94622F0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 11:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C8FC3411E;
        Thu,  7 Jul 2022 11:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657192812;
        bh=aiyTbicPsb7VZNnD7RyzS8iSfcSdgmUuB8FlOpWLxUo=;
        h=From:To:Cc:Subject:Date:From;
        b=j1Q16gU6HsNLSkdiC3XXzN3Qjfuf8GgsGYdqjRV9SUVPbnDBJFY0LTjCIbMN1NvkE
         XGPVVtHKpw6lBTTD6WVyw7YqxOsIzHgjYQe49B3K6wVWT88ghKMruV0HZ7AjrfUfr+
         IRCw8G3cybCP171s1xFwTAeDa1AEC3bVBhXCm0n83PM9p/ozuLceCqblvYoThtx2Ik
         gCUXXNjMkSOj1d50fEJoV8Jl4dFP+MgVgcaHbFVww+1AVdPN231+A00DZx61yX/L6e
         YRvo5gjwhfQlN8o5jC3SJLsA+NkI9QV5fKbdrT1ie0CEJDLcBB7fvb65Jh0sLPeTGj
         pgWQD4oBGhkeA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] regulator: Fix MFD_MAX597X dependency
Date:   Thu,  7 Jul 2022 12:17:53 +0100
Message-Id: <20220707111753.16581-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=761; h=from:subject; bh=aiyTbicPsb7VZNnD7RyzS8iSfcSdgmUuB8FlOpWLxUo=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBixsCv1EX5jf2aH5wxmWkPgBTLjoO0tTXH7POWdXVj EobqYmuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYsbArwAKCRAk1otyXVSH0B3QB/ 9Lsos5mxxL28/epyxiB/ojaWLVwOvRUfPtu0Dmqz0xst8a6PGBH2I9w4NeQkAnlT1HC+ieU4t2oLBx 7S2vcrBNdoi+ApO1HzoRZWIz5pZChlLGH35Z7eojp7zjnc/4HKxzQ4BeutmkA+umoSfuRsSnNidmFz lmAa6nxnJY65Zw1dxmSWKpleDK+Axppr5Fjw2vNhvqUxeKYD2fN2DCsOmoHNhW2ZJYWhATOOtRcJbI vqLbApuwgDHojJEqfPLVb+qydVj9L1ZxlCYpuNowLa3Mx7iFq4GHSMWloXpExa2D0CTQ5umqeR8m/i pf5Hucj6orJDIG1VlrMIsaqlkXZgB7
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers should depend on rather than select their MFDs.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index aedc4cba9240..23e3e4a35cc9 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -550,7 +550,7 @@ config REGULATOR_MAX597X
 	tristate "Maxim 597x power switch and monitor"
 	depends on I2C
 	depends on OF
-	select MFD_MAX597X
+	depends on MFD_MAX597X
 	help
 	  This driver controls a Maxim 5970/5978 switch via I2C bus.
 	  The MAX5970/5978 is a smart switch with no output regulation, but
-- 
2.30.2

