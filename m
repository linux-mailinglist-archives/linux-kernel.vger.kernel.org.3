Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885B75520F8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243165AbiFTPa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237936AbiFTPaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:30:55 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C46EC42;
        Mon, 20 Jun 2022 08:30:55 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d13so10033850plh.13;
        Mon, 20 Jun 2022 08:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BOT86CwIpGfNhldrUrE42MrnwbNP3jQ4SNl8CEF3k+g=;
        b=qM4h2oAN9RBKPshpp0EHn+/Xy1RQNKz4b1krco6dcGrFAgyn2k9bPwmk18Z11bIE9v
         ZzE8lrdJ4V/TnmUys/ooGvkN+ObW/zrAa8S6aP5MGg2sQbu2elMEPWHkXyhok9DgXl0a
         NHnsXnCKvLa0mnLm9zsuYdjbzqJYkTPTG73sPV6BNtGih2UOdAUYdh7tShQvrfbcOmlQ
         1STg7AWbmpoPzQTMlxpKMNo5pfc/Z9nObP9mu2fCjunybQ3Zkq6YidUdNRIbhX5WeRkp
         sILXbqsq8rgTr25J9Lk+Saoce9ccKKrJ8VEmnco3wwqIq1Q58T+HQ0Gwz8T5pdnpT28R
         jkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BOT86CwIpGfNhldrUrE42MrnwbNP3jQ4SNl8CEF3k+g=;
        b=35eHFcDYk3nsAu2h+Ir19FIeO2V/C5RO0x3YbEXXdjYqkPgvtmurhjEyJv1y6swDeP
         Oxc9TjyNHacFx77hiHrdAcA7rEikllpiS9e+y/6acG4LVEJPtS6yFJfbl5ugYE4yozNk
         CB7vepVPpE1EQwG4teN/oCO7mt/QvOvZfH5vzZAZj/TKTB+7z3NXmp4/XOLlOvcb9yAU
         5Msl1ORQ+WyJVv7fzSyWGmb/off6kx4Ut1doIi1Ak57t2ZX/L/N5vJFUqvo7e1GMs1hB
         xjaMcTKi43ObemjQk/NEB2GdjMno7M9zqQmsplBCGTEiTBBVbWvvBMVIH8lvm44q8g28
         Jy2Q==
X-Gm-Message-State: AJIora+qkQPHyHB8eglJvmjyS0Hgr1zUl+l6xLyNlnMR3DGTLZzBV5Dl
        MVA5+FSajUTLPs2pgncnTu8SMQCziX/biw==
X-Google-Smtp-Source: AGRyM1tXMbdMk0xhzMfzjCGNg7HtlWRgu9Ld/DSZdGGzQmxyUXdwpCpN1OJuM48q81avazvcDNkVzw==
X-Received: by 2002:a17:902:7088:b0:167:78c0:e05e with SMTP id z8-20020a170902708800b0016778c0e05emr24133204plk.149.1655739054349;
        Mon, 20 Jun 2022 08:30:54 -0700 (PDT)
Received: from guoguo-omen.lan ([2401:c080:1400:4da2:b701:47d5:9291:4cf9])
        by smtp.gmail.com with ESMTPSA id t63-20020a628142000000b0051c03229a2bsm2038856pfd.21.2022.06.20.08.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 08:30:53 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-acpi@vger.kernel.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 0/3] Skip IRQ1 override for two laptops
Date:   Mon, 20 Jun 2022 23:30:42 +0800
Message-Id: <20220620153045.11129-1-gch981213@gmail.com>
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

The IRQ1 of these laptops with Ryzen 6000 and Insyde UEFI are
active low and defined in legacy format in ACPI DSDT. The
kernel override made their keyboard non-functional.
This patchset skips override for them.

Changes since v1:
 Match DMI_PRODUCT_NAME for ThinkBook because the board name
 is used for other completely different Lenovo laptops.
 Add a patch for RedmiBook

Changes since v2:
 Fix alphabetical order in skip_override_table
 Add a patch for Asus Zenbook

Chuanhong Guo (1):
  ACPI: skip IRQ1 override on Lenovo ThinkBook 14G4+ ARA

Kent Hou Man (1):
  ACPI: skip IRQ1 override on Asus Zenbook S 13 OLED UM5302

Tighe Donnelly (1):
  ACPI: skip IRQ1 override on Redmi Book Pro 15 2022

 drivers/acpi/resource.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

-- 
2.36.1

