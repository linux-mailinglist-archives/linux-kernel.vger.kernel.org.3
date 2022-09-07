Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938C25B00EF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiIGJxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiIGJxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:53:43 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E5AAEDAE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 02:53:42 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MMyCM6myzz687wc;
        Wed,  7 Sep 2022 17:49:35 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 11:53:39 +0200
Received: from [10.202.227.197] (10.202.227.197) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 10:53:39 +0100
Message-ID: <d9cf492e-1236-8446-9651-dfe848a5932d@huawei.com>
Date:   Wed, 7 Sep 2022 10:53:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 1/2] iova: Remove some magazine pointer NULL checks
To:     Ethan Zhao <haifeng.zhao@linux.intel.com>, <robin.murphy@arm.com>,
        <joro@8bytes.org>, <will@kernel.org>
CC:     <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1662369083-238529-1-git-send-email-john.garry@huawei.com>
 <1662369083-238529-2-git-send-email-john.garry@huawei.com>
 <1d80f56c-bef7-6e5f-0bca-dad35f5e5a8e@linux.intel.com>
 <3fa23318-6fa7-eba0-30b8-1fb71e6c327e@huawei.com>
 <7c4383ac-0b0b-dd43-9958-dbd4abeea63f@linux.intel.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <7c4383ac-0b0b-dd43-9958-dbd4abeea63f@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.227.197]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2022 10:33, Ethan Zhao wrote:

Hi Ethan,

>>> Do you mean iova_magazine_alloc() is impossible to fail ?
>>
>> No, iova_magazine_alloc() may fail and return NULL. But if it does 
>> then we set iovad rcache pointer = NULL in the error path and don't 
>> use the rcache.
> 
> Yup,  if iova_magazine_alloc() failed ,
> 
> iovad->rcaches = NULL;
> 
> was set by free_iova_rcaches()
> 
> in error path of iova_domain_init_rcache().
> 
> and checked in
> 
> alloc_iova_fast()->iova_rcache_get().
> 
> More comment in code would wipe off my curiosity.

As discussed with Robin, we will actually remove that check in 
iova_rcache_get() for now and in future make the IOVA domain init more 
robust.

As for the "loaded" and "prev" NULL checks removal in this specific 
patch, I will add more words in the commit message to make it clearer 
that failure in init was the only way in which they NULL previously.

thanks,
John
