Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECAC53721E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 20:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiE2SNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 14:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiE2SNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 14:13:46 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDA4703EF;
        Sun, 29 May 2022 11:13:43 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5CDAF22248;
        Sun, 29 May 2022 20:13:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1653848021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f9XNTGn+HU9ifTLspVWfrUfTbd+mZ0O2Sv288leiWk4=;
        b=sP6C0XFykNmOAD2lXUG8aZHDbHlXLfsqCIcpAyV7TPf4CO+CuMgRCQxD2yNKP19f7MlDfv
        VBn/rxsqlkKqS61UuSqs5iHxH+BpQnPPH9/H5ftQi7uFBe4feoxjZ2NHr+dMyg2zNTxLIE
        PMiG7LAc5OCbPoRQR7Ra3qoL5HBlm2Q=
From:   Michael Walle <michael@walle.cc>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH 1/2] cpuidle: cpuidle-arm: remove arm64 support
Date:   Sun, 29 May 2022 20:13:28 +0200
Message-Id: <20220529181329.2345722-2-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220529181329.2345722-1-michael@walle.cc>
References: <20220529181329.2345722-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 788961462f34 ("ARM: psci: cpuidle: Enable PSCI CPUidle
driver") the generic ARM cpuidle driver doesn't probe anymore because
arm_cpuidle_init() will always return -EOPNOTSUPP. That is, because the
mentioned commit removes the only .cpu_suspend and .cpu_init_idle
provider.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/cpuidle/Kconfig.arm | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index be7f512109f7..747aa537389b 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -3,7 +3,8 @@
 # ARM CPU Idle drivers
 #
 config ARM_CPUIDLE
-	bool "Generic ARM/ARM64 CPU idle Driver"
+	bool "Generic ARM CPU idle Driver"
+	depends on ARM
 	select DT_IDLE_STATES
 	select CPU_IDLE_MULTIPLE_DRIVERS
 	help
-- 
2.30.2

