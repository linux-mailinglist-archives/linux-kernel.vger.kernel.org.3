Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4297652E32F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 05:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345178AbiETDlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 23:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbiETDlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 23:41:18 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D89186CC
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 20:41:16 -0700 (PDT)
Received: (Authenticated sender: ash@heyquark.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 71E83200003;
        Fri, 20 May 2022 03:41:08 +0000 (UTC)
Message-ID: <d84e4d24-f350-80fc-6c31-b7e7f8d429f4@heyquark.com>
Date:   Fri, 20 May 2022 13:41:04 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 11/12] powerpc: wiiu: don't enforce flat memory
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     paulus@samba.org, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        robh+dt@kernel.org, benh@kernel.crashing.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        j.ne@posteo.net
References: <20220302044406.63401-1-ash@heyquark.com>
 <20220302044406.63401-12-ash@heyquark.com>
 <20220513224353.n56qg5fhstbaqhfz@pali>
From:   Ash Logan <ash@heyquark.com>
In-Reply-To: <20220513224353.n56qg5fhstbaqhfz@pali>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/5/22 08:43, Pali Rohár wrote:
> On Wednesday 02 March 2022 15:44:05 Ash Logan wrote:
>> pgtable_32.c:mapin_ram loops over each valid memory range, which means
>> non-contiguous memory just works.
> 
> Hello! Does it mean that non-contiguous memory works for any 32-bit
> powerpc platform, and not only for wiiu? If yes, should not be
> non-contiguous memory support enabled for all 32-bit ppc boards then?

Hi! Sorry for my delayed response. As best I can tell, it does indeed
Just Work, but I have only been able to test on wiiu which is missing a
lot of features other boards have (like PCI) - so it's possible there's
still an assumption elsewhere in the kernel that I haven't hit.

As best I can tell, the Wii and Wii U are the only 32-bit powerpc boards
out there where it's even possible to have non-contiguous memory.

>> Signed-off-by: Ash Logan <ash@heyquark.com>
>> ---
>>  arch/powerpc/mm/init_32.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
>> index 3d690be48e84..59a84629d9a0 100644
>> --- a/arch/powerpc/mm/init_32.c
>> +++ b/arch/powerpc/mm/init_32.c
>> @@ -125,10 +125,10 @@ void __init MMU_init(void)
>>  	 * lowmem_end_addr is initialized below.
>>  	 */
>>  	if (memblock.memory.cnt > 1) {
>> -#ifndef CONFIG_WII
>> +#if !defined(CONFIG_WII) && !defined(CONFIG_WIIU)
>>  		memblock_enforce_memory_limit(memblock.memory.regions[0].size);
>>  		pr_warn("Only using first contiguous memory region\n");
>> -#else
>> +#elif defined(CONFIG_WII)
>>  		wii_memory_fixups();
>>  #endif
>>  	}
>> -- 
>> 2.35.1
>>
