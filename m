Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08632578251
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbiGRM2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiGRM23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:28:29 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0CAC025E82
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:28:27 -0700 (PDT)
Received: from [10.20.42.19] (unknown [10.20.42.19])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx7+PcUdViYbQmAA--.8726S3;
        Mon, 18 Jul 2022 20:28:12 +0800 (CST)
Subject: Re: [PATCH V15 01/15] ACPICA: MADT: Add LoongArch APICs support
To:     Marc Zyngier <maz@kernel.org>,
        Robert Moore <robert.moore@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
References: <1657868751-30444-1-git-send-email-lvjianmin@loongson.cn>
 <1657868751-30444-2-git-send-email-lvjianmin@loongson.cn>
 <87mtd93p3n.wl-maz@kernel.org>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <7ed06824-4ccb-a9c4-fa01-583006ab90c1@loongson.cn>
Date:   Mon, 18 Jul 2022 20:28:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87mtd93p3n.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dx7+PcUdViYbQmAA--.8726S3
X-Coremail-Antispam: 1UD129KBjvJXoW3AFyxZw4DZr4DXFy7Cry7trb_yoWxCFy8pr
        ZrCw17Kw4UXr1ftF1aqw4Yva43Ja4SkF1xZwsxGa4xCFnrKF47XF1vkF13WFW3ta1rKay0
        vw10q3W8ua1UArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU901xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
        ACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE-syl
        42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW5Wr1UJr1l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0D
        MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
        VFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/7/17 上午2:10, Marc Zyngier wrote:
> [+ Robert Moore]
> 
> On Fri, 15 Jul 2022 08:05:37 +0100,
> Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>
>> From: Huacai Chen <chenhuacai@loongson.cn>
>>
>> LoongArch-specific interrupt controllers (similar to APIC) are added
>> in the next revision of ACPI Specification (current revision is 6.4),
>> which including CORE_PIC (CPUINTC), LIO_PIC (LIOINTC), EIO_PIC (EIOINTC),
>> HT_PIC (HTVECINTC), BIO_PIC (PCHINTC), LPC_PIC (PCHLPC) and MSI_PIC
>> (PCHMSI). This patch add their definition.
>>
>> ACPI changes of LoongArch-specific interrupt controllers have already
>> been approved in the ECRs, and will be public in the next revision of
>> ACPI Specification.
>>
>> Reference: https://mantis.uefi.org/mantis/view.php?id=2203
>> Reference: https://mantis.uefi.org/mantis/view.php?id=2313
>>
>> Above links needs login(available for ASWG), so the following link(
>> the ECR file for adding LoongArch APICs into ACPI spec) is provided
>> for public:
>>
>> https://github.com/lvjianmin-loongson/acpica/blob/master/Add%20APIC%20Structures%20for%20Loongarch%20in%20MADT-rev3.pdf
>>
>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> 
> Since the ACPI maintainers are unwilling to take this patch (for
> undisclosed reasons), we need something to unblock this sorry
> situation, as I don't think it is fair on the LoongArch folks to be
> blocked for another cycle on this ground only.
> 
> I'm proposing to replace this patch with the following, which will
> allow the patches to be merged without breaking anything. Once the
> ACPI support is updated, we'll be able to simply revert this patch.
> 
> Thanks,
> 
> 	M.
> 
>  From 43ec25d2dbde3c422cce430c9d5ec32fbe7b255c Mon Sep 17 00:00:00 2001
> From: Marc Zyngier <maz@kernel.org>
> Date: Sat, 16 Jul 2022 18:56:10 +0100
> Subject: [PATCH] LoongArch: Provisionally add ACPICA data structures
> 
> The LoongArch architecture is using ACPI, but the spec containing
> the required updates still is in an unreleased state.
> 
> Instead of preventing the inclusion of the IRQ support into the
> kernel, add the missing bits to the arch-specific parts of
> the ACPICA support.
> 
> Once the ACPICA bits are updated to the version that supports
> LoongArch, these bits can eventually be removed.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>   arch/loongarch/include/asm/acpi.h | 138 ++++++++++++++++++++++++++++++
>   1 file changed, 138 insertions(+)
> 
> diff --git a/arch/loongarch/include/asm/acpi.h b/arch/loongarch/include/asm/acpi.h
> index 62044cd5b7bc..6155e46098af 100644
> --- a/arch/loongarch/include/asm/acpi.h
> +++ b/arch/loongarch/include/asm/acpi.h
> @@ -31,6 +31,144 @@ static inline bool acpi_has_cpu_in_madt(void)
>   
>   extern struct list_head acpi_wakeup_device_list;
>   
> +/*
> + * Temporary definitions until the core ACPICA code gets updated (see
> + * 1656837932-18257-1-git-send-email-lvjianmin@loongson.cn and its
> + * follow-ups for the "rationale").
> + *
> + * Once the "legal reasons" are cleared and that the code is merged,
> + * this can be dropped entierely.
> + */
> +#if (ACPI_CA_VERSION == 0x20220331 && !defined(LOONGARCH_ACPICA_EXT))
> +
> +#define LOONGARCH_ACPICA_EXT	1
> +
> +#define	ACPI_MADT_TYPE_CORE_PIC		17
> +#define	ACPI_MADT_TYPE_LIO_PIC		18
> +#define	ACPI_MADT_TYPE_HT_PIC		19
> +#define	ACPI_MADT_TYPE_EIO_PIC		20
> +#define	ACPI_MADT_TYPE_MSI_PIC		21
> +#define	ACPI_MADT_TYPE_BIO_PIC		22
> +#define	ACPI_MADT_TYPE_LPC_PIC		23
> +
> +/* Values for Version field above */
> +
> +enum acpi_madt_core_pic_version {
> +	ACPI_MADT_CORE_PIC_VERSION_NONE = 0,
> +	ACPI_MADT_CORE_PIC_VERSION_V1 = 1,
> +	ACPI_MADT_CORE_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
> +};
> +
> +enum acpi_madt_lio_pic_version {
> +	ACPI_MADT_LIO_PIC_VERSION_NONE = 0,
> +	ACPI_MADT_LIO_PIC_VERSION_V1 = 1,
> +	ACPI_MADT_LIO_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
> +};
> +
> +enum acpi_madt_eio_pic_version {
> +	ACPI_MADT_EIO_PIC_VERSION_NONE = 0,
> +	ACPI_MADT_EIO_PIC_VERSION_V1 = 1,
> +	ACPI_MADT_EIO_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
> +};
> +
> +enum acpi_madt_ht_pic_version {
> +	ACPI_MADT_HT_PIC_VERSION_NONE = 0,
> +	ACPI_MADT_HT_PIC_VERSION_V1 = 1,
> +	ACPI_MADT_HT_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
> +};
> +
> +enum acpi_madt_bio_pic_version {
> +	ACPI_MADT_BIO_PIC_VERSION_NONE = 0,
> +	ACPI_MADT_BIO_PIC_VERSION_V1 = 1,
> +	ACPI_MADT_BIO_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
> +};
> +
> +enum acpi_madt_msi_pic_version {
> +	ACPI_MADT_MSI_PIC_VERSION_NONE = 0,
> +	ACPI_MADT_MSI_PIC_VERSION_V1 = 1,
> +	ACPI_MADT_MSI_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
> +};
> +
> +enum acpi_madt_lpc_pic_version {
> +	ACPI_MADT_LPC_PIC_VERSION_NONE = 0,
> +	ACPI_MADT_LPC_PIC_VERSION_V1 = 1,
> +	ACPI_MADT_LPC_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
> +};
> +

