Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AB057DB57
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 09:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbiGVHd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 03:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbiGVHd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:33:57 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D63D9823E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 00:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1658475231; bh=T33GVH8f5eLsNBuftvVxlcnpfNmKejbXJKmjJ5lvpUk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=guTB4N9RgJi3l17IYvwKjfR/E+cJUrUTz9TupsvIv7hcHB1vATgZGyMXoB8WGLwsq
         EGHudXUjV30Vrf/yhWnw0qkWhihU2JNCKdOEAAu7zBwGe904Gmqy0HNbAzq0abyCXo
         xKiOyn7teymo3FcQzK8VSbW4n3bYu+9AXYhGkzlo=
Received: from [100.100.35.250] (unknown [58.34.185.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 8C1526061B;
        Fri, 22 Jul 2022 15:33:51 +0800 (CST)
Message-ID: <f43b5f40-9e2b-b179-390d-591a73603afa@xen0n.name>
Date:   Fri, 22 Jul 2022 15:33:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:104.0)
 Gecko/20100101 Thunderbird/104.0a1
Subject: Re: [PATCH v2] LoongArch: Remove LOONGARCH_CPUCFG48 and some CSR
 definitions
Content-Language: en-US
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>
References: <1658305979-2073-1-git-send-email-yangtiezhu@loongson.cn>
 <fc5a891d-e5a9-c02d-08e0-318213cde8f4@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <fc5a891d-e5a9-c02d-08e0-318213cde8f4@loongson.cn>
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

On 2022/7/22 14:58, Tiezhu Yang wrote:
>
>
> On 07/20/2022 04:32 PM, Tiezhu Yang wrote:
>> According to the configuration information accessible by the CPUCFG
>> instruction [1] and the Overview of Control and Status Registers [2],
>> we can not see the descriptions about LOONGARCH_CPUCFG48 (0x30),
>> LOONGARCH_CSR_PRID (0xc0), LOONGARCH_CSR_MCSR* (0xc0 ~ 0xff) and
>> LOONGARCH_CSR_UCAWIN* (0x100 ~ 0x109), they are not used in the
>> current kernel code.
>>
>> LOONGARCH_CPUCFG48 may be used only in the firmware layer, it should
>> not be used in the future for kernel developers, remove the related
>> LOONGARCH_CPUCFG48 definitions.
>>
>> LOONGARCH_CSR_MCSR* is shadow of LOONGARCH_CPUCFG*, no need to access
>> LOONGARCH_CSR_MCSR* and LOONGARCH_CSR_PRID through CSR instruction,
>> use CPUCFG instruction to access LOONGARCH_CPUCFG* is enough, so also
>> remove LOONGARCH_CSR_MCSR* and LOONGARCH_CSR_PRID definitions.
>>
>> LOONGARCH_CSR_UCAWIN* may be not implemented in hardware, use CSR
>> instruction to access them is meaningless, so also remove the related
>> LOONGARCH_CSR_UCAWIN* definitions.
>>
>> The intention of this patch is to keep consistent between the code and
>> the manual.
>>
>> [1] 
>> https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#the-configuration-information-accessible-by-the-cpucfg-instruction
>> [2] 
>> https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#table-overview-of-control-and-status-registers
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>
>> v2:
>>   -- Remove LOONGARCH_CSR_PRID and LOONGARCH_CSR_UCAWIN*
>>   -- Modify the patch subject and update the commit message
>>
>>  arch/loongarch/include/asm/loongarch.h | 229 
>> ---------------------------------
>>  1 file changed, 229 deletions(-)
>> Hi all,
>
> Are you OK with this change? Any comments will be much appreciated.

Sorry for not getting to this earlier; $DAY_JOB is taking its toll on my 
Linux contributions these days.

IMO, it's probably better to keep the definitions for documentation 
purposes.

As a Loongson employee, you may be aware of the fact that your company's 
"official" documentation is often lacking, and this information you're 
removing is not found elsewhere. So for preserving this knowledge, 
either (1) ask your documentation people to properly record these 
information in official docs then you can go ahead removing them here, 
or (2) just keep the content here if (1) isn't doable for any reason. 
You do want 3rd-parties to freely develop on your platforms, making full 
use of the products' capabilities, don't you? ;-)

