Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE394855A7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 16:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237107AbiAEPRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 10:17:41 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:58781 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237011AbiAEPRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 10:17:34 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1641395854; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=S9AtsjfAyxkE1VRytr2/1sWSS6u/ZAMynfW/PfWhtss=; b=EjQCbvnz8HbyfCIQBB3AY5B/lEKFcHwBEppb7NFldlF4xLOsGM5/B+Ga/ZjGSg+SqS93dpMQ
 nHYuOBk4h24T89RRnQXbVwiR3fijgtYfOZLAi4uENezmCTTc732x8/8h+ORfAzVV8cIj1KrL
 Ye24r9Np7athjpdhqZrkn1NvgPI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 61d5b68d7d878c8ded433e97 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 05 Jan 2022 15:17:33
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 823A5C4361A; Wed,  5 Jan 2022 15:17:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.29.110] (unknown [49.37.146.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ED612C4338F;
        Wed,  5 Jan 2022 15:17:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org ED612C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [PATCH v2] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED for
 shmem
To:     Shakeel Butt <shakeelb@google.com>,
        Charan Teja Reddy <quic_charante@quicinc.com>
Cc:     hughd@google.com, akpm@linux-foundation.org, vbabka@suse.cz,
        rientjes@google.com, david@redhat.com, mhocko@suse.com,
        surenb@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1638442253-1591-1-git-send-email-quic_charante@quicinc.com>
 <CALvZod6fSkdV6oSyxsv0+gcRfZ=H9Uaw=7=t902U85fWJStuzA@mail.gmail.com>
 <4a5cde83-c673-6af0-702f-f8b59e05a397@codeaurora.org>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <08d3c298-1568-1ea2-8215-0dffa1c5a089@codeaurora.org>
Date:   Wed, 5 Jan 2022 20:47:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <4a5cde83-c673-6af0-702f-f8b59e05a397@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, Apologies for taking such a long time for the next spin. Posted
V3 @
https://patchwork.kernel.org/project/linux-mm/patch/1641395025-7922-1-git-send-email-quic_charante@quicinc.com/
. Please provide your comments.

On 12/6/2021 12:59 PM, Charan Teja Kalla wrote:
> Thanks Shakeel for your valuable inputs!!
> 
> On 12/2/2021 11:24 PM, Shakeel Butt wrote:
>> On Thu, Dec 2, 2021 at 2:51 AM Charan Teja Reddy
>> <quic_charante@quicinc.com> wrote:
>>>
>>> From: Charan Teja Reddy <charante@codeaurora.org>
>>>
>>> Currently fadvise(2) is supported only for the files that doesn't
>>> associated with noop_backing_dev_info thus for the files, like shmem,
>>> fadvise results into NOP. But then there is file_operations->fadvise()
>>> that lets the file systems to implement their own fadvise
>>> implementation. Use this support to implement some of the POSIX_FADV_XXX
>>> functionality for shmem files.
>>>
>>> This patch aims to implement POSIX_FADV_WILLNEED and POSIX_FADV_DONTNEED
>>> advices to shmem files which can be helpful for the drivers who may want
>>> to manage the shmem pages of the files that are created through
>>> shmem_file_setup[_with_mnt]().  An example usecase may be like, driver
>>> can create the shmem file of the size equal to its requirements and
>>> map the pages for DMA and then pass the fd to user. The user who knows
>>> well about the usage of these pages can now decide when these pages are
>>> not required push them to swap through DONTNEED thus free up memory well
>>> in advance rather than relying on the reclaim and use WILLNEED when it
>>> decide that they are useful in the near future. IOW, it lets the clients
>>> to free up/read the memory when it wants to. Another usecase is that GEM
>>> objets which are currenlty allocated and managed through shmem files can
>>> use vfs_fadvise(DONT|WILLNEED) on shmem fd when the driver comes to
>>> know(like through some hints from user space) that GEM objects are not
>>> going to use/will need in the near future.
>>
>> The proposed semantics of POSIX_FADV_DONTNEED is actually similar to
>> MADV_PAGEOUT and different from MADV_DONTNEED. This is a user facing
>> API and this difference will cause confusion.
> 
> man pages [1] says that "POSIX_FADV_DONTNEED attempts to free cached
> pages associated with the specified region." This statement, IIUC,  on
> issuing this FADV, it is expected to free the file cache pages. And it
> is implementation defined If the dirty pages may be attempted to
> writeback. And the unwritten dirty pages will not be freed.  And thus
> for Shmem files this is being done by dirtying the page and pushing out
> to swap.
> 
> So, Isn't the FADV_DONTNEED also covers the semantics of MADV_PAGEOUT
> for file pages? IOW, what is the purpose of PAGEOUT for the file pages.
> Or I am missing some trivial logic in your comment here?
> 
> Coming to MADV_DONTNEED[2], on the mapped shmem files doesn't have any
> effect as the pages of those shmem files can still be in RAM. Subsequent
> accesses of pages in the range will succeed from the up-to-date contents
> of the underlying mapped file. IOW, the pages are still be present in
> the cache. Am I wrong here?
> 
> [1] https://man7.org/linux/man-pages/man2/posix_fadvise.2.html
> [2] https://man7.org/linux/man-pages/man2/madvise.2.html
> 
> 
>>
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
