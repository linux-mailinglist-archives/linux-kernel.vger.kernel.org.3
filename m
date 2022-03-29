Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E65E4EA637
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 05:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbiC2EB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 00:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiC2EBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 00:01:24 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA66449C9B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 20:59:41 -0700 (PDT)
Received: from kwepemi100018.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KSG4T2dCFzgY7b;
        Tue, 29 Mar 2022 11:58:01 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi100018.china.huawei.com (7.221.188.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 29 Mar 2022 11:59:39 +0800
Received: from [10.174.179.19] (10.174.179.19) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 29 Mar 2022 11:59:38 +0800
Message-ID: <d992f076-5eba-929b-e284-57bd5471cd85@huawei.com>
Date:   Tue, 29 Mar 2022 11:59:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] hugetlb: Fix hugepages_setup when deal with pernode
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        <akpm@linux-foundation.org>, <yaozhenguo1@gmail.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <rdunlap@infradead.org>
References: <20220324074037.2024608-1-liupeng256@huawei.com>
 <361111c6-921b-e129-edf3-367748f6497e@oracle.com>
 <ec312492-fea9-7130-8be4-1c362c2e84a6@huawei.com>
 <e94ea60f-9da7-98b7-7d47-1183c0fd2ddc@oracle.com>
From:   "liupeng (DM)" <liupeng256@huawei.com>
In-Reply-To: <e94ea60f-9da7-98b7-7d47-1183c0fd2ddc@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.19]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/3/29 10:46, Mike Kravetz wrote:
> Yes, I agree that the change is needed and the current behavior is
> unacceptable.
>
> One remaining question is the change from returning '0' to '1' in the case
> of error.  I do understand this is to prevent the invalid parameter string
> from being passed to init.  It may not be correct/right, but in every other
> case where an invalid parameter in encountered in hugetlb command line
> processing we return "0".  Should we perhaps change all these other places
> to be consistent?  I honestly do not know what is the appropriate behavior
> in these situations.

Thank you for your carefulness and question.

I have checked default_hugepagesz_setup and hugepages_setup will both print
some information before return '0', so there is no need to print again in
"Unknown kernel command line parameters".

Should I send another patch to repair the rest "return 0" in hugetlb?

Some other tests for current linux-master:

cmdline:
hugepagesz=1G hugepages=1 hugepagesz=1G hugepages=2
dmesg:
HugeTLB: hugepagesz=1G specified twice, ignoring
Unknown kernel command line parameters " hugepagesz=1G hugepages=2"

cmdline:
hugepagesz=1Y hugepages=1
dmesg:
HugeTLB: unsupported hugepagesz=1Y
HugeTLB: hugepages=1 does not follow a valid hugepagesz, ignoring
Unknown kernel command line parameters "hugepagesz=1Y hugepages=1"

--
Peng Liu
.
