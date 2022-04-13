Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDFC4FEFF5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbiDMGlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiDMGlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:41:21 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D526550B13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 23:39:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0V9yP7mu_1649831936;
Received: from 30.47.203.83(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V9yP7mu_1649831936)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 13 Apr 2022 14:38:57 +0800
Message-ID: <fcfe3a03-933f-6dd7-2059-df83b1d18943@linux.alibaba.com>
Date:   Wed, 13 Apr 2022 14:39:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 3/4] hugetlb: Fix return value of __setup handlers
To:     Peng Liu <liupeng256@huawei.com>, mike.kravetz@oracle.com,
        david@redhat.com, akpm@linux-foundation.org, yaozhenguo1@gmail.com,
        songmuchun@bytedance.com, liuyuntao10@huawei.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220413032915.251254-1-liupeng256@huawei.com>
 <20220413032915.251254-4-liupeng256@huawei.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220413032915.251254-4-liupeng256@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/2022 11:29 AM, Peng Liu wrote:
> When __setup() return '0', using invalid option values causes the
> entire kernel boot option string to be reported as Unknown. Hugetlb
> calls __setup() and will return '0' when set invalid parameter
> string.
> 
> The following phenomenon is observed:
>   cmdline:
>    hugepagesz=1Y hugepages=1
>   dmesg:
>    HugeTLB: unsupported hugepagesz=1Y
>    HugeTLB: hugepages=1 does not follow a valid hugepagesz, ignoring
>    Unknown kernel command line parameters "hugepagesz=1Y hugepages=1"
> 
> Since hugetlb will print warning/error information before return for
> invalid parameter string, just use return '1' to avoid print again.
> 
> Signed-off-by: Peng Liu <liupeng256@huawei.com>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