Hi, Marc, I add #pragma here to make following structures align to 1 
byte as include/acpi/actbl2.h, or else, the MADT will not be parsed 
correctly.

#pragma pack(1)

> +/* Core Interrupt Controller */
> +
> +struct acpi_madt_core_pic {
> +	struct acpi_subtable_header header;
> +	u8 version;
> +	u32 processor_id;
> +	u32 core_id;
> +	u32 flags;
> +};
> +
> +/* Legacy I/O Interrupt Controller */
> +
> +struct acpi_madt_lio_pic {
> +	struct acpi_subtable_header header;
> +	u8 version;
> +	u64 address;
> +	u16 size;
> +	u8 cascade[2];
> +	u32 cascade_map[2];
> +};
> +
> +/* Extend I/O Interrupt Controller */
> +
> +struct acpi_madt_eio_pic {
> +	struct acpi_subtable_header header;
> +	u8 version;
> +	u8 cascade;
> +	u8 node;
> +	u64 node_map;
> +};
> +
> +/* HT Interrupt Controller */
> +
> +struct acpi_madt_ht_pic {
> +	struct acpi_subtable_header header;
> +	u8 version;
> +	u64 address;
> +	u16 size;
> +	u8 cascade[8];
> +};
> +
> +/* Bridge I/O Interrupt Controller */
> +
> +struct acpi_madt_bio_pic {
> +	struct acpi_subtable_header header;
> +	u8 version;
> +	u64 address;
> +	u16 size;
> +	u16 id;
> +	u16 gsi_base;
> +};
> +
> +/* MSI Interrupt Controller */
> +
> +struct acpi_madt_msi_pic {
> +	struct acpi_subtable_header header;
> +	u8 version;
> +	u64 msg_address;
> +	u32 start;
> +	u32 count;
> +};
> +
> +/* LPC Interrupt Controller */
> +
> +struct acpi_madt_lpc_pic {
> +	struct acpi_subtable_header header;
> +	u8 version;
> +	u64 address;
> +	u16 size;
> +	u8 cascade;
> +};
> +

#pragma pack()

> +#endif
> +
>   #endif /* !CONFIG_ACPI */
>   
>   #define ACPI_TABLE_UPGRADE_MAX_PHYS ARCH_LOW_ADDRESS_LIMIT
> 

