Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285A64AB014
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 15:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243323AbiBFO6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 09:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiBFO6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 09:58:12 -0500
X-Greylist: delayed 122 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 06:58:11 PST
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DAEAC06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 06:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644159489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uX4lWbiYHZ8NWu80q7dFh0qDvrig4tAryOtejA4ht4k=;
        b=MwcsX7qbWuA5E4Ge8VKwogfXOntpALErFYYZACuUknLdB08io3q2IBGzYDhA8kbzrvmbVu
        6uaJvmsblqi6ZfIznX5uh5pbHjewf9vWv6f/hCdzXbmih89SxIaF7BeHzfMQ3F4RvzPy++
        PjkoFeGy5cQxeBIphzmECeokvb0uD8M=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-524-cpdp-dCkNS6Ulb49BFnjMA-1; Sun, 06 Feb 2022 09:58:08 -0500
X-MC-Unique: cpdp-dCkNS6Ulb49BFnjMA-1
Received: by mail-qt1-f200.google.com with SMTP id j30-20020ac84c9e000000b002cf986622d1so9121275qtv.6
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 06:58:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uX4lWbiYHZ8NWu80q7dFh0qDvrig4tAryOtejA4ht4k=;
        b=xpeE48eUkr+jgItLmyJnIqn+1RsDl087lyUnv/DfT4xYVc/3Eq4SfABYCVTBZh1u9C
         POZ1yabOp78OQBtT2v515HBObQ+XlzqDxknyB/SORX8EzoUkyx6OiCLtw76bQWxSHkOA
         gh6c38t0DXAL9gR01Mg2xXz7IvgvwdVTchzjGeSdLyQjne/0amA1FfxqWtnzh4PsEtFh
         RFNH0DpBLUzWqeUULZqqtZDAmP0jAJZlMJ7Uij1Q9G6tKrBd7aWGGmvjRiIHg1i/cLye
         No1I/DRZd9SaMiJGZLdmAxR6lm3kmqn6iVY/GUrPuV5HTRIHiDOze1vzGkT0BjMLGXgk
         jf1Q==
X-Gm-Message-State: AOAM533jLsMF9NCd96c0GxU5vpskUAq8Jjfl+1GFeNkYN2HT2v49TweV
        zUgMVMHT73JsLGIgXRR8N4a9NVKodoxG4aZbW4rbJ7m0dv4DMTbMmZ1zWu8LY0BOGY1KcRDDtip
        xuOiMrHar/Yp2MBCgOk/mkhEz
X-Received: by 2002:a05:620a:210d:: with SMTP id l13mr4202086qkl.276.1644159488353;
        Sun, 06 Feb 2022 06:58:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyzMMFTsVYuA3WsMa5aAtZSa2Zi+YOirEF8uFgzKhOcPAqZ1RB6Xj6uxrY4Qwi7RDDYG5p59A==
X-Received: by 2002:a05:620a:210d:: with SMTP id l13mr4202080qkl.276.1644159488194;
        Sun, 06 Feb 2022 06:58:08 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id l202sm4030030qke.66.2022.02.06.06.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 06:58:07 -0800 (PST)
From:   trix@redhat.com
To:     rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] ACPI: cleanup double word in comment
Date:   Sun,  6 Feb 2022 06:58:03 -0800
Message-Id: <20220206145803.2011247-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Remove the second 'on' and 'those'.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/acpi/Kconfig    | 2 +-
 drivers/acpi/pci_link.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ba45541b1f1f8..9b93d8f328d4a 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -301,7 +301,7 @@ config ACPI_IPMI
 	help
 	  This driver enables the ACPI to access the BMC controller. And it
 	  uses the IPMI request/response message to communicate with BMC
-	  controller, which can be found on on the server.
+	  controller, which can be found on the server.
 
 	  To compile this driver as a module, choose M here:
 	  the module will be called as acpi_ipmi.
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index d54fb8e54671d..58647051c948a 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -185,7 +185,7 @@ static acpi_status acpi_pci_link_check_current(struct acpi_resource *resource,
 			if (!p || !p->interrupt_count) {
 				/*
 				 * IRQ descriptors may have no IRQ# bits set,
-				 * particularly those those w/ _STA disabled
+				 * particularly those w/ _STA disabled
 				 */
 				pr_debug("Blank _CRS IRQ resource\n");
 				return AE_OK;
-- 
2.26.3

