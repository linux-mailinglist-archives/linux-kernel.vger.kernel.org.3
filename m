Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2113248A881
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 08:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348548AbiAKHgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 02:36:18 -0500
Received: from thoth.sbs.de ([192.35.17.2]:37462 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348539AbiAKHgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 02:36:17 -0500
X-Greylist: delayed 735 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Jan 2022 02:36:16 EST
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 20B7NmpG030985
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 08:23:48 +0100
Received: from ubuntu.localdomain ([139.21.146.160])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 20B7Nl7a032292;
        Tue, 11 Jan 2022 08:23:47 +0100
From:   Daniel Starke <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 1/1] tty: n_gsm: Fix SW flow control encoding/handling
Date:   Mon, 10 Jan 2022 23:23:17 -0800
Message-Id: <20220111072317.2082-1-daniel.starke@siemens.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to 3GPP 27.010 chapter 5.2.7.3 DC1 and DC3 (SW flow control) are to
be treated according to ISO/IEC 646. That means the MSB shall be ignored.
This patch applies the needed changes to handle this correctly.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 0b96b14bbfe1..9ee0643fc9e2 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -322,6 +322,7 @@ static int addr_cnt;
 #define GSM1_ESCAPE_BITS	0x20
 #define XON			0x11
 #define XOFF			0x13
+#define ASCII_MASK		0x7F
 
 static const struct tty_port_operations gsm_port_ops;
 
@@ -521,7 +522,7 @@ static void gsm_print_packet(const char *hdr, int addr, int cr,
  *	@output: output buffer
  *	@len: length of input
  *
- *	Expand a buffer by bytestuffing it. The worst case size change
+ *	Expand a buffer by byte stuffing it. The worst case size change
  *	is doubling and the caller is responsible for handing out
  *	suitable sized buffers.
  */
@@ -531,7 +532,8 @@ static int gsm_stuff_frame(const u8 *input, u8 *output, int len)
 	int olen = 0;
 	while (len--) {
 		if (*input == GSM1_SOF || *input == GSM1_ESCAPE
-		    || *input == XON || *input == XOFF) {
+		    || (*input & ASCII_MASK) == XON
+		    || (*input & ASCII_MASK) == XOFF) {
 			*output++ = GSM1_ESCAPE;
 			*output++ = *input++ ^ GSM1_ESCAPE_BITS;
 			olen++;
-- 
2.25.1

