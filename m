Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0F657A0C0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238582AbiGSOJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237725AbiGSOIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:08:34 -0400
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71674E869
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 06:25:17 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id DnDrouVrVAeI9DnDro6WTl; Tue, 19 Jul 2022 15:25:16 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 19 Jul 2022 15:25:16 +0200
X-ME-IP: 90.11.190.129
Message-ID: <29c3fbdd-7695-46c5-bb75-fe358c574ab3@wanadoo.fr>
Date:   Tue, 19 Jul 2022 15:25:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/3] ocfs2: Remove a useless spinlock
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>
References: <bd6796635e58f9c47cf857573c3b9474a00ce26a.1658224839.git.christophe.jaillet@wanadoo.fr>
 <8ba7004d330cbe5f626539a8a3bff696d0c4285e.1658224839.git.christophe.jaillet@wanadoo.fr>
 <7b644e5d32d74d3d90dfc5b1786ae5b9@AcuMS.aculab.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <7b644e5d32d74d3d90dfc5b1786ae5b9@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 19/07/2022 à 12:24, David Laight a écrit :
> From: Christophe JAILLET
>> Sent: 19 July 2022 11:02
>>
>> 'node_map_lock' is a spinlock only used to protect calls to set_bit(),
>> clear_bit() and test_bit().
>>
>> {set|clear}_bit() are already atomic and don't need this extra spinlock.
>> test_bit() only reads the bitmap for a given bit.
>>
>> Remove this useless spinlock.
> 
> It looks to me like the calling code is racy
> unless there is another lock in the callers.

The call chains are:
   ocfs2_recover_orphans()
     ocfs2_mark_recovering_orphan_dir()
       spin_lock(&osb->osb_lock);		<-- osb_lock spinlock
       ocfs2_node_map_set_bit()			<-- uses node_map_lock
       ...
       spin_unlock(&osb->osb_lock);
     ...
     ocfs2_clear_recovering_orphan_dir()
       ocfs2_node_map_clear_bit()		<-- uses node_map_lock
						    osb_lock is NOT taken


   ocfs2_check_orphan_recovery_state()
     spin_lock(&osb->osb_lock);			<-- osb_lock spinlock
     ...
     ocfs2_node_map_test_bit()			<-- uses node_map_lock
     ...
     spin_unlock(&osb->osb_lock);


So the code looks already protected by the 'osb_lock' spinlock, but I 
don't know this code and ocfs2_mark_recovering_orphan_dir() looks tricky 
to me. (so some other eyes are much welcome)

> While map->map is protected, the result of test_bit()
> is stale - so can't be used for much.
> 

Anyway, should there be a locking issue, it is there with or without my 
patch, right?

CJ


> 	David
> 
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> test_bit() is NOT documented as an atomic function. However, I can't see
>> how it could return a wrong result here.
>>
>> So review with care. There is maybe something I don't think about that is
>> lurking here.
>> ---
>>   fs/ocfs2/heartbeat.c | 11 ++++-------
>>   fs/ocfs2/ocfs2.h     |  2 --
>>   2 files changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/ocfs2/heartbeat.c b/fs/ocfs2/heartbeat.c
>> index 1d72e0788943..4863ad35c242 100644
>> --- a/fs/ocfs2/heartbeat.c
>> +++ b/fs/ocfs2/heartbeat.c
>> @@ -35,7 +35,6 @@ static void ocfs2_node_map_init(struct ocfs2_node_map *map)
>>
>>   void ocfs2_init_node_maps(struct ocfs2_super *osb)
>>   {
>> -	spin_lock_init(&osb->node_map_lock);
>>   	ocfs2_node_map_init(&osb->osb_recovering_orphan_dirs);
>>   }
>>
>> @@ -67,9 +66,8 @@ void ocfs2_node_map_set_bit(struct ocfs2_super *osb,
>>   	if (bit==-1)
>>   		return;
>>   	BUG_ON(bit >= map->num_nodes);
>> -	spin_lock(&osb->node_map_lock);
>> +
>>   	set_bit(bit, map->map);
>> -	spin_unlock(&osb->node_map_lock);
>>   }
>>
>>   void ocfs2_node_map_clear_bit(struct ocfs2_super *osb,
>> @@ -79,9 +77,8 @@ void ocfs2_node_map_clear_bit(struct ocfs2_super *osb,
>>   	if (bit==-1)
>>   		return;
>>   	BUG_ON(bit >= map->num_nodes);
>> -	spin_lock(&osb->node_map_lock);
>> +
>>   	clear_bit(bit, map->map);
>> -	spin_unlock(&osb->node_map_lock);
>>   }
>>
>>   int ocfs2_node_map_test_bit(struct ocfs2_super *osb,
>> @@ -89,13 +86,13 @@ int ocfs2_node_map_test_bit(struct ocfs2_super *osb,
>>   			    int bit)
>>   {
>>   	int ret;
>> +
>>   	if (bit >= map->num_nodes) {
>>   		mlog(ML_ERROR, "bit=%d map->num_nodes=%d\n", bit, map->num_nodes);
>>   		BUG();
>>   	}
>> -	spin_lock(&osb->node_map_lock);
>> +
>>   	ret = test_bit(bit, map->map);
>> -	spin_unlock(&osb->node_map_lock);
>>   	return ret;
>>   }
>>
>> diff --git a/fs/ocfs2/ocfs2.h b/fs/ocfs2/ocfs2.h
>> index 740b64238312..1df193b97c30 100644
>> --- a/fs/ocfs2/ocfs2.h
>> +++ b/fs/ocfs2/ocfs2.h
>> @@ -302,8 +302,6 @@ struct ocfs2_super
>>
>>   	u32 *slot_recovery_generations;
>>
>> -	spinlock_t node_map_lock;
>> -
>>   	u64 root_blkno;
>>   	u64 system_dir_blkno;
>>   	u64 bitmap_blkno;
>> --
>> 2.34.1
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
> 

