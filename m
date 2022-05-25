Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C816533566
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 04:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243652AbiEYCim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 22:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243651AbiEYCil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 22:38:41 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500976FA3F
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 19:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1653446316;
        bh=7hgzB9B1FavH2ac+OAibdvQUQeO8owyl2BSghzGS/H0=;
        h=Message-ID:Subject:From:To:Date:From;
        b=dxqjEQ4j4C6g9zgMcjnvdHZle4G2+24FQoaKut3y8IdJogd40IGSrJd/yx0gXmdKZ
         +W4COK+7CiWJcoxVUHOINUaydeMaQOJztdqbfTA6/zKKem4oAJ/5l/w1bQoeD/cdIo
         S8NZE7ciUt5NyZQkUDbpES6s7eoBUb4GFge74ip8=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id AB0361288C38;
        Tue, 24 May 2022 22:38:36 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gwTA5Ga_SlL9; Tue, 24 May 2022 22:38:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1653446316;
        bh=7hgzB9B1FavH2ac+OAibdvQUQeO8owyl2BSghzGS/H0=;
        h=Message-ID:Subject:From:To:Date:From;
        b=dxqjEQ4j4C6g9zgMcjnvdHZle4G2+24FQoaKut3y8IdJogd40IGSrJd/yx0gXmdKZ
         +W4COK+7CiWJcoxVUHOINUaydeMaQOJztdqbfTA6/zKKem4oAJ/5l/w1bQoeD/cdIo
         S8NZE7ciUt5NyZQkUDbpES6s7eoBUb4GFge74ip8=
