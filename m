Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B164A3B45
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 00:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357231AbiA3Xhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 18:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356979AbiA3Xhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 18:37:35 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69AEC06173E;
        Sun, 30 Jan 2022 15:37:34 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id bu18so23307397lfb.5;
        Sun, 30 Jan 2022 15:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=38q4P9PH9nES8RczvE7OnqqkPXztayfrVWMcaUM8s+A=;
        b=Q5MMOfb7rSODkS2kn3q5XZwf8zqIJ51IQ9xubkbgFUXSkjeQuaWSup3m+O4pqzEDb+
         E5n9vGkwG0A9gd4ThXBeoS4gmKX3lE/LDT4c+lQtj8pSMtUOMy+/RfxrZFjXGS7nFwz3
         Ea8wdh6MqebEmUMqRIX0pFbIr1vxXIyTdEq6fEBGk8pS5aGMUej1IOxH3mvGTTx8Zb1A
         p4WtB/fC8HBNV/xxJOVx1rFQqfZwVyB2qQ4QMQgl9eptDSGyK38HXczvAjdOimktb6W5
         8rYZQrU03+6DIo9Weao9ASYgqF1QhkVgUfmExWAQVTk5LYoCXz0MemHnQpiOtJnXUQLZ
         yZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=38q4P9PH9nES8RczvE7OnqqkPXztayfrVWMcaUM8s+A=;
        b=nHxy9Jm3/JLzH3T0OpSQeVxg3ExfOLvOm7Ah4cRJKYsAS+V3fko3V63duzozPp1obD
         1WfHVJDOLJrPvXV5Wd4y6tyNpcExnEdBgacOLnpfpDDDWHhjKkhGewJvwsk44IzITGqU
         +CiXGghBdntTtIxYzOQn0DjrtQCzI/+nh0+TeFnbWBQCz6vOnrdM0jTd8mH/hTzei1R6
         43uksjpQ5NBxA1avch34EeQBkPtbdhpZK6teWCBy18KXYIzsSxNKMa3B27sQLORyHW1p
         hN2FZtFKmuXRQPJ/xQdW/O00ssr/1dwNBV1MG04wqsd6A/WW4V1XawZpOb5kwV3LoOkh
         YhVg==
X-Gm-Message-State: AOAM532xlhykuGGUyaSAcv9VsaUZow8HGbTM16soZwcgxLVDrTf/A1KR
        0hTbv1fYmrpweRaEQjDwg9s=
X-Google-Smtp-Source: ABdhPJwx3H1Lxh28u4hkNoEI/kzbRKfVLKfuDBCQcQ68ILBqPiTWY9aJ1dkoCljIJtKgelCY8ITq2Q==
X-Received: by 2002:a05:6512:23a2:: with SMTP id c34mr13488689lfv.623.1643585852671;
        Sun, 30 Jan 2022 15:37:32 -0800 (PST)
Received: from localhost.localdomain (109-252-138-126.dynamic.spd-mgts.ru. [109.252.138.126])
        by smtp.gmail.com with ESMTPSA id a24sm1262950ljp.112.2022.01.30.15.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 15:37:32 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
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
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee.jones@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, alankao@andestech.com,
        "K . C . Kuen-Chern Lin" <kclin@andestech.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v6 04/21] kernel: Add combined power-off+restart handler call chain API
Date:   Mon, 31 Jan 2022 02:37:01 +0300
Message-Id: <20220130233718.21544-5-digetx@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220130233718.21544-1-digetx@gmail.com>
References: <20220130233718.21544-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SoC platforms often have multiple ways of how to perform system's
power-off and restart operations. Meanwhile today's kernel is limited to
a single option. Add combined power-off+restart handler call chain API,
which is inspired by the restart API. The new API provides both power-off
and restart functionality.

The old pm_power_off method will be kept around till all users are
converted to the new API.

Current restart API will be replaced by the new unified API since
new API is its superset. The restart functionality of the sys-off handler
API is built upon the existing restart-notifier APIs.

In order to ease conversion to the new API, convenient helpers are added
for the common use-cases. They will reduce amount of boilerplate code and
remove global variables. These helpers preserve old behaviour for cases
where only one power-off handler is expected, this is what all existing
drivers want, and thus, they could be easily converted to the new API.
Users of the new API should explicitly enable power-off chaining by
setting corresponding flag of the power_handler structure.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/linux/reboot.h   | 265 ++++++++++++++++++-
 kernel/power/hibernate.c |   2 +-
 kernel/reboot.c          | 555 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 814 insertions(+), 8 deletions(-)

diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index af907a3d68d1..c2fa8d63c129 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -8,10 +8,35 @@
 
 struct device;
 
-#define SYS_DOWN	0x0001	/* Notify of system down */
-#define SYS_RESTART	SYS_DOWN
-#define SYS_HALT	0x0002	/* Notify of system halt */
-#define SYS_POWER_OFF	0x0003	/* Notify of system power off */
+enum reboot_prepare_mode {
+	SYS_DOWN = 1,		/* Notify of system down */
+	SYS_RESTART = SYS_DOWN,
+	SYS_HALT,		/* Notify of system halt */
+	SYS_POWER_OFF,		/* Notify of system power off */
+};
+
+/*
+ * Standard restart priority levels. Intended to be set in the
+ * sys_off_handler.restart_priority field.
+ *
+ * Use `RESTART_PRIO_ABC +- prio` style for additional levels.
+ *
+ * RESTART_PRIO_RESERVED:	Falls back to RESTART_PRIO_DEFAULT.
+ *				Drivers may leave priority initialized
+ *				to zero, to auto-set it to the default level.
+ *
+ * RESTART_PRIO_LOW:		Use this for handler of last resort.
+ *
+ * RESTART_PRIO_DEFAULT:	Use this for default/generic handler.
+ *
+ * RESTART_PRIO_HIGH:		Use this if you have multiple handlers and
+ *				this handler has higher priority than the
+ *				default handler.
+ */
+#define RESTART_PRIO_RESERVED		0
+#define RESTART_PRIO_LOW		8
+#define RESTART_PRIO_DEFAULT		128
+#define RESTART_PRIO_HIGH		192
 
 enum reboot_mode {
 	REBOOT_UNDEFINED = -1,
@@ -49,6 +74,237 @@ extern int register_restart_handler(struct notifier_block *);
 extern int unregister_restart_handler(struct notifier_block *);
 extern void do_kernel_restart(char *cmd);
 
+/*
+ * System power-off and restart API.
+ */
+
+/*
+ * Standard power-off priority levels. Intended to be set in the
+ * sys_off_handler.power_off_priority field.
+ *
+ * Use `POWEROFF_PRIO_ABC +- prio` style for additional levels.
+ *
+ * POWEROFF_PRIO_RESERVED:	Falls back to POWEROFF_PRIO_DEFAULT.
+ *				Drivers may leave priority initialized
+ *				to zero, to auto-set it to the default level.
+ *
+ * POWEROFF_PRIO_PLATFORM:	Intended to be used by platform-level handler.
+ *				Has lowest priority since device drivers are
+ *				expected to take over platform handler which
+ *				doesn't allow further callback chaining.
+ *
+ * POWEROFF_PRIO_DEFAULT:	Use this for default/generic handler.
+ *
+ * POWEROFF_PRIO_FIRMWARE:	Use this if handler uses firmware call.
+ *				Has highest priority since firmware is expected
+ *				to know best how to power-off hardware properly.
+ */
+#define POWEROFF_PRIO_RESERVED		0
+#define POWEROFF_PRIO_PLATFORM		1
+#define POWEROFF_PRIO_DEFAULT		128
+#define POWEROFF_PRIO_HIGH		192
+#define POWEROFF_PRIO_FIRMWARE		224
+
+enum poweroff_mode {
+	POWEROFF_NORMAL = 0,
+	POWEROFF_PREPARE,
+};
+
+/**
+ * struct power_off_data - Power-off callback argument
+ *
+ * @cb_data: Callback data.
+ */
+struct power_off_data {
+	void *cb_data;
+};
+
+/**
+ * struct power_off_prep_data - Power-off preparation callback argument
+ *
+ * @cb_data: Callback data.
+ */
+struct power_off_prep_data {
+	void *cb_data;
+};
+
+/**
+ * struct restart_data - Restart callback argument
+ *
+ * @cb_data: Callback data.
+ * @cmd: Restart command string.
+ * @stop_chain: Further lower priority callbacks won't be executed if set to
+ *		true. Can be changed within callback. Default is false.
+ * @mode: Reboot mode ID.
+ */
+struct restart_data {
+	void *cb_data;
+	const char *cmd;
+	bool stop_chain;
+	enum reboot_mode mode;
+};
+
+/**
+ * struct reboot_prep_data - Reboot and shutdown preparation callback argument
+ *
+ * @cb_data: Callback data.
+ * @cmd: Restart command string.
+ * @stop_chain: Further lower priority callbacks won't be executed if set to
+ *		true. Can be changed within callback. Default is false.
+ * @mode: Preparation mode ID.
+ */
+struct reboot_prep_data {
+	void *cb_data;
+	const char *cmd;
+	bool stop_chain;
+	enum reboot_prepare_mode mode;
+};
+
+struct sys_off_handler_private_data {
+	struct notifier_block power_off_nb;
+	struct notifier_block restart_nb;
+	struct notifier_block reboot_nb;
+	void (*platform_power_off_cb)(void);
+	void (*simple_power_off_cb)(void *data);
+	void *simple_power_off_cb_data;
+	bool registered;
+};
+
+/**
+ * struct sys_off_handler - System power-off and restart handler
+ *
+ * @cb_data: Pointer to user's data.
+ *
+ * @power_off_cb: Callback that powers off this machine. Inactive if NULL.
+ *
+ * @power_off_prepare_cb: Power-off preparation callback. All power-off
+ * preparation callbacks are invoked after @reboot_prepare_cb and before
+ * @power_off_cb. Inactive if NULL.
+ *
+ * @power_off_priority: Power-off callback priority, must be unique.
+ * Zero value is reserved and auto-reassigned to POWEROFF_PRIO_DEFAULT.
+ * Inactive if @power_off_cb is NULL.
+ *
+ * @power_off_chaining_allowed: Set to false if callback's execution should
+ * stop when @power_off_cb fails to power off this machine. True if further
+ * lower priority power-off callback should be executed. False is default
+ * value.
+ *
+ * @restart_cb: Callback that reboots this machine. Inactive if NULL.
+ *
+ * @restart_priority: Restart callback priority, must be unique. Zero value
+ * is reserved and auto-reassigned to RESTART_PRIO_DEFAULT. Inactive if
+ * @restart_cb is NULL.
+ *
+ * @restart_chaining_disallowed: Set to true if callback's execution should
+ * stop when @restart_cb fails to restart this machine. False if further
+ * lower priority restart callback should be executed. False is default
+ * value.
+ *
+ * @reboot_prepare_cb: Reboot/shutdown preparation callback. All reboot
+ * preparation callbacks are invoked before @restart_cb or @power_off_cb,
+ * depending on the mode. It's registered with register_reboot_notifier().
+ * The point is to remove boilerplate code from drivers which use this
+ * callback in conjunction with the restart/power-off callbacks.
+ *
+ * @reboot_priority: Reboot/shutdown preparation callback priority, doesn't
+ * need to be unique. Zero is default value. Inactive if @reboot_prepare_cb
+ * is NULL.
+ *
+ * @priv: Internal data. Shouldn't be touched.
+ *
+ * Describes power-off and restart handlers which are invoked by kernel
+ * to power off or restart this machine. Supports prioritized chaining for
+ * both restart and power-off handlers.
+ *
+ * Struct sys_off_handler can be static. Members of this structure must not be
+ * altered while handler is registered.
+ *
+ * Fill the structure members and pass it to @register_sys_off_handler().
+ */
+struct sys_off_handler {
+	void *cb_data;
+
+	void (*power_off_cb)(struct power_off_data *data);
+	void (*power_off_prepare_cb)(struct power_off_prep_data *data);
+	int power_off_priority;
+	bool power_off_chaining_allowed;
+
+	void (*restart_cb)(struct restart_data *data);
+	int restart_priority;
+	bool restart_chaining_disallowed;
+
+	void (*reboot_prepare_cb)(struct reboot_prep_data *data);
+	int reboot_priority;
+
+	const struct sys_off_handler_private_data priv;
+};
+
+int register_sys_off_handler(struct sys_off_handler *handler);
+int unregister_sys_off_handler(struct sys_off_handler *handler);
+
+int devm_register_sys_off_handler(struct device *dev,
+				  struct sys_off_handler *handler);
+
+int devm_register_prioritized_power_off_handler(struct device *dev,
+						int priority,
+						void (*callback)(void *data),
+						void *cb_data);
+
+/**
+ *	devm_register_simple_power_off_handler - Register simple power-off callback
+ *	@dev: Device that registers callback
+ *	@callback: Callback function
+ *	@cb_data: Callback's argument
+ *
+ *	Registers resource-managed power-off callback with default priority.
+ *	It will be invoked as last step of the power-off sequence. Further
+ *	lower priority callbacks won't be executed if this @callback fails.
+ *
+ *	Returns zero on success, or error code on failure.
+ */
+static inline int
+devm_register_simple_power_off_handler(struct device *dev,
+				       void (*callback)(void *data),
+				       void *cb_data)
+{
+	return devm_register_prioritized_power_off_handler(dev,
+							   POWEROFF_PRIO_DEFAULT,
+							   callback, cb_data);
+}
+
+int register_platform_power_off(void (*power_off)(void));
+int unregister_platform_power_off(void (*power_off)(void));
+
+int devm_register_prioritized_restart_handler(struct device *dev,
+					      int priority,
+					      void (*callback)(struct restart_data *data),
+					      void *cb_data);
+
+/**
+ *	devm_register_simple_restart_handler - Register simple restart callback
+ *	@dev: Device that registers callback
+ *	@callback: Callback function
+ *	@cb_data: Callback's argument
+ *
+ *	Registers resource-managed restart callback with default priority.
+ *	It will be invoked as a part of the restart sequence. Further
+ *	lower priority callback will be executed if this @callback fails.
+ *
+ *	Returns zero on success, or error code on failure.
+ */
+static inline int
+devm_register_simple_restart_handler(struct device *dev,
+				     void (*callback)(struct restart_data *data),
+				     void *cb_data)
+{
+	return devm_register_prioritized_restart_handler(dev,
+							 RESTART_PRIO_DEFAULT,
+							 callback, cb_data);
+}
+
+void do_kernel_power_off(void);
+
 /*
  * Architecture-specific implementations of sys_reboot commands.
  */
@@ -70,6 +326,7 @@ extern void kernel_restart_prepare(char *cmd);
 extern void kernel_restart(char *cmd);
 extern void kernel_halt(void);
 extern void kernel_power_off(void);
+extern bool kernel_can_power_off(void);
 
 extern int C_A_D; /* for sysctl */
 void ctrl_alt_del(void);
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index a94044197c4a..aace22f7a031 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -665,7 +665,7 @@ static void power_down(void)
 		hibernation_platform_enter();
 		fallthrough;
 	case HIBERNATION_SHUTDOWN:
-		if (pm_power_off)
+		if (kernel_can_power_off())
 			kernel_power_off();
 		break;
 	}
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 35f0cde641c1..1ae5ba86b150 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -296,6 +296,546 @@ void kernel_halt(void)
 }
 EXPORT_SYMBOL_GPL(kernel_halt);
 
