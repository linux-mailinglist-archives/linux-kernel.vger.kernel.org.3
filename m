Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A464FBB92
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345926AbiDKMEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242881AbiDKMEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:04:38 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4189B37BEA;
        Mon, 11 Apr 2022 05:02:24 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 2CDB6809F;
        Mon, 11 Apr 2022 11:59:51 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] serial: core: Start managing serial controllers to enable runtime PM
Date:   Mon, 11 Apr 2022 15:02:18 +0300
Message-Id: <20220411120218.17422-1-tony@atomide.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to enable runtime PM for serial port device drivers in a generic
way. To do this, we want to have the serial core layer manage the
registered serial port controllers. For runtime PM, we need a way to find
the serial ports for each serial port controller device.

The serial core manages ports. Each serial controller can have multiple
ports. As serial core has no struct device, and the serial port device
drivers have their own driver data, we cannot currently start making
use of serial core generic data easily without changing all the serial
port device drivers.

We could consider adding a serial core specific struct device. It would
be a child of the serial port device, and would allow us eventually to use
device_links to add generic runtime PM calls for example. But as the serial
core layer is not a device driver, driver specific features would need to
be added, and are probably not justified for a virtual device.

Considering the above, let's improve the serial core layer so we can
manage the serial port controllers better. Let's register the controllers
with the serial core layer in addition to the serial ports.

To find the serial ports for a controller based on struct device, let's
add a new data structure for a serial_controller. Let's add the registered
devices into a radix_tree so we can look up the controller easily even
with many controllers registered. This allows us to keep track of the
runtime PM state for each serial port controller device.

As some serial port device drivers enable runtime PM in their probe before
registering with the serial core layer, and some do not enable runtime PM
at all currently, we need check the state in the serial core layer on
uart_port_startup(). We need to also consider that a serial port device
may have multiple ports.

Initially we just want to enable runtime PM for all the serial port
controller devices. This allows us to add runtime PM calls and properly
handle any errors without a need for serial layer specific runtime PM
wrapper functions.

After this patch no functional changes for the serial port device drivers
are intended. For most cases, we just enable runtime PM and keep the
runtime PM usage count until all the serial controller ports are
unregistered. For drivers implementing runtime PM, we just keep track of
the configuration.

The serial core layer has the following use cases to deal with:

- If a serial port device driver does not implement runtime PM, the
  device state is set to active state, and the runtime PM usage count
  is kept until the last port for a device is unregistered

- If a serial port device driver implements runtime PM, the runtime PM
  usage count is kept until the last port for the device is unregistered

- If a serial port device driver implements runtime PM autosuspend,
  autosuspend is not prevented. This currently gets set only for the
  8250_omap driver to keep runtime PM working for it

For system suspend, things should be mostly detached from the runtime PM.
The serial port device drivers may call pm_runtime_force_suspend() and
pm_runtime_force_resume() as needed.

Suggested-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/8250/8250_core.c |   1 +
 drivers/tty/serial/8250/8250_omap.c |   1 +
 drivers/tty/serial/serial_core.c    | 181 ++++++++++++++++++++++++++++
 include/linux/serial_core.h         |   3 +
 4 files changed, 186 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -996,6 +996,7 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 		uart->port.regshift     = up->port.regshift;
 		uart->port.iotype       = up->port.iotype;
 		uart->port.flags        = up->port.flags | UPF_BOOT_AUTOCONF;
+		uart->port.supports_autosuspend = up->port.supports_autosuspend;
 		uart->bugs		= up->bugs;
 		uart->port.mapbase      = up->port.mapbase;
 		uart->port.mapsize      = up->port.mapsize;
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1338,6 +1338,7 @@ static int omap8250_probe(struct platform_device *pdev)
 	up.rs485_start_tx = serial8250_em485_start_tx;
 	up.rs485_stop_tx = serial8250_em485_stop_tx;
 	up.port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
