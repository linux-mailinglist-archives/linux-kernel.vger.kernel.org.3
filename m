Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F764E4243
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 15:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238225AbiCVOtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 10:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238597AbiCVOsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:48:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EA9376669
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 07:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647960429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4qzlNRqD4tfZikp/Dsm0XnaKMVbT8FwPh0SW/Cj1Wic=;
        b=C4pJWM2V9fxKH9AboGEPqs2Y1WsKHFn+J2YkIWnsH1yYPKb1xaaXEci1x9YgsdhVEBgXfj
        WXE3jgn6Ryg+2AiKR/1z5+/os0BvSrYA76PorFCm548W1ryoN1kpnwn/kWoEcnDsnva2//
        gKjdLEj8PAYkCw9JxUnWzDAWHKeoTnc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-530-kDEEsZCYMRyrx3_r-5US9A-1; Tue, 22 Mar 2022 10:47:08 -0400
X-MC-Unique: kDEEsZCYMRyrx3_r-5US9A-1
Received: by mail-qk1-f199.google.com with SMTP id i2-20020a05620a248200b0067b51fa1269so11911622qkn.19
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 07:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4qzlNRqD4tfZikp/Dsm0XnaKMVbT8FwPh0SW/Cj1Wic=;
        b=EINwbrvBhtIIN1n4N4VKIgN3y6c7+R46v9WH3t8IeRf1JxaGLZn787TFme/Uqf95IY
         E8EMAd1ET4OqbSmVNhKNTk2+W/mIe/teS2tWIgBHEdOMnqiH0OwaXph9NQ9uvgu4qqTA
         YTMKC3ytlFROvMAf5JHLtk9AW6dYlArvuaebBFFodCyKQ0VFA1hbAq3eK4hr+T9+cneE
         PoRm8TIQkrxyLfgRyQc20CLbre15fa2i7LGH/tXP/D7RwEgf3+M5BP9CICQnfAmJiGSw
         Im6ICDCma1qi27dEMbd31mcx5hBQXFHyl4+XpH95pw8PLxi0isTlIss83r5V9ibpY8Ny
         tfUg==
X-Gm-Message-State: AOAM533onRW985nYMGKdxtv8r0GyiQQR5QeCO0tYwrqdKhFYph5r/3R1
        LelKVTy7u1kWMDyvopB9mfGU1sssoVHmV+bSjrhMCLSV4K0TGHPZMDxjKkCRJZuRyD5ki9CFc+5
        MnetlBMsBJ1OQAOlGcEz7+3O7
X-Received: by 2002:a05:622a:205:b0:2e1:cda9:88e9 with SMTP id b5-20020a05622a020500b002e1cda988e9mr20487280qtx.384.1647960427432;
        Tue, 22 Mar 2022 07:47:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsLj5vUxfXBtD9PGWuK+FxEeeYZyjr67r11l2MMHSXkoX+jf7ZZy940QgqsSUCVpzKFaoUwA==
X-Received: by 2002:a05:622a:205:b0:2e1:cda9:88e9 with SMTP id b5-20020a05622a020500b002e1cda988e9mr20487261qtx.384.1647960427212;
        Tue, 22 Mar 2022 07:47:07 -0700 (PDT)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id j188-20020a3755c5000000b0067d1c76a09fsm9474508qkb.74.2022.03.22.07.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 07:47:06 -0700 (PDT)
From:   trix@redhat.com
To:     hare@suse.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] [SCSI] aic7xxx: use standard pci subsystem, subdevice defines
Date:   Tue, 22 Mar 2022 07:46:48 -0700
Message-Id: <20220322144648.2467777-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Common defines should be used over custom defines.

Change and remove these defines
PCIR_SUBVEND_0 to PCI_SUBSYSTEM_VENDOR_ID
PCIR_SUBDEV_0 to PCI_SUBSYSTEM_ID

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/scsi/aic7xxx/aic79xx_osm.h | 2 --
 drivers/scsi/aic7xxx/aic79xx_pci.c | 6 +++---
 drivers/scsi/aic7xxx/aic7xxx_osm.h | 2 --
 drivers/scsi/aic7xxx/aic7xxx_pci.c | 4 ++--
 4 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic79xx_osm.h b/drivers/scsi/aic7xxx/aic79xx_osm.h
