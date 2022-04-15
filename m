Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD021501FF4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 03:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348369AbiDOBM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 21:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348363AbiDOBMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 21:12:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14CE3B550
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 18:09:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F299621FF
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 01:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E2AC385A1;
        Fri, 15 Apr 2022 01:09:53 +0000 (UTC)
Message-ID: <9e5ee1c3-ca80-f343-a1f5-66f3dd1c0727@linux-m68k.org>
Date:   Fri, 15 Apr 2022 11:09:50 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [linux-stable-rc:queue/5.4 7091/9999]
 drivers/staging/comedi/drivers/comedi_isadma.c:25:17: error: implicit
 declaration of function 'claim_dma_lock'
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
References: <202204130751.lUeRF1y2-lkp@intel.com>
 <CAK8P3a3ow9EpNAyTU9n6zC8Rmw71vJ6oaRSCHmd1qU9Z_c3RuA@mail.gmail.com>
 <d5ffc004-f55c-c01e-3395-7983fb25e570@linux-m68k.org>
 <CAK8P3a29S9q=ZCGEx-1qxYciYB5=Jffkk9jx1+Gv91xvgtdA=g@mail.gmail.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <CAK8P3a29S9q=ZCGEx-1qxYciYB5=Jffkk9jx1+Gv91xvgtdA=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/4/22 01:59, Arnd Bergmann wrote:
> On Thu, Apr 14, 2022 at 4:16 PM Greg Ungerer <gerg@linux-m68k.org> wrote:
>> On 13/4/22 18:54, Arnd Bergmann wrote:
>>> On Wed, Apr 13, 2022 at 1:07 AM kernel test robot <lkp@intel.com> wrote:
>   >
>>> Greg (Ungerer), do you see any of these that are used on Coldfire?
>>> I can rule out most of them, but there are a few that are unclear to me.
>>
>> I think the cs89x0 driver may have been used on at least one platform
>> in the past. But nothing that is currently supported in mainline code.
>> So we can safely assume none of these are required for ColdFire platforms.
> 
> Ok, so even if this driver is used on coldfire, it only uses the ISA DMA
> code path for actual ISA devices, not for the platform device code on
> non-PC systems.
> 
> I think we can just remove arch/m68k/coldfire/dma.c and most of
> arch/m68k/include/asm/dma.h then after dropping CONFIG_ISA_DMA_API,
> leaving only the bits needed for CONFIG_GENERIC_ISA_DMA on Q40
> and AMIGA.

Yep, I think that is a good plan.

Regards
Greg


