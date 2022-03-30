Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4FA4EC7CE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347870AbiC3PIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347899AbiC3PId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:08:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 841649D0C1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:06:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42A0F1477;
        Wed, 30 Mar 2022 08:06:43 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE8A03F73B;
        Wed, 30 Mar 2022 08:06:41 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH 09/22] firmware: arm_scmi: Split protocol specific definitions in a dedicated header
Date:   Wed, 30 Mar 2022 16:05:38 +0100
Message-Id: <20220330150551.2573938-10-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220330150551.2573938-1-cristian.marussi@arm.com>
References: <20220330150551.2573938-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move some SCMI protocol specific definitions from common.h into a the new
dedicated protocols.h header so that SCMI protocols core code can include
only what it needs; this is going to be useful to avoid the risk of growing
indefinitely the dimension of common.h, especially when introducing some
common protocols helper functions.

Header common.h will continue to be included by SCMI core and transport
layers.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/clock.c     |   4 +-
 drivers/firmware/arm_scmi/common.h    | 224 +----------------------
 drivers/firmware/arm_scmi/perf.c      |   6 +-
 drivers/firmware/arm_scmi/power.c     |   4 +-
 drivers/firmware/arm_scmi/protocols.h | 247 ++++++++++++++++++++++++++
 drivers/firmware/arm_scmi/reset.c     |   4 +-
 drivers/firmware/arm_scmi/sensors.c   |   4 +-
 drivers/firmware/arm_scmi/system.c    |   4 +-
 drivers/firmware/arm_scmi/voltage.c   |   4 +-
 9 files changed, 265 insertions(+), 236 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/protocols.h

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 7adf99b92bf6..d78339dc2fdc 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -2,13 +2,13 @@
 /*
  * System Control and Management Interface (SCMI) Clock Protocol
  *
- * Copyright (C) 2018-2021 ARM Ltd.
+ * Copyright (C) 2018-2022 ARM Ltd.
  */
 
 #include <linux/module.h>
 #include <linux/sort.h>
 
