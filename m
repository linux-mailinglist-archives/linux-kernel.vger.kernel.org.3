Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2823A589E70
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 17:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238986AbiHDPOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 11:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbiHDPOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 11:14:15 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C15212E;
        Thu,  4 Aug 2022 08:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1659626052;
        bh=CK00+RmMLUmbOSy7NG+lnz7dM/464so90/QBHs9RGKY=;
        h=Message-ID:Subject:From:To:Date:From;
        b=gNBAPahg+t6yUV0GlefKc35sfutKC85ZfKTS/JGA1/gge8ouolpA1mHOi0KM5EUbv
         S0i8WhGpypJ4DJZisVG5Byp7MRpBdw+f9v6jPoCE2O3NN7awSQgfAaM3gBpRA5suiH
         ATfQCLgDsDT3FC1oiL3fL0fZASiU7AKyOoOXGC50=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DD3C01280224;
        Thu,  4 Aug 2022 11:14:12 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jffIsxv9UwCs; Thu,  4 Aug 2022 11:14:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1659626052;
        bh=CK00+RmMLUmbOSy7NG+lnz7dM/464so90/QBHs9RGKY=;
        h=Message-ID:Subject:From:To:Date:From;
        b=gNBAPahg+t6yUV0GlefKc35sfutKC85ZfKTS/JGA1/gge8ouolpA1mHOi0KM5EUbv
         S0i8WhGpypJ4DJZisVG5Byp7MRpBdw+f9v6jPoCE2O3NN7awSQgfAaM3gBpRA5suiH
         ATfQCLgDsDT3FC1oiL3fL0fZASiU7AKyOoOXGC50=
