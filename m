Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8268D4E6A6D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 22:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353029AbiCXV4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 17:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiCXV4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 17:56:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596AFB8203
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 14:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=KTgRqvDEK7bov5PjUtR6QEBdXtcARc2MNPBx4i2j3ek=; b=cEa84EFIQiG58QGKExhB/lbcDn
        Snfo3AYg9VqwdhJy1GAV5K3re8XcGzn7o5ovqcyln6XbFc3sZVf48ja/sUM5CzHiz/+FqqKhmzh/D
        AI2Sa55QlLFcS8VLstxVZyCAtSXpHPdRwmTrjNInpxbY8FzHzqkMoINcl5P4jYUaMtvBEoYuoAC+m
        utS3y8egJbexKS+b9DnCFiq+HGXjmQfeXu/uO66ssBRErBU5ZLQgJDOBmbAcIOFiTmxbKxOzHTWgC
        JQkissx/B+hdFVjl7x8X8CNmCIJxln2mmjiwrzsteccSx9Rteej4FItojHL3RVBlHZ557ZbxgW9JA
        j0FKqK+Q==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXVQF-00Dmp7-TJ; Thu, 24 Mar 2022 21:55:12 +0000
Message-ID: <43faf292-245b-5db5-cce9-369d8fb6bd21@infradead.org>
Date:   Thu, 24 Mar 2022 14:55:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: scalability regressions related to hugetlb_fault() changes
Content-Language: en-US
To:     Ray Fucillo <Ray.Fucillo@intersystems.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
References: <D3204B1E-50A1-4261-8C75-3DF77A302502@intersystems.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <D3204B1E-50A1-4261-8C75-3DF77A302502@intersystems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[add linux-mm mailing list]

On 3/24/22 13:12, Ray Fucillo wrote:
> In moving to newer versions of the kernel, our customers have experienced dramatic new scalability problems in our database application, InterSystems IRIS.  Our research has narrowed this down to new processes that attach to the database's shared memory segment taking very long delays (in some cases ~100ms!) acquiring the i_mmap_lock_read() in hugetlb_fault() as they fault in the huge page for the first time.  The addition of this lock in hugetlb_fault() matches the versions where we see this problem.  It's not just slowing the new process that incurs the delay, but backing up other processes if the page fault occurs inside a critical section within the database application.
> 
> Is there something that can be improved here?  
> 
> The read locks in hugetlb_fault() contend with write locks that seem to be taken in very common application code paths: shmat(), process exit, fork() (not vfork()), shmdt(), presumably others.  So hugetlb_fault() contending to read turns out to be common.  When the system is loaded, there will be many new processes faulting in pages that may blocks the write lock, which in turn blocks more readers in fault behind it, and so on...  I don't think there's any support for shared page tables in hugetlb to avoid the faults altogether.
> 
> Switching to 1GB huge pages instead of 2MB is a good mitigation in reducing the frequency of fault, but not a complete solution.
> 
> Thanks for considering.
> 
> Ray

-- 
~Randy