-#include "common.h"
+#include "protocols.h"
 
 enum scmi_clock_protocol_cmd {
 	CLOCK_ATTRIBUTES = 0x3,
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 6885348a505d..61aba7447c32 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -4,7 +4,7 @@
  * driver common header file containing some definitions, structures
  * and function prototypes used in all the different SCMI protocols.
  *
- * Copyright (C) 2018-2021 ARM Ltd.
+ * Copyright (C) 2018-2022 ARM Ltd.
  */
 #ifndef _SCMI_COMMON_H
 #define _SCMI_COMMON_H
@@ -24,37 +24,9 @@
 
 #include <asm/unaligned.h>
 
+#include "protocols.h"
 #include "notify.h"
 
-#define PROTOCOL_REV_MINOR_MASK	GENMASK(15, 0)
-#define PROTOCOL_REV_MAJOR_MASK	GENMASK(31, 16)
-#define PROTOCOL_REV_MAJOR(x)	(u16)(FIELD_GET(PROTOCOL_REV_MAJOR_MASK, (x)))
-#define PROTOCOL_REV_MINOR(x)	(u16)(FIELD_GET(PROTOCOL_REV_MINOR_MASK, (x)))
-#define MAX_OPPS		16
-
-enum scmi_common_cmd {
-	PROTOCOL_VERSION = 0x0,
-	PROTOCOL_ATTRIBUTES = 0x1,
-	PROTOCOL_MESSAGE_ATTRIBUTES = 0x2,
-};
-
-/**
- * struct scmi_msg_resp_prot_version - Response for a message
- *
- * @minor_version: Minor version of the ABI that firmware supports
- * @major_version: Major version of the ABI that firmware supports
- *
- * In general, ABI version changes follow the rule that minor version increments
- * are backward compatible. Major revision changes in ABI may not be
- * backward compatible.
- *
- * Response to a generic message with message type SCMI_MSG_VERSION
- */
-struct scmi_msg_resp_prot_version {
-	__le16 minor_version;
-	__le16 major_version;
-};
-
 #define MSG_ID_MASK		GENMASK(7, 0)
 #define MSG_XTRACT_ID(hdr)	FIELD_GET(MSG_ID_MASK, (hdr))
 #define MSG_TYPE_MASK		GENMASK(9, 8)
@@ -78,28 +50,6 @@ struct scmi_msg_resp_prot_version {
  */
 #define SCMI_PENDING_XFERS_HT_ORDER_SZ		9
 
-/**
- * struct scmi_msg_hdr - Message(Tx/Rx) header
- *
- * @id: The identifier of the message being sent
- * @protocol_id: The identifier of the protocol used to send @id message
- * @type: The SCMI type for this message
- * @seq: The token to identify the message. When a message returns, the
- *	platform returns the whole message header unmodified including the
- *	token
- * @status: Status of the transfer once it's complete
- * @poll_completion: Indicate if the transfer needs to be polled for
- *	completion or interrupt mode is used
- */
-struct scmi_msg_hdr {
-	u8 id;
-	u8 protocol_id;
-	u8 type;
-	u16 seq;
-	u32 status;
-	bool poll_completion;
-};
-
 /**
  * pack_scmi_header() - packs and returns 32-bit header
  *
@@ -129,72 +79,6 @@ static inline void unpack_scmi_header(u32 msg_hdr, struct scmi_msg_hdr *hdr)
 	hdr->type = MSG_XTRACT_TYPE(msg_hdr);
 }
 
-/**
- * struct scmi_msg - Message(Tx/Rx) structure
- *
- * @buf: Buffer pointer
- * @len: Length of data in the Buffer
- */
-struct scmi_msg {
-	void *buf;
-	size_t len;
-};
-
-/**
- * struct scmi_xfer - Structure representing a message flow
- *
- * @transfer_id: Unique ID for debug & profiling purpose
- * @hdr: Transmit message header
- * @tx: Transmit message
- * @rx: Receive message, the buffer should be pre-allocated to store
- *	message. If request-ACK protocol is used, we can reuse the same
- *	buffer for the rx path as we use for the tx path.
- * @done: command message transmit completion event
- * @async_done: pointer to delayed response message received event completion
- * @pending: True for xfers added to @pending_xfers hashtable
- * @node: An hlist_node reference used to store this xfer, alternatively, on
- *	  the free list @free_xfers or in the @pending_xfers hashtable
- * @users: A refcount to track the active users for this xfer.
- *	   This is meant to protect against the possibility that, when a command
- *	   transaction times out concurrently with the reception of a valid
- *	   response message, the xfer could be finally put on the TX path, and
- *	   so vanish, while on the RX path scmi_rx_callback() is still
- *	   processing it: in such a case this refcounting will ensure that, even
- *	   though the timed-out transaction will anyway cause the command
- *	   request to be reported as failed by time-out, the underlying xfer
- *	   cannot be discarded and possibly reused until the last one user on
- *	   the RX path has released it.
- * @busy: An atomic flag to ensure exclusive write access to this xfer
- * @state: The current state of this transfer, with states transitions deemed
- *	   valid being:
- *	    - SCMI_XFER_SENT_OK -> SCMI_XFER_RESP_OK [ -> SCMI_XFER_DRESP_OK ]
- *	    - SCMI_XFER_SENT_OK -> SCMI_XFER_DRESP_OK
- *	      (Missing synchronous response is assumed OK and ignored)
- * @lock: A spinlock to protect state and busy fields.
- * @priv: A pointer for transport private usage.
- */
-struct scmi_xfer {
-	int transfer_id;
-	struct scmi_msg_hdr hdr;
-	struct scmi_msg tx;
-	struct scmi_msg rx;
-	struct completion done;
-	struct completion *async_done;
-	bool pending;
-	struct hlist_node node;
-	refcount_t users;
-#define SCMI_XFER_FREE		0
-#define SCMI_XFER_BUSY		1
-	atomic_t busy;
-#define SCMI_XFER_SENT_OK	0
-#define SCMI_XFER_RESP_OK	1
-#define SCMI_XFER_DRESP_OK	2
-	int state;
-	/* A lock to protect state and busy fields */
-	spinlock_t lock;
-	void *priv;
-};
-
 /*
  * An helper macro to lookup an xfer from the @pending_xfers hashtable
  * using the message sequence number token as a key.
@@ -210,64 +94,6 @@ struct scmi_xfer {
 	xfer_;							\
 })
 
-struct scmi_xfer_ops;
-
-/**
- * struct scmi_protocol_handle  - Reference to an initialized protocol instance
- *
- * @dev: A reference to the associated SCMI instance device (handle->dev).
- * @xops: A reference to a struct holding refs to the core xfer operations that
- *	  can be used by the protocol implementation to generate SCMI messages.
- * @set_priv: A method to set protocol private data for this instance.
- * @get_priv: A method to get protocol private data previously set.
- *
- * This structure represents a protocol initialized against specific SCMI
- * instance and it will be used as follows:
- * - as a parameter fed from the core to the protocol initialization code so
- *   that it can access the core xfer operations to build and generate SCMI
- *   messages exclusively for the specific underlying protocol instance.
- * - as an opaque handle fed by an SCMI driver user when it tries to access
- *   this protocol through its own protocol operations.
- *   In this case this handle will be returned as an opaque object together
- *   with the related protocol operations when the SCMI driver tries to access
- *   the protocol.
- */
-struct scmi_protocol_handle {
-	struct device *dev;
-	const struct scmi_xfer_ops *xops;
-	int (*set_priv)(const struct scmi_protocol_handle *ph, void *priv);
-	void *(*get_priv)(const struct scmi_protocol_handle *ph);
-};
-
-/**
- * struct scmi_xfer_ops  - References to the core SCMI xfer operations.
- * @version_get: Get this version protocol.
- * @xfer_get_init: Initialize one struct xfer if any xfer slot is free.
- * @reset_rx_to_maxsz: Reset rx size to max transport size.
- * @do_xfer: Do the SCMI transfer.
- * @do_xfer_with_response: Do the SCMI transfer waiting for a response.
- * @xfer_put: Free the xfer slot.
- *
- * Note that all this operations expect a protocol handle as first parameter;
- * they then internally use it to infer the underlying protocol number: this
- * way is not possible for a protocol implementation to forge messages for
- * another protocol.
- */
-struct scmi_xfer_ops {
-	int (*version_get)(const struct scmi_protocol_handle *ph, u32 *version);
-	int (*xfer_get_init)(const struct scmi_protocol_handle *ph, u8 msg_id,
-			     size_t tx_size, size_t rx_size,
-			     struct scmi_xfer **p);
-	void (*reset_rx_to_maxsz)(const struct scmi_protocol_handle *ph,
-				  struct scmi_xfer *xfer);
-	int (*do_xfer)(const struct scmi_protocol_handle *ph,
-		       struct scmi_xfer *xfer);
-	int (*do_xfer_with_response)(const struct scmi_protocol_handle *ph,
-				     struct scmi_xfer *xfer);
-	void (*xfer_put)(const struct scmi_protocol_handle *ph,
-			 struct scmi_xfer *xfer);
-};
-
 struct scmi_revision_info *
 scmi_revision_area_get(const struct scmi_protocol_handle *ph);
 int scmi_handle_put(const struct scmi_handle *handle);
@@ -276,55 +102,9 @@ void scmi_set_handle(struct scmi_device *scmi_dev);
 void scmi_setup_protocol_implemented(const struct scmi_protocol_handle *ph,
 				     u8 *prot_imp);
 
-typedef int (*scmi_prot_init_ph_fn_t)(const struct scmi_protocol_handle *);
-
-/**
- * struct scmi_protocol  - Protocol descriptor
- * @id: Protocol ID.
- * @owner: Module reference if any.
- * @instance_init: Mandatory protocol initialization function.
- * @instance_deinit: Optional protocol de-initialization function.
- * @ops: Optional reference to the operations provided by the protocol and
- *	 exposed in scmi_protocol.h.
- * @events: An optional reference to the events supported by this protocol.
- */
-struct scmi_protocol {
-	const u8				id;
-	struct module				*owner;
-	const scmi_prot_init_ph_fn_t		instance_init;
-	const scmi_prot_init_ph_fn_t		instance_deinit;
-	const void				*ops;
-	const struct scmi_protocol_events	*events;
-};
-
 int __init scmi_bus_init(void);
 void __exit scmi_bus_exit(void);
 
-#define DECLARE_SCMI_REGISTER_UNREGISTER(func)		\
-	int __init scmi_##func##_register(void);	\
-	void __exit scmi_##func##_unregister(void)
-DECLARE_SCMI_REGISTER_UNREGISTER(base);
-DECLARE_SCMI_REGISTER_UNREGISTER(clock);
-DECLARE_SCMI_REGISTER_UNREGISTER(perf);
-DECLARE_SCMI_REGISTER_UNREGISTER(power);
-DECLARE_SCMI_REGISTER_UNREGISTER(reset);
-DECLARE_SCMI_REGISTER_UNREGISTER(sensors);
-DECLARE_SCMI_REGISTER_UNREGISTER(voltage);
-DECLARE_SCMI_REGISTER_UNREGISTER(system);
-
-#define DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(name, proto)	\
-static const struct scmi_protocol *__this_proto = &(proto);	\
-								\
-int __init scmi_##name##_register(void)				\
-{								\
-	return scmi_protocol_register(__this_proto);		\
-}								\
-								\
-void __exit scmi_##name##_unregister(void)			\
-{								\
-	scmi_protocol_unregister(__this_proto);			\
-}
-
 const struct scmi_protocol *scmi_protocol_get(int protocol_id);
 void scmi_protocol_put(int protocol_id);
 
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index e9f68b91580c..0e9703310758 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -2,7 +2,7 @@
 /*
  * System Control and Management Interface (SCMI) Performance Protocol
  *
- * Copyright (C) 2018-2021 ARM Ltd.
+ * Copyright (C) 2018-2022 ARM Ltd.
  */
 
 #define pr_fmt(fmt) "SCMI Notifications PERF - " fmt
@@ -17,9 +17,11 @@
 #include <linux/scmi_protocol.h>
 #include <linux/sort.h>
 
-#include "common.h"
+#include "protocols.h"
 #include "notify.h"
 
+#define MAX_OPPS		16
+
 enum scmi_performance_protocol_cmd {
 	PERF_DOMAIN_ATTRIBUTES = 0x3,
 	PERF_DESCRIBE_LEVELS = 0x4,
diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
index 5c04d63e7ff1..e378a3eb0d07 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -2,7 +2,7 @@
 /*
  * System Control and Management Interface (SCMI) Power Protocol
  *
- * Copyright (C) 2018-2021 ARM Ltd.
+ * Copyright (C) 2018-2022 ARM Ltd.
  */
 
 #define pr_fmt(fmt) "SCMI Notifications POWER - " fmt
@@ -10,7 +10,7 @@
 #include <linux/module.h>
 #include <linux/scmi_protocol.h>
 
-#include "common.h"
+#include "protocols.h"
 #include "notify.h"
 
 enum scmi_power_protocol_cmd {
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
new file mode 100644
index 000000000000..b2a92d2b2986
--- /dev/null
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -0,0 +1,247 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * System Control and Management Interface (SCMI) Message Protocol
+ * protocols common header file containing some definitions, structures
+ * and function prototypes used in all the different SCMI protocols.
+ *
+ * Copyright (C) 2022 ARM Ltd.
+ */
+#ifndef _SCMI_PROTOCOLS_H
+#define _SCMI_PROTOCOLS_H
+
+#include <linux/bitfield.h>
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/hashtable.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/refcount.h>
+#include <linux/scmi_protocol.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include <asm/unaligned.h>
+
+#define PROTOCOL_REV_MINOR_MASK	GENMASK(15, 0)
+#define PROTOCOL_REV_MAJOR_MASK	GENMASK(31, 16)
+#define PROTOCOL_REV_MAJOR(x)	((u16)(FIELD_GET(PROTOCOL_REV_MAJOR_MASK, (x))))
+#define PROTOCOL_REV_MINOR(x)	((u16)(FIELD_GET(PROTOCOL_REV_MINOR_MASK, (x))))
+
+enum scmi_common_cmd {
+	PROTOCOL_VERSION = 0x0,
+	PROTOCOL_ATTRIBUTES = 0x1,
+	PROTOCOL_MESSAGE_ATTRIBUTES = 0x2,
+};
+
+/**
+ * struct scmi_msg_resp_prot_version - Response for a message
+ *
+ * @minor_version: Minor version of the ABI that firmware supports
+ * @major_version: Major version of the ABI that firmware supports
+ *
+ * In general, ABI version changes follow the rule that minor version increments
+ * are backward compatible. Major revision changes in ABI may not be
+ * backward compatible.
+ *
+ * Response to a generic message with message type SCMI_MSG_VERSION
+ */
+struct scmi_msg_resp_prot_version {
+	__le16 minor_version;
+	__le16 major_version;
+};
+
+/**
+ * struct scmi_msg - Message(Tx/Rx) structure
+ *
+ * @buf: Buffer pointer
+ * @len: Length of data in the Buffer
+ */
+struct scmi_msg {
+	void *buf;
+	size_t len;
+};
+
+/**
+ * struct scmi_msg_hdr - Message(Tx/Rx) header
+ *
+ * @id: The identifier of the message being sent
+ * @protocol_id: The identifier of the protocol used to send @id message
+ * @type: The SCMI type for this message
+ * @seq: The token to identify the message. When a message returns, the
+ *	platform returns the whole message header unmodified including the
+ *	token
+ * @status: Status of the transfer once it's complete
+ * @poll_completion: Indicate if the transfer needs to be polled for
+ *	completion or interrupt mode is used
+ */
+struct scmi_msg_hdr {
+	u8 id;
+	u8 protocol_id;
+	u8 type;
+	u16 seq;
+	u32 status;
+	bool poll_completion;
+};
+
+/**
+ * struct scmi_xfer - Structure representing a message flow
+ *
+ * @transfer_id: Unique ID for debug & profiling purpose
+ * @hdr: Transmit message header
+ * @tx: Transmit message
+ * @rx: Receive message, the buffer should be pre-allocated to store
+ *	message. If request-ACK protocol is used, we can reuse the same
+ *	buffer for the rx path as we use for the tx path.
+ * @done: command message transmit completion event
+ * @async_done: pointer to delayed response message received event completion
+ * @pending: True for xfers added to @pending_xfers hashtable
+ * @node: An hlist_node reference used to store this xfer, alternatively, on
+ *	  the free list @free_xfers or in the @pending_xfers hashtable
+ * @users: A refcount to track the active users for this xfer.
+ *	   This is meant to protect against the possibility that, when a command
+ *	   transaction times out concurrently with the reception of a valid
+ *	   response message, the xfer could be finally put on the TX path, and
+ *	   so vanish, while on the RX path scmi_rx_callback() is still
+ *	   processing it: in such a case this refcounting will ensure that, even
+ *	   though the timed-out transaction will anyway cause the command
+ *	   request to be reported as failed by time-out, the underlying xfer
+ *	   cannot be discarded and possibly reused until the last one user on
+ *	   the RX path has released it.
+ * @busy: An atomic flag to ensure exclusive write access to this xfer
+ * @state: The current state of this transfer, with states transitions deemed
+ *	   valid being:
+ *	    - SCMI_XFER_SENT_OK -> SCMI_XFER_RESP_OK [ -> SCMI_XFER_DRESP_OK ]
+ *	    - SCMI_XFER_SENT_OK -> SCMI_XFER_DRESP_OK
+ *	      (Missing synchronous response is assumed OK and ignored)
+ * @lock: A spinlock to protect state and busy fields.
+ * @priv: A pointer for transport private usage.
+ */
+struct scmi_xfer {
+	int transfer_id;
+	struct scmi_msg_hdr hdr;
+	struct scmi_msg tx;
+	struct scmi_msg rx;
+	struct completion done;
+	struct completion *async_done;
+	bool pending;
+	struct hlist_node node;
+	refcount_t users;
+#define SCMI_XFER_FREE		0
+#define SCMI_XFER_BUSY		1
+	atomic_t busy;
+#define SCMI_XFER_SENT_OK	0
+#define SCMI_XFER_RESP_OK	1
+#define SCMI_XFER_DRESP_OK	2
+	int state;
+	/* A lock to protect state and busy fields */
+	spinlock_t lock;
+	void *priv;
+};
+
+struct scmi_xfer_ops;
+
+/**
+ * struct scmi_protocol_handle  - Reference to an initialized protocol instance
+ *
+ * @dev: A reference to the associated SCMI instance device (handle->dev).
+ * @xops: A reference to a struct holding refs to the core xfer operations that
+ *	  can be used by the protocol implementation to generate SCMI messages.
+ * @set_priv: A method to set protocol private data for this instance.
+ * @get_priv: A method to get protocol private data previously set.
+ *
+ * This structure represents a protocol initialized against specific SCMI
+ * instance and it will be used as follows:
+ * - as a parameter fed from the core to the protocol initialization code so
+ *   that it can access the core xfer operations to build and generate SCMI
+ *   messages exclusively for the specific underlying protocol instance.
+ * - as an opaque handle fed by an SCMI driver user when it tries to access
+ *   this protocol through its own protocol operations.
+ *   In this case this handle will be returned as an opaque object together
+ *   with the related protocol operations when the SCMI driver tries to access
+ *   the protocol.
+ */
+struct scmi_protocol_handle {
+	struct device *dev;
+	const struct scmi_xfer_ops *xops;
+	int (*set_priv)(const struct scmi_protocol_handle *ph, void *priv);
+	void *(*get_priv)(const struct scmi_protocol_handle *ph);
+};
+
+/**
+ * struct scmi_xfer_ops  - References to the core SCMI xfer operations.
+ * @version_get: Get this version protocol.
+ * @xfer_get_init: Initialize one struct xfer if any xfer slot is free.
+ * @reset_rx_to_maxsz: Reset rx size to max transport size.
+ * @do_xfer: Do the SCMI transfer.
+ * @do_xfer_with_response: Do the SCMI transfer waiting for a response.
+ * @xfer_put: Free the xfer slot.
+ *
+ * Note that all this operations expect a protocol handle as first parameter;
+ * they then internally use it to infer the underlying protocol number: this
+ * way is not possible for a protocol implementation to forge messages for
+ * another protocol.
+ */
+struct scmi_xfer_ops {
+	int (*version_get)(const struct scmi_protocol_handle *ph, u32 *version);
+	int (*xfer_get_init)(const struct scmi_protocol_handle *ph, u8 msg_id,
+			     size_t tx_size, size_t rx_size,
+			     struct scmi_xfer **p);
+	void (*reset_rx_to_maxsz)(const struct scmi_protocol_handle *ph,
+				  struct scmi_xfer *xfer);
+	int (*do_xfer)(const struct scmi_protocol_handle *ph,
+		       struct scmi_xfer *xfer);
+	int (*do_xfer_with_response)(const struct scmi_protocol_handle *ph,
+				     struct scmi_xfer *xfer);
+	void (*xfer_put)(const struct scmi_protocol_handle *ph,
+			 struct scmi_xfer *xfer);
+};
+
+typedef int (*scmi_prot_init_ph_fn_t)(const struct scmi_protocol_handle *);
+
+/**
+ * struct scmi_protocol  - Protocol descriptor
+ * @id: Protocol ID.
+ * @owner: Module reference if any.
+ * @instance_init: Mandatory protocol initialization function.
+ * @instance_deinit: Optional protocol de-initialization function.
+ * @ops: Optional reference to the operations provided by the protocol and
+ *	 exposed in scmi_protocol.h.
+ * @events: An optional reference to the events supported by this protocol.
+ */
+struct scmi_protocol {
+	const u8				id;
+	struct module				*owner;
+	const scmi_prot_init_ph_fn_t		instance_init;
+	const scmi_prot_init_ph_fn_t		instance_deinit;
+	const void				*ops;
+	const struct scmi_protocol_events	*events;
+};
+
+#define DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(name, proto)	\
+static const struct scmi_protocol *__this_proto = &(proto);	\
+								\
+int __init scmi_##name##_register(void)				\
+{								\
+	return scmi_protocol_register(__this_proto);		\
+}								\
+								\
+void __exit scmi_##name##_unregister(void)			\
+{								\
+	scmi_protocol_unregister(__this_proto);			\
+}
+
+#define DECLARE_SCMI_REGISTER_UNREGISTER(func)		\
+	int __init scmi_##func##_register(void);	\
+	void __exit scmi_##func##_unregister(void)
+DECLARE_SCMI_REGISTER_UNREGISTER(base);
+DECLARE_SCMI_REGISTER_UNREGISTER(clock);
+DECLARE_SCMI_REGISTER_UNREGISTER(perf);
+DECLARE_SCMI_REGISTER_UNREGISTER(power);
+DECLARE_SCMI_REGISTER_UNREGISTER(reset);
+DECLARE_SCMI_REGISTER_UNREGISTER(sensors);
+DECLARE_SCMI_REGISTER_UNREGISTER(voltage);
+DECLARE_SCMI_REGISTER_UNREGISTER(system);
+
+#endif /* _SCMI_PROTOCOLS_H */
diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
index b823a9f64af9..cc465632aa1a 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -2,7 +2,7 @@
 /*
  * System Control and Management Interface (SCMI) Reset Protocol
  *
- * Copyright (C) 2019-2021 ARM Ltd.
+ * Copyright (C) 2019-2022 ARM Ltd.
  */
 
 #define pr_fmt(fmt) "SCMI Notifications RESET - " fmt
@@ -10,7 +10,7 @@
 #include <linux/module.h>
 #include <linux/scmi_protocol.h>
 
-#include "common.h"
+#include "protocols.h"
 #include "notify.h"
 
 enum scmi_reset_protocol_cmd {
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index f37ac9824a87..07c28e249f0c 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -2,7 +2,7 @@
 /*
  * System Control and Management Interface (SCMI) Sensor Protocol
  *
- * Copyright (C) 2018-2021 ARM Ltd.
+ * Copyright (C) 2018-2022 ARM Ltd.
  */
 
 #define pr_fmt(fmt) "SCMI Notifications SENSOR - " fmt
@@ -11,7 +11,7 @@
 #include <linux/module.h>
 #include <linux/scmi_protocol.h>
 
-#include "common.h"
+#include "protocols.h"
 #include "notify.h"
 
 #define SCMI_MAX_NUM_SENSOR_AXIS	63
diff --git a/drivers/firmware/arm_scmi/system.c b/drivers/firmware/arm_scmi/system.c
index cbfc19f7a463..220e399118ad 100644
--- a/drivers/firmware/arm_scmi/system.c
+++ b/drivers/firmware/arm_scmi/system.c
@@ -2,7 +2,7 @@
 /*
  * System Control and Management Interface (SCMI) System Power Protocol
  *
- * Copyright (C) 2020-2021 ARM Ltd.
+ * Copyright (C) 2020-2022 ARM Ltd.
  */
 
 #define pr_fmt(fmt) "SCMI Notifications SYSTEM - " fmt
@@ -10,7 +10,7 @@
 #include <linux/module.h>
 #include <linux/scmi_protocol.h>
 
-#include "common.h"
+#include "protocols.h"
 #include "notify.h"
 
 #define SCMI_SYSTEM_NUM_SOURCES		1
diff --git a/drivers/firmware/arm_scmi/voltage.c b/drivers/firmware/arm_scmi/voltage.c
index ac08e819088b..7aa887a7cbd2 100644
--- a/drivers/firmware/arm_scmi/voltage.c
+++ b/drivers/firmware/arm_scmi/voltage.c
@@ -2,13 +2,13 @@
 /*
  * System Control and Management Interface (SCMI) Voltage Protocol
  *
- * Copyright (C) 2020-2021 ARM Ltd.
+ * Copyright (C) 2020-2022 ARM Ltd.
  */
 
 #include <linux/module.h>
 #include <linux/scmi_protocol.h>
 
-#include "common.h"
+#include "protocols.h"
 
 #define VOLTAGE_DOMS_NUM_MASK		GENMASK(15, 0)
 #define REMAINING_LEVELS_MASK		GENMASK(31, 16)
-- 
2.32.0

