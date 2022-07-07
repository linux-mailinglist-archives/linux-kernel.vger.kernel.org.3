Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CEC569913
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 06:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbiGGEXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 00:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbiGGEW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 00:22:57 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC342FFE1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 21:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1657167773; bh=kVK+K1j5mB45c4TjayXPR0CHym4BWHEeRog+G28gmD4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=isW7nzFD73L6p2ml5+cAPqYl4RKlNVriE6R+uySXyUk146ghNKzC/K9WSfQrT1NOq
         hL/GcXSW4BJhw7YBkg7ABoC9BZeAEzNHDtNJXLiF0XcnF8pV120J/ZNh7uUZXKvHRf
         CSsA3C1+iC/yQ3PQDRIDP70wOQI8tjAaXOW18aHA=
Received: from [100.100.57.190] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 037FE6010B;
        Thu,  7 Jul 2022 12:22:52 +0800 (CST)
Message-ID: <e67e03ae-e2d4-79e6-7f6a-5558ea9de52b@xen0n.name>
Date:   Thu, 7 Jul 2022 12:22:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:104.0)
 Gecko/20100101 Thunderbird/104.0a1
Subject: Re: [PATCH v2] LoongArch: Clean useless vcsr in loongarch_fpu.
To:     Xi Ruoyao <xry111@xry111.site>, WANG Xuerui <kernel@xen0n.name>,
        Qi Hu <huqi@loongson.cn>,
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
Content-Language: en-US
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <bd889cd7b72138a12b1339a33156ff46530c20b0.camel@xry111.site>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/7 12:04, Xi Ruoyao wrote:
> On Thu, 2022-07-07 at 11:05 +0800, WANG Xuerui wrote:
>
>> To be frank, at this point I think you're trying to hide something.
>> (This is not your fault, blame someone else of course because they told
>> you the fact.) In the old-world kernel the VCSR a.k.a. FCSR16 is
>> certainly being saved/restored, and there's apparently no harm in doing
>> so. And if the contents are indeed "undefined", why are the code there
>> in the first place? Certainly the bits *are* meaningful, only that for
>> some reason you aren't revealing the semantics and pretending that they
>> are "undefined" and probably "do nothing externally observable" if
>> accessed in the first place.
> On a 3A5000LL, I did an experiment via a kernel module, which enables
> LSX/LASX and tries to write and read fcsr16.  I tried each bit (1, 2, 4,
> 8, ..., 1 << 31) one by one.  The result: no matter which bit I wrote
> into fcsr16, I always read out 0.
>
> And I've objdump'ed a kernel shipped in an early Loongnix release.  It
> seems the only reference to fcsr16 is a "movgr2fcsr $r16, $r0"
> instruction.

Hmm this is weird. I can't understand why the vcsr code was there in the 
first place then... I'd like to check a few Loongnix/Kylin/UOS kernels 
but currently I don't have the time.

If this is the case, indeed all vcsr-related code should be removed. 
Although I'm still not sure how to best word the commit message.

