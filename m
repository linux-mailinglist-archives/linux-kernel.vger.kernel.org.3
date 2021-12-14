Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1C1474807
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhLNQ2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236199AbhLNQ1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:27:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D67C061574;
        Tue, 14 Dec 2021 08:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=uslCgpNux7UCWvRrQn0jiboSZeFlAwPdMrox4AtO3lY=; b=NA69IeRgKaAKGVIPZOXkudrLma
        LB4GLgor00uc8BI0/pGiViJ9hCO5G31dOaMt9n5+tGiVIKu1TJRf8W16fGRo5ZYEFdlQHSCN0htZn
        jsOofBk7FUY03UCo4Z6WxML0kucfTzx6UlJagPU+Z+piEnDtGHmRfqbXubz66BSn8RtyW8mPNHii9
        gX7ZEdDulliKRtIaGHZP31xYwF2pmYZY6B+TPPwejwrKVCdmCleglG35v8t7k+BuYa3CkmUQ62Dfb
        sw9nIv4AV2FGjfRkkp1e6k+UzTcFUfkG7tsgM6jvLT4RwVrQ14YvcK012oih2gbxIm+2q7eW/Waox
        vFUvJ+NQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxAdj-00DsaK-Fr; Tue, 14 Dec 2021 16:26:56 +0000
Message-ID: <8ab0ed95-ce79-cd61-0440-20e0242b8930@infradead.org>
Date:   Tue, 14 Dec 2021 08:26:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: linux-next: Tree for Dec 13 (SND_AMD_ACP_CONFIG)
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     alsa-devel@alsa-project.org,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211214030215.3181149-1-broonie@kernel.org>
 <8ff9d4b2-1905-2efa-cb86-e8f6cef06ef2@infradead.org>
 <15c3b6fe-b159-6cee-be67-11f2f2dd0d04@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <15c3b6fe-b159-6cee-be67-11f2f2dd0d04@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 12/14/21 05:51, Pierre-Louis Bossart wrote:
> 
> 
>> on i386 or x86_64:
>>
>> when # CONFIG_ACPI is not set,
>> so SND_SOC_ACPI is not set:
>>
>> WARNING: unmet direct dependencies detected for SND_AMD_ACP_CONFIG
>>   Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_ACPI [=n]
>>   Selected by [y]:
>>   - SND_SOC_AMD_ACP_COMMON [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && X86 [=y] && PCI [=y]
>>
>>
>> Full randconfig file is attached
> 
> It's probably triggered by my recent change to fix another problem.
> 
> d9b994cd7641 ASoC: AMD: acp-config: fix missing dependency on SND_SOC_ACPI
> 
> I didn't realize SND_AMD_ACP_CONFIG was selected by other configs.
> Moving to a select seems to fix the issue reported by Randy, not sure if
> it's the right thing to do though.
> 

That works. You can add my Ack if you want to push this patch.
Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

> 
> diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
> index bcfeb3fc2592..7a9e45094f37 100644
> --- a/sound/soc/amd/Kconfig
> +++ b/sound/soc/amd/Kconfig
> @@ -98,7 +98,7 @@ config SND_SOC_AMD_YC_MACH
> 
>  config SND_AMD_ACP_CONFIG
>         tristate "AMD ACP configuration selection"
> -       depends on SND_SOC_ACPI
> +       select SND_SOC_ACPI if ACPI
>         help
>          This option adds an auto detection to determine which ACP
>          driver modules to use
> 
> 

-- 
~Randy
