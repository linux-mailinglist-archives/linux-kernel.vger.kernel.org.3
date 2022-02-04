Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C887F4A92AD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 04:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356707AbiBDDTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 22:19:55 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40468 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiBDDTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 22:19:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20C07B83654
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 03:19:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995B8C340E8;
        Fri,  4 Feb 2022 03:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643944791;
        bh=ZlIGcuypCyxj9pYmnJrdabP+w4iW8DzvlECu6ZAvYc8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jqOpNuHa9UFJfOYzzBlS61vK2kMADyjb2qAnQDZe1p/KPv107AkasJinDP95LZRqJ
         3QFZ4j4mt0Qvwz4myjzGUzda423myiIxvh/Yjs4BqqmTKlXVQ+8/8Z8R+XasKbz+OO
         RgvqvtaV6Sc+ONZXke77i4xFw3aQDBybj0waXbtZnVLkVihPoCHyFNPxPxRqQk+2t1
         EVPKG2efvy3ic16o/hHQoJ5ZkyuH3o/Inj4aMBHBqcT59fR+iAlmKX896iygRpIuCl
         VCagGdRAgnQ92V1Tz/kwAqYJJuYJmtkgLAytkST5Zp/RGHL6N0WfEqYfsqZ+jneAc4
         wOxmExkLfeQcQ==
Message-ID: <9faddf59-0c09-aa20-981a-65b06c4517ae@kernel.org>
Date:   Fri, 4 Feb 2022 11:19:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] f2fs: fix to unlock page correctly in error path of
 is_alive()
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@denx.de>
References: <20220203144705.23528-1-chao@kernel.org>
 <Yfw1FnkiO+U+zGS0@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Yfw1FnkiO+U+zGS0@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/2/4 4:03, Jaegeuk Kim wrote:
> On 02/03, Chao Yu wrote:
>> As Pavel Machek reported in below link [1]:
>>
>> After commit 77900c45ee5c ("f2fs: fix to do sanity check in is_alive()"),
>> node page should be unlock via calling f2fs_put_page() in the error path
>> of is_alive(), otherwise, f2fs may hang when it tries to lock the node
>> page, fix it.
>>
>> [1] https://lore.kernel.org/stable/20220124203637.GA19321@duo.ucw.cz/
> 
> Need -stable? It seems 4.19+?

It depends on where commit 77900c45ee5c ("f2fs: fix to do sanity check in is_alive()")
be backported to? Anyway, let me Cc stable-kernel mailing list.

Thanks,

> 
>>
>> Fixes: 77900c45ee5c ("f2fs: fix to do sanity check in is_alive()")
>> Reported-by: Pavel Machek <pavel@denx.de>
>> Signed-off-by: Pavel Machek <pavel@denx.de>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/gc.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index 0a6b0a8ae97e..2d53ef121e76 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -1038,8 +1038,10 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>>   		set_sbi_flag(sbi, SBI_NEED_FSCK);
>>   	}
>>   
>> -	if (f2fs_check_nid_range(sbi, dni->ino))
>> +	if (f2fs_check_nid_range(sbi, dni->ino)) {
>> +		f2fs_put_page(node_page, 1);
>>   		return false;
>> +	}
>>   
>>   	*nofs = ofs_of_node(node_page);
>>   	source_blkaddr = data_blkaddr(NULL, node_page, ofs_in_node);
>> -- 
>> 2.32.0
