Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B251447D2B0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 14:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245275AbhLVNLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 08:11:48 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:46346 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240720AbhLVNLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 08:11:46 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0V.QmgAE_1640178699;
Received: from 30.240.100.46(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0V.QmgAE_1640178699)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 Dec 2021 21:11:42 +0800
Message-ID: <e1d10668-3928-8b38-92d0-e92d26e20bef@linux.alibaba.com>
Date:   Wed, 22 Dec 2021 21:11:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v2 1/6] crypto: sm3 - create SM3 stand-alone library
Content-Language: en-US
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Vitaly Chikunov <vt@altlinux.org>,
        Eric Biggers <ebiggers@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        x86@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20211222045022.27069-1-tianjia.zhang@linux.alibaba.com>
 <20211222045022.27069-2-tianjia.zhang@linux.alibaba.com>
 <CAOtvUMehn2_HW+b0etPKAV+H=V=PoENkO1xAdL78dCuHma4m_A@mail.gmail.com>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <CAOtvUMehn2_HW+b0etPKAV+H=V=PoENkO1xAdL78dCuHma4m_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gilad,

On 12/22/21 2:59 PM, Gilad Ben-Yossef wrote:
> On Wed, Dec 22, 2021 at 6:50 AM Tianjia Zhang
> <tianjia.zhang@linux.alibaba.com> wrote:
>>
>> Stand-alone implementation of the SM3 algorithm. It is designed
>> to have as little dependencies as possible. In other cases you
>> should generally use the hash APIs from include/crypto/hash.h.
>> Especially when hashing large amounts of data as those APIs may
>> be hw-accelerated. In the new SM3 stand-alone library,
>> sm3_compress() has also been optimized, instead of simply using
>> the code in sm3_generic.
>>
> 
> I have a really minor nitpick: the commit message talks about changes
> to sm3_compress() which was there in the original code but there is no
> such function in the current code which is in a different patch and
> file, so if you do another iteration for other reason, perhaps change
> the commit message to refer to sm3_transform() instead? it's not
> really important enough to warrant a new iteration on it's own...
> 
> Otherwise, I'm not smart enough to evaluate the changes to
> sm3_transform() cryptographically  but the overall approach of moving
> to a standalone library seems sane to me.
> 
> So, for what it's worth -
> 
> Reviewed-by: Gilad Ben-Yossef <gilad@benyosef.com>
> 
> Gilad
> 

Thanks for your suggestion. I agree with you. In the implementation of 
sm3_generic, sm3_compress() is a sub-function of sm3_transform(). The 
optimization is indeed for sm3_transform(). I will fix it in the next patch.

Best regards,
Tianjia
