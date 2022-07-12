Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24AD570FEF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 04:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiGLCBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 22:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiGLCBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 22:01:34 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94ADC2F037;
        Mon, 11 Jul 2022 19:01:32 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id v4-20020a17090abb8400b001ef966652a3so10013929pjr.4;
        Mon, 11 Jul 2022 19:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fkxd8zIo1AnUctnwK3XErf3kWIJuqlFOkAEqPsRtokc=;
        b=KaBYOu1L28Jm9zFHTufjdVjIWE7s0oW1snh5c65zY0brBY8GXesih/4XGlT5niH37O
         YOUqXgEEBZbxctb3hLNNQFvJl5Of4NJhTfA+WWIByLxiLDQgPaxQKq3I2n7tcJLwNZOi
         6mTgP4y2IaQV/NncDB+6u4hgis+PL99n62Ltzc5CHMsHx/drMtYTPqKiKyRX04Fc8TB8
         Sy8AoDDh661Dg5aFInbbSt5ASUJL3hT2uzEKQmx2VEyNbyvGQv6AddxVgyLOABPzxRyQ
         uY+cqLG4QG4c2MjKjseZQeHj2Nb91V1yjp0SPxzFAc97NgFEUf4Blesq/fydVnJ3heAZ
         BD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fkxd8zIo1AnUctnwK3XErf3kWIJuqlFOkAEqPsRtokc=;
        b=dw2VgAN/1EXwyJQuklRG7y12A4YcMUCIqYaAQ2IXGsm6mjAcMhBEtPNfudpNSHMBlh
         Flrp1wlPjOK8UqPyIp10HtWz+//R/WPkdrGNCAavv4EWIuncItXiZWS+Aj1I6B17pyV0
         SstzPZQndeki3zn4BDqy0U3wsSnm8lJe/klOeLYBWkSQWL4HOY0NLJtIEgFcdyXZi8Uk
         4KL2vfD4b37v6fCEN6DBAe4lF/cqHu1CiREcke4dFpge7om6nbl9vnLHKn66WHxkmSxe
         PVSsn0cGSzzgWUfibDtS5EZchEXrQrXtJpNdGstjwCiAC+EBGjc5mFX7RZmcbWqn0KVi
         FyIA==
X-Gm-Message-State: AJIora+MEZa4afAkGhDGiVEF6+dFeWFs+siDe49nLOqGgku1mihETpav
        CMG88eAnMGUl5WXBWpZpR7YQU5ibMY0CNA==
X-Google-Smtp-Source: AGRyM1sC99RV7uLjDmVL+sCSTIHWnfnRoisTLkMhw8hAb8MYOAK8WrInJNJZBTAY1nbYH3sGmVzZDw==
X-Received: by 2002:a17:902:ea0e:b0:16b:f92b:a3c3 with SMTP id s14-20020a170902ea0e00b0016bf92ba3c3mr21251142plg.10.1657591291892;
        Mon, 11 Jul 2022 19:01:31 -0700 (PDT)
Received: from guoguo-omen.lan ([2401:c080:1400:4da2:b701:47d5:9291:4cf9])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090264d000b0015e8d4eb26esm5361637pli.184.2022.07.11.19.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 19:01:31 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-acpi@vger.kernel.org
Cc:     Tighe Donnelly <tighe.donnelly@protonmail.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6] ACPI: skip IRQ override on AMD Zen platforms
Date:   Tue, 12 Jul 2022 10:00:58 +0800
Message-Id: <20220712020058.90374-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IRQ override isn't needed on modern AMD Zen systems.
There's an active low keyboard IRQ on AMD Ryzen 6000 and it will stay
this way on newer platforms. This IRQ override breaks keyboards for
almost all Ryzen 6000 laptops currently on the market.

Skip this IRQ override for all AMD Zen platforms because this IRQ
override is supposed to be a workaround for buggy ACPI DSDT and we can't
have a long list of all future AMD CPUs/Laptops in the kernel code.
If a device with buggy ACPI DSDT shows up, a separated list containing
just them should be created.

Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
Change sice v5: reworked

 drivers/acpi/resource.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index c2d494784425..510cdec375c4 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -416,6 +416,16 @@ static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
 {
 	int i;
 
+#ifdef CONFIG_X86
+	/*
+	 * IRQ override isn't needed on modern AMD Zen systems and
+	 * this override breaks active low IRQs on AMD Ryzen 6000 and
+	 * newer systems. Skip it.
+	 */
+	if (boot_cpu_has(X86_FEATURE_ZEN))
+		return false;
+#endif
+
 	for (i = 0; i < ARRAY_SIZE(skip_override_table); i++) {
 		const struct irq_override_cmp *entry = &skip_override_table[i];
 
-- 
2.36.1

