Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DF848DED3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 21:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbiAMUWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 15:22:45 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:36392 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232597AbiAMUWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 15:22:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1642105364;
        bh=4yb8S0SxF8mGdKyBVLWgGJ233ht8yYKx9q1qC9d0u4g=;
        h=Message-ID:Subject:From:To:Date:From;
        b=pvvFblrbu95wmakZe5SvH+BjyayKoLzQypb5jGk7L4TNBxagpgnIBUvlryudbUF4F
         RDLb4cwxwwJp5hmSbYA5+JK/qS5Dx0uOqmxS9QX6tDRUlmwsfORuDmZlu+tMMDABZ1
         VxM5AkQT5/6Xj6bMmUz45hNyCUQocC+VMiAc3iLo=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7385C1280E57;
        Thu, 13 Jan 2022 15:22:44 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 725_tg9aG2Ea; Thu, 13 Jan 2022 15:22:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1642105364;
        bh=4yb8S0SxF8mGdKyBVLWgGJ233ht8yYKx9q1qC9d0u4g=;
        h=Message-ID:Subject:From:To:Date:From;
        b=pvvFblrbu95wmakZe5SvH+BjyayKoLzQypb5jGk7L4TNBxagpgnIBUvlryudbUF4F
         RDLb4cwxwwJp5hmSbYA5+JK/qS5Dx0uOqmxS9QX6tDRUlmwsfORuDmZlu+tMMDABZ1
         VxM5AkQT5/6Xj6bMmUz45hNyCUQocC+VMiAc3iLo=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::527])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E1F4A1280E1C;
        Thu, 13 Jan 2022 15:22:43 -0500 (EST)
Message-ID: <31f8716fbb4f1e2a332b2b3e3243a170e8b01145.camel@HansenPartnership.com>
Subject: [GIT PULL] first round of SCSI updates for the 5.15+ merge window
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 13 Jan 2022 15:22:42 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series consists of the usual driver updates (ufs, pm80xx, lpfc,
mpi3mr, mpt3sas, hisi_sas, libsas) and minor updates and bug
fixes.  The most impactful change is likely the switch from GFP_DMA to
GFP_KERNEL in a bunch of drivers, but even that shouldn't affect too
many people.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

Adrian Hunter (4):
      scsi: ufs: ufs-pci: Add support for Intel ADL
      scsi: ufs: Let devices remain runtime suspended during system suspend
      scsi: ufs: core: Fix another task management completion race
      scsi: ufs: core: Fix task management completion timeout race

Alan Stern (1):
      scsi: block: pm: Always set request queue runtime active in blk_post_runtime_resume()

Bart Van Assche (31):
      scsi: ufs: Implement polling support
      scsi: ufs: Optimize the command queueing code
      scsi: ufs: Stop using the clock scaling lock in the error handler
      scsi: ufs: Fix a kernel crash during shutdown
      scsi: ufs: Improve SCSI abort handling further
      scsi: ufs: Introduce ufshcd_release_scsi_cmd()
      scsi: ufs: Remove the 'update_scaling' local variable
      scsi: ufs: Remove hba->cmd_queue
      scsi: ufs: Fix a deadlock in the error handler
      scsi: ufs: Rework ufshcd_change_queue_depth()
      scsi: ufs: Remove ufshcd_any_tag_in_use()
      scsi: ufs: Fix race conditions related to driver data
      scsi: ufs: Remove dead code
      scsi: ufs: Remove the sdev_rpmb member
      scsi: ufs: Remove is_rpmb_wlun()
      scsi: ufs: Rename a function argument
      scsi: core: Fix scsi_device_max_queue_depth()
      scsi: Remove superfluous #include <linux/async.h> directives
      scsi: pmcraid: Fix a kernel-doc warning
      scsi: pm8001: Fix kernel-doc warnings
      scsi: megaraid: Fix a kernel-doc warning
      scsi: initio: Fix a kernel-doc warning
      scsi: dc395x: Fix a kernel-doc warning
      scsi: bfa: Declare 'bfad_im_vport_attrs' static
      scsi: atp870u: Fix a kernel-doc warning
      scsi: a100u2w: Fix a kernel-doc warning
      scsi: core: Show SCMD_LAST in text form
      scsi: core: Declare 'scsi_scan_type' static
      scsi: core: Suppress a kernel-doc warning
      scsi: core: Remove Scsi_Host.shost_dev_attr_groups
      scsi: ufs: core: Improve SCSI abort handling

