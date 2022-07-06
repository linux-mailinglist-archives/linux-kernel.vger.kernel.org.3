Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF5C569029
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 18:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbiGFQ7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 12:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbiGFQ6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:58:54 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83932A42D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 09:58:52 -0700 (PDT)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LdQfb5Grpz67pCt;
        Thu,  7 Jul 2022 00:56:07 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Jul 2022 18:58:50 +0200
Received: from [10.126.171.66] (10.126.171.66) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Jul 2022 17:58:49 +0100
Message-ID: <db3958dc-d714-f361-f349-06317a0e0cec@huawei.com>
Date:   Wed, 6 Jul 2022 17:58:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] nvme: Fix nvme_setup_command metadata trace event for
 cdw10
To:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
CC:     <axboe@fb.com>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <1657095398-114310-1-git-send-email-john.garry@huawei.com>
 <YsW0orMaDFfrHbx+@kbusch-mbp.dhcp.thefacebook.com>
 <20220706161825.GA1962@lst.de>
 <YsW3oXcCe6/y6iRb@kbusch-mbp.dhcp.thefacebook.com>
 <20220706163434.GA2222@lst.de>
 <YsW7+Lsy0ENSA/il@kbusch-mbp.dhcp.thefacebook.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <YsW7+Lsy0ENSA/il@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.171.66]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2022 17:44, Keith Busch wrote:
> On Wed, Jul 06, 2022 at 06:34:34PM +0200, Christoph Hellwig wrote:
>> On Wed, Jul 06, 2022 at 10:26:09AM -0600, Keith Busch wrote:
>>> On Wed, Jul 06, 2022 at 06:18:25PM +0200, Christoph Hellwig wrote:
>>>> On Wed, Jul 06, 2022 at 10:13:22AM -0600, Keith Busch wrote:
>>>>> Did you test what the trace looks like afte this? We're losing valuable trace
>>>>> data here. The field is supposed to get CDW's 10 - 15, so that's 24 bytes.

ok, I just thought it was a typo, but did not know why you were using an 
array macro.

> I
>>>>> don't know why it cares that the address of the field being read is only 4
>>>>> bytes; we want everything that comes after it too.
>>>>
>>>> Because accesses should not spawn boundaries of members in structs unless
>>>> copying the entire struct.  If we want to trace the various fields we
>>>> need to individually assign them.
>>>>
>>>> Anyway, I'm dropping this patch from nvme-5.19 for now to let the
>>>> discussion conclude.
>>>
>>> How about this instead?
>>
>> Maybe a better option would be to use struct_group().
> 
> Good call, I'd never used that macro before. The result produces anonymous
> unions like I just proposed, so yes, I like that option.
> .

The warning hints at using struct_group() also ...

Anyway, Keith, do you want to write a new patch or shall I?

Thanks,
John
