Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD89D4E67CB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 18:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352312AbiCXR2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352285AbiCXR2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:28:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39614B188E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 10:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648142827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OIJlhxZQII2b1Vl5R2eePvHRFchgJiZqPqucMSOZBVI=;
        b=EOkCpfvOJSFqMXLMjm4HvSWTgkkmwIt5rYJa+FHDz0UqVYIC+tprc5vyGm2IuoSGuc/OKX
        5+cTupFKM1shQZ17kO4GN19lm4YO9FaC1VsCnCFjO2WZglsY1uPOvThEyGZBXWxbedW5tK
        X0Zgm3v2R/oy78iRKV6iddr+2gLNL58=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-380-K6iTcQ0NPHmL60azdyKqSQ-1; Thu, 24 Mar 2022 13:27:06 -0400
X-MC-Unique: K6iTcQ0NPHmL60azdyKqSQ-1
Received: by mail-qv1-f72.google.com with SMTP id t16-20020ad44850000000b00440e0f2a561so4113473qvy.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 10:27:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OIJlhxZQII2b1Vl5R2eePvHRFchgJiZqPqucMSOZBVI=;
        b=3fkKI3+1m4LvEowAMOx367P7/lDWfslLuvDvFEeqL06+dqcmwB1yefyWP8sUzIjGsj
         u4VScH96Q678ROHjvtJbgaE7Ndf1dX6sF/YaZgdmRnt54sUIqW5WsodpHkt4N6eWMLwA
         BSA1oFTHK+Q38C2kCePIS4NzdqNibx6ifgwTZiAZpJrUulZj3h2lYnfgtFNVo7S5pCud
         yvp56V5JHRnxlF0TgAnK/FeuhRxJ80IrJxQ53qZXRwLeTFE4LMaIkZaRM4YFinHmtGSZ
         VOVNTsqZzQGNCRMXsk0ZUepW18CPPkQmCPSPYJIW1FTvNWx7os/IMme1zVDciWGJu9US
         /FXg==
X-Gm-Message-State: AOAM533/faqY7KDTyT6Pv/zca5xSUyQ19zEYSZYqC1ZnbytHQD8ozCER
        77H08jJESPsObkrCUVRh4cbmml1SaaEfren1FxdmGq+xYKv1Uku9dvuJyljD9m9qI6fWoB1SUMB
        C2TlC8oKpKoQOSkeltTELZm3VlRSvG44EVum15qSxNEtfEGkDAD2rwBNBY9ahp2pfGM3ecLsxrz
        Y4
X-Received: by 2002:a05:620a:a57:b0:67d:396a:8a9d with SMTP id j23-20020a05620a0a5700b0067d396a8a9dmr4150376qka.322.1648142825466;
        Thu, 24 Mar 2022 10:27:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxB5F5wgV7J5cTSYxSXNzkylFEPJGtGrvg0qTVvsWiiJ29lM4a+bp0esEG2VaB8Mu4hX9z7ng==
X-Received: by 2002:a05:620a:a57:b0:67d:396a:8a9d with SMTP id j23-20020a05620a0a5700b0067d396a8a9dmr4150351qka.322.1648142825215;
        Thu, 24 Mar 2022 10:27:05 -0700 (PDT)
Received: from fedora.hitronhub.home (modemcable200.11-22-96.mc.videotron.ca. [96.22.11.200])
        by smtp.gmail.com with ESMTPSA id bm21-20020a05620a199500b0067d5e6c7bd8sm1886515qkb.56.2022.03.24.10.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 10:27:04 -0700 (PDT)
From:   Adrien Thierry <athierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Adrien Thierry <athierry@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Stefan Wahren <stefan.wahren@i2se.com>,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gaston Gonzalez <gascoar@gmail.com>,
        Ojaswin Mujoo <ojaswin98@gmail.com>,
        linux-staging@lists.linux.dev
Subject: [PATCH v2 2/2] staging: vchiq_arm: Use bcm2711 compatible string for bcm2711-based RPi
Date:   Thu, 24 Mar 2022 13:26:47 -0400
Message-Id: <20220324172647.167617-3-athierry@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220324172647.167617-1-athierry@redhat.com>
References: <20220324172647.167617-1-athierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use bcm2711 compatible string in vchiq driver and device tree for
bcm2711-based Raspberry Pi (Raspberry Pi 4). This is consistent with
what the downstream device tree uses, and allows running the vchiq
driver on the upstream kernel with the downstream device tree.

Signed-off-by: Adrien Thierry <athierry@redhat.com>
---
 arch/arm/boot/dts/bcm2711-rpi.dtsi                           | 1 +
 .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c    | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2711-rpi.dtsi b/arch/arm/boot/dts/bcm2711-rpi.dtsi
index ca266c5d9f9b..c868d1dcaba7 100644
--- a/arch/arm/boot/dts/bcm2711-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2711-rpi.dtsi
@@ -70,5 +70,6 @@ blconfig: nvram@0 {
 };
 
 &vchiq {
+	compatible = "brcm,bcm2711-vchiq";
 	interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 };
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 3a2e4582db8e..136c664132f4 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -81,6 +81,10 @@ static struct vchiq_drvdata bcm2836_drvdata = {
 	.cache_line_size = 64,
 };
 
+static struct vchiq_drvdata bcm2711_drvdata = {
+	.cache_line_size = 64,
+};
+
 struct vchiq_arm_state {
 	/* Keepalive-related data */
 	struct task_struct *ka_thread;
@@ -1748,6 +1752,7 @@ void vchiq_platform_conn_state_changed(struct vchiq_state *state,
 static const struct of_device_id vchiq_of_match[] = {
 	{ .compatible = "brcm,bcm2835-vchiq", .data = &bcm2835_drvdata },
 	{ .compatible = "brcm,bcm2836-vchiq", .data = &bcm2836_drvdata },
+	{ .compatible = "brcm,bcm2711-vchiq", .data = &bcm2711_drvdata },
 	{},
 };
 MODULE_DEVICE_TABLE(of, vchiq_of_match);
-- 
2.35.1

