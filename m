Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD6A53D7FC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 19:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239002AbiFDRNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 13:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238357AbiFDRNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 13:13:18 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B937627B3F
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 10:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1654362795;
        bh=8fLidAoAqhm2SxxwLYDp3oE6sOROf9POt0TusgpwMlQ=;
        h=Message-ID:Subject:From:To:Date:From;
        b=Nr0BGk45q3cdpNzdyTjgECkuPNySVj2FE/Kz0wEfqmW19tdP+s34gyvbRhTdubAQX
         UVQlQbFJCDM3wVivmKK5GcPCl6ybpGzYebpMRjC7wQDStJVYb2kcet1fSHIwaUlyjy
         DTzpEhk12gFxnmvUdBXOGB8zxDFl9NOnq48hcW9w=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 44A3112810D3;
        Sat,  4 Jun 2022 13:13:15 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KPPX8UdcoWUW; Sat,  4 Jun 2022 13:13:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1654362795;
        bh=8fLidAoAqhm2SxxwLYDp3oE6sOROf9POt0TusgpwMlQ=;
        h=Message-ID:Subject:From:To:Date:From;
        b=Nr0BGk45q3cdpNzdyTjgECkuPNySVj2FE/Kz0wEfqmW19tdP+s34gyvbRhTdubAQX
         UVQlQbFJCDM3wVivmKK5GcPCl6ybpGzYebpMRjC7wQDStJVYb2kcet1fSHIwaUlyjy
         DTzpEhk12gFxnmvUdBXOGB8zxDFl9NOnq48hcW9w=
