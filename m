Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C70557A2E2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 17:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239277AbiGSPYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 11:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiGSPYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:24:46 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED96564E7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:24:45 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LnMvw26byz6842y;
        Tue, 19 Jul 2022 23:20:12 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Jul 2022 17:24:44 +0200
Received: from [10.126.173.247] (10.126.173.247) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Jul 2022 16:24:43 +0100
Message-ID: <64da0019-4816-a409-be93-b1cf7021c584@huawei.com>
Date:   Tue, 19 Jul 2022 16:24:42 +0100
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
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220714164136.n2ycc5axt7vtctgs@treble>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.173.247]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
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

On 14/07/2022 17:41, Josh Poimboeuf wrote:
> On Thu, Jul 14, 2022 at 10:57:51AM +0100, John Garry wrote:
>> On 08/07/2022 15:47, John Garry wrote:
>>
>> +
>>
>> JFYI, This issue is caused by CONFIG_DEBUG_INFO now being default off in my
>> .config from commit f9b3cd245784 ("Kconfig.debug: make DEBUG_INFO selectable
>> from a choice").
>>
>> By enabling that config faddr2line now looks ok again.
>>
>> BTW, Could we add a check for any kernel dependency in this tool?
> Hi John,
> 
> The script doesn't know how to reliably find the .config file, but it
> should be able to check for missing DWARF in the binary itself.

Hi Josh,

So adding config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT to v5.19-rc2 got it 
working again for me on arm64. However commit dcea997beed6 ("faddr2line: 
Fix overlapping text section failures, the sequel") seems to be broken 
for me, below - this first appeared in rc3. Any idea what the issue 
could be?

$./faddr.sh hisi_sas_sata_done+0x8/0x38
hisi_sas_sata_done+0x8/0x38:
fs mm ??:0

Thanks,
John
