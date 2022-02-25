Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401294C3FCA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 09:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238377AbiBYIJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 03:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238373AbiBYIJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:09:40 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Feb 2022 00:09:06 PST
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D68182D1E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 00:09:05 -0800 (PST)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202202250808009f23e98cf4fe52f221
        for <linux-kernel@vger.kernel.org>;
        Fri, 25 Feb 2022 09:08:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=w3cR0f3cIM/VOAe+KecHNt+g+EOW+d9BsBRoANoCFng=;
 b=DqyV6NfxrBaJZhDc16boDliemJvQPknc09/s7Nc+Bn9cZNeXAV0VwSFdWU+OCHMOzZSJAs
 FV3XiN2FwjV/zp9jZT7COcwcRTFRn5AAt8ouL2qixckgnxFxYVh+vRTzdK+UEmhh1OG0pYGC
 xj87ig3bfFGTXjqPP036lUiS0uz24=;
From:   Daniel Starke <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [RFC 1/1] tty: n_gsm: improve standard compliance and feature completeness
Date:   Fri, 25 Feb 2022 00:07:58 -0800
Message-Id: <20220225080758.2869-2-daniel.starke@siemens.com>
In-Reply-To: <20220225080758.2869-1-daniel.starke@siemens.com>
References: <20220225080758.2869-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-118192:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The complete patch based on tty-next is included here for reference.
A proper series of patches will follow based on the comments to this RFC.
Please refer to the cover letter for more details.

Changes included:
- added: proper n_gsm Kernel module information fields and module version
- added: optional start-of-frame flag skipping in advanced option mode
- added: UI (unnumbered information) frame support
- added: PN (parameter negotiation) message handling and function support
- added: optional keep-alive control link supervision via Test messages
- added: proc fs files to provide meta data for the n_gsm instances
- added: various parameter gated kernel debug messages
- added: option for strict mode to reject non-standard compliant behavior
- added: TIOCM_OUT1 and TIOCM_OUT2 to allow responder to operate as modem
- added: TIOCMIWAIT support on virtual ttys
- added: additional ioctls and parameters to configure the new functions
- added: more function comments and aligned all to the coding guidelines
- changed: overall locking mechanism to avoid data race conditions
- changed: outgoing data flow to decouple physical from virtual tty
  handling for better performance and to avoid dead-locks
- fixed: advanced option mode implementation
- fixed: convergence layer type 2 implementation
- fixed: handling of CLD (multiplexer close down) messages
- fixed: broken muxer close down procedure

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c         | 4523 +++++++++++++++++++++++++----------
 include/uapi/linux/gsmmux.h |   70 +-
 2 files changed, 3364 insertions(+), 1229 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 0b1808e3a912..2af68faffe73 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1,27 +1,43 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * n_gsm.c GSM 0710 tty multiplexor
+ * n_gsm.c GSM 0710 tty multiplexer
  * Copyright (c) 2009/10 Intel Corporation
+ * Portions Copyright (c) 2018-2022 Siemens Mobility GmbH
  *
- *	* THIS IS A DEVELOPMENT SNAPSHOT IT IS NOT A FINAL RELEASE *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  *
- * TO DO:
- *	Mostly done:	ioctls for setting modes/timing
- *	Partly done:	hooks so you can pull off frames to non tty devs
- *	Restart DLCI 0 when it closes ?
- *	Improve the tx engine
- *	Resolve tx side locking by adding a queue_head and routing
- *		all control traffic via it
- *	General tidy/document
- *	Review the locking/move to refcounts more (mux now moved to an
- *		alloc/free model ready)
- *	Use newest tty open/close port helpers and install hooks
- *	What to do about power functions ?
- *	Termios setting and negotiation
- *	Do we need a 'which mux are you' ioctl to correlate mux and tty sets
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ *  * THIS IS A DEVELOPMENT SNAPSHOT IT IS NOT A FINAL RELEASE *
+ *
+ * Outgoing path:
+ * tty -> DLCI fifo -> scheduler -> GSM MUX data queue    ---o-> ldisc
+ * control message               -> GSM MUX control queue --´
  *
