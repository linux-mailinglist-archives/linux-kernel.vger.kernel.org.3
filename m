Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9572585ECE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 14:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbiGaMN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 08:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbiGaMN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 08:13:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87991E0DD;
        Sun, 31 Jul 2022 05:13:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3607E5CDE6;
        Sun, 31 Jul 2022 12:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659269634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=MoD124msHPoahhducUaRZ5YhKQzBryVa1R4WnCXJGWU=;
        b=doJUrXK6Rw+53B0dIR0UXFI6ALSynukp5O0Lx0YQ/wfZCy/Wx/b+k14690eSNF3RJGsGVa
        aajaT5eyqNoc05k3ApiSesHhpZ0pXVYSUeHZqYcMW7w+kgr8xBLak0ljyXoKhNyluWn3Ao
        TF/A4m2pfFMREZVW4BwW8OROhAimWFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659269634;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=MoD124msHPoahhducUaRZ5YhKQzBryVa1R4WnCXJGWU=;
        b=434Z1zpyFU1XUPetPdDjaMnaGBOwrhwoAHu5zQ3cXVcmrm6O/DmmsuNPXTOo2l2vQPFPke
        upX+fSsn29uhTEAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E8CDF13416;
        Sun, 31 Jul 2022 12:13:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id K/55NgFy5mJQVgAAMHmgww
        (envelope-from <jdelvare@suse.de>); Sun, 31 Jul 2022 12:13:53 +0000
Date:   Sun, 31 Jul 2022 14:13:52 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Cc:     Talel Shenhar <talel@amazon.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] thermal: Drop obsolete dependency on COMPILE_TEST
Message-ID: <20220731141352.7caa1a69@endymion.delvare>
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
Cc: Talel Shenhar <talel@amazon.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-5.18.orig/drivers/thermal/Kconfig	2022-05-22 21:52:31.000000000 +0200
+++ linux-5.18/drivers/thermal/Kconfig	2022-07-31 13:51:55.009394318 +0200
@@ -221,7 +221,7 @@ config THERMAL_EMULATION
 
 config THERMAL_MMIO
 	tristate "Generic Thermal MMIO driver"
-	depends on OF || COMPILE_TEST
+	depends on OF
 	depends on HAS_IOMEM
 	help
 	  This option enables the generic thermal MMIO driver that will use
@@ -496,7 +496,7 @@ config SPRD_THERMAL
 
 config KHADAS_MCU_FAN_THERMAL
 	tristate "Khadas MCU controller FAN cooling support"
-	depends on OF || COMPILE_TEST
+	depends on OF
 	depends on MFD_KHADAS_MCU
 	select MFD_CORE
 	select REGMAP

-- 
Jean Delvare
SUSE L3 Support
