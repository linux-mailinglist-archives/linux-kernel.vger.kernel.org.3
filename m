Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888DE4DA3C3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 21:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351594AbiCOULD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 16:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351582AbiCOUK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 16:10:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 282CC50E26
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 13:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647374986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OIJlhxZQII2b1Vl5R2eePvHRFchgJiZqPqucMSOZBVI=;
        b=asDd5UHnJwsWp+Qv+ZslpkGtFx+gmmX4jTdV/rDTCxC8mhb7mc/XtH6oJex0k3KWjYuKg6
        v9eye4RuspT8Sfg25SPydgd4jfajaPJu3TK1s/3MjNEa6P3WLaTW1HeIVXWt1iDaWuLIHi
        GxVt4gnrWQB2/5K+CxvMsmf2Lk1Gs38=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-439-9Or1lNq5Nx-S3QWD1_4mRw-1; Tue, 15 Mar 2022 16:09:45 -0400
X-MC-Unique: 9Or1lNq5Nx-S3QWD1_4mRw-1
Received: by mail-qv1-f72.google.com with SMTP id l4-20020a0cc204000000b00435ac16d67cso308270qvh.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 13:09:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OIJlhxZQII2b1Vl5R2eePvHRFchgJiZqPqucMSOZBVI=;
        b=LMbWAURdt2fUvoMItJn7WZT0Efa6EMlbzXmHROxGhtuqg+8CVlAM1jLj5DWnJerZw6
         G1k99rwq2r1Pi0ipbxhik+G1wAvopyq2xvc4aniaU0FsN8R7O5lpREFxugNXmXXbPbEK
         K6tHoj53aChtaEveLGJAGhketeNz/NiySpfpZqS3OqoFKuzFeAjSPqcQCvmeiMwuF0j8
         2spMvRo0iiSh96BucTQx819Xo16Zkhxuqjv2wLBLTZQ24QgeRZk6qd9TT4GG2hm6P0xj
         JxiBWILEp5i5+bCvOMsCo+4lfEhHvii4lJtr8nFbEIoYklHPWU+4g6l/fR69+9XgTWmr
         Mh4g==
X-Gm-Message-State: AOAM531BqHR39LKwNAs8mxq1LsNiVRGXCeLYhijUzuiyFlHQObks+ec7
        TF12usFeat0MsqhacYhHU4qAiNZ5KCRTHs8AuHRQp7dXd20aniOpv/h3dnYRY5YGBak99faz0HD
        BJYO364lsgu4WIaw0+nzHv3rlHbZW8OIJjSHsbs1Pl+2PqHhBIjuQaGbaRFVZFowc3Vr1IdI+8j
        ks
X-Received: by 2002:a05:6214:27c6:b0:438:ff55:f2ad with SMTP id ge6-20020a05621427c600b00438ff55f2admr19812292qvb.14.1647374984333;
        Tue, 15 Mar 2022 13:09:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBAm8qJM4uO8E8XkhhgJ83X1MYV1taiReK2amKwIwz+dojqDUprSq/T2eq8pIQxnEiC+JolA==
X-Received: by 2002:a05:6214:27c6:b0:438:ff55:f2ad with SMTP id ge6-20020a05621427c600b00438ff55f2admr19812260qvb.14.1647374984094;
        Tue, 15 Mar 2022 13:09:44 -0700 (PDT)
Received: from fedora.hitronhub.home (modemcable200.11-22-96.mc.videotron.ca. [96.22.11.200])
        by smtp.gmail.com with ESMTPSA id 197-20020a3703ce000000b0067af869ffa6sm9582433qkd.127.2022.03.15.13.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 13:09:43 -0700 (PDT)
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
Subject: [PATCH 2/2] staging: vchiq_arm: Use bcm2711 compatible string for bcm2711-based RPi
Date:   Tue, 15 Mar 2022 16:09:29 -0400
Message-Id: <20220315200929.74952-3-athierry@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220315200929.74952-1-athierry@redhat.com>
References: <20220315200929.74952-1-athierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

