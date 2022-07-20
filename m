Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D61157B430
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 11:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238726AbiGTJtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 05:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiGTJtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 05:49:00 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D834965D7C;
        Wed, 20 Jul 2022 02:48:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VJwWVRl_1658310535;
Received: from 30.227.66.165(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VJwWVRl_1658310535)
          by smtp.aliyun-inc.com;
          Wed, 20 Jul 2022 17:48:55 +0800
Message-ID: <65e6bbcb-2c33-2e43-1826-a62387572310@linux.alibaba.com>
Date:   Wed, 20 Jul 2022 17:48:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] ocfs2: Remove a useless spinlock
Content-Language: en-US
To:     Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     David.Laight@ACULAB.COM, jlbec@evilplan.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark@fasheh.com, ocfs2-devel@oss.oracle.com
References: <bd6796635e58f9c47cf857573c3b9474a00ce26a.1658224839.git.christophe.jaillet@wanadoo.fr>
 <8ba7004d330cbe5f626539a8a3bff696d0c4285e.1658224839.git.christophe.jaillet@wanadoo.fr>
 <7b644e5d32d74d3d90dfc5b1786ae5b9@AcuMS.aculab.com>
 <29c3fbdd-7695-46c5-bb75-fe358c574ab3@wanadoo.fr>
 <07c924de-78bf-c993-ce73-635af71f4edd@linux.alibaba.com>
 <f313cb6f-de75-2447-eebc-5c240bc243a2@wanadoo.fr>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <f313cb6f-de75-2447-eebc-5c240bc243a2@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/22 4:26 PM, Marion & Christophe JAILLET wrote:
> 
> Le 20/07/2022 à 03:59, Joseph Qi a écrit :
>>
>> On 7/19/22 9:25 PM, Christophe JAILLET wrote:
>>> Le 19/07/2022 à 12:24, David Laight a écrit :
>>>> From: Christophe JAILLET
>>>>> Sent: 19 July 2022 11:02
>>>>>
>>>>> 'node_map_lock' is a spinlock only used to protect calls to set_bit(),
>>>>> clear_bit() and test_bit().
>>>>>
>>>>> {set|clear}_bit() are already atomic and don't need this extra spinlock.
>>>>> test_bit() only reads the bitmap for a given bit.
>>>>>
>>>>> Remove this useless spinlock.
>>>> It looks to me like the calling code is racy
>>>> unless there is another lock in the callers.
>>> The call chains are:
>>>    ocfs2_recover_orphans()
>>>      ocfs2_mark_recovering_orphan_dir()
>>>        spin_lock(&osb->osb_lock);        <-- osb_lock spinlock
>>>        ocfs2_node_map_set_bit()            <-- uses node_map_lock
>>>        ...
>>>        spin_unlock(&osb->osb_lock);
>>>      ...
>>>      ocfs2_clear_recovering_orphan_dir()
>>>        ocfs2_node_map_clear_bit()        <-- uses node_map_lock
>>>                              osb_lock is NOT taken
>>>
>>>
>>>    ocfs2_check_orphan_recovery_state()
>>>      spin_lock(&osb->osb_lock);            <-- osb_lock spinlock
>>>      ...
>>>      ocfs2_node_map_test_bit()            <-- uses node_map_lock
>>>      ...
>>>      spin_unlock(&osb->osb_lock);
>>>
>>>
>>> So the code looks already protected by the 'osb_lock' spinlock, but I don't know this code and ocfs2_mark_recovering_orphan_dir() looks tricky to me. (so some other eyes are much welcome)
>>   osb_lock is to protect osb filed such as 'osb_orphan_wipes', while
>> node_map_lock is to protect the node map 'osb_recovering_orphan_dirs'
>> specifically.
> 
> Thanks for this explanation.
> 
> But does "node_map_lock" really protects anything?
> It is just around some atomic function calls which shouldn't need any, right?
> 
> test_bit() is not documented as atomic, but {clear|set}_bit() could be executed just before or just after it with the current locking mechanism, so I don't really see how it would make a difference.
> 
> I don't understand the logic of this lock here.
> 
> Can you elaborate?

These code are introduced long time ago...
Refer to commit b4df6ed8db0c "[PATCH] ocfs2: fix orphan recovery
deadlock", I guess it plays a role 'barrier' and make sure test node map
is executed prior than signal orphan recovery thread. In other words, to
serialize evict inode and orphan recovery.

Thanks,
Joseph
