Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C854D7964
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 03:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbiCNCdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 22:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbiCNCdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 22:33:43 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB46117D;
        Sun, 13 Mar 2022 19:32:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0V72sF0B_1647225146;
Received: from 30.240.100.21(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0V72sF0B_1647225146)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 14 Mar 2022 10:32:28 +0800
Message-ID: <d8e6305a-b535-5952-aa2a-275ca18c1bd9@linux.alibaba.com>
Date:   Mon, 14 Mar 2022 10:32:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH 1/3] crypto: sm4 - create SM4 library based on sm4 generic
 code
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Markku-Juhani O . Saarinen" <mjos@iki.fi>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        X86 ML <x86@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210610134459.28541-1-tianjia.zhang@linux.alibaba.com>
 <20210610134459.28541-2-tianjia.zhang@linux.alibaba.com>
 <Yh32tEhUgGeSXf/A@zx2c4.com> <Yh65NU6TwcvW/VZV@gondor.apana.org.au>
 <CAHmME9qL4gHwJZcYGRmJ8sxcjkpGFjWDH2gxu15FXzgCUDLifw@mail.gmail.com>
 <Yh/uW6z7aOyG0Jl8@gmail.com>
 <CAHmME9rUUGAM+MP802=dSe0HMLnGAq4Yne-NHfJxyGaKMcdSxg@mail.gmail.com>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <CAHmME9rUUGAM+MP802=dSe0HMLnGAq4Yne-NHfJxyGaKMcdSxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On 3/12/22 7:03 AM, Jason A. Donenfeld wrote:
> Hi Tianjia,
> 
> On Wed, Mar 2, 2022 at 3:23 PM Eric Biggers <ebiggers@kernel.org> wrote:
>>
>> On Wed, Mar 02, 2022 at 01:26:13AM +0100, Jason A. Donenfeld wrote:
>>> On Wed, Mar 2, 2022 at 1:24 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>>>>
>>>> On Tue, Mar 01, 2022 at 11:34:28AM +0100, Jason A. Donenfeld wrote:
>>>>>>   lib/crypto/Kconfig   |   3 +
>>>>>>   lib/crypto/Makefile  |   3 +
>>>>>>   lib/crypto/sm4.c     | 184 +++++++++++++++++++++++++++++++++++++++++++
>>>>>
>>>>> If this is only used by the crypto API, it does not belong in
>>>>> lib/crypto.
>>>>
>>>> Nope there is no such rule.  lib/crypto is fine if you're adding
>>>> code that is shared between crypto and arch/*/crypto.
>>>
>>> The sprawling madness continues then... Noted.
>>
>> I think it would make more sense for this code to be in crypto/, for the reason
>> that Jason gave.
> 
> Were you planning on submitting a patch for this?
> 
> Thanks,
> Jason

I agree with Herbert that this is not necessary and the community is 
currently not in agreement on this point, and I'd be happy to do the 
work if there's a more reasonable reason.

Thanks so much for your suggestion.

Best regards,
Tianjia
