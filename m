Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF499580399
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 19:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236270AbiGYRju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 13:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiGYRjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 13:39:49 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAA61C912
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 10:39:47 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ls6gs17tnz68737;
        Tue, 26 Jul 2022 01:37:45 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Mon, 25 Jul 2022 19:39:44 +0200
Received: from [10.126.173.156] (10.126.173.156) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Jul 2022 18:39:44 +0100
Message-ID: <c2f91d00-96d2-c1f4-c858-5619515a30ed@huawei.com>
Date:   Mon, 25 Jul 2022 18:39:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 0/2] arm64 defconfig: Get faddr2line working
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        <jpoimboe@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <1658681004-132191-1-git-send-email-john.garry@huawei.com>
 <CAK8P3a0umWWic6LAzxXJ7BACYVE--m-wbynh7Z8F+pGoUBxGTA@mail.gmail.com>
 <25237c44-ebc4-fc9a-7c6f-3e990f968038@huawei.com>
 <CAK8P3a2+0EwSJ=fRBL2JCGypJRL-qE4rEiXYnJbqhZ=weethdQ@mail.gmail.com>
 <4d5c9bfc-dc10-7019-cad4-751e21f02a18@huawei.com>
 <CAK8P3a3QNjOSodb-ND=nZ=ThC9xZhEyUOaUsWCDF70s9g80r-w@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <CAK8P3a3QNjOSodb-ND=nZ=ThC9xZhEyUOaUsWCDF70s9g80r-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.173.156]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2022 15:22, Arnd Bergmann wrote:
>> INTERCONNECT has no dependencies, so "select" - like for MAILBOX -
>> should be fine, I suppose
> There are a couple of trade-offs between the two approaches.
> The main advantage of 'select' is that you can enable drivers more
> easily and all the required subsystems are there automatically.
> The advantage of 'depends on' is that it becomes easier to disable
> entire subsystems that one may not need.
> 
> Which of those two is more important is of course a matter of perspective,
> I like to be able to turn things off more easily because that makes it
> possible to test the corner cases with randconfig more easily, and it
> helps produce size-reduced kernels for embedded systems.
> 
> Another aspect is that we overall have more 'depends on' than 'select',
> and sticking with the more common way avoids circular dependencies,
> both within an area of the kernel and overall.
> 
> The rule that I tend to follow with 'select' is to only use it on symbols
> that you don't even want to show to users. If a feature is part of
> a library (think zlib), then each user just needs to select the symbol
> but you never actually have to decide whether to show it or not.

ok, seems reasonable. Personally I dislike 'select' for all the common 
reasons.

> 
>>>> And would each config item deletion merit a separate patch?
>>> You send a combined patch for the obvious ones (secccomp
>>> and mailbox AFAICT) or send them separately. For the other ones I think
>>> we should try fixing the Kconfig files first, otherwise we just end up
>>> putting them back afterwards.
>> ok, fine. I'll deal with the obvious changes first plus
>> CONFIG_DEBUG_INFO and then the non-obvious, non-trivial ones. I'll base
>> on your arm/defconfig branch (for defconfig changes).
> The CONFIG_DEBUG_INFO one should be fixed by my series from
> last week already, do you still see another issue with that?

Ah, I thought that you re-enabled CONFIG_DEBUG_INFO for only the arm32 
configs but see that you also re-enabled for arm64 defconfig as well.

> I actually
> have another patch to fix up all the non-Arm defconfigs for this one as
> well, but haven't sent that one yet.

Thanks,
John
