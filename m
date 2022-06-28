Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DE855CCBC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343573AbiF1LAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiF1LAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:00:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF5C1F63E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 04:00:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB162B81DBA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 11:00:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3C7C3411D;
        Tue, 28 Jun 2022 11:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656414003;
        bh=9d4xyAa6YD4y5IMEAUFSYY776V/1c1wZm9maJCdy3d0=;
        h=From:To:Cc:Subject:Date:From;
        b=P/BFOrRjJ1acWzudoyeb58nh1hxyKh3TQ1tN3dfRuqaGiahqDVNjs31P9WWc3EBgs
         7ZaVjls65cdSq3z5uLP/jUy4kAy31fSi0h369GhBKhKh7/ucd2S8163IO6gw4Rc8Gu
         nE3ksYtjfnm3GF8WJkEgXIyfSGeIkeOBKs+tOoK68rDGeBFmiQBgv2l4aPjLmuOneH
         6E1DCK2EanbqWUrigzh7eKBTFVy7+frL7SATZq0u7kjcpy0zfknKxx6Vzb2+fvqxKX
         HDSc0PJFr9AMF0oy/xwu0dzB6+geBjBZ7EXEKZ20MmDGWZ3X4LUCqXSeXztM5soEHb
         CIkYI+eliNTLQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH v2 00/12] Adding Gaudi2 ASIC support to habanalabs driver
Date:   Tue, 28 Jun 2022 13:59:46 +0300
Message-Id: <20220628105958.1254875-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sending the v2 of this patch-set after fixing some comments from Greg.

Changes to each patch are detailed in the relevant patches.

Patch 6 was added to remove obsolete elements from the device structure.

Patch 11 in the 1st patch-set, the TPM patch, was removed due to some points
that Greg raised and I need to investigate and come back with answers.

Original cover-letter:

This patch-set adds support for initializing and sending workloads to
habanalabs next-gen deep-learning training accelerator ASIC, called Gaudi2.

The Gaudi2 ASIC is based on the same architecture as the Gaudi ASIC and
therefore, the driver's common code is applicable to it with only a few
changes. Almost all of the code included in this patch-set is the
ASIC-depedent code which is different per ASIC.

The patches details are as follows:

- Patch 1 adds the necessary registers header files. I took great care of
  reducing this amount to minimum.

- Patch 2 adds the Gaudi2 definitions to the uapi file.

- Patch 3 adds the bulk of the Gaudi2 asic-specific code.

- Patches 4-6 modify the existing code to initialize the new asic-specific
  functions and properties and to remove unused elements.

- Patch 7 adds a generic security module that will be used by Gaudi2, and
  future ASICs, to initialize the security mechanisms of the device in a
  common way.

- Patches 8-11 add various features of Gaudi2 in asic-specific and common code.

- Patch 12 enables the Gaudi2 code in the driver.

More details on Gaudi2 Hardware can be found here:
https://habana.ai/wp-content/uploads/pdf/2022/gaudi2-whitepaper.pdf

We have already uploaded the updated LLVM compiler for our TPC engine to:
https://github.com/HabanaAI/tpc_llvm/tree/v1.1.0

And we are currently working on updating the open-source SynapseAI Core to
submit workloads to Gaudi2 via the driver.

Thanks,
Oded

Benjamin Dotan (1):
  habanalabs/gaudi2: add gaudi2 profiler module

Moti Haimovski (1):
  habanalabs: add gaudi2 MMU support

Oded Gabbay (8):
  habanalabs/gaudi2: add asic registers header files
  uapi: habanalabs: add gaudi2 defines
  habanalabs: add gaudi2 asic-specific code
  habanalabs: add unsupported functions
  habanalabs: initialize new asic properties
  habanalabs: remove obsolete device variables used for testing
  habanalabs: add gaudi2 wait-for-CS support
  habanalabs: enable gaudi2 code in driver

