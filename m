Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612EF4F8F2B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbiDHGag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 02:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbiDHGad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 02:30:33 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EA22560F7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 23:28:31 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KZSwv3b7gz1HBdw;
        Fri,  8 Apr 2022 14:27:59 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Apr 2022 14:28:28 +0800
Subject: Re: [PATCH v7] mm/hwpoison: fix race between hugetlb free/demotion
 and memory_failure_hugetlb()
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20220407112929.1344748-1-naoya.horiguchi@linux.dev>
 <4b5ad6c3-99a0-b04f-21ad-8ade46984c76@huawei.com>
 <20220408015610.GA3061012@hori.linux.bs1.fc.nec.co.jp>
 <e928b6a2-2bb4-82dc-1508-5b293ecb7539@huawei.com>
 <20220408050753.GA3069452@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <a57bc3e5-6342-9be3-7c6d-a2d66c37efc3@huawei.com>
Date:   Fri, 8 Apr 2022 14:28:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220408050753.GA3069452@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/8 13:07, HORIGUCHI NAOYA(堀口 直也) wrote:
> 
>>>> Without this patch, page refcnt is not decremented if MF_COUNT_INCREASED is set in flags
>>>> when PageHWPoison is already set. So I think this patch also fixes that issue. Thanks!
>>>
>>> Good point, I even didn't notice that. And the issue still seems to exist
>>> for normal page's cases.  Maybe encountering "already hwpoisoned" case from
>>> madvise_inject_error() is rare but could happen when the first call failed
>>> to contain the error (which is still accessible from the calling process).
>>
>> Oh, I missed normal page's issue. :) Will you fix this issue kindly or am I supposed
>> to fix it?
> 
> I'll try it too, ;)
> 

That's very kind of you. ;)
Thanks.

> Thanks,
> Naoya Horiguchi
> 

