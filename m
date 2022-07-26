Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EFA581316
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 14:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238827AbiGZMVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 08:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238805AbiGZMVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 08:21:22 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CF024950;
        Tue, 26 Jul 2022 05:21:21 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LsbWl4tdjzWfXT;
        Tue, 26 Jul 2022 20:17:23 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 20:21:13 +0800
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 20:21:12 +0800
Subject: Re: [PATCH 2/5] ARM: stacktrace: Avoid duplicate saving of exception
 PC value
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     <ardb@kernel.org>, <will@kernel.org>, <mark.rutland@arm.com>,
        <broonie@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <arnd@arndb.de>,
        <linus.walleij@linaro.org>, <rostedt@goodmis.org>,
        <nick.hawkins@hpe.com>, <john@phrozen.org>, <mhiramat@kernel.org>,
        <ast@kernel.org>, <linyujun809@huawei.com>,
        <ndesaulniers@google.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
References: <20220712021527.109921-1-lihuafei1@huawei.com>
 <20220712021527.109921-3-lihuafei1@huawei.com>
 <Yt/AawOdA8w24toW@shell.armlinux.org.uk>
From:   Li Huafei <lihuafei1@huawei.com>
Message-ID: <c16ad370-4157-7315-eaca-efd884359c05@huawei.com>
Date:   Tue, 26 Jul 2022 20:21:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <Yt/AawOdA8w24toW@shell.armlinux.org.uk>
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



On 2022/7/26 18:22, Russell King (Oracle) wrote:
> On Tue, Jul 12, 2022 at 10:15:24AM +0800, Li Huafei wrote:
>> @@ -34,6 +37,9 @@ void arm_get_current_stackframe(struct pt_regs *regs, struct stackframe *frame)
>>  		frame->kr_cur = NULL;
>>  		frame->tsk = current;
>>  #endif
>> +#ifdef CONFIG_UNWINDER_FRAME_POINTER
>> +		frame->ex_frame = in_entry_text(frame->pc) ? true : false;
> 
> in_entry_text() returns a bool, so there's no need for the ternary
> operator. The same comment applies throughout this patch.
> 
OK, I will fix it in v3.

Thanks,
Huafei