Received: from lingrow.int.hansenpartnership.com (c-67-166-174-65.hsd1.va.comcast.net [67.166.174.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4D5CA12801F3;
        Thu,  4 Aug 2022 11:14:12 -0400 (EDT)
Message-ID: <e8b94928dcadff82e7b7eabb80f75ed12fc1a394.camel@HansenPartnership.com>
Subject: [GIT PULL] first round of SCSI updates for the 5.19+ merge window
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 04 Aug 2022 11:14:10 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates to the usual drivers (ufs, qla2xx, target, lpfc, smartpqi,
mpi3mr).  The main driver change that might cause issues on down the
road is the conversion of some of our oldest surviving drivers to the
DMA API (should only affect m68k).  The only major core change is the
rework of async resume; the rest are either completely trivial or for
updating deprecated APIs.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

The short changelog is:

Alice Chao (1):
      scsi: ufs: ufs-mediatek: Fix invalid access to vccqx

Alim Akhtar (6):
      scsi: ufs: Rearrange addresses in increasing order
      scsi: ufs: host: ufs-exynos: Use already existing definition
      scsi: ufs: host: ufs-exynos: Remove unused defines
      scsi: ufs: host: ufs-exynos: Add support for FSD UFS HCI
      scsi: ufs: host: ufs-exynos: Add mphy apb clock mask
      scsi: dt-bindings: ufs: exynos-ufs: Add FSD compatible

Arnd Bergmann (2):
      scsi: dpt_i2o: Remove obsolete driver
      scsi: BusLogic: Remove bus_to_virt()

Arun Easi (8):
      scsi: qla2xxx: Fix discovery issues in FC-AL topology
      scsi: qla2xxx: Fix response queue handler reading stale packets
      scsi: qla2xxx: Fix losing FCP-2 targets on long port disable with I/Os
      scsi: qla2xxx: Add debug prints in the device remove path
      scsi: qla2xxx: Fix losing target when it reappears during delete
      scsi: qla2xxx: Fix losing FCP-2 targets during port perturbation tests
      scsi: qla2xxx: Fix crash due to stale SRB access around I/O timeouts
      scsi: qla2xxx: Fix excessive I/O error messages by default

Bart Van Assche (2):
      scsi: sd: Rework asynchronous resume support
      scsi: core: Move the definition of SCSI_QUEUE_DELAY

Bikash Hazarika (4):
      scsi: qla2xxx: Update manufacturer details
      scsi: qla2xxx: Zero undefined mailbox IN registers
      scsi: qla2xxx: Fix incorrect display of max frame size
      scsi: qla2xxx: Add a new v2 dport diagnostic feature

Bo Liu (1):
      scsi: core: bsg: Remove usage of the deprecated ida_simple_xxx() API

CC Chou (1):
      scsi: ufs: ufs-mediatek: Introduce workaround for power mode change

ChanWoo Lee (1):
      scsi: ufs: ufs-qcom: Remove unneeded code

Changyuan Lyu (1):
      scsi: trace: Print driver_tag and scheduler_tag in SCSI trace

Chanho Park (1):
      scsi: ufs: ufs-exynos: Change ufs phy control sequence

Colin Ian King (2):
      scsi: ufs: core: Fix spelling mistake "Cannnot" -> "Cannot"
      scsi: fcoe: Remove redundant assignment to variable 'wlen'

Damien Le Moal (3):
      scsi: libsas: Introduce struct smp_rps_resp
      scsi: libsas: Introduce struct smp_rg_resp
      scsi: libsas: Introduce struct smp_disc_resp

Dan Carpenter (3):
      scsi: mpi3mr: Delete a stray tab
      scsi: mpi3mr: Unlock on error path
      scsi: qla2xxx: Check correct variable in qla24xx_async_gffid()

Daniil Lunev (2):
      scsi: ufs: core: Read device property for ref clock
      scsi: ufs: ufs-pci: Enable WriteBooster capability on ADL

Dmitry Bogdanov (8):
      scsi: target: iscsi: Do not require target authentication
      scsi: target: iscsi: Allow AuthMethod=None
      scsi: target: iscsi: Support base64 in CHAP
      scsi: target: iscsi: Add support for extended CDB AHS
      scsi: iscsi: Prefer xmit of DataOut over new commands
      scsi: target: iscsi: Control authentication per ACL
      scsi: target: iscsi: Extract auth functions
      scsi: target: iscsi: Add upcast helpers

Don Brace (2):
      scsi: smartpqi: Update version to 2.1.18-045
      scsi: smartpqi: Update copyright to current year

Gilbert Wu (1):
      scsi: smartpqi: Add controller fw version to console log

James Smart (12):
      scsi: lpfc: Copyright updates for 14.2.0.5 patches
      scsi: lpfc: Update lpfc version to 14.2.0.5
      scsi: lpfc: Remove Menlo/Hornet related code
      scsi: lpfc: Refactor lpfc_nvmet_prep_abort_wqe() into lpfc_sli_prep_abort_xri()
      scsi: lpfc: Revert RSCN_MEMENTO workaround for misbehaved configuration
      scsi: lpfc: Fix lost NVMe paths during LIF bounce stress test
      scsi: lpfc: Fix attempted FA-PWWN usage after feature disable
      scsi: lpfc: Fix possible memory leak when failing to issue CMF WQE
      scsi: lpfc: Remove extra atomic_inc on cmd_pending in queuecommand after VMID
      scsi: lpfc: Set PU field when providing D_ID in XMIT_ELS_RSP64_CX iocb
      scsi: lpfc: Prevent buffer overflow crashes in debugfs with malformed user input
      scsi: lpfc: Fix uninitialized cqe field in lpfc_nvme_cancel_iocb()

Jason Wang (1):
      scsi: megaraid: Remove the static variable initialisation

Jiang Jian (7):
      scsi: zfcp: Drop redundant "the" in the comments
      scsi: sym53c8xx_2: Remove redundant "with"
      scsi: snic: Remove redundant "on"
      scsi: aacraid: Remove redundant "the"
      scsi: target: Remove duplicate "the"
      scsi: message: fusion: Drop redundant "the"
      scsi: hisi_sas: Align comments

Jiapeng Chong (1):
      scsi: megaraid_sas: Clean up some inconsistent indenting

Johan Hovold (1):
      scsi: ufs: dt-bindings: Add SC8280XP binding

John Garry (5):
      scsi: hisi_sas: Call hisi_sas_slave_configure() from slave_configure_v3_hw()
      scsi: pm8001: Expose hardware queues for pm80xx
      scsi: pm8001: Use non-atomic bitmap ops for tag alloc + free
      scsi: pm8001: Set up tags before using them
      scsi: pm8001: Rework shost initial values

Julian Wiedmann (1):
      scsi: zfcp: Declare zfcp_sdev_attrs as static

Junwoo Lee (1):
      scsi: ufs: Skip last hci reset to get valid register values

Justin Stitt (1):
      scsi: target: iscsi: Fix clang -Wformat warnings

Karan Tilak Kumar (1):
      scsi: fnic: Refactor code in fnic probe to initialize SCSI layer

Keoseong Park (1):
      scsi: ufs: core: Remove UIC_HIBERN8_ENTER_RETRIES

Kevin Barnett (4):
      scsi: smartpqi: Add ctrl ready timeout module parameter
      scsi: smartpqi: Update deleting a LUN via sysfs
      scsi: smartpqi: Fix RAID map race condition
      scsi: smartpqi: Stop logging spurious PQI reset failures

Krzysztof Kozlowski (3):
      scsi: ufs: ufshcd: Constify pointed data
      scsi: ufs: ufshcd-pltfrm: Constify pointed data
      scsi: ufs: exynos: Constify driver data

Kumar Meiyappan (1):
      scsi: smartpqi: Add driver support for multi-LUN devices

Li Zhijian (1):
      scsi: core: Shorten long warning messages

Mahesh Rajashekhara (1):
      scsi: smartpqi: Fix DMA direction for RAID requests

Max Gurtovoy (1):
      scsi: iscsi: Make iscsi_unregister_transport() return void

Michael Schmitz (4):
      scsi: gvp11.c: Fix DMA mask calculation error
      scsi: gvp11: Convert m68k WD33C93 drivers to DMA API
      scsi: a2091: Convert m68k WD33C93 drivers to DMA API
      scsi: a3000: Convert m68k WD33C93 drivers to DMA API

Mike Christie (21):
      scsi: target: Remove XDWRITEREAD emulated support
      scsi: target: Detect UNMAP support post configuration
      scsi: target: Add file configure_unmap callout
      scsi: target: Add iblock configure_unmap callout
      scsi: target: Add callout to configure UNMAP settings
      scsi: target: Remove incorrect zero blocks WRITE_SAME check
      scsi: libiscsi: Improve conn_send_pdu API
      scsi: iscsi: Try to avoid taking back_lock in xmit path
      scsi: iscsi: Remove iscsi_get_task back_lock requirement
      scsi: iscsi: Remove unneeded task state check
      scsi: iscsi_tcp: Drop target_alloc use
      scsi: iscsi_tcp: Tell net when there's more data
      scsi: iscsi: Run recv path from workqueue
      scsi: iscsi: Add recv workqueue helpers
      scsi: iscsi: Rename iscsi_conn_queue_work()
      scsi: iscsi: Fix session removal on shutdown
      scsi: qedi: Use QEDI_MODE_NORMAL for error handling
      scsi: iscsi: Add helper to remove a session from the kernel
      scsi: iscsi: Clean up bound endpoints during shutdown
      scsi: iscsi: Allow iscsi_if_stop_conn() to be called from kernel
      scsi: iscsi: Fix HW conn removal use after free

Mike McGowen (5):
      scsi: smartpqi: Add module param to disable managed ints
      scsi: smartpqi: Add PCI IDs for Lenovo controllers
      scsi: smartpqi: Add PCI ID for Adaptec SmartHBA 2100-8i
      scsi: smartpqi: Close write read holes
      scsi: smartpqi: Shorten drive visibility after removal

Murthy Bhat (1):
      scsi: smartpqi: Add PCI IDs for ramaxel controllers

Nilesh Javali (6):
      scsi: qla2xxx: Update version to 10.02.07.800-k
      scsi: qla2xxx: Fix sparse warning for dport_data
      scsi: Revert "scsi: qla2xxx: Fix disk failure to rediscover"
      scsi: qla2xxx: Update version to 10.02.07.700-k
      scsi: qla2xxx: Update version to 10.02.07.600-k
      scsi: qla2xxx: Update version to 10.02.07.500-k

Peter Wang (5):
      scsi: ufs: ufs-mediatek: Support performance boosting
      scsi: ufs: ufs-mediatek: Add stage information for ref-clk control
      scsi: ufs: ufs-mediatek: Prevent host hang by setting CLK_CG early
      scsi: ufs: ufs-mediatek: Always add delays for VCC operations
      scsi: ufs: ufs-mediatek: Support low-power mode for VCCQ

Po-Wen Kao (4):
      scsi: ufs: ufs-mediatek: Support host power control
      scsi: ufs: ufs-mediatek: Disable reset confirm feature by UniPro
      scsi: ufs: ufs-mediatek: Prevent device regulators setting LPM incorrectly
      scsi: ufs: ufs-mediatek: Fix the timing of configuring device regulators

Quinn Tran (24):
      scsi: qla2xxx: Fix imbalance vha->vref_count
      scsi: qla2xxx: edif: Fix dropped IKE message
      scsi: qla2xxx: Fix erroneous mailbox timeout after PCI error injection
      scsi: qla2xxx: Turn off multi-queue for 8G adapters
      scsi: qla2xxx: Wind down adapter after PCIe error
      scsi: qla2xxx: edif: Fix slow session teardown
      scsi: qla2xxx: edif: Reduce N2N thrashing at app_start time
      scsi: qla2xxx: edif: Fix no logout on delete for N2N
      scsi: qla2xxx: edif: Fix session thrash
      scsi: qla2xxx: edif: Tear down session if keys have been removed
      scsi: qla2xxx: edif: Fix no login after app start
      scsi: qla2xxx: edif: Reduce disruption due to multiple app start
      scsi: qla2xxx: edif: Send LOGO for unexpected IKE message
      scsi: qla2xxx: edif: Fix I/O timeout due to over-subscription
      scsi: qla2xxx: edif: Fix n2n login retry for secure device
      scsi: qla2xxx: edif: Fix n2n discovery issue with secure target
      scsi: qla2xxx: edif: Remove old doorbell interface
      scsi: qla2xxx: edif: Add retry for ELS passthrough
      scsi: qla2xxx: edif: Synchronize NPIV deletion with authentication application
      scsi: qla2xxx: edif: Fix potential stuck session in sa update
      scsi: qla2xxx: edif: Add bsg interface to read doorbell events
      scsi: qla2xxx: edif: Wait for app to ack on sess down
      scsi: qla2xxx: edif: bsg refactor
      scsi: qla2xxx: edif: Reduce Initiator-Initiator thrashing

Ren Yu (1):
      scsi: mpt3sas: Fix typo in comment

Ren Zhijie (1):
      scsi: ufs: ufs-mediatek: Fix build error and type mismatch

Sagar Biradar (1):
      scsi: smartpqi: Fix PCI control linkdown system hang

Sreekanth Reddy (4):
      scsi: mpi3mr: Reduce VD queue depth on detecting throttling
      scsi: mpi3mr: Resource Based Metering
      scsi: mpi3mr: Increase cmd_per_lun to 128
      scsi: mpi3mr: Enable shared host tagset

Stanley Chu (8):
      scsi: ufs: ufs-mediatek: Fix build warnings
      scsi: ufs: ufs-mediatek: Disable unused VCCQx power rails
      scsi: ufs: ufs-mediatek: Support multiple VCC sources
      scsi: ufs: Export regulator functions
      scsi: ufs: ufs-mediatek: Support low-power mode for parents of VCCQx
      scsi: ufs: ufs-mediatek: Support flexible parameters for SMC calls
      scsi: ufs: Fix ADAPT logic for HS-G5
      scsi: ufs: Export ufshcd_uic_change_pwr_mode()

Tetsuo Handa (1):
      scsi: mpt3sas: Remove flush_scheduled_work() call

Tony Battersby (1):
      scsi: sg: Allow waiting for commands to complete on removed device

Varun Prakash (1):
      scsi: MAINTAINERS: Update cxgb3i and cxgb4i maintainer

Wolfram Sang (1):
      scsi: ufs: core: Fix typos in error messages

Xiang Chen (3):
      scsi: libsas: Resume SAS host for phy reset or enable via sysfs
      scsi: hisi_sas: Relocate DMA unmap of SMP task
      scsi: hisi_sas: Remove unnecessary variable to hold DMA map elements

Xin Gao (1):
      scsi: ch: Do not initialise statics to 0

Xingui Yang (1):
      scsi: hisi_sas: Modify v3 HW SATA completion error processing

Xiu Jianfeng (1):
      scsi: lpfc: Use memset_startat() helper in lpfc_nvmet_xmt_fcp_op_cmp()

Yang Li (1):
      scsi: target: iscsi: Fix NULL pointer dereference in iscsi_conn_auth_required()

Yoshihiro Shimoda (5):
      scsi: MAINTAINERS: Add maintainer for Renesas UFS driver
      scsi: ufs: ufs-renesas: Add support for Renesas R-Car UFS controller
      scsi: ufs: core: Add UFSHCD_QUIRK_HIBERN_FASTAUTO
      scsi: ufs: core: Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS
      scsi: dt-bindings: ufs: Document Renesas R-Car UFS host controller

Zhang Jiaming (1):
      scsi: mpt3sas: Fix whitespace and spelling mistake

keliu (1):
      scsi: core: iscsi: Directly use ida_alloc()/ida_free()

And the diffstat:

 .../devicetree/bindings/ufs/qcom,ufs.yaml          |    2 +
 .../devicetree/bindings/ufs/renesas,ufs.yaml       |   61 +
 .../bindings/ufs/samsung,exynos-ufs.yaml           |    1 +
 Documentation/scsi/ufs.rst                         |   15 +
 Documentation/userspace-api/ioctl/ioctl-number.rst |    2 +-
 MAINTAINERS                                        |   19 +-
 block/bsg.c                                        |    4 +-
 drivers/infiniband/ulp/iser/iscsi_iser.c           |    4 +-
 drivers/message/fusion/mptspi.c                    |    2 +-
 drivers/s390/scsi/zfcp_diag.h                      |    2 +-
 drivers/s390/scsi/zfcp_sysfs.c                     |    2 +-
 drivers/scsi/BusLogic.c                            |   35 +-
 drivers/scsi/Kconfig                               |   13 +-
 drivers/scsi/Makefile                              |    1 -
 drivers/scsi/a2091.c                               |   63 +-
 drivers/scsi/a3000.c                               |   53 +-
 drivers/scsi/aacraid/aachba.c                      |    2 +-
 drivers/scsi/aic94xx/aic94xx_dev.c                 |    2 +-
 drivers/scsi/be2iscsi/be_main.c                    |   21 +-
 drivers/scsi/bnx2i/bnx2i_iscsi.c                   |    2 +-
 drivers/scsi/ch.c                                  |    2 +-
 drivers/scsi/cxgbi/libcxgbi.c                      |    4 +-
 drivers/scsi/dpt/dpti_i2o.h                        |  441 ---
 drivers/scsi/dpt/dpti_ioctl.h                      |  136 -
 drivers/scsi/dpt/dptsig.h                          |  336 --
 drivers/scsi/dpt/osd_defs.h                        |   79 -
 drivers/scsi/dpt/osd_util.h                        |  358 --
 drivers/scsi/dpt/sys_info.h                        |  417 ---
 drivers/scsi/dpt_i2o.c                             | 3545 --------------------
 drivers/scsi/dpti.h                                |  331 --
 drivers/scsi/fcoe/fcoe.c                           |    1 -
 drivers/scsi/fnic/fnic_main.c                      |   45 +-
 drivers/scsi/gvp11.c                               |   95 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c              |   49 +-
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c             |    2 -
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c             |    6 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c             |   16 +-
 drivers/scsi/hosts.c                               |    4 +-
 drivers/scsi/iscsi_tcp.c                           |   74 +-
 drivers/scsi/iscsi_tcp.h                           |    2 +
 drivers/scsi/libiscsi.c                            |  313 +-
 drivers/scsi/libiscsi_tcp.c                        |    6 +-
 drivers/scsi/libsas/sas_expander.c                 |   67 +-
 drivers/scsi/libsas/sas_init.c                     |    4 +
 drivers/scsi/libsas/sas_internal.h                 |    2 +-
 drivers/scsi/lpfc/lpfc.h                           |   11 +-
 drivers/scsi/lpfc/lpfc_attr.c                      |   27 +-
 drivers/scsi/lpfc/lpfc_bsg.c                       |  324 --
 drivers/scsi/lpfc/lpfc_bsg.h                       |   14 +-
 drivers/scsi/lpfc/lpfc_crtn.h                      |    2 +-
 drivers/scsi/lpfc/lpfc_debugfs.c                   |   22 +-
 drivers/scsi/lpfc/lpfc_els.c                       |   32 +-
 drivers/scsi/lpfc/lpfc_hbadisc.c                   |   60 +-
 drivers/scsi/lpfc/lpfc_hw.h                        |   10 -
 drivers/scsi/lpfc/lpfc_hw4.h                       |    1 -
 drivers/scsi/lpfc/lpfc_ids.h                       |    4 +-
 drivers/scsi/lpfc/lpfc_init.c                      |   19 +-
 drivers/scsi/lpfc/lpfc_nvme.c                      |    1 +
 drivers/scsi/lpfc/lpfc_nvmet.c                     |   54 +-
 drivers/scsi/lpfc/lpfc_scsi.c                      |    1 -
 drivers/scsi/lpfc/lpfc_sli.c                       |   38 +-
 drivers/scsi/lpfc/lpfc_sli.h                       |    1 -
 drivers/scsi/lpfc/lpfc_version.h                   |    2 +-
 drivers/scsi/megaraid/megaraid_mbox.c              |    2 +-
 drivers/scsi/megaraid/megaraid_sas_base.c          |    4 +-
 drivers/scsi/mpi3mr/mpi3mr.h                       |   73 +-
 drivers/scsi/mpi3mr/mpi3mr_fw.c                    |   67 +
 drivers/scsi/mpi3mr/mpi3mr_os.c                    |  291 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c                |    8 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c               |    3 +-
 drivers/scsi/pm8001/pm8001_hwi.c                   |    5 +
 drivers/scsi/pm8001/pm8001_init.c                  |   73 +-
 drivers/scsi/pm8001/pm8001_sas.c                   |   10 +-
 drivers/scsi/pm8001/pm8001_sas.h                   |    3 +
 drivers/scsi/pm8001/pm80xx_hwi.c                   |   46 +-
 drivers/scsi/qedi/qedi_main.c                      |   11 +-
 drivers/scsi/qla2xxx/qla_attr.c                    |   29 +-
 drivers/scsi/qla2xxx/qla_bsg.c                     |   96 +-
 drivers/scsi/qla2xxx/qla_bsg.h                     |   15 +
 drivers/scsi/qla2xxx/qla_dbg.h                     |    2 +-
 drivers/scsi/qla2xxx/qla_def.h                     |   36 +-
 drivers/scsi/qla2xxx/qla_edif.c                    |  585 ++--
 drivers/scsi/qla2xxx/qla_edif.h                    |    7 +-
 drivers/scsi/qla2xxx/qla_edif_bsg.h                |  106 +-
 drivers/scsi/qla2xxx/qla_fw.h                      |    2 +-
 drivers/scsi/qla2xxx/qla_gbl.h                     |   13 +-
 drivers/scsi/qla2xxx/qla_gs.c                      |  131 +-
 drivers/scsi/qla2xxx/qla_init.c                    |   96 +-
 drivers/scsi/qla2xxx/qla_iocb.c                    |    5 +-
 drivers/scsi/qla2xxx/qla_isr.c                     |  138 +-
 drivers/scsi/qla2xxx/qla_mbx.c                     |   67 +-
 drivers/scsi/qla2xxx/qla_mid.c                     |    6 +-
 drivers/scsi/qla2xxx/qla_nvme.c                    |    5 -
 drivers/scsi/qla2xxx/qla_os.c                      |  103 +-
 drivers/scsi/qla2xxx/qla_target.c                  |   35 +-
 drivers/scsi/qla2xxx/qla_version.h                 |    4 +-
 drivers/scsi/scsi_error.c                          |    4 +-
 drivers/scsi/scsi_lib.c                            |   14 +-
 drivers/scsi/scsi_transport_iscsi.c                |   98 +-
 drivers/scsi/sd.c                                  |   84 +-
 drivers/scsi/sd.h                                  |    5 +
 drivers/scsi/sg.c                                  |   53 +-
 drivers/scsi/smartpqi/Kconfig                      |    2 +-
 drivers/scsi/smartpqi/smartpqi.h                   |   27 +-
 drivers/scsi/smartpqi/smartpqi_init.c              |  405 ++-
 drivers/scsi/smartpqi/smartpqi_sas_transport.c     |    2 +-
 drivers/scsi/smartpqi/smartpqi_sis.c               |   11 +-
 drivers/scsi/smartpqi/smartpqi_sis.h               |    4 +-
 drivers/scsi/snic/snic_fwint.h                     |    2 +-
 drivers/scsi/sym53c8xx_2/sym_hipd.c                |    2 +-
 drivers/target/iscsi/iscsi_target.c                |   57 +-
 drivers/target/iscsi/iscsi_target_auth.c           |  122 +-
 drivers/target/iscsi/iscsi_target_configfs.c       |  113 +-
 drivers/target/iscsi/iscsi_target_login.c          |   17 +-
 drivers/target/iscsi/iscsi_target_nego.c           |  160 +-
 drivers/target/iscsi/iscsi_target_nego.h           |    3 +-
 drivers/target/iscsi/iscsi_target_nodeattrib.c     |    1 +
 drivers/target/iscsi/iscsi_target_tpg.c            |    3 +-
 drivers/target/target_core_alua.c                  |    2 +-
 drivers/target/target_core_configfs.c              |   27 +-
 drivers/target/target_core_device.c                |    6 +
 drivers/target/target_core_file.c                  |   37 +-
 drivers/target/target_core_iblock.c                |   13 +-
 drivers/target/target_core_sbc.c                   |   99 -
 drivers/ufs/core/ufshcd-priv.h                     |    6 +-
 drivers/ufs/core/ufshcd.c                          |   86 +-
 drivers/ufs/host/Kconfig                           |   12 +
 drivers/ufs/host/Makefile                          |    1 +
 drivers/ufs/host/ufs-exynos.c                      |  182 +-
 drivers/ufs/host/ufs-exynos.h                      |    1 +
 drivers/ufs/host/ufs-mediatek.c                    |  324 +-
 drivers/ufs/host/ufs-mediatek.h                    |   74 +
 drivers/ufs/host/ufs-qcom.c                        |   23 -
 drivers/ufs/host/ufs-renesas.c                     |  412 +++
 drivers/ufs/host/ufshcd-pci.c                      |    1 +
 drivers/ufs/host/ufshcd-pltfrm.c                   |   15 +-
 drivers/ufs/host/ufshcd-pltfrm.h                   |    6 +-
 include/scsi/libiscsi.h                            |   13 +-
 include/scsi/libsas.h                              |    2 +-
 include/scsi/sas.h                                 |   42 +-
 include/scsi/scsi_transport_iscsi.h                |    3 +-
 include/target/iscsi/iscsi_target_core.h           |   14 +
 include/target/target_core_backend.h               |    1 +
 include/trace/events/scsi.h                        |   35 +-
 include/ufs/ufshcd.h                               |   21 +-
 include/ufs/unipro.h                               |  104 +-
 146 files changed, 4429 insertions(+), 7663 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ufs/renesas,ufs.yaml
 delete mode 100644 drivers/scsi/dpt/dpti_i2o.h
 delete mode 100644 drivers/scsi/dpt/dpti_ioctl.h
 delete mode 100644 drivers/scsi/dpt/dptsig.h
 delete mode 100644 drivers/scsi/dpt/osd_defs.h
 delete mode 100644 drivers/scsi/dpt/osd_util.h
 delete mode 100644 drivers/scsi/dpt/sys_info.h
 delete mode 100644 drivers/scsi/dpt_i2o.c
 delete mode 100644 drivers/scsi/dpti.h
 create mode 100644 drivers/ufs/host/ufs-renesas.c

James


