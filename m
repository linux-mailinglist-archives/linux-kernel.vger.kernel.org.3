Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C2358A71B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 09:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237582AbiHEHb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 03:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbiHEHbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 03:31:25 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE9DCBC0E;
        Fri,  5 Aug 2022 00:31:23 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxQM9Cx+xiA5sHAA--.28007S2;
        Fri, 05 Aug 2022 15:31:15 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     lpieralisi@kernel.org, robin.murphy@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
        robert.moore@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH V2 0/2] DMA: update acpi_dma_get_range to return dma map regions 
Date:   Fri,  5 Aug 2022 15:31:12 +0800
Message-Id: <1659684674-40612-1-git-send-email-lvjianmin@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AQAAf9DxQM9Cx+xiA5sHAA--.28007S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr1ftw4DWw4xZw1xCw1DAwb_yoWDtwb_Aa
        93Ja48Gr4vgFy5XFy7try3Jr98tF4IqF4j93Wvqw4UAr17Jr1UGr4jyF4Ivr12vF4UGrs8
        Z3yjvry8Ar1UtjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4kYjsxI4VWkCwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
        s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
        kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
        Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
        0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY
        6x8ErcxFaVAv8VW5Wr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2xR6UU
        UUU
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Jianmin Lv (2):
  ACPI / scan: Support multiple dma windows with different offsets
  LoongArch: Remove ARCH_HAS_PHYS_TO_DMA

 arch/loongarch/Kconfig        |  1 -
 arch/loongarch/kernel/dma.c   | 62 +++++++++++++++++++++----------------------
 arch/loongarch/kernel/setup.c |  2 +-
 drivers/acpi/arm64/dma.c      | 44 ++++++++++++++++++++++--------
 drivers/acpi/scan.c           | 48 ++++++++++++++++-----------------
 include/acpi/acpi_bus.h       |  3 +--
 include/linux/acpi.h          | 12 +++++----
 7 files changed, 97 insertions(+), 75 deletions(-)

-- 
1.8.3.1