Bean Huo (2):
      scsi: ufs: core: Fix deadlock issue in ufshcd_wait_for_doorbell_clr()
      scsi: ufs: ufshpb: Fix warning in ufshpb_set_hpb_read_to_upiu()

Changyuan Lyu (2):
      scsi: pm80xx: Add pm80xx_mpi_build_cmd() tracepoint
      scsi: pm80xx: Add tracepoints

Christoph Hellwig (8):
      scsi: pmcraid: Don't use GFP_DMA in pmcraid_alloc_sglist()
      scsi: snic: Don't use GFP_DMA in snic_queue_report_tgt_req()
      scsi: myrs: Don't use GFP_DMA
      scsi: myrb: Don't use GFP_DMA in myrb_pdev_slave_alloc()
      scsi: initio: Don't use GFP_DMA in initio_probe_one()
      scsi: sr: Don't use GFP_DMA
      scsi: ch: Don't use GFP_DMA
      scsi: efct: Don't pass GFP_DMA to dma_alloc_coherent()

Christophe JAILLET (4):
      scsi: hpsa: Remove an unused variable in hpsa_update_scsi_devices()
      scsi: hisi_sas: Use non-atomic bitmap functions when possible
      scsi: hisi_sas: Remove some useless code in hisi_sas_alloc()
      scsi: hisi_sas: Use devm_bitmap_zalloc() when applicable

Chunguang Xu (1):
      scsi: core: Use eh_timeout for START STOP UNIT

Colin Ian King (1):
      scsi: mptfusion: Remove redundant variable r

Dan Carpenter (2):
      scsi: target: configfs: Delete unnecessary checks for NULL
      scsi: qla2xxx: edif: Fix off by one bug in qla_edif_app_getfcinfo()

Ewan D. Milne (2):
      scsi: core: Simplify control flow in scmd_eh_abort_handler()
      scsi: qla2xxx: Fix mailbox direction flags in qla2xxx_get_adapter_id()

Florian Fainelli (3):
      scsi: qla4xxx: Format SYSFS_FLAG_FW_SEL_BOOT as byte
      scsi: qedi: Fix SYSFS_FLAG_FW_SEL_BOOT formatting
      scsi: qedi: Remove set but unused 'page' variable

Geert Uytterhoeven (2):
      scsi: ufs: Fix double space in SCSI_UFS_HWMON description
      scsi: ufs: Wrap Universal Flash Storage drivers in SCSI_UFSHCD

George Kennedy (2):
      scsi: scsi_debug: Sanity check block descriptor length in resp_mode_select()
      scsi: scsi_debug: Fix type in min_t to avoid stack OOB

Hannes Reinecke (1):
      scsi: qla2xxx: Synchronize rport dev_loss_tmo setting

Igor Pylypiv (5):
      scsi: pm80xx: Do not call scsi_remove_host() in pm8001_alloc()
      scsi: pm80xx: Use bitmap_zalloc() for tags bitmap allocation
      scsi: pm80xx: Update WARN_ON check in pm8001_mpi_build_cmd()
      scsi: pm80xx: Do not check the address-of value for NULL
      scsi: pm80xx: Apply byte mask for phy ID in mpi_phy_start_resp()

James Smart (10):
      scsi: lpfc: Update lpfc version to 14.0.0.4
      scsi: lpfc: Add additional debugfs support for CMF
      scsi: lpfc: Cap CMF read bytes to MBPI
      scsi: lpfc: Adjust CMF total bytes and rxmonitor
      scsi: lpfc: Trigger SLI4 firmware dump before doing driver cleanup
      scsi: lpfc: Fix NPIV port deletion crash
      scsi: lpfc: Fix lpfc_force_rscn ndlp kref imbalance
      scsi: lpfc: Change return code on I/Os received during link bounce
      scsi: lpfc: Fix leaked lpfc_dmabuf mbox allocations with NPIV
      scsi: lpfc: Fix non-recovery of remote ports following an unsolicited LOGO

