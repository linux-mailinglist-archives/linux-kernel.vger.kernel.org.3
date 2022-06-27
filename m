Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F4355CD85
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbiF0N1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbiF0N1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:27:48 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8597641B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:27:47 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LWpRZ0xQFz9spN;
        Mon, 27 Jun 2022 21:27:06 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 27 Jun 2022 21:27:44 +0800
Subject: Re: [PATCH v3 1/2] mm/swapfile: fix possible data races of
 inuse_pages
To:     Qian Cai <quic_qiancai@quicinc.com>
CC:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <ying.huang@intel.com>, <songmuchun@bytedance.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220625093346.48894-1-linmiaohe@huawei.com>
 <20220625093346.48894-2-linmiaohe@huawei.com> <Yrml4mB3sa5fZVJa@qian>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <fe3c4834-71a6-7867-2108-eca43fde62fc@huawei.com>
Date:   Mon, 27 Jun 2022 21:27:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Yrml4mB3sa5fZVJa@qian>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/27 20:43, Qian Cai wrote:
> On Sat, Jun 25, 2022 at 05:33:45PM +0800, Miaohe Lin wrote:
>> si->inuse_pages could still be accessed concurrently now. The plain reads
>> outside si->lock critical section, i.e. swap_show and si_swapinfo, which
>> results in data races. READ_ONCE and WRITE_ONCE is used to fix such data
>> races. Note these data races should be ok because they're just used for
>> showing swap info.
> 
> Was this found by kcsan? If so, it would be useful to record the exact
> kscan report in the commit message.

Sorry, it's found via code inspection.

Thanks.

> .
> 

