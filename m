Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBCE509B6E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387132AbiDUJB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387062AbiDUJBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:01:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAC620F74;
        Thu, 21 Apr 2022 01:58:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DD5311F757;
        Thu, 21 Apr 2022 08:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650531490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xU8K/tdIZler/l3ib8M0Xg8/Qlkc1HwVzABB0NRT8B4=;
        b=JRN7M4iPB4KaKkvOEAIvx158MiLt/VculB0T7/GdnoKGCk6wkHZcDxKzL0jVRPfNNeGWma
        /sBVAnzkn7MG4I/7y/17a+of0Y9S8Mim0xvuLM+vLig5EXyhMsN2aLXsdSn73GGsg3/3ec
        GDzwHHj1VAKzpp2mF0pYv64FpuuIJnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650531490;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xU8K/tdIZler/l3ib8M0Xg8/Qlkc1HwVzABB0NRT8B4=;
        b=K2wh25YEP0oFUXV+fu8iEiZPRbpTASUq30i6OTQ1gIHvQSSg9vdH6L5DIdp+mNi4+VcUsA
        IrmykC+3g2jeHFAQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id ACB8E2C145;
        Thu, 21 Apr 2022 08:58:10 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 05/10] serial: icom: move header content to .c
Date:   Thu, 21 Apr 2022 10:58:03 +0200
Message-Id: <20220421085808.24152-6-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220421085808.24152-1-jslaby@suse.cz>
References: <20220421085808.24152-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point keeping the header content separated. The header was
not even protected against double inclusion. So move the content to the
appropriate source file.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/icom.c | 267 ++++++++++++++++++++++++++++++++++++-
 drivers/tty/serial/icom.h | 274 --------------------------------------
 2 files changed, 265 insertions(+), 276 deletions(-)
 delete mode 100644 drivers/tty/serial/icom.h

diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
index e1f9d42180ff..083c00aced07 100644
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -19,6 +19,7 @@
 #include <linux/fs.h>
 #include <linux/tty_flip.h>
 #include <linux/serial.h>
+#include <linux/serial_core.h>
 #include <linux/serial_reg.h>
 #include <linux/major.h>
 #include <linux/string.h>
@@ -41,13 +42,275 @@
 #include <asm/irq.h>
 #include <linux/uaccess.h>
 
-#include "icom.h"
-
 /*#define ICOM_TRACE		 enable port trace capabilities */
 
 #define ICOM_DRIVER_NAME "icom"
 #define NR_PORTS	       128
 
