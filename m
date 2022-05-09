Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A66C52089C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 01:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbiEIXh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 19:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbiEIXhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 19:37:13 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0075B22705F;
        Mon,  9 May 2022 16:33:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 2F8AA1F41C30
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652139194;
        bh=bWEhd2ly681MLGj7UVCJAzYeXMznG9pbqJy3OeFWJRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BPDQwkauvsVGCV6donoyMBQqi6nfKh7S+Iw/1P9iMbIBBqyoUvSgbLuYvsqdYh/ls
         GMjWJ14AyXBDnXQre3telXmHCJzLKXlCCI3qHan6n6N+oKtio7vMszlQ/fxWkoZQss
         FWDRbd6hKveTgyIf56hKjN7sgj9kRrU43a5oXc/b4FYAyh/tffvNibZf6DI0vK54ws
         zhTvXytd8B9ucimFodcLV0sRbymSo1ScARgq6soV9eL7++8Wv9QDXGNUEog3feDRa0
         8MU4GtColV6cUkO+UZwfe5puFbTFwvmAXe5mtb2I6jqpygEimE8CDtmiPOapiivdh/
         Y3sLj2Qbwqplg==
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
Subject: [PATCH v8 03/27] kernel/reboot: Introduce sys-off handler API
Date:   Tue, 10 May 2022 02:32:11 +0300
Message-Id: <20220509233235.995021-4-dmitry.osipenko@collabora.com>
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

In order to support power-off chaining we need to get rid of the global
pm_* variables, replacing them with the new kernel API functions that
support chaining.

Introduce new generic sys-off handler API that brings the following
features:

1. Power-off and restart handlers are registered using same API function
   that supports chaining, hence all power-off and restart modes will
   support chaining using this unified function.

2. Prevents notifier priority collisions by disallowing registration of
   multiple handlers at the non-default priority level.

3. Supports passing opaque user argument to callback, which allows us to
   remove global variables from drivers.

This patch adds support of the following sys-off modes:

- SYS_OFF_MODE_POWER_OFF_PREPARE that replaces global pm_power_off_prepare
  variable and provides chaining support for power-off-prepare handlers.

- SYS_OFF_MODE_POWER_OFF that replaces global pm_power_off variable and
  provides chaining support for power-off handlers.

- SYS_OFF_MODE_RESTART that provides a better restart API, removing a need
  from drivers to have a global scratch variable by utilizing the opaque
  callback argument.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 include/linux/reboot.h |  77 +++++++++++++++++
 kernel/reboot.c        | 182 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 259 insertions(+)

diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index a2429648d831..05981ef079d8 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -7,6 +7,7 @@
 #include <uapi/linux/reboot.h>
 
 struct device;
+struct sys_off_handler;
 
 #define SYS_DOWN	0x0001	/* Notify of system down */
 #define SYS_RESTART	SYS_DOWN
@@ -62,6 +63,82 @@ extern void machine_shutdown(void);
 struct pt_regs;
 extern void machine_crash_shutdown(struct pt_regs *);
 
