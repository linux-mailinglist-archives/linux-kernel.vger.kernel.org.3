Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6D7547AC8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 17:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237727AbiFLP0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 11:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237653AbiFLP0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 11:26:40 -0400
Received: from mail.enpas.org (zhong.enpas.org [IPv6:2a03:4000:2:537::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9170E5F244;
        Sun, 12 Jun 2022 08:26:35 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id E67ACFF9E2;
        Sun, 12 Jun 2022 15:26:33 +0000 (UTC)
From:   Max Staudt <max@enpas.org>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Mailhol <vincent.mailhol@gmail.com>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v8] can, tty: can327 CAN/ldisc driver for ELM327 based OBD-II adapters
Date:   Sun, 12 Jun 2022 17:26:01 +0200
Message-Id: <20220612152601.142314-1-max@enpas.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the can327 driver. It does a surprisingly good job at turning
ELM327 based OBD-II interfaces into cheap CAN interfaces for simple
homebrew projects.

Please see the included documentation for details and limitations:
Documentation/networking/device_drivers/can/can327.rst

Cc: linux-can <linux-can@vger.kernel.org>
Signed-off-by: Max Staudt <max@enpas.org>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
After a through review (thanks to Vincent Mailhol), this is hopefully
the last version of the can327 upstreaming patch.

Thanks to everyone involved!


Changes in v8:
 - Rebased on linux-can-next
 - Added "select CAN_RX_OFFLOAD" to Kconfig
 - Removed CAN_CTRLMODE_LISTENONLY check, can_dropped_invalid_skb() does it.
 - Removed CAN specific LED code.
 - Print number of unhandled UART RX bytes on buffer overflow.
 - The RX buffer is now 1024 bytes to handle huge buffers, such as
   those found on FTDI USB-Serial bridges. In case the buffer is
   ever too small again, this printk might give us a hint whether
   it's truly a buffer sizing problem, or the buffer filling up
   with garbage.
   Thanks to frankiej911 for reporting and testing.
 - Fixed memory leak in elm327_parse_frame() error cases.
   Thanks Vincent!
 - Don't count RTR frame DLC towards tx_bytes.
 - Cleaned up can327.rst, as suggested by Vincent.
 - Cleaned up stale includes and comments and array indices.

Changes in v7:
 - Accelerate parsing by not re-checking previous data
     While waiting for a <CR> the code would search through previous
     received characters, too. Keep track of what we've already
     checked to speed this up.
 - Speed up can327_is_valid_rx_char() with a LUT
 - Make elm327_rxbuf_cmp() return bool
 - Simplify/clarify branching and locking in several places
 - Don't ____cacheline_aligned the TX buffer
 - Style and comments cleanup

Changes in v6:
 - Renamed 'elmcan' to 'can327'
 - No other changes.

Changes in v5:
 - Fixed lockdep asserts (I didn't have lockdep enabled in my build)
 - Restore: TTY wakeup request before write() in elm327_send()
 - Clear TTY wakeup on uart_side_failure
 - checkpatch style fixes
 - Repack struct elmcan

Changes in v4:
 - Rebased on top of v5.18-rc5
 - Simplified TTY locking.
     The ldisc layer already blocks our ldisc ops from running concurrently.
     No elm_get(), no RCU are needed, except locking against the TX worker.
 - Removed .hangup() ldisc op which only called .close().
     The ldisc layer calls .close() in a good place anyway.
 - Restart on netdev down/up, even after UART failure.
     This is in line with Marc's line of thinking, and there was no
     good reason not to implement it. It also cleaned up the code.
 - hw_failure is now uart_side_failure and shutdown looks closer to es58x.
 - Clarified memory/string comparisons.
     One helper function remains, but it's hopefully clear now :)
 - lockdep_assert_held() instead of comments.
 - Cleaned up types in struct elmcan and used pahole to pack it.
     unsigned instead of int, u8 instead of char, ...
 - The TX buffer is now a static part of struct elmcan. No more kmalloc().
 - Removed dummy mailbox_read() for rx_offload.
     by using can_rx_offload_add_manual() instead of can_rx_offload_add_fifo().
 - netif_wake_queue() is moved to happen as late as possible.
     Wake when the ELM327 is going into monitoring mode, not every time
     after flushing whatever UART buffer we were TX'ing.
 - Use alloc_can_skb() and avoid late allocation and copy.
 - elmcan_netdev_start_xmit(): Used can_dropped_invalid_skb().
 - Replaced ->can_dlc with ->len.
 - Clarified size of local TX buffer in elm327_handle_prompt().
 - Renamed TODO_* to ELM327_TX_DO_* and ELM_* to ELM327_STATE_*.
 - Minor string and other cleanups.
     pr_fmt, MODULE_*, unnecessary checks, ...
 - Clarified file header.

Changes in v3:
 - Now depends on c2faf737abfb for new ldisc number 30.
 - Eliminated hardcoded string lengths (GCC will work its magic).
 - Emit generic error frames if an error message couldn't be parsed.
 - Silence driver startup and init (but still announce ldattach).
 - Cleaned up comments, strings, readme.
 - Removed sole module option "accept_flaky_uart".
   I likely had EMI in earlier testing, which is gone now.
   This means we can stay strict, unless anyone objects.

Changes in v2:
 - Moved to SocketCAN's rx-offload wrapper for NAPI, thus avoiding
   packets being reordered.
 - Updated TTY ldisc code for Linux v5.17-rc3. A lot of cleanup has
   happened there lately.
 - netif_stop_queue() is called earlier in _netdev_close().
 - Minor cleanup: More helpful strings and return values.

---
 .../networking/device_drivers/can/can327.rst  |  331 +++++
 .../networking/device_drivers/can/index.rst   |    1 +
 MAINTAINERS                                   |    7 +
 drivers/net/can/Kconfig                       |   18 +
 drivers/net/can/Makefile                      |    1 +
 drivers/net/can/can327.c                      | 1145 +++++++++++++++++
 include/uapi/linux/tty.h                      |    3 +-
 7 files changed, 1505 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/networking/device_drivers/can/can327.rst
 create mode 100644 drivers/net/can/can327.c

diff --git a/Documentation/networking/device_drivers/can/can327.rst b/Documentation/networking/device_drivers/can/can327.rst
new file mode 100644
index 000000000000..b87bfbe5d51c
--- /dev/null
+++ b/Documentation/networking/device_drivers/can/can327.rst
@@ -0,0 +1,331 @@
+.. SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+
+can327: ELM327 driver for Linux SocketCAN
+==========================================
+
+Authors
+--------
+
+Max Staudt <max@enpas.org>
+
+
+
+Motivation
+-----------
+
+This driver aims to lower the initial cost for hackers interested in
+working with CAN buses.
+
+CAN adapters are expensive, few, and far between.
+ELM327 interfaces are cheap and plentiful.
+Let's use ELM327s as CAN adapters.
+
+
+
+Introduction
+-------------
+
+This driver is an effort to turn abundant ELM327 based OBD interfaces
+into full fledged (as far as possible) CAN interfaces.
+
+Since the ELM327 was never meant to be a stand alone CAN controller,
+the driver has to switch between its modes as quickly as possible in
+order to fake full-duplex operation.
+
+As such, can327 is a best effort driver. However, this is more than
+enough to implement simple request-response protocols (such as OBD II),
+and to monitor broadcast messages on a bus (such as in a vehicle).
+
+Most ELM327s come as nondescript serial devices, attached via USB or
+Bluetooth. The driver cannot recognize them by itself, and as such it
+is up to the user to attach it in form of a TTY line discipline
+(similar to PPP, SLIP, slcan, ...).
+
+This driver is meant for ELM327 versions 1.4b and up, see below for
+known limitations in older controllers and clones.
+
+
+
+Data sheet
+-----------
+
+The official data sheets can be found at ELM electronics' home page:
+
+  https://www.elmelectronics.com/
+
+
+
+How to attach the line discipline
+----------------------------------
+
+Every ELM327 chip is factory programmed to operate at a serial setting
+of 38400 baud/s, 8 data bits, no parity, 1 stopbit.
+
+If you have kept this default configuration, the line discipline can
+be attached on a command prompt as follows::
+
+    sudo ldattach \
+           --debug \
+           --speed 38400 \
+           --eightbits \
+           --noparity \
+           --onestopbit \
+           --iflag -ICRNL,INLCR,-IXOFF \
+           30 \
+           /dev/ttyUSB0
+
+To change the ELM327's serial settings, please refer to its data
+sheet. This needs to be done before attaching the line discipline.
+
+Once the ldisc is attached, the CAN interface starts out unconfigured.
+Set the speed before starting it::
+
+    # The interface needs to be down to change parameters
+    sudo ip link set can0 down
+    sudo ip link set can0 type can bitrate 500000
+    sudo ip link set can0 up
+
+500000 bit/s is a common rate for OBD-II diagnostics.
+If you're connecting straight to a car's OBD port, this is the speed
+that most cars (but not all!) expect.
+
+After this, you can set out as usual with candump, cansniffer, etc.
+
+
+
+How to check the controller version
+------------------------------------
+
+Use a terminal program to attach to the controller.
+
+After issuing the "``AT WS``" command, the controller will respond with
+its version::
+
+    >AT WS
+
+
+    ELM327 v1.4b
+
+    >
+
+Note that clones may claim to be any version they like.
+It is not indicative of their actual feature set.
+
+
+
+
+Communication example
+----------------------
+
+This is a short and incomplete introduction on how to talk to an ELM327.
+It is here to guide understanding of the controller's and the driver's
+limitation (listed below) as well as manual testing.
+
+
+The ELM327 has two modes:
+
+- Command mode
+- Reception mode
+
+In command mode, it expects one command per line, terminated by CR.
+By default, the prompt is a "``>``", after which a command can be
+entered::
+
+    >ATE1
+    OK
+    >
+
+The init script in the driver switches off several configuration options
+that are only meaningful in the original OBD scenario the chip is meant
+for, and are actually a hindrance for can327.
+
+
+When a command is not recognized, such as by an older version of the
+ELM327, a question mark is printed as a response instead of OK::
+
+    >ATUNKNOWN
+    ?
+    >
+
+At present, can327 does not evaluate this response. See the section
+below on known limitations for details.
+
+
+When a CAN frame is to be sent, the target address is configured, after
+which the frame is sent as a command that consists of the data's hex
+dump::
+
+    >ATSH123
+    OK
+    >DEADBEEF12345678
+    OK
+    >
+
+The above interaction sends the SFF frame "``DE AD BE EF 12 34 56 78``"
+with (11 bit) CAN ID ``0x123``.
+For this to function, the controller must be configured for SFF sending
+mode (using "``AT PB``", see code or datasheet).
+
+
+Once a frame has been sent and wait-for-reply mode is on (``ATR1``,
+configured on ``listen-only=off``), or when the reply timeout expires
+and the driver sets the controller into monitoring mode (``ATMA``),
+the ELM327 will send one line for each received CAN frame, consisting
+of CAN ID, DLC, and data::
+
+    123 8 DEADBEEF12345678
+
+For EFF (29 bit) CAN frames, the address format is slightly different,
+which can327 uses to tell the two apart::
+
+    12 34 56 78 8 DEADBEEF12345678
+
+The ELM327 will receive both SFF and EFF frames - the current CAN
+config (``ATPB``) does not matter.
+
+
+If the ELM327's internal UART sending buffer runs full, it will abort
+the monitoring mode, print "BUFFER FULL" and drop back into command
+mode. Note that in this case, unlike with other error messages, the
+error message may appear on the same line as the last (usually
+incomplete) data frame::
+
+    12 34 56 78 8 DEADBEEF123 BUFFER FULL
+
+
+
+Known limitations of the controller
+------------------------------------
+
+- Clone devices ("v1.5" and others)
+
+  Sending RTR frames is not supported and will be dropped silently.
+
+  Receiving RTR with DLC 8 will appear to be a regular frame with
+  the last received frame's DLC and payload.
+
+  "``AT CSM``" (CAN Silent Monitoring, i.e. don't send CAN ACKs) is
+  not supported, and is hard coded to ON. Thus, frames are not ACKed
+  while listening: "``AT MA``" (Monitor All) will always be "silent".
+  However, immediately after sending a frame, the ELM327 will be in
+  "receive reply" mode, in which it *does* ACK any received frames.
+  Once the bus goes silent, or an error occurs (such as BUFFER FULL),
+  or the receive reply timeout runs out, the ELM327 will end reply
+  reception mode on its own and can327 will fall back to "``AT MA``"
+  in order to keep monitoring the bus.
+
+  Other limitations may apply, depending on the clone and the quality
+  of its firmware.
+
+
+- All versions
+
+  No full duplex operation is supported. The driver will switch
+  between input/output mode as quickly as possible.
+
+  The length of outgoing RTR frames cannot be set. In fact, some
+  clones (tested with one identifying as "``v1.5``") are unable to
+  send RTR frames at all.
+
+  We don't have a way to get real-time notifications on CAN errors.
+  While there is a command (``AT CS``) to retrieve some basic stats,
+  we don't poll it as it would force us to interrupt reception mode.
+
+
+- Versions prior to 1.4b
+
+  These versions do not send CAN ACKs when in monitoring mode (AT MA).
+  However, they do send ACKs while waiting for a reply immediately
+  after sending a frame. The driver maximizes this time to make the
+  controller as useful as possible.
+
+  Starting with version 1.4b, the ELM327 supports the "``AT CSM``"
+  command, and the "listen-only" CAN option will take effect.
+
+
+- Versions prior to 1.4
+
+  These chips do not support the "``AT PB``" command, and thus cannot
+  change bitrate or SFF/EFF mode on-the-fly. This will have to be
+  programmed by the user before attaching the line discipline. See the
+  data sheet for details.
+
+
+- Versions prior to 1.3
+
+  These chips cannot be used at all with can327. They do not support
+  the "``AT D1``" command, which is necessary to avoid parsing conflicts
+  on incoming data, as well as distinction of RTR frame lengths.
+
+  Specifically, this allows for easy distinction of SFF and EFF
+  frames, and to check whether frames are complete. While it is possible
+  to deduce the type and length from the length of the line the ELM327
+  sends us, this method fails when the ELM327's UART output buffer
+  overruns. It may abort sending in the middle of the line, which will
+  then be mistaken for something else.
+
+
+
+Known limitations of the driver
+--------------------------------
+
+- No 8/7 timing.
+
+  ELM327 can only set CAN bitrates that are of the form 500000/n, where
+  n is an integer divisor.
+  However there is an exception: With a separate flag, it may set the
+  speed to be 8/7 of the speed indicated by the divisor.
+  This mode is not currently implemented.
+
+- No evaluation of command responses.
+
+  The ELM327 will reply with OK when a command is understood, and with ?
+  when it is not. The driver does not currently check this, and simply
+  assumes that the chip understands every command.
+  The driver is built such that functionality degrades gracefully
+  nevertheless. See the section on known limitations of the controller.
+
+- No use of hardware CAN ID filtering
+
+  An ELM327's UART sending buffer will easily overflow on heavy CAN bus
+  load, resulting in the "``BUFFER FULL``" message. Using the hardware
+  filters available through "``AT CF xxx``" and "``AT CM xxx``" would be
+  helpful here, however SocketCAN does not currently provide a facility
+  to make use of such hardware features.
+
+
+
+Rationale behind the chosen configuration
+------------------------------------------
+
+``AT E1``
+  Echo on
+
+  We need this to be able to get a prompt reliably.
+
+``AT S1``
+  Spaces on
+
+  We need this to distinguish 11/29 bit CAN addresses received.
+
+  Note:
+  We can usually do this using the line length (odd/even),
+  but this fails if the line is not transmitted fully to
+  the host (BUFFER FULL).
+
+``AT D1``
+  DLC on
+
+  We need this to tell the "length" of RTR frames.
+
+
+
+A note on CAN bus termination
+------------------------------
+
+Your adapter may have resistors soldered in which are meant to terminate
+the bus. This is correct when it is plugged into a OBD-II socket, but
+not helpful when trying to tap into the middle of an existing CAN bus.
+
+If communications don't work with the adapter connected, check for the
+termination resistors on its PCB and try removing them.
diff --git a/Documentation/networking/device_drivers/can/index.rst b/Documentation/networking/device_drivers/can/index.rst
index 0c3cc6633559..6a8a4f74fa26 100644
--- a/Documentation/networking/device_drivers/can/index.rst
+++ b/Documentation/networking/device_drivers/can/index.rst
@@ -10,6 +10,7 @@ Contents:
 .. toctree::
    :maxdepth: 2
 
+   can327
    ctu/ctucanfd-driver
    freescale/flexcan
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 05fcbea3e432..baa92958e067 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7301,6 +7301,13 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/ibm/ehea/
 
+ELM327 CAN NETWORK DRIVER
+M:	Max Staudt <max@enpas.org>
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	Documentation/networking/device_drivers/can/can327.rst
+F:	drivers/net/can/can327.c
+
 EM28XX VIDEO4LINUX DRIVER
 M:	Mauro Carvalho Chehab <mchehab@kernel.org>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index 806f15146f69..4078d0775572 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -113,6 +113,24 @@ config CAN_AT91
 	  This is a driver for the SoC CAN controller in Atmel's AT91SAM9263
 	  and AT91SAM9X5 processors.
 
+config CAN_CAN327
+	tristate "Serial / USB serial ELM327 based OBD-II Interfaces (can327)"
+	depends on TTY
+	select CAN_RX_OFFLOAD
+	help
+	  CAN driver for several 'low cost' OBD-II interfaces based on the
+	  ELM327 OBD-II interpreter chip.
+
+	  This is a best effort driver - the ELM327 interface was never
+	  designed to be used as a standalone CAN interface. However, it can
+	  still be used for simple request-response protocols (such as OBD II),
+	  and to monitor broadcast messages on a bus (such as in a vehicle).
+
+	  Please refer to the documentation for information on how to use it:
+	  Documentation/networking/device_drivers/can/can327.rst
+
+	  If this driver is built as a module, it will be called can327.
+
 config CAN_FLEXCAN
 	tristate "Support for Freescale FLEXCAN based chips"
 	depends on OF || COLDFIRE || COMPILE_TEST
diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
index 0af85983634c..cafa0e0a3dfe 100644
--- a/drivers/net/can/Makefile
+++ b/drivers/net/can/Makefile
@@ -14,6 +14,7 @@ obj-y				+= usb/
 obj-y				+= softing/
 
 obj-$(CONFIG_CAN_AT91)		+= at91_can.o
+obj-$(CONFIG_CAN_CAN327)	+= can327.o
 obj-$(CONFIG_CAN_CC770)		+= cc770/
 obj-$(CONFIG_CAN_C_CAN)		+= c_can/
 obj-$(CONFIG_CAN_CTUCANFD)	+= ctucanfd/
diff --git a/drivers/net/can/can327.c b/drivers/net/can/can327.c
new file mode 100644
index 000000000000..508378354b2c
--- /dev/null
+++ b/drivers/net/can/can327.c
@@ -0,0 +1,1145 @@
+// SPDX-License-Identifier: GPL-2.0
+/* ELM327 based CAN interface driver (tty line discipline)
+ *
+ * This driver started as a derivative of linux/drivers/net/can/slcan.c
+ * and my thanks go to the original authors for their inspiration.
+ *
+ * can327.c Author : Max Staudt <max-linux@enpas.org>
+ * slcan.c Author  : Oliver Hartkopp <socketcan@hartkopp.net>
+ * slip.c Authors  : Laurence Culhane <loz@holmes.demon.co.uk>
+ *                   Fred N. van Kempen <waltje@uwalt.nl.mugnet.org>
+ */
+
+#define pr_fmt(fmt) "can327: " fmt
+
+#include <linux/init.h>
+#include <linux/module.h>
+
+#include <linux/bitops.h>
+#include <linux/ctype.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/lockdep.h>
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/tty.h>
+#include <linux/tty_ldisc.h>
+#include <linux/workqueue.h>
+
+#include <uapi/linux/tty.h>
+
+#include <linux/can.h>
+#include <linux/can/dev.h>
+#include <linux/can/error.h>
+#include <linux/can/rx-offload.h>
+
+#define ELM327_NAPI_WEIGHT 4
+
+#define ELM327_SIZE_TXBUF 32
+#define ELM327_SIZE_RXBUF 1024
+
+#define ELM327_CAN_CONFIG_SEND_SFF           0x8000
+#define ELM327_CAN_CONFIG_VARIABLE_DLC       0x4000
+#define ELM327_CAN_CONFIG_RECV_BOTH_SFF_EFF  0x2000
+#define ELM327_CAN_CONFIG_BAUDRATE_MULT_8_7  0x1000
+
+#define ELM327_DUMMY_CHAR 'y'
+#define ELM327_DUMMY_STRING "y"
+#define ELM327_READY_CHAR '>'
+
+/* Bits in elm->cmds_todo */
+enum elm327_tx_do {
+	ELM327_TX_DO_CAN_DATA = 0,
+	ELM327_TX_DO_CANID_11BIT,
+	ELM327_TX_DO_CANID_29BIT_LOW,
+	ELM327_TX_DO_CANID_29BIT_HIGH,
+	ELM327_TX_DO_CAN_CONFIG_PART2,
+	ELM327_TX_DO_CAN_CONFIG,
+	ELM327_TX_DO_RESPONSES,
+	ELM327_TX_DO_SILENT_MONITOR,
+	ELM327_TX_DO_INIT
+};
+
+struct can327 {
+	/* This must be the first member when using alloc_candev() */
+	struct can_priv can;
+
+	struct can_rx_offload offload;
+
+	/* TTY buffers */
+	u8 txbuf[ELM327_SIZE_TXBUF];
+	u8 rxbuf[ELM327_SIZE_RXBUF];
+
+	/* Per-channel lock */
+	spinlock_t lock;
+
+	/* TTY and netdev devices that we're bridging */
+	struct tty_struct *tty;
+	struct net_device *dev;
+
+	/* TTY buffer accounting */
+	struct work_struct tx_work;	/* Flushes TTY TX buffer */
+	u8 *txhead;			/* Next TX byte */
+	size_t txleft;			/* Bytes left to TX */
+	int rxfill;			/* Bytes already RX'd in buffer */
+
+	/* State machine */
+	enum {
+		ELM327_STATE_NOTINIT = 0,
+		ELM327_STATE_GETDUMMYCHAR,
+		ELM327_STATE_GETPROMPT,
+		ELM327_STATE_RECEIVING,
+	} state;
+
+	/* Things we have yet to send */
+	char **next_init_cmd;
+	unsigned long cmds_todo;
+
+	/* The CAN frame and config the ELM327 is sending/using,
+	 * or will send/use after finishing all cmds_todo
+	 */
+	struct can_frame can_frame_to_send;
+	u16 can_config;
+	u8 can_bitrate_divisor;
+
+	/* Parser state */
+	bool drop_next_line;
+
+	/* Stop the channel on UART side hardware failure, e.g. stray
+	 * characters or neverending lines. This may be caused by bad
+	 * UART wiring, a bad ELM327, a bad UART bridge...
+	 * Once this is true, nothing will be sent to the TTY.
+	 */
+	bool uart_side_failure;
+};
+
+static inline void elm327_uart_side_failure(struct can327 *elm);
+
+static void elm327_send(struct can327 *elm, const void *buf, size_t len)
+{
+	int written;
+
+	lockdep_assert_held(&elm->lock);
+
+	if (elm->uart_side_failure)
+		return;
+
+	memcpy(elm->txbuf, buf, len);
+
+	/* Order of next two lines is *very* important.
+	 * When we are sending a little amount of data,
+	 * the transfer may be completed inside the ops->write()
+	 * routine, because it's running with interrupts enabled.
+	 * In this case we *never* got WRITE_WAKEUP event,
+	 * if we did not request it before write operation.
+	 *       14 Oct 1994  Dmitry Gorodchanin.
+	 */
+	set_bit(TTY_DO_WRITE_WAKEUP, &elm->tty->flags);
+	written = elm->tty->ops->write(elm->tty, elm->txbuf, len);
+	if (written < 0) {
+		netdev_err(elm->dev,
+			   "Failed to write to tty %s.\n",
+			   elm->tty->name);
+		elm327_uart_side_failure(elm);
+		return;
+	}
+
+	elm->txleft = len - written;
+	elm->txhead = elm->txbuf + written;
+}
+
+/* Take the ELM327 out of almost any state and back into command mode.
+ * We send ELM327_DUMMY_CHAR which will either abort any running
+ * operation, or be echoed back to us in case we're already in command
+ * mode.
+ */
+static void elm327_kick_into_cmd_mode(struct can327 *elm)
+{
+	lockdep_assert_held(&elm->lock);
+
+	if (elm->state != ELM327_STATE_GETDUMMYCHAR &&
+	    elm->state != ELM327_STATE_GETPROMPT) {
+		elm327_send(elm, ELM327_DUMMY_STRING, 1);
+
+		elm->state = ELM327_STATE_GETDUMMYCHAR;
+	}
+}
+
+/* Schedule a CAN frame and necessary config changes to be sent to the TTY. */
+static void elm327_send_frame(struct can327 *elm, struct can_frame *frame)
+{
+	lockdep_assert_held(&elm->lock);
+
+	/* Schedule any necessary changes in ELM327's CAN configuration */
+	if (elm->can_frame_to_send.can_id != frame->can_id) {
+		/* Set the new CAN ID for transmission. */
+		if ((frame->can_id ^ elm->can_frame_to_send.can_id)
+		    & CAN_EFF_FLAG) {
+			elm->can_config = (frame->can_id & CAN_EFF_FLAG
+						? 0
+						: ELM327_CAN_CONFIG_SEND_SFF)
+					| ELM327_CAN_CONFIG_VARIABLE_DLC
+					| ELM327_CAN_CONFIG_RECV_BOTH_SFF_EFF
+					| elm->can_bitrate_divisor;
+
+			set_bit(ELM327_TX_DO_CAN_CONFIG, &elm->cmds_todo);
+		}
+
+		if (frame->can_id & CAN_EFF_FLAG) {
+			clear_bit(ELM327_TX_DO_CANID_11BIT, &elm->cmds_todo);
+			set_bit(ELM327_TX_DO_CANID_29BIT_LOW, &elm->cmds_todo);
+			set_bit(ELM327_TX_DO_CANID_29BIT_HIGH, &elm->cmds_todo);
+		} else {
+			set_bit(ELM327_TX_DO_CANID_11BIT, &elm->cmds_todo);
+			clear_bit(ELM327_TX_DO_CANID_29BIT_LOW, &elm->cmds_todo);
+			clear_bit(ELM327_TX_DO_CANID_29BIT_HIGH, &elm->cmds_todo);
+		}
+	}
+
+	/* Schedule the CAN frame itself. */
+	elm->can_frame_to_send = *frame;
+	set_bit(ELM327_TX_DO_CAN_DATA, &elm->cmds_todo);
+
+	elm327_kick_into_cmd_mode(elm);
+}
+
+/* ELM327 initialisation sequence.
+ * The line length is limited by the buffer in elm327_handle_prompt().
+ */
+static char *elm327_init_script[] = {
+	"AT WS\r",        /* v1.0: Warm Start */
+	"AT PP FF OFF\r", /* v1.0: All Programmable Parameters Off */
+	"AT M0\r",        /* v1.0: Memory Off */
+	"AT AL\r",        /* v1.0: Allow Long messages */
+	"AT BI\r",        /* v1.0: Bypass Initialisation */
+	"AT CAF0\r",      /* v1.0: CAN Auto Formatting Off */
+	"AT CFC0\r",      /* v1.0: CAN Flow Control Off */
+	"AT CF 000\r",    /* v1.0: Reset CAN ID Filter */
+	"AT CM 000\r",    /* v1.0: Reset CAN ID Mask */
+	"AT E1\r",        /* v1.0: Echo On */
+	"AT H1\r",        /* v1.0: Headers On */
+	"AT L0\r",        /* v1.0: Linefeeds Off */
+	"AT SH 7DF\r",    /* v1.0: Set CAN sending ID to 0x7df */
+	"AT ST FF\r",     /* v1.0: Set maximum Timeout for response after TX */
+	"AT AT0\r",       /* v1.2: Adaptive Timing Off */
+	"AT D1\r",        /* v1.3: Print DLC On */
+	"AT S1\r",        /* v1.3: Spaces On */
+	"AT TP B\r",      /* v1.0: Try Protocol B */
+	NULL
+};
+
+static void elm327_init(struct can327 *elm)
+{
+	lockdep_assert_held(&elm->lock);
+
+	elm->state = ELM327_STATE_NOTINIT;
+	elm->can_frame_to_send.can_id = 0x7df; /* ELM327 HW default */
+	elm->rxfill = 0;
+	elm->drop_next_line = 0;
+
+	/* We can only set the bitrate as a fraction of 500000.
+	 * The bitrates listed in can327_bitrate_const will
+	 * limit the user to the right values.
+	 */
+	elm->can_bitrate_divisor = 500000 / elm->can.bittiming.bitrate;
+	elm->can_config = ELM327_CAN_CONFIG_SEND_SFF
+			| ELM327_CAN_CONFIG_VARIABLE_DLC
+			| ELM327_CAN_CONFIG_RECV_BOTH_SFF_EFF
+			| elm->can_bitrate_divisor;
+
+	/* Configure ELM327 and then start monitoring */
+	elm->next_init_cmd = &elm327_init_script[0];
+	set_bit(ELM327_TX_DO_INIT, &elm->cmds_todo);
+	set_bit(ELM327_TX_DO_SILENT_MONITOR, &elm->cmds_todo);
+	set_bit(ELM327_TX_DO_RESPONSES, &elm->cmds_todo);
+	set_bit(ELM327_TX_DO_CAN_CONFIG, &elm->cmds_todo);
+
+	elm327_kick_into_cmd_mode(elm);
+}
+
+static void elm327_feed_frame_to_netdev(struct can327 *elm,
+					struct sk_buff *skb)
+{
+	lockdep_assert_held(&elm->lock);
+
+	if (!netif_running(elm->dev))
+		return;
+
+	/* Queue for NAPI pickup.
+	 * rx-offload will update stats and LEDs for us.
+	 */
+	if (can_rx_offload_queue_tail(&elm->offload, skb))
+		elm->dev->stats.rx_fifo_errors++;
+
+	/* Wake NAPI */
+	can_rx_offload_irq_finish(&elm->offload);
+}
+
+/* Called when we're out of ideas and just want it all to end. */
+static inline void elm327_uart_side_failure(struct can327 *elm)
+{
+	struct can_frame *frame;
+	struct sk_buff *skb;
+
+	lockdep_assert_held(&elm->lock);
+
+	elm->uart_side_failure = true;
+
+	clear_bit(TTY_DO_WRITE_WAKEUP, &elm->tty->flags);
+
+	elm->can.can_stats.bus_off++;
+	netif_stop_queue(elm->dev);
+	elm->can.state = CAN_STATE_BUS_OFF;
+	can_bus_off(elm->dev);
+
+	netdev_err(elm->dev, "ELM327 misbehaved. Blocking further communication.\n");
+
+	skb = alloc_can_err_skb(elm->dev, &frame);
+	if (!skb)
+		return;
+
+	frame->can_id |= CAN_ERR_BUSOFF;
+	elm327_feed_frame_to_netdev(elm, skb);
+}
+
+/* Compares a byte buffer (non-NUL terminated) to the payload part of a string,
+ * and returns true iff the buffer (content *and* length) is exactly that
+ * string, without the terminating NUL byte.
+ *
+ * Example: If reference is "BUS ERROR", then this returns true iff nbytes == 9
+ *          and !memcmp(buf, "BUS ERROR", 9).
+ *
+ * The reason to use strings is so we can easily include them in the C code,
+ * and to avoid hardcoding lengths.
+ */
+static inline bool elm327_rxbuf_cmp(const u8 *buf, size_t nbytes, const char *reference)
+{
+	size_t ref_len = strlen(reference);
+
+	return (nbytes == ref_len) && !memcmp(buf, reference, ref_len);
+}
+
+static void elm327_parse_error(struct can327 *elm, size_t len)
+{
+	struct can_frame *frame;
+	struct sk_buff *skb;
+
+	lockdep_assert_held(&elm->lock);
+
+	skb = alloc_can_err_skb(elm->dev, &frame);
+	if (!skb)
+		/* It's okay to return here:
+		 * The outer parsing loop will drop this UART buffer.
+		 */
+		return;
+
+	/* Filter possible error messages based on length of RX'd line */
+	if (elm327_rxbuf_cmp(elm->rxbuf, len, "UNABLE TO CONNECT")) {
+		netdev_err(elm->dev,
+			   "ELM327 reported UNABLE TO CONNECT. Please check your setup.\n");
+	} else if (elm327_rxbuf_cmp(elm->rxbuf, len, "BUFFER FULL")) {
+		/* This will only happen if the last data line was complete.
+		 * Otherwise, elm327_parse_frame() will heuristically
+		 * emit this kind of error frame instead.
+		 */
+		frame->can_id |= CAN_ERR_CRTL;
+		frame->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
+	} else if (elm327_rxbuf_cmp(elm->rxbuf, len, "BUS ERROR")) {
+		frame->can_id |= CAN_ERR_BUSERROR;
+	} else if (elm327_rxbuf_cmp(elm->rxbuf, len, "CAN ERROR")) {
+		frame->can_id |= CAN_ERR_PROT;
+	} else if (elm327_rxbuf_cmp(elm->rxbuf, len, "<RX ERROR")) {
+		frame->can_id |= CAN_ERR_PROT;
+	} else if (elm327_rxbuf_cmp(elm->rxbuf, len, "BUS BUSY")) {
+		frame->can_id |= CAN_ERR_PROT;
+		frame->data[2] = CAN_ERR_PROT_OVERLOAD;
+	} else if (elm327_rxbuf_cmp(elm->rxbuf, len, "FB ERROR")) {
+		frame->can_id |= CAN_ERR_PROT;
+		frame->data[2] = CAN_ERR_PROT_TX;
+	} else if (len == 5 && !memcmp(elm->rxbuf, "ERR", 3)) {
+		/* ERR is followed by two digits, hence line length 5 */
+		netdev_err(elm->dev, "ELM327 reported an ERR%c%c. Please power it off and on again.\n",
+			   elm->rxbuf[3], elm->rxbuf[4]);
+		frame->can_id |= CAN_ERR_CRTL;
+	} else {
+		/* Something else has happened.
+		 * Maybe garbage on the UART line.
+		 * Emit a generic error frame.
+		 */
+	}
+
+	elm327_feed_frame_to_netdev(elm, skb);
+}
+
+/* Parse CAN frames coming as ASCII from ELM327.
+ * They can be of various formats:
+ *
+ * 29-bit ID (EFF):  12 34 56 78 D PL PL PL PL PL PL PL PL
+ * 11-bit ID (!EFF): 123 D PL PL PL PL PL PL PL PL
+ *
+ * where D = DLC, PL = payload byte
+ *
+ * Instead of a payload, RTR indicates a remote request.
+ *
+ * We will use the spaces and line length to guess the format.
+ */
+static int elm327_parse_frame(struct can327 *elm, size_t len)
+{
+	struct can_frame *frame;
+	struct sk_buff *skb;
+	int hexlen;
+	int datastart;
+	int i;
+
+	lockdep_assert_held(&elm->lock);
+
+	skb = alloc_can_skb(elm->dev, &frame);
+	if (!skb)
+		return -ENOMEM;
+
+	/* Find first non-hex and non-space character:
+	 *  - In the simplest case, there is none.
+	 *  - For RTR frames, 'R' is the first non-hex character.
+	 *  - An error message may replace the end of the data line.
+	 */
+	for (hexlen = 0; hexlen <= len; hexlen++) {
+		if (hex_to_bin(elm->rxbuf[hexlen]) < 0 &&
+		    elm->rxbuf[hexlen] != ' ') {
+			break;
+		}
+	}
+
+	/* Sanity check whether the line is really a clean hexdump,
+	 * or terminated by an error message, or contains garbage.
+	 */
+	if (hexlen < len &&
+	    !isdigit(elm->rxbuf[hexlen]) &&
+	    !isupper(elm->rxbuf[hexlen]) &&
+	    '<' != elm->rxbuf[hexlen] &&
+	    ' ' != elm->rxbuf[hexlen]) {
+		/* The line is likely garbled anyway, so bail.
+		 * The main code will restart listening.
+		 */
+		kfree_skb(skb);
+		return -ENODATA;
+	}
+
+	/* Use spaces in CAN ID to distinguish 29 or 11 bit address length.
+	 * No out-of-bounds access:
+	 * We use the fact that we can always read from elm->rxbuf.
+	 */
+	if (elm->rxbuf[2] == ' ' && elm->rxbuf[5] == ' ' &&
+	    elm->rxbuf[8] == ' ' && elm->rxbuf[11] == ' ' &&
+	    elm->rxbuf[13] == ' ') {
+		frame->can_id = CAN_EFF_FLAG;
+		datastart = 14;
+	} else if (elm->rxbuf[3] == ' ' && elm->rxbuf[5] == ' ') {
+		datastart = 6;
+	} else {
+		/* This is not a well-formatted data line.
+		 * Assume it's an error message.
+		 */
+		kfree_skb(skb);
+		return -ENODATA;
+	}
+
+	if (hexlen < datastart) {
+		/* The line is too short to be a valid frame hex dump.
+		 * Something interrupted the hex dump or it is invalid.
+		 */
+		kfree_skb(skb);
+		return -ENODATA;
+	}
+
+	/* From here on all chars up to buf[hexlen] are hex or spaces,
+	 * at well-defined offsets.
+	 */
+
+	/* Read CAN data length */
+	frame->len = (hex_to_bin(elm->rxbuf[datastart - 2]) << 0);
+
+	/* Read CAN ID */
+	if (frame->can_id & CAN_EFF_FLAG) {
+		frame->can_id |= (hex_to_bin(elm->rxbuf[0]) << 28)
+			       | (hex_to_bin(elm->rxbuf[1]) << 24)
+			       | (hex_to_bin(elm->rxbuf[3]) << 20)
+			       | (hex_to_bin(elm->rxbuf[4]) << 16)
+			       | (hex_to_bin(elm->rxbuf[6]) << 12)
+			       | (hex_to_bin(elm->rxbuf[7]) << 8)
+			       | (hex_to_bin(elm->rxbuf[9]) << 4)
+			       | (hex_to_bin(elm->rxbuf[10]) << 0);
+	} else {
+		frame->can_id |= (hex_to_bin(elm->rxbuf[0]) << 8)
+			       | (hex_to_bin(elm->rxbuf[1]) << 4)
+			       | (hex_to_bin(elm->rxbuf[2]) << 0);
+	}
+
+	/* Check for RTR frame */
+	if (elm->rxfill >= hexlen + 3 &&
+	    !memcmp(&elm->rxbuf[hexlen], "RTR", 3)) {
+		frame->can_id |= CAN_RTR_FLAG;
+	}
+
+	/* Is the line long enough to hold the advertised payload?
+	 * Note: RTR frames have a DLC, but no actual payload.
+	 */
+	if (!(frame->can_id & CAN_RTR_FLAG) &&
+	    (hexlen < frame->len * 3 + datastart)) {
+		/* Incomplete frame.
+		 * Probably the ELM327's RS232 TX buffer was full.
+		 * Emit an error frame and exit.
+		 */
+		frame->can_id = CAN_ERR_FLAG | CAN_ERR_CRTL;
+		frame->len = CAN_ERR_DLC;
+		frame->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
+		elm327_feed_frame_to_netdev(elm, skb);
+
+		/* Signal failure to parse.
+		 * The line will be re-parsed as an error line, which will fail.
+		 * However, this will correctly drop the state machine back into
+		 * command mode.
+		 */
+		kfree_skb(skb);
+		return -ENODATA;
+	}
+
+	/* Parse the data nibbles. */
+	for (i = 0; i < frame->len; i++) {
+		frame->data[i] = (hex_to_bin(elm->rxbuf[datastart + 3*i]) << 4)
+			       | (hex_to_bin(elm->rxbuf[datastart + 3*i + 1]));
+	}
+
+	/* Feed the frame to the network layer. */
+	elm327_feed_frame_to_netdev(elm, skb);
+
+	return 0;
+}
+
+static void elm327_parse_line(struct can327 *elm, size_t len)
+{
+	lockdep_assert_held(&elm->lock);
+
+	/* Skip empty lines */
+	if (!len)
+		return;
+
+	/* Skip echo lines */
+	if (elm->drop_next_line) {
+		elm->drop_next_line = 0;
+		return;
+	} else if (!memcmp(elm->rxbuf, "AT", 2)) {
+		return;
+	}
+
+	/* Regular parsing */
+	if (elm->state == ELM327_STATE_RECEIVING &&
+	    elm327_parse_frame(elm, len)) {
+		/* Parse an error line. */
+		elm327_parse_error(elm, len);
+
+		/* Start afresh. */
+		elm327_kick_into_cmd_mode(elm);
+	}
+}
+
+static void elm327_handle_prompt(struct can327 *elm)
+{
+	struct can_frame *frame = &elm->can_frame_to_send;
+	/* Size this buffer for the largest ELM327 line we may generate,
+	 * which is currently an 8 byte CAN frame's payload hexdump.
+	 * Items in elm327_init_script must fit here, too!
+	 */
+	char local_txbuf[sizeof("0102030405060708\r")];
+
+	lockdep_assert_held(&elm->lock);
+
+	if (!elm->cmds_todo) {
+		/* Enter CAN monitor mode */
+		elm327_send(elm, "ATMA\r", 5);
+		elm->state = ELM327_STATE_RECEIVING;
+
+		/* We will be in the default state once this command is
+		 * sent, so enable the TX packet queue.
+		 */
+		netif_wake_queue(elm->dev);
+
+		return;
+	}
+
+	/* Reconfigure ELM327 step by step as indicated by elm->cmds_todo */
+	if (test_bit(ELM327_TX_DO_INIT, &elm->cmds_todo)) {
+		snprintf(local_txbuf, sizeof(local_txbuf),
+			 "%s",
+			 *elm->next_init_cmd);
+
+		elm->next_init_cmd++;
+		if (!(*elm->next_init_cmd)) {
+			clear_bit(ELM327_TX_DO_INIT, &elm->cmds_todo);
+			/* Init finished. */
+		}
+
+	} else if (test_and_clear_bit(ELM327_TX_DO_SILENT_MONITOR, &elm->cmds_todo)) {
+		snprintf(local_txbuf, sizeof(local_txbuf),
+			 "ATCSM%i\r",
+			 !!(elm->can.ctrlmode & CAN_CTRLMODE_LISTENONLY));
+
+	} else if (test_and_clear_bit(ELM327_TX_DO_RESPONSES, &elm->cmds_todo)) {
+		snprintf(local_txbuf, sizeof(local_txbuf),
+			 "ATR%i\r",
+			 !(elm->can.ctrlmode & CAN_CTRLMODE_LISTENONLY));
+
+	} else if (test_and_clear_bit(ELM327_TX_DO_CAN_CONFIG, &elm->cmds_todo)) {
+		snprintf(local_txbuf, sizeof(local_txbuf),
+			 "ATPC\r");
+		set_bit(ELM327_TX_DO_CAN_CONFIG_PART2, &elm->cmds_todo);
+
+	} else if (test_and_clear_bit(ELM327_TX_DO_CAN_CONFIG_PART2, &elm->cmds_todo)) {
+		snprintf(local_txbuf, sizeof(local_txbuf),
+			 "ATPB%04X\r",
+			 elm->can_config);
+
+	} else if (test_and_clear_bit(ELM327_TX_DO_CANID_29BIT_HIGH, &elm->cmds_todo)) {
+		snprintf(local_txbuf, sizeof(local_txbuf),
+			 "ATCP%02X\r",
+			 (frame->can_id & CAN_EFF_MASK) >> 24);
+
+	} else if (test_and_clear_bit(ELM327_TX_DO_CANID_29BIT_LOW, &elm->cmds_todo)) {
+		snprintf(local_txbuf, sizeof(local_txbuf),
+			 "ATSH%06X\r",
+			 frame->can_id & CAN_EFF_MASK & ((1 << 24) - 1));
+
+	} else if (test_and_clear_bit(ELM327_TX_DO_CANID_11BIT, &elm->cmds_todo)) {
+		snprintf(local_txbuf, sizeof(local_txbuf),
+			 "ATSH%03X\r",
+			 frame->can_id & CAN_SFF_MASK);
+
+	} else if (test_and_clear_bit(ELM327_TX_DO_CAN_DATA, &elm->cmds_todo)) {
+		if (frame->can_id & CAN_RTR_FLAG) {
+			/* Send an RTR frame. Their DLC is fixed.
+			 * Some chips don't send them at all.
+			 */
+			snprintf(local_txbuf, sizeof(local_txbuf),
+				 "ATRTR\r");
+		} else {
+			/* Send a regular CAN data frame */
+			int i;
+
+			for (i = 0; i < frame->len; i++) {
+				snprintf(&local_txbuf[2 * i], sizeof(local_txbuf),
+					 "%02X",
+					 frame->data[i]);
+			}
+
+			snprintf(&local_txbuf[2 * i], sizeof(local_txbuf),
+				 "\r");
+		}
+
+		elm->drop_next_line = 1;
+		elm->state = ELM327_STATE_RECEIVING;
+
+		/* We will be in the default state once this command is
+		 * sent, so enable the TX packet queue.
+		 */
+		netif_wake_queue(elm->dev);
+	}
+
+	elm327_send(elm, local_txbuf, strlen(local_txbuf));
+}
+
+static bool elm327_is_ready_char(char c)
+{
+	/* Bits 0xc0 are sometimes set (randomly), hence the mask.
+	 * Probably bad hardware.
+	 */
+	return (c & 0x3f) == ELM327_READY_CHAR;
+}
+
+static void elm327_drop_bytes(struct can327 *elm, size_t i)
+{
+	lockdep_assert_held(&elm->lock);
+
+	memmove(&elm->rxbuf[0], &elm->rxbuf[i], ELM327_SIZE_RXBUF - i);
+	elm->rxfill -= i;
+}
+
+static void elm327_parse_rxbuf(struct can327 *elm, size_t first_new_char_idx)
+{
+	size_t len, pos;
+
+	lockdep_assert_held(&elm->lock);
+
+	switch (elm->state) {
+	case ELM327_STATE_NOTINIT:
+		elm->rxfill = 0;
+		break;
+
+	case ELM327_STATE_GETDUMMYCHAR:
+		/* Wait for 'y' or '>' */
+		for (pos = 0; pos < elm->rxfill; pos++) {
+			if (elm->rxbuf[pos] == ELM327_DUMMY_CHAR) {
+				elm327_send(elm, "\r", 1);
+				elm->state = ELM327_STATE_GETPROMPT;
+				pos++;
+				break;
+			} else if (elm327_is_ready_char(elm->rxbuf[pos])) {
+				elm327_send(elm, ELM327_DUMMY_STRING, 1);
+				pos++;
+				break;
+			}
+		}
+
+		elm327_drop_bytes(elm, pos);
+		break;
+
+	case ELM327_STATE_GETPROMPT:
+		/* Wait for '>' */
+		if (elm327_is_ready_char(elm->rxbuf[elm->rxfill - 1]))
+			elm327_handle_prompt(elm);
+
+		elm->rxfill = 0;
+		break;
+
+	case ELM327_STATE_RECEIVING:
+		/* Find <CR> delimiting feedback lines. */
+		len = first_new_char_idx;
+		while (len < elm->rxfill && elm->rxbuf[len] != '\r')
+			len++;
+
+		if (len == ELM327_SIZE_RXBUF) {
+			/* Assume the buffer ran full with garbage.
+			 * Did we even connect at the right baud rate?
+			 */
+			netdev_err(elm->dev,
+				   "RX buffer overflow. Faulty ELM327 or UART?\n");
+			elm327_uart_side_failure(elm);
+		} else if (len == elm->rxfill) {
+			if (elm327_is_ready_char(elm->rxbuf[elm->rxfill - 1])) {
+				/* The ELM327's AT ST response timeout ran out,
+				 * so we got a prompt.
+				 * Clear RX buffer and restart listening.
+				 */
+				elm->rxfill = 0;
+
+				elm327_handle_prompt(elm);
+			}
+
+			/* No <CR> found - we haven't received a full line yet.
+			 * Wait for more data.
+			 */
+		} else {
+			/* We have a full line to parse. */
+			elm327_parse_line(elm, len);
+
+			/* Remove parsed data from RX buffer. */
+			elm327_drop_bytes(elm, len + 1);
+
+			/* More data to parse? */
+			if (elm->rxfill)
+				elm327_parse_rxbuf(elm, 0);
+		}
+	}
+}
+
+static int can327_netdev_open(struct net_device *dev)
+{
+	struct can327 *elm = netdev_priv(dev);
+	int err;
+
+	spin_lock_bh(&elm->lock);
+
+	if (!elm->tty) {
+		spin_unlock_bh(&elm->lock);
+		return -ENODEV;
+	}
+
+	if (elm->uart_side_failure)
+		netdev_warn(elm->dev, "Reopening netdev after a UART side fault has been detected.\n");
+
+	/* Clear TTY buffers */
+	elm->rxfill = 0;
+	elm->txleft = 0;
+
+	/* open_candev() checks for elm->can.bittiming.bitrate != 0 */
+	err = open_candev(dev);
+	if (err) {
+		spin_unlock_bh(&elm->lock);
+		return err;
+	}
+
+	elm327_init(elm);
+	spin_unlock_bh(&elm->lock);
+
+	err = can_rx_offload_add_manual(dev, &elm->offload, ELM327_NAPI_WEIGHT);
+	if (err) {
+		close_candev(dev);
+		return err;
+	}
+
+	can_rx_offload_enable(&elm->offload);
+
+	elm->can.state = CAN_STATE_ERROR_ACTIVE;
+	netif_start_queue(dev);
+
+	return 0;
+}
+
+static int can327_netdev_close(struct net_device *dev)
+{
+	struct can327 *elm = netdev_priv(dev);
+
+	/* Interrupt whatever the ELM327 is doing right now */
+	spin_lock_bh(&elm->lock);
+	elm327_send(elm, ELM327_DUMMY_STRING, 1);
+	spin_unlock_bh(&elm->lock);
+
+	netif_stop_queue(dev);
+
+	/* Give UART one final chance to flush. */
+	clear_bit(TTY_DO_WRITE_WAKEUP, &elm->tty->flags);
+	flush_work(&elm->tx_work);
+
+	can_rx_offload_disable(&elm->offload);
+	elm->can.state = CAN_STATE_STOPPED;
+	can_rx_offload_del(&elm->offload);
+	close_candev(dev);
+
+	return 0;
+}
+
+/* Send a can_frame to a TTY. */
+static netdev_tx_t can327_netdev_start_xmit(struct sk_buff *skb,
+					    struct net_device *dev)
+{
+	struct can327 *elm = netdev_priv(dev);
+	struct can_frame *frame = (struct can_frame *)skb->data;
+
+	if (can_dropped_invalid_skb(dev, skb))
+		return NETDEV_TX_OK;
+
+	/* We shouldn't get here after a hardware fault:
+	 * can_bus_off() calls netif_carrier_off()
+	 */
+	if (elm->uart_side_failure) {
+		WARN_ON_ONCE(elm->uart_side_failure);
+		goto out;
+	}
+
+	netif_stop_queue(dev);
+
+	/* BHs are already disabled, so no spin_lock_bh().
+	 * See Documentation/networking/netdevices.txt
+	 */
+	spin_lock(&elm->lock);
+	elm327_send_frame(elm, frame);
+	spin_unlock(&elm->lock);
+
+	dev->stats.tx_packets++;
+	dev->stats.tx_bytes += frame->can_id & CAN_RTR_FLAG ? 0 : frame->len;
+
+out:
+	kfree_skb(skb);
+	return NETDEV_TX_OK;
+}
+
+static const struct net_device_ops can327_netdev_ops = {
+	.ndo_open	= can327_netdev_open,
+	.ndo_stop	= can327_netdev_close,
+	.ndo_start_xmit	= can327_netdev_start_xmit,
+	.ndo_change_mtu	= can_change_mtu,
+};
+
+static bool can327_is_valid_rx_char(u8 c)
+{
+	static const bool lut_char_is_valid['z'] = {
+		['\r'] = true,
+		[' '] = true,
+		['.'] = true,
+		['0'] = true, true, true, true, true,
+		['5'] = true, true, true, true, true,
+		['<'] = true,
+		[ELM327_READY_CHAR] = true,
+		['?'] = true,
+		['A'] = true, true, true, true, true, true, true,
+		['H'] = true, true, true, true, true, true, true,
+		['O'] = true, true, true, true, true, true, true,
+		['V'] = true, true, true, true, true,
+		['a'] = true,
+		['b'] = true,
+		['v'] = true,
+		[ELM327_DUMMY_CHAR] = true,
+	};
+	BUILD_BUG_ON(ELM327_DUMMY_CHAR >= 'z');
+
+	return (c < ARRAY_SIZE(lut_char_is_valid) &&
+		lut_char_is_valid[c]);
+}
+
+/* Handle incoming ELM327 ASCII data.
+ * This will not be re-entered while running, but other ldisc
+ * functions may be called in parallel.
+ */
+static void can327_ldisc_rx(struct tty_struct *tty,
+			    const unsigned char *cp, const char *fp, int count)
+{
+	struct can327 *elm = (struct can327 *)tty->disc_data;
+	size_t first_new_char_idx;
+
+	if (elm->uart_side_failure)
+		return;
+
+	spin_lock_bh(&elm->lock);
+
+	/* Store old rxfill, so elm327_parse_rxbuf() will have
+	 * the option of skipping already checked characters.
+	 */
+	first_new_char_idx = elm->rxfill;
+
+	while (count-- && elm->rxfill < ELM327_SIZE_RXBUF) {
+		if (fp && *fp++) {
+			netdev_err(elm->dev, "Error in received character stream. Check your wiring.");
+
+			elm327_uart_side_failure(elm);
+
+			spin_unlock_bh(&elm->lock);
+			return;
+		}
+
+		/* Ignore NUL characters, which the PIC microcontroller may
+		 * inadvertently insert due to a known hardware bug.
+		 * See ELM327 documentation, which refers to a Microchip PIC
+		 * bug description.
+		 */
+		if (*cp) {
+			/* Check for stray characters on the UART line.
+			 * Likely caused by bad hardware.
+			 */
+			if (!can327_is_valid_rx_char(*cp)) {
+				netdev_err(elm->dev,
+					   "Received illegal character %02x.\n",
+					   *cp);
+				elm327_uart_side_failure(elm);
+
+				spin_unlock_bh(&elm->lock);
+				return;
+			}
+
+			elm->rxbuf[elm->rxfill++] = *cp;
+		}
+
+		cp++;
+	}
+
+	if (count >= 0) {
+		netdev_err(elm->dev, "Receive buffer overflowed. Bad chip or wiring? count = %i", count);
+
+		elm327_uart_side_failure(elm);
+
+		spin_unlock_bh(&elm->lock);
+		return;
+	}
+
+	elm327_parse_rxbuf(elm, first_new_char_idx);
+	spin_unlock_bh(&elm->lock);
+}
+
+/* Write out remaining transmit buffer.
+ * Scheduled when TTY is writable.
+ */
+static void can327_ldisc_tx_worker(struct work_struct *work)
+{
+	struct can327 *elm = container_of(work, struct can327, tx_work);
+	ssize_t written;
+
+	if (elm->uart_side_failure)
+		return;
+
+	spin_lock_bh(&elm->lock);
+
+	if (elm->txleft) {
+		written = elm->tty->ops->write(elm->tty, elm->txhead, elm->txleft);
+		if (written < 0) {
+			netdev_err(elm->dev,
+				   "Failed to write to tty %s.\n",
+				   elm->tty->name);
+			elm327_uart_side_failure(elm);
+
+			spin_unlock_bh(&elm->lock);
+			return;
+		}
+
+		elm->txleft -= written;
+		elm->txhead += written;
+	}
+
+	if (!elm->txleft)
+		clear_bit(TTY_DO_WRITE_WAKEUP, &elm->tty->flags);
+
+	spin_unlock_bh(&elm->lock);
+}
+
+/* Called by the driver when there's room for more data. */
+static void can327_ldisc_tx_wakeup(struct tty_struct *tty)
+{
+	struct can327 *elm = (struct can327 *)tty->disc_data;
+
+	schedule_work(&elm->tx_work);
+}
+
+/* ELM327 can only handle bitrates that are integer divisors of 500 kHz,
+ * or 7/8 of that. Divisors are 1 to 64.
+ * Currently we don't implement support for 7/8 rates.
+ */
+static const u32 can327_bitrate_const[] = {
+	 7812,  7936,  8064,  8196,  8333,  8474,  8620,  8771,
+	 8928,  9090,  9259,  9433,  9615,  9803, 10000, 10204,
+	10416, 10638, 10869, 11111, 11363, 11627, 11904, 12195,
+	12500, 12820, 13157, 13513, 13888, 14285, 14705, 15151,
+	15625, 16129, 16666, 17241, 17857, 18518, 19230, 20000,
+	20833, 21739, 22727, 23809, 25000, 26315, 27777, 29411,
+	31250, 33333, 35714, 38461, 41666, 45454, 50000, 55555,
+	62500, 71428, 83333, 100000, 125000, 166666, 250000, 500000
+};
+
+/* Dummy needed to use bitrate_const */
+static int can327_do_set_bittiming(struct net_device *netdev)
+{
+	return 0;
+}
+
+static int can327_ldisc_open(struct tty_struct *tty)
+{
+	struct net_device *dev;
+	struct can327 *elm;
+	int err;
+
+	if (!capable(CAP_NET_ADMIN))
+		return -EPERM;
+
+	if (!tty->ops->write)
+		return -EOPNOTSUPP;
+
+	dev = alloc_candev(sizeof(struct can327), 0);
+	if (!dev)
+		return -ENFILE;
+	elm = netdev_priv(dev);
+
+	/* Configure TTY interface */
+	tty->receive_room = 65536; /* We don't flow control */
+	spin_lock_init(&elm->lock);
+	INIT_WORK(&elm->tx_work, can327_ldisc_tx_worker);
+
+	/* Configure CAN metadata */
+	elm->can.bitrate_const = can327_bitrate_const;
+	elm->can.bitrate_const_cnt = ARRAY_SIZE(can327_bitrate_const);
+	elm->can.do_set_bittiming = can327_do_set_bittiming;
+	elm->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY;
+
+	/* Configure netdev interface */
+	elm->dev = dev;
+	dev->netdev_ops = &can327_netdev_ops;
+
+	/* Mark ldisc channel as alive */
+	elm->tty = tty;
+	tty->disc_data = elm;
+
+	/* Let 'er rip */
+	err = register_candev(elm->dev);
+	if (err) {
+		free_candev(elm->dev);
+		return err;
+	}
+
+	netdev_info(elm->dev, "can327 on %s.\n", tty->name);
+
+	return 0;
+}
+
+/* Close down a can327 channel.
+ * This means flushing out any pending queues, and then returning.
+ * This call is serialized against other ldisc functions:
+ * Once this is called, no other ldisc function of ours is entered.
+ *
+ * We also use this function for a hangup event.
+ */
+static void can327_ldisc_close(struct tty_struct *tty)
+{
+	struct can327 *elm = (struct can327 *)tty->disc_data;
+
+	/* unregister_netdev() calls .ndo_stop() so we don't have to.
+	 * Our .ndo_stop() also flushes the TTY write wakeup handler,
+	 * so we can safely set elm->tty = NULL after this.
+	 */
+	unregister_candev(elm->dev);
+
+	/* Mark channel as dead */
+	spin_lock_bh(&elm->lock);
+	tty->disc_data = NULL;
+	elm->tty = NULL;
+	spin_unlock_bh(&elm->lock);
+
+	netdev_info(elm->dev, "can327 off %s.\n", tty->name);
+
+	free_candev(elm->dev);
+}
+
+static int can327_ldisc_ioctl(struct tty_struct *tty,
+			      unsigned int cmd, unsigned long arg)
+{
+	struct can327 *elm = (struct can327 *)tty->disc_data;
+	unsigned int tmp;
+
+	switch (cmd) {
+	case SIOCGIFNAME:
+		tmp = strnlen(elm->dev->name, IFNAMSIZ - 1) + 1;
+		if (copy_to_user((void __user *)arg, elm->dev->name, tmp))
+			return -EFAULT;
+		return 0;
+
+	case SIOCSIFHWADDR:
+		return -EINVAL;
+
+	default:
+		return tty_mode_ioctl(tty, cmd, arg);
+	}
+}
+
+static struct tty_ldisc_ops can327_ldisc = {
+	.owner		= THIS_MODULE,
+	.name		= "can327",
+	.num		= N_CAN327,
+	.receive_buf	= can327_ldisc_rx,
+	.write_wakeup	= can327_ldisc_tx_wakeup,
+	.open		= can327_ldisc_open,
+	.close		= can327_ldisc_close,
+	.ioctl		= can327_ldisc_ioctl,
+};
+
+static int __init can327_init(void)
+{
+	int status;
+
+	status = tty_register_ldisc(&can327_ldisc);
+	if (status)
+		pr_err("Can't register line discipline\n");
+
+	return status;
+}
+
+static void __exit can327_exit(void)
+{
+	/* This will only be called when all channels have been closed by
+	 * userspace - tty_ldisc.c takes care of the module's refcount.
+	 */
+	tty_unregister_ldisc(&can327_ldisc);
+}
+
+module_init(can327_init);
+module_exit(can327_exit);
+
+MODULE_ALIAS_LDISC(N_CAN327);
+MODULE_DESCRIPTION("ELM327 based CAN interface");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Max Staudt <max@enpas.org>");
diff --git a/include/uapi/linux/tty.h b/include/uapi/linux/tty.h
index 9d0f06bfbac3..68aeae2addec 100644
--- a/include/uapi/linux/tty.h
+++ b/include/uapi/linux/tty.h
@@ -38,8 +38,9 @@
 #define N_NULL		27	/* Null ldisc used for error handling */
 #define N_MCTP		28	/* MCTP-over-serial */
 #define N_DEVELOPMENT	29	/* Manual out-of-tree testing */
+#define N_CAN327	30	/* ELM327 based OBD-II interfaces */
 
 /* Always the newest line discipline + 1 */
-#define NR_LDISCS	30
+#define NR_LDISCS	31
 
 #endif /* _UAPI_LINUX_TTY_H */
-- 
2.30.2

