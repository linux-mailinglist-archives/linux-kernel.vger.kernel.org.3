Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4524B809C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 07:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiBPG0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 01:26:30 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiBPG02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 01:26:28 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F35D1D6869
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 22:26:11 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id c10so1338894pfv.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 22:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OvKU87ZuZVBNlgRFBm0eK1EY/vXmrbJUx8OOhh6O4Fw=;
        b=VNEOZaNjA8eSHMhScLGO1U7A14vrcKc3V+O17T0GPa4CA7I0gu8ccEAHfW/N/i8FEZ
         worTZCDDMQ0FYDxMqxuc0U1mf+F9uAEEBWmuMq0TfXN0GSQ7DaDNA7fSHtzUBC6w26Iw
         v2ZACq1ukUzkORWOFfKm7Q6XWsDy5CkdRfPaVc7IZCS7ssRpCA5mD4kqJHhbI/m26N4c
         qE5qXRQo3YG15e/CBehLRHNN0P40WBx5XXe6N8elYULUv+zylyn8RcYEjuNIg8xk5mXH
         cEnyKxxF+TVvNIQF3ZTcBbCqUd1VoAWn+tpUpNsbjho2ZI3txmXc6WcG+bnO/VHqS7T9
         skfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OvKU87ZuZVBNlgRFBm0eK1EY/vXmrbJUx8OOhh6O4Fw=;
        b=faKP/ulJi7NCaY5WUGLDJDVdy+iN3jAwPagkc9/IX0j3bat9KzcZANajIX0JdIYY9R
         J7uUP8LcBtDFklvZDLcHPtW+5jZqRZheUD+FgFwFdOg11XSgKtxYp05K1E4ZxXG+f1qo
         hwo9nAb9J7QhGwB8e570uAOsEmDLR/fKvQ5XUabioAHiicDjMWDn0bVF6JJeh6h87ZlQ
         XbylMC9V5xdHmitvs1qNsSWTQzjyaRmyi6d78h5kyIsDj5Iv9IAFWmZgy382o2Twm9NL
         h5JNyjp3NBxU+an2EV2zUnf222eoz1qGkAERE2pyM94IzmBEJe8VPSIvrFyXayQYAu+E
         tysw==
X-Gm-Message-State: AOAM530ieohfuDn8PX/GfDXQpoIdiMd1cs/m9zzqXx5vto7e6c2kw8YF
        Qc3MGQqRQ5+PpilFF0dW4GY=
X-Google-Smtp-Source: ABdhPJzQ8AwLjhZi76l0VaynoH2aURGnmi8K2tncLmHhiuqRQj23xU8ennGPDAs232lXurmGTokPyg==
X-Received: by 2002:a63:f20d:0:b0:372:c9bf:eaad with SMTP id v13-20020a63f20d000000b00372c9bfeaadmr1083890pgh.308.1644992769244;
        Tue, 15 Feb 2022 22:26:09 -0800 (PST)
Received: from ubuntu-server.local ([2600:1700:3ec7:421f:fd1e:ea7b:d4f8:959b])
        by smtp.googlemail.com with ESMTPSA id k4sm11321864pff.39.2022.02.15.22.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 22:26:08 -0800 (PST)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     Tong Zhang <ztong0001@gmail.com>
Subject: [PATCH] platform/chrome: cros_ec: honor acpi=off
Date:   Tue, 15 Feb 2022 22:26:01 -0800
Message-Id: <20220216062601.779690-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
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

when acpi=off is provided in bootarg, kernel crash with

 BUG: kernel NULL pointer dereference, address: 0000000000000018
 RIP: 0010:acpi_ns_walk_namespace+0x57/0x280
  <TASK>
 ? acpi_get_devices+0x140/0x140
 cros_ec_lpc_init+0x25/0x100

Driver should check if ACPI is disabled before calling acpi_get_devices(),
otherwise acpi_walk_namespace() will dereference null pointer since the
acpi_gbl_root_node is not initialized.
This is a common pattern and should be fixed in ACPI framework to prevent
such crash in the future, but since many drivers are already doing explicit
check(acpi_disable) we do the same thing here.

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/platform/chrome/cros_ec_lpc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index d6306d2a096f..95412a55ed8d 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -550,6 +550,9 @@ static int __init cros_ec_lpc_init(void)
 	int ret;
 	acpi_status status;
 
+	if (acpi_disable)
+		return -ENODEV;
+
 	status = acpi_get_devices(ACPI_DRV_NAME, cros_ec_lpc_parse_device,
 				  &cros_ec_lpc_acpi_device_found, NULL);
 	if (ACPI_FAILURE(status))
-- 
2.25.1