+#define BAUD_TABLE_LIMIT	((sizeof(icom_acfg_baud)/sizeof(int)) - 1)
+static int icom_acfg_baud[] = {
+	300,
+	600,
+	900,
+	1200,
+	1800,
+	2400,
+	3600,
+	4800,
+	7200,
+	9600,
+	14400,
+	19200,
+	28800,
+	38400,
+	57600,
+	76800,
+	115200,
+	153600,
+	230400,
+	307200,
+	460800,
+};
+
+struct icom_regs {
+	u32 control;		/* Adapter Control Register     */
+	u32 interrupt;		/* Adapter Interrupt Register   */
+	u32 int_mask;		/* Adapter Interrupt Mask Reg   */
+	u32 int_pri;		/* Adapter Interrupt Priority r */
+	u32 int_reg_b;		/* Adapter non-masked Interrupt */
+	u32 resvd01;
+	u32 resvd02;
+	u32 resvd03;
+	u32 control_2;		/* Adapter Control Register 2   */
+	u32 interrupt_2;	/* Adapter Interrupt Register 2 */
+	u32 int_mask_2;		/* Adapter Interrupt Mask 2     */
+	u32 int_pri_2;		/* Adapter Interrupt Prior 2    */
+	u32 int_reg_2b;		/* Adapter non-masked 2         */
+};
+
+struct func_dram {
+	u32 reserved[108];	/* 0-1B0   reserved by personality code */
+	u32 RcvStatusAddr;	/* 1B0-1B3 Status Address for Next rcv */
+	u8 RcvStnAddr;		/* 1B4     Receive Station Addr */
+	u8 IdleState;		/* 1B5     Idle State */
+	u8 IdleMonitor;		/* 1B6     Idle Monitor */
+	u8 FlagFillIdleTimer;	/* 1B7     Flag Fill Idle Timer */
+	u32 XmitStatusAddr;	/* 1B8-1BB Transmit Status Address */
+	u8 StartXmitCmd;	/* 1BC     Start Xmit Command */
+	u8 HDLCConfigReg;	/* 1BD     Reserved */
+	u8 CauseCode;		/* 1BE     Cause code for fatal error */
+	u8 xchar;		/* 1BF     High priority send */
+	u32 reserved3;		/* 1C0-1C3 Reserved */
+	u8 PrevCmdReg;		/* 1C4     Reserved */
+	u8 CmdReg;		/* 1C5     Command Register */
+	u8 async_config2;	/* 1C6     Async Config Byte 2 */
+	u8 async_config3;	/* 1C7     Async Config Byte 3 */
+	u8 dce_resvd[20];	/* 1C8-1DB DCE Rsvd           */
+	u8 dce_resvd21;		/* 1DC     DCE Rsvd (21st byte */
+	u8 misc_flags;		/* 1DD     misc flags         */
+#define V2_HARDWARE     0x40
+#define ICOM_HDW_ACTIVE 0x01
+	u8 call_length;		/* 1DE     Phone #/CFI buff ln */
+	u8 call_length2;	/* 1DF     Upper byte (unused) */
+	u32 call_addr;		/* 1E0-1E3 Phn #/CFI buff addr */
+	u16 timer_value;	/* 1E4-1E5 general timer value */
+	u8 timer_command;	/* 1E6     general timer cmd  */
+	u8 dce_command;		/* 1E7     dce command reg    */
+	u8 dce_cmd_status;	/* 1E8     dce command stat   */
+	u8 x21_r1_ioff;		/* 1E9     dce ready counter  */
+	u8 x21_r0_ioff;		/* 1EA     dce not ready ctr  */
+	u8 x21_ralt_ioff;	/* 1EB     dce CNR counter    */
+	u8 x21_r1_ion;		/* 1EC     dce ready I on ctr */
+	u8 rsvd_ier;		/* 1ED     Rsvd for IER (if ne */
+	u8 ier;			/* 1EE     Interrupt Enable   */
+	u8 isr;			/* 1EF     Input Signal Reg   */
+	u8 osr;			/* 1F0     Output Signal Reg  */
+	u8 reset;		/* 1F1     Reset/Reload Reg   */
+	u8 disable;		/* 1F2     Disable Reg        */
+	u8 sync;		/* 1F3     Sync Reg           */
+	u8 error_stat;		/* 1F4     Error Status       */
+	u8 cable_id;		/* 1F5     Cable ID           */
+	u8 cs_length;		/* 1F6     CS Load Length     */
+	u8 mac_length;		/* 1F7     Mac Load Length    */
+	u32 cs_load_addr;	/* 1F8-1FB Call Load PCI Addr */
+	u32 mac_load_addr;	/* 1FC-1FF Mac Load PCI Addr  */
+};
+
+/*
+ * adapter defines and structures
+ */
+#define ICOM_CONTROL_START_A         0x00000008
+#define ICOM_CONTROL_STOP_A          0x00000004
+#define ICOM_CONTROL_START_B         0x00000002
+#define ICOM_CONTROL_STOP_B          0x00000001
+#define ICOM_CONTROL_START_C         0x00000008
+#define ICOM_CONTROL_STOP_C          0x00000004
+#define ICOM_CONTROL_START_D         0x00000002
+#define ICOM_CONTROL_STOP_D          0x00000001
+#define ICOM_IRAM_OFFSET             0x1000
+#define ICOM_IRAM_SIZE               0x0C00
+#define ICOM_DCE_IRAM_OFFSET         0x0A00
+#define ICOM_CABLE_ID_VALID          0x01
+#define ICOM_CABLE_ID_MASK           0xF0
+#define ICOM_DISABLE                 0x80
+#define CMD_XMIT_RCV_ENABLE          0xC0
+#define CMD_XMIT_ENABLE              0x40
+#define CMD_RCV_DISABLE              0x00
+#define CMD_RCV_ENABLE               0x80
+#define CMD_RESTART                  0x01
+#define CMD_HOLD_XMIT                0x02
+#define CMD_SND_BREAK                0x04
+#define RS232_CABLE                  0x06
+#define V24_CABLE                    0x0E
+#define V35_CABLE                    0x0C
+#define V36_CABLE                    0x02
+#define NO_CABLE                     0x00
+#define START_DOWNLOAD               0x80
+#define ICOM_INT_MASK_PRC_A          0x00003FFF
+#define ICOM_INT_MASK_PRC_B          0x3FFF0000
+#define ICOM_INT_MASK_PRC_C          0x00003FFF
+#define ICOM_INT_MASK_PRC_D          0x3FFF0000
+#define INT_RCV_COMPLETED            0x1000
+#define INT_XMIT_COMPLETED           0x2000
+#define INT_IDLE_DETECT              0x0800
+#define INT_RCV_DISABLED             0x0400
+#define INT_XMIT_DISABLED            0x0200
+#define INT_RCV_XMIT_SHUTDOWN        0x0100
+#define INT_FATAL_ERROR              0x0080
+#define INT_CABLE_PULL               0x0020
+#define INT_SIGNAL_CHANGE            0x0010
+#define HDLC_PPP_PURE_ASYNC          0x02
+#define HDLC_FF_FILL                 0x00
+#define HDLC_HDW_FLOW                0x01
+#define START_XMIT                   0x80
+#define ICOM_ACFG_DRIVE1             0x20
+#define ICOM_ACFG_NO_PARITY          0x00
+#define ICOM_ACFG_PARITY_ENAB        0x02
+#define ICOM_ACFG_PARITY_ODD         0x01
+#define ICOM_ACFG_8BPC               0x00
+#define ICOM_ACFG_7BPC               0x04
+#define ICOM_ACFG_6BPC               0x08
+#define ICOM_ACFG_5BPC               0x0C
+#define ICOM_ACFG_1STOP_BIT          0x00
+#define ICOM_ACFG_2STOP_BIT          0x10
+#define ICOM_DTR                     0x80
+#define ICOM_RTS                     0x40
+#define ICOM_RI                      0x08
+#define ICOM_DSR                     0x80
+#define ICOM_DCD                     0x20
+#define ICOM_CTS                     0x40
+
+#define NUM_XBUFFS 1
+#define NUM_RBUFFS 2
+#define RCV_BUFF_SZ 0x0200
+#define XMIT_BUFF_SZ 0x1000
+struct statusArea {
+    /**********************************************/
+	/* Transmit Status Area                       */
+    /**********************************************/
+	struct xmit_status_area{
+		__le32 leNext;	/* Next entry in Little Endian on Adapter */
+		__le32 leNextASD;
+		__le32 leBuffer;	/* Buffer for entry in LE for Adapter */
+		__le16 leLengthASD;
+		__le16 leOffsetASD;
+		__le16 leLength;	/* Length of data in segment */
+		__le16 flags;
+#define SA_FLAGS_DONE           0x0080	/* Done with Segment */
+#define SA_FLAGS_CONTINUED      0x8000	/* More Segments */
+#define SA_FLAGS_IDLE           0x4000	/* Mark IDLE after frm */
+#define SA_FLAGS_READY_TO_XMIT  0x0800
+#define SA_FLAGS_STAT_MASK      0x007F
+	} xmit[NUM_XBUFFS];
+
+    /**********************************************/
+	/* Receive Status Area                        */
+    /**********************************************/
+	struct {
+		__le32 leNext;	/* Next entry in Little Endian on Adapter */
+		__le32 leNextASD;
+		__le32 leBuffer;	/* Buffer for entry in LE for Adapter */
+		__le16 WorkingLength;	/* size of segment */
+		__le16 reserv01;
+		__le16 leLength;	/* Length of data in segment */
+		__le16 flags;
+#define SA_FL_RCV_DONE           0x0010	/* Data ready */
+#define SA_FLAGS_OVERRUN         0x0040
+#define SA_FLAGS_PARITY_ERROR    0x0080
+#define SA_FLAGS_FRAME_ERROR     0x0001
+#define SA_FLAGS_FRAME_TRUNC     0x0002
+#define SA_FLAGS_BREAK_DET       0x0004	/* set conditionally by device driver, not hardware */
+#define SA_FLAGS_RCV_MASK        0xFFE6
+	} rcv[NUM_RBUFFS];
+};
+
+struct icom_adapter;
+
+
+#define ICOM_MAJOR       243
+#define ICOM_MINOR_START 0
+
+struct icom_port {
+	struct uart_port uart_port;
+	u8 imbed_modem;
+#define ICOM_UNKNOWN		1
+#define ICOM_RVX		2
+#define ICOM_IMBED_MODEM	3
+	unsigned char cable_id;
+	unsigned char read_status_mask;
+	unsigned char ignore_status_mask;
+	void __iomem * int_reg;
+	struct icom_regs __iomem *global_reg;
+	struct func_dram __iomem *dram;
+	int port;
+	struct statusArea *statStg;
+	dma_addr_t statStg_pci;
+	__le32 *xmitRestart;
+	dma_addr_t xmitRestart_pci;
+	unsigned char *xmit_buf;
+	dma_addr_t xmit_buf_pci;
+	unsigned char *recv_buf;
+	dma_addr_t recv_buf_pci;
+	int next_rcv;
+	int put_length;
+	int status;
+#define ICOM_PORT_ACTIVE	1	/* Port exists. */
+#define ICOM_PORT_OFF		0	/* Port does not exist. */
+	int load_in_progress;
+	struct icom_adapter *adapter;
+};
+
+struct icom_adapter {
+	void __iomem * base_addr;
+	unsigned long base_addr_pci;
+	struct pci_dev *pci_dev;
+	struct icom_port port_info[4];
+	int index;
+	int version;
+#define ADAPTER_V1	0x0001
+#define ADAPTER_V2	0x0002
+	u32 subsystem_id;
+#define FOUR_PORT_MODEL				0x0252
+#define V2_TWO_PORTS_RVX			0x021A
+#define V2_ONE_PORT_RVX_ONE_PORT_IMBED_MDM	0x0251
+	int numb_ports;
+	struct list_head icom_adapter_entry;
+	struct kref kref;
+};
+
+/* prototype */
+extern void iCom_sercons_init(void);
+
+struct lookup_proc_table {
+	u32	__iomem *global_control_reg;
+	unsigned long	processor_id;
+};
+
+struct lookup_int_table {
+	u32	__iomem *global_int_mask;
+	unsigned long	processor_id;
+};
+
 static inline struct icom_port *to_icom_port(struct uart_port *port)
 {
 	return container_of(port, struct icom_port, uart_port);
diff --git a/drivers/tty/serial/icom.h b/drivers/tty/serial/icom.h
deleted file mode 100644
index 62d5ba81dcfc..000000000000
--- a/drivers/tty/serial/icom.h
+++ /dev/null
@@ -1,274 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * icom.h
- *
- * Copyright (C) 2001 Michael Anderson, IBM Corporation
- *
- * Serial device driver include file.
- */
-
-#include <linux/serial_core.h>
-
-#define BAUD_TABLE_LIMIT	((sizeof(icom_acfg_baud)/sizeof(int)) - 1)
-static int icom_acfg_baud[] = {
-	300,
-	600,
-	900,
-	1200,
-	1800,
-	2400,
-	3600,
-	4800,
-	7200,
-	9600,
-	14400,
-	19200,
-	28800,
-	38400,
-	57600,
-	76800,
-	115200,
-	153600,
-	230400,
-	307200,
-	460800,
-};
-
-struct icom_regs {
-	u32 control;		/* Adapter Control Register     */
-	u32 interrupt;		/* Adapter Interrupt Register   */
-	u32 int_mask;		/* Adapter Interrupt Mask Reg   */
-	u32 int_pri;		/* Adapter Interrupt Priority r */
-	u32 int_reg_b;		/* Adapter non-masked Interrupt */
-	u32 resvd01;
-	u32 resvd02;
-	u32 resvd03;
-	u32 control_2;		/* Adapter Control Register 2   */
-	u32 interrupt_2;	/* Adapter Interrupt Register 2 */
-	u32 int_mask_2;		/* Adapter Interrupt Mask 2     */
-	u32 int_pri_2;		/* Adapter Interrupt Prior 2    */
-	u32 int_reg_2b;		/* Adapter non-masked 2         */
-};
-
-struct func_dram {
-	u32 reserved[108];	/* 0-1B0   reserved by personality code */
-	u32 RcvStatusAddr;	/* 1B0-1B3 Status Address for Next rcv */
-	u8 RcvStnAddr;		/* 1B4     Receive Station Addr */
-	u8 IdleState;		/* 1B5     Idle State */
-	u8 IdleMonitor;		/* 1B6     Idle Monitor */
-	u8 FlagFillIdleTimer;	/* 1B7     Flag Fill Idle Timer */
-	u32 XmitStatusAddr;	/* 1B8-1BB Transmit Status Address */
-	u8 StartXmitCmd;	/* 1BC     Start Xmit Command */
-	u8 HDLCConfigReg;	/* 1BD     Reserved */
-	u8 CauseCode;		/* 1BE     Cause code for fatal error */
-	u8 xchar;		/* 1BF     High priority send */
-	u32 reserved3;		/* 1C0-1C3 Reserved */
-	u8 PrevCmdReg;		/* 1C4     Reserved */
-	u8 CmdReg;		/* 1C5     Command Register */
-	u8 async_config2;	/* 1C6     Async Config Byte 2 */
-	u8 async_config3;	/* 1C7     Async Config Byte 3 */
-	u8 dce_resvd[20];	/* 1C8-1DB DCE Rsvd           */
-	u8 dce_resvd21;		/* 1DC     DCE Rsvd (21st byte */
-	u8 misc_flags;		/* 1DD     misc flags         */
-#define V2_HARDWARE     0x40
-#define ICOM_HDW_ACTIVE 0x01
-	u8 call_length;		/* 1DE     Phone #/CFI buff ln */
-	u8 call_length2;	/* 1DF     Upper byte (unused) */
-	u32 call_addr;		/* 1E0-1E3 Phn #/CFI buff addr */
-	u16 timer_value;	/* 1E4-1E5 general timer value */
-	u8 timer_command;	/* 1E6     general timer cmd  */
-	u8 dce_command;		/* 1E7     dce command reg    */
-	u8 dce_cmd_status;	/* 1E8     dce command stat   */
-	u8 x21_r1_ioff;		/* 1E9     dce ready counter  */
-	u8 x21_r0_ioff;		/* 1EA     dce not ready ctr  */
-	u8 x21_ralt_ioff;	/* 1EB     dce CNR counter    */
-	u8 x21_r1_ion;		/* 1EC     dce ready I on ctr */
-	u8 rsvd_ier;		/* 1ED     Rsvd for IER (if ne */
-	u8 ier;			/* 1EE     Interrupt Enable   */
-	u8 isr;			/* 1EF     Input Signal Reg   */
-	u8 osr;			/* 1F0     Output Signal Reg  */
-	u8 reset;		/* 1F1     Reset/Reload Reg   */
-	u8 disable;		/* 1F2     Disable Reg        */
-	u8 sync;		/* 1F3     Sync Reg           */
-	u8 error_stat;		/* 1F4     Error Status       */
-	u8 cable_id;		/* 1F5     Cable ID           */
-	u8 cs_length;		/* 1F6     CS Load Length     */
-	u8 mac_length;		/* 1F7     Mac Load Length    */
-	u32 cs_load_addr;	/* 1F8-1FB Call Load PCI Addr */
-	u32 mac_load_addr;	/* 1FC-1FF Mac Load PCI Addr  */
-};
-
-/*
- * adapter defines and structures
- */
-#define ICOM_CONTROL_START_A         0x00000008
-#define ICOM_CONTROL_STOP_A          0x00000004
-#define ICOM_CONTROL_START_B         0x00000002
-#define ICOM_CONTROL_STOP_B          0x00000001
-#define ICOM_CONTROL_START_C         0x00000008
-#define ICOM_CONTROL_STOP_C          0x00000004
-#define ICOM_CONTROL_START_D         0x00000002
-#define ICOM_CONTROL_STOP_D          0x00000001
-#define ICOM_IRAM_OFFSET             0x1000
-#define ICOM_IRAM_SIZE               0x0C00
-#define ICOM_DCE_IRAM_OFFSET         0x0A00
-#define ICOM_CABLE_ID_VALID          0x01
-#define ICOM_CABLE_ID_MASK           0xF0
-#define ICOM_DISABLE                 0x80
-#define CMD_XMIT_RCV_ENABLE          0xC0
-#define CMD_XMIT_ENABLE              0x40
-#define CMD_RCV_DISABLE              0x00
-#define CMD_RCV_ENABLE               0x80
-#define CMD_RESTART                  0x01
-#define CMD_HOLD_XMIT                0x02
-#define CMD_SND_BREAK                0x04
-#define RS232_CABLE                  0x06
-#define V24_CABLE                    0x0E
-#define V35_CABLE                    0x0C
-#define V36_CABLE                    0x02
-#define NO_CABLE                     0x00
-#define START_DOWNLOAD               0x80
-#define ICOM_INT_MASK_PRC_A          0x00003FFF
-#define ICOM_INT_MASK_PRC_B          0x3FFF0000
-#define ICOM_INT_MASK_PRC_C          0x00003FFF
-#define ICOM_INT_MASK_PRC_D          0x3FFF0000
-#define INT_RCV_COMPLETED            0x1000
-#define INT_XMIT_COMPLETED           0x2000
-#define INT_IDLE_DETECT              0x0800
-#define INT_RCV_DISABLED             0x0400
-#define INT_XMIT_DISABLED            0x0200
-#define INT_RCV_XMIT_SHUTDOWN        0x0100
-#define INT_FATAL_ERROR              0x0080
-#define INT_CABLE_PULL               0x0020
-#define INT_SIGNAL_CHANGE            0x0010
-#define HDLC_PPP_PURE_ASYNC          0x02
-#define HDLC_FF_FILL                 0x00
-#define HDLC_HDW_FLOW                0x01
-#define START_XMIT                   0x80
-#define ICOM_ACFG_DRIVE1             0x20
-#define ICOM_ACFG_NO_PARITY          0x00
-#define ICOM_ACFG_PARITY_ENAB        0x02
-#define ICOM_ACFG_PARITY_ODD         0x01
-#define ICOM_ACFG_8BPC               0x00
-#define ICOM_ACFG_7BPC               0x04
-#define ICOM_ACFG_6BPC               0x08
-#define ICOM_ACFG_5BPC               0x0C
-#define ICOM_ACFG_1STOP_BIT          0x00
-#define ICOM_ACFG_2STOP_BIT          0x10
-#define ICOM_DTR                     0x80
-#define ICOM_RTS                     0x40
-#define ICOM_RI                      0x08
-#define ICOM_DSR                     0x80
-#define ICOM_DCD                     0x20
-#define ICOM_CTS                     0x40
-
-#define NUM_XBUFFS 1
-#define NUM_RBUFFS 2
-#define RCV_BUFF_SZ 0x0200
-#define XMIT_BUFF_SZ 0x1000
-struct statusArea {
-    /**********************************************/
-	/* Transmit Status Area                       */
-    /**********************************************/
-	struct xmit_status_area{
-		__le32 leNext;	/* Next entry in Little Endian on Adapter */
-		__le32 leNextASD;
-		__le32 leBuffer;	/* Buffer for entry in LE for Adapter */
-		__le16 leLengthASD;
-		__le16 leOffsetASD;
-		__le16 leLength;	/* Length of data in segment */
-		__le16 flags;
-#define SA_FLAGS_DONE           0x0080	/* Done with Segment */
-#define SA_FLAGS_CONTINUED      0x8000	/* More Segments */
-#define SA_FLAGS_IDLE           0x4000	/* Mark IDLE after frm */
-#define SA_FLAGS_READY_TO_XMIT  0x0800
-#define SA_FLAGS_STAT_MASK      0x007F
-	} xmit[NUM_XBUFFS];
-
-    /**********************************************/
-	/* Receive Status Area                        */
-    /**********************************************/
-	struct {
-		__le32 leNext;	/* Next entry in Little Endian on Adapter */
-		__le32 leNextASD;
-		__le32 leBuffer;	/* Buffer for entry in LE for Adapter */
-		__le16 WorkingLength;	/* size of segment */
-		__le16 reserv01;
-		__le16 leLength;	/* Length of data in segment */
-		__le16 flags;
-#define SA_FL_RCV_DONE           0x0010	/* Data ready */
-#define SA_FLAGS_OVERRUN         0x0040
-#define SA_FLAGS_PARITY_ERROR    0x0080
-#define SA_FLAGS_FRAME_ERROR     0x0001
-#define SA_FLAGS_FRAME_TRUNC     0x0002
-#define SA_FLAGS_BREAK_DET       0x0004	/* set conditionally by device driver, not hardware */
-#define SA_FLAGS_RCV_MASK        0xFFE6
-	} rcv[NUM_RBUFFS];
-};
-
-struct icom_adapter;
-
-
-#define ICOM_MAJOR       243
-#define ICOM_MINOR_START 0
-
-struct icom_port {
-	struct uart_port uart_port;
-	u8 imbed_modem;
-#define ICOM_UNKNOWN		1
-#define ICOM_RVX		2
-#define ICOM_IMBED_MODEM	3
-	unsigned char cable_id;
-	unsigned char read_status_mask;
-	unsigned char ignore_status_mask;
-	void __iomem * int_reg;
-	struct icom_regs __iomem *global_reg;
-	struct func_dram __iomem *dram;
-	int port;
-	struct statusArea *statStg;
-	dma_addr_t statStg_pci;
-	__le32 *xmitRestart;
-	dma_addr_t xmitRestart_pci;
-	unsigned char *xmit_buf;
-	dma_addr_t xmit_buf_pci;
-	unsigned char *recv_buf;
-	dma_addr_t recv_buf_pci;
-	int next_rcv;
-	int put_length;
-	int status;
-#define ICOM_PORT_ACTIVE	1	/* Port exists. */
-#define ICOM_PORT_OFF		0	/* Port does not exist. */
-	int load_in_progress;
-	struct icom_adapter *adapter;
-};
-
-struct icom_adapter {
-	void __iomem * base_addr;
-	unsigned long base_addr_pci;
-	struct pci_dev *pci_dev;
-	struct icom_port port_info[4];
-	int index;
-	int version;
-#define ADAPTER_V1	0x0001
-#define ADAPTER_V2	0x0002
-	u32 subsystem_id;
-#define FOUR_PORT_MODEL				0x0252
-#define V2_TWO_PORTS_RVX			0x021A
-#define V2_ONE_PORT_RVX_ONE_PORT_IMBED_MDM	0x0251
-	int numb_ports;
-	struct list_head icom_adapter_entry;
-	struct kref kref;
-};
-
-/* prototype */
-extern void iCom_sercons_init(void);
-
-struct lookup_proc_table {
-	u32	__iomem *global_control_reg;
-	unsigned long	processor_id;
-};
-
-struct lookup_int_table {
-	u32	__iomem *global_int_mask;
-	unsigned long	processor_id;
-};
-- 
2.36.0

