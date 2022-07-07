Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EDA569A45
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 08:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbiGGGJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 02:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbiGGGJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 02:09:55 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78411B1F2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 23:09:54 -0700 (PDT)
Received: from [10.90.50.23] (unknown [192.168.200.1])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxn9OseMZi7XgOAA--.1729S3;
        Thu, 07 Jul 2022 14:09:49 +0800 (CST)
Message-ID: <41a2a420-adfa-6f8d-392d-0c15892b6945@loongson.cn>
Date:   Thu, 7 Jul 2022 14:09:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] LoongArch: Clean useless vcsr in loongarch_fpu.
Content-Language: en-US
To:     WANG Xuerui <kernel@xen0n.name>, Xi Ruoyao <xry111@xry111.site>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
References: <20220704153612.314112-1-huqi@loongson.cn>
 <4273e104-8392-6a06-5d18-a1933978d8c3@xen0n.name>
 <22a1ba993e298ce12a374decefebeca484240883.camel@xry111.site>
 <16c9ccaa5e5a2ffd39272cff6f66e487c659b571.camel@xry111.site>
 <CAAhV-H5+qd1ZrOqE8fgRmWshXy57AfEFpyKSK8ZstZZEQ53owQ@mail.gmail.com>
 <ac46f5cb4c8d1154cfc3e862fb5211e869839c9a.camel@xry111.site>
 <c824b9ca-c9c4-1912-7845-99a0989277a4@loongson.cn>
 <9d064771-9402-4e84-96f8-4713cddf42f2@www.fastmail.com>
 <730cb4c4-a6a3-783e-3e4c-7c2bdc35c088@loongson.cn>
 <0583a335-72f7-55cf-3cd9-4dbd8109a440@xen0n.name>
 <bd889cd7b72138a12b1339a33156ff46530c20b0.camel@xry111.site>
 <e67e03ae-e2d4-79e6-7f6a-5558ea9de52b@xen0n.name>
From:   Qi Hu <huqi@loongson.cn>
In-Reply-To: <e67e03ae-e2d4-79e6-7f6a-5558ea9de52b@xen0n.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dxn9OseMZi7XgOAA--.1729S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw13Kr4rGryxuFWfuF4Durg_yoW8Ar15pr
        W5ta9Yyr4kJryxAw1Ivwn5XrySvwn5AF15J3WkXFsavwn0qF9agrW8JFW093yYgrZ7Ka4Y
        vr47Kas5ZayUZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: pkxtxqxorr0wxvrqhubq/1tbiAQAACV3QvPyK7wABsh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/7/7 12:22, WANG Xuerui wrote:
> On 2022/7/7 12:04, Xi Ruoyao wrote:
>> On Thu, 2022-07-07 at 11:05 +0800, WANG Xuerui wrote:
>>
>>> To be frank, at this point I think you're trying to hide something.
>>> (This is not your fault, blame someone else of course because they told
>>> you the fact.) In the old-world kernel the VCSR a.k.a. FCSR16 is
>>> certainly being saved/restored, and there's apparently no harm in doing
>>> so. And if the contents are indeed "undefined", why are the code there
>>> in the first place? Certainly the bits *are* meaningful, only that for
>>> some reason you aren't revealing the semantics and pretending that they
>>> are "undefined" and probably "do nothing externally observable" if
>>> accessed in the first place.
>> On a 3A5000LL, I did an experiment via a kernel module, which enables
>> LSX/LASX and tries to write and read fcsr16.  I tried each bit (1, 2, 4,
>> 8, ..., 1 << 31) one by one.  The result: no matter which bit I wrote
>> into fcsr16, I always read out 0.
>>
>> And I've objdump'ed a kernel shipped in an early Loongnix release.  It
>> seems the only reference to fcsr16 is a "movgr2fcsr $r16, $r0"
>> instruction.
>
> Hmm this is weird. I can't understand why the vcsr code was there in 
> the first place then... I'd like to check a few Loongnix/Kylin/UOS 
> kernels but currently I don't have the time.
>
> If this is the case, indeed all vcsr-related code should be removed. 
> Although I'm still not sure how to best word the commit message.
>
Thanks for the Ruoyao's experiment.

Removing the vcsr is the first step to trying to support LBT and 
LSX/LASX in Kernel. In my opinion, the vcsr relevant code may be used 
for debugging and forgot to remove.

