Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01FA52A4E9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349000AbiEQOcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348974AbiEQOcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:32:36 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437212E0BC
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:32:34 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id z15-20020a9d65cf000000b00605f064482cso12292399oth.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uDeOasEP4bkxX+GLxjzJeOaAS/nni8FlEebfZiyJwRw=;
        b=Jjj3ql/A3szAQ6aQlsMetuItQV6OZzRvAGnWStnH9PB/flpellz9AH8+xi4mRlBCor
         SKUa4ZqFTttP4eqylQfqKP7MzZRU/Z84Kj3S3YuyDdx+e7DjGgbQ304JrrGJ8hbVsjs5
         kKxErIPN/fTKYZGwTQjSDMS4/OwnilvkDhu0/rNYgAjpqlC8T02WCqWyh9r473J/csfR
         BLHXLzB+ZoeF++wdKeb9GgZ7UNb7HW8+B3isJ+6ZfaWJs0jWXFTM8RP1m0Mtlsi75ifU
         ocCcDsz3DuX1bmBwgJzj3etG2X0zdb96Qnun7xWzHlJk5o41LiVO7AmxVAwMPBMoSruw
         /EFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uDeOasEP4bkxX+GLxjzJeOaAS/nni8FlEebfZiyJwRw=;
        b=2c7HsIj7RTZUycjyXo0W0dv4gvdyh0Iw5H4yz+ho/LE8JWj/Nbt6zFag0LmgBFwUjs
         QocOHEJmWvqZ7rDuJZcWQXBOzFkX4bGmvo83KxyvAUmiVgXRdY+Vn7NgtedpTehHurs5
         sITQZWWg7fkbsohpl1yDf+QdrU9YBdwwm1nIwTvuAgMsejeOWy8Gyme0o8lkVLWXq3NE
         UPUuph6+5JtQXu/6buj3GOPkMyAFjdWRnu0NMBmMQBu9Xe4zTgXNwmTqLxK2tKu7hVu8
         Js1sDQ3hEs2beY/6AnULxCblasmdJxuhn8OPaY9tGPqJ9EHTDdZMvrtzbccZDSDx4Cpt
         Tczw==
X-Gm-Message-State: AOAM530d4Nr+ktvhcjBonTEZ/vs2d7EsbyEB7wCsRiUdG5kyEWSOcKdT
        9SsSWy70bJCIWHe5smajNJ97HnOYmdwj2g==
X-Google-Smtp-Source: ABdhPJxE2mUqYa2ahV/ZN53ovoeDcxjSnNHhIj/+cTbzB56UxUUc1wz0LHRswp2ydnTZzDjkesOPBQ==
X-Received: by 2002:a9d:875:0:b0:605:fbdd:ae3d with SMTP id 108-20020a9d0875000000b00605fbddae3dmr8065309oty.352.1652797953557;
        Tue, 17 May 2022 07:32:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o184-20020aca5ac1000000b00328abf1e309sm4914815oib.23.2022.05.17.07.32.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 07:32:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b18d5338-0031-a813-2825-207bea1b84cb@roeck-us.net>
Date:   Tue, 17 May 2022 07:32:30 -0700
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

Another bisect result, boot failures with nommu targets (arm:mps2-an385,
m68k:mcf5208evb). Bisect log is the same for both.

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
# good: [bbd9f664c351fbe61afa949abaaa03aed5c84af9] fs/proc/task_mmu: stop using linked list and highest_vm_end
git bisect good bbd9f664c351fbe61afa949abaaa03aed5c84af9
# good: [e09906217c535bd7c2e4eb35182543214c4b8891] mm/mempolicy: use vma iterator & maple state instead of vma linked list
git bisect good e09906217c535bd7c2e4eb35182543214c4b8891
# good: [0154775a4cf2bc79c2220207816c86142f259e95] mm/pagewalk: use vma_find() instead of vma linked list
git bisect good 0154775a4cf2bc79c2220207816c86142f259e95
# bad: [bd773a78705fb58eeadd80e5b31739df4c83c559] nommu: remove uses of VMA linked list
git bisect bad bd773a78705fb58eeadd80e5b31739df4c83c559
# good: [387141902a1de92a387816ae819d6111e582c6eb] i915: use the VMA iterator
git bisect good 387141902a1de92a387816ae819d6111e582c6eb
# first bad commit: [bd773a78705fb58eeadd80e5b31739df4c83c559] nommu: remove uses of VMA linked list
