Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775B25A10BD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241921AbiHYMkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237774AbiHYMkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:40:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D271A048;
        Thu, 25 Aug 2022 05:40:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1A8EE205A8;
        Thu, 25 Aug 2022 12:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661431215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=m+esSZFT3CEpb8V0GtG2lZxTFRI8y+pv8iwD+6oOC0k=;
        b=SzS2wPQnUpq1EfUDLBdJXaxyVByWNEL3P1e8Ho8MsIn5+TUU5nx3QVAsZfNnxyUs8+6vw8
        RatvXC3SXtggIjxd0TbnyZwOY5AqMb/P0ATr6td69/LFbutQJNf6eOT4WzDniyXA+Ow3Dt
        ooxnqg7s8/ZGxnPGWOIwmXwNxwCIyu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661431215;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=m+esSZFT3CEpb8V0GtG2lZxTFRI8y+pv8iwD+6oOC0k=;
        b=gxj3GYdh/sSww5BnxypS2QS+58hnAZ1r2LH5Z5lhC/rqrblZJDubWLdVCvy7DXLjVVLQ9V
        8adjIUiNk9XFniCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D470913A8E;
        Thu, 25 Aug 2022 12:40:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aa5SMq5tB2OjGgAAMHmgww
        (envelope-from <jdelvare@suse.de>); Thu, 25 Aug 2022 12:40:14 +0000
Date:   Thu, 25 Aug 2022 14:40:12 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     linux-iio@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio:accel:dmard06: Optimize when CONFIG_OF isn't set
Message-ID: <20220825144012.24a33bb0@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_OF isn't set, we can optimize out dmard06_of_match as it
will never be used.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/accel/dmard06.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-5.19.orig/drivers/iio/accel/dmard06.c	2022-08-25 14:19:11.742351430 +0200
+++ linux-5.19/drivers/iio/accel/dmard06.c	2022-08-25 14:20:13.505276596 +0200
@@ -209,7 +209,7 @@ static const struct i2c_device_id dmard0
 };
 MODULE_DEVICE_TABLE(i2c, dmard06_id);
 
-static const struct of_device_id dmard06_of_match[] = {
+static const struct of_device_id __maybe_unused dmard06_of_match[] = {
 	{ .compatible = "domintech,dmard05" },
 	{ .compatible = "domintech,dmard06" },
 	{ .compatible = "domintech,dmard07" },
@@ -222,7 +222,7 @@ static struct i2c_driver dmard06_driver
 	.id_table = dmard06_id,
 	.driver = {
 		.name = DMARD06_DRV_NAME,
-		.of_match_table = dmard06_of_match,
+		.of_match_table = of_match_ptr(dmard06_of_match),
 		.pm = pm_sleep_ptr(&dmard06_pm_ops),
 	},
 };


-- 
Jean Delvare
SUSE L3 Support
