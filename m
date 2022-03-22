Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19DF4E3691
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 03:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbiCVCR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 22:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbiCVCRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 22:17:51 -0400
Received: from out199-12.us.a.mail.aliyun.com (out199-12.us.a.mail.aliyun.com [47.90.199.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271D325C6A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 19:15:39 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0V7tYAbz_1647915334;
Received: from 30.225.24.67(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0V7tYAbz_1647915334)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 22 Mar 2022 10:15:35 +0800
Message-ID: <5aefc78f-9a75-9b44-9471-87f42011b7c2@linux.alibaba.com>
Date:   Tue, 22 Mar 2022 10:15:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH] ocfs2: fix check if list iterator did find an element
Content-Language: en-US
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Mark Fasheh <mark@fasheh.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, Joel Becker <jlbec@evilplan.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220319203106.2541700-1-jakobkoschel@gmail.com>
 <abcbf5d2-c348-7dc0-cfd3-9bcc6431bc64@linux.alibaba.com>
 <A7AA04AA-6B4C-4211-99A6-0D3C04ED7B26@gmail.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <A7AA04AA-6B4C-4211-99A6-0D3C04ED7B26@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/21/22 9:34 PM, Jakob Koschel wrote:
> 
>> On 21. Mar 2022, at 02:50, Joseph Qi <joseph.qi@linux.alibaba.com> wrote:
>>
>>
>>
>> On 3/20/22 4:31 AM, Jakob Koschel wrote:
>>> Instead of setting 'res' to NULL, it should only be set if
>>> the suitable element was found.
>>>
>>> In the original code 'res' would have been set to an incorrect pointer
>>> if the list is empty.
>>>
>> The logic before iteration can make sure track_list won't be empty.
>> Please refer the discussion via:
>> https://lore.kernel.org/ocfs2-devel/bd0ec87e-b490-83dc-2363-5e5342c59fa4@linux.alibaba.com/T/#m96d4397930201d83d68677c33a9721ae8dbd8f15
> 
> ah yes, I just read up on the discussion there, sorry for having duplicated it
> here.
> 
> Was any conclusion reached there which fixes can/should be merged?
> 
> This code obviously can always be safe if the list cannot be empty.
> That's also not necessarily the reason I'm fixing this. The reason is that
> we want to get rid of any use of the list iterator variable after the loop
> ('res' in this case). This will allow moving the list iterator variable
> into the scope of the list iterator macro to forbid any invalid use of it
> at compile time. Like this you don't have to rely on assumptions that are
> hard to validate (e.g. that a certain list is never empty).
> 
> The patch here is the minimal change to simply do that but looking at
> Dan Carpenter patch there might be more things in this code that can
> be simplified.
> 
Agree, so I'm fine with this change.
So could you please update the description and send v2?

Thanks,
Joseph

> [CC'd Dan Carpenter]
> 
> See [1] for changes that have already been merged:
> 
> [1] https://lore.kernel.org/linux-kernel/20220308171818.384491-3-jakobkoschel@gmail.com/
> 
>>
>> Thanks,
>> Joseph
>>
>>> In preparation to limit the scope of the list iterator to the list
>>> traversal loop, use a dedicated pointer pointing to the found element [1].
>>>
>>> Link: https://lore.kernel.org/all/YhdfEIwI4EdtHdym@kroah.com/
>>> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
>>> ---
>>> fs/ocfs2/dlm/dlmdebug.c | 12 ++++++------
>>> 1 file changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/fs/ocfs2/dlm/dlmdebug.c b/fs/ocfs2/dlm/dlmdebug.c
>>> index d442cf5dda8a..be5e9ed7da8d 100644
>>> --- a/fs/ocfs2/dlm/dlmdebug.c
>>> +++ b/fs/ocfs2/dlm/dlmdebug.c
>>> @@ -541,7 +541,7 @@ static void *lockres_seq_start(struct seq_file *m, loff_t *pos)
>>> 	struct debug_lockres *dl = m->private;
>>> 	struct dlm_ctxt *dlm = dl->dl_ctxt;
>>> 	struct dlm_lock_resource *oldres = dl->dl_res;
>>> -	struct dlm_lock_resource *res = NULL;
>>> +	struct dlm_lock_resource *res = NULL, *iter;
>>> 	struct list_head *track_list;
>>>
>>> 	spin_lock(&dlm->track_lock);
>>> @@ -556,11 +556,11 @@ static void *lockres_seq_start(struct seq_file *m, loff_t *pos)
>>> 		}
>>> 	}
>>>
>>> -	list_for_each_entry(res, track_list, tracking) {
>>> -		if (&res->tracking == &dlm->tracking_list)
>>> -			res = NULL;
>>> -		else
>>> -			dlm_lockres_get(res);
>>> +	list_for_each_entry(iter, track_list, tracking) {
>>> +		if (&iter->tracking != &dlm->tracking_list) {
>>> +			dlm_lockres_get(iter);
>>> +			res = iter;
>>> +		}
>>> 		break;
>>> 	}
>>> 	spin_unlock(&dlm->track_lock);
>>>
>>> base-commit: 34e047aa16c0123bbae8e2f6df33e5ecc1f56601
>>> --
>>> 2.25.1
> 
> 	Jakob
