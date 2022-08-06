Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57ED158B40B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 08:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241693AbiHFGPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 02:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241522AbiHFGPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 02:15:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4ADB876;
        Fri,  5 Aug 2022 23:15:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AD30C22DAA;
        Sat,  6 Aug 2022 06:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659766525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6LdsyvuXMMZOLuygs1F92G2+lRCOO62r6mwZEfdkrTo=;
        b=pu3VbbdlryDl5EeEMYkwJS4IKZPG3Ozb0Wq/V3VgyL5FLU0veWsnHM9fKjOrGqIDeae7JJ
        emBxNPKntZ3ZIBJ9I0Zk7ngWaqyrJpXuCAcdSp2SapoS6155cLJc+OFRVB0DybquufloyA
        dcG8AAoHT3ra+Ks6N6dacqAZBrcmrKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659766525;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6LdsyvuXMMZOLuygs1F92G2+lRCOO62r6mwZEfdkrTo=;
        b=+kSryS+BLiGHuA7lxqDgBP0MfepawUrBu6c0l64YSuRWxz7hUL6tbUyqIExdqaMPwRWfRZ
        xsKknj3n6+Gx1iCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7383613ADE;
        Sat,  6 Aug 2022 06:15:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id F+FYGv0G7mKmSgAAMHmgww
        (envelope-from <jdelvare@suse.de>); Sat, 06 Aug 2022 06:15:25 +0000
Date:   Sat, 6 Aug 2022 08:15:24 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     linux-watchdog@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v2] watchdog: wdat_wdt: Set the min and max timeout values
 properly
Message-ID: <20220806081524.5636461a@endymion.delvare>
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
Reviewed-by! Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
Changes since v1:
 * Fix a stupid typo which broke the build. Apparently I shouldn't be
   sending out patches after midnight, sorry.

 drivers/watchdog/wdat_wdt.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-5.18.orig/drivers/watchdog/wdat_wdt.c	2022-07-27 07:32:33.336928967 +0200
+++ linux-5.18/drivers/watchdog/wdat_wdt.c	2022-08-06 08:09:49.235935543 +0200
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
+	if (timeout < wdat->wdd.min_timeout ||
+	    timeout > wdat->wdd.max_timeout) {
 		dev_warn(dev, "Invalid timeout %d given, using %d\n",
 			 timeout, WDAT_DEFAULT_TIMEOUT);
 		timeout = WDAT_DEFAULT_TIMEOUT;


-- 
Jean Delvare
SUSE L3 Support