John Garry (7):
      scsi: Revert "scsi: hisi_sas: Filter out new PHY up events during suspend"
      scsi: libsas: Don't always drain event workqueue for HA resume
      scsi: libsas: Decode SAM status and host byte codes
      scsi: hisi_sas: Factor out task prep and delivery code
      scsi: hisi_sas: Pass abort structure for internal abort
      scsi: hisi_sas: Make internal abort have no task proto
      scsi: hisi_sas: Start delivery hisi_sas_task_exec() directly

Kees Cook (2):
      scsi: lpfc: Use struct_group to isolate cast to larger object
      scsi: lpfc: Use struct_group() to initialize struct lpfc_cgn_info

Manish Rangankar (1):
      scsi: qedi: Fix cmd_cleanup_cmpl counter mismatch issue

Mike Christie (4):
      scsi: core: sysfs: Fix setting device state to SDEV_RUNNING
      scsi: target: core: Use RCU helpers for INQUIRY t10_alua_tg_pt_gp
      scsi: core: sysfs: Fix hang when device state is set via sysfs
      scsi: iscsi: Unblock session then wake up error handler

Niklas Cassel (2):
      scsi: sd_zbc: Clean up sd_zbc_parse_report() setting of wp
      scsi: sd_zbc: Simplify zone full condition check

Qi Liu (3):
      scsi: hisi_sas: Fix phyup timeout on FPGA
      scsi: hisi_sas: Prevent parallel FLR and controller reset
      scsi: hisi_sas: Prevent parallel controller reset and control phy command

Roman Bolshakov (1):
      scsi: qla2xxx: Format log strings only if needed

Sebastian Andrzej Siewior (1):
      scsi: be2iscsi: Remove maintainers

Shin'ichiro Kawasaki (2):
      scsi: scsi_debug: Fix buffer size of REPORT ZONES command
      scsi: scsi_debug: Zero clear zones at reset write pointer

Sreekanth Reddy (28):
      scsi: mpi3mr: Bump driver version to 8.0.0.61.0
      scsi: mpi3mr: Fixes around reply request queues
      scsi: mpi3mr: Enhanced Task Management Support Reply handling
      scsi: mpi3mr: Use TM response codes from MPI3 headers
      scsi: mpi3mr: Add io_uring interface support in I/O-polled mode
      scsi: mpi3mr: Print cable mngnt and temp threshold events
      scsi: mpi3mr: Support Prepare for Reset event
      scsi: mpi3mr: Add Event acknowledgment logic
      scsi: mpi3mr: Gracefully handle online FW update operation
      scsi: mpi3mr: Detect async reset that occurred in firmware
      scsi: mpi3mr: Add IOC reinit function
      scsi: mpi3mr: Handle offline FW activation in graceful manner
      scsi: mpi3mr: Code refactor of IOC init - part2
      scsi: mpi3mr: Code refactor of IOC init - part1
      scsi: mpi3mr: Fault IOC when internal command gets timeout
      scsi: mpi3mr: Display IOC firmware package version
      scsi: mpi3mr: Handle unaligned PLL in unmap cmnds
      scsi: mpi3mr: Increase internal cmnds timeout to 60s
      scsi: mpi3mr: Do access status validation before adding devices
      scsi: mpi3mr: Add support for PCIe Managed Switch SES device
      scsi: mpi3mr: Update MPI3 headers - part2
      scsi: mpi3mr: Update MPI3 headers - part1
      scsi: mpi3mr: Don't reset IOC if cmnds flush with reset status
      scsi: mpi3mr: Replace spin_lock() with spin_lock_irqsave()
      scsi: mpi3mr: Add debug APIs based on logging_level bits
      scsi: mpt3sas: Fix incorrect system timestamp
      scsi: mpt3sas: Fix system going into read-only mode
      scsi: mpt3sas: Fix kernel panic during drive powercycle test

Xiang Chen (12):
      scsi: hisi_sas: Use autosuspend for the host controller
      scsi: libsas: Keep host active while processing events
      scsi: hisi_sas: Keep controller active between ISR of phyup and the event being processed
      scsi: libsas: Defer works of new phys during suspend
      scsi: libsas: Refactor sas_queue_deferred_work()
      scsi: libsas: Add flag SAS_HA_RESUMING
      scsi: libsas: Resume host while sending SMP I/Os
      scsi: hisi_sas: Add more logs for runtime suspend/resume
      scsi: libsas: Insert PORTE_BROADCAST_RCVD event for resuming host
      scsi: mvsas: Add spin_lock/unlock() to protect asd_sas_port->phy_list
      scsi: hisi_sas: Fix some issues related to asd_sas_port->phy_list
      scsi: libsas: Add spin_lock/unlock() to protect asd_sas_port->phy_list

