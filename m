Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E329758B259
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 00:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241817AbiHEWHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 18:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241779AbiHEWHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 18:07:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6ECB12768;
        Fri,  5 Aug 2022 15:07:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 376CD34598;
        Fri,  5 Aug 2022 22:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659737228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Sqb3DDDY6ymKLXpHg1cCPpNN3i1H+Y7M1+qegvCFOI4=;
        b=owGONwNjkyDx95TgILNkWKR92IRHXPrKWLIhdBa33xZ7TGd9cttWU2pHqMucrGfdqiwmvG
        8FSURQp08XTNUmacDqe4wD8rgn3el5kbpnWUiLnTx0ASDUtt3iIGEQdqkntaJnh3w1+s7h
        M+lL/WvbZOiC5Ioi887IJHtx8AZs5Sc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659737228;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Sqb3DDDY6ymKLXpHg1cCPpNN3i1H+Y7M1+qegvCFOI4=;
        b=n18gR4H902usgtITEMeNsF+ybYEfNiX6guWgSObTz7JeMISB3AutF5cvF615lSNyXRsJ3w
        VbSd4lIZz1b7cJDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ECB5613A9C;
        Fri,  5 Aug 2022 22:07:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RmgHOIuU7WLtUgAAMHmgww
        (envelope-from <jdelvare@suse.de>); Fri, 05 Aug 2022 22:07:07 +0000
Date:   Sat, 6 Aug 2022 00:07:06 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     linux-watchdog@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH] watchdog: wdat_wdt: Set the min and max timeout values
 properly
Message-ID: <20220806000706.3eeafc9c@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wdat_wdt driver is misusing the min_hw_heartbeat_ms field. This
field should only be used when the hardware watchdog device should not
be pinged more frequently than a specific period. The ACPI WDAT
"Minimum Count" field, on the other hand, specifies the minimum
timeout value that can be set. This corresponds to the min_timeout
field in Linux's watchdog infrastructure.

Setting min_hw_heartbeat_ms instead can cause pings to the hardware
to be delayed when there is no reason for that, eventually leading to
unexpected firing of the watchdog timer (and thus unexpected reboot).

I'm also changing max_hw_heartbeat_ms to max_timeout for symmetry,
although the use of this one isn't fundamentally wrong, but there is
also no reason to enable the software-driven ping mechanism for the
wdat_wdt driver.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Fixes: 058dfc767008 ("ACPI / watchdog: Add support for WDAT hardware watchdog")
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc! Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
Untested, as I have no supported hardware at hand.

Note to the watchdog subsystem maintainers: I must say I find the
whole thing pretty confusing.

First of all, the name symmetry between min_hw_heartbeat_ms and
max_hw_heartbeat_ms, while these properties are completely unrelated,
is heavily misleading. max_hw_heartbeat_ms is really max_hw_timeout
and should be renamed to that IMHO, if we keep it at all.

Secondly, the coexistence of max_timeout and max_hw_heartbeat_ms is
also making the code pretty hard to understand and get right.
Historically, max_timeout was already supposed to be the maximum
hardware timeout value. I don't understand why a new field with that
meaning was introduced, subsequently changing the original meaning of
max_timeout to become a software-only limit... but only if
max_hw_heartbeat_ms is set.

To be honest, I'm not sold to the idea of a software-emulated
maximum timeout value above what the hardware can do, but if doing
that makes sense in certain situations, then I believe it should be
implemented as a boolean flag (named emulate_large_timeout, for
example) to complement max_timeout instead of a separate time value.
Is there a reason I'm missing, why it was not done that way?

Currently, a comment in watchdog.h claims that max_timeout is ignored
when max_hw_heartbeat_ms is set. However in watchdog_dev.c, sysfs
attribute max_timeout is created unconditionally, and
max_hw_heartbeat_ms doesn't have a sysfs attribute. So userspace has
no way to know if max_timeout is the hardware limit, or whether
software emulation will kick in for a specified timeout value. Also,
there is no complaint if both max_hw_heartbeat_ms and max_timeout
are set.

 drivers/watchdog/wdat_wdt.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-5.18.orig/drivers/watchdog/wdat_wdt.c	2022-07-27 07:32:33.336928967 +0200
+++ linux-5.18/drivers/watchdog/wdat_wdt.c	2022-08-05 19:49:19.607793835 +0200
@@ -342,8 +342,8 @@ static int wdat_wdt_probe(struct platfor
 		return -EINVAL;
 
 	wdat->period = tbl->timer_period;
-	wdat->wdd.min_hw_heartbeat_ms = wdat->period * tbl->min_count;
-	wdat->wdd.max_hw_heartbeat_ms = wdat->period * tbl->max_count;
+	wdat->wdd.min_timeout = DIV_ROUND_UP(wdat->period * tbl->min_count, 1000);
+	wdat->wdd.max_timeout = wdat->period * tbl->max_count / 1000;
 	wdat->stopped_in_sleep = tbl->flags & ACPI_WDAT_STOPPED;
 	wdat->wdd.info = &wdat_wdt_info;
 	wdat->wdd.ops = &wdat_wdt_ops;
@@ -450,8 +450,8 @@ static int wdat_wdt_probe(struct platfor
 	 * watchdog properly after it has opened the device. In some cases
 	 * the BIOS default is too short and causes immediate reboot.
 	 */
-	if (timeout * 1000 < wdat->wdd.min_hw_heartbeat_ms ||
-	    timeout * 1000 > wdat->wdd.max_hw_heartbeat_ms) {
+	if (timeout < wdat->min_timeout ||
+	    timeout > wdat->max_timeout) {
 		dev_warn(dev, "Invalid timeout %d given, using %d\n",
 			 timeout, WDAT_DEFAULT_TIMEOUT);
 		timeout = WDAT_DEFAULT_TIMEOUT;


-- 
Jean Delvare
SUSE L3 Support
