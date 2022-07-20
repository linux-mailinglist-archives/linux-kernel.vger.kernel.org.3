Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE5E57B2D9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 10:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239724AbiGTI0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 04:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235039AbiGTI0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 04:26:41 -0400
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3439B66AF9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:26:40 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id E52RoVdt2xFTAE52Ro9pAL; Wed, 20 Jul 2022 10:26:38 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 20 Jul 2022 10:26:38 +0200
X-ME-IP: 90.11.190.129
Message-ID: <f313cb6f-de75-2447-eebc-5c240bc243a2@wanadoo.fr>
Date:   Wed, 20 Jul 2022 10:26:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/3] ocfs2: Remove a useless spinlock
Content-Language: en-US
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     David.Laight@ACULAB.COM, christophe.jaillet@wanadoo.fr,
        jlbec@evilplan.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark@fasheh.com,
        ocfs2-devel@oss.oracle.com
References: <bd6796635e58f9c47cf857573c3b9474a00ce26a.1658224839.git.christophe.jaillet@wanadoo.fr>
 <8ba7004d330cbe5f626539a8a3bff696d0c4285e.1658224839.git.christophe.jaillet@wanadoo.fr>
 <7b644e5d32d74d3d90dfc5b1786ae5b9@AcuMS.aculab.com>
 <29c3fbdd-7695-46c5-bb75-fe358c574ab3@wanadoo.fr>
 <07c924de-78bf-c993-ce73-635af71f4edd@linux.alibaba.com>
From:   Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <07c924de-78bf-c993-ce73-635af71f4edd@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 20/07/2022 à 03:59, Joseph Qi a écrit :
>
> On 7/19/22 9:25 PM, Christophe JAILLET wrote:
>> Le 19/07/2022 à 12:24, David Laight a écrit :
>>> From: Christophe JAILLET
>>>> Sent: 19 July 2022 11:02
>>>>
>>>> 'node_map_lock' is a spinlock only used to protect calls to set_bit(),
>>>> clear_bit() and test_bit().
>>>>
>>>> {set|clear}_bit() are already atomic and don't need this extra spinlock.
>>>> test_bit() only reads the bitmap for a given bit.
>>>>
>>>> Remove this useless spinlock.
>>> It looks to me like the calling code is racy
>>> unless there is another lock in the callers.
>> The call chains are:
>>    ocfs2_recover_orphans()
>>      ocfs2_mark_recovering_orphan_dir()
>>        spin_lock(&osb->osb_lock);        <-- osb_lock spinlock
>>        ocfs2_node_map_set_bit()            <-- uses node_map_lock
>>        ...
>>        spin_unlock(&osb->osb_lock);
>>      ...
>>      ocfs2_clear_recovering_orphan_dir()
>>        ocfs2_node_map_clear_bit()        <-- uses node_map_lock
>>                              osb_lock is NOT taken
>>
>>
>>    ocfs2_check_orphan_recovery_state()
>>      spin_lock(&osb->osb_lock);            <-- osb_lock spinlock
>>      ...
>>      ocfs2_node_map_test_bit()            <-- uses node_map_lock
>>      ...
>>      spin_unlock(&osb->osb_lock);
>>
>>
>> So the code looks already protected by the 'osb_lock' spinlock, but I don't know this code and ocfs2_mark_recovering_orphan_dir() looks tricky to me. (so some other eyes are much welcome)
>   
> osb_lock is to protect osb filed such as 'osb_orphan_wipes', while
> node_map_lock is to protect the node map 'osb_recovering_orphan_dirs'
> specifically.

Thanks for this explanation.

But does "node_map_lock" really protects anything?
It is just around some atomic function calls which shouldn't need any, 
right?

test_bit() is not documented as atomic, but {clear|set}_bit() could be 
executed just before or just after it with the current locking 
mechanism, so I don't really see how it would make a difference.

I don't understand the logic of this lock here.

Can you elaborate?

CJ


> Thanks,
> Joseph
>
