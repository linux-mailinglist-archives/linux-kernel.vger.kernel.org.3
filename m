Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE824D414C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 07:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239887AbiCJGnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 01:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239864AbiCJGnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 01:43:43 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE07F5F90
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 22:42:42 -0800 (PST)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KDfXz0TrZz9sYG;
        Thu, 10 Mar 2022 14:38:59 +0800 (CST)
Received: from [10.174.179.215] (10.174.179.215) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Mar 2022 14:42:40 +0800
Subject: Re: [PATCH -next] perf/marvell: cn10k Fix build error without
 CONFIG_OF
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        <bbudiredla@marvell.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220309140617.33860-1-yuehaibing@huawei.com>
 <CAK8P3a1UBX2c0-VQtQd885U-=+RHxn_mZzD6ELk-B4cq+09afg@mail.gmail.com>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <cdcdd201-840d-a928-1746-7656994cb12e@huawei.com>
Date:   Thu, 10 Mar 2022 14:42:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1UBX2c0-VQtQd885U-=+RHxn_mZzD6ELk-B4cq+09afg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/9 22:11, Arnd Bergmann wrote:
> On Wed, Mar 9, 2022 at 3:06 PM YueHaibing <yuehaibing@huawei.com> wrote:
>>
>> drivers/perf/marvell_cn10k_ddr_pmu.c:723:21: error: ‘cn10k_ddr_pmu_of_match’ undeclared here (not in a function); did you mean ‘cn10k_ddr_pmu_driver’?
>>          .of_match_table = cn10k_ddr_pmu_of_match,
>>                            ^~~~~~~~~~~~~~~~~~~~~~
>>
>> Use of_match_ptr() to fix this.
>>
>> Fixes: 7cf83e222bce ("perf/marvell: CN10k DDR performance monitor support")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> It's generally better to remove the #ifdef around the match table
> definition instead,
> which improves readability, and has no downsides on the machines this actually
> runs on, because CONFIG_OF is always enabled on arm64.

Ok， will do this in v2, thanks!
> 
>       Arnd
> .
> 
