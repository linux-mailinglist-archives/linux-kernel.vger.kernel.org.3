Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFFD5AA8D9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 09:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbiIBHjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 03:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbiIBHje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:39:34 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AF6B8F02;
        Fri,  2 Sep 2022 00:38:16 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 145so1120662pfw.4;
        Fri, 02 Sep 2022 00:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=WkR9LaSKiyJhtlTTWqMUWeVX6Mln5pRmeIixpHeSGbc=;
        b=UcMpMc1Kcy3O9+Qc0m7+xjCFZ4XPruIw9U3cyOACsPf2/js7J9BrKgZ31g6rsm3+Ei
         FLfdQeSqTXbXk8/aHm9FLoQQqVJSRN2X70HECxx9zjxrrnZFffErQZV3hLn47lYDi6et
         e0mQSDo9gd513Fyx9JVs+qw3hR5Qa0V2C2dZmuH4ZSPksQC4BCOoqIzYnJ9z0DPO7HXs
         xn05vGCvCx19VOo/6wTPnsR+2WciCIL8ot5B4TOwa04jVmrmX728oTDLkgiN+UymEq1b
         QAIXQxoLSIhakaUZZJ+9YnwaXasIhR0IVRqLFSbcSa13hEQSqQeevomPXkjd/VK3ZEWk
         5JNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=WkR9LaSKiyJhtlTTWqMUWeVX6Mln5pRmeIixpHeSGbc=;
        b=KTR0Q7ieheEYUVlLeyBWIs/N7LNzkEfRemPQjoocfZJRSpYub+mHHl4mKtTGGGOppa
         kxfwX9+gINXxhChoLUW0F/8oP3Usv8tohyz2gqrBZd7HG9OkPW4dvLneNCdwLaRlP2qq
         xRnZtk6s0jHF3ujic1IFRtOeUfGZvcCEFCakHefgVC4gf1T7D3a5QrgH5fJaN25crSk9
         WSFE+3daiixdUQKnwQv5TmmBpVGC63fROTC5UDBWYIwjwLyhiQ72qvd/vaYHDiitVU79
         DKltssMwUJjU4SueD7zy0GyMcmIadzZzEpbr9CcOEt4Rr8DQDyJqif8hjhZLRrWGjmMC
         adgQ==
X-Gm-Message-State: ACgBeo1lesFQp8Q5c9LVT9d0/cZ2jY8Km/6n8EumRMy0bTMOoNzo++1F
        5G+rXfMYhzN7ebR/IlnVAvk1TKXYIDk=
X-Google-Smtp-Source: AA6agR7Rg6Dfva7zK/SAy8pg1Ez2Vf07BTbYdHwqsP4MSnQ8uQ+CJ/X7JT0MdHbjIZzxdYn5MeE1ZA==
X-Received: by 2002:a65:6ccf:0:b0:42b:20e8:5b8a with SMTP id g15-20020a656ccf000000b0042b20e85b8amr28449731pgw.500.1662104295633;
        Fri, 02 Sep 2022 00:38:15 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu. [2607:f720:1300:3033::1:4dd])
        by smtp.googlemail.com with ESMTPSA id i9-20020a170902c94900b0016ecc7d5297sm862930pla.292.2022.09.02.00.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 00:38:15 -0700 (PDT)
From:   Li Zhong <floridsleeves@gmail.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org,
        Li Zhong <floridsleeves@gmail.com>
Subject: [PATCH v1] drivers/acpi/processor_idle: check the return value of acpi_fetch_acpi_dev()
Date:   Fri,  2 Sep 2022 00:37:30 -0700
Message-Id: <20220902073730.2207819-1-floridsleeves@gmail.com>
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

