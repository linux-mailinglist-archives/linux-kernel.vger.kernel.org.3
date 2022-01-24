Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDB7499746
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 22:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448131AbiAXVMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 16:12:03 -0500
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:57501 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390405AbiAXUpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 15:45:19 -0500
Received: from [192.168.1.18] ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id C6DBnl19kAWDQC6DBnQiEv; Mon, 24 Jan 2022 21:45:16 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 24 Jan 2022 21:45:16 +0100
X-ME-IP: 90.126.236.122
Message-ID: <6a1b84da-d55e-e058-13a8-9920b05ff20d@wanadoo.fr>
Date:   Mon, 24 Jan 2022 21:45:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] lib/string_helpers: Use the given gfp flag when
 allocating memory
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <1ec96b6e4f2e35599931d7516c6938c4a8845bf0.1642337606.git.christophe.jaillet@wanadoo.fr>
 <Ye63DkOZkBd2j+8+@smile.fi.intel.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <Ye63DkOZkBd2j+8+@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 24/01/2022 à 15:26, Andy Shevchenko a écrit :
> On Sun, Jan 16, 2022 at 01:53:37PM +0100, Christophe JAILLET wrote:
>> kstrdup_quotable_cmdline() and kstrdup_quotable_file() are given a gfp flag
>> that is passed and used for memory allocation in kstrdup_quotable() just a
>> few lines below.
>>
>> It looks reasonable to use this gfp value for the buffer allocated and
>> freed in these functions as well.
> 
> Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Hi,
just in case, another patch has been proposed in the thread related to 
the v1 of this patch.
See [1].

I let you see which approach is the more relevant.

CJ

[1]: https://lore.kernel.org/linux-kernel/YeU8PhtvvXIWtTk%2F@dhcp22.suse.cz/

> 
>> Fixes: 0ee931c4e31a ("mm: treewide: remove GFP_TEMPORARY allocation flag")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> According to what I've found in 5.16, all callers use GFP_KERNEL, so this
>> patch should be a no-op.
>> But who knows how it will be used in the future. Better safe than sorry.
>>
>> v2: Add the change for kstrdup_quotable_file()
>> ---
>>   lib/string_helpers.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/string_helpers.c b/lib/string_helpers.c
>> index 90f9f1b7afec..4433e486b725 100644
>> --- a/lib/string_helpers.c
>> +++ b/lib/string_helpers.c
>> @@ -624,7 +624,7 @@ char *kstrdup_quotable_cmdline(struct task_struct *task, gfp_t gfp)
>>   	char *buffer, *quoted;
>>   	int i, res;
>>   
>> -	buffer = kmalloc(PAGE_SIZE, GFP_KERNEL);
>> +	buffer = kmalloc(PAGE_SIZE, gfp);
>>   	if (!buffer)
>>   		return NULL;
>>   
>> @@ -660,7 +660,7 @@ char *kstrdup_quotable_file(struct file *file, gfp_t gfp)
>>   		return kstrdup("<unknown>", gfp);
>>   
>>   	/* We add 11 spaces for ' (deleted)' to be appended */
>> -	temp = kmalloc(PATH_MAX + 11, GFP_KERNEL);
>> +	temp = kmalloc(PATH_MAX + 11, gfp);
>>   	if (!temp)
>>   		return kstrdup("<no_memory>", gfp);
>>   
>> -- 
>> 2.32.0
>>
> 

