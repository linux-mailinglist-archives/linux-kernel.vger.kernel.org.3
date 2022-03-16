Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CA54DBB32
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 00:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348998AbiCPXlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 19:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242323AbiCPXls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 19:41:48 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F98B19C2D;
        Wed, 16 Mar 2022 16:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=WjyIVz0q+UMbn1WR+oudjW9eiu0evgbI/MYyy3lxxoQ=; b=YwxckvA27D7GRUSgMK2Qetxptg
        YVjh3pu28OQx2vb2FswVPD9b11NFItoAKl2Cl5DvCOS4hd8LVGhw6Djs0ONhtQreZh3977uEtxIPq
        H9zkAQrPjsLCS8yO/3FRu2EOKy65xyWxSR9SOcqtCb4gKq/Nfayb495wowzrfDENeWC8pISdoigkm
        bkVia/RqZum9sFALDfLKJbq5s+BWkV4dquLhji7uMeIMv5YJoV6lE9MgzDXCXDlBgmP+Z7UKVdB1b
        4SM1qtDNra6zDWhZj+X3z8wdRipFMxsJkkCtLHCwxBvs7gy/xnMk0nbiQr5XnfYqg12vlaMs5ueVY
        YhLqyK+w==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUdFY-001h55-TG; Wed, 16 Mar 2022 23:40:17 +0000
Message-ID: <4a812ca1-7733-7826-61ee-e0d8c65230f9@infradead.org>
Date:   Wed, 16 Mar 2022 16:40:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] cpuidle: tegra: add ARCH_SUSPEND_POSSIBLE dependency
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <treding@nvidia.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        He Ying <heying24@huawei.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211013160125.772873-1-arnd@kernel.org>
 <2fdbd732-2496-2267-6636-2f682c39e928@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <2fdbd732-2496-2267-6636-2f682c39e928@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/21 15:25, Dmitry Osipenko wrote:
> 13.10.2021 19:01, Arnd Bergmann пишет:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> Some StrongARM processors don't support suspend, which leads
>> to a build failure with the tegra cpuidle driver:
>>
>> WARNING: unmet direct dependencies detected for ARM_CPU_SUSPEND
>>   Depends on [n]: ARCH_SUSPEND_POSSIBLE [=n]
>>   Selected by [y]:
>>   - ARM_TEGRA_CPUIDLE [=y] && CPU_IDLE [=y] && (ARM [=y] || ARM64) && (ARCH_TEGRA [=n] || COMPILE_TEST [=y]) && !ARM64 && MMU [=y]
>>
>> arch/arm/kernel/sleep.o: in function `__cpu_suspend':
>> (.text+0x68): undefined reference to `cpu_sa110_suspend_size'
>>
>> Add an explicit dependency to make randconfig builds avoid
>> this combination.
>>
>> Fixes: faae6c9f2e68 ("cpuidle: tegra: Enable compile testing")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/cpuidle/Kconfig.arm | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
>> index 2cc3c208a180..af97992eaa82 100644
>> --- a/drivers/cpuidle/Kconfig.arm
>> +++ b/drivers/cpuidle/Kconfig.arm
>> @@ -100,6 +100,7 @@ config ARM_MVEBU_V7_CPUIDLE
>>  config ARM_TEGRA_CPUIDLE
>>  	bool "CPU Idle Driver for NVIDIA Tegra SoCs"
>>  	depends on (ARCH_TEGRA || COMPILE_TEST) && !ARM64 && MMU
>> +	depends on ARCH_SUSPEND_POSSIBLE
>>  	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
>>  	select ARM_CPU_SUSPEND
>>  	help
>>
> 
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

What is the status of this patch, please?

kernel test robot is still reporting this build error, so I just
created the same patch...

thanks.
-- 
~Randy
