Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF48D57B314
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 10:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbiGTIju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 04:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbiGTIjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 04:39:47 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95F75B046
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:39:46 -0700 (PDT)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LnpvQ5yVhz687nB;
        Wed, 20 Jul 2022 16:36:18 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 20 Jul 2022 10:39:44 +0200
Received: from [10.195.32.208] (10.195.32.208) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2375.24; Wed, 20 Jul 2022 09:39:43 +0100
Message-ID: <3bd9817d-1959-c081-e5d0-8b0e70b3f41e@huawei.com>
Date:   Wed, 20 Jul 2022 09:39:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: faddr2line issue
To:     Josh Poimboeuf <jpoimboe@kernel.org>
CC:     <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <09df26a9-27af-1276-34c6-820bf7e27da8@huawei.com>
 <3492d341-a681-f344-f5cd-5b1ea3725f31@huawei.com>
 <20220714164136.n2ycc5axt7vtctgs@treble>
 <64da0019-4816-a409-be93-b1cf7021c584@huawei.com>
 <20220720000654.yospyvbrfliy3lrn@treble>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220720000654.yospyvbrfliy3lrn@treble>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.32.208]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
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

On 20/07/2022 01:06, Josh Poimboeuf wrote:
>> So adding config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT to v5.19-rc2 got it
>> working again for me on arm64. However commit dcea997beed6 ("faddr2line: Fix
>> overlapping text section failures, the sequel") seems to be broken for me,
>> below - this first appeared in rc3. Any idea what the issue could be?
>>
>> $./faddr.sh hisi_sas_sata_done+0x8/0x38
>> hisi_sas_sata_done+0x8/0x38:
>> fs mm ??:0
> Hm, what does faddr.sh do? 

ah, it's just a wrapper to call scripts/faddr2line with vmlinux and $1 
(being hisi_sas_sata_done+0x8/0x38, above) args

> Does addr2line also fail?

faddr2line fails, as below.

> 
> Can you run
> 
>    bash -x scripts/faddr2line <vmlinux or .ko file> hisi_sas_sata_done+0x8/0x38
> 
> and share the output?

on rc3 we get:

https://raw.githubusercontent.com/hisilicon/kernel-dev/private-topic-sas-5.19-faddr2line-linux-rc3/before2

With dcea997beed6 reverted on rc3:

https://raw.githubusercontent.com/hisilicon/kernel-dev/private-topic-sas-5.19-faddr2line-linux-rc3/after2

This is my branch is you want to see what I have:
https://github.com/hisilicon/kernel-dev/commits/private-topic-sas-5.19-faddr2line-linux-rc3

Thanks,
John