Received: from [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b] (unknown [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 17FD81288C35;
        Tue, 24 May 2022 22:38:36 -0400 (EDT)
Message-ID: <bd25414c73fae85529568c6f5b88bfdad6df7b97.camel@HansenPartnership.com>
Subject: [GIT PULL] first round of SCSI updates for the 5.18+ merge window
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 24 May 2022 22:38:34 -0400
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

This series consists of a small set of driver updates (lpfc, ufs,
mpt3sas mpi3mr, iscsi target).  Apart from that this is mostly small
fixes with very few core changes (the biggest one being VPD caching.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

The short changelog is:

Alexander Vorwerk (1):
      scsi: message: fusion: Remove unused variable retval

Bart Van Assche (32):
      scsi: scsi_debug: Fix a typo
      scsi: sd: sd_zbc: Introduce struct zoned_disk_info
      scsi: sd: sd_zbc: Verify that the zone size is a power of two
      scsi: sd: sd_zbc: Improve source code documentation
      scsi: ufs: Move the ufs_is_valid_unit_desc_lun() definition
      scsi: ufs: Move the struct ufs_ref_clk definition
      scsi: ufs: Split the ufshcd.h header file
      scsi: ufs: Minimize #include directives
      scsi: ufs: Fix kernel-doc syntax in ufshcd.h
      scsi: ufs: Remove unnecessary ufshcd-crypto.h include directives
      scsi: ufs: qcom: Fix ufs_qcom_resume()
      scsi: ufs: Introduce ufshcd_clkgate_delay_set()
      scsi: ufs: Remove locking from around single register writes
      scsi: ufs: Remove the TRUE and FALSE definitions
      scsi: ufs: Remove paths from source code comments
      scsi: ufs: Use an SPDX license identifier in the Kconfig file
      scsi: ufs: Rename sdev_ufs_device into ufs_device_wlun
      scsi: ufs: Remove the driver version
      scsi: ufs: Make the config_scaling_param calls type safe
      scsi: ufs: Switch to aggregate initialization
      scsi: ufs: Remove unused constants and code
      scsi: ufs: Invert the return value of ufshcd_is_hba_active()
      scsi: ufs: Declare the quirks array const
      scsi: ufs: Rename struct ufs_dev_fix into ufs_dev_quirk
      scsi: ufs: Remove the UFS_FIX() and END_FIX() macros
      scsi: ufs: Use get_unaligned_be16() instead of be16_to_cpup()
      scsi: ufs: Remove ufshcd_lrb.sense_buffer
      scsi: ufs: Remove ufshcd_lrb.sense_bufflen
      scsi: ufs: Simplify statements that return a boolean
      scsi: ufs: Remove superfluous boolean conversions
      scsi: ufs: Declare ufshcd_wait_for_register() static
      scsi: ufs: Fix a spelling error in a source code comment

Bean Huo (6):
      scsi: ufs: ufshpb: Clean up ufshpb_suspend()/resume()
      scsi: ufs: ufshpb: Add handing of device reset regions in HPB device mode
      scsi: ufs: ufshpb: Change sysfs node hpb_stats/rb_* prefix to start with rcmd_*
      scsi: ufs: ufshpb: Clean up the handler when device resets HPB information
      scsi: ufs: ufshpb: Remove enum initialization value
      scsi: ufs: ufshpb: Merge ufshpb_reset() and ufshpb_reset_host()

Bodo Stroesser (1):
      scsi: target: tcmu: Avoid holding XArray lock when calling lock_page

Borislav Petkov (1):
      scsi: aacraid: Fix undefined behavior due to shift overflowing the constant

Changcheng Deng (1):
      scsi: lpfc: Remove unneeded variable

Christophe JAILLET (1):
      scsi: vmw_pvscsi: No need to clear memory after a dma_alloc_coherent() call

Colin Ian King (1):
      scsi: qedf: Remove redundant variable op

Damien Le Moal (10):
      scsi: scsi_debug: Add gap zone support
      scsi: scsi_debug: Rename zone type constants
      scsi: sd: sd_zbc: Hide gap zones
      scsi: sd: sd_zbc: Return early in sd_zbc_check_zoned_characteristics()
      scsi: sd: sd_zbc: Use logical blocks as unit when querying zones
      scsi: mpt3sas: Fix adapter replyPostRegisterIndex declaration
      scsi: mpt3sas: Fix event callback log_code value handling
      scsi: mpt3sas: Fix ioc->base_readl() use
      scsi: mpt3sas: Fix writel() use
      scsi: mpt3sas: Fix _ctl_set_task_mid() TaskMID check

Dan Carpenter (3):
      scsi: mpi3mr: Return error if dma_alloc_coherent() fails
      scsi: mpi3mr: Fix a NULL vs IS_ERR() bug in mpi3mr_bsg_init()
      scsi: iscsi: Fix harmless double shift bug

Davidlohr Bueso (2):
      scsi: libfc: Remove get_cpu() semantics in fc_exch_em_alloc()
      scsi: fcoe: Add a local_lock to fcoe_percpu

Enze Li (1):
      scsi: sr: Add memory allocation failure handling for get_capabilities()

Gleb Chesnokov (1):
      scsi: qla2xxx: Remove free_sg command flag

Guo Zhengkui (1):
      scsi: qla2xxx: edif: Remove unneeded variable

Haowen Bai (9):
      scsi: elx: efct: Remove NULL check after calling container_of()
      scsi: dpt_i2o: Drop redundant spinlock initialization
      scsi: qedf: Remove unnecessary code
      scsi: qla4xxx: Drop redundant memset()
      scsi: ipr: Directly return instead of using local ret variable
      scsi: aha1542: Remove unneeded semicolon
      scsi: bfa: Remove redundant NULL check
      scsi: fnic: Remove redundant NULL check
      scsi: mac53c94: Fix warning comparing pointer to 0

Harshit Mogalapalli (2):
      scsi: elx: efct: Remove redundant memset() statement
      scsi: megaraid_sas: Remove redundant memset() statement

James Smart (42):
      scsi: lpfc: Update lpfc version to 14.2.0.3
      scsi: lpfc: Use sg_dma_address() and sg_dma_len() macros for NVMe I/O
      scsi: lpfc: Alter FPIN stat accounting logic
      scsi: lpfc: Rework FDMI initialization after link up
      scsi: lpfc: Change VMID registration to be based on fabric parameters
      scsi: lpfc: Decrement outstanding gidft_inp counter if lpfc_err_lost_link()
      scsi: lpfc: Use list_for_each_entry_safe() in rscn_recovery_check()
      scsi: lpfc: Fix dmabuf ptr assignment in lpfc_ct_reject_event()
      scsi: lpfc: Inhibit aborts if external loopback plug is inserted
      scsi: lpfc: Fix ndlp put following a LOGO completion
      scsi: lpfc: Fill in missing ndlp kref puts in error paths
      scsi: lpfc: Fix element offset in __lpfc_sli_release_iocbq_s4()
      scsi: lpfc: Remove redundant lpfc_sli_prep_wqe() call
      scsi: lpfc: Fix additional reference counting in lpfc_bsg_rport_els()
      scsi: lpfc: Fix resource leak in lpfc_sli4_send_seq_to_ulp()
      scsi: lpfc: Remove unnecessary null ndlp check in lpfc_sli_prep_wqe()
      scsi: lpfc: Copyright updates for 14.2.0.2 patches
      scsi: lpfc: Update lpfc version to 14.2.0.2
      scsi: lpfc: Expand setting ELS_ID field in ELS_REQUEST64_WQE
      scsi: lpfc: Update stat accounting for READ_STATUS mbox command
      scsi: lpfc: Change FA-PWWN detection methodology
      scsi: lpfc: Refactor cleanup of mailbox commands
      scsi: lpfc: Fix field overload in lpfc_iocbq data structure
      scsi: lpfc: Introduce FC_RSCN_MEMENTO flag for tracking post RSCN completion
      scsi: lpfc: Register for Application Services FC-4 type in Fabric topology
      scsi: lpfc: Remove false FDMI NVMe FC-4 support for NPIV ports
      scsi: lpfc: Revise FDMI reporting of supported port speed for trunk groups
      scsi: lpfc: Fix call trace observed during I/O with CMF enabled
      scsi: lpfc: Correct CRC32 calculation for congestion stats
      scsi: lpfc: Move MI module parameter check to handle dynamic disable
      scsi: lpfc: Remove unnecessary NULL pointer assignment for ELS_RDF path
      scsi: lpfc: Transition to NPR state upon LOGO cmpl if link down or aborted
      scsi: lpfc: Update fc_prli_sent outstanding only after guaranteed IOCB submit
      scsi: lpfc: Protect memory leak for NPIV ports sending PLOGI_RJT
      scsi: lpfc: Fix null pointer dereference after failing to issue FLOGI and PLOGI
      scsi: lpfc: Clear fabric topology flag before initiating a new FLOGI
      scsi: lpfc: Fix SCSI I/O completion and abort handler deadlock
      scsi: lpfc: Requeue SCSI I/O to upper layer when fw reports link down
      scsi: lpfc: Zero SLI4 fcp_cmnd buffer's fcpCntl0 field
      scsi: lpfc: Fix diagnostic fw logging after a function reset
      scsi: lpfc: Move cfg_log_verbose check before calling lpfc_dmp_dbg()
      scsi: lpfc: Tweak message log categories for ELS/FDMI/NVMe rescan

Jiapeng Chong (1):
      scsi: pmcraid: Remove unneeded semicolon

John Garry (5):
      scsi: hisi_sas: Fix memory ordering in hisi_sas_task_deliver()
      scsi: hisi_sas: Fix rescan after deleting a disk
      scsi: hisi_sas: Use sas_ata_wait_after_reset() in IT nexus reset
      scsi: libsas: Refactor sas_ata_hard_reset()
      scsi: core: Refine how we set tag_set NUMA node

Karan Tilak Kumar (1):
      scsi: fnic: Replace DMA mask of 64 bits with 47 bits

Kiwoong Kim (1):
      scsi: ufs: core: Exclude UECxx from SFR dump list

Konstantin Shelekhin (1):
      scsi: target: core: Silence the message about unknown VPD pages

Konstantin Vyshetsky (1):
      scsi: ufs: core: Increase fDeviceInit poll frequency

Krzysztof Kozlowski (1):
      scsi: ufs: ufshcd-pltfrm: Simplify pdev->dev usage

Lv Ruyi (1):
      scsi: megaraid: Fix error check return value of register_chrdev()

Manivannan Sadhasivam (5):
      scsi: ufs: qcom: Enable RPM_AUTOSUSPEND for runtime PM
      scsi: ufs: core: Remove redundant wmb() in ufshcd_send_command()
      scsi: ufs: qcom: Add a readl() to make sure ref_clk gets enabled
      scsi: ufs: qcom: Simplify handling of devm_phy_get()
      scsi: ufs: qcom: Fix acquiring the optional reset control line

Martin K. Petersen (9):
      scsi: sd: Reorganize DIF/DIX code to avoid calling revalidate twice
      scsi: sd: Optimal I/O size should be a multiple of reported granularity
      scsi: sd: Switch to using scsi_device VPD pages
      scsi: sd: Use cached ATA Information VPD page
      scsi: core: Do not truncate INQUIRY data on modern devices
      scsi: core: Cache VPD pages b0, b1, b2
      scsi: core: Pick suitable allocation length in scsi_report_opcode()
      scsi: core: Query VPD size before getting full page
      scsi: mpt3sas: Use cached ATA Information VPD page

Maurizio Lombardi (1):
      scsi: target: Allow changing dbroot if there are no registered devices

Max Gurtovoy (3):
      scsi: target: iscsi: Rename iscsi_session to iscsit_session
      scsi: target: iscsi: Rename iscsi_conn to iscsit_conn
      scsi: target: iscsi: Rename iscsi_cmd to iscsit_cmd

Minghao Chi (2):
      scsi: ipr: Use kobj_to_dev()
      scsi: ufs: Use pm_runtime_resume_and_get() instead of pm_runtime_get_sync()

Po-Wen Kao (1):
      scsi: ufs: core: Remove redundant HPB unmap

Sebastian Andrzej Siewior (2):
      scsi: bnx2fc: Avoid using get_cpu() in bnx2fc_cmd_alloc()
      scsi: fcoe: Use per-CPU API to update per-CPU statistics

Sreekanth Reddy (7):
      scsi: mpi3mr: Add target device related sysfs attributes
      scsi: mpi3mr: Add shost related sysfs attributes
      scsi: mpt3sas: Update driver version to 42.100.00.00
      scsi: mpt3sas: Fix junk chars displayed while printing ChipName
      scsi: mpi3mr: Return I/Os to an unrecoverable HBA with DID_ERROR
      scsi: mpi3mr: Hidden drives not removed during soft reset
      scsi: mpi3mr: Increase I/O timeout value to 60s

Sumit Saxena (9):
      scsi: mpi3mr: Update driver version to 8.0.0.69.0
      scsi: mpi3mr: Add support for NVMe passthrough
      scsi: mpi3mr: Expose adapter state to sysfs
      scsi: mpi3mr: Add support for PEL commands
      scsi: mpi3mr: Add support for MPT commands
      scsi: mpi3mr: Move data structures/definitions from MPI headers to uapi header
      scsi: mpi3mr: Add support for driver commands
      scsi: mpi3mr: Add bsg device support
      scsi: core: Increase max device queue_depth to 4096

Wan Jiabing (3):
      scsi: ufs: core: Remove duplicate include in ufshcd
      scsi: elx: efct: Remove unnecessary memset() in efct_io()
      scsi: megaraid_sas: Remove unnecessary memset

Xiang Chen (1):
      scsi: hisi_sas: Undo RPM resume for failed notify phy event for v3 HW

Xiaoguang Wang (1):
      scsi: target: tcmu: Fix possible data corruption

Xiaomeng Tong (2):
      scsi: dc395x: Fix a missing check on list iterator
      scsi: qedf: Remove an unneeded NULL check on list iterator

Yihao Han (1):
      scsi: fcoe: Simplify if-if to if-else

ran jianping (3):
      scsi: fnic: Remove unneeded flush_workqueue()
      scsi: qla2xxx: Remove unneeded flush_workqueue()
      scsi: bfa: Remove unneeded flush_workqueue()


And the diffstat:

 Documentation/ABI/testing/sysfs-driver-ufs        |   18 +-
 drivers/infiniband/ulp/isert/ib_isert.c           |  104 +-
 drivers/infiniband/ulp/isert/ib_isert.h           |    4 +-
 drivers/message/fusion/mptctl.c                   |    3 -
 drivers/scsi/aacraid/aacraid.h                    |    2 +-
 drivers/scsi/aha1542.c                            |   20 +-
 drivers/scsi/bfa/bfad_debugfs.c                   |    3 +-
 drivers/scsi/bfa/bfad_im.c                        |    1 -
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                 |   22 +-
 drivers/scsi/bnx2fc/bnx2fc_io.c                   |   17 +-
 drivers/scsi/dc395x.c                             |   15 +-
 drivers/scsi/dpt_i2o.c                            |    1 -
 drivers/scsi/elx/efct/efct_hw.c                   |    1 -
 drivers/scsi/elx/efct/efct_io.c                   |    1 -
 drivers/scsi/elx/efct/efct_lio.c                  |    3 -
 drivers/scsi/fcoe/fcoe.c                          |   44 +-
 drivers/scsi/fcoe/fcoe_ctlr.c                     |   26 +-
 drivers/scsi/fcoe/fcoe_transport.c                |    6 +-
 drivers/scsi/fnic/fnic.h                          |    2 +-
 drivers/scsi/fnic/fnic_debugfs.c                  |    3 +-
 drivers/scsi/fnic/fnic_main.c                     |   10 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c             |   68 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c            |   10 +-
 drivers/scsi/hosts.c                              |    8 +-
 drivers/scsi/ipr.c                                |   13 +-
 drivers/scsi/libfc/fc_exch.c                      |    3 +-
 drivers/scsi/libfc/fc_fcp.c                       |   29 +-
 drivers/scsi/libfc/fc_lport.c                     |   30 +-
 drivers/scsi/libsas/sas_ata.c                     |   41 +-
 drivers/scsi/lpfc/lpfc.h                          |   10 +-
 drivers/scsi/lpfc/lpfc_attr.c                     |   55 +-
 drivers/scsi/lpfc/lpfc_bsg.c                      |   81 +-
 drivers/scsi/lpfc/lpfc_crtn.h                     |    5 +-
 drivers/scsi/lpfc/lpfc_ct.c                       |  366 ++--
 drivers/scsi/lpfc/lpfc_els.c                      |  715 ++++----
 drivers/scsi/lpfc/lpfc_hbadisc.c                  |  164 +-
 drivers/scsi/lpfc/lpfc_hw.h                       |   75 +-
 drivers/scsi/lpfc/lpfc_hw4.h                      |   17 +-
 drivers/scsi/lpfc/lpfc_init.c                     |  274 ++-
 drivers/scsi/lpfc/lpfc_logmsg.h                   |    8 +-
 drivers/scsi/lpfc/lpfc_mbox.c                     |  203 ++-
 drivers/scsi/lpfc/lpfc_nportdisc.c                |   79 +-
 drivers/scsi/lpfc/lpfc_nvme.c                     |   44 +-
 drivers/scsi/lpfc/lpfc_nvmet.c                    |   73 +-
 drivers/scsi/lpfc/lpfc_scsi.c                     |   72 +-
 drivers/scsi/lpfc/lpfc_sli.c                      |  270 ++-
 drivers/scsi/lpfc/lpfc_sli.h                      |   34 +-
 drivers/scsi/lpfc/lpfc_sli4.h                     |    3 +
 drivers/scsi/lpfc/lpfc_version.h                  |    2 +-
 drivers/scsi/lpfc/lpfc_vport.c                    |   31 +-
 drivers/scsi/mac53c94.c                           |    2 +-
 drivers/scsi/megaraid.c                           |    2 +-
 drivers/scsi/megaraid/megaraid_sas_base.c         |    2 -
 drivers/scsi/megaraid/megaraid_sas_fusion.c       |    2 -
 drivers/scsi/mpi3mr/Kconfig                       |    1 +
 drivers/scsi/mpi3mr/Makefile                      |    1 +
 drivers/scsi/mpi3mr/mpi/mpi30_init.h              |   53 -
 drivers/scsi/mpi3mr/mpi/mpi30_ioc.h               |   27 -
 drivers/scsi/mpi3mr/mpi/mpi30_pci.h               |   31 +-
 drivers/scsi/mpi3mr/mpi3mr.h                      |  137 +-
 drivers/scsi/mpi3mr/mpi3mr_app.c                  | 1864 +++++++++++++++++++++
 drivers/scsi/mpi3mr/mpi3mr_debug.h                |   37 +-
 drivers/scsi/mpi3mr/mpi3mr_fw.c                   |  335 +++-
 drivers/scsi/mpi3mr/mpi3mr_os.c                   |   71 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c               |   34 +-
 drivers/scsi/mpt3sas/mpt3sas_base.h               |    6 +-
 drivers/scsi/mpt3sas/mpt3sas_ctl.c                |   11 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c              |   24 +-
 drivers/scsi/pmcraid.c                            |    2 +-
 drivers/scsi/qedf/qedf_attr.c                     |    2 -
 drivers/scsi/qedf/qedf_io.c                       |    3 +-
 drivers/scsi/qedf/qedf_main.c                     |   13 +-
 drivers/scsi/qla2xxx/qla_edif.c                   |    3 +-
 drivers/scsi/qla2xxx/qla_os.c                     |    1 -
 drivers/scsi/qla2xxx/qla_target.c                 |    2 -
 drivers/scsi/qla2xxx/qla_target.h                 |    1 -
 drivers/scsi/qla4xxx/ql4_os.c                     |    1 -
 drivers/scsi/scsi.c                               |  116 +-
 drivers/scsi/scsi_debug.c                         |  149 +-
 drivers/scsi/scsi_lib.c                           |    2 +-
 drivers/scsi/scsi_scan.c                          |   12 +-
 drivers/scsi/scsi_sysfs.c                         |   28 +
 drivers/scsi/sd.c                                 |  193 ++-
 drivers/scsi/sd.h                                 |   33 +-
 drivers/scsi/sd_dif.c                             |    8 +-
 drivers/scsi/sd_zbc.c                             |  236 ++-
 drivers/scsi/sr.c                                 |   14 +-
 drivers/scsi/ufs/Kconfig                          |   26 +-
 drivers/scsi/ufs/cdns-pltfrm.c                    |    2 +-
 drivers/scsi/ufs/tc-dwc-g210-pci.c                |    1 +
 drivers/scsi/ufs/tc-dwc-g210-pltfrm.c             |    1 +
 drivers/scsi/ufs/tc-dwc-g210.c                    |    2 +
 drivers/scsi/ufs/tc-dwc-g210.h                    |    2 +
 drivers/scsi/ufs/ti-j721e-ufs.c                   |    6 +-
 drivers/scsi/ufs/ufs-debugfs.c                    |    1 +
 drivers/scsi/ufs/ufs-exynos.c                     |    5 +-
 drivers/scsi/ufs/ufs-exynos.h                     |    8 +-
 drivers/scsi/ufs/ufs-hisi.c                       |    2 +
 drivers/scsi/ufs/ufs-hwmon.c                      |    1 +
 drivers/scsi/ufs/ufs-mediatek.c                   |   31 +-
 drivers/scsi/ufs/ufs-qcom-ice.c                   |    2 +-
 drivers/scsi/ufs/ufs-qcom.c                       |   73 +-
 drivers/scsi/ufs/ufs-qcom.h                       |    6 +-
 drivers/scsi/ufs/ufs-sysfs.c                      |    1 +
 drivers/scsi/ufs/ufs-sysfs.h                      |    3 +-
 drivers/scsi/ufs/ufs.h                            |   35 -
 drivers/scsi/ufs/ufs_bsg.c                        |    6 +
 drivers/scsi/ufs/ufs_bsg.h                        |    7 +-
 drivers/scsi/ufs/ufs_quirks.h                     |   15 +-
 drivers/scsi/ufs/ufshcd-crypto.h                  |    5 +-
 drivers/scsi/ufs/ufshcd-dwc.c                     |    2 +
 drivers/scsi/ufs/ufshcd-dwc.h                     |    2 +
 drivers/scsi/ufs/ufshcd-pci.c                     |    4 +-
 drivers/scsi/ufs/ufshcd-pltfrm.c                  |   38 +-
 drivers/scsi/ufs/ufshcd-priv.h                    |  298 ++++
 drivers/scsi/ufs/ufshcd.c                         |  247 ++-
 drivers/scsi/ufs/ufshcd.h                         |  368 +---
 drivers/scsi/ufs/ufshci.h                         |    2 +
 drivers/scsi/ufs/ufshpb.c                         |  203 ++-
 drivers/scsi/ufs/ufshpb.h                         |   16 +-
 drivers/scsi/ufs/unipro.h                         |   18 +-
 drivers/scsi/vmw_pvscsi.c                         |    1 -
 drivers/target/iscsi/cxgbit/cxgbit.h              |   22 +-
 drivers/target/iscsi/cxgbit/cxgbit_cm.c           |    8 +-
 drivers/target/iscsi/cxgbit/cxgbit_ddp.c          |    4 +-
 drivers/target/iscsi/cxgbit/cxgbit_main.c         |    2 +-
 drivers/target/iscsi/cxgbit/cxgbit_target.c       |   72 +-
 drivers/target/iscsi/iscsi_target.c               |  272 +--
 drivers/target/iscsi/iscsi_target.h               |   30 +-
 drivers/target/iscsi/iscsi_target_auth.c          |   10 +-
 drivers/target/iscsi/iscsi_target_auth.h          |    4 +-
 drivers/target/iscsi/iscsi_target_configfs.c      |   34 +-
 drivers/target/iscsi/iscsi_target_datain_values.c |   28 +-
 drivers/target/iscsi/iscsi_target_datain_values.h |   12 +-
 drivers/target/iscsi/iscsi_target_device.c        |    4 +-
 drivers/target/iscsi/iscsi_target_device.h        |    8 +-
 drivers/target/iscsi/iscsi_target_erl0.c          |   68 +-
 drivers/target/iscsi/iscsi_target_erl0.h          |   24 +-
 drivers/target/iscsi/iscsi_target_erl1.c          |   92 +-
 drivers/target/iscsi/iscsi_target_erl1.h          |   40 +-
 drivers/target/iscsi/iscsi_target_erl2.c          |   48 +-
 drivers/target/iscsi/iscsi_target_erl2.h          |   26 +-
 drivers/target/iscsi/iscsi_target_login.c         |   78 +-
 drivers/target/iscsi/iscsi_target_login.h         |   22 +-
 drivers/target/iscsi/iscsi_target_nego.c          |   60 +-
 drivers/target/iscsi/iscsi_target_nego.h          |   12 +-
 drivers/target/iscsi/iscsi_target_nodeattrib.c    |    4 +-
 drivers/target/iscsi/iscsi_target_parameters.c    |    8 +-
 drivers/target/iscsi/iscsi_target_parameters.h    |    8 +-
 drivers/target/iscsi/iscsi_target_seq_pdu_list.c  |   44 +-
 drivers/target/iscsi/iscsi_target_seq_pdu_list.h  |   10 +-
 drivers/target/iscsi/iscsi_target_stat.c          |   16 +-
 drivers/target/iscsi/iscsi_target_tmr.c           |   72 +-
 drivers/target/iscsi/iscsi_target_tmr.h           |   16 +-
 drivers/target/iscsi/iscsi_target_tpg.c           |    2 +-
 drivers/target/iscsi/iscsi_target_tpg.h           |    4 +-
 drivers/target/iscsi/iscsi_target_util.c          |  164 +-
 drivers/target/iscsi/iscsi_target_util.h          |  102 +-
 drivers/target/target_core_configfs.c             |   47 +-
 drivers/target/target_core_spc.c                  |    2 +-
 drivers/target/target_core_user.c                 |   50 +-
 include/scsi/libfcoe.h                            |    2 +
 include/scsi/libiscsi.h                           |    6 +-
 include/scsi/sas_ata.h                            |    7 +
 include/scsi/scsi_device.h                        |    9 +-
 include/scsi/scsi_proto.h                         |    9 +-
 include/target/iscsi/iscsi_target_core.h          |   52 +-
 include/target/iscsi/iscsi_transport.h            |  126 +-
 include/uapi/scsi/scsi_bsg_mpi3mr.h               |  582 +++++++
 169 files changed, 6840 insertions(+), 3470 deletions(-)
 create mode 100644 drivers/scsi/mpi3mr/mpi3mr_app.c
 create mode 100644 drivers/scsi/ufs/ufshcd-priv.h
 create mode 100644 include/uapi/scsi/scsi_bsg_mpi3mr.h

James


