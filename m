Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30095401D2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343582AbiFGOye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiFGOyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:54:32 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E53F5061
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 07:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654613671; x=1686149671;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zvcJr5+iQoAK6fcqSS027wnYABW2kz88MgZCy5Lz/5k=;
  b=tAfz4DQ/7t6ST7c5LchQm6+zWegI4kd25vcQstlOi8J5/OV1LwxpYmXM
   ds+iiww8Pw9hMVkiadYTXC17Du1hVxIy3lTXrEXTHUznjARhQkgEDLe3+
   jmFEwIE+BUXr/gBsvsPvOSezf/d51Uzkgjmx27uwNwsPLxpRPCW5jG3n/
   Q=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 07 Jun 2022 07:54:30 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 07:54:30 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 7 Jun 2022 07:54:29 -0700
Received: from [10.214.30.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 7 Jun 2022
 07:54:26 -0700
Message-ID: <7584364f-3aaf-282a-0a67-d8329a3415dc@quicinc.com>
Date:   Tue, 7 Jun 2022 20:22:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH RESEND V5,2/2] mm: shmem: implement
 POSIX_FADV_[WILL|DONT]NEED for shmem
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <markhemm@googlemail.com>,
        <hughd@google.com>, <rientjes@google.com>, <surenb@google.com>,
        <shakeelb@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <cover.1648706231.git.quic_charante@quicinc.com>
 <c2f7242faffd41f46120f82079256ece26b92bf0.1648706231.git.quic_charante@quicinc.com>
 <20220531142135.666b1fcf506e4a327af98ff9@linux-foundation.org>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <20220531142135.666b1fcf506e4a327af98ff9@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Andrew for your review!!

Sorry for the delayed reply here as I was on vacation.

On 6/1/2022 2:51 AM, Andrew Morton wrote:
> On Thu, 31 Mar 2022 12:08:21 +0530 Charan Teja Kalla <quic_charante@quicinc.com> wrote:
> 
>> From: Charan Teja Reddy <quic_charante@quicinc.com>
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
>> to free up/read the memory when it wants to.
> 
> Is there an actual userspace/driver combination which will use this? 
> Has the new feature been tested in such an arrangement?  And if so,
> which driver(s)?
> 

Currently my organization is using this setup where it does makes use of
the shmem infrastructure to allocate the pages and its fd is passed to
the user. The user is now deciding on when to reclaim these pages to
free up the memory through already presented vfs_fadvise(DONTNEED)
system call and bringing back them through vfs_fadvise(WILLNEED), when
they are needed.

This user decision, in just one of the usecases, is based on memory
pressure in the system. Using this fadvise(), the driver now has fully
managing the pages as the usecase requirement is such that when it is
running, all the pages should be present in the ram. And when it is not
running, I am making all those pages to goto swap there by making some
free memory.

This is for embedded system application where display drivers are involved.

>> Another usecase is that GEM
>> objects which are currently allocated and managed through shmem files
>> can use vfs_fadvise(DONT|WILLNEED) on shmem fd when the driver comes to
>> know(like through some hints from user space) that GEM objects are not
>> going to use/will need in the near future.
> 
> Again, is this just a theoretical bright idea, or can we be assured
> that adding this code to the kernel will end up having been useful to
> our users?

This is currently the idea I have and we really not have the code for
the usecase mentioned above mentioning about GEM objects. But I strongly
see that this will be definitely end up been useful to our users.

Because, we have another usecase which is close to the GEM buffer
allocation mechanism and using the vfs_fadvise() from the kernel to
manage those for DRM(display) drivers hence saying that can be useful to
others as well.

> 
>> Some questions asked while reviewing this patch:
>>
>> Q) Can the same thing be achieved with FD mapped to user and use
>> madvise?
>> A) All drivers are not mapping all the shmem fd's to user space and want
>> to manage them with in the kernel. Ex: shmem memory can be mapped to the
>> other subsystems and they fill in the data and then give it to other
>> subsystem for further processing, where, the user mapping is not at all
>> required.  A simple example, memory that is given for gpu subsystem
>> which can be filled directly and give to display subsystem. And the
>> respective drivers know well about when to keep that memory in ram or
>> swap based on may be a user activity.
>>
>> Q) Should we add the documentation section in Manual pages?
>> A) The man[1] pages for the fadvise() whatever says is also applicable
>> for shmem files. so couldn't feel it correct to add specific to shmem
>> files separately.
>> [1] https://linux.die.net/man/2/fadvise
>>
>> Q) The proposed semantics of POSIX_FADV_DONTNEED is actually similar to
>> MADV_PAGEOUT and different from MADV_DONTNEED. This is a user facing API
>> and this difference will cause confusion?
>> A) man pages [1] says that "POSIX_FADV_DONTNEED attempts to free cached
>> pages associated with the specified region." This means on issuing this
>> FADV, it is expected to free the file cache pages. And it is
>> implementation defined If the dirty pages may be attempted to writeback.
>> And the unwritten dirty pages will not be freed. So, FADV_DONTNEED also
>> covers the semantics of MADV_PAGEOUT for file pages and there is no
>> purpose of PAGEOUT for file pages.
> 
