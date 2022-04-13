Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D31E4FF59A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 13:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbiDMLXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 07:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiDMLXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 07:23:04 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4399B26AD9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 04:20:43 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bh17so3231560ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 04:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yMHX8VmInfu96ICFrLyuQfmIbbC+AVb0b8MRzaL94OU=;
        b=mRgDYFsUynZQPMKvQ56e8mxiZ9Xy0A9C/mv9RlUnftc4X/afdBAhLXecN5e0xdj3JR
         BSyVG8UidHxqSRpwTWyYFPt6su9knUQ85uNVAiUGUDSw5whiI9izaJOrs0qCNvHvfgGm
         qXdSYfKFwdJb3ZYdInIr+DX0yDhWJqDnD1JSbBs78TOzvatMaI1zadBZuW9ZLU4bpK1v
         O6HMX/S0DpstwftC2/VT7zOXrmqhcFByr/RukOi3nUnTqaOL2Ov7P1f3tQNkS5496Ret
         /qTD+pACyTpRAo+IG22wTVTv2d5lQkAZy3TwtFaWQofbMcWWQUwQQwKysSUrqUbQzhya
         LvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yMHX8VmInfu96ICFrLyuQfmIbbC+AVb0b8MRzaL94OU=;
        b=TPtymrlX5rORnY1bay/tVVz+AJR8WmnfsiEM1+7TKf3Ba7XbFGmEQV6DqtoJn93GHc
         fGsr9+B04ITZ93MIj07aF5p2A+ENkzAUCoFPUXAbz4Dyr0gmTOdqC870EfRued167aD2
         5UXENci6AON0eY9TZHeSxGNP11eTeZVfYxkqLfsAYXwvccWHU7yRrIsLOqwUUGhX5Ulo
         /9/a7DMkV5Z1VAyN98qL1kBb+WO2Oq1rqsJcatrS4pA4dpgxb4TqJJc4q3O41bVHiEGd
         fQGES5XwRgfzmOo2M/FxjzkscmvIwTqdzO7ikDcqa6n2tQTtUYklUPLPQ79M4Eqraxty
         7oYQ==
X-Gm-Message-State: AOAM530N0NFK3ZJa0WcxCoWVOj95R54zBowQQDb18lH8AgqlT+e0EgLQ
        7emwDfIBtW6BnJxkm0mbtRc=
X-Google-Smtp-Source: ABdhPJx34Og2EC543+P/clWmi2EFDObDXiIQKE++7zn61HRVanxWZuTW93TmqyezvOnQwBX8vMa7Kg==
X-Received: by 2002:a17:906:2991:b0:6cf:6b24:e92f with SMTP id x17-20020a170906299100b006cf6b24e92fmr37834229eje.748.1649848841596;
        Wed, 13 Apr 2022 04:20:41 -0700 (PDT)
Received: from [192.168.1.2] (host-79-54-81-151.retail.telecomitalia.it. [79.54.81.151])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709063e8100b006ce06ed8aa7sm14162272ejj.142.2022.04.13.04.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 04:20:41 -0700 (PDT)
Message-ID: <b14ed993-6c3a-ca0a-1b5c-b365628bd1fc@gmail.com>
Date:   Wed, 13 Apr 2022 13:20:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] binder: Address corner cases in deferred copy and fixup
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tkjos@android.com, brauner@kernel.org, arve@android.com,
        linux-kernel@vger.kernel.org, maco@android.com,
        Joel Fernandes <joel@joelfernandes.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>
References: <20220413085428.20367-1-ales.astone@gmail.com>
 <YlafI74E/5HttdeB@kroah.com>
From:   Alessandro Astone <ales.astone@gmail.com>
In-Reply-To: <YlafI74E/5HttdeB@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2022 12:00, Greg KH wrote:

