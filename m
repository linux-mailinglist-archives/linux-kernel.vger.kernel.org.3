Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E1047964B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 22:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhLQVcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 16:32:02 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:32962 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhLQVcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 16:32:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0B5B623E1;
        Fri, 17 Dec 2021 21:32:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130ECC36AE2;
        Fri, 17 Dec 2021 21:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639776720;
        bh=YK9Oe77zivtjF3VITRs9BXvD9ia6c7L4mODLnm294y8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EL8ZJ6zlgHnByQBIztdtELD8vP3niuv3traRTu20bQg2zXSAoxPwS85bbHUgJgWwa
         pMce0xX74+BtAYLDpQIfQbDH9dwWfvUfyl6Z4k9eZFucrw01rkPcX3lAU1qw9mNwbO
         545TS0g0vNUIQQBjj9EejWZoSlzXhSRvAlL5o+GhetkAoOwP3ZcXt2F7LgIvQLtmK1
         ZoZXGgeG0AZn++Rv+jDncHIVuvtDzJt0Ru4u8HApNUG1RjmH8dfuOeYTUT4aN6Cxyi
         nvVZAjGtn1IPSuMSbIDBYsDaHdhkhXpnGV0yf6yKjVAbKkOXzLO1q6uEdBu+4bLKM2
         aGTA8XQR38IPA==
Subject: Re: [PATCH v3 4/4] arm64: arch_k3: Select GPMC device driver
To:     Nishanth Menon <nm@ti.com>
Cc:     krzysztof.kozlowski@canonical.com, tony@atomide.com,
        robh@kernel.org, kishon@ti.com, vigneshr@ti.com,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20211217102945.17432-1-rogerq@kernel.org>
 <20211217102945.17432-5-rogerq@kernel.org>
 <20211217161417.q2qwwlki7oieqzjd@headlock>
From:   Roger Quadros <rogerq@kernel.org>
Message-ID: <ab7ad49c-046b-eebf-1b4e-ca1314efbbae@kernel.org>
Date:   Fri, 17 Dec 2021 23:31:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211217161417.q2qwwlki7oieqzjd@headlock>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nishanth,

On 17/12/2021 18:14, Nishanth Menon wrote:
> On 12:29-20211217, Roger Quadros wrote:
>> The GPMC controller is present on some K3 SoCs.
>> It provides access to NOR/NAND flashes and asynchronous
>> SRAM-like memories and ASICs.
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  arch/arm64/Kconfig.platforms | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>> index 1aa8b7073218..f447b120f863 100644
>> --- a/arch/arm64/Kconfig.platforms
>> +++ b/arch/arm64/Kconfig.platforms
>> @@ -122,6 +122,7 @@ config ARCH_K3
>>  	select TI_SCI_INTR_IRQCHIP
>>  	select TI_SCI_INTA_IRQCHIP
>>  	select TI_K3_SOCINFO
>> +	select OMAP_GPMC
> I dont think GPMC should be part of the select list here. instead
> defconfig patch is prefered. the existance and usage of the same are
> limited and it is NOT a core functional component required to boot up a
> K3 platform.
> 

Since OMAP_GPMC is not visible it cannot be enabled via defconfig file.
I tried to make it visible in earlier revision of this patchset but it looks
like OMAP_GPMC config was meant to be not a visible option form the beginning.

All legacy platforms have been selecting it in some way or the other but I agree
with you that selecting it at SOC level may not be the best option.

If not here, any suggestions where should I select it from? Maybe from
mtd/nand/raw/Kconfig if GPMC NAND driver is enabled?

cheers,
-roger
