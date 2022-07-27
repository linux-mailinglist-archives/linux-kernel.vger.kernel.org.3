Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4B558201B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 08:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiG0G3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 02:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiG0G3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 02:29:35 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0751EAFD;
        Tue, 26 Jul 2022 23:29:34 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Lt3kX65Ygz9sxl;
        Wed, 27 Jul 2022 14:28:20 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 14:29:31 +0800
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 14:29:29 +0800
Subject: Re: [PATCH 5/5] ARM: stacktrace: Convert stacktrace to generic
 ARCH_STACKWALK
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     <linux@armlinux.org.uk>, <rmk+kernel@armlinux.org.uk>,
        <ardb@kernel.org>, <will@kernel.org>, <mark.rutland@arm.com>,
        <broonie@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <arnd@arndb.de>,
        <rostedt@goodmis.org>, <nick.hawkins@hpe.com>, <john@phrozen.org>,
        <mhiramat@kernel.org>, <ast@kernel.org>, <linyujun809@huawei.com>,
        <ndesaulniers@google.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
References: <20220712021527.109921-1-lihuafei1@huawei.com>
 <20220712021527.109921-6-lihuafei1@huawei.com>
 <CACRpkdZVxyCsENJQ_-KZBMHjVrYCHzFG2UdCAe=mt_5Ts8_RFw@mail.gmail.com>
From:   Li Huafei <lihuafei1@huawei.com>
Message-ID: <ecc9376b-694b-e42c-977c-813be0a76792@huawei.com>
Date:   Wed, 27 Jul 2022 14:29:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdZVxyCsENJQ_-KZBMHjVrYCHzFG2UdCAe=mt_5Ts8_RFw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.237]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

On 2022/7/18 17:12, Linus Walleij wrote:
> On Tue, Jul 12, 2022 at 4:19 AM Li Huafei <lihuafei1@huawei.com> wrote:
> 
>> This patch converts ARM stacktrace to the generic ARCH_STACKWALK
>> implemented by commit 214d8ca6ee85 ("stacktrace: Provide common
>> infrastructure").
>>
>> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> 
> Looks good to me:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> What I want to know is if this commit will avoid the problem mentioned
> in review of commit 3? I.e. the generic stackwalk code will make sure we are
> not running the task on another CPU, so that is why we could remove
> that check?
> 

In v3, I removed patch 3 of v1 and kept that check, see

  https://lore.kernel.org/lkml/20220727040022.139387-1-lihuafei1@huawei.com/

Given this change, I did not add your reviewed-by to patch 4 of v3. If 
you think patch 4 of v3 is still ok, please do let me know. Thank you 
very much!

Thanks,
Huafei

> Yours,
> Linus Walleij
> .
> 
