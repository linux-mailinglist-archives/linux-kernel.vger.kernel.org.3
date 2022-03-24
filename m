Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF754E6942
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 20:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352932AbiCXT0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 15:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346128AbiCXT0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 15:26:02 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3209BBB5;
        Thu, 24 Mar 2022 12:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1648149866;
        bh=L/KO3F87N4oWB284t73olfOmSeF3Y98pqK+hUuTq2oM=;
        h=Message-ID:Subject:From:To:Date:From;
        b=RMUoImAsYgNfzi6HEeZEAlIr5vdCKJmKEXbQOYlvqkz3dfq5mY2+EtnYKaC7KV+dT
         fQXbDU10qJR9XgG8XBMa/KCJBj7cfUgnHrKTopcSlU7Yvmc3FU5wBlNA/jbZ4o8y5N
         fcjEO6F0Osaffz+tqx96tCOAKfitSJOSbVS40kAc=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 4FD02128739B;
        Thu, 24 Mar 2022 15:24:26 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8Vdv1A2KbMYT; Thu, 24 Mar 2022 15:24:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1648149866;
        bh=L/KO3F87N4oWB284t73olfOmSeF3Y98pqK+hUuTq2oM=;
        h=Message-ID:Subject:From:To:Date:From;
        b=RMUoImAsYgNfzi6HEeZEAlIr5vdCKJmKEXbQOYlvqkz3dfq5mY2+EtnYKaC7KV+dT
         fQXbDU10qJR9XgG8XBMa/KCJBj7cfUgnHrKTopcSlU7Yvmc3FU5wBlNA/jbZ4o8y5N
         fcjEO6F0Osaffz+tqx96tCOAKfitSJOSbVS40kAc=
