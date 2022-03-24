Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9014E5F4F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348520AbiCXH13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbiCXH11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:27:27 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EFA986F4;
        Thu, 24 Mar 2022 00:25:56 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id r13so7327601ejd.5;
        Thu, 24 Mar 2022 00:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XVilrVPHAzNXojXt+GjJOL6H62xOPCwBdLhdn2DWXIM=;
        b=otovnpD5nrCVnZOsLSqe8I1OIJRwaeI6Wprpx5/aY+tLRP2xckrtLUD/siXLU0Txf3
         21HyGWc+9cV2Rn0XxJyTxE6UL5SEDgTZw98y9gKL3wnDu0AEcS/eFNTmcJm4p2Y8Bfg9
         QTEjKShf9Y8EAQ/C9rEPAfjempmv8JNNth7q8lGJ6Vr2y90i4WZVXozSuNiDgHBgcd7U
         ZjfRmpiI6Ou7+clTpm9JLqeDfSaHFj4Eev5TNir7uoSlHyP0sxtAG35Kuy+WV0TsirBo
         0XCSnJKarnaRYK/EGYD4aYAaWI1Hx+7q/SleHBCKJHXoL+NxnOez9BUQc2A4WYp4otFp
         UM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XVilrVPHAzNXojXt+GjJOL6H62xOPCwBdLhdn2DWXIM=;
        b=jfzqnxW9w4TZhkya9vuopczhWxzMhx4XRtO7Cb7Gi/ZsDR5QWcRZbO+3XtPczBrqal
         KJbw1kHdCQrtRgFD7qv8HdThMsYJkDMI1v45B+OmdvyKLButgG2CTw8FHBubRX3RQ1o4
         WE2Dg0VAXT4HO37G1ASAvJVBBkN6Af7d2P91ttPTjK+Otu+NrPVmVOw1xWGU8rwbCPre
         Ng6zWd5TyD5yhJrA8EdBDPs/AEeo0gyJ4hzrYqxiPrQYIkYhGux9BCf4RbALXWkiv6X9
         vrH+cTe7u4klWYrw1XWEJAtHGtO8RsfmE8SPCIYI3vqcZbmsk73qWje0buwmDgqrZsJc
         UVCQ==
X-Gm-Message-State: AOAM531M3XDF/QkWmEeauynp2NfFLA1jjgaoyjgxr+DMWkvXLODsUX6s
        EIeO1bVemxEFAjh4mpZZ0XA=
X-Google-Smtp-Source: ABdhPJzRiymZM6GpooNPxU4tvHwmcChIBJjf+hQ5ofKWj78Tx4y6dAWhErrocnZuydc4KL0kfbKuNg==
X-Received: by 2002:a17:907:8a25:b0:6d7:d59:6912 with SMTP id sc37-20020a1709078a2500b006d70d596912mr4275772ejc.259.1648106754763;
        Thu, 24 Mar 2022 00:25:54 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id hg11-20020a1709072ccb00b006cee4fb36c7sm770476ejc.64.2022.03.24.00.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 00:25:54 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH] spi: spidev: replace usage of found with dedicated list iterator variable
Date:   Thu, 24 Mar 2022 08:25:34 +0100
Message-Id: <20220324072534.63420-1-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable instead of a
found boolean [1].

This removes the need to use a found variable and simply checking if
the variable was set, can determine if the break/goto was hit.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/spi/spidev.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index a5cceca8b82b..2c5e685826ad 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -561,19 +561,20 @@ spidev_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 static int spidev_open(struct inode *inode, struct file *filp)
 {
-	struct spidev_data	*spidev;
+	struct spidev_data	*spidev = NULL, *iter;
 	int			status = -ENXIO;
 
 	mutex_lock(&device_list_lock);
 
-	list_for_each_entry(spidev, &device_list, device_entry) {
-		if (spidev->devt == inode->i_rdev) {
+	list_for_each_entry(iter, &device_list, device_entry) {
+		if (iter->devt == inode->i_rdev) {
 			status = 0;
+			spidev = iter;
 			break;
 		}
 	}
 
-	if (status) {
+	if (!spidev) {
 		pr_debug("spidev: nothing for minor %d\n", iminor(inode));
 		goto err_find_dev;
 	}

base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
2.25.1