> On Wed, Apr 13, 2022 at 10:54:27AM +0200, Alessandro Astone wrote:
>> When handling BINDER_TYPE_FDA object we are pushing a parent fixup
>> with a certain skip_size but no scatter-gather copy object, since
>> the copy is handled standalone.
>> If BINDER_TYPE_FDA is the last children the scatter-gather copy
>> loop will never stop to skip it, thus we are left with an item in
>> the parent fixup list. This will trigger the BUG_ON().
>>
>> Furthermore, it is possible to receive BINDER_TYPE_FDA object
>> with num_fds=0 which will confuse the scatter-gather code.
>>
>> In the android userspace I could only find these usecases in the
>> libstagefright OMX implementation, so it might be that they're
>> doing something very weird, but nonetheless the kernel should not
>> panic about it.
>>
>> Fixes: 09184ae9b575 ("binder: defer copies of pre-patched txn data")
>> Signed-off-by: Alessandro Astone <ales.astone@gmail.com>
>> ---
>>   drivers/android/binder.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
>> index 8351c5638880..18ad6825ba30 100644
>> --- a/drivers/android/binder.c
>> +++ b/drivers/android/binder.c
>> @@ -2295,7 +2295,7 @@ static int binder_do_deferred_txn_copies(struct binder_alloc *alloc,
>>   {
>>   	int ret = 0;
>>   	struct binder_sg_copy *sgc, *tmpsgc;
>> -	struct binder_ptr_fixup *pf =
>> +	struct binder_ptr_fixup *tmppf, *pf =
> Just make this a new line:
> 	struct binder_ptr_fixup *tmppf;
> above the existing line.
>
Ack.

>>   		list_first_entry_or_null(pf_head, struct binder_ptr_fixup,
>>   					 node);
>>   
>> @@ -2349,7 +2349,11 @@ static int binder_do_deferred_txn_copies(struct binder_alloc *alloc,
>>   		list_del(&sgc->node);
>>   		kfree(sgc);
>>   	}
>> -	BUG_ON(!list_empty(pf_head));
> So you are hitting this BUG_ON() today?
>
Correct, both on 5.17, stable 5.17.2 and current master

>> +	list_for_each_entry_safe(pf, tmppf, pf_head, node) {
>> +		BUG_ON(pf->skip_size == 0);
>> +		list_del(&pf->node);
>> +		kfree(pf);
>> +	}
>>   	BUG_ON(!list_empty(sgc_head));
>>   
>>   	return ret > 0 ? -EINVAL : ret;
>> @@ -2486,6 +2490,9 @@ static int binder_translate_fd_array(struct list_head *pf_head,
>>   	struct binder_proc *proc = thread->proc;
>>   	int ret;
>>   
>> +	if (fda->num_fds == 0)
>> +		return 0;
> Why return 0?
>
> This feels like a separate issue from above, should this be 2 different
> commits?
>
return 0 because I want it to be handled as it was handled before
	09184ae9b575 ("binder: defer copies of pre-patched txn data")

Function `binder_do_deferred_txn_copies` distinguishes between a copy-fixup
and a skip with `if (pf->skip_size)` so if the skip_size is 0, which happens
if fda->num_fds is 0, it would accidentally enter the wrong branch.
By returning 0 early i make sure a skip of size 0 is not added. It's not an
error because it was never an error before commit 09184ae9b575 and some
userspace in android is hitting this path.

I would agree it's a separate issue.
I originally merged it in this same patch because
1) Both are fixups to 09184ae9b575
2) Both are triggered by the same real-world android transaction that looks
    something like this:
      obj[0] BINDER_TYPE_PTR, parent
      obj[1] BINDER_TYPE_PTR, child
      obj[2] BINDER_TYPE_PTR, child
      obj[3] BINDER_TYPE_FDA with num_fds=0
3) In the other hunk of this patch i replace the BUG_ON with:
      BUG_ON(pf->skip_size == 0)
    to only BUG if any item remaining in the pf_head list is not a skip,
    but as observed we may receive skips of size 0.
4) With this hunk only, you would no longer reproduce the BUG_ON because the
    only transaction we receive in android with BINDER_TYPE_FDA as last child
    coincidentally always has num_fds=0. Certainly some weird behaviour...

So if I split them, patch A would depend on patch B (see point 3), but the
BUG of patch B would only be reproducible without patch A (see point 4).

But let me know if you still prefer them split.

> thanks,
>
> greg k-h
