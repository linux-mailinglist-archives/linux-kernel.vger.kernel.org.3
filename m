Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF54589B53
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 14:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239584AbiHDL7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 07:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239562AbiHDL7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 07:59:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C977745F6C;
        Thu,  4 Aug 2022 04:59:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4AB1820D15;
        Thu,  4 Aug 2022 11:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659614379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=EUCS7g/zgoM7nhHrg1a17fSw/MKdtZCCwVWMf7qRsAc=;
        b=warjybyVgrYrMdXWqixrvgR9ppCn3cIpgd8v8HwN7LXFbZGRIY8weVG4bLIZGaK+1K3Gon
        kbmOcgZShqDMni5ZDJmORkjCgmF6asIrU7xlHyh3al2ZqSNtdMBexMhncIQ00O9GwH0N14
        Tg2w33If7y5ZsBrMSGhuf2jVau/VOc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659614379;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=EUCS7g/zgoM7nhHrg1a17fSw/MKdtZCCwVWMf7qRsAc=;
        b=UEvkDTqVuOZL858W4cHq7ic1Ql23IRE8Fr66+KT/SfzoffnMD5ZbjcWZRxft/9SRGObIrD
        1DI/+yXe+vfIqvCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 105E513434;
        Thu,  4 Aug 2022 11:59:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7W+yAau062JbNQAAMHmgww
        (envelope-from <jdelvare@suse.de>); Thu, 04 Aug 2022 11:59:39 +0000
Date:   Thu, 4 Aug 2022 13:59:38 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Cc:     Talel Shenhar <talel@amazon.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] thermal/drivers/thermal_mmio: Drop of_match_ptr()
Message-ID: <20220804135938.7f69f5d9@endymion.delvare>
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

From: Jean Delvare <jdelvare@suse.de>
Subject: thermal/drivers/thermal_mmio: Drop of_match_ptr()

Now that the driver depends on OF, we know what of_match_ptr() will
always resolve to, so we might as well save cpp some work.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Talel Shenhar <talel@amazon.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
---
This could have been folded into my previous patch, sorry for missing
it.

 drivers/thermal/thermal_mmio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-5.18.orig/drivers/thermal/thermal_mmio.c	2022-05-22 21:52:31.000000000 +0200
+++ linux-5.18/drivers/thermal/thermal_mmio.c	2022-08-04 13:50:46.426178245 +0200
@@ -107,7 +107,7 @@ static struct platform_driver thermal_mm
 	.probe = thermal_mmio_probe,
 	.driver = {
 		.name = "thermal-mmio",
-		.of_match_table = of_match_ptr(thermal_mmio_id_table),
+		.of_match_table = thermal_mmio_id_table,
 	},
 };
 


-- 
Jean Delvare
SUSE L3 Support
