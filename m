Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDE34D3D8C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 00:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238875AbiCIX2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 18:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238874AbiCIX1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 18:27:52 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7433D123413
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 15:26:52 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id mv5-20020a17090b198500b001bf2a039831so6657806pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 15:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IXsvt/qpy77G/P1nJG1A2sEfsJy769SZ9m7UZ80Z1gI=;
        b=Iwq90xK120fuhEtdvG/vEmpq2zGIsbVWduHunCNRli0QX2xZ5E2rooEPutmE8EnkkL
         eK63/xKJlLiKBtv9LazJKzgDgaWw6oWO8TFPVhzKcd4LdDTp2R1YUBkFV1Gmhmh0vOZp
         A7X2flXJoNmkS6xmXkgYgF2SbATjDsOKC8JtZ37MBAaAw7eHLVePHAu4ezBuo2W3yfDM
         suQVF33eZV2q3aATDpaWV8JsNK62xZyA8NsobR9AYGb+YJX7Ex8djCr60G3th/TJqGu/
         EeOllANjL8Fe5w9zxEFtwqWCdZq8FIroV0JmYoRLTp2PHj6iF8pPU0IT/cyBq2vgUmtB
         sBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IXsvt/qpy77G/P1nJG1A2sEfsJy769SZ9m7UZ80Z1gI=;
        b=X14eHUSo+/opkrFpz9sxxamIjf+2BdjvLF0RS7IHAD7fiapPXeZNHF/O+zqhNyT1DK
         QTJyPbj3CSVb/1hQ67BEQonYNZRx68qx52e780c8hPpibrhmTPjg4206NlIVlhKXk0XO
         k4rk0lD4LtMYHX6j8TUgYfVMoDT3dzlWVMaSWDBDhZsa6acDLLZ81mmDw34VmuuyPkTO
         UAGABrprAcU+oQeybgSaFtmlVGNTqhOj1k7yUTJ8iodLnAIWpDmRDkQy6dM1V2gEclFb
         iX+Nq9rtNAECwwwET/T7XnugSr5auJ1do9b/mZcbZqYbc85TpRwikpkUjULC3vjLobmS
         NSpg==
X-Gm-Message-State: AOAM533Uy1VyOb/+W3D4PNGvtme1UjxPHRcgxte71zO1OQkKLZj1ynj9
        iE98yTkC+IE0ZHWGiiTG5VGzXw==
X-Google-Smtp-Source: ABdhPJwFj6aJmVfT9QXy0jlw/r/TJ1zKm7udha4IUfJiCvLOvuMSAne94esgH8Nn4pyiGnsET9g2oQ==
X-Received: by 2002:a17:902:7610:b0:151:6152:549c with SMTP id k16-20020a170902761000b001516152549cmr1923916pll.91.1646868411633;
        Wed, 09 Mar 2022 15:26:51 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t8-20020a6549c8000000b00372eb3a7fb3sm3288258pgs.92.2022.03.09.15.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 15:26:51 -0800 (PST)
Message-ID: <02b3c239-9505-66bd-7502-22ac46b6f007@kernel.dk>
Date:   Wed, 9 Mar 2022 16:26:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 07/13] task_work: Introduce task_work_pending
Content-Language: en-US
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>
References: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
 <20220309162454.123006-7-ebiederm@xmission.com>
 <01459886-2393-665a-43b1-70082ceace0c@kernel.dk>
 <87cziubtfu.fsf@email.froward.int.ebiederm.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <87cziubtfu.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/22 4:24 PM, Eric W. Biederman wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 3/9/22 9:24 AM, Eric W. Biederman wrote:
>>> diff --git a/include/linux/task_work.h b/include/linux/task_work.h
>>> index 5b8a93f288bb..897494b597ba 100644
>>> --- a/include/linux/task_work.h
>>> +++ b/include/linux/task_work.h
>>> @@ -19,6 +19,11 @@ enum task_work_notify_mode {
>>>  	TWA_SIGNAL,
>>>  };
>>>  
>>> +static inline bool task_work_pending(struct task_struct *task)
>>> +{
>>> +	return READ_ONCE(task->task_works);
>>> +}
>>> +
>>
>> Most of the checks for this is current, do we need READ_ONCE here?
> 
> There is a non-current use in fs/io_uring in __io_uring_show_fdinfo
> and another in task_work_cancel_match.
> 
> Beyond that there are quite a few writes that are not at all from
> current so even on current task->task_works can change if you look
> twice.
> 
> So if only to keep it from making unwarranted assumptions I think
> READ_ONCE makes sense.
> 
> Given that READ_ONCE is practically free I don't see where there is
> any harm in using it to document the kind of code we expect the compiler
> to generate.
> 
> Looking a second time I see all of the other reads of task->task_works
> are already READ_ONCE in kernel/task_work.c, so really I think if we
> don't want READ_ONCE we need a big fat comment about why it is safe
> in a check like task_work_pending and while it is needed everywhere
> else.  At the moment I am not smart enough to write that comment.
> 
> I will see about adding this bit of discussion in the commit comment to
> make it a little clearer why I am introducing READ_ONCE.

Fair enough, and doesn't warrant a current_tw_pending() helper in that
case either.

-- 
Jens Axboe