+/*
+ * sys-off handler API.
+ */
+
+/*
+ * Standard sys-off priority levels. Users are expected to set priorities
+ * relative to the standard levels.
+ *
+ * SYS_OFF_PRIO_PLATFORM:	Use this for platform-level handlers.
+ *
+ * SYS_OFF_PRIO_LOW:		Use this for handler of last resort.
+ *
+ * SYS_OFF_PRIO_DEFAULT:	Use this for normal handlers.
+ *
+ * SYS_OFF_PRIO_HIGH:		Use this for higher priority handlers.
+ *
+ * SYS_OFF_PRIO_FIRMWARE:	Use this if handler uses firmware call.
+ */
+#define SYS_OFF_PRIO_PLATFORM		-256
+#define SYS_OFF_PRIO_LOW		-128
+#define SYS_OFF_PRIO_DEFAULT		0
+#define SYS_OFF_PRIO_HIGH		192
+#define SYS_OFF_PRIO_FIRMWARE		224
+
+enum sys_off_mode {
+	/**
+	 * @SYS_OFF_MODE_POWER_OFF_PREPARE:
+	 *
+	 * Handlers prepare system to be powered off. Handlers are
+	 * allowed to sleep.
+	 */
+	SYS_OFF_MODE_POWER_OFF_PREPARE,
+
+	/**
+	 * @SYS_OFF_MODE_POWER_OFF:
+	 *
+	 * Handlers power-off system. Handlers are disallowed to sleep.
+	 */
+	SYS_OFF_MODE_POWER_OFF,
+
+	/**
+	 * @SYS_OFF_MODE_RESTART:
+	 *
+	 * Handlers restart system. Handlers are disallowed to sleep.
+	 */
+	SYS_OFF_MODE_RESTART,
+};
+
+/**
+ * struct sys_off_data - sys-off callback argument
+ *
+ * @mode: Mode ID. Currently used only by the sys-off restart mode,
+ *        see enum reboot_mode for the available modes.
+ * @cb_data: User's callback data.
+ * @cmd: Command string. Currently used only by the sys-off restart mode,
+ *       NULL otherwise.
+ */
+struct sys_off_data {
+	int mode;
+	void *cb_data;
+	const char *cmd;
+};
+
+struct sys_off_handler *
+register_sys_off_handler(enum sys_off_mode mode,
+			 int priority,
+			 int (*callback)(struct sys_off_data *data),
+			 void *cb_data);
+void unregister_sys_off_handler(struct sys_off_handler *handler);
+
+int devm_register_sys_off_handler(struct device *dev,
+				  enum sys_off_mode mode,
+				  int priority,
+				  int (*callback)(struct sys_off_data *data),
+				  void *cb_data);
+
 /*
  * Architecture independent implemenations of sys_reboot commands.
  */
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 8ce30fa0a104..672a658f21ee 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -48,6 +48,15 @@ int reboot_cpu;
 enum reboot_type reboot_type = BOOT_ACPI;
 int reboot_force;
 
+struct sys_off_handler {
+	struct notifier_block nb;
+	int (*sys_off_cb)(struct sys_off_data *data);
+	void *cb_data;
+	enum sys_off_mode mode;
+	bool blocking;
+	void *list;
+};
+
 /*
  * If set, this is used for preparing the system to power off.
  */
@@ -281,6 +290,179 @@ void kernel_halt(void)
 }
 EXPORT_SYMBOL_GPL(kernel_halt);
 
