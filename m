Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E733B57E0E2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 13:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbiGVLh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 07:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiGVLhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 07:37:25 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8470AF86B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 04:37:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=carlo.bai@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VK4wQdR_1658489841;
Received: from 30.97.56.201(mailfrom:carlo.bai@linux.alibaba.com fp:SMTPD_---0VK4wQdR_1658489841)
          by smtp.aliyun-inc.com;
          Fri, 22 Jul 2022 19:37:21 +0800
Message-ID: <f01182c5-a19e-0f84-bcaa-102246fd5563@linux.alibaba.com>
Date:   Fri, 22 Jul 2022 19:37:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] kexec: accumulate and release the size of crashkernel
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, baolin.wang@linux.alibaba.com
References: <1656934895-12334-1-git-send-email-carlo.bai@linux.alibaba.com>
 <YsOaZ/IETqnWO2uI@MiWiFi-R3L-srv>
From:   Carlo Bai <carlo.bai@linux.alibaba.com>
In-Reply-To: <YsOaZ/IETqnWO2uI@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/5 9:56, Baoquan He wrote:
> On 07/04/22 at 07:41pm, Kaihao Bai wrote:
>> Currently x86 and arm64 support to reserve low memory range for
>> crashkernel. When crashkernel=Y,low is defined, the main kernel would
>> reserve another memblock (instead of crashkernel=X,high, which stored
>> in crashk_res) for crashkernel and store it in crashk_low_res.
>>
>> The implementations of get_crash_size and crash_shrink_size do not
>> consider the extra reserved memory range if it exists. Thus, firstly
>> accumulate this range on the size of crashkernel and export the size
>> by /sys/kernel/kexec_crash_size.
>>
>> If getting the input of /sys/kernel/kexec_crash_size, both reserved ranges
>> might be released if the new size is smaller than current size. The order
>> of release is (crashk_res -> crashk_low_res). Only if the new size defined
>> by the user is smaller than the size of low memory range, continue to
>> release the reserved low memory range after completely releasing the high
>> memory range.
> 
> Sorry, I don't like this patchset.
> 
> I bet you don't encounter a real problem in your product environment.
> Regarding crashkernel=,high|low, the ,low memory is for DMA and
> requirement from memory under lower range. The ,high meomry is for
> kernel/initrd loading, kernel data, user space program running. When
> you configure crashkernel= in your system, you need evaluate what
> value is suitable. /sys/kernel/kexec_crash_size is an interface you
> can make use of to tune the memory usage. People are not suggested to
> free all crashkernel reservation via the interface.
> 
> So, please leave this as is, unless you have a real case where this
> change is needed.
> 
> Thanks
> Baoquan

Sorry for the late reply.

Sincerely thanks for your reviewing, I don't have a real problem which 
needs to release part/all of the reserved low memory range of 
crashkernel. All I think is to change the interface more compatible with 
the reserved low memory range.

Besides, I think it's still confusing if we have actually reserved low 
memory range of crashkernel, but it does not reflect by the size of 
kexec_crash_size.

Thanks,
Kaihao Bai