+/*
+ *	Notifier list for kernel code which wants to be called
+ *	to power off the system.
+ */
+static BLOCKING_NOTIFIER_HEAD(power_off_handler_list);
+
+/*
+ * Temporary stub that prevents linkage failure while we're in process
+ * of removing all uses of legacy pm_power_off() around the kernel.
+ */
+void __weak (*pm_power_off)(void);
+
+static void dummy_pm_power_off(void)
+{
+	/* temporary stub until pm_power_off() is gone, see more below */
+}
+
+static struct notifier_block *pm_power_off_nb;
+
+/**
+ *	register_power_off_handler - Register function to be called to power off
+ *				     the system
+ *	@nb: Info about handler function to be called
+ *	@nb->priority:	Handler priority. Handlers should follow the
+ *			following guidelines for setting priorities.
+ *			0:	Reserved
+ *			1:	Power-off handler of last resort,
+ *				with limited power-off capabilities
+ *			128:	Default power-off handler; use if no other
+ *				power-off handler is expected to be available,
+ *				and/or if power-off functionality is
+ *				sufficient to power-off the entire system
+ *			255:	Highest priority power-off handler, will
+ *				preempt all other power-off handlers
+ *
+ *	Registers a function with code to be called to power off the
+ *	system.
+ *
+ *	Registered functions will be called as last step of the power-off
+ *	sequence.
+ *
+ *	Registered functions are expected to power off the system immediately.
+ *	If more than one function is registered, the power-off handler priority
+ *	selects which function will be called first.
+ *
+ *	Power-off handlers are expected to be registered from non-architecture
+ *	code, typically from drivers. A typical use case would be a system
+ *	where power-off functionality is provided through a PMIC. Multiple
+ *	power-off handlers may exist; for example, one power-off handler might
+ *	turn off the entire system, while another only turns off part of
+ *	system. In such cases, the power-off handler which only disables part
+ *	of the hardware is expected to register with low priority to ensure
+ *	that it only runs if no other means to power off the system is
+ *	available.
+ *
+ *	Currently always returns zero, as blocking_notifier_chain_register()
+ *	always returns zero.
+ */
+static int register_power_off_handler(struct notifier_block *nb)
+{
+	int ret;
+
+	ret = blocking_notifier_chain_register_unique_prio(&power_off_handler_list, nb);
+	if (ret && ret != -EBUSY)
+		return ret;
+
+	if (!ret)
+		goto set_pm_power_off;
+
+	/*
+	 * Handler must have unique priority. Otherwise call order is
+	 * determined by registration order, which is unreliable.
+	 *
+	 * This requirement will become mandatory once all drivers
+	 * will be converted to use new sys-off API.
+	 */
+	pr_err("failed to register power-off handler using unique priority\n");
+
+	ret = blocking_notifier_chain_register(&power_off_handler_list, nb);
+	if (ret)
+		return ret;
+
+	/*
+	 * Some drivers check whether pm_power_off was already installed.
+	 * Install dummy callback using new API to preserve old behaviour
+	 * for those drivers during period of transition to the new API.
+	 */
+set_pm_power_off:
+	if (!pm_power_off) {
+		pm_power_off = dummy_pm_power_off;
+		pm_power_off_nb = nb;
+	}
+
+	return 0;
+}
+
+static int unregister_power_off_handler(struct notifier_block *nb)
+{
+	if (nb == pm_power_off_nb) {
+		if (pm_power_off == dummy_pm_power_off)
+			pm_power_off = NULL;
+
+		pm_power_off_nb = NULL;
+	}
+
+	return blocking_notifier_chain_unregister(&power_off_handler_list, nb);
+}
+
+static void devm_unregister_power_off_handler(void *data)
+{
+	struct notifier_block *nb = data;
+
+	unregister_power_off_handler(nb);
+}
+
+static int devm_register_power_off_handler(struct device *dev,
+					   struct notifier_block *nb)
+{
+	int err;
+
+	err = register_power_off_handler(nb);
+	if (err)
+		return err;
+
+	return devm_add_action_or_reset(dev, devm_unregister_power_off_handler,
+					nb);
+}
+
+static int sys_off_handler_power_off(struct notifier_block *nb,
+				     unsigned long mode, void *unused)
+{
+	struct power_off_prep_data prep_data = {};
+	struct sys_off_handler_private_data *priv;
+	struct power_off_data data = {};
+	struct sys_off_handler *h;
+	int ret = NOTIFY_DONE;
+
+	priv = container_of(nb, struct sys_off_handler_private_data, power_off_nb);
+	h = container_of(priv, struct sys_off_handler, priv);
+	prep_data.cb_data = h->cb_data;
+	data.cb_data = h->cb_data;
+
+	switch (mode) {
+	case POWEROFF_NORMAL:
+		if (h->power_off_cb)
+			h->power_off_cb(&data);
+
+		if (priv->simple_power_off_cb)
+			priv->simple_power_off_cb(priv->simple_power_off_cb_data);
+
+		if (priv->platform_power_off_cb)
+			priv->platform_power_off_cb();
+
+		if (!h->power_off_chaining_allowed)
+			ret = NOTIFY_STOP;
+
+		break;
+
+	case POWEROFF_PREPARE:
+		if (h->power_off_prepare_cb)
+			h->power_off_prepare_cb(&prep_data);
+
+		break;
+
+	default:
+		unreachable();
+	}
+
+	return ret;
+}
+
+static int sys_off_handler_restart(struct notifier_block *nb,
+				   unsigned long mode, void *cmd)
+{
+	struct sys_off_handler_private_data *priv;
+	struct restart_data data = {};
+	struct sys_off_handler *h;
+
+	priv = container_of(nb, struct sys_off_handler_private_data, restart_nb);
+	h = container_of(priv, struct sys_off_handler, priv);
+
+	data.stop_chain = h->restart_chaining_disallowed;
+	data.cb_data = h->cb_data;
+	data.mode = mode;
+	data.cmd = cmd;
+
+	h->restart_cb(&data);
+
+	return data.stop_chain ? NOTIFY_STOP : NOTIFY_DONE;
+}
+
+static int sys_off_handler_reboot(struct notifier_block *nb,
+				  unsigned long mode, void *cmd)
+{
+	struct sys_off_handler_private_data *priv;
+	struct reboot_prep_data data = {};
+	struct sys_off_handler *h;
+
+	priv = container_of(nb, struct sys_off_handler_private_data, reboot_nb);
+	h = container_of(priv, struct sys_off_handler, priv);
+
+	data.cb_data = h->cb_data;
+	data.stop_chain = false;
+	data.mode = mode;
+	data.cmd = cmd;
+
+	h->reboot_prepare_cb(&data);
+
+	return data.stop_chain ? NOTIFY_STOP : NOTIFY_DONE;
+}
+
+static struct sys_off_handler_private_data *
+sys_off_handler_private_data(struct sys_off_handler *handler)
+{
+	return (struct sys_off_handler_private_data *)&handler->priv;
+}
+
+/**
+ *	devm_register_sys_off_handler - Register system power-off/restart handler
+ *	@dev: Device that registers handler
+ *	@handler: System-off handler
+ *
+ *	Registers handler that will be called as last step of the power-off
+ *	and restart sequences.
+ *
+ *	Returns zero on success, or error code on failure.
+ */
+int register_sys_off_handler(struct sys_off_handler *handler)
+{
+	struct sys_off_handler_private_data *priv;
+	int err, priority;
+
+	priv = sys_off_handler_private_data(handler);
+
+	/* sanity-check whether handler is registered twice */
+	if (priv->registered)
+		return -EBUSY;
+
+	if (handler->power_off_cb || handler->power_off_prepare_cb) {
+		if (handler->power_off_priority == POWEROFF_PRIO_RESERVED)
+			priority = POWEROFF_PRIO_DEFAULT;
+		else
+			priority = handler->power_off_priority;
+
+		priv->power_off_nb.notifier_call = sys_off_handler_power_off;
+		priv->power_off_nb.priority = priority;
+
+		err = register_power_off_handler(&priv->power_off_nb);
+		if (err)
+			goto reset_sys_off_handler;
+	}
+
+	if (handler->restart_cb) {
+		if (handler->restart_priority == RESTART_PRIO_RESERVED)
+			priority = RESTART_PRIO_DEFAULT;
+		else
+			priority = handler->restart_priority;
+
+		priv->restart_nb.notifier_call = sys_off_handler_restart;
+		priv->restart_nb.priority = priority;
+
+		err = register_restart_handler(&priv->restart_nb);
+		if (err)
+			goto unreg_power_off_handler;
+	}
+
+	if (handler->reboot_prepare_cb) {
+		priv->reboot_nb.notifier_call = sys_off_handler_reboot;
+		priv->reboot_nb.priority = handler->reboot_priority;
+
+		err = register_reboot_notifier(&priv->reboot_nb);
+		if (err)
+			goto unreg_restart_handler;
+	}
+
+	priv->registered = true;
+
+	return 0;
+
+unreg_restart_handler:
+	if (handler->restart_cb)
+		unregister_restart_handler(&priv->restart_nb);
+
+unreg_power_off_handler:
+	if (handler->power_off_cb)
+		unregister_power_off_handler(&priv->power_off_nb);
+
+reset_sys_off_handler:
+	memset(priv, 0, sizeof(*priv));
+
+	return err;
+}
+EXPORT_SYMBOL(register_sys_off_handler);
+
+/**
+ *	unregister_sys_off_handler - Unregister system power-off/restart handler
+ *	@handler: System-off handler
+ *
+ *	Unregisters sys-off handler. Does nothing and returns zero if handler
+ *	is NULL.
+ *
+ *	Returns zero on success, or error code on failure.
+ */
+int unregister_sys_off_handler(struct sys_off_handler *handler)
+{
+	struct sys_off_handler_private_data *priv;
+
+	if (!handler)
+		return 0;
+
+	priv = sys_off_handler_private_data(handler);
+
+	/* sanity-check whether handler is unregistered twice */
+	if (!priv->registered)
+		return -EINVAL;
+
+	if (handler->reboot_prepare_cb)
+		unregister_reboot_notifier(&priv->reboot_nb);
+
+	if (handler->restart_cb)
+		unregister_restart_handler(&priv->restart_nb);
+
+	if (handler->power_off_cb)
+		unregister_power_off_handler(&priv->power_off_nb);
+
+	memset(priv, 0, sizeof(*priv));
+
+	return 0;
+}
+EXPORT_SYMBOL(unregister_sys_off_handler);
+
+static void devm_unregister_sys_off_handler(void *data)
+{
+	struct sys_off_handler *handler = data;
+
+	unregister_sys_off_handler(handler);
+}
+
+/**
+ *	devm_register_sys_off_handler - Register system power-off/restart handler
+ *	@dev: Device that registers handler
+ *	@handler: System-off handler
+ *
+ *	Resource-managed variant of register_sys_off_handler().
+ *
+ *	Returns zero on success, or error code on failure.
+ */
+int devm_register_sys_off_handler(struct device *dev,
+				  struct sys_off_handler *handler)
+{
+	int err;
+
+	err = register_sys_off_handler(handler);
+	if (err)
+		return err;
+
+	return devm_add_action_or_reset(dev, devm_unregister_sys_off_handler,
+					handler);
+}
+EXPORT_SYMBOL(devm_register_sys_off_handler);
+
+/**
+ *	devm_register_prioritized_power_off_handler - Register prioritized power-off callback
+ *	@dev: Device that registers callback
+ *	@priority: Callback's priority
+ *	@callback: Callback function
+ *	@cb_data: Callback's argument
+ *
+ *	Registers resource-managed power-off callback with a given priority.
+ *	It will be called as last step of the power-off sequence. Callbacks
+ *	chaining is disabled, i.e. further lower priority callbacks won't
+ *	be executed if this @callback will fail to execute.
+ *
+ *	Returns zero on success, or error code on failure.
+ */
+int devm_register_prioritized_power_off_handler(struct device *dev,
+						int priority,
+						void (*callback)(void *data),
+						void *cb_data)
+{
+	struct sys_off_handler_private_data *priv;
+	struct sys_off_handler *handler;
+
+	handler = devm_kzalloc(dev, sizeof(*handler), GFP_KERNEL);
+	if (!handler)
+		return -ENOMEM;
+
+	if (priority == POWEROFF_PRIO_RESERVED)
+		priority = POWEROFF_PRIO_DEFAULT;
+
+	priv = sys_off_handler_private_data(handler);
+
+	priv->power_off_nb.notifier_call = sys_off_handler_power_off;
+	priv->power_off_nb.priority = priority;
+	priv->simple_power_off_cb_data = cb_data;
+	priv->simple_power_off_cb = callback;
+
+	return devm_register_power_off_handler(dev, &priv->power_off_nb);
+}
+EXPORT_SYMBOL(devm_register_prioritized_power_off_handler);
+
+/**
+ *	devm_register_prioritized_restart_handler - Register prioritized restart callback
+ *	@dev: Device that registers callback
+ *	@priority: Callback's priority
+ *	@callback: Callback function
+ *	@cb_data: Callback's argument
+ *
+ *	Registers resource-managed restart callback with a given priority.
+ *	It will be called as a part of the restart sequence. Callbacks
+ *	chaining is disabled, i.e. further lower priority callbacks won't
+ *	be executed if this @callback will fail to execute.
+ *
+ *	Returns zero on success, or error code on failure.
+ */
+int devm_register_prioritized_restart_handler(struct device *dev,
+					      int priority,
+					      void (*callback)(struct restart_data *data),
+					      void *cb_data)
+{
+	struct sys_off_handler *handler;
+
+	handler = devm_kzalloc(dev, sizeof(*handler), GFP_KERNEL);
+	if (!handler)
+		return -ENOMEM;
+
+	if (priority == RESTART_PRIO_RESERVED)
+		priority = RESTART_PRIO_DEFAULT;
+
+	handler->restart_priority = priority;
+	handler->restart_cb = callback;
+	handler->cb_data = cb_data;
+
+	return devm_register_sys_off_handler(dev, handler);
+}
+EXPORT_SYMBOL(devm_register_prioritized_restart_handler);
+
+static struct sys_off_handler platform_power_off_handler = {
+	.priv = {
+		.power_off_nb = {
+			.notifier_call = sys_off_handler_power_off,
+			.priority = POWEROFF_PRIO_PLATFORM,
+		},
+	},
+};
+
+static DEFINE_SPINLOCK(platform_power_off_lock);
+
+/**
+ *	register_platform_power_off - Register platform-level power-off callback
+ *	@power_off: Power-off callback
+ *
+ *	Registers power-off callback that will be called as last step
+ *	of the power-off sequence. This callback is expected to be invoked
+ *	for the last resort. Further lower priority callbacks won't be
+ *	executed if @power_off fails. Only one platform power-off callback
+ *	is allowed to be registered at a time.
+ *
+ *	Returns zero on success, or error code on failure.
+ */
+int register_platform_power_off(void (*power_off)(void))
+{
+	struct sys_off_handler_private_data *priv;
+	int ret = 0;
+
+	priv = sys_off_handler_private_data(&platform_power_off_handler);
+
+	spin_lock(&platform_power_off_lock);
+	if (priv->platform_power_off_cb)
+		ret = -EBUSY;
+	else
+		priv->platform_power_off_cb = power_off;
+	spin_unlock(&platform_power_off_lock);
+
+	if (ret)
+		return ret;
+
+	ret = register_power_off_handler(&priv->power_off_nb);
+	if (ret)
+		priv->platform_power_off_cb = NULL;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(register_platform_power_off);
+
+/**
+ *	unregister_platform_power_off - Unregister platform-level power-off callback
+ *	@power_off: Power-off callback
+ *
+ *	Unregisters previously registered platform power-off callback.
+ *
+ *	Returns zero on success, or error code on failure.
+ */
+int unregister_platform_power_off(void (*power_off)(void))
+{
+	struct sys_off_handler_private_data *priv;
+	int ret;
+
+	priv = sys_off_handler_private_data(&platform_power_off_handler);
+
+	if (priv->platform_power_off_cb != power_off)
+		return -EINVAL;
+
+	ret = unregister_power_off_handler(&priv->power_off_nb);
+	priv->platform_power_off_cb = NULL;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(unregister_platform_power_off);
+
+/**
+ *	do_kernel_power_off - Execute kernel power-off handler call chain
+ *
+ *	Calls functions registered with register_power_off_handler.
+ *
+ *	Expected to be called as last step of the power-off sequence.
+ *
+ *	Powers off the system immediately if a power-off handler function has
+ *	been registered. Otherwise does nothing.
+ */
+void do_kernel_power_off(void)
+{
+	/* legacy pm_power_off() is unchained and has highest priority */
+	if (pm_power_off && pm_power_off != dummy_pm_power_off)
+		return pm_power_off();
+
+	blocking_notifier_call_chain(&power_off_handler_list, POWEROFF_NORMAL,
+				     NULL);
+}
+
+static void do_kernel_power_off_prepare(void)
+{
+	/* legacy pm_power_off_prepare() is unchained and has highest priority */
+	if (pm_power_off_prepare)
+		return pm_power_off_prepare();
+
+	blocking_notifier_call_chain(&power_off_handler_list, POWEROFF_PREPARE,
+				     NULL);
+}
+
 /**
  *	kernel_power_off - power_off the system
  *
@@ -304,8 +844,7 @@ EXPORT_SYMBOL_GPL(kernel_halt);
 void kernel_power_off(void)
 {
 	kernel_shutdown_prepare(SYSTEM_POWER_OFF);
-	if (pm_power_off_prepare)
-		pm_power_off_prepare();
+	do_kernel_power_off_prepare();
 	migrate_to_reboot_cpu();
 	syscore_shutdown();
 	pr_emerg("Power down\n");
@@ -314,6 +853,16 @@ void kernel_power_off(void)
 }
 EXPORT_SYMBOL_GPL(kernel_power_off);
 
+bool kernel_can_power_off(void)
+{
+	if (!pm_power_off &&
+	    blocking_notifier_call_chain_is_empty(&power_off_handler_list))
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(kernel_can_power_off);
+
 DEFINE_MUTEX(system_transition_mutex);
 
 /*
@@ -355,7 +904,7 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 	/* Instead of trying to make the power_off code look like
 	 * halt when pm_power_off is not set do it the easy way.
 	 */
-	if ((cmd == LINUX_REBOOT_CMD_POWER_OFF) && !pm_power_off)
+	if (cmd == LINUX_REBOOT_CMD_POWER_OFF && !kernel_can_power_off())
 		cmd = LINUX_REBOOT_CMD_HALT;
 
 	mutex_lock(&system_transition_mutex);
-- 
2.34.1

