Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA6552A342
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344439AbiEQNX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243506AbiEQNXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:23:25 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58CF42EDB
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:23:23 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-e656032735so24210471fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0n953XZLxNEicMb/zkLfQgu+fYiiRNsJAwEuGolBYkU=;
        b=bsSNy9bPYG5mXjC+DZgJICtDaiXr6a1ubl77WEZ3t00iU6/7n7EqpjiSjDLx6yyP4w
         3nk8SKBTWfmYB4Kbzp1U7Q0fgspvzC8UFKKzmntorxeh9mKBzONqyPGxBa3YnOCTXqnt
         Qpmc8CnMBpfPM1OmJAvmr17nb7Z3hON/j+IMPmL4DasvkGweVMKgrovji2Z2h5jPcJer
         XKF1xOy+tNVjtWtnzQkuI44CGTrpA2TpRTw31NDIJje6SonN667xTTUl/lPP9na3kTVu
         0fSM/0cCR7tenXDA9D6cBCVMr/OjDs2wySYQ2Wida9xdlG7uV8fveNnW2+ZHrn6CH1O3
         5lSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0n953XZLxNEicMb/zkLfQgu+fYiiRNsJAwEuGolBYkU=;
        b=123Xo0swoUETTZp0BKysUIdvubZn67wBd4CBArGClAW8dlDe2nrxdCp5Y1wuc/kwFu
         SjzCS3rX3N6MLknwrqwn+PDhPm2cmVLKgmT/a6JFc5kX8IOyersEgpAt+KwhPXtbgi4I
         wMZy4YtT7A9SgST9p1Q3OFvBoi6JpGTE7ze/6FtDdiCtzH7e2sjfWa6eXBBTO31tteFb
         +XTohrxJApxupu0tsuzEMcVIL8u/syU8R/wyxFE/IGDMCgmVY/PO9Rjl7sr5jlxXFuRr
         2VDzN33oamGjphMpuVvUMBjLYoFqCAUFHqQDJ+l89PP2JdjRS+z3lJWyHKV4sobseCI9
         IRkQ==
X-Gm-Message-State: AOAM533VdhV/Atu2CIVe7pjL26XVudkZeqnfUWbqkzkSmy64/xVUd2yD
        ElEVP3YElFtyysDeqsQWC0s=
X-Google-Smtp-Source: ABdhPJzVRHkwDITClgqv6RqaGHhieAiHVw2WliPWzz2rEghJ8PNVLHO6lecC2jiSjCYQQQbak4Jgnw==
X-Received: by 2002:a05:6870:c0d3:b0:f1:8e58:15ec with SMTP id e19-20020a056870c0d300b000f18e5815ecmr7601295oad.118.1652793803206;
        Tue, 17 May 2022 06:23:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h12-20020a4ad28c000000b0035eb4e5a6b1sm5261607oos.7.2022.05.17.06.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 06:23:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <973b908d-7098-cbae-8046-9a42cfabd570@roeck-us.net>
Date:   Tue, 17 May 2022 06:23:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] mapletree-vs-khugepaged
Content-Language: en-US
To:     Heiko Carstens <hca@linux.ibm.com>,
        Liam Howlett <liam.howlett@oracle.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220428172040.GA3623323@roeck-us.net> <YmvVkKXJWBoGqWFx@osiris>
 <yt9dk0apbicu.fsf@linux.ibm.com> <20220513165955.mkg5wvfi4dwpzoer@revolver>
 <YoOMsmq24FWsWWyr@osiris>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <YoOMsmq24FWsWWyr@osiris>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/22 04:53, Heiko Carstens wrote:
