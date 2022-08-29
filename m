Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273585A414F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 05:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiH2DIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 23:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiH2DIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 23:08:22 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9837B3F1D8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 20:08:16 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id e28so5290061qts.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 20:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fusetak.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=XFPVDLt22Mf+eywEhtbrRGQZP+BqmzTLYoHmyhTVdSw=;
        b=fcbB/iInZapQUJ2oYudpXbpXZpEX3NIzrhQSi0gN5gKzpw6P/juoLEESyKTdrZ5d8d
         /YDB/uh3pG+lKkCmMcb+js/fZaWQxXk+ZmvGcDleQ0hk9SvRIAzQyN4A8vPmcsRfRmZX
         l8Kl3+ah2OGElogYljWy3pnzOQ/GGAfo4fHFLXCTel8CVKmRuTkExVT2mbHnm3cMhqhk
         LZuogQqdTh9vpe6QSHPwouC3tTlAtK8C6zjibQNA96wGAj9Zw1v4tvCbTot+W+jYwhoo
         Sqy+Fnre0Sw3zmNjNnaX6jGnRqjRjxIxqC/SQsWPUgkLME1j+LYPHYUtM+DS+b99ny7P
         QCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=XFPVDLt22Mf+eywEhtbrRGQZP+BqmzTLYoHmyhTVdSw=;
        b=QEEk3imleXhEy06oAZuO5M3FIx+szBuDvhJTNhk0WsBN/H26FU0QuMIRHh6BVmHIAD
         I/VnOc1F4mm+UXjo4ma7d8RtuWdNmqMuoJVPe7SrNRWb7+xndwQwlsTXMJEiqXsqbuST
         LjKCCEvIUiE95WtIbov/4wUjTlqTG0toByeOcdJBbdqo4MhbhOSSjd61wKRXwv76GZKE
         steODpAzcQBsN3vjfUDX4Rs7ejAMDTvSz1CXCwqNfySk7ewLvL6ZztM7ztxJxHjhdOZZ
         l0nRcbTOTkQj3myOMfj/uB14uwfl7ylrlNz0PUoSRcPwXUzJr2bBskwSxGcn9hshutCI
         452g==
X-Gm-Message-State: ACgBeo1cNpFqYs9pLwOEm4cdRwKtVhe2w0kcJpqd+p+NDmmMbEmjPeM9
        vBscIUZf+Gpce/3eL8UscZkDtg==
X-Google-Smtp-Source: AA6agR7hLwZ29c1VezpHHkk+bMHwJXVH/dx7lvm8lqxW0VcnNRQnAaL+1jCUrBfQ7E506itw19MPJA==
X-Received: by 2002:a05:622a:130d:b0:344:8f5c:2cda with SMTP id v13-20020a05622a130d00b003448f5c2cdamr8589786qtk.685.1661742480648;
        Sun, 28 Aug 2022 20:08:00 -0700 (PDT)
Received: from fusetakDesktop.internal.fusetak.net (cpe84948c2a9a83-cm84948c2a9a80.cpe.net.fido.ca. [72.140.25.213])
        by smtp.gmail.com with ESMTPSA id s16-20020ac85290000000b0034305a91aaesm4457940qtn.83.2022.08.28.20.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 20:08:00 -0700 (PDT)
From:   Tamim Khan <tamim@fusetak.com>
To:     linux-acpi@vger.kernel.org
Cc:     lenb@kernel.org, rafael@kernel.org, linux-kernel@vger.kernel.org,
        Tamim Khan <tamim@fusetak.com>,
        Hui Wang <hui.wang@canonical.com>,
        Sunand <sunandchakradhar@gmail.com>
Subject: [PATCH] ACPI: Skip IRQ override on Asus Vivobook K3402ZA/K3502ZA
Date:   Sun, 28 Aug 2022 23:04:19 -0400
Message-Id: <20220829030417.236471-1-tamim@fusetak.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the ACPI DSDT table for Asus VivoBook K3402ZA/K3502ZA
IRQ 1 is described as ActiveLow; however, the kernel overrides
it to Edge_High. This prevents the internal keyboard from working
on these laptops. In order to fix this add these laptops to the
skip_override_table so that the kernel does not override IRQ 1 to
Edge_High.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=216158
Reviewed-by: Hui Wang <hui.wang@canonical.com>
Tested-by: Tamim Khan <tamim@fusetak.com>
Tested-by: Sunand <sunandchakradhar@gmail.com>
Signed-off-by: Tamim Khan <tamim@fusetak.com>
---
This patch is very similar to the fix implemented for keyboards on 
Medion laptops in 892a012699fc0b91a2ed6309078936191447f480 
(ACPI: resources: Add DMI-based legacy IRQ override quirk) and 
1b26ae40092b43bb6e9c5df376227382b390b953 (ACPI: resources: Add one 
more Medion model in IRQ override quirk) and has been reviewed by the
author of those commits. It has also been tested by myself on a K3502ZA 
and by someone else with a K3402ZA to verify that this patch allows
the internal keyboard to work.

 drivers/acpi/resource.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 510cdec375c4..2ebc85233bac 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -399,6 +399,24 @@ static const struct dmi_system_id medion_laptop[] = {
 	{ }
 };
 
+static const struct dmi_system_id asus_laptop[] = {
+	{
+		.ident = "Asus Vivobook K3402ZA",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "K3402ZA"),
+		},
+	},
+	{
+		.ident = "Asus Vivobook K3502ZA",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "K3502ZA"),
+		},
+	},
+	{ }
+};
+
 struct irq_override_cmp {
 	const struct dmi_system_id *system;
 	unsigned char irq;
@@ -409,6 +427,7 @@ struct irq_override_cmp {
 
 static const struct irq_override_cmp skip_override_table[] = {
 	{ medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0 },
+	{ asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0 },
 };
 
 static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
-- 
2.37.2

