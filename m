Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C876448578F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 18:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242449AbiAERop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 12:44:45 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:23576 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242461AbiAERok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 12:44:40 -0500
Received: from host81-132-12-162.range81-132.btcentralplus.com ([81.132.12.162] helo=[192.168.1.218])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1n5AKx-0000lW-FP; Wed, 05 Jan 2022 17:44:36 +0000
Message-ID: <96d9e6d4-16e5-6bfe-fc5a-7d0dfbaeadf0@youngman.org.uk>
Date:   Wed, 5 Jan 2022 17:44:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: mdadm regression tests fail
Content-Language: en-GB
To:     Randy Dunlap <rdunlap@infradead.org>,
        Bruce Dubbs <bruce.dubbs@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-raid@vger.kernel.org
Cc:     "Douglas R. Reno" <renodr2002@gmail.com>,
        Pierre Labastie <pierre.labastie@neuf.fr>
References: <c4c17b11-16f4-ef70-5897-02f923907963@gmail.com>
 <45492ddd-42f1-674f-af27-5e0a0aace8c9@infradead.org>
From:   Wols Lists <antlists@youngman.org.uk>
In-Reply-To: <45492ddd-42f1-674f-af27-5e0a0aace8c9@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bear in mind raid superblock v0.9 is deprecated as in "if it breaks it 
won't be fixed for you".

So I would skip this test, and if you're mentioning raid in the 
handbook, tell people they need to use one of the v1.x formats.

(NB - you can always point them at the linux raid wiki.)

Cheers,
Wol

On 05/01/2022 17:12, Randy Dunlap wrote:
> Hi.
> [adding linux-raid mailing list]
> 
> 
> On 1/4/22 10:55, Bruce Dubbs wrote:
>> I am trying to document the mdadm-4.2 installation procedures for our book,
>> https://www.linuxfromscratch.org/blfs/view/svn/postlfs/mdadm.html
>>
>> For testing, I am doing a simple:
>>
>>    make
>>    sudo ./test --keep-going --logdir=test-logs --save-logs
>>
>> But I get failures for about half the tests.
>>
>> Digging in a bit I just ran:
>>
>>   sudo ./test --tests=00raid0 --logdir=test-logs
>>
>> This is the first test that fails.  With some hacking, it appears that the first portion of this test that fails is:
>>
>>    mdadm -CR $md0 -e0.90 -l0 -n4 $dev0 $dev1 $dev2 $dev3
>>
>> This resolves to
>>
>>    mdadm -CR /dev/md0 -e0.90 -l0 -n4 /dev/loop0 /dev/loop1 /dev/loop2 /dev/loop3
>>
>> There is not a lot of error output in the test, so I manually ran:
>>
>>    dd if=/dev/zero of=/tmp/mdtest0 count=20000 bs=1K
>>    losetup /dev/loop0 /tmp/mdtest0
>>
>> For /dev/loop[0123]
>>
>> Then I ran
>>
>>    mdadm -CR /dev/md0 -e0.90 -l0 -n4 /dev/loop0 /dev/loop1 /dev/loop2 /dev/loop3
>>    mdadm: 0.90 metadata does not support layouts for RAID0
>>
>> My question is whether the regression tests in the tarball are valid for mdadm-4.2?
>>
>>    -- Bruce Dubbs
>>       linuxfromscratch.org
>>
>> Note: The kernel is version 5.15.12.
> 

