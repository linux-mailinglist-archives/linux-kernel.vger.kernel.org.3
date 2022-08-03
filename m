Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5F758932C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 22:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238655AbiHCU16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 16:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238644AbiHCU1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 16:27:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAB05A3EB
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 13:27:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 93D36203BD;
        Wed,  3 Aug 2022 20:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659558470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=sJi/riKS48wXie/3JJxXDigk9Rt5HETijre2XnpC50U=;
        b=gbR2JVnw/jy67GwtEK0/tSdUYNV1eXG57H4FKvDvgW9+ZBpCA7Ir6kFviitc/1f0NrYuLX
        QHfmnt41a3ZaQJ09J5qlxYwno1Y9kLjKcmSBOV4PpEpdACoO9MUWqx67PiYbX0CIyskfgQ
        KE3iLSkdRi1nMnyGMqJcx4s5/jx1mGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659558470;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=sJi/riKS48wXie/3JJxXDigk9Rt5HETijre2XnpC50U=;
        b=nm9HEYtlie2Fr4o3q0voqR8WZET3jm3+hMzt0l6PJfO4l1GQQzdLuP2o4dYJTz4/PnCOnG
        tTuhl9ZAKuUxywCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F07113A94;
        Wed,  3 Aug 2022 20:27:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XTy4FEba6mKDLAAAMHmgww
        (envelope-from <jdelvare@suse.de>); Wed, 03 Aug 2022 20:27:50 +0000
Date:   Wed, 3 Aug 2022 22:27:49 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] clocksource/drivers/timer-microchip-pit64b: Drop obsolete
 dependency on COMPILE_TEST
Message-ID: <20220803222749.24d71d5c@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
is possible to test-build any driver which depends on OF on any
architecture by explicitly selecting OF. Therefore depending on
COMPILE_TEST as an alternative is no longer needed.

It is actually better to always build such drivers with OF enabled,
so that the test builds are closer to how each driver will actually be
built on its intended target. Building them without OF may not test
much as the compiler will optimize out potentially large parts of the
code. In the worst case, this could even pop false positive warnings.
Dropping COMPILE_TEST here improves the quality of our testing and
avoids wasting time on non-existent issues.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/clocksource/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-5.18.orig/drivers/clocksource/Kconfig	2022-07-27 07:32:33.178926986 +0200
+++ linux-5.18/drivers/clocksource/Kconfig	2022-08-03 22:21:01.044733852 +0200
@@ -703,7 +703,7 @@ config INGENIC_OST
 
 config MICROCHIP_PIT64B
 	bool "Microchip PIT64B support"
-	depends on OF || COMPILE_TEST
+	depends on OF
 	select TIMER_OF
 	help
 	  This option enables Microchip PIT64B timer for Atmel


-- 
Jean Delvare
SUSE L3 Support
