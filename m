Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1D9509D79
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388273AbiDUKUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382272AbiDUKT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:19:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD1A22525;
        Thu, 21 Apr 2022 03:17:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3A8A1215FC;
        Thu, 21 Apr 2022 10:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650536229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=3O6/BdDKv6pQlJqixzof36IiCZINQ7EleO0KCxDYz08=;
        b=Gwxs6xPNUG8N4mol49RlvyysByoXuj/4BkAmKh9CYflIQGSSlcVbekd8xvly3WOCk6KYW2
        48cyDeZqZczl09WaDcwqFyEwpvR6a1tszxs3ssCCLH0dEut90wuxG9ZY+2rxJvZEBoYFNg
        LjXfJVyaDoIZ6icbL+83D5sqssgY9KU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650536229;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=3O6/BdDKv6pQlJqixzof36IiCZINQ7EleO0KCxDYz08=;
        b=Un44p/32CI+/Gg3yw9FzYxTSWF43suEDiPCeFUmzZNq/LV2rZLdpBsPpiG8fMdTZpZcY23
        OUwe2Blot0PL0+Bg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 090082C142;
        Thu, 21 Apr 2022 10:17:09 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 0/7] serial: various cleanups
Date:   Thu, 21 Apr 2022 12:17:01 +0200
Message-Id: <20220421101708.5640-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.0
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

This is a set of simple cleanups for various drivers. All should be
straightforward.

The last two patches enable compilation on 0-day bot also for three more
drivers. So we should have a better coverage. Actually the last but one
is the result of the last one -- 0-day bot already complained to me.

Jiri Slaby (7):
  serial: sunplus-uart: mark sunplus_console_ports[] static
  serial: xilinx_uartps: return early in cdns_uart_handle_tx()
  serial: xilinx_uartps: cache xmit in cdns_uart_handle_tx()
  serial: zs: use NULL as a pointer, not 0
  serial: qcom: use check for empty instead of pending
  serial: pic32: make SERIAL_PIC32_CONSOLE depend on SERIAL_PIC32=y
  serial: allow COMPILE_TEST for some drivers

 drivers/tty/serial/Kconfig             |  8 ++---
 drivers/tty/serial/cpm_uart/cpm_uart.h |  2 ++
 drivers/tty/serial/qcom_geni_serial.c  |  2 +-
 drivers/tty/serial/sunplus-uart.c      |  2 +-
 drivers/tty/serial/xilinx_uartps.c     | 46 +++++++++-----------------
 drivers/tty/serial/zs.c                |  2 +-
 6 files changed, 25 insertions(+), 37 deletions(-)

-- 
2.36.0

