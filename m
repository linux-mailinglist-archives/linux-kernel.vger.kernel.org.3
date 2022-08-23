Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A3159E900
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiHWRTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbiHWRSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:18:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703001175DD;
        Tue, 23 Aug 2022 06:47:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 27835336D1;
        Tue, 23 Aug 2022 13:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661262436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4fpc7DDr1cBcY0zp8LDLF5xyNGxLDQvc9n2jefed/40=;
        b=gMmMz33YhNuP4+oZY66Y1T6EiVIn8JzM1/WhcH0ryNzzYAoc7ZwsdOipjBEkgwhFJb0pA9
        2HcOVNC02ke1bTqW4asQMRCeWrvHsOpvPF1DTd+r80/zSQfdqamA7mQYP9UHBTJplifamL
        ehSoEQn2Niv6E7Dhuwdnj0m6sC4wnjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661262436;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4fpc7DDr1cBcY0zp8LDLF5xyNGxLDQvc9n2jefed/40=;
        b=NEhfsqR3We1uxi6BxQn6ghoeGPC14lmwm9Jo8Rn1QmEKt9J9SdZmRf+H+BiEF7IbpJC5jP
        Bgh/jIWF83VTOtAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF00A13A89;
        Tue, 23 Aug 2022 13:47:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 03mGNGPaBGPrbQAAMHmgww
        (envelope-from <jdelvare@suse.de>); Tue, 23 Aug 2022 13:47:15 +0000
Date:   Tue, 23 Aug 2022 15:47:13 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     linux-watchdog@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Liu Xinpeng <liuxp11@chinatelecom.cn>
Subject: [PATCH v3] watchdog: wdat_wdt: Set the min and max timeout values
 properly
Message-ID: <20220823154713.023ee771@endymion.delvare>
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

Since commit 6d72c7ac9fbe ("watchdog: wdat_wdt: Using the existing
function to check parameter timeout"), min_timeout is being set too,
but to the arbitrary value of 1 second, which doesn't make sense and
allows setting timeout values lower that the ACPI WDAT "Minimum
Count" field.

I'm also changing max_hw_heartbeat_ms to max_timeout for symmetry,
although the use of this one isn't fundamentally wrong, but there is
also no reason to enable the software-driven ping mechanism for the
wdat_wdt driver.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Fixes: 058dfc767008 ("ACPI / watchdog: Add support for WDAT hardware watchdog")
Fixes: 6d72c7ac9fbe ("watchdog: wdat_wdt: Using the existing function to check parameter timeout")
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Liu Xinpeng <liuxp11@chinatelecom.cn>
---
Changes since v2:
 * Rebased on top of v5.19.
Changes since v1:
 * Fix a stupid typo which broke the build.

Mika, Guenter, I chose to preserve your respective Reviewed-by tags, as
the end result is essentially similar to the previous iteration of the
patch. Feel free to complain if you disagree.

 drivers/watchdog/wdat_wdt.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- linux-5.19.orig/drivers/watchdog/wdat_wdt.c	2022-07-31 23:03:01.000000000 +0200
+++ linux-5.19/drivers/watchdog/wdat_wdt.c	2022-08-23 15:01:12.106398116 +0200
@@ -342,9 +342,8 @@ static int wdat_wdt_probe(struct platfor
 		return -EINVAL;
 
 	wdat->period = tbl->timer_period;
-	wdat->wdd.min_hw_heartbeat_ms = wdat->period * tbl->min_count;
-	wdat->wdd.max_hw_heartbeat_ms = wdat->period * tbl->max_count;
-	wdat->wdd.min_timeout = 1;
+	wdat->wdd.min_timeout = DIV_ROUND_UP(wdat->period * tbl->min_count, 1000);
+	wdat->wdd.max_timeout = wdat->period * tbl->max_count / 1000;
 	wdat->stopped_in_sleep = tbl->flags & ACPI_WDAT_STOPPED;
 	wdat->wdd.info = &wdat_wdt_info;
 	wdat->wdd.ops = &wdat_wdt_ops;

-- 
Jean Delvare
SUSE L3 Support
