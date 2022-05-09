Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB23852091F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 01:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbiEIXjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 19:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbiEIXh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 19:37:56 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE4424FDAB;
        Mon,  9 May 2022 16:33:35 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id C21B61F430BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652139214;
        bh=hTMdSPi0zN4MGEkpm7fbCDxWpGgYrC/cc+PuY565mHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sk8pDCwXSAwTQ9cVTZlPz8a8ySrGY3hGrPt+VGDskV6R+uCOw9LADMc/JKfeftNPo
         asFxJcHbxHiK/3w91N3jvIgWMJgwCq+N4MlCfsgguAazqG3J0kdIxL0enJF0AIFfvB
         qrj4DZBOnMGXRehw13w/Gqu1lXja85Nu7DH8kFwOkMscD0FBV8ggmpXlUuebyAbpd6
         13JtTCF+jbP9cTENV6T22N6ht/UOp/jY7vlhjRhQskgAm5LbyaAdU+aqJl1oWzNotR
         zhh4iJ4DmsyzvGmL9Z1V2DZh2YCAdFZhUlWdl4dlLp7iND0uYa6NncprgcDCwwXRCN
         BwArMJ/2esCeg==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee.jones@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v8 08/27] kernel/reboot: Add register_platform_power_off()
Date:   Tue, 10 May 2022 02:32:16 +0300
Message-Id: <20220509233235.995021-9-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220509233235.995021-1-dmitry.osipenko@collabora.com>
References: <20220509233235.995021-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add platform-level registration helpers that will ease transition of the
arch/platform power-off callbacks to the new sys-off based API, allowing
us to remove the global pm_power_off variable in the future.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 include/linux/reboot.h |  3 +++
 kernel/reboot.c        | 55 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index c52f77ee4ddd..f185b64faae0 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -141,6 +141,9 @@ int devm_register_sys_off_handler(struct device *dev,
 				  int (*callback)(struct sys_off_data *data),
 				  void *cb_data);
 
+int register_platform_power_off(void (*power_off)(void));
+void unregister_platform_power_off(void (*power_off)(void));
+
 /*
  * Architecture independent implemenations of sys_reboot commands.
  */
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 982e58c11ce8..e74103f2a801 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -469,6 +469,61 @@ int devm_register_sys_off_handler(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_register_sys_off_handler);
 
+static struct sys_off_handler *platform_power_off_handler;
+
+static int platform_power_off_notify(struct sys_off_data *data)
+{
+	void (*platform_power_power_off_cb)(void) = data->cb_data;
+
+	platform_power_power_off_cb();
+
+	return NOTIFY_DONE;
+}
+
+/**
+ *	register_platform_power_off - Register platform-level power-off callback
+ *	@power_off: Power-off callback
+ *
+ *	Registers power-off callback that will be called as last step
+ *	of the power-off sequence. This callback is expected to be invoked
+ *	for the last resort. Only one platform power-off callback is allowed
+ *	to be registered at a time.
+ *
+ *	Returns zero on success, or error code on failure.
+ */
+int register_platform_power_off(void (*power_off)(void))
+{
+	struct sys_off_handler *handler;
+
+	handler = register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
+					   SYS_OFF_PRIO_PLATFORM,
+					   platform_power_off_notify,
+					   power_off);
+	if (IS_ERR(handler))
+		return PTR_ERR(handler);
+
+	platform_power_off_handler = handler;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(register_platform_power_off);
+
+/**
+ *	unregister_platform_power_off - Unregister platform-level power-off callback
+ *	@power_off: Power-off callback
+ *
+ *	Unregisters previously registered platform power-off callback.
+ */
+void unregister_platform_power_off(void (*power_off)(void))
+{
+	if (platform_power_off_handler &&
+	    platform_power_off_handler->cb_data == power_off) {
+		unregister_sys_off_handler(platform_power_off_handler);
+		platform_power_off_handler = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(unregister_platform_power_off);
+
 static int legacy_pm_power_off_prepare(struct sys_off_data *data)
 {
 	if (pm_power_off_prepare)
-- 
2.35.1

