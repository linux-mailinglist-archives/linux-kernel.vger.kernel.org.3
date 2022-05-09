Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E823452096F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 01:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbiEIXn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 19:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbiEIXlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 19:41:20 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E6A262658;
        Mon,  9 May 2022 16:34:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 3F0BE1F44239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652139289;
        bh=pGHmFEEjaXj2663JV2ZbLu8gGj/vTytf7TAeEENRqwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j6TdMpmPOCtsPovulFCfAQHz4uF7UDkPzJj/3CmgFYBImRy8M4O8YGcz4W706uWok
         oiILXGafhBbX7n+gHJn6RXTuMBUQC8tJ+EhQAGsuO/iXIERVRLzkR/44dQES7yRA6/
         FtuuqnjfOGSov1+k3mURGR/0OqutTfvEFLoWalI2/ND2VETgVusAQFBX2DfNOA/g7I
         j0l9XZgvP22CfJfFfA6ZxZIqFh1T34qNRlUcm5bkUIByJGzf9sEM5G0d3YHcPWZak3
         l8eX2DCnZSObZ31khwPUziOiMTJxqBOzynYhlqeRkrRRR5tLIOpk/iZhwBgqc0RGs9
         Toz7YL4ixFXdA==
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
Subject: [PATCH v8 27/27] kernel/reboot: Add devm_register_restart_handler()
Date:   Tue, 10 May 2022 02:32:35 +0300
Message-Id: <20220509233235.995021-28-dmitry.osipenko@collabora.com>
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

Add devm_register_restart_handler() helper that registers sys-off
handler using restart mode and with a default priority. Most drivers
will want to register restart handler with a default priority, so this
helper will reduce the boilerplate code and make code easier to read and
follow.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 include/linux/reboot.h |  4 ++++
 kernel/reboot.c        | 22 ++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index 7c6e1f308f7c..e5d9ef886179 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -145,6 +145,10 @@ int devm_register_power_off_handler(struct device *dev,
 				    int (*callback)(struct sys_off_data *data),
 				    void *cb_data);
 
+int devm_register_restart_handler(struct device *dev,
+				  int (*callback)(struct sys_off_data *data),
+				  void *cb_data);
+
 int register_platform_power_off(void (*power_off)(void));
 void unregister_platform_power_off(void (*power_off)(void));
 
diff --git a/kernel/reboot.c b/kernel/reboot.c
index b790025154ac..2e78bd754a75 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -484,6 +484,28 @@ int devm_register_power_off_handler(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_register_power_off_handler);
 
+/**
+ *	devm_register_restart_handler - Register restart handler
+ *	@dev: Device that registers callback
+ *	@callback: Callback function
+ *	@cb_data: Callback's argument
+ *
+ *	Registers resource-managed sys-off handler with a default priority
+ *	and using restart mode.
+ *
+ *	Returns zero on success, or error code on failure.
+ */
+int devm_register_restart_handler(struct device *dev,
+				  int (*callback)(struct sys_off_data *data),
+				  void *cb_data)
+{
+	return devm_register_sys_off_handler(dev,
+					     SYS_OFF_MODE_RESTART,
+					     SYS_OFF_PRIO_DEFAULT,
+					     callback, cb_data);
+}
+EXPORT_SYMBOL_GPL(devm_register_restart_handler);
+
 static struct sys_off_handler *platform_power_off_handler;
 
 static int platform_power_off_notify(struct sys_off_data *data)
-- 
2.35.1

