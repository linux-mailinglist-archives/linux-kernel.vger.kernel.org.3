Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A017E5A59AD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 05:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiH3DCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 23:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiH3DBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 23:01:49 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DB0C9C224;
        Mon, 29 Aug 2022 20:01:46 -0700 (PDT)
Received: from loongson-pc.loongson.cn (unknown [10.20.42.105])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx72uTfQ1jmS0MAA--.50840S2;
        Tue, 30 Aug 2022 11:01:39 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     lpieralisi@kernel.org, robin.murphy@arm.com, chenhuacai@loongson.cn
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        lenb@kernel.org, robert.moore@intel.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        loongarch@lists.linux.dev
Subject: [PATCH V3 0/2] DMA: update acpi_dma_get_range to return dma map regions 
Date:   Tue, 30 Aug 2022 11:01:37 +0800
Message-Id: <20220830030139.29899-1-lvjianmin@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx72uTfQ1jmS0MAA--.50840S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr1ftw4DWw4xZw1xCw1DAwb_yoWkKrg_AF
        Z3Ja48Gr1kWay5XFy7trW3tr98tFW7XF4Y93Wvqw4UCrnxJF1UXr1jyF47Zr17ZF18Grs8
        Za4jvryrZr17tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbaxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280
        aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r10
        6r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkIecxE
        wVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26ryrJr1UJwCFx2IqxVCFs4
        IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
        MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
        WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
        6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
        BIdaVFxhVjvjDU0xZFpf9x0JUZa9-UUUUU=
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch series changed acpi_dma_get_range to return dma regions
as of_dma_get_range, so that dev->dma_range_map can be initialized
conveniently.

And acpi_arch_dma_setup for ARM64 is changed wih removing dma_base
and size from it's parameters.

Remove ARCH_HAS_PHYS_TO_DMA for LoongArch and use generic
phys_to_dma/dma_to_phys in include/linux/dma-direct.h.

V1 -> V2
- Removed dma_base and size from acpi_arch_dma_setup' parameters
- Add patch to remove ARCH_HAS_PHYS_TO_DMA for LoongArch

V2 -> V3
- Add kerneldoc for acpi_dma_get_range changing
- Remove redundant code in acpi_arch_dma_setup, and check map


Jianmin Lv (2):
  ACPI / scan: Support multiple dma windows with different offsets
  LoongArch: Remove ARCH_HAS_PHYS_TO_DMA

 arch/loongarch/Kconfig        |  1 -
 arch/loongarch/kernel/dma.c   | 52 +++++++++++++++++-------------------------
 arch/loongarch/kernel/setup.c |  2 +-
 drivers/acpi/arm64/dma.c      | 29 ++++++++++++++---------
 drivers/acpi/scan.c           | 53 +++++++++++++++++++------------------------
 include/acpi/acpi_bus.h       |  3 +--
 include/linux/acpi.h          | 12 ++++++----
 7 files changed, 71 insertions(+), 81 deletions(-)

-- 
1.8.3.1

