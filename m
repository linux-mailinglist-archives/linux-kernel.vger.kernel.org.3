Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E34456558F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbiGDMhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbiGDMhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:37:46 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6088311C3A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:37:45 -0700 (PDT)
Received: from [198.18.0.1] (unknown [192.168.200.1])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxT+MS38JiIZoIAA--.25892S3;
        Mon, 04 Jul 2022 20:37:39 +0800 (CST)
Message-ID: <7012090d-560c-a9ce-7852-0cc57d9c7edc@loongson.cn>
Date:   Mon, 4 Jul 2022 20:37:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] LoongArch: Clean useless vcsr in loongarch_fpu.
Content-Language: en-US
To:     Xi Ruoyao <xry111@xry111.site>, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220704061402.683762-1-huqi@loongson.cn>
 <1470d272-e148-c600-f759-a1e2dac776e1@xen0n.name>
 <7904571e-3ef4-5841-497d-6796c8c36c52@loongson.cn>
 <e187cda4edf0a3186e7caae8ed285e2564742f26.camel@xry111.site>
From:   Qi Hu <huqi@loongson.cn>
In-Reply-To: <e187cda4edf0a3186e7caae8ed285e2564742f26.camel@xry111.site>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxT+MS38JiIZoIAA--.25892S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJr1DAF1xArykAryUCF4kWFg_yoW8Gr15pa
        y7Ww40kFn3JrWxGF4qqan7Ca4rXrW5Ga15XwnxG34Fvr1DWFyfK3yrJFW5CrW8WryqqayU
        XFs7ta4xGF4UZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: pkxtxqxorr0wxvrqhubq/1tbiAQARCV3QvPwxlQABsx
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/7/4 17:58, Xi Ruoyao wrote:
> On Mon, 2022-07-04 at 17:27 +0800, huqi wrote:
>
>>> The original code was written with future LSX/LASX support in mind;
>>> the code is dead currently, but expected to get utilized Soon (TM).
>>>
>>> So, I'd like to confirm if future LoongArch models would *not* feature
>>> LSX/LASX in its current form, and that the Loongson Corporation is not
>>> going to upstream LSX/LASX support, given you are apparently a
>>> Loongson employee with the first-hand information? We'd like to avoid
>>> code churn in general, so if the LSX/LASX support is to be eventually
>>> mainlined, removing them now would only lead to them being introduced
>>> later.
>> `vcsr` is removed because it has been removed in hardware. What's more,
>> it will not be used to support LSX/LASX in the future.
> It would be better to add this information into the commit message.  Is
> it already removed in 3A5000?  On my machine "movfcsr2gr $a0, $r16"
> produces SIGILL (but maybe it's because LSX is not enabled via the EUEN
> register).

Yes, adding this information to the commit message will be more 
reasonable. I will do it later.

It is true that 3A5000 has removed this register. $r16 to $r31 are 
reserved for LSX/LASX. So "movfcsr2gr $a0, $r16" will raise SXD/ASXD if 
LSX/LASX is not enabled, and kernel will raise SIGILL.

