Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C6D5A210A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 08:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245077AbiHZGo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 02:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243137AbiHZGoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 02:44:55 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF061EAE5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 23:44:52 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MDVZk42sGzYcpx;
        Fri, 26 Aug 2022 14:40:30 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 14:44:49 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 14:44:48 +0800
Message-ID: <7718a9bc-e976-daeb-f490-e7b5190e50b6@huawei.com>
Date:   Fri, 26 Aug 2022 14:44:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next v2 2/2] riscv: extable: add new extable type
 EX_TYPE_KACCESS_ERR_ZERO support
To:     Andrew Jones <ajones@ventanamicro.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <Conor.Dooley@microchip.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        Guohanjun <guohanjun@huawei.com>
References: <20220815032025.2685516-1-tongtiangen@huawei.com>
 <20220815032025.2685516-3-tongtiangen@huawei.com>
 <20220825110602.bog5mjpascvikwxx@kamzik>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <20220825110602.bog5mjpascvikwxx@kamzik>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/8/25 19:06, Andrew Jones 写道:
> On Mon, Aug 15, 2022 at 03:20:25AM +0000, Tong Tiangen wrote:
>> Currently, The extable type EX_TYPE_UACCESS_ERR_ZERO is used by
>> __get/put_kernel_nofault(), but those helpers are not uaccess type, so we
>> add a new extable type EX_TYPE_KACCESS_ERR_ZERO which can be used by
>> __get/put_kernel_no_fault().
>>
>> Only refactor code without any functional changes.
> 
> This isn't quite true. __get/put_kernel_nofault now sets a different
> extable type (as the commit message says). But, nothing special seems
> to be done with that, so there's effectively no functional change. Can
> you please elaborate on the motivation for this change? Where will the
> KACCESS type need to be distinguished from the UACCESS type?

The introduction of EX_TYPE_KACCESS_ERR_ZERO does not change any 
function, but makes a correct distinction in the actual type, indicating 
that there are indeed some kaccess entries in extable. I think this 
optimization is more clear and reasonable.

A few weeks ago, I did something similar on arm64[1]. I think this 
optimization can also be used on riscv.

We can do some features that are used on uaccss but not applicable on 
kaccess in the future[2].

[1] 
https://lore.kernel.org/lkml/20220621072638.1273594-2-tongtiangen@huawei.com/
[2]https://lore.kernel.org/lkml/20220812070557.1028499-4-tongtiangen@huawei.com/

Thanks,
Tong.

> 
> Thanks,
> drew
> .
