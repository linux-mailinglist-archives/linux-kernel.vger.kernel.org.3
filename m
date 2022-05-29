Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1227E537220
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 20:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbiE2SN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 14:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiE2SNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 14:13:46 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5ABF703F0;
        Sun, 29 May 2022 11:13:43 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 725682222E;
        Sun, 29 May 2022 20:13:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1653848021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6n/6v/VC4xmIj9vHN5pvSgXtD15Nl8g3BX3m4NKHQh0=;
        b=KX2uvR1yYFGMln4H+O3VuZyFA8BM0rUYCplNorT8hCqSIbPKLVi0dURDTJpGZU4W7uXftG
        qovEJJdKEfsPCSrE8i7ZkrzXfJp94npMskROTsYjoExwYIxwVz8wi5mEMxfcU2zVREfcQI
        oFRpz+yBdUqsoHO/+OdAZtL1rSkyQ14=
From:   Michael Walle <michael@walle.cc>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH 0/2] arm64: remove generic ARM cpuidle support
Date:   Sun, 29 May 2022 20:13:27 +0200
Message-Id: <20220529181329.2345722-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
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

Playing with an own PSCI implementation, I've noticed that the cpuidle-arm
driver doesn't work on arm64. It doesn't probe because since commit
788961462f34 ("ARM: psci: cpuidle: Enable PSCI CPUidle driver") the
arm_cpuidle_init() can only return -EOPNOTSUPP, because the commit removed
the cpu_idle_init and cpu_suspend ops.

It left me puzzled for quite some time. It seems that the cpuidle-psci is
the preferred one and this has been the case for quite some time. The
mentioned commit first appeared in v5.4.

Remove the ARM64 support for the cpuidle-arm driver, which then let us
remove all the supporting arch code.

Michael Walle (2):
  cpuidle: cpuidle-arm: remove arm64 support
  arm64: cpuidle: remove generic cpuidle support

 arch/arm64/include/asm/cpu_ops.h |  9 ---------
 arch/arm64/include/asm/cpuidle.h | 15 ---------------
 arch/arm64/kernel/cpuidle.c      | 29 -----------------------------
 drivers/cpuidle/Kconfig.arm      |  3 ++-
 4 files changed, 2 insertions(+), 54 deletions(-)

-- 
2.30.2

