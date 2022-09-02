Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E689F5AA917
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 09:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbiIBHvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 03:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbiIBHvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:51:08 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A56569F50;
        Fri,  2 Sep 2022 00:51:07 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id u1-20020a17090a410100b001fff314d14fso1372975pjf.5;
        Fri, 02 Sep 2022 00:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=l7PysdDE7wN+ye8WRTKSRcfMHgYlvrUlNtFAwiTdfkc=;
        b=MSeXIxsWfHMOPCblIr986Y0cCuP9gohYjJX8CZpxJOj+F/Qdm13qgTB/AjfPZMageB
         5iKcHihidqHEK3RxY/s/LXyUmETkKkkDhr3uQfjm3mhShonwTMJ7BmqDv3wxWobVgZDl
         dYNq8+SrHrFN6ZErkysqCJNbw37QycEasVoMOoaRsPn6OWRmxImcdBUB5Jbc0Mt8Fluy
         SsGube0vuJdG27vF5l1g1sGP3Ca+AJAUEOvL+IciEDPkd9alb2sWMWGGHDwoHLpn8IEt
         f6gkb5/s7mGLrW1JnwT1MUrws8Xa6IyKIa+FEaU/T8UE/lo9QwDvb1JS8M7bTd+iFG1U
         YnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=l7PysdDE7wN+ye8WRTKSRcfMHgYlvrUlNtFAwiTdfkc=;
        b=IwCPn7uNHdJOc4xcKfEVhwGR7qK+nIfpgxrAVM/3dbduDdiLs+fon00mr5/vfsRQpt
         tWpZXeN2kLn3Tpcmi8wOkIwLW9VaC+1XOLoR64hYo2cVxQrZpPxnQDOQMht9EF/LOJmN
         KOBS8JRw8UBS6dspnW++WN5yEjl4kdEIAP68ci3EDQ3dfgxaVO9+0cDvAfNREp2+fAkc
         QA9jMRLtyregHZNDx9HZVD0gFOfhRk8QT2QJXnVUTfbJZic0N+Ix7Y7ClldgmgjTggvO
         wxe/qVww5PccBdeNPjBvHo3nlYrJtDkLV7rUY3AHsO+D3a/fP6haF1smKaYgOAvmQPcz
         6WmA==
X-Gm-Message-State: ACgBeo0r1MynZkAAYT4+2HD7Huz2gPmPpXlCME/z1TJyjRrGnEj+hwlM
        imuZOUhM6CoJrikEU2l/cZfOYKaMNOM2jQ==
X-Google-Smtp-Source: AA6agR4vsKeAwluDf0MR9ibQbnCUn+oeddwtCawAP9LGB2Ll3wWNF7w6acCv2BDoKD6LvXwB07ftiw==
X-Received: by 2002:a17:903:41c6:b0:16e:fb38:e2c7 with SMTP id u6-20020a17090341c600b0016efb38e2c7mr34737565ple.75.1662105066815;
        Fri, 02 Sep 2022 00:51:06 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu. [2607:f720:1300:3033::1:4dd])
        by smtp.googlemail.com with ESMTPSA id l10-20020a170903120a00b0016ef87334aesm911341plh.162.2022.09.02.00.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 00:51:06 -0700 (PDT)
From:   Li Zhong <floridsleeves@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        Li Zhong <floridsleeves@gmail.com>
Subject: [PATCH v1] arch/x86/kernel/acpi: check the return value of mp_find_ioapic()
Date:   Fri,  2 Sep 2022 00:50:53 -0700
Message-Id: <20220902075053.2212595-1-floridsleeves@gmail.com>
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

Check the return value of mp_find_ioapic(), which could be -1. Since
ioapic will be used as index in mpc_ioapic_id(), we should check the
return value ioapic here.

Signed-off-by: Li Zhong <floridsleeves@gmail.com>
---
 arch/x86/kernel/acpi/boot.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 907cc98b1938..687111adfb90 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -463,6 +463,10 @@ static void mp_config_acpi_gsi(struct device *dev, u32 gsi, int trigger,
 	mp_irq.srcbus = number;
 	mp_irq.srcbusirq = (((devfn >> 3) & 0x1f) << 2) | ((pin - 1) & 3);
 	ioapic = mp_find_ioapic(gsi);
+	if (ioapic < 0) {
+		pr_warn("Failed to find ioapic for gsi : %u\n", gsi);
+		return;
+	}
 	mp_irq.dstapic = mpc_ioapic_id(ioapic);
 	mp_irq.dstirq = mp_find_ioapic_pin(ioapic, gsi);
 
-- 
2.25.1