> On Fri, May 13, 2022 at 05:00:31PM +0000, Liam Howlett wrote:
>> * Sven Schnelle <svens@linux.ibm.com> [220513 10:46]:
>>> Heiko Carstens <hca@linux.ibm.com> writes:
>>>> FWIW, same on s390 - linux-next is completely broken. Note: I didn't
>>>> bisect, but given that the call trace, and even the failing address
>>>> match, I'm quite confident it is the same reason.
>>> IS that issue supposed to be fixed? git bisect pointed me to
>>>
>>> # bad: [76535d42eb53485775a8c54ea85725812b75543f] Merge branch
>>>    'mm-everything' of
>>>    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>>>
>>> which isn't really helpful.
>>>
>>> Anything we could help with debugging this?
>>
>> I tested the maple tree on top of the s390 as it was the same crash and
>> it was okay.  I haven't tested the mm-everything branch though.  Can you
>> test mm-unstable?
>>
>> I'll continue setting up a sparc VM for testing here and test
>> mm-everything on that and the s390
> 
> So due to reports here I did some sort of "special bisect": with today's
> linux-next I did a hard reset to commit 562340595cbb ("Merge branch
> 'for-next/kspp' of
> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git"),
> started a bisect on Andrew's tree between mm-stable and mm-unstable, and
> merged whatever commit was about to be bisected into 562340595cbb.
> 
> This lead finally to commit f1297d3a2cb7 ("mm/mmap: reorganize munmap to
> use maple states") as "first bad commit".
> 
> So given that we are shortly before the merge window and linux-next is
> completely broken for s390, how do we proceed? Right now I have no idea if
> there is anything else in linux-next that would break s390 because of this.
> 
> Even though I'm sure you won't like to hear this, but I'd appreciate if
> this code could be removed from linux-next again.

I finally found some time to bisect the alpha boot failures in -next.
Bisect results below.

Guenter

---
# bad: [47c1c54d1bcd0a69a56b49473bc20f17b70e5242] Add linux-next specific files for 20220517
# good: [42226c989789d8da4af1de0c31070c96726d990c] Linux 5.18-rc7
git bisect start 'HEAD' 'v5.18-rc7'
# good: [27d9fca0814b912f762dd5adeb81d9ab250705a9] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
git bisect good 27d9fca0814b912f762dd5adeb81d9ab250705a9
# good: [c57a4cecd8f02b365109fc326c7cde5ec6020a54] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
git bisect good c57a4cecd8f02b365109fc326c7cde5ec6020a54
# good: [0389ffdcdd4eacf5cfcef2a5e25b49a1662f8a8b] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
git bisect good 0389ffdcdd4eacf5cfcef2a5e25b49a1662f8a8b
# good: [c506c5c327711f8bb522c10262ec3a932fe91cd2] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git
git bisect good c506c5c327711f8bb522c10262ec3a932fe91cd2
# bad: [b24964a75c5c0129fd6a0d9bcb0fb6e84fbac126] mm/mmap: drop range_has_overlap() function
git bisect bad b24964a75c5c0129fd6a0d9bcb0fb6e84fbac126
# good: [3cbab4ca1ea8752912d8719d72059869b4c18045] mm/damon/sysfs: use enum for 'state' input handling
git bisect good 3cbab4ca1ea8752912d8719d72059869b4c18045
# good: [9113eaf331bf44579882c001867773cf1b3364fd] mm/memory-failure.c: add hwpoison_filter for soft offline
git bisect good 9113eaf331bf44579882c001867773cf1b3364fd
# good: [2b2adc303cebc213072520eb2e86e4beb65e9499] mm: remove rb tree.
git bisect good 2b2adc303cebc213072520eb2e86e4beb65e9499
# bad: [bbd9f664c351fbe61afa949abaaa03aed5c84af9] fs/proc/task_mmu: stop using linked list and highest_vm_end
git bisect bad bbd9f664c351fbe61afa949abaaa03aed5c84af9
# bad: [3b150cc8ab608f7a7da76b036b0ba7513628b0be] arm64: remove mmap linked list from vdso
git bisect bad 3b150cc8ab608f7a7da76b036b0ba7513628b0be
# good: [282a3e65bd1dece042bb8cf3a1666d79af1553b0] mm: use maple tree operations for find_vma_intersection()
git bisect good 282a3e65bd1dece042bb8cf3a1666d79af1553b0
# good: [d175d2cc268623e3e68181235a4aa068b50a8213] mm: convert vma_lookup() to use mtree_load()
git bisect good d175d2cc268623e3e68181235a4aa068b50a8213
# bad: [f1297d3a2cb77261c10fbbd69d92bbca700108e0] mm/mmap: reorganize munmap to use maple states
git bisect bad f1297d3a2cb77261c10fbbd69d92bbca700108e0
# good: [a897bb88e1e61df70f350a51f51cade3930adc3c] mm/mmap: move mmap_region() below do_munmap()
git bisect good a897bb88e1e61df70f350a51f51cade3930adc3c
# first bad commit: [f1297d3a2cb77261c10fbbd69d92bbca700108e0] mm/mmap: reorganize munmap to use maple states
