Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE87506BAD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351961AbiDSMHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352003AbiDSMFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:05:13 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F50326ED
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:00:35 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KjMhT1dWszCrBk;
        Tue, 19 Apr 2022 19:56:09 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Apr 2022 20:00:32 +0800
Subject: Re: [PATCH v2] mm/swapfile: unuse_pte can map random data if swap
 read fails
To:     David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <neilb@suse.de>, <apopple@nvidia.com>, <surenb@google.com>,
        <minchan@kernel.org>, <peterx@redhat.com>, <sfr@canb.auug.org.au>,
        <rcampbell@nvidia.com>, <naoya.horiguchi@nec.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220416030549.60559-1-linmiaohe@huawei.com>
 <b57fea1e-5c9b-f47e-f565-16b54f1e8782@redhat.com>
 <1b614ac3-02c0-ec66-b51a-e9b7e1a375ad@huawei.com>
 <c901938d-efcc-6a94-bbf4-93e7f4c2ea7d@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <a6707adc-6d3e-92bb-4bb3-29a6e1f350f1@huawei.com>
Date:   Tue, 19 Apr 2022 20:00:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <c901938d-efcc-6a94-bbf4-93e7f4c2ea7d@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/19 19:46, David Hildenbrand wrote:
...
>> Do you mean that we should set the pfn to 0 for the hwpoison marker so that we can
>> distinguish swapin error case from real hwpoison case?
> 
> I am not sure if we really have to distinguish. However, "0" seems to
> make sense to indicate "this is not an actual problematic PFN, the
> information is simply no longer around due to a hardware issue.
> 

IMHO, we have to distinguish. For example, we might need to return VM_FAULT_SIGBUS
instead of VM_FAULT_HWPOISON when user accesses the error page. Or should we simply
return VM_FAULT_HWPOISON to simplify the handling?

Thanks!
