Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B264D709F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 20:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbiCLTxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 14:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiCLTxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 14:53:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244A9673F0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 11:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=46BaTAlH/OKydLod1HzNTZq02oo+TDCOK386PUPy6Mw=; b=UQKkeF8Jf4Gf5bUz8S4C73QteO
        4Q/dIPfuUH6m52Lx/zc7dpaOpxDeEGqEmsYulTgsgU1YjEFeVpnUODd2znmoBuaxhbyo4KGBxIaCt
        W5oo+YnUebsBvTBSHi7cY5NSQpX8KHXb56ACirQvrehoMSerz8hAu57TYj2oIRKhrZEY+ycnhcXsl
        l3WDExEGBhsk+VQ6ETB82Oi2ovnuVDzDJtsTE92IfKOs/aysQfHGvzJ2SDDKJjmS5HdZuWWxzrztw
        7fEkjqz9f9rKDdBY04F2Csh4bmRnfQ/TSa9x3aKagXJTKY6M5u/w8/YNzAbGGlaYSmhlGsbCzPdFR
        NLHCqA6g==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nT7md-001n1z-6G; Sat, 12 Mar 2022 19:52:11 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        John Stultz <john.stultz@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2] clocksource: acpi_pm: fix return value of __setup handler
Date:   Sat, 12 Mar 2022 11:52:10 -0800
Message-Id: <20220312195210.23573-1-rdunlap@infradead.org>
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

__setup() handlers should return 1 to obsolete_checksetup() in
init/main.c to indicate that the boot option has been handled.
A return of 0 causes the boot option/value to be listed as an Unknown
kernel parameter and added to init's (limited) environment strings.

The __setup() handler interface isn't meant to handle negative return
values -- they are non-zero, so they mean "handled" (like a return
value of 1 does), but that's just a quirk. So return 1 from
parse_pmtmr(). Also print a warning message if kstrtouint() returns
an error.

Fixes: 6b148507d3d0 ("pmtmr: allow command line override of ioport")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
From: Igor Zhbanov <i.zhbanov@omprussia.ru>
Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
---
v2: correct the Fixes: tag (Dan Carpenter)

 drivers/clocksource/acpi_pm.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-next-20220310.orig/drivers/clocksource/acpi_pm.c
+++ linux-next-20220310/drivers/clocksource/acpi_pm.c
@@ -229,8 +229,10 @@ static int __init parse_pmtmr(char *arg)
 	int ret;
 
 	ret = kstrtouint(arg, 16, &base);
-	if (ret)
-		return ret;
+	if (ret) {
+		pr_warn("PMTMR: invalid 'pmtmr=' value: '%s'\n", arg);
+		return 1;
+	}
 
 	pr_info("PMTMR IOPort override: 0x%04x -> 0x%04x\n", pmtmr_ioport,
 		base);