index 679a4fd138746..793fe19993a90 100644
--- a/drivers/scsi/aic7xxx/aic79xx_osm.h
+++ b/drivers/scsi/aic7xxx/aic79xx_osm.h
@@ -420,8 +420,6 @@ ahd_unlock(struct ahd_softc *ahd, unsigned long *flags)
 
 /* config registers for header type 0 devices */
 #define PCIR_MAPS	0x10
-#define PCIR_SUBVEND_0	0x2c
-#define PCIR_SUBDEV_0	0x2e
 
 /****************************** PCI-X definitions *****************************/
 #define PCIXR_COMMAND	0x96
diff --git a/drivers/scsi/aic7xxx/aic79xx_pci.c b/drivers/scsi/aic7xxx/aic79xx_pci.c
index 2f0bdb9225a40..5fad41b1ab58d 100644
--- a/drivers/scsi/aic7xxx/aic79xx_pci.c
+++ b/drivers/scsi/aic7xxx/aic79xx_pci.c
@@ -260,8 +260,8 @@ ahd_find_pci_device(ahd_dev_softc_t pci)
 
 	vendor = ahd_pci_read_config(pci, PCIR_DEVVENDOR, /*bytes*/2);
 	device = ahd_pci_read_config(pci, PCIR_DEVICE, /*bytes*/2);
-	subvendor = ahd_pci_read_config(pci, PCIR_SUBVEND_0, /*bytes*/2);
-	subdevice = ahd_pci_read_config(pci, PCIR_SUBDEV_0, /*bytes*/2);
+	subvendor = ahd_pci_read_config(pci, PCI_SUBSYSTEM_VENDOR_ID, /*bytes*/2);
+	subdevice = ahd_pci_read_config(pci, PCI_SUBSYSTEM_ID, /*bytes*/2);
 	full_id = ahd_compose_id(device,
 				 vendor,
 				 subdevice,
@@ -298,7 +298,7 @@ ahd_pci_config(struct ahd_softc *ahd, const struct ahd_pci_identity *entry)
 	 * Record if this is an HP board.
 	 */
 	subvendor = ahd_pci_read_config(ahd->dev_softc,
-					PCIR_SUBVEND_0, /*bytes*/2);
+					PCI_SUBSYSTEM_VENDOR_ID, /*bytes*/2);
 	if (subvendor == SUBID_HP)
 		ahd->flags |= AHD_HP_BOARD;
 
diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.h b/drivers/scsi/aic7xxx/aic7xxx_osm.h
index 4782a304e93cc..51d9f4de07346 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.h
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.h
@@ -433,8 +433,6 @@ ahc_unlock(struct ahc_softc *ahc, unsigned long *flags)
 
 /* config registers for header type 0 devices */
 #define PCIR_MAPS	0x10
-#define PCIR_SUBVEND_0	0x2c
-#define PCIR_SUBDEV_0	0x2e
 
 typedef enum
 {
diff --git a/drivers/scsi/aic7xxx/aic7xxx_pci.c b/drivers/scsi/aic7xxx/aic7xxx_pci.c
index dab3a6d12c4d2..2d4c85426dc3e 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_pci.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_pci.c
@@ -673,8 +673,8 @@ ahc_find_pci_device(ahc_dev_softc_t pci)
 
 	vendor = ahc_pci_read_config(pci, PCIR_DEVVENDOR, /*bytes*/2);
 	device = ahc_pci_read_config(pci, PCIR_DEVICE, /*bytes*/2);
-	subvendor = ahc_pci_read_config(pci, PCIR_SUBVEND_0, /*bytes*/2);
-	subdevice = ahc_pci_read_config(pci, PCIR_SUBDEV_0, /*bytes*/2);
+	subvendor = ahc_pci_read_config(pci, PCI_SUBSYSTEM_VENDOR_ID, /*bytes*/2);
+	subdevice = ahc_pci_read_config(pci, PCI_SUBSYSTEM_ID, /*bytes*/2);
 	full_id = ahc_compose_id(device, vendor, subdevice, subvendor);
 
 	/*
-- 
2.26.3