+	up.port.supports_autosuspend = 1;
 
 	ret = of_alias_get_id(np, "serial");
 	if (ret < 0) {
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -16,7 +16,9 @@
 #include <linux/console.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
+#include <linux/pm_runtime.h>
 #include <linux/proc_fs.h>
+#include <linux/radix-tree.h>
 #include <linux/seq_file.h>
 #include <linux/device.h>
 #include <linux/serial.h> /* for serial_state and serial_icounter_struct */
@@ -29,6 +31,25 @@
 #include <linux/irq.h>
 #include <linux/uaccess.h>
 
+/*
+ * Serial port device specific data for serial core.
+ *
+ * Each port device can have multiple ports with struct uart_state allocated
+ * for each port. The array of ports is kept in struct uart_driver.
+ */
+struct serial_controller {
+	struct uart_driver *drv;		/* For port specific uart_state */
+	struct mutex lock;			/* For changing enabled_count */
+	int enabled_count;			/* Enable count for runtime PM */
+	unsigned long implements_pm_runtime:1;
+	unsigned long supports_autosuspend:1;
+};
+
+/*
+ * Serial core port device instances. Update protected by port_mutex.
+ */
+static RADIX_TREE(serial_core_devices, GFP_NOWAIT);
+
 /*
  * This is used to lock changes in serial line configuration.
  */
@@ -169,6 +190,151 @@ static void uart_port_dtr_rts(struct uart_port *uport, int raise)
 		uart_clear_mctrl(uport, TIOCM_DTR | TIOCM_RTS);
 }
 
+/* Called from uart_add_one_port() with port_mutex held */
+static int serial_core_register_port(struct uart_port *port,
+				     struct uart_driver *drv)
+{
+	unsigned long idx = (unsigned long)port->dev;
+	struct serial_controller *controller;
+
+	if (!idx)
+		return 0;
+
+	controller = radix_tree_lookup(&serial_core_devices, idx);
+	if (controller) {
+		port->state->controller = controller;
+		WARN_ON(port->supports_autosuspend !=
+			controller->supports_autosuspend);
+		return 0;
+	}
+
+	controller = kzalloc(sizeof(*controller), GFP_KERNEL);
+	if (!controller)
+		return -ENOMEM;
+
+	mutex_init(&controller->lock);
+	controller->drv = drv;
+	controller->supports_autosuspend = port->supports_autosuspend;
+	port->state->controller = controller;
+
+	return radix_tree_insert(&serial_core_devices, idx, controller);
+}
+
+/* Called from uart_add/remove_one_port() with port_mutex held */
+static void serial_core_unregister_port(struct uart_port *port)
+{
+	unsigned long idx = (unsigned long)port->dev;
+	struct serial_controller *controller;
+
+	if (!idx)
+		return;
+
+	controller = radix_tree_lookup(&serial_core_devices, idx);
+	if (!controller)
+		return;
+
+	controller = radix_tree_delete(&serial_core_devices, idx);
+	if (!controller)
+		return;
+
+	kfree(controller);
+}
+
+/* Called from uart_port_startup() */
+static int serial_core_pm_runtime_start(struct uart_port *port)
+{
+	struct serial_controller *controller;
+	struct device *dev = port->dev;
+	struct uart_state *state;
+	int ret = 0;
+
+	if (!dev)
+		return 0;
+
+	state = port->state;
+	controller = state->controller;
+	if (!controller)
+		return 0;
+
+	mutex_lock(&controller->lock);
+
+	if (controller->enabled_count)
+		goto out_enabled;
+
+	/* Always enable autosuspend and consider child devices for serdev */
+	pm_runtime_use_autosuspend(dev);
+	pm_suspend_ignore_children(dev, false);
+
+	/*
+	 * If the port driver did not enable runtime PM in probe, do it now.
+	 * Devices that did not enable runtime PM get set active so we can
+	 * properly handle the returned errors for runtime PM calls.
+	 */
+	if (!pm_runtime_enabled(dev)) {
+		pm_runtime_set_active(dev);
+		pm_runtime_enable(dev);
+	} else {
+		controller->implements_pm_runtime = 1;
+	}
+
+	/*
+	 * Keep the port device enabled unless autosuspend is supported.
+	 * Released on port shutdown.
+	 */
+	if (!controller->supports_autosuspend) {
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret < 0) {
+			pm_runtime_dont_use_autosuspend(dev);
+			pm_runtime_disable(dev);
+			goto out_unlock;
+		}
+	}
+
+out_enabled:
+	controller->enabled_count++;
+
+out_unlock:
+	mutex_unlock(&controller->lock);
+
+	return ret;
+}
+
+/* Called from uart_shutdown() */
+static void serial_core_pm_runtime_stop(struct uart_port *port)
+{
+	struct serial_controller *controller;
+	struct device *dev = port->dev;
+	struct uart_state *state;
+
+	if (!dev)
+		return;
+
+	state = port->state;
+	controller = state->controller;
+	if (!controller)
+		return;
+
+	mutex_lock(&controller->lock);
+
+	controller->enabled_count--;
+
+	if (controller->enabled_count)
+		goto out_unlock;
+
+	/* Last caller, undo the runtime PM settings done on startup */
+	pm_runtime_dont_use_autosuspend(dev);
+	pm_suspend_ignore_children(dev, true);
+	if (!controller->supports_autosuspend)
+		pm_runtime_put_sync(dev);
+	if (!controller->implements_pm_runtime) {
+		pm_runtime_set_suspended(dev);
+		pm_runtime_disable(dev);
+	}
+
+out_unlock:
+	mutex_unlock(&controller->lock);
+}
+
 /*
  * Startup the port.  This will be called once per open.  All calls
  * will be serialised by the per-port mutex.
@@ -184,6 +350,10 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
 	if (uport->type == PORT_UNKNOWN)
 		return 1;
 
+	retval = serial_core_pm_runtime_start(uport);
+	if (retval)
+		return retval;
+
 	/*
 	 * Make sure the device is in D0 state.
 	 */
