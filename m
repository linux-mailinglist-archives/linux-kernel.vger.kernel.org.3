Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EE1565847
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbiGDOI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbiGDOIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:08:22 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDA6184
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:08:19 -0700 (PDT)
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 264E7v25049441;
        Mon, 4 Jul 2022 23:07:57 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Mon, 04 Jul 2022 23:07:57 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 264E7vm9049438
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 4 Jul 2022 23:07:57 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <951dd1a9-2b48-fb0c-9ee2-aac2b8170c2c@I-love.SAKURA.ne.jp>
Date:   Mon, 4 Jul 2022 23:07:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] char: misc: make misc_open() and misc_register() killable
Content-Language: en-US
To:     Wedson Almeida Filho <wedsonaf@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <000000000000d9ff3a05bb37069e@google.com>
 <72e74af9-f1b6-e383-a2c3-6ee8a0aea5e0@I-love.SAKURA.ne.jp>
 <YsKW6VvWqvcMRBSl@kroah.com>
 <100f445e-9fa8-4f37-76aa-8359f0008c59@I-love.SAKURA.ne.jp>
 <YsLIepAXeBKT0AF/@kroah.com>
 <01a93294-e323-b9ca-7e95-a33d4b89dc47@I-love.SAKURA.ne.jp>
 <YsLkJ1LMMnM9Mo0K@google.com>
 <19598d43-de61-c663-25e8-17b6f5d5ef80@I-love.SAKURA.ne.jp>
 <YsLx5JckMbx/4V4/@google.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <YsLx5JckMbx/4V4/@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/07/04 22:57, Wedson Almeida Filho wrote:
> On Mon, Jul 04, 2022 at 10:48:32PM +0900, Tetsuo Handa wrote:
>> On 2022/07/04 21:59, Wedson Almeida Filho wrote:
>>>> @@ -139,6 +139,10 @@ static int misc_open(struct inode *inode, struct file *file)
>>>>  
>>>>  	err = 0;
>>>>  	replace_fops(file, new_fops);
>>>> +	if (iter->unlocked_open && file->f_op->open) {
>>>> +		mutex_unlock(&misc_mtx);
>>>> +		return file->f_op->open(inode, file);
>>>> +	}
>>>
>>> One of the invariants of miscdev is that once misc_deregister() returns,
>>> no new calls to f_op->open() are made. (Although, of course, you can
>>> still have open files but that's a whole different problem.)
>>
>> The point of this change is that file->f_op after mutex_unlock(&misc_mtx) is
>>  from new_fops which is guaranteed to hold a ref on "struct file_operations"
>> via new_fops = fops_get("struct miscdevice"->fops).
>> That is, a module ref remains valid even after mutex_unlock(&misc_mtx).
>>
>> And as with major_names_lock case quoted below, this change assumes that
>> misc_deregister() is called from module's __exit function, and fops_get()
>> is preventing the module owning new_fops from calling __exit function.
> 
> Your assumption is not sound. misc_deregister() can be (and is)
> legitimately called from other places, for example, a driver's remove()
> callback. In fact, when I grep for misc_deregister(), the second
> instance is such a case.

OK, the frequency of calling misc_deregister() can be much higher than
unregister_blkdev(), which means that misc_mtx is more prone to trigger
hung task warnings. I'm more inclined to avoid sleeping with misc_mtx held.