+/*
+ *	Notifier list for kernel code which wants to be called
+ *	to prepare system for power off.
+ */
+static BLOCKING_NOTIFIER_HEAD(power_off_prep_handler_list);
+
+/*
+ *	Notifier list for kernel code which wants to be called
+ *	to power off system.
+ */
+static ATOMIC_NOTIFIER_HEAD(power_off_handler_list);
+
+static int sys_off_notify(struct notifier_block *nb,
+			  unsigned long mode, void *cmd)
+{
+	struct sys_off_handler *handler;
+	struct sys_off_data data = {};
+
+	handler = container_of(nb, struct sys_off_handler, nb);
+	data.cb_data = handler->cb_data;
+	data.mode = mode;
+	data.cmd = cmd;
+
+	return handler->sys_off_cb(&data);
+}
+
+/**
+ *	register_sys_off_handler - Register sys-off handler
+ *	@mode: Sys-off mode
+ *	@priority: Handler priority
+ *	@callback: Callback function
+ *	@cb_data: Callback argument
+ *
+ *	Registers system power-off or restart handler that will be invoked
+ *	at the step corresponding to the given sys-off mode. Handler's callback
+ *	should return NOTIFY_DONE to permit execution of the next handler in
+ *	the call chain or NOTIFY_STOP to break the chain (in error case for
+ *	example).
+ *
+ *	Multiple handlers can be registered at the default priority level.
+ *
+ *	Only one handler can be registered at the non-default priority level,
+ *	otherwise ERR_PTR(-EBUSY) is returned.
+ *
+ *	Returns a new instance of struct sys_off_handler on success, or
+ *	an ERR_PTR()-encoded error code otherwise.
+ */
+struct sys_off_handler *
+register_sys_off_handler(enum sys_off_mode mode,
+			 int priority,
+			 int (*callback)(struct sys_off_data *data),
+			 void *cb_data)
+{
+	struct sys_off_handler *handler;
+	int err;
+
+	handler = kzalloc(sizeof(*handler), GFP_KERNEL);
+	if (!handler)
+		return ERR_PTR(-ENOMEM);
+
+	switch (mode) {
+	case SYS_OFF_MODE_POWER_OFF_PREPARE:
+		handler->list = &power_off_prep_handler_list;
+		handler->blocking = true;
+		break;
+
+	case SYS_OFF_MODE_POWER_OFF:
+		handler->list = &power_off_handler_list;
+		break;
+
+	case SYS_OFF_MODE_RESTART:
+		handler->list = &restart_handler_list;
+		break;
+
+	default:
+		kfree(handler);
+		return ERR_PTR(-EINVAL);
+	}
+
+	handler->nb.notifier_call = sys_off_notify;
+	handler->nb.priority = priority;
+	handler->sys_off_cb = callback;
+	handler->cb_data = cb_data;
+	handler->mode = mode;
+
+	if (handler->blocking) {
+		if (priority == SYS_OFF_PRIO_DEFAULT)
+			err = blocking_notifier_chain_register(handler->list,
+							       &handler->nb);
+		else
+			err = blocking_notifier_chain_register_unique_prio(handler->list,
+									   &handler->nb);
+	} else {
+		if (priority == SYS_OFF_PRIO_DEFAULT)
+			err = atomic_notifier_chain_register(handler->list,
+							     &handler->nb);
+		else
+			err = atomic_notifier_chain_register_unique_prio(handler->list,
+									 &handler->nb);
+	}
+
+	if (err) {
+		kfree(handler);
+		return ERR_PTR(err);
+	}
+
+	return handler;
+}
+EXPORT_SYMBOL_GPL(register_sys_off_handler);
+
+/**
+ *	unregister_sys_off_handler - Unregister sys-off handler
+ *	@handler: Sys-off handler
+ *
+ *	Unregisters given sys-off handler.
+ */
+void unregister_sys_off_handler(struct sys_off_handler *handler)
+{
+	int err;
+
+	if (!handler)
+		return;
+
+	if (handler->blocking)
+		err = blocking_notifier_chain_unregister(handler->list,
+							 &handler->nb);
+	else
+		err = atomic_notifier_chain_unregister(handler->list,
+						       &handler->nb);
+
+	/* sanity check, shall never happen */
+	WARN_ON(err);
+
+	kfree(handler);
+}
+EXPORT_SYMBOL_GPL(unregister_sys_off_handler);
+
+static void devm_unregister_sys_off_handler(void *data)
+{
+	struct sys_off_handler *handler = data;
+
+	unregister_sys_off_handler(handler);
+}
+
+/**
+ *	devm_register_sys_off_handler - Register sys-off handler
+ *	@dev: Device that registers handler
+ *	@mode: Sys-off mode
+ *	@priority: Handler priority
+ *	@callback: Callback function
+ *	@cb_data: Callback argument
+ *
+ *	Registers resource-managed sys-off handler.
+ *
+ *	Returns zero on success, or error code on failure.
+ */
+int devm_register_sys_off_handler(struct device *dev,
+				  enum sys_off_mode mode,
+				  int priority,
+				  int (*callback)(struct sys_off_data *data),
+				  void *cb_data)
+{
+	struct sys_off_handler *handler;
+
+	handler = register_sys_off_handler(mode, priority, callback, cb_data);
+	if (IS_ERR(handler))
+		return PTR_ERR(handler);
+
+	return devm_add_action_or_reset(dev, devm_unregister_sys_off_handler,
+					handler);
+}
+EXPORT_SYMBOL_GPL(devm_register_sys_off_handler);
+
 /**
  *	kernel_power_off - power_off the system
  *
-- 
2.35.1

