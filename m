Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5344BCA6B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 20:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243080AbiBSTMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 14:12:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243058AbiBSTMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 14:12:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CF638B7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 11:11:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A51B60AE9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 19:11:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE901C004E1;
        Sat, 19 Feb 2022 19:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645297912;
        bh=AdNNP3f2nzvuisqB37U22ZFFkpwe6bfxYYWqRev4vwQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cbImLl1jXLs7ShzBAg0QzQ/sXVqTMPCMrfHZqCGqMSUjIOz377LkoRYgiWxWerz47
         S+P4Njx8QALDuCOrtvLQoJJEJyzmu6+Ys0agpbpIkSHa7e11ZZ1xhT/6pAPjjGROIz
         O3pfVo8flWDxHh/T0t+TRQg+G4hTzRzPLCZV06ufKkdCw6tzqWjZ5+Pz91XJy80pua
         LbLQFNRk4OxzFeAhtGXqiawsfvaREGgh30X4LlAA0PHb5iMK3zf3Jel2o2vMQ+h88B
         x+yWKeq/n3/wz0LB9qC/gh3bMAje6XH3SOJ+JMVErgjBsNsJtQl3YhJrYU2el3Erq+
         yocwGKyFRAmDw==
Message-ID: <8a6f24eb-a256-3d0e-5a2c-f62b4afd30aa@kernel.org>
Date:   Sat, 19 Feb 2022 21:11:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mtd: rawnand: omap2: Prevent invalid configuration and
 build error
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     miquel.raynal@bootlin.com, krzysztof.kozlowski@canonical.com,
        vigneshr@ti.com, nm@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220118123525.8020-1-rogerq@kernel.org>
 <20220219150836.GA1035394@roeck-us.net>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20220219150836.GA1035394@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19/02/2022 17:08, Guenter Roeck wrote:
> On Tue, Jan 18, 2022 at 02:35:25PM +0200, Roger Quadros wrote:
>> We need to select MEMORY as well otherwise OMAP_GPMC will not be built.
>> For simplicity let's select MEMORY and OMAP_GPMC unconditionally as
>> this driver depends on OMAP_GPMC driver and uses symbols from there.
>>
>> Fixes: dbcb124acebd ("mtd: rawnand: omap2: Select GPMC device driver for ARCH_K3")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> 
> This patch ignores OMAP_GPMC dependencies and results in:
> 
> WARNING: unmet direct dependencies detected for OMAP_GPMC
>   Depends on [n]: MEMORY [=y] && OF_ADDRESS [=n]
>   Selected by [m]:
>   - MTD_NAND_OMAP2 [=m] && MTD [=m] && MTD_RAW_NAND [=m] && (ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST [=y]) && HAS_IOMEM [=y]
> 
> when configuring sparc64:allmodconfig, and in the following
> build failure when trying to build that image.
> 
> Building sparc64:allmodconfig ... failed
> --------------
> Error log:
> <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
> sparc64-linux-ld: drivers/memory/omap-gpmc.o: in function `gpmc_probe_generic_child':
> omap-gpmc.c:(.text.unlikely+0x14c4): undefined reference to `of_platform_device_create'
> 
> Guenter
> 
>> ---
>>  drivers/mtd/nand/raw/Kconfig | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
>> index 20408b7db540..d986ab4e4c35 100644
>> --- a/drivers/mtd/nand/raw/Kconfig
>> +++ b/drivers/mtd/nand/raw/Kconfig
>> @@ -42,7 +42,8 @@ config MTD_NAND_OMAP2
>>  	tristate "OMAP2, OMAP3, OMAP4 and Keystone NAND controller"
>>  	depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
>>  	depends on HAS_IOMEM
>> -	select OMAP_GPMC if ARCH_K3
>> +	select MEMORY
>> +	select OMAP_GPMC

I think selecting these was a bad idea in the first place. I'll send out a patch to remove the selects.
This driver should depend on them instead.

We will figure out how to enable OMAP_GPMC for K3 architecture some other way.

>>  	help
>>  	  Support for NAND flash on Texas Instruments OMAP2, OMAP3, OMAP4
>>  	  and Keystone platforms.
>> -- 
>> 2.17.1
>>

cheers,
-roger