Ofir Bitton (2):
  habanalabs: add generic security module
  habanalabs/gaudi2: add gaudi2 security module

 .../ABI/testing/debugfs-driver-habanalabs     |    11 +-
 drivers/misc/habanalabs/Makefile              |     3 +
 drivers/misc/habanalabs/common/Makefile       |     3 +-
 .../habanalabs/common/command_submission.c    |   123 +-
 drivers/misc/habanalabs/common/context.c      |     3 +
 drivers/misc/habanalabs/common/debugfs.c      |   120 +-
 drivers/misc/habanalabs/common/decoder.c      |   133 +
 drivers/misc/habanalabs/common/device.c       |    69 +-
 drivers/misc/habanalabs/common/firmware_if.c  |    26 +
 drivers/misc/habanalabs/common/habanalabs.h   |   446 +-
 .../misc/habanalabs/common/habanalabs_drv.c   |    69 +-
 .../misc/habanalabs/common/habanalabs_ioctl.c |    25 +-
 drivers/misc/habanalabs/common/hw_queue.c     |    10 +
 drivers/misc/habanalabs/common/irq.c          |   139 +-
 drivers/misc/habanalabs/common/memory.c       |    21 +-
 drivers/misc/habanalabs/common/mmu/Makefile   |     3 +-
 drivers/misc/habanalabs/common/mmu/mmu.c      |   496 +-
 .../misc/habanalabs/common/mmu/mmu_v2_hr.c    |   399 +
 drivers/misc/habanalabs/common/pci/pci.c      |    38 +-
 drivers/misc/habanalabs/common/security.c     |   600 +
 drivers/misc/habanalabs/common/sysfs.c        |     6 +
 drivers/misc/habanalabs/gaudi/gaudi.c         |   172 +-
 drivers/misc/habanalabs/gaudi2/Makefile       |     4 +
 drivers/misc/habanalabs/gaudi2/gaudi2.c       |  9775 ++++
 drivers/misc/habanalabs/gaudi2/gaudi2P.h      |   536 +
 .../misc/habanalabs/gaudi2/gaudi2_coresight.c |  2722 +
 .../habanalabs/gaudi2/gaudi2_coresight_regs.h |  1063 +
 drivers/misc/habanalabs/gaudi2/gaudi2_masks.h |   135 +
 .../misc/habanalabs/gaudi2/gaudi2_security.c  |  3849 ++
 drivers/misc/habanalabs/goya/goya.c           |    26 +-
 .../misc/habanalabs/include/common/cpucp_if.h |   294 +-
 .../habanalabs/include/common/hl_boot_if.h    |     7 +
 .../gaudi2/arc/gaudi2_arc_common_packets.h    |   213 +
 .../asic_reg/arc_farm_arc0_acp_eng_regs.h     |   567 +
 .../gaudi2/asic_reg/arc_farm_arc0_aux_masks.h |   819 +
 .../gaudi2/asic_reg/arc_farm_arc0_aux_regs.h  |   591 +
 .../arc_farm_arc0_dup_eng_axuser_regs.h       |    61 +
 .../asic_reg/arc_farm_arc0_dup_eng_regs.h     |   575 +
 .../asic_reg/arc_farm_kdma_ctx_axuser_masks.h |   135 +
 .../asic_reg/arc_farm_kdma_ctx_axuser_regs.h  |    61 +
 .../gaudi2/asic_reg/arc_farm_kdma_ctx_masks.h |   221 +
 .../gaudi2/asic_reg/arc_farm_kdma_ctx_regs.h  |    95 +
 .../asic_reg/arc_farm_kdma_kdma_cgm_regs.h    |    29 +
 .../gaudi2/asic_reg/arc_farm_kdma_masks.h     |   415 +
 .../gaudi2/asic_reg/arc_farm_kdma_regs.h      |   157 +
 .../include/gaudi2/asic_reg/cpu_if_regs.h     |   777 +
 .../gaudi2/asic_reg/dcore0_dec0_cmd_masks.h   |   229 +
 .../gaudi2/asic_reg/dcore0_dec0_cmd_regs.h    |    85 +
 .../dcore0_edma0_core_ctx_axuser_regs.h       |    61 +
 .../asic_reg/dcore0_edma0_core_ctx_regs.h     |    95 +
 .../gaudi2/asic_reg/dcore0_edma0_core_masks.h |   415 +
 .../gaudi2/asic_reg/dcore0_edma0_core_regs.h  |   157 +
 .../asic_reg/dcore0_edma0_qm_arc_aux_regs.h   |   591 +
 .../dcore0_edma0_qm_axuser_nonsecured_regs.h  |    61 +
 .../asic_reg/dcore0_edma0_qm_cgm_regs.h       |    29 +
 .../gaudi2/asic_reg/dcore0_edma0_qm_masks.h   |  1165 +
 .../gaudi2/asic_reg/dcore0_edma0_qm_regs.h    |  1057 +
 .../dcore0_edma1_core_ctx_axuser_regs.h       |    61 +
 .../dcore0_edma1_qm_axuser_nonsecured_regs.h  |    61 +
 .../gaudi2/asic_reg/dcore0_hmmu0_mmu_masks.h  |   294 +
 .../gaudi2/asic_reg/dcore0_hmmu0_mmu_regs.h   |   237 +
 .../gaudi2/asic_reg/dcore0_hmmu0_stlb_masks.h |   348 +
 .../gaudi2/asic_reg/dcore0_hmmu0_stlb_regs.h  |   141 +
 .../gaudi2/asic_reg/dcore0_mme_acc_regs.h     |    73 +
 ...0_mme_ctrl_lo_arch_agu_cout0_master_regs.h |    33 +
 ...e0_mme_ctrl_lo_arch_agu_cout0_slave_regs.h |    33 +
 ...0_mme_ctrl_lo_arch_agu_cout1_master_regs.h |    33 +
 ...e0_mme_ctrl_lo_arch_agu_cout1_slave_regs.h |    33 +
 ...re0_mme_ctrl_lo_arch_agu_in0_master_regs.h |    33 +
 ...ore0_mme_ctrl_lo_arch_agu_in0_slave_regs.h |    33 +
 ...re0_mme_ctrl_lo_arch_agu_in1_master_regs.h |    33 +
 ...ore0_mme_ctrl_lo_arch_agu_in1_slave_regs.h |    33 +
 ...re0_mme_ctrl_lo_arch_agu_in2_master_regs.h |    33 +
 ...ore0_mme_ctrl_lo_arch_agu_in2_slave_regs.h |    33 +
 ...re0_mme_ctrl_lo_arch_agu_in3_master_regs.h |    33 +
 ...ore0_mme_ctrl_lo_arch_agu_in3_slave_regs.h |    33 +
 ...re0_mme_ctrl_lo_arch_agu_in4_master_regs.h |    33 +
 ...ore0_mme_ctrl_lo_arch_agu_in4_slave_regs.h |    33 +
 .../dcore0_mme_ctrl_lo_arch_base_addr_regs.h  |    39 +
 ...re0_mme_ctrl_lo_arch_non_tensor_end_regs.h |    73 +
 ...0_mme_ctrl_lo_arch_non_tensor_start_regs.h |    35 +
 .../dcore0_mme_ctrl_lo_arch_tensor_a_regs.h   |    67 +
 .../dcore0_mme_ctrl_lo_arch_tensor_b_regs.h   |    67 +
 ...dcore0_mme_ctrl_lo_arch_tensor_cout_regs.h |    67 +
 .../asic_reg/dcore0_mme_ctrl_lo_masks.h       |   468 +
 .../dcore0_mme_ctrl_lo_mme_axuser_regs.h      |    61 +
 .../gaudi2/asic_reg/dcore0_mme_ctrl_lo_regs.h |   163 +
 .../asic_reg/dcore0_mme_qm_arc_acp_eng_regs.h |   567 +
 .../asic_reg/dcore0_mme_qm_arc_aux_regs.h     |   591 +
 .../dcore0_mme_qm_arc_dup_eng_axuser_regs.h   |    61 +
 .../asic_reg/dcore0_mme_qm_arc_dup_eng_regs.h |   575 +
 .../dcore0_mme_qm_axuser_nonsecured_regs.h    |    61 +
 .../dcore0_mme_qm_axuser_secured_regs.h       |    61 +
 .../gaudi2/asic_reg/dcore0_mme_qm_cgm_regs.h  |    29 +
 .../gaudi2/asic_reg/dcore0_mme_qm_regs.h      |  1057 +
 .../gaudi2/asic_reg/dcore0_mme_sbte0_masks.h  |   107 +
 .../dcore0_mme_sbte0_mstr_if_axuser_regs.h    |    61 +
 .../dcore0_mme_wb0_mstr_if_axuser_regs.h      |    61 +
 .../gaudi2/asic_reg/dcore0_rtr0_ctrl_regs.h   |   291 +
 .../dcore0_rtr0_mstr_if_rr_prvt_hbw_regs.h    |   213 +
 .../dcore0_rtr0_mstr_if_rr_prvt_lbw_regs.h    |   189 +
 .../dcore0_rtr0_mstr_if_rr_shrd_hbw_regs.h    |   213 +
 .../dcore0_rtr0_mstr_if_rr_shrd_lbw_regs.h    |   189 +
 .../asic_reg/dcore0_sync_mngr_glbl_masks.h    |   135 +
 .../asic_reg/dcore0_sync_mngr_glbl_regs.h     |  1203 +
 .../dcore0_sync_mngr_mstr_if_axuser_masks.h   |   135 +
 .../dcore0_sync_mngr_mstr_if_axuser_regs.h    |    61 +
 .../asic_reg/dcore0_sync_mngr_objs_masks.h    |    87 +
 .../asic_reg/dcore0_sync_mngr_objs_regs.h     | 43543 +++++++++++++++
 .../asic_reg/dcore0_tpc0_cfg_axuser_regs.h    |    61 +
 .../asic_reg/dcore0_tpc0_cfg_kernel_regs.h    |   129 +
 .../dcore0_tpc0_cfg_kernel_tensor_0_regs.h    |    63 +
 .../gaudi2/asic_reg/dcore0_tpc0_cfg_masks.h   |   509 +
 .../gaudi2/asic_reg/dcore0_tpc0_cfg_qm_regs.h |   129 +
 .../dcore0_tpc0_cfg_qm_sync_object_regs.h     |    27 +
 .../dcore0_tpc0_cfg_qm_tensor_0_regs.h        |    63 +
 .../gaudi2/asic_reg/dcore0_tpc0_cfg_regs.h    |   229 +
 .../asic_reg/dcore0_tpc0_cfg_special_regs.h   |   185 +
 .../asic_reg/dcore0_tpc0_eml_busmon_0_regs.h  |   163 +
 .../asic_reg/dcore0_tpc0_eml_etf_regs.h       |   113 +
 .../asic_reg/dcore0_tpc0_eml_funnel_regs.h    |    75 +
 .../asic_reg/dcore0_tpc0_eml_spmu_regs.h      |   151 +
 .../asic_reg/dcore0_tpc0_eml_stm_regs.h       |   131 +
 .../asic_reg/dcore0_tpc0_qm_arc_aux_regs.h    |   591 +
 .../dcore0_tpc0_qm_axuser_nonsecured_regs.h   |    61 +
 .../gaudi2/asic_reg/dcore0_tpc0_qm_cgm_regs.h |    29 +
 .../gaudi2/asic_reg/dcore0_tpc0_qm_regs.h     |  1057 +
 .../dcore0_vdec0_brdg_ctrl_axuser_dec_regs.h  |    61 +
 ...0_vdec0_brdg_ctrl_axuser_msix_abnrm_regs.h |    61 +
 ...re0_vdec0_brdg_ctrl_axuser_msix_l2c_regs.h |    61 +
 ...re0_vdec0_brdg_ctrl_axuser_msix_nrm_regs.h |    61 +
 ...re0_vdec0_brdg_ctrl_axuser_msix_vcd_regs.h |    61 +
 .../asic_reg/dcore0_vdec0_brdg_ctrl_masks.h   |   581 +
 .../asic_reg/dcore0_vdec0_brdg_ctrl_regs.h    |   245 +
 .../asic_reg/dcore0_vdec0_ctrl_special_regs.h |   185 +
 .../gaudi2/asic_reg/dcore1_mme_ctrl_lo_regs.h |   163 +
 .../gaudi2/asic_reg/dcore3_mme_ctrl_lo_regs.h |   163 +
 .../asic_reg/gaudi2_blocks_linux_driver.h     | 45067 ++++++++++++++++
 .../include/gaudi2/asic_reg/gaudi2_regs.h     |   544 +
 .../gaudi2/asic_reg/nic0_qm0_cgm_regs.h       |    29 +
 .../include/gaudi2/asic_reg/nic0_qm0_regs.h   |  1057 +
 .../gaudi2/asic_reg/nic0_qm_arc_aux0_regs.h   |   591 +
 .../include/gaudi2/asic_reg/nic0_qpc0_regs.h  |   905 +
 .../nic0_umr0_0_completion_queue_ci_1_regs.h  |    27 +
 .../nic0_umr0_0_unsecure_doorbell0_regs.h     |    31 +
 .../include/gaudi2/asic_reg/pcie_aux_regs.h   |   293 +
 .../include/gaudi2/asic_reg/pcie_dbi_regs.h   |   422 +
 .../gaudi2/asic_reg/pcie_dec0_cmd_masks.h     |   229 +
 .../gaudi2/asic_reg/pcie_dec0_cmd_regs.h      |    85 +
 .../pcie_vdec0_brdg_ctrl_axuser_dec_regs.h    |    61 +
 ...e_vdec0_brdg_ctrl_axuser_msix_abnrm_regs.h |    61 +
 ...cie_vdec0_brdg_ctrl_axuser_msix_l2c_regs.h |    61 +
 ...cie_vdec0_brdg_ctrl_axuser_msix_nrm_regs.h |    61 +
 ...cie_vdec0_brdg_ctrl_axuser_msix_vcd_regs.h |    61 +
 .../asic_reg/pcie_vdec0_brdg_ctrl_masks.h     |   580 +
 .../asic_reg/pcie_vdec0_brdg_ctrl_regs.h      |   245 +
 .../asic_reg/pcie_vdec0_ctrl_special_regs.h   |   185 +
 .../include/gaudi2/asic_reg/pcie_wrap_regs.h  |   601 +
 .../asic_reg/pdma0_core_ctx_axuser_regs.h     |    61 +
 .../gaudi2/asic_reg/pdma0_core_ctx_regs.h     |    95 +
 .../gaudi2/asic_reg/pdma0_core_masks.h        |   415 +
 .../include/gaudi2/asic_reg/pdma0_core_regs.h |   157 +
 .../asic_reg/pdma0_core_special_masks.h       |   135 +
 .../gaudi2/asic_reg/pdma0_qm_arc_aux_regs.h   |   591 +
 .../pdma0_qm_axuser_nonsecured_regs.h         |    61 +
 .../asic_reg/pdma0_qm_axuser_secured_regs.h   |    61 +
 .../gaudi2/asic_reg/pdma0_qm_cgm_regs.h       |    29 +
 .../include/gaudi2/asic_reg/pdma0_qm_masks.h  |  1165 +
 .../include/gaudi2/asic_reg/pdma0_qm_regs.h   |  1057 +
 .../asic_reg/pdma1_core_ctx_axuser_regs.h     |    61 +
 .../pdma1_qm_axuser_nonsecured_regs.h         |    61 +
 .../gaudi2/asic_reg/pmmu_hbw_stlb_masks.h     |   334 +
 .../gaudi2/asic_reg/pmmu_hbw_stlb_regs.h      |   141 +
 .../include/gaudi2/asic_reg/pmmu_pif_regs.h   |   135 +
 .../include/gaudi2/asic_reg/psoc_etr_masks.h  |   311 +
 .../include/gaudi2/asic_reg/psoc_etr_regs.h   |   115 +
 .../gaudi2/asic_reg/psoc_global_conf_masks.h  |  1406 +
 .../gaudi2/asic_reg/psoc_global_conf_regs.h   |  1337 +
 .../gaudi2/asic_reg/psoc_reset_conf_masks.h   |  2321 +
 .../gaudi2/asic_reg/psoc_reset_conf_regs.h    |   989 +
 .../gaudi2/asic_reg/psoc_timestamp_regs.h     |    57 +
 .../include/gaudi2/asic_reg/rot0_desc_regs.h  |   155 +
 .../include/gaudi2/asic_reg/rot0_masks.h      |   313 +
 .../gaudi2/asic_reg/rot0_qm_arc_aux_regs.h    |   591 +
 .../asic_reg/rot0_qm_axuser_nonsecured_regs.h |    61 +
 .../gaudi2/asic_reg/rot0_qm_cgm_regs.h        |    29 +
 .../include/gaudi2/asic_reg/rot0_qm_regs.h    |  1057 +
 .../include/gaudi2/asic_reg/rot0_regs.h       |   111 +
 .../gaudi2/asic_reg/xbar_edge_0_regs.h        |   199 +
 .../include/gaudi2/asic_reg/xbar_mid_0_regs.h |   199 +
 .../misc/habanalabs/include/gaudi2/gaudi2.h   |   120 +
 .../include/gaudi2/gaudi2_async_events.h      |   963 +
 .../gaudi2/gaudi2_async_ids_map_extended.h    |  2668 +
 .../include/gaudi2/gaudi2_async_virt_events.h |    57 +
 .../include/gaudi2/gaudi2_coresight.h         |   984 +
 .../habanalabs/include/gaudi2/gaudi2_fw_if.h  |    99 +
 .../include/gaudi2/gaudi2_packets.h           |   197 +
 .../include/gaudi2/gaudi2_reg_map.h           |    59 +
 .../include/hw_ip/mmu/mmu_general.h           |    14 +-
 .../habanalabs/include/hw_ip/mmu/mmu_v2_0.h   |    51 +
 include/uapi/misc/habanalabs.h                |   455 +-
 201 files changed, 157843 insertions(+), 432 deletions(-)
 create mode 100644 drivers/misc/habanalabs/common/decoder.c
 create mode 100644 drivers/misc/habanalabs/common/mmu/mmu_v2_hr.c
 create mode 100644 drivers/misc/habanalabs/common/security.c
 create mode 100644 drivers/misc/habanalabs/gaudi2/Makefile
 create mode 100644 drivers/misc/habanalabs/gaudi2/gaudi2.c
 create mode 100644 drivers/misc/habanalabs/gaudi2/gaudi2P.h
 create mode 100644 drivers/misc/habanalabs/gaudi2/gaudi2_coresight.c
 create mode 100644 drivers/misc/habanalabs/gaudi2/gaudi2_coresight_regs.h
 create mode 100644 drivers/misc/habanalabs/gaudi2/gaudi2_masks.h
 create mode 100644 drivers/misc/habanalabs/gaudi2/gaudi2_security.c
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/arc/gaudi2_arc_common_packets.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/arc_farm_arc0_acp_eng_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/arc_farm_arc0_aux_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/arc_farm_arc0_aux_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/arc_farm_arc0_dup_eng_axuser_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/arc_farm_arc0_dup_eng_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/arc_farm_kdma_ctx_axuser_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/arc_farm_kdma_ctx_axuser_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/arc_farm_kdma_ctx_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/arc_farm_kdma_ctx_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/arc_farm_kdma_kdma_cgm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/arc_farm_kdma_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/arc_farm_kdma_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/cpu_if_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_dec0_cmd_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_dec0_cmd_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_edma0_core_ctx_axuser_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_edma0_core_ctx_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_edma0_core_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_edma0_core_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_edma0_qm_arc_aux_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_edma0_qm_axuser_nonsecured_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_edma0_qm_cgm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_edma0_qm_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_edma0_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_edma1_core_ctx_axuser_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_edma1_qm_axuser_nonsecured_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_hmmu0_mmu_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_hmmu0_mmu_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_hmmu0_stlb_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_hmmu0_stlb_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_acc_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_cout0_master_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_cout0_slave_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_cout1_master_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_cout1_slave_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_in0_master_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_in0_slave_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_in1_master_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_in1_slave_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_in2_master_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_in2_slave_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_in3_master_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_in3_slave_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_in4_master_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_agu_in4_slave_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_base_addr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_non_tensor_end_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_non_tensor_start_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_tensor_a_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_tensor_b_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_arch_tensor_cout_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_mme_axuser_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_ctrl_lo_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_qm_arc_acp_eng_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_qm_arc_aux_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_qm_arc_dup_eng_axuser_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_qm_arc_dup_eng_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_qm_axuser_nonsecured_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_qm_axuser_secured_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_qm_cgm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_sbte0_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_sbte0_mstr_if_axuser_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_mme_wb0_mstr_if_axuser_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_rtr0_ctrl_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_rtr0_mstr_if_rr_prvt_hbw_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_rtr0_mstr_if_rr_prvt_lbw_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_rtr0_mstr_if_rr_shrd_hbw_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_rtr0_mstr_if_rr_shrd_lbw_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_sync_mngr_glbl_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_sync_mngr_glbl_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_sync_mngr_mstr_if_axuser_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_sync_mngr_mstr_if_axuser_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_sync_mngr_objs_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_sync_mngr_objs_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_cfg_axuser_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_cfg_kernel_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_cfg_kernel_tensor_0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_cfg_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_cfg_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_cfg_qm_sync_object_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_cfg_qm_tensor_0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_cfg_special_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_eml_busmon_0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_eml_etf_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_eml_funnel_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_eml_spmu_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_eml_stm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_qm_arc_aux_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_qm_axuser_nonsecured_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_qm_cgm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_tpc0_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_vdec0_brdg_ctrl_axuser_dec_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_vdec0_brdg_ctrl_axuser_msix_abnrm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_vdec0_brdg_ctrl_axuser_msix_l2c_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_vdec0_brdg_ctrl_axuser_msix_nrm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_vdec0_brdg_ctrl_axuser_msix_vcd_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_vdec0_brdg_ctrl_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_vdec0_brdg_ctrl_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore0_vdec0_ctrl_special_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore1_mme_ctrl_lo_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/dcore3_mme_ctrl_lo_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/gaudi2_blocks_linux_driver.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/gaudi2_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/nic0_qm0_cgm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/nic0_qm0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/nic0_qm_arc_aux0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/nic0_qpc0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/nic0_umr0_0_completion_queue_ci_1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/nic0_umr0_0_unsecure_doorbell0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_aux_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_dbi_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_dec0_cmd_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_dec0_cmd_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_vdec0_brdg_ctrl_axuser_dec_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_vdec0_brdg_ctrl_axuser_msix_abnrm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_vdec0_brdg_ctrl_axuser_msix_l2c_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_vdec0_brdg_ctrl_axuser_msix_nrm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_vdec0_brdg_ctrl_axuser_msix_vcd_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_vdec0_brdg_ctrl_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_vdec0_brdg_ctrl_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_vdec0_ctrl_special_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pcie_wrap_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma0_core_ctx_axuser_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma0_core_ctx_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma0_core_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma0_core_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma0_core_special_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma0_qm_arc_aux_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma0_qm_axuser_nonsecured_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma0_qm_axuser_secured_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma0_qm_cgm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma0_qm_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma0_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma1_core_ctx_axuser_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pdma1_qm_axuser_nonsecured_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pmmu_hbw_stlb_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pmmu_hbw_stlb_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/pmmu_pif_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/psoc_etr_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/psoc_etr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/psoc_global_conf_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/psoc_global_conf_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/psoc_reset_conf_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/psoc_reset_conf_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/psoc_timestamp_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/rot0_desc_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/rot0_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/rot0_qm_arc_aux_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/rot0_qm_axuser_nonsecured_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/rot0_qm_cgm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/rot0_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/rot0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/xbar_edge_0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/asic_reg/xbar_mid_0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/gaudi2.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/gaudi2_async_events.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/gaudi2_async_ids_map_extended.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/gaudi2_async_virt_events.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/gaudi2_coresight.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/gaudi2_fw_if.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/gaudi2_packets.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi2/gaudi2_reg_map.h
 create mode 100644 drivers/misc/habanalabs/include/hw_ip/mmu/mmu_v2_0.h

-- 
2.25.1