Received: from [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b] (unknown [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id A64D512810C4;
        Sat,  4 Jun 2022 13:13:14 -0400 (EDT)
Message-ID: <29ba89f60e3b9ff457056b79f3b9d86c8a4b1c48.camel@HansenPartnership.com>
Subject: [GIT PULL] final round of SCSI updates for the 5.18+ merge window
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 04 Jun 2022 13:13:13 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mostly small bug fixes plus other trivial updates.  The major change of
note is moving ufs out of scsi and a minor update to lpfc vmid
handling.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

The short changelog is:

Bart Van Assche (1):
      scsi: ufs: Split the drivers/scsi/ufs directory

Bradley Grove (1):
      scsi: lpfc: Add support for ATTO Fibre Channel devices

Christoph Hellwig (2):
      scsi: core: Unexport scsi_bus_type
      scsi: sd: Don't call blk_cleanup_disk() in sd_probe()

Colin Ian King (1):
      scsi: qla1280: Remove redundant variable

Damien Le Moal (2):
      scsi: sd_zbc: Prevent zone information memory leak
      scsi: sd: Fix potential NULL pointer dereference

Dan Carpenter (1):
      scsi: ufs: ufshcd: Delete unnecessary NULL check

Gleb Chesnokov (1):
      scsi: qla2xxx: Remove unused 'ql_dm_tgt_ex_pct' parameter

Hannes Reinecke (2):
      scsi: core: Return BLK_STS_TRANSPORT for ALUA transitioning
      scsi: myrb: Fix up null pointer access on myrb_cleanup()

James Smart (3):
      scsi: lpfc: Add support for VMID tagging of NVMe I/Os
      scsi: lpfc: Rework lpfc_vmid_get_appid() to be protocol independent
      scsi: lpfc: Commonize VMID code location

Jiapeng Chong (1):
      scsi: mpi3mr: Fix kernel-doc

Julia Lawall (6):
      scsi: isci: Fix typo in comment
      scsi: pmcraid: Fix typo in comment
      scsi: smartpqi: Fix typo in comment
      scsi: qedf: Fix typo in comment
      scsi: esas2r: Fix typo in comment
      scsi: storvsc: Fix typo in comment

Muneendra Kumar (1):
      scsi: nvme-fc: Add new routine nvme_fc_io_getuuid()

Sumit Saxena (1):
      scsi: mpi3mr: Rework mrioc->bsg_device model to fix warnings

Tom Rix (1):
      scsi: qla2xxx: Remove setting of 'req' and 'rsp' parameters

And the diffstat:

 MAINTAINERS                                        |  10 +-
 drivers/Kconfig                                    |   2 +
 drivers/Makefile                                   |   1 +
 drivers/nvme/host/fc.c                             |  18 ++
 drivers/scsi/Kconfig                               |   1 -
 drivers/scsi/Makefile                              |   1 -
 drivers/scsi/esas2r/esas2r_flash.c                 |   2 +-
 drivers/scsi/isci/request.c                        |   2 +-
 drivers/scsi/lpfc/Makefile                         |   2 +-
 drivers/scsi/lpfc/lpfc_crtn.h                      |   3 +
 drivers/scsi/lpfc/lpfc_hw.h                        |  22 ++
 drivers/scsi/lpfc/lpfc_ids.h                       |  30 +++
 drivers/scsi/lpfc/lpfc_init.c                      |  89 +++++++
 drivers/scsi/lpfc/lpfc_nvme.c                      |  45 ++++
 drivers/scsi/lpfc/lpfc_scsi.c                      | 263 +------------------
 drivers/scsi/lpfc/lpfc_vmid.c                      | 288 +++++++++++++++++++++
 drivers/scsi/mpi3mr/mpi3mr.h                       |   2 +-
 drivers/scsi/mpi3mr/mpi3mr_app.c                   |  50 ++--
 drivers/scsi/myrb.c                                |  11 +-
 drivers/scsi/pmcraid.c                             |   2 +-
 drivers/scsi/qedf/qedf_io.c                        |   2 +-
 drivers/scsi/qla1280.c                             |   3 +-
 drivers/scsi/qla2xxx/qla_mid.c                     |   2 -
 drivers/scsi/qla2xxx/qla_target.c                  |   7 -
 drivers/scsi/scsi_lib.c                            |   2 +-
 drivers/scsi/scsi_sysfs.c                          |   1 -
 drivers/scsi/sd.c                                  |   5 +-
 drivers/scsi/sd.h                                  |   4 +-
 drivers/scsi/sd_zbc.c                              |  26 +-
 drivers/scsi/smartpqi/smartpqi.h                   |   2 +-
 drivers/scsi/storvsc_drv.c                         |   2 +-
 drivers/ufs/Kconfig                                |  30 +++
 drivers/ufs/Makefile                               |   5 +
 drivers/ufs/core/Kconfig                           |  60 +++++
 drivers/ufs/core/Makefile                          |  10 +
 drivers/{scsi/ufs => ufs/core}/ufs-debugfs.c       |   2 +-
 drivers/{scsi/ufs => ufs/core}/ufs-debugfs.h       |   0
 .../{scsi/ufs => ufs/core}/ufs-fault-injection.c   |   0
 .../{scsi/ufs => ufs/core}/ufs-fault-injection.h   |   0
 drivers/{scsi/ufs => ufs/core}/ufs-hwmon.c         |   2 +-
 drivers/{scsi/ufs => ufs/core}/ufs-sysfs.c         |   2 +-
 drivers/{scsi/ufs => ufs/core}/ufs-sysfs.h         |   0
 drivers/{scsi/ufs => ufs/core}/ufs_bsg.c           |   2 +-
 drivers/{scsi/ufs => ufs/core}/ufs_bsg.h           |   0
 drivers/{scsi/ufs => ufs/core}/ufshcd-crypto.c     |   2 +-
 drivers/{scsi/ufs => ufs/core}/ufshcd-crypto.h     |   4 +-
 drivers/{scsi/ufs => ufs/core}/ufshcd-priv.h       |   2 +-
 drivers/{scsi/ufs => ufs/core}/ufshcd.c            |   9 +-
 drivers/{scsi/ufs => ufs/core}/ufshpb.c            |   2 +-
 drivers/{scsi/ufs => ufs/core}/ufshpb.h            |   0
 drivers/{scsi/ufs => ufs/host}/Kconfig             |  75 +-----
 drivers/{scsi/ufs => ufs/host}/Makefile            |  12 -
 drivers/{scsi/ufs => ufs/host}/cdns-pltfrm.c       |   0
 drivers/{scsi/ufs => ufs/host}/tc-dwc-g210-pci.c   |   2 +-
 .../{scsi/ufs => ufs/host}/tc-dwc-g210-pltfrm.c    |   0
 drivers/{scsi/ufs => ufs/host}/tc-dwc-g210.c       |   4 +-
 drivers/{scsi/ufs => ufs/host}/tc-dwc-g210.h       |   0
 drivers/{scsi/ufs => ufs/host}/ti-j721e-ufs.c      |   0
 drivers/{scsi/ufs => ufs/host}/ufs-exynos.c        |   6 +-
 drivers/{scsi/ufs => ufs/host}/ufs-exynos.h        |   0
 drivers/{scsi/ufs => ufs/host}/ufs-hisi.c          |   8 +-
 drivers/{scsi/ufs => ufs/host}/ufs-hisi.h          |   0
 .../{scsi/ufs => ufs/host}/ufs-mediatek-trace.h    |   2 +-
 drivers/{scsi/ufs => ufs/host}/ufs-mediatek.c      |   6 +-
 drivers/{scsi/ufs => ufs/host}/ufs-mediatek.h      |   0
 drivers/{scsi/ufs => ufs/host}/ufs-qcom-ice.c      |   0
 drivers/{scsi/ufs => ufs/host}/ufs-qcom.c          |   8 +-
 drivers/{scsi/ufs => ufs/host}/ufs-qcom.h          |   2 +-
 drivers/{scsi/ufs => ufs/host}/ufshcd-dwc.c        |   4 +-
 drivers/{scsi/ufs => ufs/host}/ufshcd-dwc.h        |   2 +-
 drivers/{scsi/ufs => ufs/host}/ufshcd-pci.c        |   2 +-
 drivers/{scsi/ufs => ufs/host}/ufshcd-pltfrm.c     |   4 +-
 drivers/{scsi/ufs => ufs/host}/ufshcd-pltfrm.h     |   2 +-
 drivers/{scsi/ufs => ufs/host}/ufshci-dwc.h        |   0
 include/linux/nvme-fc-driver.h                     |  14 +
 {drivers/scsi => include}/ufs/ufs.h                |   0
 {drivers/scsi => include}/ufs/ufs_quirks.h         |   0
 {drivers/scsi => include}/ufs/ufshcd.h             |   8 +-
 {drivers/scsi => include}/ufs/ufshci.h             |   0
 {drivers/scsi => include}/ufs/unipro.h             |   0
 80 files changed, 728 insertions(+), 465 deletions(-)
 create mode 100644 drivers/scsi/lpfc/lpfc_vmid.c
 create mode 100644 drivers/ufs/Kconfig
 create mode 100644 drivers/ufs/Makefile
 create mode 100644 drivers/ufs/core/Kconfig
 create mode 100644 drivers/ufs/core/Makefile
 rename drivers/{scsi/ufs => ufs/core}/ufs-debugfs.c (99%)
 rename drivers/{scsi/ufs => ufs/core}/ufs-debugfs.h (100%)
 rename drivers/{scsi/ufs => ufs/core}/ufs-fault-injection.c (100%)
 rename drivers/{scsi/ufs => ufs/core}/ufs-fault-injection.h (100%)
 rename drivers/{scsi/ufs => ufs/core}/ufs-hwmon.c (99%)
 rename drivers/{scsi/ufs => ufs/core}/ufs-sysfs.c (99%)
 rename drivers/{scsi/ufs => ufs/core}/ufs-sysfs.h (100%)
 rename drivers/{scsi/ufs => ufs/core}/ufs_bsg.c (99%)
 rename drivers/{scsi/ufs => ufs/core}/ufs_bsg.h (100%)
 rename drivers/{scsi/ufs => ufs/core}/ufshcd-crypto.c (99%)
 rename drivers/{scsi/ufs => ufs/core}/ufshcd-crypto.h (97%)
 rename drivers/{scsi/ufs => ufs/core}/ufshcd-priv.h (99%)
 rename drivers/{scsi/ufs => ufs/core}/ufshcd.c (99%)
 rename drivers/{scsi/ufs => ufs/core}/ufshpb.c (99%)
 rename drivers/{scsi/ufs => ufs/core}/ufshpb.h (100%)
 rename drivers/{scsi/ufs => ufs/host}/Kconfig (56%)
 rename drivers/{scsi/ufs => ufs/host}/Makefile (56%)
 rename drivers/{scsi/ufs => ufs/host}/cdns-pltfrm.c (100%)
 rename drivers/{scsi/ufs => ufs/host}/tc-dwc-g210-pci.c (99%)
 rename drivers/{scsi/ufs => ufs/host}/tc-dwc-g210-pltfrm.c (100%)
 rename drivers/{scsi/ufs => ufs/host}/tc-dwc-g210.c (99%)
 rename drivers/{scsi/ufs => ufs/host}/tc-dwc-g210.h (100%)
 rename drivers/{scsi/ufs => ufs/host}/ti-j721e-ufs.c (100%)
 rename drivers/{scsi/ufs => ufs/host}/ufs-exynos.c (99%)
 rename drivers/{scsi/ufs => ufs/host}/ufs-exynos.h (100%)
 rename drivers/{scsi/ufs => ufs/host}/ufs-hisi.c (99%)
 rename drivers/{scsi/ufs => ufs/host}/ufs-hisi.h (100%)
 rename drivers/{scsi/ufs => ufs/host}/ufs-mediatek-trace.h (93%)
 rename drivers/{scsi/ufs => ufs/host}/ufs-mediatek.c (99%)
 rename drivers/{scsi/ufs => ufs/host}/ufs-mediatek.h (100%)
 rename drivers/{scsi/ufs => ufs/host}/ufs-qcom-ice.c (100%)
 rename drivers/{scsi/ufs => ufs/host}/ufs-qcom.c (99%)
 rename drivers/{scsi/ufs => ufs/host}/ufs-qcom.h (99%)
 rename drivers/{scsi/ufs => ufs/host}/ufshcd-dwc.c (98%)
 rename drivers/{scsi/ufs => ufs/host}/ufshcd-dwc.h (95%)
 rename drivers/{scsi/ufs => ufs/host}/ufshcd-pci.c (99%)
 rename drivers/{scsi/ufs => ufs/host}/ufshcd-pltfrm.c (99%)
 rename drivers/{scsi/ufs => ufs/host}/ufshcd-pltfrm.h (98%)
 rename drivers/{scsi/ufs => ufs/host}/ufshci-dwc.h (100%)
 rename {drivers/scsi => include}/ufs/ufs.h (100%)
 rename {drivers/scsi => include}/ufs/ufs_quirks.h (100%)
 rename {drivers/scsi => include}/ufs/ufshcd.h (99%)
 rename {drivers/scsi => include}/ufs/ufshci.h (100%)
 rename {drivers/scsi => include}/ufs/unipro.h (100%)

James


