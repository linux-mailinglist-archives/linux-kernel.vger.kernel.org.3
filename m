Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912AA4AE5CB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 01:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239379AbiBIAPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 19:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239393AbiBIAPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 19:15:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62890C061576;
        Tue,  8 Feb 2022 16:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=lJOw/VsM+kYcT/r7+TM/LOgN+0nAg/jllFVjzFoM+1w=; b=cF2+BNKws0UQ09BHu8hPNouc9E
        AbUDHIXPuBawoB/uMNaTtM/qDD4SnCeBoSm//klzhdjTXk6fF7b4B3TWrpIZJXDbOyPy8ZnOyfetI
        wd0CgTL4TjXE6UcB/QESUJC2St8GyxzYSj++nNvwfbpo5oVbJ2ceclV/kumhV9OHxkEnGq8+hJaq5
        yDYu+4BPe8/DAzM2w0J5UoTjA0TC/uzCvpMJhFWJfn74mZ4XbVIAsSZ7mkFa8Syw3LRReAgDHoyyG
        A9ZEn0ONe3jvIPDmnAbVwuvR4yz5f2lXvz3RZVOWsgUHhWqS+sC8XGAJhLaY3sI0kWRRYlQMSXt7h
        353Ld3FQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHaeB-00FqeX-HY; Wed, 09 Feb 2022 00:15:47 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH -next] thermal: intel: INTEL_HFI_THERMAL depends on NET
Date:   Tue,  8 Feb 2022 16:15:46 -0800
Message-Id: <20220209001546.18189-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
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

THERMAL_NETLINK depends on NET and since 'select' does not follow
any dependency chain, INTEL_HFI_THERMAL also should depend on NET.

Fix one Kconfig warning and 48 subsequent build errors:

WARNING: unmet direct dependencies detected for THERMAL_NETLINK
  Depends on [n]: THERMAL [=y] && NET [=n]
  Selected by [y]:
  - INTEL_HFI_THERMAL [=y] && THERMAL [=y] && (X86 [=y] || X86_INTEL_QUARK [=n] || COMPILE_TEST [=y]) && CPU_SUP_INTEL [=y] && X86_THERMAL_VECTOR [=y]

Fixes: bd30cdfd9bd7 ("thermal: intel: hfi: Notify user space for HFI events")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Aubrey Li <aubrey.li@linux.intel.com>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kucheria <amitk@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
---
Found in mmotm, linux-next.patch.

 drivers/thermal/intel/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- mmotm-2022-0208-1531.orig/drivers/thermal/intel/Kconfig
+++ mmotm-2022-0208-1531/drivers/thermal/intel/Kconfig
@@ -102,6 +102,7 @@ config INTEL_MENLOW
 
 config INTEL_HFI_THERMAL
 	bool "Intel Hardware Feedback Interface"
+	depends on NET
 	depends on CPU_SUP_INTEL
 	depends on X86_THERMAL_VECTOR
 	select THERMAL_NETLINK