@@ -306,6 +476,9 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 	 */
 	tty_port_set_suspended(port, 0);
 
+	/* Runtime PM paired with configuration done in uart_port_startup() */
+	serial_core_pm_runtime_stop(uport);
+
 	/*
 	 * Do not free() the transmit buffer page under the port lock since
 	 * this can create various circular locking scenarios. For instance,
@@ -2907,6 +3080,10 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 		goto out;
 	}
 
+	ret = serial_core_register_port(uport, drv);
+	if (ret)
+		goto out;
+
 	/*
 	 * If this port is in use as a console then the spinlock is already
 	 * initialised.
@@ -2930,6 +3107,7 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 				    GFP_KERNEL);
 	if (!uport->tty_groups) {
 		ret = -ENOMEM;
+		serial_core_unregister_port(uport);
 		goto out;
 	}
 	uport->tty_groups[0] = &tty_dev_attr_group;
@@ -2999,6 +3177,9 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
 		goto out;
 	}
 	uport->flags |= UPF_DEAD;
+
+	serial_core_unregister_port(uport);
+
 	mutex_unlock(&port->mutex);
 
 	/*
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -249,6 +249,7 @@ struct uart_port {
 	unsigned char		hub6;			/* this should be in the 8250 driver */
 	unsigned char		suspended;
 	unsigned char		console_reinit;
+	unsigned long		supports_autosuspend:1;
 	const char		*name;			/* port name */
 	struct attribute_group	*attr_group;		/* port specific attributes */
 	const struct attribute_group **tty_groups;	/* all attributes (serial core use only) */
@@ -284,6 +285,8 @@ enum uart_pm_state {
  * This is the state information which is persistent across opens.
  */
 struct uart_state {
+	struct serial_controller *controller;
+
 	struct tty_port		port;
 
 	enum uart_pm_state	pm_state;
-- 
2.35.1
