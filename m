Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2074D509B97
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387144AbiDUJBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387064AbiDUJBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:01:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C6221248;
        Thu, 21 Apr 2022 01:58:13 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 39E38212CA;
        Thu, 21 Apr 2022 08:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650531492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aCVuSWmdJcT0qsHrLl/HQ/xnZ+4OVTDDHOXy1yDRIyw=;
        b=eGuZm4DngR1Y6cKZRBDMMR4iSQm29zB1KC9VE65ajS+H1IVCdPmIVCAaRau77clJ0i3VR/
        kySKBiqhB65x92DcqSbKm8QTJ0XA2RVxH+TIwJ/splOo7BnQa45tlRwZVAJedzzOhgRFS/
        wM66pZhDcIDFm8H0EqrjZ/KuwPm5jfk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650531492;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aCVuSWmdJcT0qsHrLl/HQ/xnZ+4OVTDDHOXy1yDRIyw=;
        b=wtqWh50xiFPYH77mfVbJvf0zfVIyeNs+iB2pjNANjyLngg/CxnxNNQQup6165JnBlfsG5B
        +GM35fjb3Bok+rBw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 11D892C141;
        Thu, 21 Apr 2022 08:58:12 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 10/10] serial: icom: remove unused struct icom_port members
Date:   Thu, 21 Apr 2022 10:58:08 +0200
Message-Id: <20220421085808.24152-11-jslaby@suse.cz>
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

Some members of struct icom_port are completely unused or only set and
never read. Remove all those.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/icom.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
index e22f37a41764..45df29947fe8 100644
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -252,10 +252,6 @@ struct icom_adapter;
 
 struct icom_port {
 	struct uart_port uart_port;
-	u8 imbed_modem;
-#define ICOM_UNKNOWN		1
-#define ICOM_RVX		2
-#define ICOM_IMBED_MODEM	3
 	unsigned char cable_id;
 	unsigned char read_status_mask;
 	unsigned char ignore_status_mask;
@@ -272,11 +268,9 @@ struct icom_port {
 	unsigned char *recv_buf;
 	dma_addr_t recv_buf_pci;
 	int next_rcv;
-	int put_length;
 	int status;
 #define ICOM_PORT_ACTIVE	1	/* Port exists. */
 #define ICOM_PORT_OFF		0	/* Port does not exist. */
-	int load_in_progress;
 	struct icom_adapter *adapter;
 };
 
@@ -1517,7 +1511,6 @@ static void icom_set_termios(struct uart_port *port,
 	writel(icom_port->statStg_pci + offset,
 	       &icom_port->dram->RcvStatusAddr);
 	icom_port->next_rcv = 0;
-	icom_port->put_length = 0;
 	*icom_port->xmitRestart = 0;
 	writel(icom_port->xmitRestart_pci,
 	       &icom_port->dram->XmitStatusAddr);
@@ -1578,7 +1571,6 @@ static int icom_init_ports(struct icom_adapter *icom_adapter)
 			icom_port = &icom_adapter->port_info[i];
 			icom_port->port = i;
 			icom_port->status = ICOM_PORT_ACTIVE;
-			icom_port->imbed_modem = ICOM_UNKNOWN;
 		}
 	} else {
 		if (subsystem_id == PCI_DEVICE_ID_IBM_ICOM_FOUR_PORT_MODEL) {
@@ -1589,26 +1581,15 @@ static int icom_init_ports(struct icom_adapter *icom_adapter)
 
 				icom_port->port = i;
 				icom_port->status = ICOM_PORT_ACTIVE;
-				icom_port->imbed_modem = ICOM_IMBED_MODEM;
 			}
 		} else {
 			icom_adapter->numb_ports = 4;
 
 			icom_adapter->port_info[0].port = 0;
 			icom_adapter->port_info[0].status = ICOM_PORT_ACTIVE;
-
-			if (subsystem_id ==
-			    PCI_DEVICE_ID_IBM_ICOM_V2_ONE_PORT_RVX_ONE_PORT_MDM) {
-				icom_adapter->port_info[0].imbed_modem = ICOM_IMBED_MODEM;
-			} else {
-				icom_adapter->port_info[0].imbed_modem = ICOM_RVX;
-			}
-
 			icom_adapter->port_info[1].status = ICOM_PORT_OFF;
-
 			icom_adapter->port_info[2].port = 2;
 			icom_adapter->port_info[2].status = ICOM_PORT_ACTIVE;
-			icom_adapter->port_info[2].imbed_modem = ICOM_RVX;
 			icom_adapter->port_info[3].status = ICOM_PORT_OFF;
 		}
 	}
-- 
2.36.0

