Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD44959846A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245235AbiHRNk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244844AbiHRNjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:39:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808E65B054;
        Thu, 18 Aug 2022 06:39:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE10C616C1;
        Thu, 18 Aug 2022 13:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01D1C43151;
        Thu, 18 Aug 2022 13:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660829947;
        bh=9XS4hip4BrJAqy/9+ozgOsQC/UqbifDwKLRcpBNPQ1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lrYCoYBkRRODPD2MY7dTOBdzdN7m+zOQtiq2/wO0k3s+x4KWqoAdBHaipmR82MsRf
         WlEYDV9BFKeOxvFG3zgeikNtkkSJA7t/NBJv4x3S6hTpasuXWG7bcvI/+jpR3+S33g
         N9j1FCps9TTpdgBTqV/SPjxVnFYFcoEzCXiKHuMTSuH5QFMM+TGoJAuI9cEZmDdf3t
         SI63gua6n9kQwZ9YqM7WliTsImB6dYT+LCkODXblvhM4xzCxKiU5QZYkkApefckWMl
         TSwvrmPlT0G0B0XH1iK7rIONsOuAzTi7HcyupdAhtrQhmzQ2LXQLBUi2W5lsRIc4SD
         qNHtpv2P/gQLw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oOfjl-00AY7x-L7;
        Thu, 18 Aug 2022 15:39:05 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>, corbet@lwn.net
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] serial: document start_rx member at struct uart_ops
Date:   Thu, 18 Aug 2022 15:38:58 +0200
Message-Id: <5d07ae2eec8fbad87e623160f9926b178bef2744.1660829433.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1660829433.git.mchehab@kernel.org>
References: <cover.1660829433.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix this doc build warning:
	./include/linux/serial_core.h:397: warning: Function parameter or member 'start_rx' not described in 'uart_ops'

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH 00/13] at: https://lore.kernel.org/all/cover.1660829433.git.mchehab@kernel.org/

 include/linux/serial_core.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index aef3145f2032..6e4f4765d209 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -141,6 +141,14 @@ struct gpio_desc;
  *	Locking: none.
  *	Interrupts: caller dependent.
  *
+ * @start_rx: ``void ()(struct uart_port *port)``
+ *
+ *	Start receiving characters.
+ *
+ *	Locking: @port->lock taken.
+ *	Interrupts: locally disabled.
+ *	This call must not sleep
+ *
  * @stop_rx: ``void ()(struct uart_port *port)``
  *
  *	Stop receiving characters; the @port is in the process of being closed.
-- 
2.37.1