Ye Guojin (1):
      scsi: ufs: ufs-mediatek: Add put_device() after of_find_device_by_node()

And the diffstat:

 MAINTAINERS                                  |    2 -
 block/blk-pm.c                               |   22 +-
 drivers/message/fusion/mptbase.c             |    6 +-
 drivers/scsi/a100u2w.c                       |    2 -
 drivers/scsi/atp870u.c                       |    1 -
 drivers/scsi/bfa/bfad_attr.c                 |    2 +-
 drivers/scsi/ch.c                            |    6 +-
 drivers/scsi/dc395x.c                        |    3 +-
 drivers/scsi/elx/efct/efct_driver.c          |    2 +-
 drivers/scsi/elx/efct/efct_hw.c              |   10 +-
 drivers/scsi/elx/efct/efct_io.c              |    2 +-
 drivers/scsi/elx/libefc/efc_cmds.c           |    4 +-
 drivers/scsi/elx/libefc/efc_els.c            |    4 +-
 drivers/scsi/elx/libefc_sli/sli4.c           |   14 +-
 drivers/scsi/hisi_sas/hisi_sas.h             |    7 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c        |  396 ++++---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c       |   35 +-
 drivers/scsi/hosts.c                         |   15 +-
 drivers/scsi/hpsa.c                          |    2 -
 drivers/scsi/initio.c                        |    5 +-
 drivers/scsi/libsas/sas_discover.c           |    1 -
 drivers/scsi/libsas/sas_event.c              |   77 +-
 drivers/scsi/libsas/sas_expander.c           |    3 +
 drivers/scsi/libsas/sas_init.c               |   49 +-
 drivers/scsi/libsas/sas_internal.h           |    2 +
 drivers/scsi/libsas/sas_scsi_host.c          |    7 +-
 drivers/scsi/lpfc/lpfc.h                     |   97 +-
 drivers/scsi/lpfc/lpfc_attr.c                |   62 +-
 drivers/scsi/lpfc/lpfc_debugfs.c             |   27 +-
 drivers/scsi/lpfc/lpfc_debugfs.h             |    2 +-
 drivers/scsi/lpfc/lpfc_els.c                 |   31 +-
 drivers/scsi/lpfc/lpfc_hbadisc.c             |   10 +-
 drivers/scsi/lpfc/lpfc_hw.h                  |   29 +-
 drivers/scsi/lpfc/lpfc_init.c                |   41 +-
 drivers/scsi/lpfc/lpfc_nportdisc.c           |    6 +
 drivers/scsi/lpfc/lpfc_scsi.c                |    8 +-
 drivers/scsi/lpfc/lpfc_sli.c                 |   38 +-
 drivers/scsi/lpfc/lpfc_version.h             |    2 +-
 drivers/scsi/lpfc/lpfc_vport.c               |   83 +-
 drivers/scsi/megaraid/megaraid_mbox.c        |    1 -
 drivers/scsi/mpi3mr/mpi/mpi30_cnfg.h         |  603 +++++++++--
 drivers/scsi/mpi3mr/mpi/mpi30_image.h        |   59 +-
 drivers/scsi/mpi3mr/mpi/mpi30_init.h         |   15 +-
 drivers/scsi/mpi3mr/mpi/mpi30_ioc.h          |  128 ++-
 drivers/scsi/mpi3mr/mpi/mpi30_pci.h          |   44 +
 drivers/scsi/mpi3mr/mpi/mpi30_sas.h          |   14 +
 drivers/scsi/mpi3mr/mpi/mpi30_transport.h    |   31 +-
 drivers/scsi/mpi3mr/mpi3mr.h                 |  126 ++-
 drivers/scsi/mpi3mr/mpi3mr_debug.h           |  133 ++-
 drivers/scsi/mpi3mr/mpi3mr_fw.c              | 1451 +++++++++++++++++---------
 drivers/scsi/mpi3mr/mpi3mr_os.c              |  771 +++++++++++---
 drivers/scsi/mpt3sas/mpt3sas_base.c          |    4 +-
 drivers/scsi/mpt3sas/mpt3sas_base.h          |    4 +
 drivers/scsi/mpt3sas/mpt3sas_scsih.c         |   59 +-
 drivers/scsi/mvsas/mv_sas.c                  |    5 +
 drivers/scsi/myrb.c                          |    2 +-
 drivers/scsi/myrs.c                          |   10 +-
 drivers/scsi/pm8001/Makefile                 |    7 +-
 drivers/scsi/pm8001/pm8001_ctl.c             |   24 +-
 drivers/scsi/pm8001/pm8001_hwi.c             |   33 +-
 drivers/scsi/pm8001/pm8001_init.c            |   10 +-
 drivers/scsi/pm8001/pm8001_sas.c             |   16 +
 drivers/scsi/pm8001/pm80xx_hwi.c             |   38 +-
 drivers/scsi/pm8001/pm80xx_tracepoints.c     |   10 +
 drivers/scsi/pm8001/pm80xx_tracepoints.h     |  113 ++
 drivers/scsi/pmcraid.c                       |    5 +-
 drivers/scsi/qedi/qedi_fw.c                  |   37 +-
 drivers/scsi/qedi/qedi_iscsi.c               |    2 +-
 drivers/scsi/qedi/qedi_iscsi.h               |    2 +-
 drivers/scsi/qedi/qedi_main.c                |    8 +-
 drivers/scsi/qla2xxx/qla_attr.c              |    6 +
 drivers/scsi/qla2xxx/qla_dbg.c               |    3 +
 drivers/scsi/qla2xxx/qla_edif.c              |    2 +-
 drivers/scsi/qla2xxx/qla_init.c              |   10 +-
 drivers/scsi/qla2xxx/qla_mbx.c               |    6 +-
 drivers/scsi/qla2xxx/qla_nvme.c              |    5 +-
 drivers/scsi/qla4xxx/ql4_os.c                |    4 +-
 drivers/scsi/scsi.c                          |    5 +-
 drivers/scsi/scsi_debug.c                    |   45 +-
 drivers/scsi/scsi_debugfs.c                  |    1 +
 drivers/scsi/scsi_error.c                    |  112 +-
 drivers/scsi/scsi_pm.c                       |    3 +-
 drivers/scsi/scsi_priv.h                     |    3 +-
 drivers/scsi/scsi_scan.c                     |    4 +-
 drivers/scsi/scsi_sysfs.c                    |   37 +-
 drivers/scsi/scsi_transport_iscsi.c          |    6 +-
 drivers/scsi/sd.c                            |    1 -
 drivers/scsi/sd_zbc.c                        |    6 +-
 drivers/scsi/snic/snic_disc.c                |    2 +-
 drivers/scsi/sr.c                            |    2 +-
 drivers/scsi/sr_vendor.c                     |    4 +-
 drivers/scsi/ufs/Kconfig                     |   15 +-
 drivers/scsi/ufs/tc-dwc-g210-pci.c           |    1 -
 drivers/scsi/ufs/ufs-exynos.c                |    4 +-
 drivers/scsi/ufs/ufs-hisi.c                  |    8 +-
 drivers/scsi/ufs/ufs-mediatek.c              |    1 +
 drivers/scsi/ufs/ufshcd-pci.c                |   20 +-
 drivers/scsi/ufs/ufshcd-pltfrm.c             |    2 -
 drivers/scsi/ufs/ufshcd.c                    |  354 ++++---
 drivers/scsi/ufs/ufshcd.h                    |   20 +-
 drivers/scsi/ufs/ufshpb.c                    |    3 +-
 drivers/target/target_core_fabric_configfs.c |   16 +-
 drivers/target/target_core_spc.c             |   14 +-
 include/linux/blk-pm.h                       |    2 +-
 include/scsi/libsas.h                        |    2 +
 include/scsi/scsi_host.h                     |    6 -
 106 files changed, 3889 insertions(+), 1726 deletions(-)
 create mode 100644 drivers/scsi/mpi3mr/mpi/mpi30_pci.h
 create mode 100644 drivers/scsi/pm8001/pm80xx_tracepoints.c
 create mode 100644 drivers/scsi/pm8001/pm80xx_tracepoints.h

James


