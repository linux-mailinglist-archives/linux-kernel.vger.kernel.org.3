Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C680B59CE41
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 04:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239499AbiHWCGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 22:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239483AbiHWCGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 22:06:31 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DC012AF5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 19:06:29 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MBXbz6gJrzGpgt;
        Tue, 23 Aug 2022 10:04:47 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 23 Aug 2022 10:06:25 +0800
Subject: Re: [PATCH next] audit: fix potential double free on error path from
 fsnotify_add_inode_mark
To:     Paul Moore <paul@paul-moore.com>, Jan Kara <jack@suse.cz>,
        <cuigaosheng1@huawei.com>
CC:     <eparis@redhat.com>, <mszeredi@redhat.com>, <amir73il@gmail.com>,
        <linux-audit@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20220822022905.1949007-1-cuigaosheng1@huawei.com>
 <20220822085050.hxj6qmgj2x2tj6uv@quack3>
 <CAHC9VhSw0zJWQEm-GCzQy_-4-X-yVuzvX1wBFcYMkG1mOXy+BA@mail.gmail.com>
 <20220822152055.hitwrvi3lmldhcgx@quack3>
 <CAHC9VhQoTHZ4SFz2k7=2OLKFdrpmxq8ei-sNDNfV0MFtJsqpFg@mail.gmail.com>
 <20220822175907.q35mhoqdtdqxture@quack3>
 <CAHC9VhTpLqvZ7PCi3kn1NE6Sq967wLZA1MgnONUVYa0+j_EXbA@mail.gmail.com>
From:   cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <ab871457-8754-2d06-20f3-7743289d1ae9@huawei.com>
Date:   Tue, 23 Aug 2022 10:06:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTpLqvZ7PCi3kn1NE6Sq967wLZA1MgnONUVYa0+j_EXbA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.176]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/8/23 6:49, Paul Moore 写道:
> On Mon, Aug 22, 2022 at 1:59 PM Jan Kara <jack@suse.cz> wrote:
>> On Mon 22-08-22 13:39:23, Paul Moore wrote:
>>> On Mon, Aug 22, 2022 at 11:20 AM Jan Kara <jack@suse.cz> wrote:
>>>> On Mon 22-08-22 10:34:15, Paul Moore wrote:
>>>>> On Mon, Aug 22, 2022 at 4:50 AM Jan Kara <jack@suse.cz> wrote:
>>>>>> On Mon 22-08-22 10:29:05, Gaosheng Cui wrote:
>>>>>>> Audit_alloc_mark() assign pathname to audit_mark->path, on error path
>>>>>>> from fsnotify_add_inode_mark(), fsnotify_put_mark will free memory
>>>>>>> of audit_mark->path, but the caller of audit_alloc_mark will free
>>>>>>> the pathname again, so there will be double free problem.
>>>>>>>
>>>>>>> Fix this by resetting audit_mark->path to NULL pointer on error path
>>>>>>> from fsnotify_add_inode_mark().
>>>>>>>
>>>>>>> Fixes: 7b1293234084d ("fsnotify: Add group pointer in fsnotify_init_mark()")
>>>>>>> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
>>>>>> Good spotting! The patch looks good to me. Feel free to add:
>>>>>>
>>>>>> Reviewed-by: Jan Kara <jack@suse.cz>
>>>>>>
>>>>>>> ---
>>>>>>>   kernel/audit_fsnotify.c | 1 +
>>>>>>>   1 file changed, 1 insertion(+)
>>>>>>>
>>>>>>> diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
>>>>>>> index 6432a37ac1c9..c565fbf66ac8 100644
>>>>>>> --- a/kernel/audit_fsnotify.c
>>>>>>> +++ b/kernel/audit_fsnotify.c
>>>>>>> @@ -102,6 +102,7 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
>>>>>>>
>>>>>>>        ret = fsnotify_add_inode_mark(&audit_mark->mark, inode, 0);
>>>>>>>        if (ret < 0) {
>>>>>>> +             audit_mark->path = NULL;
>>>>>>>                fsnotify_put_mark(&audit_mark->mark);
>>>>> As I'm tracing the code path from audit through fsnotify, and back
>>>>> into audit, I'm wondering if we still have a problem.  When
>>>>> fsnotify_add_inode_mark() fails it will end up freeing not just
>>>>> audit_mark->path, but audit_mark itself via audit_fsnotify_mark_free()
>>>>> (via a call into fsnotify_put_mark()), yes?
>>>> I don't think so. fsnotify_add_mark_locked() will call fsnotify_put_mark()
>>>> but that is just a counter part to fsnotify_get_mark() a few lines above.
>>>> The caller of fsnotify_add_inode_mark() still holds its own mark reference
>>>> which prevents mark from being freed.
>>> Okay, that sounds reasonable, but I'm still looking for a code path
>>> that only frees audit_mark:path and not the audit_mark itself.  What
>>> am I not seeing?
>> The callers of audit_alloc_mark() call kfree(path) if audit_alloc_mark()
>> returns error (which is a sensible thing because in some cases path indeed
>> needs freeing).
> Of course!  Thanks for that, I think I got a bit of tunnel vision on
> this for some reason.
>
> I'll merge this into audit/stable-6.0 now and once testing is complete
> I'll send it up to Linus.  Thanks everyone!

Thanks for taking the time to review this patch. Thanks everyone!