Received: from [9.245.238.25] (unknown [129.41.87.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 8DD151287384;
        Thu, 24 Mar 2022 15:24:25 -0400 (EDT)
Message-ID: <29544a7c36504c42ca7e1fd9e6a29d68a47f6811.camel@HansenPartnership.com>
Subject: [GIT PULL] first round of SCSI updates for the 5.15+ merge window
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 24 Mar 2022 15:24:23 -0400
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

This series consists of the usual driver updates (qla2xxx, pm8001,
libsas, smartpqi, scsi_debug, lpfc, iscsi, mpi3mr) plus minor updates
and bug fixes.  The high blast radius core update is the removal of
write same, which affects block and several non-SCSI devices.  The
other big change, which is more local, is the removal of the SCSI
pointer.

The write same removal has caused three conflicts so far, they're all
obvious, although it took me a few seconds to realise the rnd-clt.c one
is caused by another patch removing the rotational field.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

The short changelog is:

Adrian Hunter (2):
      scsi: ufs: Fix runtime PM messages never-ending cycle
      scsi: core: sd: Add silence_suspend flag to suppress some PM messages

Ajish Koshy (1):
      scsi: pm80xx: Handle non-fatal errors

Arun Easi (4):
      scsi: qla2xxx: Fix crash during module load unload test
      scsi: qla2xxx: Fix missed DMA unmap for NVMe ls requests
      scsi: qla2xxx: Fix loss of NVMe namespaces after driver reload test
      scsi: qla2xxx: Fix device reconnect in loop topology

Balsundar P (1):
      scsi: smartpqi: Resolve delay issue with PQI_HZ value

Bart Van Assche (48):
      scsi: core: Remove struct scsi_pointer from struct scsi_cmnd
      scsi: zalon: Stop using the SCSI pointer
      scsi: wd33c93: Move the SCSI pointer to private command data
      scsi: wd719x: Stop using the SCSI pointer
      scsi: usb: Stop using the SCSI pointer
      scsi: sym53c8xx_2: Move the SCSI pointer to private command data
      scsi: smartpqi: Stop using the SCSI pointer
      scsi: qla2xxx: Stop using the SCSI pointer
      scsi: qla1280: Move the SCSI pointer to private command data
      scsi: ppa: Move the SCSI pointer to private command data
      scsi: sym53c500_cs: Move the SCSI pointer to private command data
      scsi: nsp_cs: Move the SCSI pointer to private command data
      scsi: nsp32: Stop using the SCSI pointer
      scsi: mvumi: Stop using the SCSI pointer
      scsi: mvsas: Fix a set-but-not-used warning
      scsi: mesh: Move the SCSI pointer to private command data
      scsi: megasas: Stop using the SCSI pointer
      scsi: megaraid: Stop using the SCSI pointer
      scsi: mac53c94: Move the SCSI pointer to private command data
      scsi: mac53c94: Fix a set-but-not-used compiler warning
      scsi: qedf: Stop using the SCSI pointer
      scsi: bnx2fc: Stop using the SCSI pointer
      scsi: libfc: Stop using the SCSI pointer
      scsi: initio: Stop using the SCSI pointer
      scsi: iscsi: Stop using the SCSI pointer
      scsi: imm: Move the SCSI pointer to private command data
      scsi: hptiop: Stop using the SCSI pointer
      scsi: fnic: Stop using the SCSI pointer
      scsi: fnic: Fix a tracing statement
      scsi: fdomain: Move the SCSI pointer to private command data
      scsi: esp_scsi: Stop using the SCSI pointer
      scsi: dc395x: Stop using the SCSI pointer
      scsi: csio: Stop using the SCSI pointer
      scsi: bfa: Stop using the SCSI pointer
      scsi: aha152x: Move the SCSI pointer to private command data
      scsi: aha1542: Remove a set-but-not-used array
      scsi: advansys: Move the SCSI pointer to private command data
      scsi: aacraid: Move the SCSI pointer to private command data
      scsi: 53c700: Stop clearing SCSI pointer fields
      scsi: arm: Move the SCSI pointer to private command data
      scsi: arm: Rename arm/scsi.h into arm/arm_scsi.h
      scsi: NCR5380: Remove the NCR5380_CMD_SIZE macro
      scsi: Remove drivers/scsi/scsi.h
      scsi: nsp_cs: Use true and false instead of TRUE and FALSE
      scsi: nsp_cs: Change the return type of two functions into 'void'
      scsi: ips: Use true and false instead of TRUE and FALSE
      scsi: ips: Change the return type of ips_release() into 'void'
      scsi: ips: Remove an unreachable statement

Bikash Hazarika (1):
      scsi: qla2xxx: Fix wrong FDMI data for 64G adapter

Cai Huoqing (1):
      scsi: bnx2fc: Fix typo in comments

Changcheng Deng (1):
      scsi: qla4xxx: Remove unneeded variable

Christoph Hellwig (15):
      scsi: core: Remove <scsi/scsi_request.h>
      scsi: core: Remove struct scsi_request
      scsi: core: Move the result field from struct scsi_request to struct scsi_cmnd
      scsi: core: Move the resid_len field from struct scsi_request to struct scsi_cmnd
      scsi: core: Remove the sense and sense_len fields from struct scsi_request
      scsi: core: Remove the cmd field from struct scsi_request
      scsi: core: Don't memset() the entire scsi_cmnd in scsi_init_command()
      scsi: target: pscsi: Remove struct pscsi_plugin_task
      scsi: block: Remove REQ_OP_WRITE_SAME support
      scsi: dm: Remove WRITE_SAME support
      scsi: md: Remove WRITE_SAME support
      scsi: sd: Remove WRITE_SAME support
      scsi: rnbd: Remove WRITE_SAME support
      scsi: drbd: Remove WRITE_SAME support
      scsi: cxlflash: Query write_zeroes limit for zeroing

Christophe JAILLET (1):
      scsi: message: fusion: Use GFP_KERNEL instead of GFP_ATOMIC in non-atomic context

Damien Le Moal (34):
      scsi: scsi_debug: Fix qc_lock use in sdebug_blk_mq_poll()
      scsi: scsi_debug: Silence unexpected unlock warnings
      scsi: libsas: Clean up sas_form_port()
      scsi: pm8001: Fix pm8001_info() message format
      scsi: pm8001: Improve pm80XX_send_abort_all()
      scsi: pm8001: Simplify pm8001_ccb_task_free()
      scsi: pm8001: Simplify pm8001_task_exec()
      scsi: pm8001: Simplify pm8001_mpi_build_cmd() interface
      scsi: pm8001: Introduce ccb alloc/free helpers
      scsi: pm8001: Simplify pm8001_get_ncq_tag()
      scsi: pm8001: Cleanup pm8001_exec_internal_task_abort()
      scsi: libsas: Simplify sas_ata_qc_issue() detection of NCQ commands
      scsi: pm8001: Fix memory leak in pm8001_chip_fw_flash_update_req()
      scsi: pm8001: Fix tag leaks on error
      scsi: pm8001: Fix task leak in pm8001_send_abort_all()
      scsi: pm8001: Fix tag values handling
      scsi: pm8001: Fix pm8001_mpi_task_abort_resp()
      scsi: pm8001: Fix pm8001_tag_alloc() failures handling
      scsi: pm8001: Fix abort all task initialization
      scsi: pm8001: Fix NCQ NON DATA command completion handling
      scsi: pm8001: Fix NCQ NON DATA command task initialization
      scsi: pm8001: Remove local variable in pm8001_pci_resume()
      scsi: pm8001: Fix use of struct set_phy_profile_req fields
      scsi: pm8001: Fix le32 values handling in pm80xx_chip_sata_req()
      scsi: pm8001: Fix le32 values handling in pm80xx_chip_ssp_io_req()
      scsi: pm8001: Fix payload initialization in pm80xx_encrypt_update()
      scsi: pm8001: Fix le32 values handling in pm80xx_set_sas_protocol_timer_config()
      scsi: pm8001: Fix payload initialization in pm80xx_set_thermal_config()
      scsi: pm8001: Fix command initialization in pm8001_chip_ssp_tm_req()
      scsi: pm8001: Fix pm80xx_pci_mem_copy() interface
      scsi: pm8001: Fix command initialization in pm80XX_send_read_log()
      scsi: pm8001: Fix pm8001_update_flash() local variable type
      scsi: pm8001: Fix __iomem pointer use in pm8001_phy_control()
      scsi: libsas: Fix sas_ata_qc_issue() handling of NCQ NON DATA commands

Daniel Wagner (1):
      scsi: qla2xxx: Refactor asynchronous command initialization

Don Brace (4):
      scsi: smartpqi: Fix unused variable pqi_pm_ops for clang
      scsi: smartpqi: Update version to 2.1.14-035
      scsi: smartpqi: Add PCI IDs
      scsi: smartpqi: Fix rmmod stack trace

Douglas Gilbert (7):
      scsi: scsi_debug: Add environmental reporting log subpage
      scsi: scsi_debug: Add no_rwlock parameter
      scsi: scsi_debug: Divide power on reset UNIT ATTENTION
      scsi: scsi_debug: Refine sdebug_blk_mq_poll()
      scsi: scsi_debug: Use TASK SET FULL more
      scsi: scsi_debug: Strengthen defer_t accesses
      scsi: scsi_debug: Address races following module load

Finn Thain (3):
      scsi: mac53c94: Stop using struct scsi_pointer
      scsi: mesh: Stop using struct scsi_pointer
      scsi: NCR5380: Add SCp members to struct NCR5380_cmd

Gilbert Wu (1):
      scsi: smartpqi: Enable SATA NCQ priority in sysfs

Gleb Chesnokov (3):
      scsi: qla2xxx: Use named initializers for q_dev_state
      scsi: qla2xxx: Use named initializers for port_[d]state_str
      scsi: qla2xxx: Remove unused qla_sess_op_cmd_list from scsi_qla_host_t

Guixin Liu (1):
      scsi: target: tcmu: Make cmd_ring_size changeable via configfs

Gustavo A. R. Silva (1):
      scsi: libfc: Replace one-element arrays with flexible-array members

Hannes Reinecke (5):
      scsi: lpfc: Use rport as argument for lpfc_chk_tgt_mapped()
      scsi: lpfc: Use rport as argument for lpfc_send_taskmgmt()
      scsi: lpfc: Use fc_block_rport()
      scsi: lpfc: Drop lpfc_no_handler()
      scsi: lpfc: Kill lpfc_bus_reset_handler()

James Smart (19):
      scsi: lpfc: Copyright updates for 14.2.0.0 patches
      scsi: lpfc: Update lpfc version to 14.2.0.0
      scsi: lpfc: SLI path split: Refactor BSG paths
      scsi: lpfc: SLI path split: Refactor Abort paths
      scsi: lpfc: SLI path split: Refactor SCSI paths
      scsi: lpfc: SLI path split: Refactor CT paths
      scsi: lpfc: SLI path split: Refactor misc ELS paths
      scsi: lpfc: SLI path split: Refactor VMID paths
      scsi: lpfc: SLI path split: Refactor FDISC paths
      scsi: lpfc: SLI path split: Refactor LS_RJT paths
      scsi: lpfc: SLI path split: Refactor LS_ACC paths
      scsi: lpfc: SLI path split: Refactor the RSCN/SCR/RDF/EDC/FARPR paths
      scsi: lpfc: SLI path split: Refactor PLOGI/PRLI/ADISC/LOGO paths
      scsi: lpfc: SLI path split: Refactor base ELS paths and the FLOGI path
      scsi: lpfc: SLI path split: Introduce lpfc_prep_wqe
      scsi: lpfc: SLI path split: Refactor fast and slow paths to native SLI4
      scsi: lpfc: SLI path split: Refactor lpfc_iocbq
      scsi: lpfc: Remove failing soft_wwn support
      scsi: scsi_transport_fc: Fix FPIN Link Integrity statistics counters

Jianglei Nie (1):
      scsi: libfc: Fix use after free in fc_exch_abts_resp()

Jiapeng Chong (1):
      scsi: aacraid: Clean up some inconsistent indenting

Jinyoung Choi (1):
      scsi: ufs: Add checking lifetime attribute for WriteBooster

Joe Carnuccio (3):
      scsi: qla2xxx: Check for firmware dump already collected
      scsi: qla2xxx: Add devids and conditionals for 28xx
      scsi: qla2xxx: Fix T10 PI tag escape and IP guard options for 28XX adapters

John Garry (26):
      scsi: hisi_sas: Use libsas internal abort support
      scsi: pm8001: Use libsas internal abort support
      scsi: libsas: Add sas_execute_internal_abort_dev()
      scsi: libsas: Add sas_execute_internal_abort_single()
      scsi: libsas: Use bool for queue_work() return code
      scsi: libsas: Make sas_notify_{phy,port}_event() return void
      scsi: libsas: Add sas_execute_ata_cmd()
      scsi: libsas: Add sas_abort_task()
      scsi: libsas: Add sas_query_task()
      scsi: libsas: Add sas_lu_reset()
      scsi: libsas: Add sas_clear_task_set()
      scsi: libsas: Add sas_abort_task_set()
      scsi: libsas: Add TMF handler aborted callback
      scsi: libsas: Add TMF handler exec complete callback
      scsi: libsas: Add sas_execute_ssp_tmf()
      scsi: libsas: Add sas_execute_tmf()
      scsi: libsas: Add sas_task.tmf
      scsi: libsas: Add struct sas_tmf_task
      scsi: libsas: Move SMP task handlers to core
      scsi: hisi_sas: Delete unused I_T_NEXUS_RESET_PHYUP_TIMEOUT
      scsi: libsas: Delete SAS_SG_ERR
      scsi: libsas: Delete lldd_clear_aca callback
      scsi: libsas: Use enum for response frame DATAPRES field
      scsi: libsas: Handle non-TMF codes in sas_scsi_find_task()
      scsi: libsas: Drop SAS_TASK_AT_INITIATOR
      scsi: isci: Drop SAS_TASK_AT_INITIATOR check in isci_task_abort_task()

Julia Lawall (6):
      scsi: lpfc: Use kcalloc()
      scsi: aic7xxx: Fix typos in comments
      scsi: qla2xxx: Fix typos in comments
      scsi: elx: libefc_sli: Fix typos in comments
      scsi: lpfc: Fix typos in comments
      scsi: message: fusion: Use GFP_KERNEL

Kees Cook (2):
      scsi: ibmvscsis: Silence -Warray-bounds warning
      scsi: mpt3sas: Convert to flexible arrays

Keoseong Park (1):
      scsi: ufs: core: Remove wlun_dev_to_hba()

Kevin Barnett (5):
      scsi: smartpqi: Fix lsscsi -t SAS addresses
      scsi: smartpqi: Fix hibernate and suspend
      scsi: smartpqi: Expose SAS address for SATA drives
      scsi: smartpqi: Fix a typo in func pqi_aio_submit_io()
      scsi: smartpqi: Fix a name typo and cleanup code

Khazhismel Kumykov (1):
      scsi: core: docs: Update notes about scsi_times_out

Lukas Bulwahn (2):
      scsi: scsi_ioctl: Drop needless assignment in sg_io()
      scsi: bsg: Drop needless assignment in scsi_bsg_sg_io_fn()

Mahesh Rajashekhara (2):
      scsi: smartpqi: Fix kdump issue when controller is locked up
      scsi: smartpqi: Update volume size after expansion

Manish Rangankar (1):
      scsi: qla2xxx: Use correct feature type field during RFF_ID processing

Martin Wilck (1):
      scsi: core: Make "access_state" sysfs attribute always visible

Mike Christie (6):
      scsi: iscsi: Drop temp workq_name
      scsi: iscsi: Use the session workqueue for recovery
      scsi: iscsi: ql4xxx: Use per-session workqueue for unbinding
      scsi: iscsi: Remove iscsi_scan_finished()
      scsi: iscsi: Speed up session unblocking and removal
      scsi: iscsi: Fix recovery and unblocking race

Mike McGowen (3):
      scsi: smartpqi: Fix BUILD_BUG_ON() statements
      scsi: smartpqi: Fix NUMA node not updated during init
      scsi: smartpqi: Speed up RAID 10 sequential reads

Minghao Chi (CGEL ZTE) (2):
      scsi: lpfc: Remove redundant flush_workqueue() call
      scsi: qedi: Remove redundant flush_workqueue() calls

Mingzhe Zou (1):
      scsi: target: Add iscsi/cpus_allowed_list in configfs

Murthy Bhat (1):
      scsi: smartpqi: Quickly propagate path failures to SCSI midlayer

Nilesh Javali (3):
      scsi: qla2xxx: Update version to 10.02.07.400-k
      scsi: qla2xxx: Update version to 10.02.07.300-k
      scsi: qla2xxx: Fix warning for missing error code

Peter Wang (1):
      scsi: ufs: core: scsi_get_lba() error fix

Qi Liu (2):
      scsi: hisi_sas: Rename error labels in hisi_sas_v3_probe()
      scsi: hisi_sas: Free irq vectors in order for v3 HW

Quinn Tran (13):
      scsi: qla2xxx: Fix stuck session of PRLI reject
      scsi: qla2xxx: Reduce false trigger to login
      scsi: qla2xxx: Fix laggy FC remote port session recovery
      scsi: qla2xxx: Fix hang due to session stuck
      scsi: qla2xxx: Fix N2N inconsistent PLOGI
      scsi: qla2xxx: Fix disk failure to rediscover
      scsi: qla2xxx: Fix incorrect reporting of task management failure
      scsi: qla2xxx: edif: Fix clang warning
      scsi: qla2xxx: Add retry for exec firmware
      scsi: qla2xxx: Fix scheduling while atomic
      scsi: qla2xxx: Fix premature hw access after PCI error
      scsi: qla2xxx: Fix warning message due to adisc being flushed
      scsi: qla2xxx: Fix stuck session in gpdb

Randy Dunlap (2):
      scsi: ufs: docs: UFS documentation corrections
      scsi: aha152x: Fix aha152x_setup() __setup handler return value

Sagar Biradar (2):
      scsi: smartpqi: Avoid drive spin-down during suspend
      scsi: smartpqi: Eliminate drive spin down on warm boot

Saurav Kashyap (3):
      scsi: qla2xxx: Add qla2x00_async_done() for async routines
      scsi: qla2xxx: Suppress a kernel complaint in qla_create_qpair()
      scsi: qla2xxx: Implement ref count for SRB

Sebastian Andrzej Siewior (2):
      scsi: usb: storage: Complete the SCSI request directly
      scsi: core: Add scsi_done_direct() for immediate completion

Shreyas Deodhar (2):
      scsi: qla2xxx: Increase max limit of ql2xnvme_queues
      scsi: qla2xxx: Add ql2xnvme_queues module param to configure number of NVMe queues

Sreekanth Reddy (12):
      scsi: mpt3sas: Fix incorrect 4GB boundary check
      scsi: mpt3sas: Remove scsi_dma_map() error messages
      scsi: mpi3mr: Fix flushing !WQ_MEM_RECLAIM events warning
      scsi: mpi3mr: Bump driver version to 8.0.0.68.0
      scsi: mpi3mr: Fix memory leaks
      scsi: mpi3mr: Update the copyright year
      scsi: mpi3mr: Fix reporting of actual data transfer size
      scsi: mpi3mr: Fix cmnd getting marked as in use forever
      scsi: mpi3mr: Fix hibernation issue
      scsi: mpi3mr: Update MPI3 headers
      scsi: mpi3mr: Fix printing of pending I/O count
      scsi: mpi3mr: Fix deadlock while canceling the fw event

Wenchao Hao (3):
      scsi: libiscsi: Teardown iscsi_cls_conn gracefully
      scsi: libiscsi: Add iscsi_cls_conn to sysfs after initialization
      scsi: iscsi: Add helper functions to manage iscsi_cls_conn

Xiang Chen (7):
      scsi: hisi_sas: Limit users changing debugfs BIST count value
      scsi: hisi_sas: Change hisi_sas_control_phy() phyup timeout
      scsi: hisi_sas: Change permission of parameter prot_mask
      scsi: Remove unused member cmd_pool for structure scsi_host_template
      scsi: libsas: Remove unused parameter for function sas_ata_eh()
      scsi: libsas: Remove duplicated setting for task->task_state_flags
      scsi: libsas: Use void for sas_discover_event() return code

Xingui Yang (1):
      scsi: hisi_sas: Modify v3 HW SSP underflow error processing

Yang Guang (2):
      scsi: bfa: Replace snprintf() with sysfs_emit()
      scsi: mvsas: Replace snprintf() with sysfs_emit()

Yang Li (4):
      scsi: core: Remove unreachable code warning
      scsi: megasas: Clean up some inconsistent indenting
      scsi: hisi_sas: Remove unnecessary print function dev_err()
      scsi: pm8001: Clean up inconsistent indenting

Yin Xiujiang (1):
      scsi: bnx2fc: Make use of the helper macro kthread_run()

Zheyu Ma (1):
      scsi: wd719x: Return proper error code when dma_set_mask() fails

And the diffstat:

 Documentation/scsi/libsas.rst                |    2 -
 Documentation/scsi/scsi_eh.rst               |   15 +-
 Documentation/scsi/ufs.rst                   |   70 +-
 block/blk-core.c                             |   13 +-
 block/blk-lib.c                              |   93 -
 block/blk-merge.c                            |   40 -
 block/blk-settings.c                         |   16 -
 block/blk-sysfs.c                            |    3 +-
 block/blk-zoned.c                            |    1 -
 block/blk.h                                  |    1 -
 block/bounce.c                               |    3 -
 drivers/ata/libata-scsi.c                    |    4 +-
 drivers/block/drbd/drbd_main.c               |   31 +-
 drivers/block/drbd/drbd_nl.c                 |   72 +-
 drivers/block/drbd/drbd_receiver.c           |   47 +-
 drivers/block/drbd/drbd_req.c                |    1 -
 drivers/block/drbd/drbd_worker.c             |    5 -
 drivers/block/pktcdvd.c                      |    8 +-
 drivers/block/rnbd/rnbd-clt.c                |    7 +-
 drivers/block/rnbd/rnbd-clt.h                |    1 -
 drivers/block/rnbd/rnbd-proto.h              |    6 -
 drivers/block/rnbd/rnbd-srv.c                |    3 +-
 drivers/cdrom/cdrom.c                        |    1 -
 drivers/infiniband/ulp/iser/iscsi_iser.c     |    1 +
 drivers/md/dm-core.h                         |    1 -
 drivers/md/dm-crypt.c                        |    1 -
 drivers/md/dm-ebs-target.c                   |    1 -
 drivers/md/dm-io.c                           |   22 +-
 drivers/md/dm-linear.c                       |    1 -
 drivers/md/dm-mpath.c                        |    1 -
 drivers/md/dm-rq.c                           |    3 -
 drivers/md/dm-stripe.c                       |    4 +-
 drivers/md/dm-table.c                        |   29 -
 drivers/md/dm-zone.c                         |    4 -
 drivers/md/dm.c                              |   15 -
 drivers/md/md-linear.c                       |    1 -
 drivers/md/md-multipath.c                    |    1 -
 drivers/md/md.h                              |    7 -
 drivers/md/raid0.c                           |    2 -
 drivers/md/raid1.c                           |    4 +-
 drivers/md/raid10.c                          |    1 -
 drivers/md/raid5.c                           |    1 -
 drivers/message/fusion/mptsas.c              |    2 +-
 drivers/message/fusion/mptspi.c              |    2 +-
 drivers/scsi/53c700.c                        |    2 -
 drivers/scsi/NCR5380.c                       |   94 +-
 drivers/scsi/NCR5380.h                       |   13 +-
 drivers/scsi/a2091.c                         |   25 +-
 drivers/scsi/a3000.c                         |   25 +-
 drivers/scsi/aacraid/aachba.c                |   43 +-
 drivers/scsi/aacraid/aacraid.h               |   24 +-
 drivers/scsi/aacraid/comminit.c              |    2 +-
 drivers/scsi/aacraid/linit.c                 |   23 +-
 drivers/scsi/advansys.c                      |   22 +-
 drivers/scsi/aha152x.c                       |  274 ++-
 drivers/scsi/aha1542.c                       |    3 +-
 drivers/scsi/aha1740.c                       |    6 +-
 drivers/scsi/aic7xxx/aicasm/aicasm.c         |    2 +-
 drivers/scsi/aic94xx/aic94xx.h               |    1 -
 drivers/scsi/aic94xx/aic94xx_init.c          |    1 -
 drivers/scsi/aic94xx/aic94xx_task.c          |    9 -
 drivers/scsi/aic94xx/aic94xx_tmf.c           |   11 +-
 drivers/scsi/arm/acornscsi.c                 |   28 +-
 drivers/scsi/arm/{scsi.h => arm_scsi.h}      |   37 +-
 drivers/scsi/arm/arxescsi.c                  |    6 +-
 drivers/scsi/arm/cumana_1.c                  |    2 +-
 drivers/scsi/arm/cumana_2.c                  |    8 +-
 drivers/scsi/arm/eesox.c                     |    8 +-
 drivers/scsi/arm/fas216.c                    |   36 +-
 drivers/scsi/arm/fas216.h                    |    4 +
 drivers/scsi/arm/oak.c                       |    2 +-
 drivers/scsi/arm/powertec.c                  |    8 +-
 drivers/scsi/arm/queue.c                     |    6 +-
 drivers/scsi/atari_scsi.c                    |    6 +-
 drivers/scsi/be2iscsi/be_main.c              |    3 +-
 drivers/scsi/bfa/bfad_attr.c                 |   26 +-
 drivers/scsi/bfa/bfad_im.c                   |   27 +-
 drivers/scsi/bfa/bfad_im.h                   |   16 +
 drivers/scsi/bnx2fc/bnx2fc.h                 |    9 +-
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c            |    8 +-
 drivers/scsi/bnx2fc/bnx2fc_io.c              |   23 +-
 drivers/scsi/bnx2fc/bnx2fc_tgt.c             |    2 +-
 drivers/scsi/bnx2i/bnx2i_iscsi.c             |    1 +
 drivers/scsi/csiostor/csio_scsi.c            |   20 +-
 drivers/scsi/csiostor/csio_scsi.h            |   10 +
 drivers/scsi/cxgbi/cxgb3i/cxgb3i.c           |    1 +
 drivers/scsi/cxgbi/cxgb4i/cxgb4i.c           |    1 +
 drivers/scsi/cxlflash/vlun.c                 |    4 +-
 drivers/scsi/dc395x.c                        |    3 -
 drivers/scsi/dmx3191d.c                      |    2 +-
 drivers/scsi/elx/libefc_sli/sli4.c           |    2 +-
 drivers/scsi/esp_scsi.c                      |    4 +-
 drivers/scsi/esp_scsi.h                      |    3 +-
 drivers/scsi/fcoe/fcoe.c                     |    1 +
 drivers/scsi/fdomain.c                       |   64 +-
 drivers/scsi/fnic/fnic.h                     |   27 +-
 drivers/scsi/fnic/fnic_main.c                |    1 +
 drivers/scsi/fnic/fnic_scsi.c                |  289 ++-
 drivers/scsi/g_NCR5380.c                     |    6 +-
 drivers/scsi/gvp11.c                         |   25 +-
 drivers/scsi/hisi_sas/hisi_sas.h             |   19 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c        |  689 ++-----
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c       |   20 +-
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c       |   23 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c       |  150 +-
 drivers/scsi/hptiop.c                        |    1 +
 drivers/scsi/hptiop.h                        |    4 +-
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c     |    9 +-
 drivers/scsi/imm.c                           |   88 +-
 drivers/scsi/imm.h                           |    5 +
 drivers/scsi/initio.c                        |   14 +-
 drivers/scsi/initio.h                        |    9 +
 drivers/scsi/ips.c                           |   52 +-
 drivers/scsi/isci/init.c                     |    1 -
 drivers/scsi/isci/request.c                  |   22 +-
 drivers/scsi/isci/request.h                  |    5 +-
 drivers/scsi/isci/task.c                     |   41 +-
 drivers/scsi/isci/task.h                     |    4 -
 drivers/scsi/iscsi_tcp.c                     |    1 +
 drivers/scsi/libfc/fc_encode.h               |    2 +-
 drivers/scsi/libfc/fc_exch.c                 |    1 +
 drivers/scsi/libfc/fc_fcp.c                  |   26 +-
 drivers/scsi/libiscsi.c                      |   49 +-
 drivers/scsi/libsas/sas_ata.c                |   25 +-
 drivers/scsi/libsas/sas_discover.c           |    6 +-
 drivers/scsi/libsas/sas_event.c              |   50 +-
 drivers/scsi/libsas/sas_expander.c           |   24 +-
 drivers/scsi/libsas/sas_internal.h           |   10 +-
 drivers/scsi/libsas/sas_port.c               |   73 +-
 drivers/scsi/libsas/sas_scsi_host.c          |  320 ++-
 drivers/scsi/libsas/sas_task.c               |   14 +-
 drivers/scsi/lpfc/lpfc.h                     |  101 +-
 drivers/scsi/lpfc/lpfc_attr.c                |  228 ---
 drivers/scsi/lpfc/lpfc_bsg.c                 |  349 ++--
 drivers/scsi/lpfc/lpfc_crtn.h                |   22 +-
 drivers/scsi/lpfc/lpfc_ct.c                  |  346 ++--
 drivers/scsi/lpfc/lpfc_debugfs.c             |    9 +-
 drivers/scsi/lpfc/lpfc_els.c                 | 1513 ++++++++------
 drivers/scsi/lpfc/lpfc_hbadisc.c             |   46 +-
 drivers/scsi/lpfc/lpfc_hw.h                  |   16 +-
 drivers/scsi/lpfc/lpfc_hw4.h                 |   38 +-
 drivers/scsi/lpfc/lpfc_init.c                |   26 +-
 drivers/scsi/lpfc/lpfc_mbox.c                |    2 +-
 drivers/scsi/lpfc/lpfc_nportdisc.c           |  104 +-
 drivers/scsi/lpfc/lpfc_nvme.c                |   41 +-
 drivers/scsi/lpfc/lpfc_nvme.h                |    8 +-
 drivers/scsi/lpfc/lpfc_nvmet.c               |   85 +-
 drivers/scsi/lpfc/lpfc_scsi.c                |  598 +++---
 drivers/scsi/lpfc/lpfc_sli.c                 | 2831 ++++++++++++--------------
 drivers/scsi/lpfc/lpfc_sli.h                 |   31 +-
 drivers/scsi/lpfc/lpfc_sli4.h                |    2 +-
 drivers/scsi/lpfc/lpfc_version.h             |    6 +-
 drivers/scsi/mac53c94.c                      |   26 +-
 drivers/scsi/mac53c94.h                      |   11 +
 drivers/scsi/mac_scsi.c                      |    9 +-
 drivers/scsi/megaraid.c                      |   21 +-
 drivers/scsi/megaraid.h                      |   23 +-
 drivers/scsi/megaraid/megaraid_sas.h         |   12 +
 drivers/scsi/megaraid/megaraid_sas_base.c    |    8 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.c  |   19 +-
 drivers/scsi/mesh.c                          |   19 +-
 drivers/scsi/mesh.h                          |   11 +
 drivers/scsi/mpi3mr/mpi/mpi30_cnfg.h         |  122 +-
 drivers/scsi/mpi3mr/mpi/mpi30_init.h         |    3 +
 drivers/scsi/mpi3mr/mpi/mpi30_ioc.h          |   46 +-
 drivers/scsi/mpi3mr/mpi/mpi30_pci.h          |    3 +-
 drivers/scsi/mpi3mr/mpi/mpi30_transport.h    |    8 +-
 drivers/scsi/mpi3mr/mpi3mr.h                 |   10 +-
 drivers/scsi/mpi3mr/mpi3mr_debug.h           |    2 +-
 drivers/scsi/mpi3mr/mpi3mr_fw.c              |   12 +-
 drivers/scsi/mpi3mr/mpi3mr_os.c              |  161 +-
 drivers/scsi/mpt3sas/mpi/mpi2_ioc.h          |    6 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c          |   43 +-
 drivers/scsi/mvme147.c                       |   16 +-
 drivers/scsi/mvsas/mv_defs.h                 |    5 -
 drivers/scsi/mvsas/mv_init.c                 |   15 +-
 drivers/scsi/mvsas/mv_sas.c                  |  185 +-
 drivers/scsi/mvsas/mv_sas.h                  |    3 -
 drivers/scsi/mvumi.c                         |    9 +-
 drivers/scsi/mvumi.h                         |    9 +
 drivers/scsi/ncr53c8xx.c                     |   22 +-
 drivers/scsi/ncr53c8xx.h                     |    6 +
 drivers/scsi/nsp32.c                         |   20 +-
 drivers/scsi/nsp32.h                         |    9 +
 drivers/scsi/pcmcia/aha152x_stub.c           |    9 +-
 drivers/scsi/pcmcia/nsp_cs.c                 |  246 +--
 drivers/scsi/pcmcia/nsp_cs.h                 |    8 +-
 drivers/scsi/pcmcia/nsp_debug.c              |    2 +-
 drivers/scsi/pcmcia/qlogic_stub.c            |    9 +-
 drivers/scsi/pcmcia/sym53c500_cs.c           |   47 +-
 drivers/scsi/pm8001/pm8001_ctl.c             |   66 +-
 drivers/scsi/pm8001/pm8001_hwi.c             |  496 ++---
 drivers/scsi/pm8001/pm8001_hwi.h             |    5 -
 drivers/scsi/pm8001/pm8001_init.c            |   16 +-
 drivers/scsi/pm8001/pm8001_sas.c             |  577 ++----
 drivers/scsi/pm8001/pm8001_sas.h             |   86 +-
 drivers/scsi/pm8001/pm80xx_hwi.c             |  500 +++--
 drivers/scsi/pm8001/pm80xx_hwi.h             |   16 +-
 drivers/scsi/ppa.c                           |   75 +-
 drivers/scsi/qedf/qedf.h                     |   10 +-
 drivers/scsi/qedf/qedf_io.c                  |   25 +-
 drivers/scsi/qedf/qedf_main.c                |    3 +-
 drivers/scsi/qedi/qedi_fw.c                  |    4 +-
 drivers/scsi/qedi/qedi_iscsi.c               |    1 +
 drivers/scsi/qedi/qedi_main.c                |    2 -
 drivers/scsi/qla1280.c                       |   21 +-
 drivers/scsi/qla1280.h                       |    3 +-
 drivers/scsi/qla2xxx/qla_attr.c              |    7 +-
 drivers/scsi/qla2xxx/qla_bsg.c               |    6 +-
 drivers/scsi/qla2xxx/qla_def.h               |   60 +-
 drivers/scsi/qla2xxx/qla_edif.c              |   25 +-
 drivers/scsi/qla2xxx/qla_gbl.h               |    7 +-
 drivers/scsi/qla2xxx/qla_gs.c                |  162 +-
 drivers/scsi/qla2xxx/qla_init.c              |  261 +--
 drivers/scsi/qla2xxx/qla_inline.h            |    2 +
 drivers/scsi/qla2xxx/qla_iocb.c              |   93 +-
 drivers/scsi/qla2xxx/qla_isr.c               |   11 +-
 drivers/scsi/qla2xxx/qla_mbx.c               |   37 +-
 drivers/scsi/qla2xxx/qla_mid.c               |    9 +-
 drivers/scsi/qla2xxx/qla_mr.c                |   11 +-
 drivers/scsi/qla2xxx/qla_nvme.c              |   71 +-
 drivers/scsi/qla2xxx/qla_nvme.h              |    3 +
 drivers/scsi/qla2xxx/qla_nx.c                |   35 +-
 drivers/scsi/qla2xxx/qla_nx.h                |   20 +-
 drivers/scsi/qla2xxx/qla_nx2.c               |    9 +-
 drivers/scsi/qla2xxx/qla_os.c                |   75 +-
 drivers/scsi/qla2xxx/qla_sup.c               |    4 +-
 drivers/scsi/qla2xxx/qla_target.c            |   34 +-
 drivers/scsi/qla2xxx/qla_tmpl.c              |    9 +-
 drivers/scsi/qla2xxx/qla_version.h           |    4 +-
 drivers/scsi/qla4xxx/ql4_def.h               |   16 +-
 drivers/scsi/qla4xxx/ql4_os.c                |   18 +-
 drivers/scsi/qlogicfas.c                     |    6 +-
 drivers/scsi/qlogicfas408.c                  |    6 +-
 drivers/scsi/scsi.h                          |   46 -
 drivers/scsi/scsi_bsg.c                      |   43 +-
 drivers/scsi/scsi_debug.c                    |  488 +++--
 drivers/scsi/scsi_debugfs.c                  |    6 +-
 drivers/scsi/scsi_error.c                    |   49 +-
 drivers/scsi/scsi_ioctl.c                    |   77 +-
 drivers/scsi/scsi_lib.c                      |  139 +-
 drivers/scsi/scsi_logging.c                  |    5 +-
 drivers/scsi/scsi_sysfs.c                    |    8 -
 drivers/scsi/scsi_transport_fc.c             |   39 +-
 drivers/scsi/scsi_transport_iscsi.c          |  184 +-
 drivers/scsi/scsi_transport_sas.c            |    1 -
 drivers/scsi/sd.c                            |  109 +-
 drivers/scsi/sd_zbc.c                        |    2 -
 drivers/scsi/sg.c                            |   52 +-
 drivers/scsi/sgiwd93.c                       |   24 +-
 drivers/scsi/smartpqi/smartpqi.h             |   16 +-
 drivers/scsi/smartpqi/smartpqi_init.c        |  559 +++--
 drivers/scsi/smartpqi/smartpqi_sis.c         |   10 +-
 drivers/scsi/smartpqi/smartpqi_sis.h         |    1 +
 drivers/scsi/sr.c                            |   30 +-
 drivers/scsi/st.c                            |   30 +-
 drivers/scsi/sun3_scsi.c                     |    4 +-
 drivers/scsi/sym53c8xx_2/sym_glue.c          |    4 +-
 drivers/scsi/ufs/ufs.h                       |    6 +
 drivers/scsi/ufs/ufshcd.c                    |   80 +-
 drivers/scsi/ufs/ufshpb.c                    |   22 +-
 drivers/scsi/wd33c93.c                       |  119 +-
 drivers/scsi/wd33c93.h                       |    4 +
 drivers/scsi/wd719x.c                        |   15 +-
 drivers/scsi/wd719x.h                        |    1 +
 drivers/scsi/zalon.c                         |    1 +
 drivers/target/iscsi/iscsi_target.c          |   77 +-
 drivers/target/iscsi/iscsi_target_configfs.c |   32 +
 drivers/target/iscsi/iscsi_target_login.c    |    8 +
 drivers/target/target_core_pscsi.c           |   67 +-
 drivers/target/target_core_pscsi.h           |    4 -
 drivers/target/target_core_user.c            |   73 +-
 drivers/usb/image/microtek.c                 |    8 +-
 drivers/usb/storage/cypress_atacb.c          |    1 -
 drivers/usb/storage/debug.c                  |    1 -
 drivers/usb/storage/isd200.c                 |    4 +-
 drivers/usb/storage/uas.c                    |   43 +-
 drivers/usb/storage/usb.c                    |    2 +-
 include/linux/bio.h                          |    3 -
 include/linux/blk_types.h                    |    2 -
 include/linux/blkdev.h                       |   19 -
 include/linux/bsg-lib.h                      |    1 -
 include/linux/device-mapper.h                |    6 -
 include/scsi/fc/fc_ms.h                      |    4 +-
 include/scsi/libfc.h                         |    9 +
 include/scsi/libiscsi.h                      |   13 +-
 include/scsi/libsas.h                        |   56 +-
 include/scsi/sas.h                           |    9 +
 include/scsi/sas_ata.h                       |   14 +-
 include/scsi/scsi_cmnd.h                     |   31 +-
 include/scsi/scsi_device.h                   |    1 +
 include/scsi/scsi_eh.h                       |    4 +-
 include/scsi/scsi_host.h                     |    3 -
 include/scsi/scsi_request.h                  |   31 -
 include/scsi/scsi_transport_iscsi.h          |    9 +-
 include/scsi/viosrp.h                        |   17 +-
 include/target/iscsi/iscsi_target_core.h     |   31 +-
 kernel/trace/blktrace.c                      |    1 -
 298 files changed, 8536 insertions(+), 8339 deletions(-)
 rename drivers/scsi/arm/{scsi.h => arm_scsi.h} (75%)
 delete mode 100644 drivers/scsi/scsi.h
 delete mode 100644 include/scsi/scsi_request.h

James