+ * Incoming path:
+ * ldisc -> gsm_queue() -o--> tty
+ *                        `-> gsm_control_response()
+ *
+ * TO DO:
+ *  Partly done: hooks so you can pull off frames to non tty devs
+ *  Restart DLCI 0 when it closes?
+ *  Improve the tx engine
+ *  General tidy/document
+ *  Review the locking/move to refcounts more (mux now moved to an alloc/free
+ *  model ready)
+ *  Use newest tty open/close port helpers and install hooks
+ *  Handle upstream flow off in gsm_dlci_data correctly
+ *  Implement proper priority handling
+ *  What to do about power functions?
  */
-
 #include <linux/types.h>
 #include <linux/major.h>
 #include <linux/errno.h>
@@ -35,6 +51,7 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/poll.h>
+#include <linux/proc_fs.h>
 #include <linux/bitops.h>
 #include <linux/file.h>
 #include <linux/uaccess.h>
@@ -52,31 +69,62 @@
 #include <linux/gsmmux.h>
 #include "tty.h"
 
+MODULE_DESCRIPTION("GSM 07.10 serial multiplexer");
+MODULE_VERSION("0.1.17");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_LDISC(N_GSM0710);
+
+static int strict;
+module_param(strict, int, 0600);
+MODULE_PARM_DESC(strict, "Enforce standard compliance. Disabled by default.");
+
 static int debug;
 module_param(debug, int, 0600);
+MODULE_PARM_DESC(debug, "Enable module debugging. Disabled by default.");
 
-/* Defaults: these are from the specification */
+/* Module debug bits */
+#define DBG_DUMP	(1 << 0) /* Data transmission dump. */
+#define DBG_DATA	(1 << 2) /* Data transmission details. */
+#define DBG_ERRORS	(1 << 3) /* Details for fail conditions. */
+#define DBG_TTY	(1 << 4) /* Transmission statistics for DLCI TTYs. */
+#define DBG_PAYLOAD    (1 << 5) /* Limit data dump to payload frames. */
+#define DBG_CALLS	(1 << 7) /* Function entry/exit. */
 
-#define T1	10		/* 100mS */
-#define T2	34		/* 333mS */
-#define N2	3		/* Retry 3 times */
+/* Defaults: these are from the specification */
+/*
+ *	Note for T1: Assuming that our underlaying tty and our link partner has
+ *	a 2 KiB send buffer operating at 115200 Baud, it takes in worst case at
+ *	least ~360ms from control message sent until acknowledgment.
+ */
+#define T1  10      /* 100ms */
+#define T2  30      /* 300ms */
+#define T3  10      /* 10s */
+#define N2  3       /* Retry 3 times */
+#define K   2       /* outstanding I frames */
 
 /* Use long timers for testing at low speed with debug on */
 #ifdef DEBUG_TIMING
-#define T1	100
-#define T2	200
+#undef T1
+#define T1  100
+#undef T2
+#define T2  300
 #endif
 
 /*
- * Semi-arbitrary buffer size limits. 0710 is normally run with 32-64 byte
- * limits so this is plenty
+ *	Semi-arbitrary buffer size limits. 0710 is normally run with 32-64 byte
+ *	limits so this is plenty
  */
 #define MAX_MRU 1500
 #define MAX_MTU 1500
-#define	GSM_NET_TX_TIMEOUT (HZ*10)
+#define MIN_UNIT 8
+/* SOF, ADDR, CTRL, LEN1, LEN2, ..., FCS, EOF */
+#define PROT_OVERHEAD 7
+#define GSM_NET_TX_TIMEOUT (10*HZ)
 
 /*
  *	struct gsm_mux_net	-	network interface
+ *	@struct gsm_dlci* dlci
+ *	@struct net_device_stats stats;
  *
  *	Created when net interface is initialized.
  */
@@ -90,26 +138,27 @@ struct gsm_mux_net {
  *	a gsm_msg which holds everything we need in a link layer independent
  *	format
  */
-
 struct gsm_msg {
 	struct list_head list;
-	u8 addr;		/* DLCI address + flags */
-	u8 ctrl;		/* Control byte + flags */
-	unsigned int len;	/* Length of data block (can be zero) */
-	unsigned char *data;	/* Points into buffer but not at the start */
+	u8 addr;             /* DLCI address + flags */
+	u8 ctrl;             /* Control byte + flags */
+	unsigned int len;    /* Length of data block (can be zero) */
+	unsigned char *data; /* Points into buffer but not at the start */
 	unsigned char buffer[];
 };
 
 enum gsm_dlci_state {
 	DLCI_CLOSED,
-	DLCI_OPENING,		/* Sending SABM not seen UA */
-	DLCI_OPEN,		/* SABM/UA complete */
-	DLCI_CLOSING,		/* Sending DISC not seen UA/DM */
+	DLCI_WAITING,   /* Waiting for DLCI configuration */
+	DLCI_CONFIGURE, /* Sending PN (for adaption > 1) */
+	DLCI_OPENING,   /* Sending SABM not seen UA */
+	DLCI_OPEN,      /* SABM/UA complete */
+	DLCI_CLOSING    /* Sending DISC not seen UA/DM */
 };
 
 enum gsm_dlci_mode {
-	DLCI_MODE_ABM,		/* Normal Asynchronous Balanced Mode */
-	DLCI_MODE_ADM,		/* Asynchronous Disconnected Mode */
+	DLCI_MODE_ABM,  /* Normal Asynchronous Balanced Mode */
+	DLCI_MODE_ADM   /* Asynchronous Disconnected Mode */
 };
 
 /*
@@ -121,7 +170,6 @@ enum gsm_dlci_mode {
  *	At the moment we don't free DLCI objects until the mux is torn down
  *	this avoid object life time issues but might be worth review later.
  */
-
 struct gsm_dlci {
 	struct gsm_mux *gsm;
 	int addr;
@@ -130,32 +178,42 @@ struct gsm_dlci {
 
 	/* Link layer */
 	enum gsm_dlci_mode mode;
-	spinlock_t lock;	/* Protects the internal state */
-	struct timer_list t1;	/* Retransmit timer for SABM and UA */
+	spinlock_t lock;        /* Protects the internal state */
+	struct timer_list t1;   /* Retransmit timer for SABM and UA */
 	int retries;
 	/* Uplink tty if active */
-	struct tty_port port;	/* The tty bound to this DLCI if there is one */
-	struct kfifo fifo;	/* Queue fifo for the DLCI */
-	int adaption;		/* Adaption layer in use */
+	struct tty_port port;   /* The tty bound to this DLCI if there is one */
+	struct kfifo fifo;      /* Queue fifo for the DLCI */
+	int adaption;           /* Adaption layer in use */
 	int prev_adaption;
-	u32 modem_rx;		/* Our incoming virtual modem lines */
-	u32 modem_tx;		/* Our outgoing modem lines */
-	bool dead;		/* Refuse re-open */
+	u32 modem_rx;           /* Our incoming virtual modem lines */
+	u32 modem_tx;           /* Our outgoing modem lines */
+	unsigned int mtu;
+	bool dead;              /* Refuse re-open */
+	/* Configuration */
+	int prio;               /* Priority */
+	int ftype;              /* Frame type */
+	int k;                  /* Window size */
 	/* Flow control */
-	bool throttled;		/* Private copy of throttle state */
-	bool constipated;	/* Throttle status for outgoing */
+	bool throttled;         /* Private copy of throttle state */
+	bool constipated;       /* Throttle status for outgoing */
 	/* Packetised I/O */
-	struct sk_buff *skb;	/* Frame being sent */
-	struct sk_buff_head skb_list;	/* Queued frames */
+	struct sk_buff *skb;    /* Frame being sent */
+	struct sk_buff_head skb_list; /* Queued frames */
 	/* Data handling callback */
 	void (*data)(struct gsm_dlci *dlci, const u8 *data, int len);
 	void (*prev_data)(struct gsm_dlci *dlci, const u8 *data, int len);
-	struct net_device *net; /* network interface, if created */
+	struct net_device *net; /* Network interface, if created */
+	/* Statistics (exposed via proc file) */
+	unsigned long tx;       /* Data bytes send on this DLCI */
+	unsigned long rx;       /* Data bytes received on this DLCI */
 };
 
-/* DLCI 0, 62/63 are special or reserved see gsmtty_open */
+/* Total number of supported devices */
+#define GSM_TTY_MINORS  256
 
-#define NUM_DLCI		64
+/* DLCI 0, 62/63 are special or reserved see gsmtty_open */
+#define NUM_DLCI        64
 
 /*
  *	DLCI 0 is used to pass control blocks out of band of the data
@@ -164,13 +222,17 @@ struct gsm_dlci {
  *	and destroyed by the user context, and updated by the receive paths
  *	and timers
  */
-
 struct gsm_control {
-	u8 cmd;		/* Command we are issuing */
-	u8 *data;	/* Data for the command in case we retransmit */
-	int len;	/* Length of block for retransmission */
-	int done;	/* Done flag */
-	int error;	/* Error if any */
+	u8 cmd;     /* Command we are issuing */
+	u8 *data;   /* Data for the command in case we retransmit */
+	int len;    /* Length of block for retransmission */
+	bool done;  /* Done flag */
+	int error;  /* Error if any */
+};
+
+enum gsm_encoding {
+	GSM_BASIC_OPT,
+	GSM_ADV_OPT,
 };
 
 enum gsm_mux_state {
@@ -196,17 +258,20 @@ enum gsm_mux_state {
  *
  *	To consider further: tty open versus mux shutdown.
  */
-
 struct gsm_mux {
-	struct tty_struct *tty;		/* The tty our ldisc is bound to */
+	struct tty_struct *tty;     /* The tty our ldisc is bound to */
+	struct proc_dir_entry *proc; /* Associated proc fs entry */
 	spinlock_t lock;
 	struct mutex mutex;
-	unsigned int num;
+	unsigned int num;           /* The MUX instance */
 	struct kref ref;
 
 	/* Events on the GSM channel */
 	wait_queue_head_t event;
 
+	/* ldisc write task */
+	struct tasklet_struct tx_tsk;
+
 	/* Bits for GSM mode decoding */
 
 	/* Framing Layer */
@@ -216,11 +281,13 @@ struct gsm_mux {
 	unsigned int address;
 	unsigned int count;
 	bool escape;
-	int encoding;
+	enum gsm_encoding encoding;
 	u8 control;
 	u8 fcs;
-	u8 received_fcs;
-	u8 *txframe;			/* TX framing buffer */
+	u8 *txframe;                /* TX framing buffer */
+	bool skip_sof;              /* Skip next SOF? */
+	unsigned long last_sof;     /* Time when the last SOF was transmitted */
+	int xon_xoff;               /* termios' IXON/IXOFF flags */
 
 	/* Method for the receiver side */
 	void (*receive)(struct gsm_mux *gsm, u8 ch);
@@ -228,33 +295,46 @@ struct gsm_mux {
 	/* Link Layer */
 	unsigned int mru;
 	unsigned int mtu;
-	int initiator;			/* Did we initiate connection */
-	bool dead;			/* Has the mux been shut down */
+	int initiator;              /* Did we initiate connection */
+	bool dead;                  /* Has the mux been shut down */
 	struct gsm_dlci *dlci[NUM_DLCI];
-	bool constipated;		/* Asked by remote to shut up */
+	bool constipated;           /* Asked by remote to shut up */
+	bool has_devices;           /* Devices were registered */
 
 	spinlock_t tx_lock;
-	unsigned int tx_bytes;		/* TX data outstanding */
-#define TX_THRESH_HI		8192
-#define TX_THRESH_LO		2048
-	struct list_head tx_list;	/* Pending data packets */
+	unsigned int tx_bytes;      /* TX data outstanding */
+#define TX_THRESH_HI        8192
+#define TX_THRESH_LO        2048
+	struct list_head tx0_list;  /* Pending control and ch.0 packets */
+	struct list_head tx1_list;  /* Pending data packets */
 
 	/* Control messages */
-	struct timer_list t2_timer;	/* Retransmit timer for commands */
-	int cretries;			/* Command retry counter */
-	struct gsm_control *pending_cmd;/* Our current pending command */
-	spinlock_t control_lock;	/* Protects the pending command */
+	struct timer_list kick_timer; /* Kick TX queuing on timeout */
+	struct timer_list t2_timer; /* Retransmit timer for commands */
+	int cretries;               /* Command retry counter */
+	struct gsm_control *pending_cmd; /* Our current pending command */
+	spinlock_t control_lock;    /* Protects the pending command */
 
-	/* Configuration */
-	int adaption;		/* 1 or 2 supported */
-	u8 ftype;		/* UI or UIH */
-	int t1, t2;		/* Timers in 1/100th of a sec */
-	int n2;			/* Retry count */
+	/* Keep-alive */
+	struct timer_list ka_timer; /* Keep-alive response timer */
+	u8 ka_num;                  /* Keep-alive match pattern */
+	int ka_retries;             /* Keep-alive retry counter */
 
-	/* Statistics (not currently exposed) */
+	/* Configuration */
+	int adaption;               /* 1 or 2 supported */
+	u8 ftype;                   /* UI or UIH */
+	int t1, t2, t3;             /* Timers in 1/100th of a sec */
+	int n2;                     /* Retry count */
+	int k;                      /* Window size */
+	bool wait_config;           /* Wait for configuration by IOC before DLCI open */
+	unsigned int keep_alive;    /* Control channel keep-alive in milliseconds */
+	unsigned int sof_intvl;     /* Time not sending SOF. */
+
+	/* Statistics (exposed via proc file) */
 	unsigned long bad_fcs;
 	unsigned long malformed;
 	unsigned long io_error;
+	unsigned long open_error;
 	unsigned long bad_size;
 	unsigned long unsupported;
 };
@@ -264,64 +344,60 @@ struct gsm_mux {
  *	Mux objects - needed so that we can translate a tty index into the
  *	relevant mux and DLCI.
  */
-
-#define MAX_MUX		4			/* 256 minors */
-static struct gsm_mux *gsm_mux[MAX_MUX];	/* GSM muxes */
+#define MAX_MUX     4                       /* 256 minors */
+static struct gsm_mux *gsm_mux[MAX_MUX];    /* GSM muxes */
 static DEFINE_SPINLOCK(gsm_mux_lock);
+static DEFINE_MUTEX(gsm_mux_mutex);
 
 static struct tty_driver *gsm_tty_driver;
 
-/* Save dlci open address */
-static int addr_open[256] = { 0 };
-/* Save dlci open count */
-static int addr_cnt;
 /*
  *	This section of the driver logic implements the GSM encodings
- *	both the basic and the 'advanced'. Reliable transport is not
+ *	both the 'basic' and the 'advanced'. Reliable transport is not
  *	supported.
  */
 
-#define CR			0x02
-#define EA			0x01
-#define	PF			0x10
-
-/* I is special: the rest are ..*/
-#define RR			0x01
-#define UI			0x03
-#define RNR			0x05
-#define REJ			0x09
-#define DM			0x0F
-#define SABM			0x2F
-#define DISC			0x43
-#define UA			0x63
-#define	UIH			0xEF
+#define CR               0x02
+#define EA               0x01
+#define PF               0x10
+
+/* I is special: the rest are .. */
+#define RR               0x01
+#define UI               0x03
+#define RNR              0x05
+#define REJ              0x09
+#define DM               0x0F
+#define SABM             0x2F
+#define DISC             0x43
+#define UA               0x63
+#define UIH              0xEF
 
 /* Channel commands */
-#define CMD_NSC			0x09
-#define CMD_TEST		0x11
-#define CMD_PSC			0x21
-#define CMD_RLS			0x29
-#define CMD_FCOFF		0x31
-#define CMD_PN			0x41
-#define CMD_RPN			0x49
-#define CMD_FCON		0x51
-#define CMD_CLD			0x61
-#define CMD_SNC			0x69
-#define CMD_MSC			0x71
+#define CMD_NSC          0x09
+#define CMD_TEST         0x11
+#define CMD_PSC          0x21
+#define CMD_RLS          0x29
+#define CMD_FCOFF        0x31
+#define CMD_PN           0x41
+#define CMD_RPN          0x49
+#define CMD_FCON         0x51
+#define CMD_CLD          0x61
+#define CMD_SNC          0x69
+#define CMD_MSC          0x71
 
 /* Virtual modem bits */
-#define MDM_FC			0x01
-#define MDM_RTC			0x02
-#define MDM_RTR			0x04
-#define MDM_IC			0x20
-#define MDM_DV			0x40
-
-#define GSM0_SOF		0xF9
-#define GSM1_SOF		0x7E
-#define GSM1_ESCAPE		0x7D
-#define GSM1_ESCAPE_BITS	0x20
-#define XON			0x11
-#define XOFF			0x13
+#define MDM_FC           0x01
+#define MDM_RTC          0x02
+#define MDM_RTR          0x04
+#define MDM_IC           0x20
+#define MDM_DV           0x40
+
+#define GSM0_SOF         0xF9
+#define GSM1_SOF         0x7E
+#define GSM1_ESCAPE      0x7D
+#define GSM1_ESCAPE_BITS 0x20
+#define XON              0x11
+#define XOFF             0x13
 #define ISO_IEC_646_MASK	0x7F
 
 static const struct tty_port_operations gsm_port_ops;
@@ -329,7 +405,6 @@ static const struct tty_port_operations gsm_port_ops;
 /*
  *	CRC table for GSM 0710
  */
-
 static const u8 gsm_fcs8[256] = {
 	0x00, 0x91, 0xE3, 0x72, 0x07, 0x96, 0xE4, 0x75,
 	0x0E, 0x9F, 0xED, 0x7C, 0x09, 0x98, 0xEA, 0x7B,
@@ -365,10 +440,21 @@ static const u8 gsm_fcs8[256] = {
 	0xBA, 0x2B, 0x59, 0xC8, 0xBD, 0x2C, 0x5E, 0xCF
 };
 
-#define INIT_FCS	0xFF
-#define GOOD_FCS	0xCF
+#define INIT_FCS    0xFF
+#define GOOD_FCS    0xCF
 
+/*
+ * Prototypes
+ */
+static void gsm_dlci_close(struct gsm_dlci *dlci);
+static void gsm_dlci_begin_close(struct gsm_dlci *dlci);
+static inline void mux_get(struct gsm_mux *gsm);
+static void gsm_dlci_release(struct gsm_dlci *dlci);
+static inline void mux_put(struct gsm_mux *gsm);
 static int gsmld_output(struct gsm_mux *gsm, u8 *data, int len);
+static void gsmld_write_trigger(struct gsm_mux *gsm);
+static void gsmld_write_task(unsigned long arg);
+static void gsm_destroy_network(struct gsm_dlci *dlci);
 
 /**
  *	gsm_fcs_add	-	update FCS
@@ -378,7 +464,6 @@ static int gsmld_output(struct gsm_mux *gsm, u8 *data, int len);
  *	Update the FCS to include c. Uses the algorithm in the specification
  *	notes.
  */
-
 static inline u8 gsm_fcs_add(u8 fcs, u8 c)
 {
 	return gsm_fcs8[fcs ^ c];
@@ -393,7 +478,6 @@ static inline u8 gsm_fcs_add(u8 fcs, u8 c)
  *	Update the FCS to include c. Uses the algorithm in the specification
  *	notes.
  */
-
 static inline u8 gsm_fcs_add_block(u8 fcs, u8 *c, int len)
 {
 	while (len--)
@@ -402,23 +486,46 @@ static inline u8 gsm_fcs_add_block(u8 fcs, u8 *c, int len)
 }
 
 /**
- *	gsm_read_ea		-	read a byte into an EA
+ *	gsm_read_ea	-	read a byte into an EA
  *	@val: variable holding value
  *	@c: byte going into the EA
  *
  *	Processes one byte of an EA. Updates the passed variable
  *	and returns 1 if the EA is now completely read
  */
-
 static int gsm_read_ea(unsigned int *val, u8 c)
 {
 	/* Add the next 7 bits into the value */
 	*val <<= 7;
 	*val |= c >> 1;
-	/* Was this the last byte of the EA 1 = yes*/
+	/* Was this the last byte of the EA 1 = yes */
 	return c & EA;
 }
 
+/**
+ *	gsm_read_ea_val	-	read a byte into an EA
+ *	@val: variable holding value
+ *	@data: buffer of data
+ *	@clen: length of buffer
+ *
+ *	Processes an EA. Updates the passed variable and
+ *	returns the processed data length.
+ */
+static int gsm_read_ea_val(unsigned int *val, const u8 *data, int clen)
+{
+	int len;
+
+	for (len = 0; clen > 0; len++, clen--) {
+		if (gsm_read_ea(val, *data++)) {
+			/* done */
+			len += 1;
+			break;
+		}
+	}
+	return len;
+}
+
+
 /**
  *	gsm_encode_modem	-	encode modem data bits
  *	@dlci: DLCI to encode from
@@ -426,10 +533,10 @@ static int gsm_read_ea(unsigned int *val, u8 c)
  *	Returns the correct GSM encoded modem status bits (6 bit field) for
  *	the current status of the DLCI and attached tty object
  */
-
 static u8 gsm_encode_modem(const struct gsm_dlci *dlci)
 {
 	u8 modembits = 0;
+
 	/* FC is true flow control not modem bits */
 	if (dlci->throttled)
 		modembits |= MDM_FC;
@@ -441,14 +548,207 @@ static u8 gsm_encode_modem(const struct gsm_dlci *dlci)
 		modembits |= MDM_IC;
 	if (dlci->modem_tx & TIOCM_CD)
 		modembits |= MDM_DV;
+
+	if (dlci->gsm->initiator)
+		return modembits | MDM_DV;
+
+	/* special mappings for passive side to operate as UE */
+	if (dlci->modem_tx & TIOCM_OUT1)
+		modembits |= MDM_IC;
+	if (dlci->modem_tx & TIOCM_OUT2)
+		modembits |= MDM_DV;
+
 	return modembits;
 }
 
+/**
+ *	gsm_encode_params	-	encode DLCI parameters
+ *	@dlci: DLCI to encode from
+ *	@data: 8 byte buffer for encoded data
+ *	@dlen: length of buffer
+ *
+ *	Encodes the parameters according to GSM 07.10 section 5.4.6.3.1
+ *	table 3.
+ */
+static int gsm_encode_params(const struct gsm_dlci *dlci, u8 *data, int dlen)
+{
+	struct gsm_mux *gsm = dlci->gsm;
+
+	if (dlen < 8)
+		return -EINVAL;
+
+	data[0] = dlci->addr;
+	data[1] = 0x00; /* UIH, convergence layer type 1 */
+	data[2] = dlci->prio;
+	data[3] = gsm->t1;
+	data[4] = dlci->mtu & 0xFF;
+	data[5] = (dlci->mtu >> 8) & 0xFF;
+	data[6] = gsm->n2;
+	data[7] = dlci->k;
+
+	if (dlci->ftype == UI) {
+		data[1] = 0x01; /* UI */
+	} else if (dlci->ftype != UIH) {
+		pr_err("%s: unsupported frame type %d\n",
+		       __func__, dlci->ftype);
+		return -EINVAL;
+	}
+
+	switch (dlci->adaption) {
+	case 1: /* Unstructured */
+		break;
+	case 2: /* Unstructured with modem bits. */
+		data[1] |= 0x10; /* convergence layer type 2 */
+		break;
+	default:
+		pr_err("%s: unsupported adaption %d\n",
+		       __func__, dlci->adaption);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ *	gsm_get_mux	-	find a mux instance by index
+ *
+ *	@index:  the mux number to search for may differ from the position
+ *	         in the mux array.
+ *
+ *	@return: Pointer of the mux instance with index <index> or
+ *	         NULL if no instance with that index exists
+ */
+static struct gsm_mux *gsm_get_mux(unsigned int index)
+{
+	int i;
+	struct gsm_mux *gsm;
+
+	/* find the object with that line number */
+	spin_lock(&gsm_mux_lock);
+	for (i = 0, gsm = NULL; i < MAX_MUX; i++) {
+		if (gsm_mux[i]) {
+			if (index == gsm_mux[i]->num) {
+				gsm = gsm_mux[i];
+				break;
+			}
+		}
+	}
+	spin_unlock(&gsm_mux_lock);
+	return gsm;
+}
+
+/**
+ *	gsm_assign_num	-	assigns a new mux instance number
+ *
+ *	@gsm: GSM mux
+ *	@num: the desired new mux instance number
+ *
+ *	The global GSM mux instance table is modified to reflect this change.
+ */
+static int gsm_assign_num(struct gsm_mux *gsm, unsigned int num)
+{
+	int ret = 0;
+
+	if (gsm->num >= MAX_MUX || num >= MAX_MUX)
+		return -EINVAL;
+
+	spin_lock(&gsm_mux_lock);
+	if (!gsm_mux[num]) {
+		if (gsm_mux[gsm->num])
+			gsm_mux[gsm->num] = NULL;
+		gsm_mux[num] = gsm;
+		gsm->num = num;
+	} else if (gsm->num != num) {
+		/* Setting an occupied instance number is not allowed. */
+		ret = -EBUSY;
+	}
+	spin_unlock(&gsm_mux_lock);
+
+	return ret;
+}
+
+/**
+ *	gsm_register_devices	-	register all tty devices for a given mux index
+ *
+ *	@driver: the tty driver that describes the tty devices
+ *	@index:  the mux number is used to calculate the minor numbers of the
+ *	         ttys for this mux and may differ from the position in the
+ *	         mux array.
+ */
+static int gsm_register_devices(struct tty_driver *driver, unsigned int index)
+{
+	struct device *dev;
+	int ret, i;
+	unsigned int base;
+
+	ret = 0;
+	if (driver && (index < MAX_MUX)) {
+		if (debug & DBG_CALLS)
+			pr_debug("%s index %u\n", __func__, index);
+		base = index * NUM_DLCI; /* first minor for this index */
+		for (i = 1; i < NUM_DLCI; i++) {
+			/* Don't register device 0 - this is the control channel
+			 * and not a usable tty interface
+			 */
+			dev = tty_register_device(gsm_tty_driver, base + i,
+						  NULL);
+			if (IS_ERR(dev)) {
+				if (debug & DBG_ERRORS)
+					pr_info("%s failed to register device minor %u",
+						__func__, base + i);
+				for (i--; i >= 1; i--)
+					tty_unregister_device(gsm_tty_driver,
+								base + i);
+				ret = PTR_ERR(dev);
+				break;
+			}
+		}
+		if (debug & DBG_CALLS)
+			pr_debug("%s done\n", __func__);
+	} else {
+		WARN_ON(index >= MAX_MUX);
+	}
+
+	return ret;
+}
+
+/**
+ *	gsm_unregister_devices	-	unregister all tty devices for a given mux index
+ *
+ *	@driver: the tty driver that describes the tty devices
+ *	@index:  the mux number is used to calculate the minor numbers of the
+ *	         ttys for this mux and may differ from the position in the
+ *	         mux array.
+ */
+static void gsm_unregister_devices(struct tty_driver *driver,
+				   unsigned int index)
+{
+	int i;
+	unsigned int base;
+
+	if (driver && (index < MAX_MUX)) {
+		if (debug & DBG_CALLS)
+			pr_debug("%s index %u\n", __func__, index);
+		base = index * NUM_DLCI; /* first minor for this index */
+		for (i = 1; i < NUM_DLCI; i++) {
+			/* Don't unregister device 0 - this is the control
+			 * channel and not a usable tty interface
+			 */
+			tty_unregister_device(gsm_tty_driver, base + i);
+		}
+		if (debug & DBG_CALLS)
+			pr_debug("%s done\n", __func__);
+	} else {
+		WARN_ON(index >= MAX_MUX);
+	}
+}
+
 /**
  *	gsm_print_packet	-	display a frame for debug
+ *	@num: GSM mux instance
  *	@hdr: header to print before decode
  *	@addr: address EA from the frame
- *	@cr: C/R bit from the frame
+ *	@cr: C/R bit seen as initiator
  *	@control: control including PF bit
  *	@data: following data bytes
  *	@dlen: length of data
@@ -456,14 +756,18 @@ static u8 gsm_encode_modem(const struct gsm_dlci *dlci)
  *	Displays a packet in human readable format for debugging purposes. The
  *	style is based on amateur radio LAP-B dump display.
  */
-
-static void gsm_print_packet(const char *hdr, int addr, int cr,
-					u8 control, const u8 *data, int dlen)
+static void gsm_print_packet(unsigned int num, const char *hdr, int addr,
+			     int cr, u8 control, const u8 *data, int dlen)
 {
-	if (!(debug & 1))
+	if (!(debug & DBG_DUMP))
 		return;
+	/* Only show user payload frames if debug & DBG_PAYLOAD */
+	if (!(debug & DBG_PAYLOAD) && addr != 0)
+		if ((control & ~PF) == UI || (control & ~PF) == UIH)
+			return;
+
 
-	pr_info("%s %d) %c: ", hdr, addr, "RC"[cr]);
+	pr_info("%s %2d,%u) %c: ", hdr, addr, num, "RC"[cr]);
 
 	switch (control & ~PF) {
 	case SABM:
@@ -490,25 +794,38 @@ static void gsm_print_packet(const char *hdr, int addr, int cr,
 				(control & 0x0E) >> 1, (control & 0xE0) >> 5);
 		} else switch (control & 0x0F) {
 			case RR:
-				pr_cont("RR(%d)", (control & 0xE0) >> 5);
+				pr_cont("RR %d", (control & 0xE0) >> 5);
 				break;
 			case RNR:
-				pr_cont("RNR(%d)", (control & 0xE0) >> 5);
+				pr_cont("RNR %d", (control & 0xE0) >> 5);
 				break;
 			case REJ:
-				pr_cont("REJ(%d)", (control & 0xE0) >> 5);
+				pr_cont("REJ %d", (control & 0xE0) >> 5);
 				break;
 			default:
 				pr_cont("[%02X]", control);
 		}
 	}
 
-	if (control & PF)
-		pr_cont("(P)");
-	else
-		pr_cont("(F)");
+	if (control & PF) {
+		if (cr)
+			pr_cont("(P)");
+		else
+			pr_cont("(F)");
+	}
+	if (dlen) {
+		int ct = 0;
 
-	print_hex_dump_bytes("", DUMP_PREFIX_NONE, data, dlen);
+		while (dlen--) {
+			if ((ct % 8) == 0) {
+				pr_cont("\n");
+				pr_debug("    ");
+			}
+			pr_cont("%02X ", *data++);
+			ct++;
+		}
+	}
+	pr_cont("\n");
 }
 
 
@@ -522,14 +839,14 @@ static void gsm_print_packet(const char *hdr, int addr, int cr,
  *	@output: output buffer
  *	@len: length of input
  *
- *	Expand a buffer by bytestuffing it. The worst case size change
+ *	Expand a buffer by byte stuffing it. The worst case size change
  *	is doubling and the caller is responsible for handing out
  *	suitable sized buffers.
  */
-
 static int gsm_stuff_frame(const u8 *input, u8 *output, int len)
 {
 	int olen = 0;
+
 	while (len--) {
 		if (*input == GSM1_SOF || *input == GSM1_ESCAPE
 		    || (*input & ISO_IEC_646_MASK) == XON
@@ -544,96 +861,12 @@ static int gsm_stuff_frame(const u8 *input, u8 *output, int len)
 	return olen;
 }
 
-/**
- *	gsm_send	-	send a control frame
- *	@gsm: our GSM mux
- *	@addr: address for control frame
- *	@cr: command/response bit
- *	@control:  control byte including PF bit
- *
- *	Format up and transmit a control frame. These do not go via the
- *	queueing logic as they should be transmitted ahead of data when
- *	they are needed.
- *
- *	FIXME: Lock versus data TX path
- */
-
-static void gsm_send(struct gsm_mux *gsm, int addr, int cr, int control)
-{
-	int len;
-	u8 cbuf[10];
-	u8 ibuf[3];
-
-	switch (gsm->encoding) {
-	case 0:
-		cbuf[0] = GSM0_SOF;
-		cbuf[1] = (addr << 2) | (cr << 1) | EA;
-		cbuf[2] = control;
-		cbuf[3] = EA;	/* Length of data = 0 */
-		cbuf[4] = 0xFF - gsm_fcs_add_block(INIT_FCS, cbuf + 1, 3);
-		cbuf[5] = GSM0_SOF;
-		len = 6;
-		break;
-	case 1:
-	case 2:
-		/* Control frame + packing (but not frame stuffing) in mode 1 */
-		ibuf[0] = (addr << 2) | (cr << 1) | EA;
-		ibuf[1] = control;
-		ibuf[2] = 0xFF - gsm_fcs_add_block(INIT_FCS, ibuf, 2);
-		/* Stuffing may double the size worst case */
-		len = gsm_stuff_frame(ibuf, cbuf + 1, 3);
-		/* Now add the SOF markers */
-		cbuf[0] = GSM1_SOF;
-		cbuf[len + 1] = GSM1_SOF;
-		/* FIXME: we can omit the lead one in many cases */
-		len += 2;
-		break;
-	default:
-		WARN_ON(1);
-		return;
-	}
-	gsmld_output(gsm, cbuf, len);
-	if (!gsm->initiator) {
-		cr = cr & gsm->initiator;
-		control = control & ~PF;
-	}
-	gsm_print_packet("-->", addr, cr, control, NULL, 0);
-}
-
-/**
- *	gsm_response	-	send a control response
- *	@gsm: our GSM mux
- *	@addr: address for control frame
- *	@control:  control byte including PF bit
- *
- *	Format up and transmit a link level response frame.
- */
-
-static inline void gsm_response(struct gsm_mux *gsm, int addr, int control)
-{
-	gsm_send(gsm, addr, 1, control);
-}
-
-/**
- *	gsm_command	-	send a control command
- *	@gsm: our GSM mux
- *	@addr: address for control frame
- *	@control:  control byte including PF bit
- *
- *	Format up and transmit a link level command frame.
- */
-
-static inline void gsm_command(struct gsm_mux *gsm, int addr, int control)
-{
-	gsm_send(gsm, addr, 1, control);
-}
-
-/* Data transmission */
+/*	Data transmission */
 
-#define HDR_LEN		6	/* ADDR CTRL [LEN.2] DATA FCS */
+#define HDR_LEN     6   /* ADDR CTRL [LEN.2] DATA FCS */
 
 /**
- *	gsm_data_alloc		-	allocate data frame
+ *	gsm_data_alloc	-	allocate data frame
  *	@gsm: GSM mux
  *	@addr: DLCI address
  *	@len: length excluding header and FCS
@@ -643,15 +876,14 @@ static inline void gsm_command(struct gsm_mux *gsm, int addr, int control)
  *	at the front for header bytes but that is treated as an implementation
  *	detail and not for the high level code to use
  */
-
 static struct gsm_msg *gsm_data_alloc(struct gsm_mux *gsm, u8 addr, int len,
-								u8 ctrl)
+				      u8 ctrl)
 {
 	struct gsm_msg *m = kmalloc(sizeof(struct gsm_msg) + len + HDR_LEN,
-								GFP_ATOMIC);
-	if (m == NULL)
+				    GFP_ATOMIC);
+	if (!m)
 		return NULL;
-	m->data = m->buffer + HDR_LEN - 1;	/* Allow for FCS */
+	m->data = m->buffer + HDR_LEN - 1;  /* Allow for FCS */
 	m->len = len;
 	m->addr = addr;
 	m->ctrl = ctrl;
@@ -660,116 +892,235 @@ static struct gsm_msg *gsm_data_alloc(struct gsm_mux *gsm, u8 addr, int len,
 }
 
 /**
- *	gsm_data_kick		-	poke the queue
+ *	gsm_send_packet	-	sends a single packet
  *	@gsm: GSM Mux
- *	@dlci: DLCI sending the data
- *
- *	The tty device has called us to indicate that room has appeared in
- *	the transmit queue. Ram more data into the pipe if we have any
- *	If we have been flow-stopped by a CMD_FCOFF, then we can only
- *	send messages on DLCI0 until CMD_FCON
+ *	@msg: packet to send
  *
- *	FIXME: lock against link layer control transmissions
+ *	The given packet is encoded and send out. No memory is freed.
+ *	The caller must hold the gsm tx lock.
  */
-
-static void gsm_data_kick(struct gsm_mux *gsm, struct gsm_dlci *dlci)
+static int gsm_send_packet(struct gsm_mux *gsm, struct gsm_msg *msg)
 {
-	struct gsm_msg *msg, *nmsg;
-	int len;
+	int skip_sof = 1;
+	int len, ret;
+
+	/* Output SOF at the beginning again after a given TX idle time */
+	if (!gsm->skip_sof || !gsm->sof_intvl)
+		skip_sof = 0;
+	if (time_is_before_eq_jiffies(gsm->last_sof
+				      + gsm->sof_intvl * HZ / 100))
+		skip_sof = 0;
+
+	if (gsm->encoding == GSM_BASIC_OPT) {
+		gsm->txframe[0] = GSM0_SOF;
+		memcpy(gsm->txframe + 1, msg->data, msg->len);
+		gsm->txframe[msg->len + 1] = GSM0_SOF;
+		len = msg->len + 2;
+	} else {
+		gsm->txframe[0] = GSM1_SOF;
+		len = gsm_stuff_frame(msg->data, gsm->txframe + 1, msg->len);
+		gsm->txframe[len + 1] = GSM1_SOF;
+		len += 2;
+	}
 
-	list_for_each_entry_safe(msg, nmsg, &gsm->tx_list, list) {
-		if (gsm->constipated && msg->addr)
-			continue;
-		if (gsm->encoding != 0) {
-			gsm->txframe[0] = GSM1_SOF;
-			len = gsm_stuff_frame(msg->data,
-						gsm->txframe + 1, msg->len);
-			gsm->txframe[len + 1] = GSM1_SOF;
-			len += 2;
-		} else {
-			gsm->txframe[0] = GSM0_SOF;
-			memcpy(gsm->txframe + 1 , msg->data, msg->len);
-			gsm->txframe[msg->len + 1] = GSM0_SOF;
-			len = msg->len + 2;
-		}
+	if (debug & DBG_DATA)
+		print_hex_dump_bytes("gsm_send_packet: ", DUMP_PREFIX_OFFSET,
+				     gsm->txframe + skip_sof, len - skip_sof);
+	gsm_print_packet(gsm->num, "-->", msg->addr, gsm->initiator, msg->ctrl,
+			 msg->data, msg->len);
 
-		if (debug & 4)
-			print_hex_dump_bytes("gsm_data_kick: ",
-					     DUMP_PREFIX_OFFSET,
-					     gsm->txframe, len);
-		if (gsmld_output(gsm, gsm->txframe, len) <= 0)
-			break;
-		/* FIXME: Can eliminate one SOF in many more cases */
-		gsm->tx_bytes -= msg->len;
+	ret = gsmld_output(gsm, gsm->txframe + skip_sof, len - skip_sof);
+	if (ret <= 0)
+		return ret;
+	gsm->tx_bytes -= msg->len;
+	gsm->skip_sof = true;
+	gsm->last_sof = jiffies;
 
-		list_del(&msg->list);
-		kfree(msg);
+	return 0;
+}
 
-		if (dlci) {
-			tty_port_tty_wakeup(&dlci->port);
-		} else {
-			int i = 0;
+/**
+ *	gsm_is_ctrl_flow_msg	-	checks if control flow message
+ *	@msg: message to check
+ *
+ *	Returns non zero if the given message is a flow control command of the
+ *	control channel. Zero is returned in any other case.
+ */
+static int gsm_is_ctrl_flow_msg(struct gsm_msg *msg)
+{
+	int ret;
+	unsigned int cmd;
+
+	if (msg->addr)
+		return 0;
 
-			for (i = 0; i < NUM_DLCI; i++)
-				if (gsm->dlci[i])
-					tty_port_tty_wakeup(&gsm->dlci[i]->port);
+	ret = 0;
+	switch (msg->ctrl & ~PF) {
+	case UI:
+	case UIH:
+		cmd = 0;
+		if (gsm_read_ea_val(&cmd, msg->data + 2, msg->len - 2) < 1)
+			break;
+		switch (cmd & ~PF) {
+		case CMD_FCOFF:
+		case CMD_FCON:
+			ret = 1;
+			break;
+		default:
+			break;
 		}
+		break;
+	default:
+		break;
 	}
+
+	return ret;
 }
 
 /**
- *	__gsm_data_queue		-	queue a UI or UIH frame
- *	@dlci: DLCI sending the data
- *	@msg: message queued
+ *	gsm_data_kick	-	poke the queue
+ *	@gsm: GSM Mux
  *
- *	Add data to the transmit queue and try and get stuff moving
- *	out of the mux tty if not already doing so. The Caller must hold
+ *	The tty device has called us to indicate that room has appeared in
+ *	the transmit queue. Ram more data into the pipe if we have any.
+ *	If we have been flow-stopped by a CMD_FCOFF, then we can only
+ *	send messages on DLCI0 until CMD_FCON. The caller must hold
  *	the gsm tx lock.
  */
-
-static void __gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
+static int gsm_data_kick(struct gsm_mux *gsm)
 {
-	struct gsm_mux *gsm = dlci->gsm;
-	u8 *dp = msg->data;
-	u8 *fcs = dp + msg->len;
+	struct gsm_msg *msg, *nmsg;
+	struct gsm_dlci *dlci;
+	int ret;
 
-	/* Fill in the header */
-	if (gsm->encoding == 0) {
-		if (msg->len < 128)
+	/* Serialize control messages and control channel messages first */
+	list_for_each_entry_safe(msg, nmsg, &gsm->tx0_list, list) {
+		if (gsm->constipated && !gsm_is_ctrl_flow_msg(msg))
+			return -EAGAIN;
+		ret = gsm_send_packet(gsm, msg);
+		switch (ret) {
+		case -ENOSPC:
+			return -ENOSPC;
+		case -ENODEV:
+			/* ldisc not open */
+			gsm->tx_bytes -= msg->len;
+			list_del(&msg->list);
+			kfree(msg);
+			continue;
+		default:
+			if (ret >= 0) {
+				list_del(&msg->list);
+				kfree(msg);
+			}
+			break;
+		}
+	}
+
+	if (gsm->constipated)
+		return -EAGAIN;
+
+	/* Serialize other channels */
+	if (list_empty(&gsm->tx1_list))
+		return 0;
+	list_for_each_entry_safe(msg, nmsg, &gsm->tx1_list, list) {
+		dlci = gsm->dlci[msg->addr];
+		/* Send only messages for DLCIs with valid state */
+		if (dlci->state != DLCI_OPEN) {
+			gsm->tx_bytes -= msg->len;
+			list_del(&msg->list);
+			kfree(msg);
+			continue;
+		}
+		ret = gsm_send_packet(gsm, msg);
+		switch (ret) {
+		case -ENOSPC:
+			return -ENOSPC;
+		case -ENODEV:
+			/* ldisc not open */
+			gsm->tx_bytes -= msg->len;
+			list_del(&msg->list);
+			kfree(msg);
+			continue;
+		default:
+			if (ret >= 0) {
+				list_del(&msg->list);
+				kfree(msg);
+			}
+			break;
+		}
+	}
+
+	return 1;
+}
+
+/**
+ *	__gsm_data_queue	-	queue a UI or UIH frame
+ *	@dlci: DLCI sending the data
+ *	@msg: message queued
+ *
+ *	Add data to the transmit queue and try and get stuff moving
+ *	out of the mux tty if not already doing so. The caller must hold
+ *	the gsm tx lock.
+ */
+static void __gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
+{
+	struct gsm_mux *gsm = dlci->gsm;
+	u8 *dp = msg->data;
+	u8 *fcs = dp + msg->len;
+
+	if (gsm->dlci[0]->dead)
+		return;
+
+	/* Fill in the header */
+	if (gsm->encoding == GSM_BASIC_OPT) {
+		if (msg->len < 128)
 			*--dp = (msg->len << 1) | EA;
 		else {
-			*--dp = (msg->len >> 7);	/* bits 7 - 15 */
-			*--dp = (msg->len & 127) << 1;	/* bits 0 - 6 */
+			*--dp = (msg->len >> 7);        /* bits 7 - 15 */
+			*--dp = (msg->len & 127) << 1;  /* bits 0 -  6 */
 		}
 	}
 
 	*--dp = msg->ctrl;
 	if (gsm->initiator)
-		*--dp = (msg->addr << 2) | 2 | EA;
+		*--dp = (msg->addr << 2) | CR | EA;
 	else
 		*--dp = (msg->addr << 2) | EA;
 	*fcs = gsm_fcs_add_block(INIT_FCS, dp , msg->data - dp);
-	/* Ugly protocol layering violation */
 	if (msg->ctrl == UI || msg->ctrl == (UI|PF))
 		*fcs = gsm_fcs_add_block(*fcs, msg->data, msg->len);
 	*fcs = 0xFF - *fcs;
 
-	gsm_print_packet("Q> ", msg->addr, gsm->initiator, msg->ctrl,
-							msg->data, msg->len);
+	gsm_print_packet(gsm->num, "Q->", msg->addr, gsm->initiator, msg->ctrl,
+			 msg->data, msg->len);
 
 	/* Move the header back and adjust the length, also allow for the FCS
-	   now tacked on the end */
+	 * now tacked on the end
+	 */
 	msg->len += (msg->data - dp) + 1;
 	msg->data = dp;
 
 	/* Add to the actual output queue */
-	list_add_tail(&msg->list, &gsm->tx_list);
+	switch (msg->ctrl & ~PF) {
+	case UI:
+	case UIH:
+		if (msg->addr)
+			list_add_tail(&msg->list, &gsm->tx1_list);
+		else
+			list_add_tail(&msg->list, &gsm->tx0_list);
+		break;
+	default:
+		list_add_tail(&msg->list, &gsm->tx0_list);
+		break;
+	}
 	gsm->tx_bytes += msg->len;
-	gsm_data_kick(gsm, dlci);
+
+	gsmld_write_trigger(gsm);
+	mod_timer(&gsm->kick_timer, jiffies + 10 * gsm->t1 * HZ / 100);
 }
 
 /**
- *	gsm_data_queue		-	queue a UI or UIH frame
+ *	gsm_data_queue	-	queue a UI or UIH frame
  *	@dlci: DLCI sending the data
  *	@msg: message queued
  *
@@ -777,13 +1128,118 @@ static void __gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
  *	out of the mux tty if not already doing so. Take the
  *	the gsm tx lock and dlci lock.
  */
-
 static void gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
 {
+	struct gsm_mux *gsm = dlci->gsm;
 	unsigned long flags;
-	spin_lock_irqsave(&dlci->gsm->tx_lock, flags);
+
+	spin_lock_irqsave(&gsm->tx_lock, flags);
 	__gsm_data_queue(dlci, msg);
-	spin_unlock_irqrestore(&dlci->gsm->tx_lock, flags);
+	spin_unlock_irqrestore(&gsm->tx_lock, flags);
+}
+
+/**
+ *	gsm_send	-	send a control frame
+ *	@gsm: our GSM mux
+ *	@addr: address for control frame
+ *	@cr: command/response bit seen as initiator
+ *	@control:  control byte including PF bit
+ *
+ *	Format up and transmit a control frame. These should be transmitted
+ *	ahead of data when they are needed.
+ */
+static int gsm_send(struct gsm_mux *gsm, int addr, int cr, int control)
+{
+	struct gsm_msg *msg;
+	u8 *dp;
+	int ocr;
+	unsigned long flags;
+
+	msg = gsm_data_alloc(gsm, addr, 0, control);
+	if (!msg) {
+		pr_err("%s: gsm_data_alloc error", __func__);
+		return -ENOMEM;
+	}
+
+	/* toggle C/R coding if not initiator */
+	ocr = cr ^ (gsm->initiator ? 0 : 1);
+
+	msg->data -= 3;
+	dp = msg->data;
+	*dp++ = (addr << 2) | (ocr << 1) | EA;
+	*dp++ = control;
+
+	if (gsm->encoding == GSM_BASIC_OPT)
+		*dp++ = EA; /* Length of data = 0 */
+
+	*dp = 0xFF - gsm_fcs_add_block(INIT_FCS, msg->data, dp - msg->data);
+	msg->len = (dp - msg->data) + 1;
+
+	gsm_print_packet(gsm->num, "Q->", addr, cr, control, NULL, 0);
+
+	spin_lock_irqsave(&gsm->tx_lock, flags);
+	list_add_tail(&msg->list, &gsm->tx0_list);
+	gsm->tx_bytes += msg->len;
+	spin_unlock_irqrestore(&gsm->tx_lock, flags);
+	gsmld_write_trigger(gsm);
+
+	return 0;
+}
+
+/**
+ *	gsm_response	-	send a control response
+ *	@gsm: our GSM mux
+ *	@addr: address for control frame
+ *	@control:  control byte including PF bit
+ *
+ *	Format up and transmit a link level response frame.
+ */
+static inline int gsm_response(struct gsm_mux *gsm, int addr, int control)
+{
+	return gsm_send(gsm, addr, 0, control);
+}
+
+/**
+ *	gsm_command	-	send a control command
+ *	@gsm: our GSM mux
+ *	@addr: address for control frame
+ *	@control:  control byte including PF bit
+ *
+ *	Format up and transmit a link level command frame.
+ */
+static inline int gsm_command(struct gsm_mux *gsm, int addr, int control)
+{
+	return gsm_send(gsm, addr, 1, control);
+}
+
+/**
+ *	gsm_dlci_clear_queues	-	remove outstanding data for a DLCI
+ *	@gsm: mux
+ *	@dlci: clear for this DLCI
+ *
+ *	Clears the data queues for a given DLCI.
+ */
+static void gsm_dlci_clear_queues(struct gsm_mux *gsm, struct gsm_dlci *dlci)
+{
+	struct gsm_msg *msg, *nmsg;
+	int addr = dlci->addr;
+	unsigned long flags;
+
+	/* Clear DLCI write fifo first */
+	spin_lock_irqsave(&dlci->lock, flags);
+	kfifo_reset(&dlci->fifo);
+	spin_unlock_irqrestore(&dlci->lock, flags);
+
+	/* Clear data packets in MUX write queue */
+	spin_lock_irqsave(&gsm->tx_lock, flags);
+	list_for_each_entry_safe(msg, nmsg, &gsm->tx1_list, list) {
+		if (msg->addr != addr)
+			continue;
+		gsm->tx_bytes -= msg->len;
+		list_del(&msg->list);
+		kfree(msg);
+	}
+	spin_unlock_irqrestore(&gsm->tx_lock, flags);
 }
 
 /**
@@ -797,50 +1253,58 @@ static void gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
  *
  *	Caller must hold the tx_lock of the mux.
  */
-
 static int gsm_dlci_data_output(struct gsm_mux *gsm, struct gsm_dlci *dlci)
 {
+	u8 *dp = NULL;
 	struct gsm_msg *msg;
-	u8 *dp;
-	int len, total_size, size;
-	int h = dlci->adaption - 1;
+	int h, len, total_size, size;
 
 	total_size = 0;
-	while (1) {
-		len = kfifo_len(&dlci->fifo);
-		if (len == 0)
-			return total_size;
-
-		/* MTU/MRU count only the data bits */
-		if (len > gsm->mtu)
-			len = gsm->mtu;
-
-		size = len + h;
-
-		msg = gsm_data_alloc(gsm, dlci->addr, size, gsm->ftype);
-		/* FIXME: need a timer or something to kick this so it can't
-		   get stuck with no work outstanding and no buffer free */
-		if (msg == NULL)
-			return -ENOMEM;
-		dp = msg->data;
-		switch (dlci->adaption) {
-		case 1:	/* Unstructured */
-			break;
-		case 2:	/* Unstructed with modem bits.
-		Always one byte as we never send inline break data */
-			*dp++ = gsm_encode_modem(dlci);
-			break;
-		}
-		WARN_ON(kfifo_out_locked(&dlci->fifo, dp , len, &dlci->lock) != len);
-		__gsm_data_queue(dlci, msg);
-		total_size += size;
+	/* for modem bits without break data */
+	h = ((dlci->adaption == 1) ? 0 : 1);
+
+	len = kfifo_len(&dlci->fifo);
+	if (len == 0)
+		return 0;
+
+	/* MTU/MRU count only the data bits but watch adaption mode */
+	if ((len + h) > dlci->mtu)
+		len = dlci->mtu - h;
+
+	size = len + h;
+
+	msg = gsm_data_alloc(gsm, dlci->addr, size, dlci->ftype);
+	if (!msg) {
+		pr_err("gsm_dlci_data_output: gsm_data_alloc error");
+		return -ENOMEM;
+	}
+	dp = msg->data;
+	switch (dlci->adaption) {
+	case 1: /* Unstructured */
+		break;
+	case 2: /* Unstructured with modem bits.
+		 * Always one byte as we never send inline break data
+		 */
+		*dp++ = (gsm_encode_modem(dlci) << 1) | EA;
+		break;
+	default:
+		pr_err("gsm_dlci_data_output: unsupported adaption %d\n",
+		       dlci->adaption);
+		break;
 	}
+
+	WARN_ON(len != kfifo_out_locked(&dlci->fifo, dp, len,
+		&dlci->lock));
+
+	__gsm_data_queue(dlci, msg);
+	total_size += size;
+	dlci->tx += len;
 	/* Bytes of data we used up */
 	return total_size;
 }
 
 /**
- *	gsm_dlci_data_output_framed  -	try and push data out of a DLCI
+ *	gsm_dlci_data_output_framed	-	try and push data out of a DLCI
  *	@gsm: mux
  *	@dlci: the DLCI to pull data from
  *
@@ -850,9 +1314,8 @@ static int gsm_dlci_data_output(struct gsm_mux *gsm, struct gsm_dlci *dlci)
  *
  *	Caller must hold the tx_lock of the mux.
  */
-
 static int gsm_dlci_data_output_framed(struct gsm_mux *gsm,
-						struct gsm_dlci *dlci)
+				       struct gsm_dlci *dlci)
 {
 	struct gsm_msg *msg;
 	u8 *dp;
@@ -865,32 +1328,30 @@ static int gsm_dlci_data_output_framed(struct gsm_mux *gsm,
 		overhead = 1;
 
 	/* dlci->skb is locked by tx_lock */
-	if (dlci->skb == NULL) {
+	if (!dlci->skb) {
 		dlci->skb = skb_dequeue_tail(&dlci->skb_list);
-		if (dlci->skb == NULL)
+		if (!dlci->skb)
 			return 0;
 		first = 1;
 	}
 	len = dlci->skb->len + overhead;
 
 	/* MTU/MRU count only the data bits */
-	if (len > gsm->mtu) {
+	if (len > dlci->mtu) {
 		if (dlci->adaption == 3) {
 			/* Over long frame, bin it */
 			dev_kfree_skb_any(dlci->skb);
 			dlci->skb = NULL;
 			return 0;
 		}
-		len = gsm->mtu;
-	} else
+		len = dlci->mtu;
+	} else {
 		last = 1;
+	}
 
 	size = len + overhead;
-	msg = gsm_data_alloc(gsm, dlci->addr, size, gsm->ftype);
-
-	/* FIXME: need a timer or something to kick this so it can't
-	   get stuck with no work outstanding and no buffer free */
-	if (msg == NULL) {
+	msg = gsm_data_alloc(gsm, dlci->addr, size, dlci->ftype);
+	if (!msg) {
 		skb_queue_tail(&dlci->skb_list, dlci->skb);
 		dlci->skb = NULL;
 		return -ENOMEM;
@@ -899,7 +1360,7 @@ static int gsm_dlci_data_output_framed(struct gsm_mux *gsm,
 
 	if (dlci->adaption == 4) { /* Interruptible framed (Packetised Data) */
 		/* Flag byte to carry the start/end info */
-		*dp++ = last << 7 | first << 6 | 1;	/* EA */
+		*dp++ = last << 7 | first << 6 | 1; /* EA */
 		len--;
 	}
 	memcpy(dp, dlci->skb->data, len);
@@ -913,44 +1374,109 @@ static int gsm_dlci_data_output_framed(struct gsm_mux *gsm,
 }
 
 /**
- *	gsm_dlci_data_sweep		-	look for data to send
+ *	gsm_dlci_modem_output	-	try and push modem status out of a DLCI
+ *	@gsm: mux
+ *	@dlci: the DLCI to pull modem status from
+ *	@brk: break signal
+ *
+ *	Push an empty frame in to the transmit queue to update the modem status
+ *	bits and to transmit an optional break.
+ *
+ *	Caller must hold the tx_lock of the mux.
+ */
+static int gsm_dlci_modem_output(struct gsm_mux *gsm, struct gsm_dlci *dlci,
+				 u8 brk)
+{
+	u8 *dp = NULL;
+	struct gsm_msg *msg;
+	int size;
+
+	/* for modem bits without break data */
+	if (dlci->adaption == 1) {
+		size = 0;
+	} else if (dlci->adaption == 2) {
+		size = 1;
+		if (brk)
+			size++;
+	} else {
+		pr_err("%s: unsupported adaption %d\n", __func__,
+		       dlci->adaption);
+	}
+
+	msg = gsm_data_alloc(gsm, dlci->addr, size, dlci->ftype);
+	if (!msg) {
+		pr_err("%s: gsm_data_alloc error", __func__);
+		return -ENOMEM;
+	}
+	dp = msg->data;
+	switch (dlci->adaption) {
+	case 1: /* Unstructured */
+		break;
+	case 2: /* Unstructured with modem bits. */
+		if (!brk) {
+			*dp++ = (gsm_encode_modem(dlci) << 1) | EA;
+		} else {
+			*dp++ = gsm_encode_modem(dlci) << 1;
+			*dp++ = (brk << 4) | 2 | EA; /* Valid, EA */
+		}
+		break;
+	default:
+		/* Handled above */
+		break;
+	}
+
+	__gsm_data_queue(dlci, msg);
+	return size;
+}
+
+/**
+ *	gsm_dlci_data_sweep	-	look for data to send
  *	@gsm: the GSM mux
  *
  *	Sweep the GSM mux channels in priority order looking for ones with
- *	data to send. We could do with optimising this scan a bit. We aim
+ *	data to send. We could do with optimizing this scan a bit. We aim
  *	to fill the queue totally or up to TX_THRESH_HI bytes. Once we hit
- *	TX_THRESH_LO we get called again
+ *	TX_THRESH_LO we get called again. See GSM 07.10 chapter 5.4.3.2.
  *
  *	FIXME: We should round robin between groups and in theory you can
- *	renegotiate DLCI priorities with optional stuff. Needs optimising.
+ *	renegotiate DLCI priorities with optional stuff. Needs optimizing.
  */
-
-static void gsm_dlci_data_sweep(struct gsm_mux *gsm)
+static int gsm_dlci_data_sweep(struct gsm_mux *gsm)
 {
-	int len;
 	/* Priority ordering: We should do priority with RR of the groups */
-	int i = 1;
-
-	while (i < NUM_DLCI) {
-		struct gsm_dlci *dlci;
+	int i, len, sent, ret = 0;
+	struct gsm_dlci *dlci;
 
-		if (gsm->tx_bytes > TX_THRESH_HI)
-			break;
-		dlci = gsm->dlci[i];
-		if (dlci == NULL || dlci->constipated) {
-			i++;
-			continue;
+	do {
+		for (sent = 0, i = 1; i < NUM_DLCI; i++) {
+			if (gsm->tx_bytes <= TX_THRESH_HI)
+				break;
+			dlci = gsm->dlci[i];
+			/* skip unused or blocked channel */
+			if (!dlci || dlci->constipated)
+				continue;
+			/* skip channels with invalid state */
+			if (dlci->state != DLCI_OPEN)
+				continue;
+			/* count the sent data per adaption */
+			if (dlci->adaption < 3 && !dlci->net)
+				len = gsm_dlci_data_output(gsm, dlci);
+			else
+				len = gsm_dlci_data_output_framed(gsm, dlci);
+			/* on error exit */
+			if (len < 0)
+				return ret;
+			if (len > 0) {
+				ret++;
+				sent = 1;
+				/* The lower DLCs can starve the higher DLCs! */
+				break;
+			}
+			/* try next */
 		}
-		if (dlci->adaption < 3 && !dlci->net)
-			len = gsm_dlci_data_output(gsm, dlci);
-		else
-			len = gsm_dlci_data_output_framed(gsm, dlci);
-		if (len < 0)
-			break;
-		/* DLCI empty - try the next */
-		if (len == 0)
-			i++;
-	}
+	} while (sent && gsm->tx_bytes < TX_THRESH_HI);
+
+	return ret;
 }
 
 /**
@@ -961,85 +1487,81 @@ static void gsm_dlci_data_sweep(struct gsm_mux *gsm)
  *	a tty wakeup except when we filled the pipe so we need to fire off
  *	new data ourselves in other cases.
  */
-
 static void gsm_dlci_data_kick(struct gsm_dlci *dlci)
 {
+	struct gsm_mux *gsm = dlci->gsm;
 	unsigned long flags;
 	int sweep;
 
 	if (dlci->constipated)
 		return;
 
-	spin_lock_irqsave(&dlci->gsm->tx_lock, flags);
+	spin_lock_irqsave(&gsm->tx_lock, flags);
 	/* If we have nothing running then we need to fire up */
-	sweep = (dlci->gsm->tx_bytes < TX_THRESH_LO);
-	if (dlci->gsm->tx_bytes == 0) {
+	sweep = (gsm->tx_bytes < TX_THRESH_LO);
+	if (gsm->tx_bytes == 0) {
 		if (dlci->net)
-			gsm_dlci_data_output_framed(dlci->gsm, dlci);
+			gsm_dlci_data_output_framed(gsm, dlci);
 		else
-			gsm_dlci_data_output(dlci->gsm, dlci);
+			gsm_dlci_data_output(gsm, dlci);
 	}
 	if (sweep)
-		gsm_dlci_data_sweep(dlci->gsm);
-	spin_unlock_irqrestore(&dlci->gsm->tx_lock, flags);
+		gsm_dlci_data_sweep(gsm);
+	spin_unlock_irqrestore(&gsm->tx_lock, flags);
 }
 
-/*
- *	Control message processing
- */
-
-
 /**
- *	gsm_control_reply	-	send a response frame to a control
- *	@gsm: gsm channel
- *	@cmd: the command to use
- *	@data: data to follow encoded info
- *	@dlen: length of data
+ *	gsm_dlci_modem_update	-	update modem state for adaption 2
+ *	@dlci: DLCI to update
+ *	@brk: break signal
  *
- *	Encode up and queue a UI/UIH frame containing our response.
+ *	Send an empty frame to signal mobile state changes and to transmit the
+ *	break signal for adaption 2.
  */
-
-static void gsm_control_reply(struct gsm_mux *gsm, int cmd, const u8 *data,
-					int dlen)
+static void gsm_dlci_modem_update(struct gsm_dlci *dlci, u8 brk)
 {
-	struct gsm_msg *msg;
-	msg = gsm_data_alloc(gsm, 0, dlen + 2, gsm->ftype);
-	if (msg == NULL)
+	struct gsm_mux *gsm = dlci->gsm;
+	unsigned long flags;
+
+	if (dlci->state != DLCI_OPEN || dlci->adaption != 2)
 		return;
-	msg->data[0] = (cmd & 0xFE) << 1 | EA;	/* Clear C/R */
-	msg->data[1] = (dlen << 1) | EA;
-	memcpy(msg->data + 2, data, dlen);
-	gsm_data_queue(gsm->dlci[0], msg);
+
+	spin_lock_irqsave(&gsm->tx_lock, flags);
+	gsm_dlci_modem_output(gsm, dlci, brk);
+	spin_unlock_irqrestore(&gsm->tx_lock, flags);
 }
 
+/*
+ *	Control message processing
+ */
+
 /**
  *	gsm_process_modem	-	process received modem status
  *	@tty: virtual tty bound to the DLCI
  *	@dlci: DLCI to affect
  *	@modem: modem bits (full EA)
- *	@clen: command length
+ *	@slen: number of signal octets
  *
  *	Used when a modem control message or line state inline in adaption
  *	layer 2 is processed. Sort out the local modem state and throttles
  */
-
 static void gsm_process_modem(struct tty_struct *tty, struct gsm_dlci *dlci,
-							u32 modem, int clen)
+			      u32 modem, int slen)
 {
 	int  mlines = 0;
 	u8 brk = 0;
 	int fc;
 
-	/* The modem status command can either contain one octet (v.24 signals)
-	   or two octets (v.24 signals + break signals). The length field will
-	   either be 2 or 3 respectively. This is specified in section
-	   5.4.6.3.7 of the  27.010 mux spec. */
+	/* The modem status command can either contain one octet (V.24 signals)
+	 * or two octets (V.24 signals + break signals). This is specified in
+	 * section 5.4.6.3.7 of the 07.10 mux spec.
+	 */
 
-	if (clen == 2)
-		modem = modem & 0x7f;
-	else {
-		brk = modem & 0x7f;
-		modem = (modem >> 7) & 0x7f;
+	if (slen == 1) {
+		modem = modem & 0x7F;
+	} else {
+		brk = modem & 0x7F;
+		modem = (modem >> 7) & 0x7F;
 	}
 
 	/* Flow control/ready to communicate */
@@ -1071,72 +1593,352 @@ static void gsm_process_modem(struct tty_struct *tty, struct gsm_dlci *dlci,
 	if (brk & 0x01)
 		tty_insert_flip_char(&dlci->port, 0, TTY_BREAK);
 	dlci->modem_rx = mlines;
+	wake_up_all(&dlci->gsm->event);
 }
 
 /**
- *	gsm_control_modem	-	modem status received
+ *	gsm_process_negotiation	-	process received parameters
  *	@gsm: GSM channel
+ *	@addr: DLCI address
+ *	@cr: command/response
  *	@data: data following command
- *	@clen: command length
+ *	@clen: length of data
  *
- *	We have received a modem status control message. This is used by
- *	the GSM mux protocol to pass virtual modem line status and optionally
- *	to indicate break signals. Unpack it, convert to Linux representation
- *	and if need be stuff a break message down the tty.
+ *	Used when the response for our parameter negotiation command was
+ *	received.
  */
-
-static void gsm_control_modem(struct gsm_mux *gsm, const u8 *data, int clen)
+static int gsm_process_negotiation(struct gsm_mux *gsm, int addr, int cr,
+				   const u8 *data, int clen)
 {
-	unsigned int addr = 0;
-	unsigned int modem = 0;
-	unsigned int brk = 0;
-	struct gsm_dlci *dlci;
-	int len = clen;
-	const u8 *dp = data;
-	struct tty_struct *tty;
+	struct gsm_dlci *dlci = gsm->dlci[addr];
+	int ftype, i, adaption, prio, t1, n1, k;
 
-	while (gsm_read_ea(&addr, *dp++) == 0) {
-		len--;
-		if (len == 0)
-			return;
+	if (clen < 8)
+		return -EINVAL;
+
+	i = data[1] & 0x0F;
+	adaption = ((data[1] >> 4) & 0x0F) + 1;
+	prio = data[2] & 0x3F;
+	t1 = data[3];
+	n1 = data[4] | (data[5] << 8);
+	/* n2 = data[6]; */
+	k = data[7] & 0x07;
+
+	if (n1 < MIN_UNIT) {
+		if (debug & DBG_ERRORS)
+			pr_info("%u:%s N1 out of range in PN\n", gsm->num,
+				__func__);
+		return -EINVAL;
 	}
-	/* Must be at least one byte following the EA */
-	len--;
-	if (len <= 0)
-		return;
 
-	addr >>= 1;
-	/* Closed port, or invalid ? */
-	if (addr == 0 || addr >= NUM_DLCI || gsm->dlci[addr] == NULL)
-		return;
-	dlci = gsm->dlci[addr];
+	if (strict) {
+		if (t1 < 1) {
+			if (debug & DBG_ERRORS)
+				pr_info("%u:%s T1 out of range in PN\n",
+					gsm->num, __func__);
+			return -EINVAL;
+		}
+		if (n1 > 32768) {
+			if (debug & DBG_ERRORS)
+				pr_info("%u:%s N1 out of range in PN\n",
+					gsm->num, __func__);
+			return -EINVAL;
+		}
+		if (k < 1) {
+			if (debug & DBG_ERRORS)
+				pr_info("%u:%s k out of range in PN\n",
+					gsm->num, __func__);
+			return -EINVAL;
+		}
+	}
 
-	while (gsm_read_ea(&modem, *dp++) == 0) {
-		len--;
-		if (len == 0)
-			return;
+	switch (i) {
+	case 0x00:
+		ftype = UIH;
+		break;
+	case 0x01:
+		ftype = UI;
+		break;
+	case 0x02: /* I frames are not supported */
+		if (debug & DBG_ERRORS)
+			pr_info("%u:%s unsupported I frame request in PN\n",
+				gsm->num, __func__);
+		return -EINVAL;
+	default:
+		if (debug & DBG_ERRORS)
+			pr_info("%u:%s i out of range in PN\n",
+				gsm->num, __func__);
+		return -EINVAL;
 	}
-	len--;
-	if (len > 0) {
-		while (gsm_read_ea(&brk, *dp++) == 0) {
-			len--;
-			if (len == 0)
-				return;
+
+	if (!cr && gsm->initiator) {
+		if (adaption != dlci->adaption) {
+			if (debug & DBG_ERRORS)
+				pr_info("%u:%s invalid adaption %d in PN\n",
+					gsm->num, __func__, adaption);
+			return -EINVAL;
+		}
+		if (prio != dlci->prio) {
+			if (debug & DBG_ERRORS)
+				pr_info("%u:%s invalid priority %d in PN",
+					gsm->num, __func__, prio);
+			return -EINVAL;
+		}
+		if (n1 > gsm->mru || n1 > dlci->mtu) {
+			/* We requested a frame size but the other party wants
+			 * to send larger frames. The standard allows only a
+			 * smaller response value than requested (5.4.6.3.1).
+			 */
+			if (debug & DBG_ERRORS)
+				pr_info("%u:%s invalid N1 %d in PN\n",
+					gsm->num, __func__, n1);
+			return -EINVAL;
+		}
+		dlci->mtu = n1;
+		if (ftype != dlci->ftype) {
+			if (debug & DBG_ERRORS)
+				pr_info("%u:%s invalid i %d in PN\n",
+					gsm->num, __func__, i);
+			return -EINVAL;
+		}
+		if (ftype != UI && ftype != UIH && k > dlci->k) {
+			if (debug & DBG_ERRORS)
+				pr_info("%u:%s invalid k %d in PN\n",
+						gsm->num, __func__, k);
+			return -EINVAL;
+		}
+		dlci->k = k;
+	} else if (cr && !gsm->initiator) {
+		/* Only convergence layer type 1 and 2 are supported. */
+		if (adaption != 1 && adaption != 2) {
+			if (debug & DBG_ERRORS)
+				pr_info("%u:%s invalid adaption %d in PN\n",
+					gsm->num, __func__, adaption);
+			return -EINVAL;
 		}
+		dlci->adaption = adaption;
+		if (n1 > gsm->mru) {
+			/* Propose a smaller value */
+			dlci->mtu = gsm->mru;
+		} else if (n1 > MAX_MTU) {
+			/* Propose a smaller value */
+			dlci->mtu = MAX_MTU;
+		} else {
+			dlci->mtu = n1;
+		}
+		dlci->prio = prio;
+		dlci->ftype = ftype;
+		dlci->k = k;
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ *	gsm_control_command	-	send a command frame to a control
+ *	@gsm: gsm channel
+ *	@cmd: the command to use
+ *	@data: data to follow encoded info
+ *	@dlen: length of data
+ *
+ *	Encode up and queue a UI/UIH frame containing our command.
+ */
+static int gsm_control_command(struct gsm_mux *gsm, int cmd, u8 *data, int dlen)
+{
+	struct gsm_msg *msg;
+	struct gsm_dlci *dlci = gsm->dlci[0];
+
+	msg = gsm_data_alloc(gsm, 0, dlen + 2, dlci->ftype);
+	if (!msg)
+		return -ENOMEM;
+
+	msg->data[0] = (cmd << 1) | EA;
+	msg->data[1] = (dlen << 1) | EA;
+	memcpy(msg->data + 2, data, dlen);
+	gsm_data_queue(dlci, msg);
+	dlci->tx += dlen;
+
+	return 0;
+}
+
+/**
+ *	gsm_control_reply	-	send a response frame to a control
+ *	@gsm: gsm channel
+ *	@cmd: the command to use
+ *	@data: data to follow encoded info
+ *	@dlen: length of data
+ *
+ *	Encode up and queue a UI/UIH frame containing our response.
+ */
+static void gsm_control_reply(struct gsm_mux *gsm, int cmd, const u8 *data,
+			      int dlen)
+{
+	struct gsm_msg *msg;
+	struct gsm_dlci *dlci = gsm->dlci[0];
+
+	msg = gsm_data_alloc(gsm, 0, dlen + 2, dlci->ftype);
+	if (!msg)
+		return;
+
+	msg->data[0] = (cmd & 0xFE) << 1 | EA; /* clear C/R */
+	msg->data[1] = (dlen << 1) | EA;
+	memcpy(msg->data + 2, data, dlen);
+	gsm_data_queue(dlci, msg);
+	dlci->tx += dlen;
+}
+
+/**
+ *	gsm_control_modem	-	modem status received
+ *	@gsm: GSM channel
+ *	@data: data following command
+ *	@clen: command length
+ *
+ *	We have received a modem status control message. This is used by
+ *	the GSM mux protocol to pass virtual modem line status and optionally
+ *	to indicate break signals. Unpack it, convert to Linux representation
+ *	and if need be stuff a break message down the tty.
+ */
+static void gsm_control_modem(struct gsm_mux *gsm, const u8 *data, int clen)
+{
+	unsigned int addr = 0;
+	unsigned int modem = 0;
+	unsigned int brk = 0;
+	struct gsm_dlci *dlci;
+	int len = clen;
+	int cl = clen;
+	const u8 *dp = data;
+	struct tty_struct *tty;
+
+	len = gsm_read_ea_val(&addr, data, cl);
+
+	if (len < 1)
+		return;
+
+	addr >>= 1;
+	/* Closed port, or invalid? */
+	if (addr == 0 || addr >= NUM_DLCI || !gsm->dlci[addr])
+		return;
+	dlci = gsm->dlci[addr];
+
+	/* Must be at least one byte following the EA */
+	if ((cl - len) < 1)
+		return;
+
+	dp += len;
+	cl -= len;
+
+	/* get the modem status */
+	len = gsm_read_ea_val(&modem, dp, cl);
+
+	if (len < 1)
+		return;
+
+	dp += len;
+	cl -= len;
+
+	/* get any break status */
+	cl = gsm_read_ea_val(&brk, dp, cl);
+
+	if (cl > 0) {
+		len += cl;
 		modem <<= 7;
-		modem |= (brk & 0x7f);
+		modem |= (brk & 0x7F);
 	}
+
+	/* process the modem & break status */
 	tty = tty_port_tty_get(&dlci->port);
-	gsm_process_modem(tty, dlci, modem, clen);
+
 	if (tty) {
+		gsm_process_modem(tty, dlci, modem, len);
 		tty_wakeup(tty);
 		tty_kref_put(tty);
 	}
+
+	/* reply control command */
 	gsm_control_reply(gsm, CMD_MSC, data, clen);
 }
 
 /**
- *	gsm_control_rls		-	remote line status
+ *	gsm_control_negotiation	-	parameter negotiation received
+ *	@gsm: GSM channel
+ *	@cr: command/response flag
+ *	@data: data following command
+ *	@dlen: data length
+ *
+ *	We have received a parameter negotiation message. This is used by
+ *	the GSM mux protocol to configure protocol parameters for a new DLCI.
+ */
+static void gsm_control_negotiation(struct gsm_mux *gsm, int cr, const u8 *data,
+				    int dlen)
+{
+	unsigned int addr;
+	u8 params[8];
+	struct gsm_dlci *dlci;
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s\n", gsm->num, __func__);
+
+	if (dlen < 8) {
+		if (debug & DBG_CALLS)
+			pr_debug("%u:%s done\n", gsm->num, __func__);
+		gsm->open_error++;
+		return;
+	}
+
+	/* Invalid port? */
+	addr = data[0] & 0x3F;
+	if (addr == 0 || addr >= NUM_DLCI || !gsm->dlci[addr]) {
+		if (debug & DBG_CALLS)
+			pr_debug("%u:%s done\n", gsm->num, __func__);
+		gsm->open_error++;
+		return;
+	}
+	dlci = gsm->dlci[addr];
+
+	/* Too late for parameter negotiation? */
+	if ((!cr && dlci->state == DLCI_OPENING) || dlci->state == DLCI_OPEN) {
+		if (debug & DBG_CALLS)
+			pr_debug("%u:%s done\n", gsm->num, __func__);
+		gsm->open_error++;
+		return;
+	}
+
+	/* Process the received parameters */
+	if (gsm_process_negotiation(gsm, addr, cr, data, dlen) != 0) {
+		/* Negotiation failed. Close the link. */
+		if (debug & DBG_ERRORS)
+			pr_info("%u:%s PN failed\n", gsm->num, __func__);
+		gsm->open_error++;
+		gsm_dlci_close(dlci);
+		return;
+	}
+
+	if (cr) {
+		/* Reply command with accepted parameters. */
+		if (gsm_encode_params(dlci, params, sizeof(params)) == 0)
+			gsm_control_reply(gsm, CMD_PN, params, sizeof(params));
+		else if (debug & DBG_ERRORS)
+			pr_info("%u:%s PN invalid\n", gsm->num, __func__);
+	} else if (dlci->state == DLCI_CONFIGURE) {
+		/* Proceed with link setup by sending SABM before UA */
+		dlci->state = DLCI_OPENING;
+		gsm_command(gsm, dlci->addr, SABM|PF);
+		mod_timer(&dlci->t1, jiffies + gsm->t1 * HZ / 100);
+	} else {
+		if (debug & DBG_ERRORS)
+			pr_info("%u:%s PN in invalid state\n", gsm->num,
+				__func__);
+		gsm->open_error++;
+	}
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s done\n", gsm->num, __func__);
+}
+
+/**
+ *	gsm_control_rls	-	remote line status
  *	@gsm: GSM channel
  *	@data: data bytes
  *	@clen: data length
@@ -1145,7 +1947,6 @@ static void gsm_control_modem(struct gsm_mux *gsm, const u8 *data, int clen)
  *	it wishes to send us an error state from the virtual link. Stuff
  *	this into the uplink tty if present
  */
-
 static void gsm_control_rls(struct gsm_mux *gsm, const u8 *data, int clen)
 {
 	struct tty_port *port;
@@ -1164,10 +1965,10 @@ static void gsm_control_rls(struct gsm_mux *gsm, const u8 *data, int clen)
 	if (len <= 0)
 		return;
 	addr >>= 1;
-	/* Closed port, or invalid ? */
-	if (addr == 0 || addr >= NUM_DLCI || gsm->dlci[addr] == NULL)
+	/* Closed port, or invalid? */
+	if (addr == 0 || addr >= NUM_DLCI || !gsm->dlci[addr])
 		return;
-	/* No error ? */
+	/* No error? */
 	bits = *dp;
 	if ((bits & 1) == 0)
 		return;
@@ -1186,9 +1987,6 @@ static void gsm_control_rls(struct gsm_mux *gsm, const u8 *data, int clen)
 	gsm_control_reply(gsm, CMD_RLS, data, clen);
 }
 
-static void gsm_dlci_begin_close(struct gsm_dlci *dlci);
-static void gsm_dlci_close(struct gsm_dlci *dlci);
-
 /**
  *	gsm_control_message	-	DLCI 0 control processing
  *	@gsm: our GSM mux
@@ -1200,36 +1998,24 @@ static void gsm_dlci_close(struct gsm_dlci *dlci);
  *	Processes the incoming request and queues a response frame or an
  *	NSC response if not supported
  */
-
 static void gsm_control_message(struct gsm_mux *gsm, unsigned int command,
-						const u8 *data, int clen)
+				const u8 *data, int clen)
 {
 	u8 buf[1];
-	unsigned long flags;
-	struct gsm_dlci *dlci;
-	int i;
-	int address;
+	struct gsm_dlci *dlci = gsm->dlci[0];
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s %02XH\n", gsm->num, __func__, command);
+
+	if (dlci)
+		dlci->rx += clen;
 
 	switch (command) {
-	case CMD_CLD: {
-		if (addr_cnt > 0) {
-			for (i = 0; i < addr_cnt; i++) {
-				address = addr_open[i];
-				dlci = gsm->dlci[address];
-				gsm_dlci_close(dlci);
-				addr_open[i] = 0;
-			}
-		}
+	case CMD_CLD:
 		/* Modem wishes to close down */
-		dlci = gsm->dlci[0];
-		if (dlci) {
-			dlci->dead = true;
-			gsm->dead = true;
+		if (dlci)
 			gsm_dlci_close(dlci);
-			addr_cnt = 0;
-			gsm_response(gsm, 0, UA|PF);
-		}
-		}
+		gsm->dead = true;
 		break;
 	case CMD_TEST:
 		/* Modem wishes to test, reply with the data */
@@ -1240,9 +2026,7 @@ static void gsm_control_message(struct gsm_mux *gsm, unsigned int command,
 		gsm->constipated = false;
 		gsm_control_reply(gsm, CMD_FCON, NULL, 0);
 		/* Kick the link in case it is idling */
-		spin_lock_irqsave(&gsm->tx_lock, flags);
-		gsm_data_kick(gsm, NULL);
-		spin_unlock_irqrestore(&gsm->tx_lock, flags);
+		gsmld_write_trigger(gsm);
 		break;
 	case CMD_FCOFF:
 		/* Modem wants us to STFU */
@@ -1251,7 +2035,12 @@ static void gsm_control_message(struct gsm_mux *gsm, unsigned int command,
 		break;
 	case CMD_MSC:
 		/* Out of band modem line change indicator for a DLCI */
-		gsm_control_modem(gsm, data, clen);
+		if (!strict || gsm->encoding == GSM_BASIC_OPT) {
+			gsm_control_modem(gsm, data, clen);
+		} else if (debug & DBG_ERRORS) {
+			pr_info("%u:%s unexpected MSC outside basic mode\n",
+				gsm->num, __func__);
+		}
 		break;
 	case CMD_RLS:
 		/* Out of band error reception for a DLCI */
@@ -1261,16 +2050,26 @@ static void gsm_control_message(struct gsm_mux *gsm, unsigned int command,
 		/* Modem wishes to enter power saving state */
 		gsm_control_reply(gsm, CMD_PSC, NULL, 0);
 		break;
-		/* Optional unsupported commands */
-	case CMD_PN:	/* Parameter negotiation */
-	case CMD_RPN:	/* Remote port negotiation */
-	case CMD_SNC:	/* Service negotiation command */
+	case CMD_NSC:
+		/* Is there a matching pending command? */
+		pr_err("%s: unexpected NSC command\n", __func__);
+		break;
+	/* Optional commands */
+	case CMD_PN:
+		/* Modem sends a parameter negotiation command */
+		gsm_control_negotiation(gsm, 1, data, clen);
+		break;
+	/* Optional unsupported commands */
+	case CMD_RPN:   /* Remote port negotiation */
+	case CMD_SNC:   /* Service negotiation command */
 	default:
 		/* Reply to bad commands with an NSC */
 		buf[0] = command;
 		gsm_control_reply(gsm, CMD_NSC, buf, 1);
 		break;
 	}
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s done\n", gsm->num, __func__);
 }
 
 /**
@@ -1285,29 +2084,46 @@ static void gsm_control_message(struct gsm_mux *gsm, unsigned int command,
  *	is done by the caller, we just update the fields, flag it as done
  *	and return
  */
-
 static void gsm_control_response(struct gsm_mux *gsm, unsigned int command,
-						const u8 *data, int clen)
+				 const u8 *data, int clen)
 {
 	struct gsm_control *ctrl;
+	struct gsm_dlci *dlci;
 	unsigned long flags;
 
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s %02XH\n", gsm->num, __func__, command);
+
 	spin_lock_irqsave(&gsm->control_lock, flags);
 
 	ctrl = gsm->pending_cmd;
-	/* Does the reply match our command */
+	dlci = gsm->dlci[0];
+	if (dlci)
+		dlci->rx += clen;
 	command |= 1;
-	if (ctrl != NULL && (command == ctrl->cmd || command == CMD_NSC)) {
+	/* Does the reply match our command */
+	if (ctrl && (command == ctrl->cmd || command == CMD_NSC)) {
 		/* Our command was replied to, kill the retry timer */
 		del_timer(&gsm->t2_timer);
 		gsm->pending_cmd = NULL;
 		/* Rejected by the other end */
 		if (command == CMD_NSC)
 			ctrl->error = -EOPNOTSUPP;
-		ctrl->done = 1;
-		wake_up(&gsm->event);
+		ctrl->done = true;
+		wake_up_all(&gsm->event);
+	/* Or did we receive the PN response to our PN command */
+	} else if (command == CMD_PN) {
+		gsm_control_negotiation(gsm, 0, data, clen);
+	/* Or did we receive the TEST response to our TEST command */
+	} else if (command == CMD_TEST && clen == 1 && *data == gsm->ka_num) {
+		gsm->ka_retries = -1; /* trigger new keep-alive message */
+		if (dlci && !dlci->dead)
+			mod_timer(&gsm->ka_timer,
+				  jiffies + gsm->keep_alive * HZ / 100);
 	}
 	spin_unlock_irqrestore(&gsm->control_lock, flags);
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s done\n", gsm->num, __func__);
 }
 
 /**
@@ -1317,15 +2133,22 @@ static void gsm_control_response(struct gsm_mux *gsm, unsigned int command,
  *
  *	Send out a pending control command (called under control lock)
  */
-
 static void gsm_control_transmit(struct gsm_mux *gsm, struct gsm_control *ctrl)
 {
-	struct gsm_msg *msg = gsm_data_alloc(gsm, 0, ctrl->len + 1, gsm->ftype);
-	if (msg == NULL)
+	struct gsm_msg *msg;
+	struct gsm_dlci *dlci = gsm->dlci[0];
+
+	if (!dlci)
 		return;
-	msg->data[0] = (ctrl->cmd << 1) | 2 | EA;	/* command */
-	memcpy(msg->data + 1, ctrl->data, ctrl->len);
-	gsm_data_queue(gsm->dlci[0], msg);
+	msg = gsm_data_alloc(gsm, 0, ctrl->len + 2, dlci->ftype);
+	if (!msg)
+		return;
+
+	msg->data[0] = (ctrl->cmd << 1) | CR | EA; /* set C/R */
+	msg->data[1] = (ctrl->len << 1) | EA;
+	memcpy(msg->data + 2, ctrl->data, ctrl->len);
+	gsm_data_queue(dlci, msg);
+	dlci->tx += ctrl->len;
 }
 
 /**
@@ -1338,28 +2161,34 @@ static void gsm_control_transmit(struct gsm_mux *gsm, struct gsm_control *ctrl)
  *	In that situation the timer may still occur in a small window but
  *	gsm->pending_cmd will be NULL and we just let the timer expire.
  */
-
 static void gsm_control_retransmit(struct timer_list *t)
 {
 	struct gsm_mux *gsm = from_timer(gsm, t, t2_timer);
 	struct gsm_control *ctrl;
 	unsigned long flags;
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s\n", gsm->num, __func__);
+
 	spin_lock_irqsave(&gsm->control_lock, flags);
 	ctrl = gsm->pending_cmd;
 	if (ctrl) {
 		gsm->cretries--;
-		if (gsm->cretries == 0) {
+		if (gsm->cretries == 0 || !gsm->dlci[0] || gsm->dlci[0]->dead) {
 			gsm->pending_cmd = NULL;
 			ctrl->error = -ETIMEDOUT;
-			ctrl->done = 1;
+			ctrl->done = true;
 			spin_unlock_irqrestore(&gsm->control_lock, flags);
-			wake_up(&gsm->event);
+			wake_up_all(&gsm->event);
 			return;
 		}
 		gsm_control_transmit(gsm, ctrl);
 		mod_timer(&gsm->t2_timer, jiffies + gsm->t2 * HZ / 100);
 	}
 	spin_unlock_irqrestore(&gsm->control_lock, flags);
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s done\n", gsm->num, __func__);
 }
 
 /**
@@ -1373,19 +2202,24 @@ static void gsm_control_retransmit(struct timer_list *t)
  *	active at a time. In theory more can be outstanding but the matching
  *	gets really complicated so for now stick to one outstanding.
  */
-
 static struct gsm_control *gsm_control_send(struct gsm_mux *gsm,
 		unsigned int command, u8 *data, int clen)
 {
 	struct gsm_control *ctrl = kzalloc(sizeof(struct gsm_control),
-						GFP_KERNEL);
+					   GFP_KERNEL);
 	unsigned long flags;
-	if (ctrl == NULL)
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s cmd %x len %d\n", gsm->num, __func__, command,
+			 clen);
+
+	if (!ctrl)
 		return NULL;
+
 retry:
-	wait_event(gsm->event, gsm->pending_cmd == NULL);
+	wait_event_interruptible(gsm->event, gsm->pending_cmd == NULL);
 	spin_lock_irqsave(&gsm->control_lock, flags);
-	if (gsm->pending_cmd != NULL) {
+	if (gsm->pending_cmd) {
 		spin_unlock_irqrestore(&gsm->control_lock, flags);
 		goto retry;
 	}
@@ -1415,75 +2249,348 @@ static struct gsm_control *gsm_control_send(struct gsm_mux *gsm,
  *	resources and returns 0 for success, or an error if the remote
  *	rejected or ignored the request.
  */
-
 static int gsm_control_wait(struct gsm_mux *gsm, struct gsm_control *control)
 {
 	int err;
-	wait_event(gsm->event, control->done == 1);
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s\n", gsm->num, __func__);
+	wait_event(gsm->event, control->done != false);
 	err = control->error;
 	kfree(control);
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s done %d\n", gsm->num, __func__, err);
 	return err;
 }
 
-
 /*
- *	DLCI level handling: Needs krefs
+ *	State transitions and timers
  */
 
-/*
- *	State transitions and timers
+/**
+ *	gsm_control_keep_alive	-	check timeout or start keep-alive
+ *	@t: timer contained in our gsm object
+ *
+ *	Called off the keep-alive timer expiry signaling that our link
+ *	partner is not responding anymore. Link will be closed.
+ *	This is also called to startup our timer.
  */
+static void gsm_control_keep_alive(struct timer_list *t)
+{
+	struct gsm_mux *gsm = from_timer(gsm, t, ka_timer);
+	unsigned long flags;
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s\n", gsm->num, __func__);
+
+	spin_lock_irqsave(&gsm->control_lock, flags);
+	if (gsm->ka_num && gsm->ka_retries == 0) {
+		/* Keep-alive expired -> close the link */
+		if (debug & DBG_ERRORS)
+			pr_info("%u:%s keep-alive timed out\n", gsm->num,
+				__func__);
+		if (gsm->dlci[0])
+			gsm_dlci_begin_close(gsm->dlci[0]);
+	} else if (gsm->keep_alive && gsm->dlci[0] && !gsm->dlci[0]->dead) {
+		if (gsm->ka_retries > 0) {
+			/* T2 expired for keep-alive -> resend */
+			gsm->ka_retries--;
+		} else {
+			/* Start keep-alive timer */
+			gsm->ka_num++;
+			if (!gsm->ka_num)
+				gsm->ka_num++;
+			gsm->ka_retries = gsm->n2;
+		}
+		gsm_control_command(gsm, CMD_TEST, &gsm->ka_num,
+				    sizeof(gsm->ka_num));
+		mod_timer(&gsm->ka_timer,
+			  jiffies + gsm->t2 * HZ / 100);
+	}
+	spin_unlock_irqrestore(&gsm->control_lock, flags);
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s done\n", gsm->num, __func__);
+}
 
 /**
- *	gsm_dlci_close		-	a DLCI has closed
+ *	gsm_dlci_close	-	a DLCI has closed
  *	@dlci: DLCI that closed
  *
  *	Perform processing when moving a DLCI into closed state. If there
  *	is an attached tty this is hung up
  */
-
 static void gsm_dlci_close(struct gsm_dlci *dlci)
 {
+	struct gsm_mux *gsm = dlci->gsm;
+
+	if (!gsm) {
+		pr_err("%s: gsm == NULL\n", __func__);
+		return;
+	}
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s\n", gsm->num, __func__);
+
 	del_timer(&dlci->t1);
-	if (debug & 8)
-		pr_debug("DLCI %d goes closed.\n", dlci->addr);
+
+	if (debug & DBG_ERRORS)
+		pr_info("%u:%s DLCI[%d] goes closed\n", gsm->num, __func__,
+			dlci->addr);
+
 	dlci->state = DLCI_CLOSED;
+	/* Prevent us from sending data before the link is up again */
+	dlci->constipated = true;
 	if (dlci->addr != 0) {
 		tty_port_tty_hangup(&dlci->port, false);
-		kfifo_reset(&dlci->fifo);
-	} else
-		dlci->gsm->dead = true;
-	/* Unregister gsmtty driver,report gsmtty dev remove uevent for user */
-	tty_unregister_device(gsm_tty_driver, dlci->addr);
-	wake_up(&dlci->gsm->event);
-	/* A DLCI 0 close is a MUX termination so we need to kick that
-	   back to userspace somehow */
+		gsm_dlci_clear_queues(gsm, dlci);
+		/* Ensure that gsmtty_open() can return. */
+		tty_port_set_initialized(&dlci->port, 0);
+		wake_up_interruptible(&dlci->port.open_wait);
+	} else {
+		del_timer(&gsm->ka_timer);
+		/* Avoid hangup during disconnect in mux cleanup. */
+		if (!gsm->dead)
+			tty_hangup(gsm->tty);
+		gsm->dead = true;
+		/* Queues cannot be cleared yet. This is done during the hangup
+		 * procedure.
+		 */
+	}
+	/* A DLCI 0 close is a MUX termination so we need to
+	 * kick that back to user space somehow
+	 */
+	wake_up_all(&gsm->event);
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s done\n", gsm->num, __func__);
 }
 
 /**
- *	gsm_dlci_open		-	a DLCI has opened
+ *	gsm_dlci_open	-	a DLCI has opened
  *	@dlci: DLCI that opened
  *
  *	Perform processing when moving a DLCI into open state.
  */
-
 static void gsm_dlci_open(struct gsm_dlci *dlci)
 {
+	struct gsm_mux *gsm = dlci->gsm;
+
 	/* Note that SABM UA .. SABM UA first UA lost can mean that we go
-	   open -> open */
+	 * open -> open
+	 */
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s\n", gsm->num, __func__);
+
 	del_timer(&dlci->t1);
 	/* This will let a tty open continue */
 	dlci->state = DLCI_OPEN;
-	if (debug & 8)
-		pr_debug("DLCI %d goes open.\n", dlci->addr);
-	/* Register gsmtty driver,report gsmtty dev add uevent for user */
-	tty_register_device(gsm_tty_driver, dlci->addr, NULL);
-	wake_up(&dlci->gsm->event);
+	dlci->constipated = false;
+	if (debug & DBG_ERRORS)
+		pr_info("%u:DLCI %d goes open.\n", gsm->num, dlci->addr);
+	if (dlci->addr) { /* Send current modem state */
+		gsm_dlci_modem_update(dlci, 0);
+	} else {	  /* Start keep-alive control */
+		gsm->ka_num = 0;
+		gsm->ka_retries = -1;
+		mod_timer(&gsm->ka_timer,
+			  jiffies + gsm->keep_alive * HZ / 100);
+	}
+	gsm_dlci_data_kick(dlci);
+	wake_up_all(&dlci->gsm->event);
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s done\n", gsm->num, __func__);
 }
 
 /**
- *	gsm_dlci_t1		-	T1 timer expiry
- *	@t: timer contained in the DLCI that opened
+ *	gsm_dlci_negotiation	-	start parameter negotiation
+ *	@dlci: DLCI to open
+ *
+ *	Starts the parameter negotiation for the new DLCI. This needs to be done
+ *	before the DLCI initialized the channel via SABM.
+ */
+static int gsm_dlci_negotiation(struct gsm_dlci *dlci)
+{
+	struct gsm_mux *gsm = dlci->gsm;
+	u8 params[8];
+	int ret;
+
+	ret = gsm_encode_params(dlci, params, sizeof(params));
+	if (ret != 0)
+		return ret;
+
+	/* We cannot asynchronous wait for the command response with
+	 * gsm_command and gsm_control_wait at this point.
+	 */
+	ret = gsm_control_command(gsm, CMD_PN, params, sizeof(params));
+
+	return ret;
+}
+
+/**
+ *	gsm_dlci_begin_open	-	start channel open procedure
+ *	@dlci: DLCI to open
+ *
+ *	Commence opening a DLCI from the Linux side. We issue SABM messages
+ *	to the modem which should then reply with a UA or ADM, at which point
+ *	we will move into open state. Opening is done asynchronously with retry
+ *	running off timers and the responses.
+ *	Parameter negotiation is performed before SABM if required.
+ */
+static void gsm_dlci_begin_open(struct gsm_dlci *dlci)
+{
+	struct gsm_mux *gsm = dlci ? dlci->gsm : NULL;
+	int need_pn = 0;
+
+	if (!dlci || !gsm) {
+		pr_info("%s: dlci %p gsm %p\n", __func__, dlci, gsm);
+		return;
+	}
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s\n", gsm->num, __func__);
+
+	if (dlci->addr != 0) {
+		if (gsm->adaption != 1 || gsm->adaption != dlci->adaption)
+			need_pn = 1;
+		if (dlci->prio != ((((dlci->addr / 8) + 1) * 8) - 1))
+			need_pn = 1;
+		if (gsm->ftype != dlci->ftype)
+			need_pn = 1;
+	}
+
+	dlci->tx = 0;
+	dlci->rx = 0;
+
+	switch (dlci->state) {
+	case DLCI_CLOSED:
+	case DLCI_WAITING:
+	case DLCI_CLOSING:
+		dlci->retries = gsm->n2;
+		if (!need_pn) {
+			dlci->state = DLCI_OPENING;
+			gsm_command(gsm, dlci->addr, SABM|PF);
+		} else {
+			/* Configure DLCI before setup */
+			dlci->state = DLCI_CONFIGURE;
+			if (gsm_dlci_negotiation(dlci) == -EINVAL) {
+				gsm_dlci_close(dlci);
+				if (debug & DBG_CALLS)
+					pr_debug("%u:%s done\n", gsm->num,
+						 __func__);
+				return;
+			}
+		}
+		mod_timer(&dlci->t1, jiffies + gsm->t1 * HZ / 100);
+		break;
+	default:
+		break;
+	}
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s done\n", gsm->num, __func__);
+}
+
+/**
+ *	gsm_dlci_wait_open	-	wait for channel open procedure
+ *	@dlci: DLCI to open
+ *
+ *	Wait for a DLCI opening from the other side. Asynchronously wait until
+ *	we get a SABM and set off timers and the responses.
+ */
+static void gsm_dlci_wait_open(struct gsm_dlci *dlci)
+{
+	struct gsm_mux *gsm = dlci ? dlci->gsm : NULL;
+
+	if (!dlci || !gsm) {
+		pr_info("%s: dlci %p gsm %p\n", __func__, dlci, gsm);
+		return;
+	}
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s\n", gsm->num, __func__);
+
+	dlci->tx = 0;
+	dlci->rx = 0;
+
+	switch (dlci->state) {
+	case DLCI_CLOSED:
+	case DLCI_WAITING:
+	case DLCI_CLOSING:
+		dlci->state = DLCI_OPENING;
+		break;
+	default:
+		break;
+	}
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s done\n", gsm->num, __func__);
+}
+
+/**
+ *	gsm_dlci_wait_config	-	wait for channel configuration
+ *	@dlci: DLCI to configure
+ *
+ *	Wait for a DLCI configuration from the application.
+ */
+static void gsm_dlci_wait_config(struct gsm_dlci *dlci)
+{
+	struct gsm_mux *gsm = dlci ? dlci->gsm : NULL;
+
+	if (!dlci || !gsm) {
+		pr_info("%s: dlci %p gsm %p\n", __func__, dlci, gsm);
+		return;
+	}
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s\n", gsm->num, __func__);
+
+	dlci->tx = 0;
+	dlci->rx = 0;
+
+	if (dlci->state == DLCI_CLOSED || dlci->state == DLCI_CLOSING)
+		dlci->state = DLCI_WAITING;
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s done\n", gsm->num, __func__);
+}
+
+/**
+ *	gsm_dlci_begin_close	-	start channel open procedure
+ *	@dlci: DLCI to open
+ *
+ *	Commence closing a DLCI from the Linux side. We issue DISC messages
+ *	to the modem which should then reply with a UA, at which point we
+ *	will move into closed state. Closing is done asynchronously with retry
+ *	off timers. We may also receive a DM reply from the other end which
+ *	indicates the channel was already closed.
+ */
+static void gsm_dlci_begin_close(struct gsm_dlci *dlci)
+{
+	struct gsm_mux *gsm = dlci->gsm;
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s\n", gsm->num, __func__);
+
+	switch (dlci->state) {
+	case DLCI_CONFIGURE:
+	case DLCI_OPEN:
+	case DLCI_OPENING:
+		dlci->retries = gsm->n2;
+		dlci->state = DLCI_CLOSING;
+		gsm_command(dlci->gsm, dlci->addr, DISC|PF);
+		mod_timer(&dlci->t1, jiffies + gsm->t1 * HZ / 100);
+		break;
+	default:
+		break;
+	}
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s done\n", gsm->num, __func__);
+}
+
+/**
+ *	gsm_dlci_t1	-	T1 timer expiry
+ *	@t: timer contained in our gsm object
  *
  *	The T1 timer handles retransmits of control frames (essentially of
  *	SABM and DISC). We resend the command until the retry count runs out
@@ -1491,170 +2598,301 @@ static void gsm_dlci_open(struct gsm_dlci *dlci)
  *	is simply put into closed state (any further frames from the other
  *	end will get a DM response)
  *
- *	Some control dlci can stay in ADM mode with other dlci working just
- *	fine. In that case we can just keep the control dlci open after the
+ *	Some control DLCI can stay in ADM mode with other DLCI working just
+ *	fine. In that case we can just keep the control DLCI open after the
  *	DLCI_OPENING retries time out.
  */
-
 static void gsm_dlci_t1(struct timer_list *t)
 {
 	struct gsm_dlci *dlci = from_timer(dlci, t, t1);
+
 	struct gsm_mux *gsm = dlci->gsm;
 
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s\n", gsm->num, __func__);
+
 	switch (dlci->state) {
+	case DLCI_CONFIGURE:
+		dlci->retries--;
+		if (dlci->retries && gsm_dlci_negotiation(dlci) != -EINVAL) {
+			mod_timer(&dlci->t1, jiffies + gsm->t1 * HZ / 100);
+		} else {
+			gsm->open_error++;
+			gsm_dlci_begin_close(dlci); /* prevent half open link */
+		}
+		break;
 	case DLCI_OPENING:
 		dlci->retries--;
 		if (dlci->retries) {
 			gsm_command(dlci->gsm, dlci->addr, SABM|PF);
 			mod_timer(&dlci->t1, jiffies + gsm->t1 * HZ / 100);
 		} else if (!dlci->addr && gsm->control == (DM | PF)) {
-			if (debug & 8)
+			if (debug & DBG_ERRORS)
 				pr_info("DLCI %d opening in ADM mode.\n",
 					dlci->addr);
-			dlci->mode = DLCI_MODE_ADM;
 			gsm_dlci_open(dlci);
 		} else {
-			gsm_dlci_close(dlci);
+			gsm->open_error++;
+			gsm_dlci_begin_close(dlci); /* prevent half open link */
 		}
-
 		break;
 	case DLCI_CLOSING:
 		dlci->retries--;
 		if (dlci->retries) {
 			gsm_command(dlci->gsm, dlci->addr, DISC|PF);
 			mod_timer(&dlci->t1, jiffies + gsm->t1 * HZ / 100);
-		} else
+		} else {
 			gsm_dlci_close(dlci);
+		}
 		break;
 	default:
 		pr_debug("%s: unhandled state: %d\n", __func__, dlci->state);
 		break;
 	}
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s done\n", gsm->num, __func__);
 }
 
 /**
- *	gsm_dlci_begin_open	-	start channel open procedure
- *	@dlci: DLCI to open
+ *	gsm_dlci_data	-	data arrived
+ *	@dlci: channel
+ *	@data: block of bytes received
+ *	@clen: length of received block
  *
- *	Commence opening a DLCI from the Linux side. We issue SABM messages
- *	to the modem which should then reply with a UA or ADM, at which point
- *	we will move into open state. Opening is done asynchronously with retry
- *	running off timers and the responses.
+ *	A UI or UIH frame has arrived which contains data for a channel
+ *	other than the control channel. If the relevant virtual tty is
+ *	open we shovel the bits down it, if not we drop them.
  */
+static void gsm_dlci_data(struct gsm_dlci *dlci, const u8 *data, int clen)
+{
+	/* krefs .. */
+	struct tty_port *port = &dlci->port;
+	struct tty_struct *tty;
+	unsigned int modem = 0;
+	int len = clen;
+	int flip = 0;
 
-static void gsm_dlci_begin_open(struct gsm_dlci *dlci)
+	if (debug & DBG_TTY)
+		pr_debug("%u:%s %d bytes for tty %d\n", dlci->gsm->num,
+			 __func__, clen, dlci->addr);
+
+	switch (dlci->adaption)  {
+		/* Unsupported types */
+	case 4:
+		/* Packetised interruptible data */
+		break;
+	case 3:
+		/* Packetised uninterruptible voice/data */
+		break;
+	case 2:
+		/* Asynchronous serial with line state in each frame */
+		len = gsm_read_ea_val(&modem, data, clen);
+		if (len < 1) {
+			pr_err("%u:%s len error\n", dlci->gsm->num, __func__);
+			return;
+		}
+		tty = tty_port_tty_get(port);
+		if (tty) {
+			gsm_process_modem(tty, dlci, modem, len);
+			tty_wakeup(tty);
+			tty_kref_put(tty);
+		}
+		/* Skip processed modem data */
+		data += len;
+		clen -= len;
+		if (clen < 1)
+			return; /* Empty frame without data */
+		fallthrough;
+	case 1:
+	default:
+		/* Line state will go via DLCI 0 controls only */
+		dlci->rx += clen;
+		flip = tty_insert_flip_string(port, data, clen);
+		if (flip < clen)
+			pr_err("%u:%s upstream flow %d off\n", dlci->gsm->num,
+			       __func__, dlci->addr);
+		tty_flip_buffer_push(port);
+		break;
+	}
+	if (debug & DBG_TTY)
+		pr_debug("%u:%s %d bytes for tty %d sent\n", dlci->gsm->num,
+			 __func__, clen, dlci->addr);
+}
+
+/**
+ *	gsm_dlci_command	-	data arrived on control channel
+ *	@dlci: channel
+ *	@data: block of bytes received
+ *	@len: length of received block
+ *
+ *	A UI or UIH frame has arrived which contains data for DLCI 0 the
+ *	control channel. This should contain a command EA followed by
+ *	control data bytes. The command EA contains a command/response bit
+ *	and we divide up the work accordingly.
+ */
+static void gsm_dlci_command(struct gsm_dlci *dlci, const u8 *data, int len)
 {
-	struct gsm_mux *gsm = dlci->gsm;
-	if (dlci->state == DLCI_OPEN || dlci->state == DLCI_OPENING)
+	/* See what command is involved */
+	unsigned int command = 0;
+	const u8 *dp = data;
+	int clen = 0;
+	int dlen;
+
+	/* read the command */
+	dlen = gsm_read_ea_val(&command, dp, len);
+	len -= dlen;
+	dp += dlen;
+
+	/* read any control data */
+	dlen = gsm_read_ea_val(&clen, dp, len);
+	len -= dlen;
+	dp += dlen;
+
+	if (clen > len) {
+		pr_err("%u:%s malformed %d>%d?\n", dlci->gsm->num, __func__,
+		       clen, len);
+		/* malformed? */
 		return;
-	dlci->retries = gsm->n2;
-	dlci->state = DLCI_OPENING;
-	gsm_command(dlci->gsm, dlci->addr, SABM|PF);
-	mod_timer(&dlci->t1, jiffies + gsm->t1 * HZ / 100);
+	}
+
+	if (command & 1)
+		gsm_control_message(dlci->gsm, command, dp, clen);
+	else
+		gsm_control_response(dlci->gsm, command, dp, clen);
+	return;
 }
 
 /**
- *	gsm_dlci_begin_close	-	start channel open procedure
- *	@dlci: DLCI to open
+ *	gsm_kick_timer	-	transmit if possible
+ *	@t: timer contained in our gsm object
  *
- *	Commence closing a DLCI from the Linux side. We issue DISC messages
- *	to the modem which should then reply with a UA, at which point we
- *	will move into closed state. Closing is done asynchronously with retry
- *	off timers. We may also receive a DM reply from the other end which
- *	indicates the channel was already closed.
+ *	Transmit data from DLCIs if the queue is empty. We can't rely on
+ *	a tty wakeup except when we filled the pipe so we need to fire off
+ *	new data ourselves in other cases.
  */
-
-static void gsm_dlci_begin_close(struct gsm_dlci *dlci)
+static void gsm_kick_timer(struct timer_list *t)
 {
-	struct gsm_mux *gsm = dlci->gsm;
-	if (dlci->state == DLCI_CLOSED || dlci->state == DLCI_CLOSING)
-		return;
-	dlci->retries = gsm->n2;
-	dlci->state = DLCI_CLOSING;
-	gsm_command(dlci->gsm, dlci->addr, DISC|PF);
-	mod_timer(&dlci->t1, jiffies + gsm->t1 * HZ / 100);
+	struct gsm_mux *gsm = from_timer(gsm, t, kick_timer);
+	unsigned long flags;
+	int sent = 0;
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s\n", gsm->num, __func__);
+
+	spin_lock_irqsave(&gsm->tx_lock, flags);
+	/* If we have nothing running then we need to fire up */
+	if (gsm->tx_bytes < TX_THRESH_LO)
+		sent = gsm_dlci_data_sweep(gsm);
+	spin_unlock_irqrestore(&gsm->tx_lock, flags);
+
+	if (sent && debug & DBG_DATA)
+		pr_info("%u:%s TX queue stalled\n", gsm->num, __func__);
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s done\n", gsm->num, __func__);
 }
 
 /**
- *	gsm_dlci_data		-	data arrived
- *	@dlci: channel
- *	@data: block of bytes received
- *	@clen: length of received block
+ *	gsm_dlci_config	-	configure a DLCI
+ *	@dlci: DLCI to configure
+ *	@dc: new configuration
+ *	@open: open the DLCI if closed?
  *
- *	A UI or UIH frame has arrived which contains data for a channel
- *	other than the control channel. If the relevant virtual tty is
- *	open we shovel the bits down it, if not we drop them.
+ *	Set a specific configuration to the given DLCI to apply different
+ *	parameters than given for the control channel.
  */
+static int gsm_dlci_config(struct gsm_dlci *dlci, struct gsm_dlci_config *dc,
+			   int open)
+{
+	bool need_restart = false;
+	struct gsm_mux *gsm = dlci->gsm;
+	bool need_open = false;
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s\n", gsm->num, __func__);
+
+	if (!dlci)
+		return -EINVAL;
+	/* Stuff we don't support yet - I frame transport */
+	if (dc->adaption != 1 && dc->adaption != 2)
+		return -EOPNOTSUPP;
+	if (dc->mtu != 0 && (dc->mtu < MIN_UNIT || dc->mtu >= MAX_MTU))
+		return -EINVAL;
+	if (strict && dc->mtu > 32768)
+		return -EINVAL;
+	if (dc->mtu > gsm->mru)
+		return -EINVAL;
+	if (dc->priority >= 64)
+		return -EINVAL;
+	if (dc->i == 0 || dc->i > 2)  /* UIH and UI only */
+		return -EINVAL;
+	if (dc->k > 7)
+		return -EINVAL;
+
+	/*
+	 * See what is needed for reconfiguration
+	 */
+	/* Framing fields */
+	if (dc->adaption != dlci->adaption)
+		need_restart = true;
+	if (dc->mtu != dlci->mtu)
+		need_restart = true;
+	if (dc->i != dlci->ftype)
+		need_restart = true;
+	/* Requires care */
+	if (dc->priority != dlci->prio)
+		need_restart = true;
+	if (dc->restart)
+		need_restart = true;
+
+	if ((open && gsm->wait_config) || need_restart)
+		need_open = true;
+	if (dlci->state == DLCI_WAITING)
+		need_open = true;
+
+	/*
+	 * Close down what is needed, restart and initiate the new
+	 * configuration.
+	 */
+	if (need_restart)
+		gsm_dlci_begin_close(dlci);
 
-static void gsm_dlci_data(struct gsm_dlci *dlci, const u8 *data, int clen)
-{
-	/* krefs .. */
-	struct tty_port *port = &dlci->port;
-	struct tty_struct *tty;
-	unsigned int modem = 0;
-	int len = clen;
+	/*
+	 * Setup the new configuration values
+	 */
+	dlci->adaption = dc->adaption;
 
-	if (debug & 16)
-		pr_debug("%d bytes for tty\n", len);
-	switch (dlci->adaption)  {
-	/* Unsupported types */
-	case 4:		/* Packetised interruptible data */
-		break;
-	case 3:		/* Packetised uininterruptible voice/data */
-		break;
-	case 2:		/* Asynchronous serial with line state in each frame */
-		while (gsm_read_ea(&modem, *data++) == 0) {
-			len--;
-			if (len == 0)
-				return;
-		}
-		tty = tty_port_tty_get(port);
-		if (tty) {
-			gsm_process_modem(tty, dlci, modem, clen);
-			tty_kref_put(tty);
-		}
-		fallthrough;
-	case 1:		/* Line state will go via DLCI 0 controls only */
-	default:
-		tty_insert_flip_string(port, data, len);
-		tty_flip_buffer_push(port);
-	}
-}
+	if (dlci->mtu)
+		dlci->mtu = dc->mtu;
+	else
+		dlci->mtu = gsm->mtu;
 
-/**
- *	gsm_dlci_command	-	data arrived on control channel
- *	@dlci: channel
- *	@data: block of bytes received
- *	@len: length of received block
- *
- *	A UI or UIH frame has arrived which contains data for DLCI 0 the
- *	control channel. This should contain a command EA followed by
- *	control data bytes. The command EA contains a command/response bit
- *	and we divide up the work accordingly.
- */
+	if (dc->priority)
+		dlci->prio = dc->priority;
+	else
+		dlci->prio = ((((dlci->addr / 8) + 1) * 8) - 1);
 
-static void gsm_dlci_command(struct gsm_dlci *dlci, const u8 *data, int len)
-{
-	/* See what command is involved */
-	unsigned int command = 0;
-	while (len-- > 0) {
-		if (gsm_read_ea(&command, *data++) == 1) {
-			int clen = *data++;
-			len--;
-			/* FIXME: this is properly an EA */
-			clen >>= 1;
-			/* Malformed command ? */
-			if (clen > len)
-				return;
-			if (command & 1)
-				gsm_control_message(dlci->gsm, command,
-								data, clen);
-			else
-				gsm_control_response(dlci->gsm, command,
-								data, clen);
-			return;
-		}
+	if (dc->i == 1)
+		dlci->ftype = UIH;
+	else if (dc->i == 2)
+		dlci->ftype = UI;
+
+	if (dc->k)
+		dlci->k = dc->k;
+	else
+		dlci->k = gsm->k;
+
+	if (need_open) {
+		if (gsm->initiator)
+			gsm_dlci_begin_open(dlci);
+		else
+			gsm_dlci_wait_open(dlci);
 	}
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s done\n", gsm->num, __func__);
+	return 0;
 }
 
 /*
@@ -1662,7 +2900,7 @@ static void gsm_dlci_command(struct gsm_dlci *dlci, const u8 *data, int len)
  */
 
 /**
- *	gsm_dlci_alloc		-	allocate a DLCI
+ *	gsm_dlci_alloc	-	allocate a DLCI
  *	@gsm: GSM mux
  *	@addr: address of the DLCI
  *
@@ -1670,11 +2908,15 @@ static void gsm_dlci_command(struct gsm_dlci *dlci, const u8 *data, int len)
  *
  *	FIXME: review locking races
  */
-
 static struct gsm_dlci *gsm_dlci_alloc(struct gsm_mux *gsm, int addr)
 {
 	struct gsm_dlci *dlci = kzalloc(sizeof(struct gsm_dlci), GFP_ATOMIC);
-	if (dlci == NULL)
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s DLCI[%d] ==%p\n", gsm->num, __func__, addr,
+			 gsm->dlci[addr]);
+
+	if (!dlci)
 		return NULL;
 	spin_lock_init(&dlci->lock);
 	mutex_init(&dlci->mutex);
@@ -1690,17 +2932,30 @@ static struct gsm_dlci *gsm_dlci_alloc(struct gsm_mux *gsm, int addr)
 	dlci->gsm = gsm;
 	dlci->addr = addr;
 	dlci->adaption = gsm->adaption;
+	dlci->mtu = gsm->mtu;
+	if (addr == 0)
+		dlci->prio = 0;
+	else
+		dlci->prio = ((((addr / 8) + 1) * 8) - 1);
+	dlci->ftype = gsm->ftype;
+	dlci->k = gsm->k;
 	dlci->state = DLCI_CLOSED;
-	if (addr)
+	if (addr) {
 		dlci->data = gsm_dlci_data;
-	else
+		/* Prevent us from sending data before the link is up */
+		dlci->constipated = true;
+	} else {
 		dlci->data = gsm_dlci_command;
+	}
 	gsm->dlci[addr] = dlci;
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s done\n", gsm->num, __func__);
 	return dlci;
 }
 
 /**
- *	gsm_dlci_free		-	free DLCI
+ *	gsm_dlci_free	-	free DLCI
  *	@port: tty port for DLCI to free
  *
  *	Free up a DLCI.
@@ -1710,29 +2965,61 @@ static struct gsm_dlci *gsm_dlci_alloc(struct gsm_mux *gsm, int addr)
 static void gsm_dlci_free(struct tty_port *port)
 {
 	struct gsm_dlci *dlci = container_of(port, struct gsm_dlci, port);
+	struct gsm_mux *gsm = dlci->gsm;
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s\n", gsm->num, __func__);
 
 	del_timer_sync(&dlci->t1);
-	dlci->gsm->dlci[dlci->addr] = NULL;
+	gsm->dlci[dlci->addr] = NULL;
 	kfifo_free(&dlci->fifo);
 	while ((dlci->skb = skb_dequeue(&dlci->skb_list)))
 		dev_kfree_skb(dlci->skb);
+	mutex_destroy(&dlci->mutex);
 	kfree(dlci);
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s done\n", gsm->num, __func__);
 }
 
+/**
+ *	dlci_get	-	increment refcount
+ *	@dlci: DLCI instance
+ */
 static inline void dlci_get(struct gsm_dlci *dlci)
 {
+	struct gsm_mux *gsm = dlci->gsm;
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s\n", gsm->num, __func__);
+
 	tty_port_get(&dlci->port);
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s done\n", gsm->num, __func__);
 }
 
+/**
+ *	dlci_put	-	decrement refcount
+ *	@dlci: DLCI instance
+ *
+ *	Releases associated TTY if refcount reaches 0.
+ */
 static inline void dlci_put(struct gsm_dlci *dlci)
 {
+	struct gsm_mux *gsm = dlci->gsm;
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s\n", gsm->num, __func__);
+
 	tty_port_put(&dlci->port);
-}
 
-static void gsm_destroy_network(struct gsm_dlci *dlci);
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s done\n", gsm->num, __func__);
+}
 
 /**
- *	gsm_dlci_release		-	release DLCI
+ *	gsm_dlci_release	-	release DLCI
  *	@dlci: DLCI to destroy
  *
  *	Release a DLCI. Actual free is deferred until either
@@ -1742,19 +3029,32 @@ static void gsm_destroy_network(struct gsm_dlci *dlci);
  */
 static void gsm_dlci_release(struct gsm_dlci *dlci)
 {
+	struct gsm_mux *gsm = dlci->gsm;
 	struct tty_struct *tty = tty_port_tty_get(&dlci->port);
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s DLCI[%d]\n", gsm->num, __func__, dlci->addr);
+
+	dlci->state = DLCI_CLOSED;
 	if (tty) {
 		mutex_lock(&dlci->mutex);
 		gsm_destroy_network(dlci);
 		mutex_unlock(&dlci->mutex);
 
-		tty_hangup(tty);
+		/* We cannot use tty_hangup() because in tty_kref_put() the tty
+		 * driver assumes that the hangup queue is free and reuses it to
+		 * queue release_one_tty() -> NULL pointer panic in
+		 * process_one_work().
+		 */
+		tty_vhangup(tty);
 
 		tty_port_tty_set(&dlci->port, NULL);
 		tty_kref_put(tty);
 	}
-	dlci->state = DLCI_CLOSED;
 	dlci_put(dlci);
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s done\n", gsm->num, __func__);
 }
 
 /*
@@ -1762,7 +3062,7 @@ static void gsm_dlci_release(struct gsm_dlci *dlci)
  */
 
 /**
- *	gsm_queue		-	a GSM frame is ready to process
+ *	gsm_queue	-	a GSM frame is ready to process
  *	@gsm: pointer to our gsm mux
  *
  *	At this point in time a frame has arrived and been demangled from
@@ -1770,143 +3070,126 @@ static void gsm_dlci_release(struct gsm_dlci *dlci)
  *	been handled below us and the frame is unpacked into the structures.
  *	The fcs holds the header FCS but any data FCS must be added here.
  */
-
 static void gsm_queue(struct gsm_mux *gsm)
 {
-	struct gsm_dlci *dlci;
-	u8 cr;
-	int address;
-	int i, j, k, address_tmp;
-	/* We have to sneak a look at the packet body to do the FCS.
-	   A somewhat layering violation in the spec */
-
-	if ((gsm->control & ~PF) == UI)
-		gsm->fcs = gsm_fcs_add_block(gsm->fcs, gsm->buf, gsm->len);
-	if (gsm->encoding == 0) {
-		/* WARNING: gsm->received_fcs is used for
-		gsm->encoding = 0 only.
-		In this case it contain the last piece of data
-		required to generate final CRC */
-		gsm->fcs = gsm_fcs_add(gsm->fcs, gsm->received_fcs);
-	}
+	struct gsm_dlci *dlci = NULL;
+	int address = 0;
+	u8 cr = 0;
+
 	if (gsm->fcs != GOOD_FCS) {
 		gsm->bad_fcs++;
-		if (debug & 4)
-			pr_debug("BAD FCS %02x\n", gsm->fcs);
+		if (debug & DBG_DATA)
+			pr_debug("BAD FCS %02XH\n", gsm->fcs);
 		return;
 	}
 	address = gsm->address >> 1;
-	if (address >= NUM_DLCI)
-		goto invalid;
+	if (address >= NUM_DLCI) {
+		if (debug & DBG_DATA)
+			pr_info("malformed addr %d\n", address);
+		gsm->malformed++;
+		return;
+	}
 
-	cr = gsm->address & 1;		/* C/R bit */
+	cr = gsm->address & 1;      /* C/R bit */
+	cr ^= gsm->initiator ? 0 : 1; /* Flip so 1 always means command */
 
-	gsm_print_packet("<--", address, cr, gsm->control, gsm->buf, gsm->len);
+	gsm_print_packet(gsm->num, "<--", address, cr, gsm->control, gsm->buf,
+			 gsm->len);
 
-	cr ^= 1 - gsm->initiator;	/* Flip so 1 always means command */
 	dlci = gsm->dlci[address];
 
 	switch (gsm->control) {
+	case SABM:
 	case SABM|PF:
-		if (cr == 1)
-			goto invalid;
-		if (dlci == NULL)
+		if (cr) {
+			pr_err("gsm_queue: SABM invalid\n");
+			gsm->malformed++;
+			gsm->open_error++;
+			break;
+		}
+		if (!dlci) {
 			dlci = gsm_dlci_alloc(gsm, address);
-		if (dlci == NULL)
-			return;
-		if (dlci->dead)
+			if (!dlci) {
+				gsm->open_error++;
+				break;
+			}
+			dlci->rx += gsm->len;
+		}
+		if (dlci->dead) {
 			gsm_response(gsm, address, DM|PF);
-		else {
+		} else {
 			gsm_response(gsm, address, UA|PF);
 			gsm_dlci_open(dlci);
-			/* Save dlci open address */
-			if (address) {
-				addr_open[addr_cnt] = address;
-				addr_cnt++;
-			}
 		}
 		break;
+
+	case DISC:
 	case DISC|PF:
-		if (cr == 1)
-			goto invalid;
-		if (dlci == NULL || dlci->state == DLCI_CLOSED) {
+		if (cr) {
+			pr_err("gsm_queue: DISC invalid\n");
+			gsm->malformed++;
+			break;
+		}
+		if (!dlci || dlci->state == DLCI_CLOSED) {
 			gsm_response(gsm, address, DM|PF);
-			return;
+			break;
 		}
 		/* Real close complete */
-		if (!address) {
-			if (addr_cnt > 0) {
-				for (i = 0; i < addr_cnt; i++) {
-					address = addr_open[i];
-					dlci = gsm->dlci[address];
-					gsm_dlci_close(dlci);
-					addr_open[i] = 0;
-				}
-			}
-			dlci = gsm->dlci[0];
-			gsm_dlci_close(dlci);
-			addr_cnt = 0;
-			gsm_response(gsm, 0, UA|PF);
-		} else {
-			gsm_response(gsm, address, UA|PF);
-			gsm_dlci_close(dlci);
-			/* clear dlci address */
-			for (j = 0; j < addr_cnt; j++) {
-				address_tmp = addr_open[j];
-				if (address_tmp == address) {
-					for (k = j; k < addr_cnt; k++)
-						addr_open[k] = addr_open[k+1];
-					addr_cnt--;
-					break;
-				}
-			}
-		}
+		gsm_response(gsm, address, UA|PF);
+		gsm_dlci_close(dlci);
 		break;
 	case UA:
 	case UA|PF:
-		if (cr == 0 || dlci == NULL)
-			break;
-		switch (dlci->state) {
-		case DLCI_CLOSING:
-			gsm_dlci_close(dlci);
-			break;
-		case DLCI_OPENING:
-			gsm_dlci_open(dlci);
+		if (!cr) {
+			pr_err("gsm_queue: UA invalid\n");
+			gsm->malformed++;
 			break;
-		default:
-			pr_debug("%s: unhandled state: %d\n", __func__,
+		}
+		if (dlci) {
+			switch (dlci->state) {
+			case DLCI_CLOSING:
+				gsm_dlci_close(dlci);
+				break;
+			case DLCI_OPENING:
+				gsm_dlci_open(dlci);
+				break;
+			default:
+				pr_debug("%s: unhandled state: %d\n", __func__,
 					dlci->state);
-			break;
+				break;
+			}
 		}
 		break;
-	case DM:	/* DM can be valid unsolicited */
+
+	case DM:    /* DM can be valid unsolicited */
 	case DM|PF:
-		if (cr)
-			goto invalid;
-		if (dlci == NULL)
-			return;
-		gsm_dlci_close(dlci);
+		if (!cr) {
+			pr_err("gsm_queue: DM invalid\n");
+			gsm->malformed++;
+			break;
+		}
+		if (dlci)
+			gsm_dlci_close(dlci);
 		break;
+
 	case UI:
 	case UI|PF:
 	case UIH:
 	case UIH|PF:
-#if 0
-		if (cr)
-			goto invalid;
-#endif
-		if (dlci == NULL || dlci->state != DLCI_OPEN) {
-			gsm_command(gsm, address, DM|PF);
-			return;
+		if (!dlci) {
+			if (gsm->control & PF)
+				gsm_response(gsm, address, DM|PF);
+			else
+				gsm_response(gsm, address, DM);
+		} else {
+			dlci->data(dlci, gsm->buf, gsm->len);
 		}
-		dlci->data(dlci, gsm->buf, gsm->len);
 		break;
 	default:
-		goto invalid;
+		gsm->malformed++;
+		break;
 	}
-	return;
-invalid:
-	gsm->malformed++;
+
 	return;
 }
 
@@ -1916,15 +3199,14 @@ static void gsm_queue(struct gsm_mux *gsm)
  *	@gsm: gsm data for this ldisc instance
  *	@c: character
  *
- *	Receive bytes in gsm mode 0
+ *	Receive bytes in mode 0 (Basic option)
  */
-
 static void gsm0_receive(struct gsm_mux *gsm, unsigned char c)
 {
 	unsigned int len;
 
 	switch (gsm->state) {
-	case GSM_SEARCH:	/* SOF marker */
+	case GSM_SEARCH:    /* SOF marker */
 		if (c == GSM0_SOF) {
 			gsm->state = GSM_ADDRESS;
 			gsm->address = 0;
@@ -1932,17 +3214,17 @@ static void gsm0_receive(struct gsm_mux *gsm, unsigned char c)
 			gsm->fcs = INIT_FCS;
 		}
 		break;
-	case GSM_ADDRESS:	/* Address EA */
+	case GSM_ADDRESS:   /* Address EA */
 		gsm->fcs = gsm_fcs_add(gsm->fcs, c);
 		if (gsm_read_ea(&gsm->address, c))
 			gsm->state = GSM_CONTROL;
 		break;
-	case GSM_CONTROL:	/* Control Byte */
+	case GSM_CONTROL:   /* Control Byte */
 		gsm->fcs = gsm_fcs_add(gsm->fcs, c);
 		gsm->control = c;
 		gsm->state = GSM_LEN0;
 		break;
-	case GSM_LEN0:		/* Length EA */
+	case GSM_LEN0:      /* Length EA */
 		gsm->fcs = gsm_fcs_add(gsm->fcs, c);
 		if (gsm_read_ea(&gsm->len, c)) {
 			if (gsm->len > gsm->mru) {
@@ -1974,21 +3256,29 @@ static void gsm0_receive(struct gsm_mux *gsm, unsigned char c)
 		else
 			gsm->state = GSM_DATA;
 		break;
-	case GSM_DATA:		/* Data */
+	case GSM_DATA:      /* Data */
 		gsm->buf[gsm->count++] = c;
-		if (gsm->count == gsm->len)
+		if (gsm->count == gsm->len) {
+			if ((gsm->control & ~PF) != UIH) {
+				/* calculate final FCS for UI frames over all
+				 * data
+				 */
+				gsm->fcs = gsm_fcs_add_block(gsm->fcs, gsm->buf,
+							     gsm->count);
+			}
 			gsm->state = GSM_FCS;
+		}
 		break;
-	case GSM_FCS:		/* FCS follows the packet */
-		gsm->received_fcs = c;
-		gsm_queue(gsm);
+	case GSM_FCS:       /* FCS follows the packet */
+		gsm->fcs = gsm_fcs_add(gsm->fcs, c);
 		gsm->state = GSM_SSOF;
 		break;
 	case GSM_SSOF:
-		if (c == GSM0_SOF) {
-			gsm->state = GSM_SEARCH;
-			break;
-		}
+		gsm->state = GSM_SEARCH;
+		if (c == GSM0_SOF)
+			gsm_queue(gsm);
+		else
+			gsm->bad_size++;
 		break;
 	default:
 		pr_debug("%s: unhandled state: %d\n", __func__, gsm->state);
@@ -2003,28 +3293,60 @@ static void gsm0_receive(struct gsm_mux *gsm, unsigned char c)
  *
  *	Receive bytes in mode 1 (Advanced option)
  */
-
 static void gsm1_receive(struct gsm_mux *gsm, unsigned char c)
 {
+	/* handle XON/XOFF */
+	if (gsm->xon_xoff & IXOFF) {
+		if ((c & ISO_IEC_646_MASK) == XON) {
+			gsm->constipated = true;
+			return;
+		} else if ((c & ISO_IEC_646_MASK) == XOFF) {
+			gsm->constipated = false;
+			/* Kick the link in case it is idling */
+			gsmld_write_trigger(gsm);
+			return;
+		}
+	}
 	if (c == GSM1_SOF) {
-		/* EOF is only valid in frame if we have got to the data state
-		   and received at least one byte (the FCS) */
-		if (gsm->state == GSM_DATA && gsm->count) {
-			/* Extract the FCS */
-			gsm->count--;
+		/* EOF is only valid in frame if we have got to the data state */
+		if (gsm->state == GSM_DATA) {
+			if (gsm->count < 1) {
+				/* Missing FSC */
+				if (debug & DBG_DATA)
+					pr_info("MISSING FCS\n");
+				gsm->malformed++;
+				gsm->state = GSM_START;
+				return;
+			}
+			/* remove the FCS from data */
+			gsm->count -= 1;
+			if ((gsm->control & ~PF) != UIH) {
+				/* calculate final FCS for UI frames over all
+				 * data but FCS
+				 */
+				gsm->fcs = gsm_fcs_add_block(gsm->fcs, gsm->buf,
+							     gsm->count);
+			}
+			/* add the FCS itself, we hope we have the GOOD_FCS */
 			gsm->fcs = gsm_fcs_add(gsm->fcs, gsm->buf[gsm->count]);
 			gsm->len = gsm->count;
 			gsm_queue(gsm);
-			gsm->state  = GSM_START;
+			gsm->state = GSM_START;
 			return;
 		}
 		/* Any partial frame was a runt so go back to start */
 		if (gsm->state != GSM_START) {
-			gsm->malformed++;
+			if (gsm->state != GSM_SEARCH) {
+				if (debug & DBG_DATA)
+					pr_info("malformed frame state %d\n",
+						gsm->state);
+				gsm->malformed++;
+			}
 			gsm->state = GSM_START;
 		}
 		/* A SOF in GSM_START means we are still reading idling or
-		   framing bytes */
+		 * framing bytes
+		 */
 		return;
 	}
 
@@ -2042,30 +3364,32 @@ static void gsm1_receive(struct gsm_mux *gsm, unsigned char c)
 		gsm->escape = false;
 	}
 	switch (gsm->state) {
-	case GSM_START:		/* First byte after SOF */
+	case GSM_START:     /* First byte after SOF */
 		gsm->address = 0;
 		gsm->state = GSM_ADDRESS;
 		gsm->fcs = INIT_FCS;
 		fallthrough;
-	case GSM_ADDRESS:	/* Address continuation */
+	case GSM_ADDRESS:   /* Address continuation */
 		gsm->fcs = gsm_fcs_add(gsm->fcs, c);
 		if (gsm_read_ea(&gsm->address, c))
 			gsm->state = GSM_CONTROL;
 		break;
-	case GSM_CONTROL:	/* Control Byte */
+	case GSM_CONTROL:   /* Control Byte */
 		gsm->fcs = gsm_fcs_add(gsm->fcs, c);
 		gsm->control = c;
 		gsm->count = 0;
 		gsm->state = GSM_DATA;
 		break;
-	case GSM_DATA:		/* Data */
-		if (gsm->count > gsm->mru) {	/* Allow one for the FCS */
+	case GSM_DATA:      /* Data */
+		if (gsm->count > gsm->mru) {    /* Allow one for the FCS */
+			pr_err("%s overrun %d\n", __func__, gsm->count);
 			gsm->state = GSM_OVERRUN;
 			gsm->bad_size++;
-		} else
+		} else {
 			gsm->buf[gsm->count++] = c;
+		}
 		break;
-	case GSM_OVERRUN:	/* Over-long - eg a dropped SOF */
+	case GSM_OVERRUN:   /* Over-long - e.g. a dropped SOF */
 		break;
 	default:
 		pr_debug("%s: unhandled state: %d\n", __func__, gsm->state);
@@ -2074,92 +3398,226 @@ static void gsm1_receive(struct gsm_mux *gsm, unsigned char c)
 }
 
 /**
- *	gsm_error		-	handle tty error
+ *	gsm_error	-	handle tty error
  *	@gsm: ldisc data
  *
  *	Handle an error in the receipt of data for a frame. Currently we just
  *	go back to hunting for a SOF.
  *
- *	FIXME: better diagnostics ?
+ *	FIXME: better diagnostics?
  */
-
 static void gsm_error(struct gsm_mux *gsm)
 {
 	gsm->state = GSM_SEARCH;
 	gsm->io_error++;
 }
 
-static int gsm_disconnect(struct gsm_mux *gsm)
+/*
+ *	Entry to the proc file system in tty/ldisc/n_gsm/
+ */
+
+static struct proc_dir_entry *proc_gsm;
+
+/**
+ *	gsm_proc_print_flag	-	check and print termios flag
+ *	@m: output handle
+ *	@flags: termios flags
+ *	@val: flag to check and print
+ *	@str: string representation of val
+ *	@first: does not need separator?
+ */
+static int gsm_proc_print_flag(struct seq_file *m, unsigned short flags,
+			       int val, const char *str, int first)
 {
-	struct gsm_dlci *dlci = gsm->dlci[0];
-	struct gsm_control *gc;
+	if ((flags & val) == 0)
+		return first;
+	if (!first)
+		seq_putc(m, '|');
+	seq_puts(m, str);
+	return 0;
+}
+#define gsm_proc_print_flag_str(m, flags, val, first) \
+	gsm_proc_print_flag((m), (flags), (val), #val, first)
 
-	if (!dlci)
-		return 0;
+/**
+ *	gsm_proc_show	-	output proc file
+ *	@m: output handle
+ *	@v: result from start
+ *
+ *	Handles the output of /proc/tty/ldisc/n_gsm/mux%d
+ */
+static int gsm_proc_show(struct seq_file *m, void *v)
+{
+	struct gsm_mux *gsm = m->private;
+	struct gsm_dlci *dlci = NULL;
+	unsigned short flags;
+	int i, first = 1;
+	const char *state, *ftype;
 
-	/* In theory disconnecting DLCI 0 is sufficient but for some
-	   modems this is apparently not the case. */
-	gc = gsm_control_send(gsm, CMD_CLD, NULL, 0);
-	if (gc)
-		gsm_control_wait(gsm, gc);
+	if (!gsm)
+		return -ENODEV;
 
-	del_timer_sync(&gsm->t2_timer);
-	/* Now we are sure T2 has stopped */
+	/* The proc file may get removed in gsm_cleanup_mux() if the connection
+	 * was closed. Early out here to avoid a deadlock.
+	 */
+	if (!mutex_trylock(&gsm_mux_mutex))
+		return -EBUSY;
+	if (!mutex_trylock(&gsm->mutex)) {
+		mutex_unlock(&gsm_mux_mutex);
+		return -EBUSY;
+	}
 
-	gsm_dlci_begin_close(dlci);
-	wait_event_interruptible(gsm->event,
-				dlci->state == DLCI_CLOSED);
+	seq_printf(m, "tty:%s flags:", tty_name(gsm->tty));
+	flags = gsm->tty->termios.c_iflag;
+	first = gsm_proc_print_flag_str(m, flags, IGNBRK, first);
+	first = gsm_proc_print_flag_str(m, flags, IXON, first);
+	first = gsm_proc_print_flag_str(m, flags, IXOFF, first);
+	flags = gsm->tty->termios.c_cflag;
+	first = gsm_proc_print_flag_str(m, flags, CLOCAL, first);
+	first = gsm_proc_print_flag_str(m, flags, CRTSCTS, first);
+	seq_putc(m, '\n');
+
+	seq_printf(m, "initiator:%d mode:%d mru:%u mtu:%u t1:%d t2:%d t3:%d n2:%d k:%d wc:%d ka:%u",
+		   gsm->initiator, gsm->encoding, gsm->mru, gsm->mtu, gsm->t1,
+		   gsm->t2, gsm->t3, gsm->n2, gsm->k, gsm->wait_config ? 1 : 0,
+		   gsm->keep_alive);
+	if (gsm->dead)
+		seq_puts(m, " DEAD");
+	seq_putc(m, '\n');
+
+	seq_printf(m, "bad_fcs:%lu malformed:%lu io_error:%lu open_error:%lu bad_size:%lu unsupported:%lu\n\n",
+		   gsm->bad_fcs, gsm->malformed, gsm->io_error, gsm->open_error,
+		   gsm->bad_size, gsm->unsupported);
+
+	for (i = 0; i < NUM_DLCI; i++) {
+		dlci = gsm->dlci[i];
+		if (!dlci)
+			continue;
+		switch (dlci->state) {
+		case DLCI_CLOSED:
+			state = "CLOSED";
+			break;
+		case DLCI_WAITING:
+			state = "WAITING";
+			break;
+		case DLCI_CONFIGURE:
+			state = "CONFIGURE";
+			break;
+		case DLCI_OPENING:
+			state = "OPENING";
+			break;
+		case DLCI_OPEN:
+			state = "OPEN";
+			break;
+		case DLCI_CLOSING:
+			state = "CLOSING";
+			break;
+		default:
+			state = "???";
+			break;
+		}
+		switch (dlci->ftype) {
+		case UI:
+			ftype = "UI";
+			break;
+		case UIH:
+			ftype = "UIH";
+			break;
+		default:
+			ftype = "???";
+			break;
+		}
+		seq_printf(m, "dlci:%d state:%s cl:%d prio:%d i:%s k:%d mtu:%u tx:%lu rx:%lu",
+			   i, state, dlci->adaption, dlci->prio, ftype, dlci->k,
+			   dlci->mtu, dlci->tx, dlci->rx);
+		if (dlci->dead)
+			seq_puts(m, " DEAD");
+		seq_putc(m, '\n');
+	}
 
-	if (signal_pending(current))
-		return -EINTR;
+	mutex_unlock(&gsm->mutex);
+	mutex_unlock(&gsm_mux_mutex);
 
 	return 0;
 }
 
+static int gsm_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, gsm_proc_show, pde_data(inode));
+}
+
+static const struct proc_ops gsm_proc_ops = {
+	.proc_open    = gsm_proc_open,
+	.proc_read    = seq_read,
+	.proc_lseek   = seq_lseek,
+	.proc_release = single_release,
+};
+
 /**
- *	gsm_cleanup_mux		-	generic GSM protocol cleanup
+ *	gsm_cleanup_mux	-	generic GSM protocol cleanup
  *	@gsm: our mux
+ *	@disc: disconnect link?
  *
  *	Clean up the bits of the mux which are the same for all framing
  *	protocols. Remove the mux from the mux table, stop all the timers
  *	and then shut down each device hanging up the channels as we go.
  */
-
-static void gsm_cleanup_mux(struct gsm_mux *gsm)
+static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
 {
 	int i;
 	struct gsm_dlci *dlci = gsm->dlci[0];
 	struct gsm_msg *txq, *ntxq;
 
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s\n", gsm->num, __func__);
 	gsm->dead = true;
+	mutex_lock(&gsm->mutex);
 
-	spin_lock(&gsm_mux_lock);
-	for (i = 0; i < MAX_MUX; i++) {
-		if (gsm_mux[i] == gsm) {
-			gsm_mux[i] = NULL;
-			break;
+	if (dlci) {
+		if (disc && dlci->state != DLCI_CLOSED) {
+			gsm_dlci_begin_close(dlci);
+			wait_event(gsm->event, dlci->state == DLCI_CLOSED);
 		}
+		dlci->dead = true;
 	}
-	spin_unlock(&gsm_mux_lock);
-	/* open failed before registering => nothing to do */
-	if (i == MAX_MUX)
-		return;
 
+	/* Finish outstanding timers, making sure they are done */
+	del_timer_sync(&gsm->kick_timer);
 	del_timer_sync(&gsm->t2_timer);
-	/* Now we are sure T2 has stopped */
-	if (dlci)
-		dlci->dead = true;
+	del_timer_sync(&gsm->ka_timer);
+
+	/* Finish writing task */
+	tasklet_disable(&gsm->tx_tsk);
+	tasklet_kill(&gsm->tx_tsk);
 
 	/* Free up any link layer users */
-	mutex_lock(&gsm->mutex);
-	for (i = 0; i < NUM_DLCI; i++)
+	if (gsm->has_devices) {
+		gsm_unregister_devices(gsm_tty_driver, gsm->num);
+		gsm->has_devices = false;
+	}
+	for (i = NUM_DLCI - 1; i >= 0; i--) {
 		if (gsm->dlci[i])
 			gsm_dlci_release(gsm->dlci[i]);
+	}
 	mutex_unlock(&gsm->mutex);
+
+	if (debug & DBG_CALLS)
+		pr_debug("%s: gsm_mux[%u] deactivated\n", __func__, gsm->num);
+
 	/* Now wipe the queues */
-	list_for_each_entry_safe(txq, ntxq, &gsm->tx_list, list)
+	tty_ldisc_flush(gsm->tty);
+	list_for_each_entry_safe(txq, ntxq, &gsm->tx0_list, list)
+		kfree(txq);
+	INIT_LIST_HEAD(&gsm->tx0_list);
+	list_for_each_entry_safe(txq, ntxq, &gsm->tx1_list, list)
 		kfree(txq);
-	INIT_LIST_HEAD(&gsm->tx_list);
+	INIT_LIST_HEAD(&gsm->tx1_list);
+
+	if (gsm->proc)
+		proc_remove(gsm->proc);
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s done\n", gsm->num, __func__);
 }
 
 /**
@@ -2170,56 +3628,101 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm)
  *	protocols. Add the mux to the mux table so it can be opened and
  *	finally kick off connecting to DLCI 0 on the modem.
  */
+static int gsm_activate_mux(struct gsm_mux *gsm)
+{
+	struct gsm_dlci *dlci = gsm ? gsm->dlci[0] : NULL;
+	char pbuf[8];
+	int ret = 0;
+
+	if (!gsm) {
+		pr_info("%s: ERROR gsm %p\n", __func__, gsm);
+		return -ENOMEM;
+	}
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s\n", gsm->num, __func__);
 
-static int gsm_activate_mux(struct gsm_mux *gsm)
-{
-	struct gsm_dlci *dlci;
-	int i = 0;
+	if (dlci) {
+		if (debug & DBG_CALLS)
+			pr_debug("%u:%s dlci != NULL\n", gsm->num, __func__);
+	} else {
+		dlci = gsm_dlci_alloc(gsm, 0);
+	}
 
+	if (!dlci) {
+		if (debug & DBG_CALLS)
+			pr_debug("%u:%s error(ENOMEM)\n", gsm->num, __func__);
+		return -ENOMEM;
+	}
+
+	timer_setup(&gsm->kick_timer, gsm_kick_timer, 0);
 	timer_setup(&gsm->t2_timer, gsm_control_retransmit, 0);
-	init_waitqueue_head(&gsm->event);
-	spin_lock_init(&gsm->control_lock);
-	spin_lock_init(&gsm->tx_lock);
+	timer_setup(&gsm->ka_timer, gsm_control_keep_alive, 0);
+	tasklet_init(&gsm->tx_tsk, gsmld_write_task, (unsigned long)gsm);
 
-	if (gsm->encoding == 0)
+	if (gsm->encoding == GSM_BASIC_OPT)
 		gsm->receive = gsm0_receive;
 	else
 		gsm->receive = gsm1_receive;
 
-	spin_lock(&gsm_mux_lock);
-	for (i = 0; i < MAX_MUX; i++) {
-		if (gsm_mux[i] == NULL) {
-			gsm->num = i;
-			gsm_mux[i] = gsm;
-			break;
-		}
+	ret = gsm_register_devices(gsm_tty_driver, gsm->num);
+	if (ret)
+		return ret;
+
+	gsm->has_devices = true;
+	dlci->dead = false;
+	gsm->skip_sof = false;
+	gsm->last_sof = jiffies;
+	gsm->xon_xoff = gsm->tty->termios.c_iflag & (IXON|IXOFF);
+	if (gsm->xon_xoff && gsm->encoding == GSM_BASIC_OPT) {
+		pr_info("%u:%s disabled XON/XOFF, not allowed in basic option\n",
+			gsm->num, __func__);
+		gsm->xon_xoff = 0;
 	}
-	spin_unlock(&gsm_mux_lock);
-	if (i == MAX_MUX)
-		return -EBUSY;
+	gsm->dead = false; /* Tty opens are now permissible */
 
-	dlci = gsm_dlci_alloc(gsm, 0);
-	if (dlci == NULL)
-		return -ENOMEM;
-	gsm->dead = false;		/* Tty opens are now permissible */
-	return 0;
+	if (snprintf(pbuf, sizeof(pbuf), "mux%u", gsm->num) > 0)
+		gsm->proc = proc_create_data(pbuf, 0444, proc_gsm,
+					     &gsm_proc_ops, gsm);
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s done\n", gsm->num, __func__);
+
+	return ret;
 }
 
 /**
- *	gsm_free_mux		-	free up a mux
+ *	gsm_free_mux	-	free up a mux
  *	@gsm: mux to free
  *
  *	Dispose of allocated resources for a dead mux
  */
 static void gsm_free_mux(struct gsm_mux *gsm)
 {
-	kfree(gsm->txframe);
-	kfree(gsm->buf);
-	kfree(gsm);
+	int i;
+	unsigned int num = gsm->num;
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s\n", num, __func__);
+
+	for (i = 0; i < MAX_MUX; i++) {
+		/* not assigned, choose one */
+		if (gsm == gsm_mux[i]) {
+			gsm_mux[i] = NULL;
+			mutex_destroy(&gsm->mutex);
+			kfree(gsm->txframe);
+			kfree(gsm->buf);
+			kfree(gsm);
+			break;
+		}
+	}
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s done\n", num, __func__);
 }
 
 /**
- *	gsm_free_muxr		-	free up a mux
+ *	gsm_free_muxr	-	free up a mux
  *	@ref: kreference to the mux to free
  *
  *	Dispose of allocated resources for a dead mux
@@ -2227,194 +3730,242 @@ static void gsm_free_mux(struct gsm_mux *gsm)
 static void gsm_free_muxr(struct kref *ref)
 {
 	struct gsm_mux *gsm = container_of(ref, struct gsm_mux, ref);
+	unsigned int num = gsm->num;
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s\n", num, __func__);
+
 	gsm_free_mux(gsm);
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s done\n", num, __func__);
 }
 
+/**
+ *	mux_get	-	increment refcount
+ *	@gsm: mux instance
+ */
 static inline void mux_get(struct gsm_mux *gsm)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&gsm_mux_lock, flags);
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s\n", gsm->num, __func__);
+
 	kref_get(&gsm->ref);
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s done\n", gsm->num, __func__);
+	spin_unlock_irqrestore(&gsm_mux_lock, flags);
+
 }
 
+/**
+ *	mux_put	-	decrement refcount
+ *	@gsm: mux instance
+ *
+ *	Releases the mux instance if refcount reaches 0.
+ */
 static inline void mux_put(struct gsm_mux *gsm)
 {
+	unsigned int num = gsm->num;
+	unsigned long flags;
+
+	spin_lock_irqsave(&gsm_mux_lock, flags);
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s\n", num, __func__);
+
 	kref_put(&gsm->ref, gsm_free_muxr);
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s done\n", num, __func__);
+	spin_unlock_irqrestore(&gsm_mux_lock, flags);
 }
 
+/**
+ *	mux_num_to_base	-	get tty base number
+ *	@gsm: mux instance
+ */
 static inline unsigned int mux_num_to_base(struct gsm_mux *gsm)
 {
 	return gsm->num * NUM_DLCI;
 }
 
+/**
+ *	mux_line_to_num	-	get mux ID from tty line number
+ *	@line: tty line number
+ */
 static inline unsigned int mux_line_to_num(unsigned int line)
 {
 	return line / NUM_DLCI;
 }
 
 /**
- *	gsm_alloc_mux		-	allocate a mux
+ *	gsm_alloc_mux	-	allocate a mux
  *
  *	Creates a new mux ready for activation.
  */
-
 static struct gsm_mux *gsm_alloc_mux(void)
 {
 	struct gsm_mux *gsm = kzalloc(sizeof(struct gsm_mux), GFP_KERNEL);
-	if (gsm == NULL)
+	int i;
+
+	if (!gsm)
 		return NULL;
-	gsm->buf = kmalloc(MAX_MRU + 1, GFP_KERNEL);
-	if (gsm->buf == NULL) {
+
+	gsm->buf = kmalloc(MAX_MRU + PROT_OVERHEAD, GFP_KERNEL);
+	if (!gsm->buf) {
 		kfree(gsm);
 		return NULL;
 	}
-	gsm->txframe = kmalloc(2 * MAX_MRU + 2, GFP_KERNEL);
-	if (gsm->txframe == NULL) {
+	gsm->txframe = kmalloc(2 * (MAX_MTU + PROT_OVERHEAD), GFP_KERNEL);
+	if (!gsm->txframe) {
 		kfree(gsm->buf);
 		kfree(gsm);
 		return NULL;
 	}
+
+	/* Initialize locks and queues */
+	init_waitqueue_head(&gsm->event);
+	spin_lock_init(&gsm->control_lock);
+	spin_lock_init(&gsm->tx_lock);
 	spin_lock_init(&gsm->lock);
 	mutex_init(&gsm->mutex);
 	kref_init(&gsm->ref);
-	INIT_LIST_HEAD(&gsm->tx_list);
+	INIT_LIST_HEAD(&gsm->tx0_list);
+	INIT_LIST_HEAD(&gsm->tx1_list);
 
+	/* Setup default configuration */
 	gsm->t1 = T1;
 	gsm->t2 = T2;
+	gsm->t3 = T3;
 	gsm->n2 = N2;
+	gsm->k = K;
 	gsm->ftype = UIH;
 	gsm->adaption = 1;
-	gsm->encoding = 1;
-	gsm->mru = 64;	/* Default to encoding 1 so these should be 64 */
+	gsm->encoding = GSM_BASIC_OPT;
+	gsm->mru = 64;       /* Default to basic option so these should be 64 */
 	gsm->mtu = 64;
-	gsm->dead = true;	/* Avoid early tty opens */
+	gsm->dead = true;    /* Avoid early tty opens */
+	gsm->wait_config = false; /* Disabled */
+	gsm->keep_alive = 0; /* Disabled */
+	gsm->sof_intvl = 0;  /* Disabled */
+	gsm->num = UINT_MAX;
+
+	/* Store the instance to the mux array, if no unused
+	 * place is available then bomb out.
+	 */
+	spin_lock(&gsm_mux_lock);
+	for (i = 0; i < MAX_MUX; i++) {
+		if (!gsm_mux[i]) {
+			gsm_mux[i] = gsm;
+			gsm->num = i;
+			break;
+		}
+	}
+	spin_unlock(&gsm_mux_lock);
+	if (i == MAX_MUX) {
+		kfree(gsm->txframe);
+		kfree(gsm->buf);
+		kfree(gsm);
+		return NULL;
+	}
 
 	return gsm;
 }
 
-static void gsm_copy_config_values(struct gsm_mux *gsm,
-				   struct gsm_config *c)
-{
-	memset(c, 0, sizeof(*c));
-	c->adaption = gsm->adaption;
-	c->encapsulation = gsm->encoding;
-	c->initiator = gsm->initiator;
-	c->t1 = gsm->t1;
-	c->t2 = gsm->t2;
-	c->t3 = 0;	/* Not supported */
-	c->n2 = gsm->n2;
-	if (gsm->ftype == UIH)
-		c->i = 1;
-	else
-		c->i = 2;
-	pr_debug("Ftype %d i %d\n", gsm->ftype, c->i);
-	c->mru = gsm->mru;
-	c->mtu = gsm->mtu;
-	c->k = 0;
-}
+/*
+ *	Line discipline
+ */
 
-static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
+/**
+ *	gsmld_output	-	write to link
+ *	@gsm: our mux
+ *	@data: bytes to output
+ *	@len: size
+ *
+ *	Write a block of data from the GSM mux to the data channel. This
+ *	will eventually be serialized from above but at the moment isn't.
+ */
+static int gsmld_output(struct gsm_mux *gsm, u8 *data, int len)
 {
-	int need_close = 0;
-	int need_restart = 0;
-
-	/* Stuff we don't support yet - UI or I frame transport, windowing */
-	if ((c->adaption != 1 && c->adaption != 2) || c->k)
-		return -EOPNOTSUPP;
-	/* Check the MRU/MTU range looks sane */
-	if (c->mru > MAX_MRU || c->mtu > MAX_MTU || c->mru < 8 || c->mtu < 8)
-		return -EINVAL;
-	if (c->n2 < 3)
-		return -EINVAL;
-	if (c->encapsulation > 1)	/* Basic, advanced, no I */
-		return -EINVAL;
-	if (c->initiator > 1)
-		return -EINVAL;
-	if (c->i == 0 || c->i > 2)	/* UIH and UI only */
-		return -EINVAL;
-	/*
-	 * See what is needed for reconfiguration
-	 */
-
-	/* Timing fields */
-	if (c->t1 != 0 && c->t1 != gsm->t1)
-		need_restart = 1;
-	if (c->t2 != 0 && c->t2 != gsm->t2)
-		need_restart = 1;
-	if (c->encapsulation != gsm->encoding)
-		need_restart = 1;
-	if (c->adaption != gsm->adaption)
-		need_restart = 1;
-	/* Requires care */
-	if (c->initiator != gsm->initiator)
-		need_close = 1;
-	if (c->mru != gsm->mru)
-		need_restart = 1;
-	if (c->mtu != gsm->mtu)
-		need_restart = 1;
-
-	/*
-	 * Close down what is needed, restart and initiate the new
-	 * configuration
-	 */
-
-	if (gsm->initiator && (need_close || need_restart)) {
-		int ret;
+	int sent;
 
-		ret = gsm_disconnect(gsm);
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s\n", gsm->num, __func__);
 
-		if (ret)
-			return ret;
+	if (!test_bit(TTY_LDISC_OPEN, &gsm->tty->flags)) {
+		if (debug & DBG_CALLS)
+			pr_debug("%u:%s error(ldisc not open)\n", gsm->num,
+				 __func__);
+		return -ENODEV;
 	}
-	if (need_restart)
-		gsm_cleanup_mux(gsm);
+	if (len > tty_write_room(gsm->tty)) {
+		set_bit(TTY_DO_WRITE_WAKEUP, &gsm->tty->flags);
+		if (debug & DBG_CALLS)
+			pr_debug("%u:%s error(no space)\n", gsm->num,
+				 __func__);
+		return -ENOSPC;
+	}
+	if (debug & DBG_DATA)
+		print_hex_dump_bytes("gsmld_output: ", DUMP_PREFIX_OFFSET, data,
+				     len);
 
-	gsm->initiator = c->initiator;
-	gsm->mru = c->mru;
-	gsm->mtu = c->mtu;
-	gsm->encoding = c->encapsulation;
-	gsm->adaption = c->adaption;
-	gsm->n2 = c->n2;
+	sent = gsm->tty->ops->write(gsm->tty, data, len);
 
-	if (c->i == 1)
-		gsm->ftype = UIH;
-	else if (c->i == 2)
-		gsm->ftype = UI;
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s sent %d\n", gsm->num, __func__, sent);
+	return sent;
+}
 
-	if (c->t1)
-		gsm->t1 = c->t1;
-	if (c->t2)
-		gsm->t2 = c->t2;
 
-	/*
-	 * FIXME: We need to separate activation/deactivation from adding
-	 * and removing from the mux array
-	 */
-	if (need_restart)
-		gsm_activate_mux(gsm);
-	if (gsm->initiator && need_close)
-		gsm_dlci_begin_open(gsm->dlci[0]);
-	return 0;
+/**
+ *	gsmld_write_trigger	-	schedule ldisc write task
+ *	@gsm: our mux
+ */
+static void gsmld_write_trigger(struct gsm_mux *gsm)
+{
+	if (!gsm || !gsm->dlci[0] || gsm->dlci[0]->dead)
+		return;
+	tasklet_schedule(&gsm->tx_tsk);
 }
 
+
 /**
- *	gsmld_output		-	write to link
- *	@gsm: our mux
- *	@data: bytes to output
- *	@len: size
+ *	gsmld_write_task	-	ldisc write task
+ *	@arg: our mux
  *
- *	Write a block of data from the GSM mux to the data channel. This
- *	will eventually be serialized from above but at the moment isn't.
+ *	Writes out data to the ldisc if possible. We are doing this in a task
+ *	to avoid dead-locking. This task returns if no space is left for output.
  */
-
-static int gsmld_output(struct gsm_mux *gsm, u8 *data, int len)
+static void gsmld_write_task(unsigned long arg)
 {
-	if (tty_write_room(gsm->tty) < len) {
-		set_bit(TTY_DO_WRITE_WAKEUP, &gsm->tty->flags);
-		return -ENOSPC;
-	}
-	if (debug & 4)
-		print_hex_dump_bytes("gsmld_output: ", DUMP_PREFIX_OFFSET,
-				     data, len);
-	return gsm->tty->ops->write(gsm->tty, data, len);
+	struct gsm_mux *gsm = (struct gsm_mux *)arg;
+	unsigned int num = gsm->num;
+	unsigned long flags;
+	int ret;
+	int i;
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s\n", num, __func__);
+
+	/* All outstanding control channel and control messages and one data
+	 * frame is sent.
+	 */
+	ret = -ENODEV;
+	spin_lock_irqsave(&gsm->tx_lock, flags);
+	if (gsm->tty)
+		ret = gsm_data_kick(gsm);
+	spin_unlock_irqrestore(&gsm->tx_lock, flags);
+
+	if (ret >= 0)
+		for (i = 0; i < NUM_DLCI; i++)
+			if (gsm->dlci[i])
+				tty_port_tty_wakeup(&gsm->dlci[i]->port);
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s done\n", num, __func__);
 }
 
 /**
@@ -2422,40 +3973,20 @@ static int gsmld_output(struct gsm_mux *gsm, u8 *data, int len)
  *	@tty: our tty structure
  *	@gsm: our mux
  *
- *	Set up the MUX for basic mode and commence connecting to the
+ *	Set up the MUX for basic option and commence connecting to the
  *	modem. Currently called from the line discipline set up but
  *	will need moving to an ioctl path.
  */
-
 static int gsmld_attach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 {
-	unsigned int base;
-	int ret, i;
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s\n", gsm->num, __func__);
 
 	gsm->tty = tty_kref_get(tty);
-	ret =  gsm_activate_mux(gsm);
-	if (ret != 0)
-		tty_kref_put(gsm->tty);
-	else {
-		/* Don't register device 0 - this is the control channel and not
-		   a usable tty interface */
-		if (gsm->initiator) {
-			base = mux_num_to_base(gsm); /* Base for this MUX */
-			for (i = 1; i < NUM_DLCI; i++) {
-				struct device *dev;
-
-				dev = tty_register_device(gsm_tty_driver,
-							base + i, NULL);
-				if (IS_ERR(dev)) {
-					for (i--; i >= 1; i--)
-						tty_unregister_device(gsm_tty_driver,
-									base + i);
-					return PTR_ERR(dev);
-				}
-			}
-		}
-	}
-	return ret;
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s done\n", gsm->num, __func__);
+	return 0;
 }
 
 
@@ -2466,20 +3997,19 @@ static int gsmld_attach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
  *
  *	Shutdown and then clean up the resources used by the line discipline
  */
-
 static void gsmld_detach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 {
-	unsigned int base = mux_num_to_base(gsm); /* Base for this MUX */
-	int i;
+	unsigned int num = gsm->num;
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s\n", num, __func__);
 
 	WARN_ON(tty != gsm->tty);
-	if (gsm->initiator) {
-		for (i = 1; i < NUM_DLCI; i++)
-			tty_unregister_device(gsm_tty_driver, base + i);
-	}
-	gsm_cleanup_mux(gsm);
 	tty_kref_put(gsm->tty);
 	gsm->tty = NULL;
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s done\n", num, __func__);
 }
 
 static void gsmld_receive_buf(struct tty_struct *tty, const unsigned char *cp,
@@ -2488,8 +4018,14 @@ static void gsmld_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 	struct gsm_mux *gsm = tty->disc_data;
 	char flags = TTY_NORMAL;
 
-	if (debug & 4)
-		print_hex_dump_bytes("gsmld_receive: ", DUMP_PREFIX_OFFSET,
+	if (!gsm)
+		return;
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s\n", gsm->num, __func__);
+
+	if (debug & DBG_DATA)
+		print_hex_dump_bytes("gsmld_receive_buf: ", DUMP_PREFIX_OFFSET,
 				     cp, count);
 
 	for (; count; count--, cp++) {
@@ -2507,50 +4043,84 @@ static void gsmld_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 			break;
 		default:
 			WARN_ONCE(1, "%s: unknown flag %d\n",
-			       tty_name(tty), flags);
+				  tty_name(tty), flags);
 			break;
 		}
 	}
-	/* FASYNC if needed ? */
+	/* FASYNC if needed? */
 	/* If clogged call tty_throttle(tty); */
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s done\n", gsm->num, __func__);
 }
 
 /**
  *	gsmld_flush_buffer	-	clean input queue
- *	@tty:	terminal device
+ *	@tty:   terminal device
  *
  *	Flush the input buffer. Called when the line discipline is
  *	being closed, when the tty layer wants the buffer flushed (eg
  *	at hangup).
  */
-
 static void gsmld_flush_buffer(struct tty_struct *tty)
 {
+	if (debug & DBG_CALLS)
+		pr_debug("%s\n", __func__);
+	if (debug & DBG_CALLS)
+		pr_debug("%s done\n", __func__);
 }
 
 /**
- *	gsmld_close		-	close the ldisc for this tty
+ *	gsmld_close	-	close the ldisc for this tty
  *	@tty: device
  *
  *	Called from the terminal layer when this line discipline is
- *	being shut down, either because of a close or becsuse of a
+ *	being shut down, either because of a close or because of a
  *	discipline change. The function will not be called while other
- *	ldisc methods are in progress.
+ *	ldisc methods are in progress and runs in atomic context.
  */
-
 static void gsmld_close(struct tty_struct *tty)
 {
-	struct gsm_mux *gsm = tty->disc_data;
+	struct gsm_mux *gsm;
+	unsigned int num;
+	unsigned long tx_flags;
 
+	mutex_lock(&gsm_mux_mutex);
+	gsm = tty->disc_data;
+
+	if (!gsm) {
+		mutex_unlock(&gsm_mux_mutex);
+		return;
+	}
+
+	num = gsm->num;
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s\n", num, __func__);
+
+	/* The ldisc locks and closes the port before calling our close. This
+	 * means we have no way to do a proper disconnect. We will not bother
+	 * to do one.
+	 */
+	gsm_cleanup_mux(gsm, false);
+
+	/* Prevent write during detach */
+	spin_lock_irqsave(&gsm->tx_lock, tx_flags);
 	gsmld_detach_gsm(tty, gsm);
+	spin_unlock_irqrestore(&gsm->tx_lock, tx_flags);
 
 	gsmld_flush_buffer(tty);
+
 	/* Do other clean up here */
 	mux_put(gsm);
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s done\n", num, __func__);
+
+	mutex_unlock(&gsm_mux_mutex);
 }
 
 /**
- *	gsmld_open		-	open an ldisc
+ *	gsmld_open	-	open an ldisc
  *	@tty: terminal to open
  *
  *	Called when this line discipline is being attached to the
@@ -2558,31 +4128,62 @@ static void gsmld_close(struct tty_struct *tty)
  *	other events will occur in parallel. No further open will occur
  *	until a close.
  */
-
 static int gsmld_open(struct tty_struct *tty)
 {
 	struct gsm_mux *gsm;
 	int ret;
+	int num = -1;
 
-	if (tty->ops->write == NULL)
-		return -EINVAL;
+	mutex_lock(&gsm_mux_mutex);
+	if (debug & DBG_CALLS)
+		pr_debug("%s\n", __func__);
+
+	if (!tty->ops->write) {
+		ret = -EINVAL;
+		goto err_unlock;
+	}
+
+	if (!test_bit(TTY_LDISC_OPEN, &tty->flags)) {
+		pr_debug("gsmld_open: tty ldisc not open\n");
+		ret = -EINVAL;
+		goto err_unlock;
+	}
 
 	/* Attach our ldisc data */
 	gsm = gsm_alloc_mux();
-	if (gsm == NULL)
-		return -ENOMEM;
+	if (!gsm) {
+		ret = -ENOMEM;
+		goto err_unlock;
+	}
+	num = gsm->num;
 
 	tty->disc_data = gsm;
 	tty->receive_room = 65536;
 
 	/* Attach the initial passive connection */
-	gsm->encoding = 1;
-
 	ret = gsmld_attach_gsm(tty, gsm);
 	if (ret != 0) {
-		gsm_cleanup_mux(gsm);
 		mux_put(gsm);
+		goto err_unlock;
 	}
+	/* The mux will not be activated yet, we wait for correct
+	 * configuration first.
+	 */
+	if (gsm->encoding == GSM_BASIC_OPT)
+		gsm->receive = gsm0_receive;
+	else
+		gsm->receive = gsm1_receive;
+
+	timer_setup(&gsm->kick_timer, gsm_kick_timer, 0);
+	timer_setup(&gsm->t2_timer, gsm_control_retransmit, 0);
+	timer_setup(&gsm->ka_timer, gsm_control_keep_alive, 0);
+	tasklet_init(&gsm->tx_tsk, gsmld_write_task, (unsigned long)gsm);
+
+err_unlock:
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s done %d\n", num, __func__, ret);
+	mutex_unlock(&gsm_mux_mutex);
+
 	return ret;
 }
 
@@ -2594,24 +4195,26 @@ static int gsmld_open(struct tty_struct *tty)
  *	that attach themselves to the master and rely on ASYNC
  *	IO must be woken up
  */
-
 static void gsmld_write_wakeup(struct tty_struct *tty)
 {
 	struct gsm_mux *gsm = tty->disc_data;
-	unsigned long flags;
+
+	if (!gsm)
+		return;
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s\n", gsm->num, __func__);
 
 	/* Queue poll */
 	clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
-	spin_lock_irqsave(&gsm->tx_lock, flags);
-	gsm_data_kick(gsm, NULL);
-	if (gsm->tx_bytes < TX_THRESH_LO) {
-		gsm_dlci_data_sweep(gsm);
-	}
-	spin_unlock_irqrestore(&gsm->tx_lock, flags);
+	gsmld_write_trigger(gsm);
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s done\n", gsm->num, __func__);
 }
 
 /**
- *	gsmld_read		-	read function for tty
+ *	gsmld_read	-	read function for tty
  *	@tty: tty device
  *	@file: file object
  *	@buf: userspace buffer pointer
@@ -2626,7 +4229,6 @@ static void gsmld_write_wakeup(struct tty_struct *tty)
  *
  *	This code must be sure never to sleep through a hangup.
  */
-
 static ssize_t gsmld_read(struct tty_struct *tty, struct file *file,
 			  unsigned char *buf, size_t nr,
 			  void **cookie, unsigned long offset)
@@ -2635,31 +4237,49 @@ static ssize_t gsmld_read(struct tty_struct *tty, struct file *file,
 }
 
 /**
- *	gsmld_write		-	write function for tty
+ *	gsmld_write	-	write function for tty
  *	@tty: tty device
  *	@file: file object
- *	@buf: userspace buffer pointer
+ *	@buf: user space buffer pointer
  *	@nr: size of I/O
  *
  *	Called when the owner of the device wants to send a frame
  *	itself (or some other control data). The data is transferred
  *	as-is and must be properly framed and checksummed as appropriate
- *	by userspace. Frames are either sent whole or not at all as this
+ *	by user space. Frames are either sent whole or not at all as this
  *	avoids pain user side.
  */
-
 static ssize_t gsmld_write(struct tty_struct *tty, struct file *file,
 			   const unsigned char *buf, size_t nr)
 {
-	int space = tty_write_room(tty);
-	if (space >= nr)
-		return tty->ops->write(tty, buf, nr);
-	set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
-	return -ENOBUFS;
+	int space;
+	int ret;
+	struct gsm_mux *gsm = tty->disc_data;
+	unsigned long flags;
+
+	if (!gsm)
+		return -ENODEV;
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s\n", gsm->num, __func__);
+
+	space = tty_write_room(tty);
+	if (space >= nr) {
+		spin_lock_irqsave(&gsm->tx_lock, flags);
+		ret = tty->ops->write(tty, buf, nr);
+		spin_unlock_irqrestore(&gsm->tx_lock, flags);
+	} else {
+		set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
+		ret = -ENOBUFS;
+	}
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s done %d\n", gsm->num, __func__, ret);
+	return ret;
 }
 
 /**
- *	gsmld_poll		-	poll method for N_GSM0710
+ *	gsmld_poll	-	poll method for N_GSM0710
  *	@tty: terminal device
  *	@file: file accessing it
  *	@wait: poll table
@@ -2671,64 +4291,365 @@ static ssize_t gsmld_write(struct tty_struct *tty, struct file *file,
  *	This code must be sure never to sleep through a hangup.
  *	Called without the kernel lock held - fine
  */
-
 static __poll_t gsmld_poll(struct tty_struct *tty, struct file *file,
-							poll_table *wait)
+			   poll_table *wait)
 {
 	__poll_t mask = 0;
 	struct gsm_mux *gsm = tty->disc_data;
 
+	if (!gsm)
+		return EPOLLHUP;
+
 	poll_wait(file, &tty->read_wait, wait);
 	poll_wait(file, &tty->write_wait, wait);
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s\n", gsm->num, __func__);
+
+	if (gsm->dead)
+		mask |= EPOLLHUP;
 	if (tty_hung_up_p(file))
 		mask |= EPOLLHUP;
+	if (test_bit(TTY_OTHER_CLOSED, &tty->flags))
+		mask |= EPOLLHUP;
 	if (!tty_is_writelocked(tty) && tty_write_room(tty) > 0)
 		mask |= EPOLLOUT | EPOLLWRNORM;
-	if (gsm->dead)
-		mask |= EPOLLHUP;
+
+	if (debug & DBG_CALLS)
+		pr_debug("%s done(0x%x)\n", __func__, mask);
 	return mask;
 }
 
+/**
+ *	gsm_copy_config_values	-	set user configuration
+ *	@gsm: source mux instance
+ *	@c: target configuration
+ */
+static void gsm_copy_config_values(const struct gsm_mux *gsm,
+				   struct gsm_config *c)
+{
+	memset(c, 0, sizeof(*c));
+	c->adaption = gsm->adaption;
+	c->encapsulation = (int)gsm->encoding;
+	c->initiator = gsm->initiator;
+	c->t1 = gsm->t1;
+	c->t2 = gsm->t2;
+	c->t3 = gsm->t3;
+	c->n2 = gsm->n2;
+	if (gsm->ftype == UIH)
+		c->i = 1;
+	else
+		c->i = 2;
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s Ftype %d i %d\n", gsm->num, __func__,
+			gsm->ftype, c->i);
+	c->mru = gsm->mru;
+	c->mtu = gsm->mtu;
+	c->k = gsm->k;
+	c->port = gsm->num;
+	c->wait_config = gsm->wait_config ? 1 : 0;
+	c->keep_alive = gsm->keep_alive;
+	c->sof_intvl = gsm->sof_intvl;
+}
+
+/**
+ *	gsm_config	-	set mux configuration
+ *	@gsm: mux to configure
+ *	@c: source configuration
+ */
+static int gsm_config(struct gsm_mux *gsm, const struct gsm_config *c)
+{
+	int ret = 0;
+	int need_close = false;
+	int need_restart = false;
+	int t1, t2;
+	struct gsm_mux *found;
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s\n", gsm->num, __func__);
+
+	/* Stuff we don't support yet - I frame transport */
+	if (c->adaption != 1 && c->adaption != 2)
+		return -EOPNOTSUPP;
+	if (c->t1 > 255)
+		return -EINVAL;
+	if (c->t2 < 2 || c->t2 > 255)
+		return -EINVAL;
+	if (strict) {
+		t1 = gsm->t1;
+		t2 = gsm->t2;
+		if (c->t1)
+			t1 = c->t1;
+		if (c->t2)
+			t2 = c->t2;
+		if (t1 >= t2)
+			return -EINVAL;
+	}
+	if (c->t3 > 255)
+		return -EINVAL;
+	if (c->n2 > 255)
+		return -EINVAL;
+	/* Check the MRU/MTU range looks sane */
+	if (c->mru > MAX_MRU || c->mtu > MAX_MTU)
+		return -EINVAL;
+	if (c->mru < MIN_UNIT || c->mtu < MIN_UNIT)
+		return -EINVAL;
+	if (c->mtu > c->mru)
+		return -EINVAL;
+	if (strict && (c->mru > 32768 || c->mtu > 32768))
+		return -EINVAL;
+	if (c->encapsulation > 1)   /* Basic, advanced, no I */
+		return -EINVAL;
+	if (c->initiator > 1)
+		return -EINVAL;
+	if (c->k > 7)
+		return -EINVAL;
+	if (c->i == 0 || c->i > 2)  /* UIH and UI only */
+		return -EINVAL;
+	if (c->port >= MAX_MUX)
+		return -EINVAL;
+	found = gsm_get_mux(c->port);
+	if (found) {
+		/* If there is a mux with that number then it must be the same
+		 * instance.
+		 */
+		if (found != gsm)
+			return -EBUSY;
+	}
+
+	/*
+	 * See what is needed for reconfiguration
+	 */
+	/* Instance */
+	if (gsm->num != c->port)
+		need_restart = true;
+	/* Timing fields */
+	if (c->t1 != 0 && c->t1 != gsm->t1)
+		need_restart = true;
+	if (c->t2 != 0 && c->t2 != gsm->t2)
+		need_restart = true;
+	if (c->encapsulation != gsm->encoding)
+		need_restart = true;
+	if (c->adaption != gsm->adaption)
+		need_restart = true;
+	/* Requires care */
+	if (c->initiator != gsm->initiator)
+		need_close = true;
+	if (c->mru != gsm->mru)
+		need_restart = true;
+	if (c->mtu != gsm->mtu)
+		need_restart = true;
+	if (c->keep_alive != gsm->keep_alive)
+		need_restart = true;
+	if (c->restart)
+		need_restart = true;
+
+	/*
+	 * Close down what is needed, restart and initiate the new
+	 * configuration, on the first time there is no DLCI[0]
+	 * and closing or cleaning up is not necessary.
+	 */
+	if (need_close || need_restart) {
+		gsm_cleanup_mux(gsm, true);
+		ret = gsm_assign_num(gsm, c->port);
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * Setup the new configuration values
+	 */
+	gsm->initiator = c->initiator;
+	gsm->mru = c->mru;
+	gsm->mtu = c->mtu;
+	gsm->encoding = c->encapsulation ? GSM_ADV_OPT : GSM_BASIC_OPT;
+	gsm->adaption = c->adaption;
+	gsm->n2 = c->n2;
+	gsm->wait_config = c->wait_config ? true : false;
+	gsm->keep_alive = c->keep_alive;
+	gsm->sof_intvl = c->sof_intvl;
+
+	if (c->i == 1)
+		gsm->ftype = UIH;
+	else if (c->i == 2)
+		gsm->ftype = UI;
+
+	if (c->t1)
+		gsm->t1 = c->t1;
+	if (c->t2)
+		gsm->t2 = c->t2;
+	if (c->t3)
+		gsm->t3 = c->t3;
+	if (c->k)
+		gsm->k = c->k;
+
+	/* FIXME: We need to separate activation/deactivation from adding
+	 * and removing from the mux array
+	 */
+	ret = gsm_activate_mux(gsm);
+	if (ret)
+		return ret;
+
+	if (gsm->initiator)
+		gsm_dlci_begin_open(gsm->dlci[0]);
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s done\n", gsm->num, __func__);
+
+	return ret;
+}
+
+/**
+ *	gsmld_ioctl	-	process IOCTL system call for the tty device
+ *	@tty: tty device
+ *	@cmd: IOCTL command code
+ *	@arg: argument for IOCTL call (cmd dependent)
+ */
 static int gsmld_ioctl(struct tty_struct *tty, unsigned int cmd,
 		       unsigned long arg)
 {
+	int ret = 0;
 	struct gsm_config c;
+	struct gsm_dlci_config dc;
 	struct gsm_mux *gsm = tty->disc_data;
-	unsigned int base;
+	struct gsm_dlci *dlci;
+
+	if (!gsm)
+		return -ENODEV;
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s\n", gsm->num, __func__);
 
 	switch (cmd) {
 	case GSMIOC_GETCONF:
+		if (debug & DBG_CALLS)
+			pr_debug("%u:%s GETCONF\n", gsm->num, __func__);
+		mutex_lock(&gsm_mux_mutex);
 		gsm_copy_config_values(gsm, &c);
 		if (copy_to_user((void __user *)arg, &c, sizeof(c)))
-			return -EFAULT;
-		return 0;
+			ret = -EFAULT;
+		else
+			ret = 0;
+		mutex_unlock(&gsm_mux_mutex);
+		break;
 	case GSMIOC_SETCONF:
+		if (debug & DBG_CALLS)
+			pr_debug("%u:%s SETCONF\n", gsm->num, __func__);
+		mutex_lock(&gsm_mux_mutex);
 		if (copy_from_user(&c, (void __user *)arg, sizeof(c)))
+			ret = -EFAULT;
+		else
+			ret = gsm_config(gsm, &c);
+		mutex_unlock(&gsm_mux_mutex);
+		break;
+	case GSMIOC_GETCONF_DLCI:
+		if (debug & DBG_CALLS)
+			pr_debug("%u:%s GETCONF_DLCI\n", gsm->num, __func__);
+		if (copy_from_user(&dc, (void __user *)arg, sizeof(dc)))
+			return -EFAULT;
+		if (dc.channel == 0 || dc.channel >= NUM_DLCI)
+			return -EINVAL;
+		dlci = gsm->dlci[dc.channel];
+		if (!dlci) {
+			dlci = gsm_dlci_alloc(gsm, dc.channel);
+			if (!dlci) {
+				gsm->open_error++;
+				return -EINVAL;
+			}
+		}
+		memset(&dc, 0, sizeof(dc));
+		dc.channel = dlci->addr;
+		dc.adaption = dlci->adaption;
+		dc.mtu = dlci->mtu;
+		dc.priority = dlci->prio;
+		if (dlci->ftype == UIH)
+			dc.i = 1;
+		else
+			dc.i = 2;
+		dc.k = dlci->k;
+		if (copy_to_user((void __user *)arg, &dc, sizeof(dc)))
+			ret = -EFAULT;
+		else
+			ret = 0;
+		break;
+	case GSMIOC_SETCONF_DLCI:
+		if (debug & DBG_CALLS)
+			pr_debug("%u:%s SETCONF_DLCI\n", gsm->num, __func__);
+		if (copy_from_user(&dc, (void __user *)arg, sizeof(dc)))
 			return -EFAULT;
-		return gsm_config(gsm, &c);
+		if (dc.channel == 0 || dc.channel >= NUM_DLCI)
+			return -EINVAL;
+		dlci = gsm->dlci[dc.channel];
+		if (!dlci) {
+			dlci = gsm_dlci_alloc(gsm, dc.channel);
+			if (!dlci) {
+				gsm->open_error++;
+				return -EINVAL;
+			}
+		}
+		ret = gsm_dlci_config(dlci, &dc, 0);
+		break;
 	case GSMIOC_GETFIRST:
-		base = mux_num_to_base(gsm);
-		return put_user(base + 1, (__u32 __user *)arg);
+		return put_user(mux_num_to_base(gsm) + 1, (__u32 __user *)arg);
 	default:
-		return n_tty_ioctl_helper(tty, cmd, arg);
+		if (debug & DBG_CALLS)
+			pr_debug("%u:%s UNKNOWN(0x%X)\n", gsm->num, __func__,
+				 cmd);
+		ret = n_tty_ioctl_helper(tty, cmd, arg);
+		break;
 	}
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s done %d\n", gsm->num, __func__, ret);
+	return ret;
+}
+
+/**
+ *	gsmld_hangup	-	hangup on associated tty
+ *	@tty: device
+ *
+ *	Called from the terminal layer when this line discipline is
+ *	being hung up. The function will not be called while other
+ *	ldisc methods are in progress and runs in atomic context.
+ */
+static void gsmld_hangup(struct tty_struct *tty)
+{
+	struct gsm_mux *gsm = tty->disc_data;
+
+	if (!gsm)
+		return;
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s\n", gsm->num, __func__);
+
+	/* gsmld_close is called by tty_ldisc_hangup after hangup */
+
+	if (debug & DBG_CALLS)
+		pr_debug("%u:%s done\n", gsm->num, __func__);
 }
 
 /*
  *	Network interface
- *
  */
 
 static int gsm_mux_net_open(struct net_device *net)
 {
-	pr_debug("%s called\n", __func__);
+	if (debug & DBG_CALLS)
+		pr_debug("%s\n", __func__);
 	netif_start_queue(net);
+	if (debug & DBG_CALLS)
+		pr_debug("%s done\n", __func__);
 	return 0;
 }
 
 static int gsm_mux_net_close(struct net_device *net)
 {
+	if (debug & DBG_CALLS)
+		pr_debug("%s\n", __func__);
+
 	netif_stop_queue(net);
+
+	if (debug & DBG_CALLS)
+		pr_debug("%s done\n", __func__);
 	return 0;
 }
 
@@ -2743,6 +4664,7 @@ static void dlci_net_free(struct gsm_dlci *dlci)
 	free_netdev(dlci->net);
 	dlci->net = NULL;
 }
+
 static void net_free(struct kref *ref)
 {
 	struct gsm_mux_net *mux_net;
@@ -2768,7 +4690,7 @@ static inline void muxnet_put(struct gsm_mux_net *mux_net)
 }
 
 static netdev_tx_t gsm_mux_net_start_xmit(struct sk_buff *skb,
-				      struct net_device *net)
+					  struct net_device *net)
 {
 	struct gsm_mux_net *mux_net = netdev_priv(net);
 	struct gsm_dlci *dlci = mux_net->dlci;
@@ -2784,8 +4706,9 @@ static netdev_tx_t gsm_mux_net_start_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
-/* called when a packet did not ack after watchdogtimeout */
-static void gsm_mux_net_tx_timeout(struct net_device *net, unsigned int txqueue)
+/* called when a packet did not ack after watchdog timeout */
+static void gsm_mux_net_tx_timeout(struct net_device *net,
+				   unsigned int txqueue)
 {
 	/* Tell syslog we are hosed. */
 	dev_dbg(&net->dev, "Tx timed out.\n");
@@ -2795,7 +4718,7 @@ static void gsm_mux_net_tx_timeout(struct net_device *net, unsigned int txqueue)
 }
 
 static void gsm_mux_rx_netchar(struct gsm_dlci *dlci,
-				const unsigned char *in_buf, int size)
+			       const unsigned char *in_buf, int size)
 {
 	struct net_device *net = dlci->net;
 	struct sk_buff *skb;
@@ -2829,10 +4752,10 @@ static void gsm_mux_rx_netchar(struct gsm_dlci *dlci,
 static void gsm_mux_net_init(struct net_device *net)
 {
 	static const struct net_device_ops gsm_netdev_ops = {
-		.ndo_open		= gsm_mux_net_open,
-		.ndo_stop		= gsm_mux_net_close,
-		.ndo_start_xmit		= gsm_mux_net_start_xmit,
-		.ndo_tx_timeout		= gsm_mux_net_tx_timeout,
+		.ndo_open       = gsm_mux_net_open,
+		.ndo_stop       = gsm_mux_net_close,
+		.ndo_start_xmit = gsm_mux_net_start_xmit,
+		.ndo_tx_timeout = gsm_mux_net_tx_timeout
 	};
 
 	net->netdev_ops = &gsm_netdev_ops;
@@ -2884,13 +4807,15 @@ static int gsm_create_network(struct gsm_dlci *dlci, struct gsm_netconfig *nc)
 	netname = "gsm%d";
 	if (nc->if_name[0] != '\0')
 		netname = nc->if_name;
+
 	net = alloc_netdev(sizeof(struct gsm_mux_net), netname,
 			   NET_NAME_UNKNOWN, gsm_mux_net_init);
+
 	if (!net) {
 		pr_err("alloc_netdev failed\n");
 		return -ENOMEM;
 	}
-	net->mtu = dlci->gsm->mtu;
+	net->mtu = dlci->mtu;
 	net->min_mtu = 8;
 	net->max_mtu = dlci->gsm->mtu;
 	mux_net = netdev_priv(net);
@@ -2912,13 +4837,13 @@ static int gsm_create_network(struct gsm_dlci *dlci, struct gsm_netconfig *nc)
 		dlci_net_free(dlci);
 		return retval;
 	}
-	return net->ifindex;	/* return network index */
+	return net->ifindex;    /* return network index */
 }
 
 /* Line discipline for real tty */
 static struct tty_ldisc_ops tty_ldisc_packet = {
-	.owner		 = THIS_MODULE,
-	.num		 = N_GSM0710,
+	.owner           = THIS_MODULE,
+	.num             = N_GSM0710,
 	.name            = "n_gsm",
 	.open            = gsmld_open,
 	.close           = gsmld_close,
@@ -2928,6 +4853,7 @@ static struct tty_ldisc_ops tty_ldisc_packet = {
 	.ioctl           = gsmld_ioctl,
 	.poll            = gsmld_poll,
 	.receive_buf     = gsmld_receive_buf,
+	.hangup          = gsmld_hangup,
 	.write_wakeup    = gsmld_write_wakeup
 };
 
@@ -2935,74 +4861,158 @@ static struct tty_ldisc_ops tty_ldisc_packet = {
  *	Virtual tty side
  */
 
-#define TX_SIZE		512
+#define TX_SIZE     512
+
+/**
+ *	gsm_modem_upd_via_data	-	send modem bits via convergence layer
+ *	@dlci: channel
+ *	@brk: break signal
+ */
+static void gsm_modem_upd_via_data(struct gsm_dlci *dlci, u8 brk)
+{
+	gsm_dlci_modem_update(dlci, brk);
+}
 
-static int gsmtty_modem_update(struct gsm_dlci *dlci, u8 brk)
+/**
+ *	gsm_modem_upd_via_msc	-	send modem bits via control frame
+ *	@dlci: channel
+ *	@brk: break signal
+ */
+static int gsm_modem_upd_via_msc(struct gsm_dlci *dlci, u8 brk)
 {
 	u8 modembits[5];
 	struct gsm_control *ctrl;
 	int len = 2;
 
+	if (dlci->gsm->encoding != GSM_BASIC_OPT)
+		return 0;
+
 	if (brk)
 		len++;
 
-	modembits[0] = len << 1 | EA;		/* Data bytes */
-	modembits[1] = dlci->addr << 2 | 3;	/* DLCI, EA, 1 */
-	modembits[2] = gsm_encode_modem(dlci) << 1 | EA;
-	if (brk)
-		modembits[3] = brk << 4 | 2 | EA;	/* Valid, EA */
+	modembits[0] = (len << 1) | EA;          /* Data bytes */
+	modembits[1] = (dlci->addr << 2) | 3;    /* DLCI, EA, 1 */
+	if (!brk) {
+		modembits[2] = (gsm_encode_modem(dlci) << 1) | EA;
+	} else {
+		modembits[2] = gsm_encode_modem(dlci) << 1;
+		modembits[3] = (brk << 4) | 2 | EA; /* Valid, EA */
+	}
+
 	ctrl = gsm_control_send(dlci->gsm, CMD_MSC, modembits, len + 1);
-	if (ctrl == NULL)
+	if (!ctrl)
 		return -ENOMEM;
+	/* we cannot receive the real answer but leaving now */
 	return gsm_control_wait(dlci->gsm, ctrl);
 }
 
+/**
+ *	gsm_modem_update	-	send modem status line state
+ *	@dlci: channel
+ *	@brk: break signal
+ */
+static int gsm_modem_update(struct gsm_dlci *dlci, u8 brk)
+{
+	if (dlci->adaption == 2) {
+		/* send convergence layer type 2 empty data frame */
+		gsm_modem_upd_via_data(dlci, brk);
+		return 0;
+	} else if (dlci->gsm->encoding == GSM_BASIC_OPT) {
+		/* send as MSC control message */
+		return gsm_modem_upd_via_msc(dlci, brk);
+	}
+
+	/* modem status lines are not supported */
+	return -EPROTONOSUPPORT;
+}
+
+/**
+ *	gsm_wait_modem_change	-	wait for modem status line change
+ *	@dlci: channel
+ *	@mask: modem status line bits
+ */
+static int gsm_wait_modem_change(struct gsm_dlci *dlci, u32 mask)
+{
+	struct gsm_mux *gsm = dlci->gsm;
+	u32 old = dlci->modem_rx & mask;
+	int ret;
+
+	if (gsm->dead)
+		return -ENODEV;
+
+	do {
+		ret = wait_event_interruptible(gsm->event, gsm->dead
+					      || old ^ (dlci->modem_rx & mask));
+		if (ret)
+			return ret;
+		if (dlci->state != DLCI_OPEN)
+			return -EL2NSYNC;
+		if (gsm->dead)
+			return -ENODEV;
+	} while ((old ^ (dlci->modem_rx & mask)) == 0);
+
+	return 0;
+}
+
+/**
+ *	gsm_carrier_raised	-	get line carrier state
+ *	@port: tty device
+ */
 static int gsm_carrier_raised(struct tty_port *port)
 {
 	struct gsm_dlci *dlci = container_of(port, struct gsm_dlci, port);
 	struct gsm_mux *gsm = dlci->gsm;
 
+	if (debug & DBG_DATA)
+		pr_info("%u:%s dlci[%d]->state %d\n", dlci->gsm->num,
+			__func__, dlci->addr, dlci->state);
 	/* Not yet open so no carrier info */
 	if (dlci->state != DLCI_OPEN)
 		return 0;
-	if (debug & 2)
-		return 1;
-
 	/*
 	 * Basic mode with control channel in ADM mode may not respond
 	 * to CMD_MSC at all and modem_rx is empty.
 	 */
-	if (gsm->encoding == 0 && gsm->dlci[0]->mode == DLCI_MODE_ADM &&
-	    !dlci->modem_rx)
+	if (gsm->encoding == GSM_BASIC_OPT &&
+	    gsm->dlci[0]->mode == DLCI_MODE_ADM && !dlci->modem_rx)
 		return 1;
-
 	return dlci->modem_rx & TIOCM_CD;
 }
 
+/**
+ *	gsm_dtr_rts	-	set DTR/RTS
+ *	@port: tty device
+ *	@onoff: new state
+ */
 static void gsm_dtr_rts(struct tty_port *port, int onoff)
 {
 	struct gsm_dlci *dlci = container_of(port, struct gsm_dlci, port);
 	unsigned int modem_tx = dlci->modem_tx;
+
+	if (debug & DBG_DATA)
+		pr_info("%u:%s dlci[%d] dtr/rts %d\n", dlci->gsm->num,
+			__func__, dlci->addr, onoff);
+
 	if (onoff)
 		modem_tx |= TIOCM_DTR | TIOCM_RTS;
 	else
 		modem_tx &= ~(TIOCM_DTR | TIOCM_RTS);
 	if (modem_tx != dlci->modem_tx) {
 		dlci->modem_tx = modem_tx;
-		gsmtty_modem_update(dlci, 0);
+		gsm_modem_update(dlci, 0);
 	}
 }
 
 static const struct tty_port_operations gsm_port_ops = {
 	.carrier_raised = gsm_carrier_raised,
-	.dtr_rts = gsm_dtr_rts,
-	.destruct = gsm_dlci_free,
+	.dtr_rts        = gsm_dtr_rts,
+	.destruct       = gsm_dlci_free,
 };
 
 static int gsmtty_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct gsm_mux *gsm;
-	struct gsm_dlci *dlci;
+	struct gsm_dlci *dlci = NULL;
 	unsigned int line = tty->index;
 	unsigned int mux = mux_line_to_num(line);
 	bool alloc = false;
@@ -3010,67 +5020,83 @@ static int gsmtty_install(struct tty_driver *driver, struct tty_struct *tty)
 
 	line = line & 0x3F;
 
+	if (debug & DBG_DATA)
+		pr_info("%s: install line %d\n", __func__, line);
+	if (line == 0 || line > 61) /* 62/63 reserved */
+		return -ECHRNG;
 	if (mux >= MAX_MUX)
 		return -ENXIO;
-	/* FIXME: we need to lock gsm_mux for lifetimes of ttys eventually */
-	if (gsm_mux[mux] == NULL)
+	gsm = gsm_get_mux(mux);
+	if (!gsm)
 		return -EUNATCH;
-	if (line == 0 || line > 61)	/* 62/63 reserved */
-		return -ECHRNG;
-	gsm = gsm_mux[mux];
 	if (gsm->dead)
 		return -EL2HLT;
 	/* If DLCI 0 is not yet fully open return an error.
-	This is ok from a locking
-	perspective as we don't have to worry about this
-	if DLCI0 is lost */
+	 * This is ok from a locking perspective as we don't have to worry about
+	 * this if DLCI0 is lost
+	 */
 	mutex_lock(&gsm->mutex);
 	if (gsm->dlci[0] && gsm->dlci[0]->state != DLCI_OPEN) {
 		mutex_unlock(&gsm->mutex);
 		return -EL2NSYNC;
 	}
 	dlci = gsm->dlci[line];
-	if (dlci == NULL) {
+	if (!dlci) {
 		alloc = true;
 		dlci = gsm_dlci_alloc(gsm, line);
 	}
-	if (dlci == NULL) {
+	if (!dlci) {
 		mutex_unlock(&gsm->mutex);
 		return -ENOMEM;
 	}
 	ret = tty_port_install(&dlci->port, driver, tty);
-	if (ret) {
-		if (alloc)
-			dlci_put(dlci);
-		mutex_unlock(&gsm->mutex);
-		return ret;
+	if (ret == 0) {
+		dlci_get(dlci);
+		dlci_get(gsm->dlci[0]);
+		mux_get(gsm);
+		tty->driver_data = dlci;
+	} else if (alloc) {
+		dlci_put(dlci);
 	}
-
-	dlci_get(dlci);
-	dlci_get(gsm->dlci[0]);
-	mux_get(gsm);
-	tty->driver_data = dlci;
 	mutex_unlock(&gsm->mutex);
-
-	return 0;
+	return ret;
 }
 
 static int gsmtty_open(struct tty_struct *tty, struct file *filp)
 {
 	struct gsm_dlci *dlci = tty->driver_data;
 	struct tty_port *port = &dlci->port;
-	struct gsm_mux *gsm = dlci->gsm;
 
+	if (debug & DBG_DATA) {
+		struct gsm_mux *gsm = dlci->gsm;
+
+		pr_info("%u:%s open %d\n", gsm->num, __func__,
+			dlci->addr);
+		pr_info("%u:%s O_NONBLOCK =%d\n", gsm->num, __func__,
+			filp->f_flags & O_NONBLOCK);
+		pr_info("%u:%s O_RDONLY   =%d\n", gsm->num, __func__,
+			filp->f_flags & O_RDONLY);
+		pr_info("%u:%s O_RDWR     =%d\n", gsm->num, __func__,
+			filp->f_flags & O_RDWR);
+	}
 	port->count++;
 	tty_port_tty_set(port, tty);
 
 	dlci->modem_rx = 0;
-	/* We could in theory open and close before we wait - eg if we get
-	   a DM straight back. This is ok as that will have caused a hangup */
+
+	/* We could in theory open and close before we wait - e.g. if we get
+	 * a DM straight back. This is ok as that will have caused a hangup
+	 */
 	tty_port_set_initialized(port, 1);
-	/* Start sending off SABM messages */
-	if (gsm->initiator)
-		gsm_dlci_begin_open(dlci);
+	if (!dlci->gsm->wait_config) {
+		/* Start sending off SABM messages */
+		if (dlci->gsm->initiator)
+			gsm_dlci_begin_open(dlci);
+		else
+			gsm_dlci_wait_open(dlci);
+	} else {
+		gsm_dlci_wait_config(dlci);
+	}
 	/* And wait for virtual carrier */
 	return tty_port_block_til_ready(port, tty, filp);
 }
@@ -3079,39 +5105,55 @@ static void gsmtty_close(struct tty_struct *tty, struct file *filp)
 {
 	struct gsm_dlci *dlci = tty->driver_data;
 
-	if (dlci == NULL)
+	if (!dlci || dlci->gsm->dead)
 		return;
 	if (dlci->state == DLCI_CLOSED)
 		return;
+
+	mutex_lock(&dlci->gsm->mutex);
+	if (dlci->gsm->dead) {
+		mutex_unlock(&dlci->gsm->mutex);
+		return;
+	}
 	mutex_lock(&dlci->mutex);
 	gsm_destroy_network(dlci);
 	mutex_unlock(&dlci->mutex);
-	if (tty_port_close_start(&dlci->port, tty, filp) == 0)
+
+	if (!tty_port_close_start(&dlci->port, tty, filp)) {
+		mutex_unlock(&dlci->gsm->mutex);
 		return;
-	gsm_dlci_begin_close(dlci);
+	}
+	/* update remote modem before disconnecting dlci? */
 	if (tty_port_initialized(&dlci->port) && C_HUPCL(tty))
 		tty_port_lower_dtr_rts(&dlci->port);
+	gsm_dlci_begin_close(dlci);
 	tty_port_close_end(&dlci->port, tty);
 	tty_port_tty_set(&dlci->port, NULL);
+	mutex_unlock(&dlci->gsm->mutex);
 	return;
 }
 
 static void gsmtty_hangup(struct tty_struct *tty)
 {
 	struct gsm_dlci *dlci = tty->driver_data;
+
 	if (dlci->state == DLCI_CLOSED)
 		return;
+
 	tty_port_hangup(&dlci->port);
 	gsm_dlci_begin_close(dlci);
 }
 
 static int gsmtty_write(struct tty_struct *tty, const unsigned char *buf,
-								    int len)
+			int len)
 {
 	int sent;
 	struct gsm_dlci *dlci = tty->driver_data;
 	if (dlci->state == DLCI_CLOSED)
 		return -EINVAL;
+	if (dlci->gsm->dead)
+		return -EBUSY;
+
 	/* Stuff the bytes into the fifo queue */
 	sent = kfifo_in_locked(&dlci->fifo, buf, len, &dlci->lock);
 	/* Need to kick the channel */
@@ -3124,6 +5166,8 @@ static unsigned int gsmtty_write_room(struct tty_struct *tty)
 	struct gsm_dlci *dlci = tty->driver_data;
 	if (dlci->state == DLCI_CLOSED)
 		return 0;
+	if (dlci->gsm->dead)
+		return 0;
 	return TX_SIZE - kfifo_len(&dlci->fifo);
 }
 
@@ -3132,27 +5176,34 @@ static unsigned int gsmtty_chars_in_buffer(struct tty_struct *tty)
 	struct gsm_dlci *dlci = tty->driver_data;
 	if (dlci->state == DLCI_CLOSED)
 		return 0;
+	if (dlci->gsm->dead)
+		return 0;
 	return kfifo_len(&dlci->fifo);
 }
 
 static void gsmtty_flush_buffer(struct tty_struct *tty)
 {
 	struct gsm_dlci *dlci = tty->driver_data;
+	unsigned long flags;
 	if (dlci->state == DLCI_CLOSED)
 		return;
 	/* Caution needed: If we implement reliable transport classes
-	   then the data being transmitted can't simply be junked once
-	   it has first hit the stack. Until then we can just blow it
-	   away */
+	 * then the data being transmitted can't simply be junked once
+	 * it has first hit the stack. Until then we can just blow it
+	 * away
+	 */
+	spin_lock_irqsave(&dlci->lock, flags);
 	kfifo_reset(&dlci->fifo);
+	spin_unlock_irqrestore(&dlci->lock, flags);
 	/* Need to unhook this DLCI from the transmit queue logic */
 }
 
 static void gsmtty_wait_until_sent(struct tty_struct *tty, int timeout)
 {
 	/* The FIFO handles the queue so the kernel will do the right
-	   thing waiting on chars_in_buffer before calling us. No work
-	   to do here */
+	 * thing waiting on chars_in_buffer before calling us. No work
+	 * to do here
+	 */
 }
 
 static int gsmtty_tiocmget(struct tty_struct *tty)
@@ -3160,6 +5211,8 @@ static int gsmtty_tiocmget(struct tty_struct *tty)
 	struct gsm_dlci *dlci = tty->driver_data;
 	if (dlci->state == DLCI_CLOSED)
 		return -EINVAL;
+	if (dlci->gsm->dead)
+		return -EBUSY;
 	return dlci->modem_rx;
 }
 
@@ -3171,28 +5224,34 @@ static int gsmtty_tiocmset(struct tty_struct *tty,
 
 	if (dlci->state == DLCI_CLOSED)
 		return -EINVAL;
+	if (dlci->gsm->dead)
+		return -EBUSY;
 	modem_tx &= ~clear;
 	modem_tx |= set;
 
 	if (modem_tx != dlci->modem_tx) {
 		dlci->modem_tx = modem_tx;
-		return gsmtty_modem_update(dlci, 0);
+		return gsm_modem_update(dlci, 0);
 	}
 	return 0;
 }
 
-
-static int gsmtty_ioctl(struct tty_struct *tty,
-			unsigned int cmd, unsigned long arg)
+static int gsmtty_ioctl(struct tty_struct *tty, unsigned int cmd,
+			unsigned long arg)
 {
 	struct gsm_dlci *dlci = tty->driver_data;
 	struct gsm_netconfig nc;
+	struct gsm_dlci_config dc;
 	int index;
+	int ret = 0;
 
 	if (dlci->state == DLCI_CLOSED)
 		return -EINVAL;
 	switch (cmd) {
 	case GSMIOC_ENABLE_NET:
+		if (debug & DBG_CALLS)
+			pr_debug("%u:%s ENABLE_NET\n", dlci->gsm->num,
+				 __func__);
 		if (copy_from_user(&nc, (void __user *)arg, sizeof(nc)))
 			return -EFAULT;
 		nc.if_name[IFNAMSIZ-1] = '\0';
@@ -3204,70 +5263,123 @@ static int gsmtty_ioctl(struct tty_struct *tty,
 			return -EFAULT;
 		return index;
 	case GSMIOC_DISABLE_NET:
+		if (debug & DBG_CALLS)
+			pr_debug("%u:%s DISABLE_NET\n", dlci->gsm->num,
+				 __func__);
 		if (!capable(CAP_NET_ADMIN))
 			return -EPERM;
 		mutex_lock(&dlci->mutex);
 		gsm_destroy_network(dlci);
 		mutex_unlock(&dlci->mutex);
 		return 0;
+	case GSMIOC_GETCONF_DLCI:
+		if (debug & DBG_CALLS)
+			pr_debug("%u:%s GETCONF_DLCI\n", dlci->gsm->num,
+				 __func__);
+		if (copy_from_user(&dc, (void __user *)arg, sizeof(dc)))
+			return -EFAULT;
+		if (dc.channel >= NUM_DLCI)
+			return -EINVAL;
+		if (dc.channel != 0 && dc.channel != dlci->addr)
+			return -EPERM;
+		memset(&dc, 0, sizeof(dc));
+		dc.channel = dlci->addr;
+		dc.adaption = dlci->adaption;
+		dc.mtu = dlci->mtu;
+		dc.priority = dlci->prio;
+		if (dlci->ftype == UIH)
+			dc.i = 1;
+		else
+			dc.i = 2;
+		dc.k = dlci->k;
+		if (copy_to_user((void __user *)arg, &dc, sizeof(dc)))
+			ret = -EFAULT;
+		else
+			ret = 0;
+		break;
+	case GSMIOC_SETCONF_DLCI:
+		if (debug & DBG_CALLS)
+			pr_debug("%u:%s SETCONF_DLCI\n", dlci->gsm->num,
+				 __func__);
+		if (copy_from_user(&dc, (void __user *)arg, sizeof(dc)))
+			return -EFAULT;
+		if (dc.channel >= NUM_DLCI)
+			return -EINVAL;
+		if (dc.channel != 0 && dc.channel != dlci->addr)
+			return -EPERM;
+		ret = gsm_dlci_config(dlci, &dc, 1);
+		break;
+	case TIOCMIWAIT:
+		if (debug & DBG_CALLS)
+			pr_debug("%u:%s TIOCMIWAIT\n", dlci->gsm->num,
+				 __func__);
+		ret = gsm_wait_modem_change(dlci, arg);
+		break;
 	default:
-		return -ENOIOCTLCMD;
+		ret = -ENOIOCTLCMD;
+		break;
 	}
+	return ret;
 }
 
 static void gsmtty_set_termios(struct tty_struct *tty, struct ktermios *old)
 {
 	struct gsm_dlci *dlci = tty->driver_data;
+
 	if (dlci->state == DLCI_CLOSED)
 		return;
 	/* For the moment its fixed. In actual fact the speed information
-	   for the virtual channel can be propogated in both directions by
-	   the RPN control message. This however rapidly gets nasty as we
-	   then have to remap modem signals each way according to whether
-	   our virtual cable is null modem etc .. */
+	 * for the virtual channel can be propagated in both directions by
+	 * the RPN control message. This however rapidly gets nasty as we
+	 * then have to remap modem signals each way according to whether
+	 * our virtual cable is null modem etc ..
+	 */
 	tty_termios_copy_hw(&tty->termios, old);
 }
 
 static void gsmtty_throttle(struct tty_struct *tty)
 {
 	struct gsm_dlci *dlci = tty->driver_data;
+
 	if (dlci->state == DLCI_CLOSED)
 		return;
 	if (C_CRTSCTS(tty))
-		dlci->modem_tx &= ~TIOCM_DTR;
+		dlci->modem_tx &= ~TIOCM_RTS;
 	dlci->throttled = true;
-	/* Send an MSC with DTR cleared */
-	gsmtty_modem_update(dlci, 0);
+	/* Send an MSC with RTS cleared (or empty frame for adaption 2) */
+	gsm_modem_update(dlci, 0);
 }
 
 static void gsmtty_unthrottle(struct tty_struct *tty)
 {
 	struct gsm_dlci *dlci = tty->driver_data;
+
 	if (dlci->state == DLCI_CLOSED)
 		return;
 	if (C_CRTSCTS(tty))
-		dlci->modem_tx |= TIOCM_DTR;
+		dlci->modem_tx |= TIOCM_RTS;
 	dlci->throttled = false;
-	/* Send an MSC with DTR set */
-	gsmtty_modem_update(dlci, 0);
+	/* Send an MSC with RTS set (or empty frame for adaption 2) */
+	gsm_modem_update(dlci, 0);
 }
 
 static int gsmtty_break_ctl(struct tty_struct *tty, int state)
 {
 	struct gsm_dlci *dlci = tty->driver_data;
-	int encode = 0;	/* Off */
+	int encode = 0; /* Off */
+
 	if (dlci->state == DLCI_CLOSED)
 		return -EINVAL;
 
-	if (state == -1)	/* "On indefinitely" - we can't encode this
-				    properly */
+	if (state == -1) {
+		/* "On indefinitely" - we can't encode this properly */
 		encode = 0x0F;
-	else if (state > 0) {
-		encode = state / 200;	/* mS to encoding */
+	} else if (state > 0) {
+		encode = state / 200;   /* mS to encoding */
 		if (encode > 0x0F)
-			encode = 0x0F;	/* Best effort */
+			encode = 0x0F;  /* Best effort */
 	}
-	return gsmtty_modem_update(dlci, encode);
+	return gsm_modem_update(dlci, encode);
 }
 
 static void gsmtty_cleanup(struct tty_struct *tty)
@@ -3277,57 +5389,58 @@ static void gsmtty_cleanup(struct tty_struct *tty)
 
 	dlci_put(dlci);
 	dlci_put(gsm->dlci[0]);
+	mutex_lock(&gsm_mux_mutex);
 	mux_put(gsm);
+	mutex_unlock(&gsm_mux_mutex);
 }
 
 /* Virtual ttys for the demux */
 static const struct tty_operations gsmtty_ops = {
-	.install		= gsmtty_install,
-	.open			= gsmtty_open,
-	.close			= gsmtty_close,
-	.write			= gsmtty_write,
-	.write_room		= gsmtty_write_room,
-	.chars_in_buffer	= gsmtty_chars_in_buffer,
-	.flush_buffer		= gsmtty_flush_buffer,
-	.ioctl			= gsmtty_ioctl,
-	.throttle		= gsmtty_throttle,
-	.unthrottle		= gsmtty_unthrottle,
-	.set_termios		= gsmtty_set_termios,
-	.hangup			= gsmtty_hangup,
-	.wait_until_sent	= gsmtty_wait_until_sent,
-	.tiocmget		= gsmtty_tiocmget,
-	.tiocmset		= gsmtty_tiocmset,
-	.break_ctl		= gsmtty_break_ctl,
-	.cleanup		= gsmtty_cleanup,
+	.install         = gsmtty_install,
+	.open            = gsmtty_open,
+	.close           = gsmtty_close,
+	.write           = gsmtty_write,
+	.write_room      = gsmtty_write_room,
+	.chars_in_buffer = gsmtty_chars_in_buffer,
+	.flush_buffer    = gsmtty_flush_buffer,
+	.ioctl           = gsmtty_ioctl,
+	.throttle        = gsmtty_throttle,
+	.unthrottle      = gsmtty_unthrottle,
+	.set_termios     = gsmtty_set_termios,
+	.hangup          = gsmtty_hangup,
+	.wait_until_sent = gsmtty_wait_until_sent,
+	.tiocmget        = gsmtty_tiocmget,
+	.tiocmset        = gsmtty_tiocmset,
+	.break_ctl       = gsmtty_break_ctl,
+	.cleanup         = gsmtty_cleanup
 };
 
-
-
 static int __init gsm_init(void)
 {
 	/* Fill in our line protocol discipline, and register it */
 	int status = tty_register_ldisc(&tty_ldisc_packet);
+
 	if (status != 0) {
 		pr_err("n_gsm: can't register line discipline (err = %d)\n",
-								status);
+		       status);
 		return status;
 	}
 
-	gsm_tty_driver = tty_alloc_driver(256, TTY_DRIVER_REAL_RAW |
+	gsm_tty_driver = tty_alloc_driver(GSM_TTY_MINORS, TTY_DRIVER_REAL_RAW |
 			TTY_DRIVER_DYNAMIC_DEV | TTY_DRIVER_HARDWARE_BREAK);
 	if (IS_ERR(gsm_tty_driver)) {
 		pr_err("gsm_init: tty allocation failed.\n");
 		status = PTR_ERR(gsm_tty_driver);
 		goto err_unreg_ldisc;
 	}
-	gsm_tty_driver->driver_name	= "gsmtty";
-	gsm_tty_driver->name		= "gsmtty";
-	gsm_tty_driver->major		= 0;	/* Dynamic */
-	gsm_tty_driver->minor_start	= 0;
-	gsm_tty_driver->type		= TTY_DRIVER_TYPE_SERIAL;
-	gsm_tty_driver->subtype	= SERIAL_TYPE_NORMAL;
-	gsm_tty_driver->init_termios	= tty_std_termios;
-	/* Fixme */
+	gsm_tty_driver->driver_name = "gsmtty";
+	gsm_tty_driver->name        = "gsmtty";
+	gsm_tty_driver->major       = 0;    /* Dynamic */
+	gsm_tty_driver->minor_start = 0;
+	gsm_tty_driver->type        = TTY_DRIVER_TYPE_SERIAL;
+	gsm_tty_driver->subtype     = SERIAL_TYPE_NORMAL;
+	gsm_tty_driver->init_termios = tty_std_termios;
+	/* FIXME */
 	gsm_tty_driver->init_termios.c_lflag &= ~ECHO;
 	tty_set_operations(gsm_tty_driver, &gsmtty_ops);
 
@@ -3336,8 +5449,11 @@ static int __init gsm_init(void)
 		status = -EBUSY;
 		goto err_put_driver;
 	}
-	pr_debug("gsm_init: loaded as %d,%d.\n",
-			gsm_tty_driver->major, gsm_tty_driver->minor_start);
+
+	proc_gsm = proc_mkdir_mode("tty/ldisc/n_gsm", 0555, NULL);
+
+	pr_debug("%s: loaded as %d,%d.\n", __func__, gsm_tty_driver->major,
+		 gsm_tty_driver->minor_start);
 	return 0;
 err_put_driver:
 	tty_driver_kref_put(gsm_tty_driver);
@@ -3349,13 +5465,12 @@ static int __init gsm_init(void)
 static void __exit gsm_exit(void)
 {
 	tty_unregister_ldisc(&tty_ldisc_packet);
+	proc_remove(proc_gsm);
 	tty_unregister_driver(gsm_tty_driver);
+	pr_debug("%s: unloading %d,%d.\n", __func__, gsm_tty_driver->major,
+		 gsm_tty_driver->minor_start);
 	tty_driver_kref_put(gsm_tty_driver);
 }
 
 module_init(gsm_init);
 module_exit(gsm_exit);
-
-
-MODULE_LICENSE("GPL");
-MODULE_ALIAS_LDISC(N_GSM0710);
diff --git a/include/uapi/linux/gsmmux.h b/include/uapi/linux/gsmmux.h
index cb8693b39cb7..e401b04bf952 100644
--- a/include/uapi/linux/gsmmux.h
+++ b/include/uapi/linux/gsmmux.h
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* Portions Copyright (c) 2018-2022 Siemens Mobility GmbH */
 #ifndef _LINUX_GSMMUX_H
 #define _LINUX_GSMMUX_H
 
@@ -6,38 +7,57 @@
 #include <linux/ioctl.h>
 #include <linux/types.h>
 
-struct gsm_config
-{
-	unsigned int adaption;
-	unsigned int encapsulation;
-	unsigned int initiator;
-	unsigned int t1;
-	unsigned int t2;
-	unsigned int t3;
-	unsigned int n2;
-	unsigned int mru;
-	unsigned int mtu;
-	unsigned int k;
-	unsigned int i;
-	unsigned int unused[8];		/* Padding for expansion without
-					   breaking stuff */
+struct gsm_config {
+	unsigned int adaption;   /* Convergence layer type */
+	unsigned int encapsulation; /* Framing (0 = basic option, 1 = advanced option) */
+	unsigned int initiator;  /* Initiator or responder */
+	unsigned int t1;         /* Acknowledgment timer */
+	unsigned int t2;         /* Response timer for multiplexer control channel */
+	unsigned int t3;         /* Response timer for wake-up procedure */
+	unsigned int n2;         /* Maximum number of retransmissions */
+	unsigned int mru;        /* Maximum incoming frame payload size */
+	unsigned int mtu;        /* Maximum outgoing frame payload size */
+	unsigned int k;          /* Window size */
+	unsigned int i;          /* Frame type (1 = UIH, 2 = UI) */
+	unsigned int port;       /* Instance */
+	unsigned int keep_alive; /* Control channel keep-alive 1/100th of a sec (0 to disable) */
+	unsigned int wait_config; /* Wait for DLCI config before opening virtual link? */
+	unsigned int restart;    /* Force link reset? */
+	unsigned int sof_intvl;  /* Start-of-frame send interval in 1/100th of a sec (skipped in-between) */
+	unsigned int unused[3];  /* Padding for expansion without breaking stuff */
 };
 
-#define GSMIOC_GETCONF		_IOR('G', 0, struct gsm_config)
-#define GSMIOC_SETCONF		_IOW('G', 1, struct gsm_config)
+#define GSMIOC_GETCONF           _IOR('G', 0, struct gsm_config)
+#define GSMIOC_SETCONF           _IOW('G', 1, struct gsm_config)
 
 struct gsm_netconfig {
-	unsigned int adaption;  /* Adaption to use in network mode */
-	unsigned short protocol;/* Protocol to use - only ETH_P_IP supported */
-	unsigned short unused2;
-	char if_name[IFNAMSIZ];	/* interface name format string */
-	__u8 unused[28];        /* For future use */
+	unsigned int adaption;   /* Adaption to use in network mode */
+	unsigned short protocol; /* Protocol to use - only ETH_P_IP supported */
+	unsigned short unused2;  /* Padding */
+	char if_name[IFNAMSIZ];  /* Interface name format string */
+	__u8 unused[28];         /* For future use */
 };
 
-#define GSMIOC_ENABLE_NET      _IOW('G', 2, struct gsm_netconfig)
-#define GSMIOC_DISABLE_NET     _IO('G', 3)
+#define GSMIOC_ENABLE_NET        _IOW('G', 2, struct gsm_netconfig)
+#define GSMIOC_DISABLE_NET       _IO('G', 3)
 
-/* get the base tty number for a configured gsmmux tty */
+/* Get the base tty number for a configured gsmmux tty. */
 #define GSMIOC_GETFIRST		_IOR('G', 4, __u32)
 
+/* Set channel accordingly before calling GSMIOC_GETCONF_DLCI. */
+struct gsm_dlci_config {
+	unsigned int channel;    /* DLCI (0 for the associated DLCI) */
+	unsigned int adaption;   /* Convergence layer type */
+	unsigned int mtu;        /* Maximum transfer unit */
+	unsigned int priority;   /* Priority (0 for default value) */
+	unsigned int i;          /* Frame type (1 = UIH, 2 = UI) */
+	unsigned int k;          /* Window size (0 for default value) */
+	unsigned int restart;    /* Force DLCI channel reset? */
+	unsigned int unused[7];  /* Padding for expansion without breaking stuff */
+};
+
+#define GSMIOC_GETCONF_DLCI      _IOWR('G', 5, struct gsm_dlci_config)
+#define GSMIOC_SETCONF_DLCI      _IOW('G', 6, struct gsm_dlci_config)
+
+
 #endif
-- 
2.25.1

