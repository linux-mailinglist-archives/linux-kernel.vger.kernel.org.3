Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38084690D3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 08:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbhLFHcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 02:32:46 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:48197 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbhLFHcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 02:32:43 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638775755; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=kpfkrbWxq3M3VkqCiFgC+HQj86saJq/Wq6k82Z/2x2s=; b=nuItm06XGIlMGhDW14Krbu5yMA2qukshn1z1jTPc+qt58SJuXoMbgWUl7ngIoCb2nWZxGeFr
 H7zAcbtmAAuh2l0S8Lo1UV95+ybPxqoCATAyNHKkYnu2CsrX8VaUvixKfLrJyCKHA2Km5O3O
 akdVNi8tT8zG418dCrUUFFguiG4=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 61adbbcae7d68470af8234c6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 06 Dec 2021 07:29:14
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C1353C4361A; Mon,  6 Dec 2021 07:29:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.29.110] (unknown [49.37.157.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 247D1C4338F;
        Mon,  6 Dec 2021 07:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 247D1C4338F
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
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <4a5cde83-c673-6af0-702f-f8b59e05a397@codeaurora.org>
Date:   Mon, 6 Dec 2021 12:59:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CALvZod6fSkdV6oSyxsv0+gcRfZ=H9Uaw=7=t902U85fWJStuzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Shakeel for your valuable inputs!!

On 12/2/2021 11:24 PM, Shakeel Butt wrote:
> On Thu, Dec 2, 2021 at 2:51 AM Charan Teja Reddy
> <quic_charante@quicinc.com> wrote:
>>
>> From: Charan Teja Reddy <charante@codeaurora.org>
>>
>> Currently fadvise(2) is supported only for the files that doesn't
>> associated with noop_backing_dev_info thus for the files, like shmem,
>> fadvise results into NOP. But then there is file_operations->fadvise()
>> that lets the file systems to implement their own fadvise
>> implementation. Use this support to implement some of the POSIX_FADV_XXX
>> functionality for shmem files.
>>
>> This patch aims to implement POSIX_FADV_WILLNEED and POSIX_FADV_DONTNEED
>> advices to shmem files which can be helpful for the drivers who may want
>> to manage the shmem pages of the files that are created through
>> shmem_file_setup[_with_mnt]().  An example usecase may be like, driver
>> can create the shmem file of the size equal to its requirements and
>> map the pages for DMA and then pass the fd to user. The user who knows
>> well about the usage of these pages can now decide when these pages are
>> not required push them to swap through DONTNEED thus free up memory well
>> in advance rather than relying on the reclaim and use WILLNEED when it
>> decide that they are useful in the near future. IOW, it lets the clients
>> to free up/read the memory when it wants to. Another usecase is that GEM
>> objets which are currenlty allocated and managed through shmem files can
>> use vfs_fadvise(DONT|WILLNEED) on shmem fd when the driver comes to
>> know(like through some hints from user space) that GEM objects are not
>> going to use/will need in the near future.
> 
> The proposed semantics of POSIX_FADV_DONTNEED is actually similar to
> MADV_PAGEOUT and different from MADV_DONTNEED. This is a user facing
> API and this difference will cause confusion.

man pages [1] says that "POSIX_FADV_DONTNEED attempts to free cached
pages associated with the specified region." This statement, IIUC,  on
issuing this FADV, it is expected to free the file cache pages. And it
is implementation defined If the dirty pages may be attempted to
writeback. And the unwritten dirty pages will not be freed.  And thus
for Shmem files this is being done by dirtying the page and pushing out
to swap.

So, Isn't the FADV_DONTNEED also covers the semantics of MADV_PAGEOUT
for file pages? IOW, what is the purpose of PAGEOUT for the file pages.
Or I am missing some trivial logic in your comment here?

Coming to MADV_DONTNEED[2], on the mapped shmem files doesn't have any
effect as the pages of those shmem files can still be in RAM. Subsequent
accesses of pages in the range will succeed from the up-to-date contents
of the underlying mapped file. IOW, the pages are still be present in
the cache. Am I wrong here?

[1] https://man7.org/linux/man-pages/man2/posix_fadvise.2.html
[2] https://man7.org/linux/man-pages/man2/madvise.2.html


> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
