Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884895A3FB3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 22:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiH1Uyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 16:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH1Uyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 16:54:33 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F027F21A;
        Sun, 28 Aug 2022 13:54:29 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id t5so6243513pjs.0;
        Sun, 28 Aug 2022 13:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=WkR9LaSKiyJhtlTTWqMUWeVX6Mln5pRmeIixpHeSGbc=;
        b=IceoL4PGOPoCpsJ0DfTNHNc/+4q/6ByhIWG7OStXeUIyPthBT5vcdYk+rTyzMuDjlL
         IjVqYkgfLAmwbnSiHzIV83ehDQ/SiRfIGTbO5CBnJkm8L+3Isf3F64DdUiRV5/9pd4GQ
         BsMnKRlfov5bLY/jpAhXOncSsD6nUuJ05gK27MUDvitzher+1jLSprVl1nMTKmhpxz7D
         ehuupBsqjPgQThAbUnBkxSiqGl++sul2fNuG0Aq1UJaZBc0kdlRTKvw325DwQ5nYiN0v
         B9ZktXqWISLS4dQisgL1U7qmTABLUwItkeDbIhK/Zx+3YidH3VUB6PTXATBUR4WWzMcG
         nUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=WkR9LaSKiyJhtlTTWqMUWeVX6Mln5pRmeIixpHeSGbc=;
        b=FlQ03779q65Ud4ygKo85ggFiTvM2/zIUq9lCB8GesCrAOusJaf0cBS8ybG5uzyjTnr
         18DLSAyakwnc0CnsaB43+bkf5BikAr/FnR4xASbdhIYwZAtZbEyJDl4jdB18q4yY7224
         zN9nFzQ/cJYWrXEtQFlrf8q81toN14YFbSj5wFUQzpYsYS50Idnxks3wpvuuyGLCsM55
         9LMGi5ewWqqKBtPRSMt5fPeTTissaiYizMe5fnbza2mY4b2n3z+wdomj9MQBm3JD06iu
         Uhm9va56pHEWJs1AICDzwUmbKoEBwuxB3F8AkRLzg1Bi/L5iaGQX59gKltsGrG3vH72i
         3dzA==
X-Gm-Message-State: ACgBeo0Ef9QSmGeiJil3+DFVSr6yZGdE2qORYbObE3p/po8EDczLhSjx
        8Y9sWv8KOLS1C6ktsf1uEDR4a4BrM7xQfQ==
X-Google-Smtp-Source: AA6agR4kdxcOS9nzv3/oVdsH1XQhYuTu2SUxhvE6Agpfxe6KsXEKfWMMVPyRDcv7WONer0F6Ebv2eA==
X-Received: by 2002:a17:902:cf42:b0:172:ed15:ee with SMTP id e2-20020a170902cf4200b00172ed1500eemr13162190plg.149.1661720069334;
        Sun, 28 Aug 2022 13:54:29 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu. [2607:f720:1300:3033::1:4dd])
        by smtp.googlemail.com with ESMTPSA id 8-20020a17090a018800b001fb277223bdsm5198017pjc.2.2022.08.28.13.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 13:54:29 -0700 (PDT)
From:   Li Zhong <floridsleeves@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org,
        Li Zhong <floridsleeves@gmail.com>
Subject: [PATCH v1] drivers/acpi/processor_idle: check the return value of acpi_fetch_acpi_dev()
Date:   Sun, 28 Aug 2022 13:54:16 -0700
Message-Id: <20220828205416.1957305-1-floridsleeves@gmail.com>
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

The return value of acpi_fetch_acpi_dev() could be NULL, which will
cause null pointer dereference if used in acpi_device_hid().

Signed-off-by: Li Zhong <floridsleeves@gmail.com>
---
 drivers/acpi/processor_idle.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 16a1663d02d4..519f8f741da3 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1117,6 +1117,8 @@ static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
 	status = acpi_get_parent(handle, &pr_ahandle);
 	while (ACPI_SUCCESS(status)) {
 		d = acpi_fetch_acpi_dev(pr_ahandle);
+		if (!d)
+			break;
 		handle = pr_ahandle;
 
 		if (strcmp(acpi_device_hid(d), ACPI_PROCESSOR_CONTAINER_HID))
-- 
2.25.1

