Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA05E4E5365
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 14:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiCWNmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 09:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244396AbiCWNmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:42:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 211C17D03D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 06:40:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A15EC23A;
        Wed, 23 Mar 2022 06:40:44 -0700 (PDT)
Received: from [10.57.43.230] (unknown [10.57.43.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40F353F73D;
        Wed, 23 Mar 2022 06:40:43 -0700 (PDT)
Message-ID: <baa516fe-23c2-fafd-d440-5d57852e6b50@arm.com>
Date:   Wed, 23 Mar 2022 13:40:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] iommu/arm: Expose ARM SMMUv3 related registers via sysfs
Content-Language: en-GB
To:     Miguel Luis <miguel.luis@oracle.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     david.edmondson@oracle.com, joao.m.martins@oracle.com
References: <20220323125500.76684-1-miguel.luis@oracle.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220323125500.76684-1-miguel.luis@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-23 12:54, Miguel Luis wrote:
> Allows userspace to check for SMMUv3 features.

What will userspace do with that information?

It hardly matters what fancy new features might be present, if the 
kernel and/or the abstracted interfaces available to userspace aren't 
using them. Any functionality which is supported by a usable interface 
should ideally be represented via that interface itself.

Furthermore many of the raw SMMU features depend on other system 
components and/or firmware, so the ID registers alone don't tell the 
full story anyway.

> Expose the following RO registers related to ARM SMMUv3 via sysfs:
> SMMU_IDR0
> SMMU_IDR1
> SMMU_IDR2
> SMMU_IDR3
> SMMU_IDR4
> SMMU_IDR5
> SMMU_IDR6
> SMMU_IIDR
> SMMU_AIDR
> 
>   # find /sys | grep arm-iommu
> /sys/devices/platform/9050000.smmuv3/iommu/smmu3.0x0000000009050000/arm-iommu

Nit: my main comment above notwithstanding, is this level of hierarchcy 
meaningful or useful? "arm-iommu" isn't an established name for anything 
as far as I'm aware.

Robin.

> /sys/devices/platform/9050000.smmuv3/iommu/smmu3.0x0000000009050000/arm-iommu/smmu_idr5
> /sys/devices/platform/9050000.smmuv3/iommu/smmu3.0x0000000009050000/arm-iommu/smmu_idr3
> /sys/devices/platform/9050000.smmuv3/iommu/smmu3.0x0000000009050000/arm-iommu/smmu_idr1
> /sys/devices/platform/9050000.smmuv3/iommu/smmu3.0x0000000009050000/arm-iommu/smmu_aidr
> /sys/devices/platform/9050000.smmuv3/iommu/smmu3.0x0000000009050000/arm-iommu/smmu_idr6
> /sys/devices/platform/9050000.smmuv3/iommu/smmu3.0x0000000009050000/arm-iommu/smmu_idr4
> /sys/devices/platform/9050000.smmuv3/iommu/smmu3.0x0000000009050000/arm-iommu/smmu_iidr
> /sys/devices/platform/9050000.smmuv3/iommu/smmu3.0x0000000009050000/arm-iommu/smmu_idr2
> /sys/devices/platform/9050000.smmuv3/iommu/smmu3.0x0000000009050000/arm-iommu/smmu_idr0
> 
> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 199 ++++++++++++++++----
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  27 +++
>   2 files changed, 191 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 6dc6d8b6b368..7f779d3f88f2 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3424,17 +3424,16 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
>   
>   static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>   {
> -	u32 reg;
>   	bool coherent = smmu->features & ARM_SMMU_FEAT_COHERENCY;
>   
>   	/* IDR0 */
> -	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR0);
> +	smmu->idr0 = readl_relaxed(smmu->base + ARM_SMMU_IDR0);
>   
>   	/* 2-level structures */
> -	if (FIELD_GET(IDR0_ST_LVL, reg) == IDR0_ST_LVL_2LVL)
> +	if (FIELD_GET(IDR0_ST_LVL, smmu->idr0) == IDR0_ST_LVL_2LVL)
>   		smmu->features |= ARM_SMMU_FEAT_2_LVL_STRTAB;
>   
> -	if (reg & IDR0_CD2L)
> +	if (smmu->idr0 & IDR0_CD2L)
>   		smmu->features |= ARM_SMMU_FEAT_2_LVL_CDTAB;
>   
>   	/*
> @@ -3442,7 +3441,7 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>   	 * We currently require the same endianness as the CPU, but this
>   	 * could be changed later by adding a new IO_PGTABLE_QUIRK.
>   	 */
> -	switch (FIELD_GET(IDR0_TTENDIAN, reg)) {
> +	switch (FIELD_GET(IDR0_TTENDIAN, smmu->idr0)) {
>   	case IDR0_TTENDIAN_MIXED:
>   		smmu->features |= ARM_SMMU_FEAT_TT_LE | ARM_SMMU_FEAT_TT_BE;
>   		break;
> @@ -3461,22 +3460,22 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>   	}
>   
>   	/* Boolean feature flags */
> -	if (IS_ENABLED(CONFIG_PCI_PRI) && reg & IDR0_PRI)
> +	if (IS_ENABLED(CONFIG_PCI_PRI) && smmu->idr0 & IDR0_PRI)
>   		smmu->features |= ARM_SMMU_FEAT_PRI;
>   
> -	if (IS_ENABLED(CONFIG_PCI_ATS) && reg & IDR0_ATS)
> +	if (IS_ENABLED(CONFIG_PCI_ATS) && smmu->idr0 & IDR0_ATS)
>   		smmu->features |= ARM_SMMU_FEAT_ATS;
>   
> -	if (reg & IDR0_SEV)
> +	if (smmu->idr0 & IDR0_SEV)
>   		smmu->features |= ARM_SMMU_FEAT_SEV;
>   
> -	if (reg & IDR0_MSI) {
> +	if (smmu->idr0 & IDR0_MSI) {
>   		smmu->features |= ARM_SMMU_FEAT_MSI;
>   		if (coherent && !disable_msipolling)
>   			smmu->options |= ARM_SMMU_OPT_MSIPOLL;
>   	}
>   
> -	if (reg & IDR0_HYP) {
> +	if (smmu->idr0 & IDR0_HYP) {
>   		smmu->features |= ARM_SMMU_FEAT_HYP;
>   		if (cpus_have_cap(ARM64_HAS_VIRT_HOST_EXTN))
>   			smmu->features |= ARM_SMMU_FEAT_E2H;
> @@ -3486,11 +3485,11 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>   	 * The coherency feature as set by FW is used in preference to the ID
>   	 * register, but warn on mismatch.
>   	 */
> -	if (!!(reg & IDR0_COHACC) != coherent)
> +	if (!!(smmu->idr0 & IDR0_COHACC) != coherent)
>   		dev_warn(smmu->dev, "IDR0.COHACC overridden by FW configuration (%s)\n",
>   			 coherent ? "true" : "false");
>   
> -	switch (FIELD_GET(IDR0_STALL_MODEL, reg)) {
> +	switch (FIELD_GET(IDR0_STALL_MODEL, smmu->idr0)) {
>   	case IDR0_STALL_MODEL_FORCE:
>   		smmu->features |= ARM_SMMU_FEAT_STALL_FORCE;
>   		fallthrough;
> @@ -3498,19 +3497,19 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>   		smmu->features |= ARM_SMMU_FEAT_STALLS;
>   	}
>   
> -	if (reg & IDR0_S1P)
> +	if (smmu->idr0 & IDR0_S1P)
>   		smmu->features |= ARM_SMMU_FEAT_TRANS_S1;
>   
> -	if (reg & IDR0_S2P)
> +	if (smmu->idr0 & IDR0_S2P)
>   		smmu->features |= ARM_SMMU_FEAT_TRANS_S2;
>   
> -	if (!(reg & (IDR0_S1P | IDR0_S2P))) {
> +	if (!(smmu->idr0 & (IDR0_S1P | IDR0_S2P))) {
>   		dev_err(smmu->dev, "no translation support!\n");
>   		return -ENXIO;
>   	}
>   
>   	/* We only support the AArch64 table format at present */
> -	switch (FIELD_GET(IDR0_TTF, reg)) {
> +	switch (FIELD_GET(IDR0_TTF, smmu->idr0)) {
>   	case IDR0_TTF_AARCH32_64:
>   		smmu->ias = 40;
>   		fallthrough;
> @@ -3522,19 +3521,20 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>   	}
>   
>   	/* ASID/VMID sizes */
> -	smmu->asid_bits = reg & IDR0_ASID16 ? 16 : 8;
> -	smmu->vmid_bits = reg & IDR0_VMID16 ? 16 : 8;
> +	smmu->asid_bits = smmu->idr0 & IDR0_ASID16 ? 16 : 8;
> +	smmu->vmid_bits = smmu->idr0 & IDR0_VMID16 ? 16 : 8;
>   
>   	/* IDR1 */
> -	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR1);
> -	if (reg & (IDR1_TABLES_PRESET | IDR1_QUEUES_PRESET | IDR1_REL)) {
> +	smmu->idr1 = readl_relaxed(smmu->base + ARM_SMMU_IDR1);
> +
> +	if (smmu->idr1 & (IDR1_TABLES_PRESET | IDR1_QUEUES_PRESET | IDR1_REL)) {
>   		dev_err(smmu->dev, "embedded implementation not supported\n");
>   		return -ENXIO;
>   	}
>   
>   	/* Queue sizes, capped to ensure natural alignment */
>   	smmu->cmdq.q.llq.max_n_shift = min_t(u32, CMDQ_MAX_SZ_SHIFT,
> -					     FIELD_GET(IDR1_CMDQS, reg));
> +					     FIELD_GET(IDR1_CMDQS, smmu->idr1));
>   	if (smmu->cmdq.q.llq.max_n_shift <= ilog2(CMDQ_BATCH_ENTRIES)) {
>   		/*
>   		 * We don't support splitting up batches, so one batch of
> @@ -3548,13 +3548,13 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>   	}
>   
>   	smmu->evtq.q.llq.max_n_shift = min_t(u32, EVTQ_MAX_SZ_SHIFT,
> -					     FIELD_GET(IDR1_EVTQS, reg));
> +					     FIELD_GET(IDR1_EVTQS, smmu->idr1));
>   	smmu->priq.q.llq.max_n_shift = min_t(u32, PRIQ_MAX_SZ_SHIFT,
> -					     FIELD_GET(IDR1_PRIQS, reg));
> +					     FIELD_GET(IDR1_PRIQS, smmu->idr1));
>   
>   	/* SID/SSID sizes */
> -	smmu->ssid_bits = FIELD_GET(IDR1_SSIDSIZE, reg);
> -	smmu->sid_bits = FIELD_GET(IDR1_SIDSIZE, reg);
> +	smmu->ssid_bits = FIELD_GET(IDR1_SSIDSIZE, smmu->idr1);
> +	smmu->sid_bits = FIELD_GET(IDR1_SIDSIZE, smmu->idr1);
>   
>   	/*
>   	 * If the SMMU supports fewer bits than would fill a single L2 stream
> @@ -3563,31 +3563,37 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>   	if (smmu->sid_bits <= STRTAB_SPLIT)
>   		smmu->features &= ~ARM_SMMU_FEAT_2_LVL_STRTAB;
>   
> +	/* IDR2 */
> +	smmu->idr2 = readl_relaxed(smmu->base + ARM_SMMU_IDR2);
> +
>   	/* IDR3 */
> -	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR3);
> -	if (FIELD_GET(IDR3_RIL, reg))
> +	smmu->idr3 = readl_relaxed(smmu->base + ARM_SMMU_IDR3);
> +	if (FIELD_GET(IDR3_RIL, smmu->idr3))
>   		smmu->features |= ARM_SMMU_FEAT_RANGE_INV;
>   
> +	/* IDR4 */
> +	smmu->idr4 = readl_relaxed(smmu->base + ARM_SMMU_IDR4);
> +
>   	/* IDR5 */
> -	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR5);
> +	smmu->idr5 = readl_relaxed(smmu->base + ARM_SMMU_IDR5);
>   
>   	/* Maximum number of outstanding stalls */
> -	smmu->evtq.max_stalls = FIELD_GET(IDR5_STALL_MAX, reg);
> +	smmu->evtq.max_stalls = FIELD_GET(IDR5_STALL_MAX, smmu->idr5);
>   
>   	/* Page sizes */
> -	if (reg & IDR5_GRAN64K)
> +	if (smmu->idr5 & IDR5_GRAN64K)
>   		smmu->pgsize_bitmap |= SZ_64K | SZ_512M;
> -	if (reg & IDR5_GRAN16K)
> +	if (smmu->idr5 & IDR5_GRAN16K)
>   		smmu->pgsize_bitmap |= SZ_16K | SZ_32M;
> -	if (reg & IDR5_GRAN4K)
> +	if (smmu->idr5 & IDR5_GRAN4K)
>   		smmu->pgsize_bitmap |= SZ_4K | SZ_2M | SZ_1G;
>   
>   	/* Input address size */
> -	if (FIELD_GET(IDR5_VAX, reg) == IDR5_VAX_52_BIT)
> +	if (FIELD_GET(IDR5_VAX, smmu->idr5) == IDR5_VAX_52_BIT)
>   		smmu->features |= ARM_SMMU_FEAT_VAX;
>   
>   	/* Output address size */
> -	switch (FIELD_GET(IDR5_OAS, reg)) {
> +	switch (FIELD_GET(IDR5_OAS, smmu->idr5)) {
>   	case IDR5_OAS_32_BIT:
>   		smmu->oas = 32;
>   		break;
> @@ -3632,6 +3638,16 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>   
>   	dev_info(smmu->dev, "ias %lu-bit, oas %lu-bit (features 0x%08x)\n",
>   		 smmu->ias, smmu->oas, smmu->features);
> +
> +	/* IDR6 */
> +	smmu->idr6 = readl_relaxed(smmu->base + ARM_SMMU_IDR6);
> +
> +	/* IIDR */
> +	smmu->iidr = readl_relaxed(smmu->base + ARM_SMMU_IIDR);
> +
> +	/* AIDR */
> +	smmu->aidr = readl_relaxed(smmu->base + ARM_SMMU_AIDR);
> +
>   	return 0;
>   }
>   
> @@ -3752,6 +3768,119 @@ static void __iomem *arm_smmu_ioremap(struct device *dev, resource_size_t start,
>   	return devm_ioremap_resource(dev, &res);
>   }
>   
> +static ssize_t smmu_idr0_show(struct device *dev,
> +			      struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct arm_smmu_device *smmu = dev_to_arm_smmu_device(dev);
> +
> +	return sprintf(buf, "%x\n", smmu->idr0);
> +}
> +static DEVICE_ATTR_RO(smmu_idr0);
> +
> +static ssize_t smmu_idr1_show(struct device *dev,
> +			      struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct arm_smmu_device *smmu = dev_to_arm_smmu_device(dev);
> +
> +	return sprintf(buf, "%x\n", smmu->idr1);
> +}
> +static DEVICE_ATTR_RO(smmu_idr1);
> +
> +static ssize_t smmu_idr2_show(struct device *dev,
> +			      struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct arm_smmu_device *smmu = dev_to_arm_smmu_device(dev);
> +
> +	return sprintf(buf, "%x\n", smmu->idr2);
> +}
> +static DEVICE_ATTR_RO(smmu_idr2);
> +
> +static ssize_t smmu_idr3_show(struct device *dev,
> +			      struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct arm_smmu_device *smmu = dev_to_arm_smmu_device(dev);
> +
> +	return sprintf(buf, "%x\n", smmu->idr3);
> +}
> +static DEVICE_ATTR_RO(smmu_idr3);
> +
> +static ssize_t smmu_idr4_show(struct device *dev,
> +			      struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct arm_smmu_device *smmu = dev_to_arm_smmu_device(dev);
> +
> +	return sprintf(buf, "%x\n", smmu->idr4);
> +}
> +static DEVICE_ATTR_RO(smmu_idr4);
> +
> +static ssize_t smmu_idr5_show(struct device *dev,
> +			      struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct arm_smmu_device *smmu = dev_to_arm_smmu_device(dev);
> +
> +	return sprintf(buf, "%x\n", smmu->idr5);
> +}
> +static DEVICE_ATTR_RO(smmu_idr5);
> +
> +static ssize_t smmu_idr6_show(struct device *dev,
> +			      struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct arm_smmu_device *smmu = dev_to_arm_smmu_device(dev);
> +
> +	return sprintf(buf, "%x\n", smmu->idr6);
> +}
> +static DEVICE_ATTR_RO(smmu_idr6);
> +
> +static ssize_t smmu_iidr_show(struct device *dev,
> +			      struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct arm_smmu_device *smmu = dev_to_arm_smmu_device(dev);
> +
> +	return sprintf(buf, "%x\n", smmu->iidr);
> +}
> +static DEVICE_ATTR_RO(smmu_iidr);
> +
> +static ssize_t smmu_aidr_show(struct device *dev,
> +			      struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct arm_smmu_device *smmu = dev_to_arm_smmu_device(dev);
> +
> +	return sprintf(buf, "%x\n", smmu->aidr);
> +}
> +static DEVICE_ATTR_RO(smmu_aidr);
> +
> +static struct attribute *arm_iommu_attrs[] = {
> +	&dev_attr_smmu_idr0.attr,
> +	&dev_attr_smmu_idr1.attr,
> +	&dev_attr_smmu_idr2.attr,
> +	&dev_attr_smmu_idr3.attr,
> +	&dev_attr_smmu_idr4.attr,
> +	&dev_attr_smmu_idr5.attr,
> +	&dev_attr_smmu_idr6.attr,
> +	&dev_attr_smmu_iidr.attr,
> +	&dev_attr_smmu_aidr.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group arm_iommu_group = {
> +	.name = "arm-iommu",
> +	.attrs = arm_iommu_attrs,
> +};
> +
> +static const struct attribute_group *arm_iommu_groups[] = {
> +	&arm_iommu_group,
> +	NULL,
> +};
> +
>   static int arm_smmu_device_probe(struct platform_device *pdev)
>   {
>   	int irq, ret;
> @@ -3839,7 +3968,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   		return ret;
>   
>   	/* And we're up. Go go go! */
> -	ret = iommu_device_sysfs_add(&smmu->iommu, dev, NULL,
> +	ret = iommu_device_sysfs_add(&smmu->iommu, dev, arm_iommu_groups,
>   				     "smmu3.%pa", &ioaddr);
>   	if (ret)
>   		return ret;
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index cd48590ada30..ffa1123bf37c 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -50,9 +50,13 @@
>   #define IDR1_SSIDSIZE			GENMASK(10, 6)
>   #define IDR1_SIDSIZE			GENMASK(5, 0)
>   
> +#define ARM_SMMU_IDR2			0x8
> +
>   #define ARM_SMMU_IDR3			0xc
>   #define IDR3_RIL			(1 << 10)
>   
> +#define ARM_SMMU_IDR4			0x10
> +
>   #define ARM_SMMU_IDR5			0x14
>   #define IDR5_STALL_MAX			GENMASK(31, 16)
>   #define IDR5_GRAN64K			(1 << 6)
> @@ -69,6 +73,9 @@
>   #define IDR5_VAX			GENMASK(11, 10)
>   #define IDR5_VAX_52_BIT			1
>   
> +#define ARM_SMMU_IIDR			0x18
> +#define ARM_SMMU_AIDR			0x1C
> +
>   #define ARM_SMMU_CR0			0x20
>   #define CR0_ATSCHK			(1 << 4)
>   #define CR0_CMDQEN			(1 << 3)
> @@ -154,6 +161,8 @@
>   
>   #define ARM_SMMU_REG_SZ			0xe00
>   
> +#define ARM_SMMU_IDR6			0x0190
> +
>   /* Common MSI config fields */
>   #define MSI_CFG0_ADDR_MASK		GENMASK_ULL(51, 2)
>   #define MSI_CFG2_SH			GENMASK(5, 4)
> @@ -669,6 +678,17 @@ struct arm_smmu_device {
>   
>   	struct arm_smmu_strtab_cfg	strtab_cfg;
>   
> +	/* SMMU feature registers */
> +	u32				idr0;
> +	u32				idr1;
> +	u32				idr2;
> +	u32				idr3;
> +	u32				idr4;
> +	u32				idr5;
> +	u32				idr6;
> +	u32				iidr;
> +	u32				aidr;
> +
>   	/* IOMMU core code handle */
>   	struct iommu_device		iommu;
>   
> @@ -676,6 +696,13 @@ struct arm_smmu_device {
>   	struct mutex			streams_mutex;
>   };
>   
> +static inline struct arm_smmu_device *dev_to_arm_smmu_device(struct device *dev)
> +{
> +	struct iommu_device *iommu = dev_to_iommu_device(dev);
> +
> +	return container_of(iommu, struct arm_smmu_device, iommu);
> +}
> +
>   struct arm_smmu_stream {
>   	u32				id;
>   	struct arm_smmu_master		*master;
