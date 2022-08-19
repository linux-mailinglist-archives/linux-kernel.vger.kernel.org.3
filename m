Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27FD599508
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242808AbiHSGIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344330AbiHSGIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:08:05 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64204C6B60
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:08:04 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x21so4454958edd.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=ufsISK0rH8yY7wMMtYIeQyvsyvFMn85SDcIXuG3IE/k=;
        b=f82fbImgvwt5AE/KH6zgPm9GdUuhIIhX3RarQ2rwkGMBsM1xeNKaxj0AlnDS7I16iK
         8OYljuzUKHCuFt1/tiTGfUc6+qVuvFUHMFe9fZ8BclZ8Lnhr1guhDBtUnz5+R366RyW/
         5H2EwV9f5v4c71ZqwiYBRG7+9z2o5Dtd7nhZHZbFVrVovXiBT9zduuhz9mKToQe7DKmR
         MAOjcxRkVo73UFj7tgJZwo3A2jM729I21+CKF4IFb2nDQEFf+GAktbdM5Dry4ipTQKbw
         wbQ/PDDjZ/HThZy05gxJb0ImF6N1s16nqN7KBOtqhSyilTcgyse5ysFk+Fi6lYjocnNL
         Zs9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=ufsISK0rH8yY7wMMtYIeQyvsyvFMn85SDcIXuG3IE/k=;
        b=F2avd9tiVaqnNpckgFLJ/dbFU4KT8dedIFpzZzDq6uEPQG3JrG4OijskcmciWDHrBQ
         pYgNMaAT1h3S3JKIs4SHMMKUgTAxmt+7tkEYmdoM2W+u34bfkG23Wc+Ism1Cg+I9Kc7T
         ekYvXPJ3TlvJ9rtBVAy2TRzJc7cUL+rHh2pNBBw5LpLde+zx3ef/3jK+8RoHzOktADVK
         VJXaShjv65qh0TvLCt6iq2gSV/RlYHfPJzTOEo8WCWfveJCb6e/gmuM73NJuUxc33MG/
         NW8KImCGaHstGTsZrBzQUejLHngvp9D51AjjZxxcvg24vMj+yrrxiKm1RAJ/NpA5ag9k
         QRlg==
X-Gm-Message-State: ACgBeo00au93SQ0p75IpOhnClPSbM4B5zVHH/JomCrYm4s+MlKsxgNHy
        dRkrtgi2lkVDpOjsiJhAkRF713qGRAWnOA==
X-Google-Smtp-Source: AA6agR5pAZHTcs6+mUcGgOV20grOehsjF6Z0qKhflTplzNAEiO0bHsErzdBCtVAK4iS/QUchlIo9nQ==
X-Received: by 2002:a05:6402:2b98:b0:43e:107:183d with SMTP id fj24-20020a0564022b9800b0043e0107183dmr4830526edb.366.1660889282693;
        Thu, 18 Aug 2022 23:08:02 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:143b:fd00:5207:8c7f:747a:b80d])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709063a8e00b0073a644ef803sm1809660ejd.101.2022.08.18.23.08.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 23:08:02 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH v1 00/19] Fix dma_map_sg error check
Date:   Fri, 19 Aug 2022 08:07:42 +0200
Message-Id: <20220819060801.10443-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all,

While working on a bugfix on RTRS[1], I noticed there are quite a few other
drivers have the same problem, due to the fact dma_map_sg return 0 on error,
not like most of the cases, return negative value for error.

I "grep -A 5 dma_map_sg' in kernel tree, and audit/fix the one I feel is buggy,
hence this serry. All the patch are independent, so can go either through the
maintainer tree once it is reviewed.

Thanks!

[1] https://lore.kernel.org/linux-rdma/20220818105355.110344-1-haris.iqbal@ionos.com/T/#t

Jack Wang (19):
  mailbox: bcm-ferxrm-mailbox: Fix error check for dma_map_sg
  infiniband/mthca: Fix dma_map_sg error check
  HSI: omap_ssi_port: Fix dma_map_sg error check
  mtd: rawnand: stm32_fmc2: Fix dma_map_sg error check
  mtd: rawnand: marvell: Fix error handle regarding dma_map_sg
  usb/hcd: Fix dma_map_sg error check
  crypto: gemin: Fix error check for dma_map_sg
  crypto: sahara: Fix error check for dma_map_sg
  crypto: qce: Fix dma_map_sg error check
  crypto: amlogic: Fix dma_map_sg error check
  crypto: allwinner: Fix dma_map_sg error check
  crypto: ccree: Fix dma_map_sg error check
  intel_th: Fix dma_map_sg error check
  nvme-rdma: Fix error check for ib_dma_map_sg
  nvme-fc: Fix the error check for dma_map_sg
  scsi/qlogicpti: Fix dma_map_sg check
  mmc: meson-mx-sdhc: Fix error check for dma_map_sg
  mmc: jz4740_mmc: Fix error check for dma_map_sg
  net/mlx4: Fix error check for dma_map_sg

 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c | 6 +++---
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c   | 2 +-
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c | 4 ++--
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c   | 2 +-
 drivers/crypto/amlogic/amlogic-gxl-cipher.c         | 6 +++---
 drivers/crypto/ccree/cc_buffer_mgr.c                | 2 +-
 drivers/crypto/gemini/sl3516-ce-cipher.c            | 6 +++---
 drivers/crypto/qce/aead.c                           | 4 ++--
 drivers/crypto/qce/sha.c                            | 8 +++++---
 drivers/crypto/qce/skcipher.c                       | 8 ++++----
 drivers/crypto/sahara.c                             | 4 ++--
 drivers/hsi/controllers/omap_ssi_port.c             | 8 ++++----
 drivers/hwtracing/intel_th/msu.c                    | 2 +-
 drivers/infiniband/hw/mthca/mthca_memfree.c         | 7 ++++---
 drivers/mailbox/bcm-flexrm-mailbox.c                | 8 ++++----
 drivers/mmc/host/jz4740_mmc.c                       | 2 +-
 drivers/mmc/host/meson-mx-sdhc-mmc.c                | 2 +-
 drivers/mtd/nand/raw/marvell_nand.c                 | 8 +++++++-
 drivers/mtd/nand/raw/stm32_fmc2_nand.c              | 8 +++++---
 drivers/net/ethernet/mellanox/mlx4/icm.c            | 4 ++--
 drivers/nvme/host/fc.c                              | 2 +-
 drivers/nvme/host/rdma.c                            | 4 ++--
 drivers/nvme/target/fc.c                            | 5 +++++
 drivers/scsi/qlogicpti.c                            | 3 ++-
 drivers/usb/core/hcd.c                              | 2 +-
 25 files changed, 67 insertions(+), 50 deletions(-)

-- 
2.34.1

