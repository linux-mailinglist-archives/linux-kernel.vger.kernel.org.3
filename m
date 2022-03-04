Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DEF4CCB3E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 02:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbiCDBT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 20:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiCDBTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 20:19:24 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AC148339
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 17:18:38 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id n185so5378815qke.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 17:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kCz7tdNd810BtQuwOagID7j3a4qH5A8d3WC+MOMxf8g=;
        b=gO3mu0vlUG+/q+BXTrTUVnHMOW6PyrlSP74c5KApxr6ll1BUMPiqlO9LfHcYmA+tzd
         2O+7FsDo3rvY2O8D2Aof1eB+kNFp6FEhIjH6HIcXnTnSVJxP5rbMLPV9nWOLRUL3a7CM
         T9nU62Yr/ATK3qOIHbzKj86tcyv0JqVvNY9XV1zDajXZK4xMYN8ErIfBw4LtzuXiOfN+
         oU0W2c97oL58f1098xgu0oZy5PHKDt/RAOGv5BSSmE5fkdgRqa98FSLjrkcmjG4Z+3cI
         jSWpFHPJ4S6DYiPm5diNr/S1itpxth8c4e+W6+j/lHaUBe5/pmAvROW0VC3c9cnDMAaX
         xJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kCz7tdNd810BtQuwOagID7j3a4qH5A8d3WC+MOMxf8g=;
        b=gFKgvRswu9K6MqmprAxWd4qEaYOlhS9OXCsEWFalMb9nqteSkVAqev5yW2X0Kbaemp
         upHl1JAbVqadG8mWmbXa0NH3E96CTRdYOJsXg5W4zWhQ+koALSDfPi7ZD/HAO3CNQmDz
         x+SdCjTuxCkElhgcyQyKlBLA3fOo+xq7fmHnqOXpAMLRw2dCeJ/ENjnNJElQO2/a/IVV
         AScscKenf6gvEu4Fx7bYEYW6gLlFlfosyKhixnOLs9ZhqIOdCXpQRByjDbwH43H9qFrJ
         motCMmjG6l325WMaE3wwitm+PcV1rTomIy38HHgP0dBM/pXt2wfpOFnv2/IjmoeuuLxp
         W/CQ==
X-Gm-Message-State: AOAM532bVGm0oNRKrXmN10t3SgGmDZmzTZ8b6JVSvZff1AMfv9eZQLqS
        rFRNdaJMywpkvCAGHSHBKK4=
X-Google-Smtp-Source: ABdhPJz+QHLirnaj+pJTbyAjKqkGMRdpdFUjenGyXIeea9bupu2mAYV8nK5O8UaFoKrNGssmafrWZg==
X-Received: by 2002:a05:620a:103b:b0:649:8109:cc11 with SMTP id a27-20020a05620a103b00b006498109cc11mr1192626qkk.567.1646356717419;
        Thu, 03 Mar 2022 17:18:37 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h17-20020ac85e11000000b002ddd5fab777sm2662093qtx.41.2022.03.03.17.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 17:18:37 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org, maz@kernel.org,
        tglx@linutronix.de, jgg@ziepe.ca, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] powerpc/sysdev: Use of_device_get_match_data()
Date:   Fri,  4 Mar 2022 01:18:30 +0000
Message-Id: <20220304011830.2061591-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>

Use of_device_get_match_data() to simplify the code.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
---
 arch/powerpc/sysdev/fsl_msi.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index b3475ae9f236..9d135bbb30b7 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -387,7 +387,6 @@ static int fsl_msi_setup_hwirq(struct fsl_msi *msi, struct platform_device *dev,
 static const struct of_device_id fsl_of_msi_ids[];
 static int fsl_of_msi_probe(struct platform_device *dev)
 {
-	const struct of_device_id *match;
 	struct fsl_msi *msi;
 	struct resource res, msiir;
 	int err, i, j, irq_index, count;
@@ -397,10 +396,7 @@ static int fsl_of_msi_probe(struct platform_device *dev)
 	u32 offset;
 	struct pci_controller *phb;
 
-	match = of_match_device(fsl_of_msi_ids, &dev->dev);
-	if (!match)
-		return -EINVAL;
-	features = match->data;
+	features = of_device_get_match_data(&dev->dev);
 
 	printk(KERN_DEBUG "Setting up Freescale MSI support\n");
 
-- 
2.25.1

