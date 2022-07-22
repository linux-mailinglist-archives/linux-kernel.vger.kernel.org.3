Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D7157DB7E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 09:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbiGVHtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 03:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbiGVHtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:49:11 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8289A5D8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 00:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1658476145; bh=D7dPB4B0Ci6KwFGskz6CnVceeEcRoUxZ7uwpqc3Ex6E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Qef991VRc4Uy0n3RBy2ITcz6jZDviFFNegVfMweNPVi4Q6p/tlPFx/WzZb3ySFgUz
         QDkY1LYzloqChyGMZGqG+vJuZU2GqgTd8q3QyunF+sTpjUfno5xjb2vGAaZ3N5GeFT
         zgf/TljJ/du1D1iMokmP6qXt6OTN3B+IRNCdWL04=
Received: from [100.100.35.250] (unknown [58.34.185.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 0BBA560610;
        Fri, 22 Jul 2022 15:49:05 +0800 (CST)
Message-ID: <6c89e5de-927d-2cf1-1ed5-fef882f45a5a@xen0n.name>
Date:   Fri, 22 Jul 2022 15:49:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:104.0)
 Gecko/20100101 Thunderbird/104.0a1
Subject: Re: [PATCH] LoongArch: Fix wrong "ROM Size" of boardinfo
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <1658397181-2095-1-git-send-email-yangtiezhu@loongson.cn>
Content-Language: en-US
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <1658397181-2095-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/21 17:53, Tiezhu Yang wrote:
> We can see the "ROM Size" is different in the following outputs:
>
> [root@linux loongson]# cat /sys/firmware/loongson/boardinfo
> BIOS Information
> Vendor                  : Loongson
> Version                 : vUDK2018-LoongArch-V2.0.pre-beta8
> ROM Size                : 63 KB
> Release Date            : 06/15/2022
>
> Board Information
> Manufacturer            : Loongson
> Board Name              : Loongson-LS3A5000-7A1000-1w-A2101
> Family                  : LOONGSON64
>
> [root@linux loongson]# dmidecode | head -11
> ...
> Handle 0x0000, DMI type 0, 26 bytes
> BIOS Information
> 	Vendor: Loongson
> 	Version: vUDK2018-LoongArch-V2.0.pre-beta8
> 	Release Date: 06/15/2022
> 	ROM Size: 4 MB
>
> According to "BIOS Information (Type 0) structure" in the SMBIOS
> Reference Specification [1], it shows 64K * (n+1) is the size of
> the physical device containing the BIOS if the size is less than
> 16M.
>
> Additionally, we can see the related code in dmidecode [2]:
>
>    u64 s = { .l = (code1 + 1) << 6 };
>
> So the output of dmidecode is correct, the output of boardinfo
> is wrong, fix it.
>
> By the way, at present no need to consider the size is 16M or
> greater on LoongArch, because it is usually 4M or 8M which is
> enough to use.
Although the commit message is a bit Chinglish, the inclusion of code 
and snippets have all complemented the description, so overall it 
doesn't hamper understanding and I'm mostly okay with it.
>
> [1] https://www.dmtf.org/sites/default/files/standards/documents/DSP0134_3.6.0.pdf
> [2] https://git.savannah.nongnu.org/cgit/dmidecode.git/tree/dmidecode.c#n347
>
> Fixes: 628c3bb40e9a ("LoongArch: Add boot and setup routines")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   arch/loongarch/kernel/setup.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
> index c74860b..8f5c2f9 100644
> --- a/arch/loongarch/kernel/setup.c
> +++ b/arch/loongarch/kernel/setup.c
> @@ -126,7 +126,7 @@ static void __init parse_bios_table(const struct dmi_header *dm)
>   	char *dmi_data = (char *)dm;
>   
>   	bios_extern = *(dmi_data + SMBIOS_BIOSEXTERN_OFFSET);
> -	b_info.bios_size = *(dmi_data + SMBIOS_BIOSSIZE_OFFSET);
> +	b_info.bios_size = (*(dmi_data + SMBIOS_BIOSSIZE_OFFSET) + 1) << 6;
>   
>   	if (bios_extern & LOONGSON_EFI_ENABLE)
>   		set_bit(EFI_BOOT, &efi.flags);

I've tested on real 3A5000 hardware and confirmed this is working.

$ cat /sys/firmware/loongson/boardinfo
BIOS Information
Vendor                  : Loongson
Version                 : vUDK2018-LoongArch-V2.0.pre-beta8
ROM Size                : 4096 KB
Release Date            : 06/15/2022

Board Information
Manufacturer            : Loongson
Board Name              : Loongson-LS3A5000-7A1000-1w-A2101
Family                  : LOONGSON64


So,

Reviewed-by: WANG Xuerui <git@xen0n.name>

