Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3621A4C2A97
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbiBXLLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiBXLLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:11:10 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B664251E76;
        Thu, 24 Feb 2022 03:10:30 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 20C601F37F;
        Thu, 24 Feb 2022 11:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645701029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=pnTd8/D0+vuGbUPMnE7NdXcE0J73CB8cyYdF/RwxZDM=;
        b=0kHboYJqp7HUnyDHvsYt676BFqFu4t4yqxg/hJtzNeOWZLpr6UMxzZhf4tuJ5G4IITMv40
        kTmLrr1g+3ZWK8nkwUI2NxaOtpsOjWaGP8qYpLg7rXz79s0d3Jl5vIdSzHMQmAhRHz/DW2
        fCxEuO4aqyiisO5NTNso/R4pmv93LXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645701029;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=pnTd8/D0+vuGbUPMnE7NdXcE0J73CB8cyYdF/RwxZDM=;
        b=4szQIPFdRLyM6l3A6Uo5BlNafD5iWdncH7+/+yMOWx5CJEqnT9zjamEiQDc0VY28lCHU3o
        KQ/39+dirrQLEHBw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EBABBA3BAC;
        Thu, 24 Feb 2022 11:10:28 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 0/5] tty: serial: various cleanups
Date:   Thu, 24 Feb 2022 12:10:23 +0100
Message-Id: <20220224111028.20917-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a small cleanup series of what I have accumulated over past few
weeks while doing larger changes.

Jiri Slaby (5):
  tty: serial: mpc52xx_uart: make rx/tx hooks return unsigned
  tty: serial: serial_txx9: remove info print from init
  tty: serial: serial_txx9: remove struct uart_txx9_port
  tty: serial: amba-pl010: use more uart_port pointers
  tty: serial: lpc32xx_hs: use serial_lpc32xx_stop_tx() helper

 drivers/tty/serial/amba-pl010.c   | 174 +++++++-------
 drivers/tty/serial/lpc32xx_hs.c   |  10 +-
 drivers/tty/serial/mpc52xx_uart.c |  22 +-
 drivers/tty/serial/serial_txx9.c  | 369 ++++++++++++++----------------
 4 files changed, 266 insertions(+), 309 deletions(-)

-- 
2.35.1

