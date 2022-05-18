Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C751A52AFE9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 03:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbiERBaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 21:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiERB36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 21:29:58 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EE354690
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 18:29:57 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-f1d5464c48so873427fac.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 18:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uMFc8C/CfVChmB1k26kuQbqCm1tMkQ9Uj/R/VPJ8nN4=;
        b=K9IM4iqhrgC99GwHjRJavKT4ovzTwZsP4J81tTZ5GLRGhVcKqkKMimqYmOakkBmwu/
         vf4681g3GRq3Xc2cfKiHiZt8ac27ctn7HZkgvLZtJtd19qJgE1REzPAeCaglz2Xsjm+Z
         hpMSUgV30i6zW6HEspZ7jjooAlYGKfmPs04nRKRSdGPTkS/2Awa2hINB5530zcO8XLy3
         TcmmtYkyOyFxSdpMCkodIXLG5zYsMC1GQqwtKogb7Xi6F138TeSGHbvI07V/fy4W5w7u
         Y4sJY1mnfaOUa9cf+kv1/qNYe6r8PPM8C+7SXI8haCw+PNtdyhyOWviTEfduyTxkU6IS
         9LhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uMFc8C/CfVChmB1k26kuQbqCm1tMkQ9Uj/R/VPJ8nN4=;
        b=3HIlWworqJVkWftznX+BSqu1wrfreADX24lXZpUZame+YIeaUvTTpTAW2Dm+wHqlwa
         ncRdSL4LU1WNj353uuo4iPPYtnEX4hMwYfoCwF6DzDDh7eH3NAOMC5vXijb2H4fHa4qT
         6UdjrnAaZngA8VDeN+/jIvPBRJBrCgjibGibdfHs7/dAZs5NnFTnWXzhiFCFJbpNjA40
         2cphqMEszsogmGPXC5wS/eDFnsFbN6yNUgVQmHdgP3UbLwREaM4CS8uAOg+RTHfyt6Ku
         ZVkzBJq8i0w4c8zIJ18gx1FH7HfgEtDPfzwcEAfvUlWjko2uOOTX4mDWq0YQF6BP5GGh
         MBww==
X-Gm-Message-State: AOAM531Y9cs9hP7gkRTSBtKBexsi1mFNvIUQFVYISXA7XagCnnOZzpYs
        Qm4tiJWGI1bPbBZ6FC9cwuW3Dc6DVeSi6swbW4R8i9dH54I3EA==
X-Google-Smtp-Source: ABdhPJzNj+puwrlY5bUzMRluwrnkTBWJQoBc0wq0pyeFNojVxIMVZFlYdEDqASc4NByzegTuU+oM31viHdBBm9GT1+E=
X-Received: by 2002:a05:6870:8a0b:b0:f1:8e74:261f with SMTP id
 p11-20020a0568708a0b00b000f18e74261fmr9260911oaq.276.1652837396518; Tue, 17
 May 2022 18:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220517175225.65283-1-schspa@gmail.com> <YoP1LSSzgg9sHJDW@google.com>
In-Reply-To: <YoP1LSSzgg9sHJDW@google.com>
From:   Schspa Shi <schspa@gmail.com>
Date:   Wed, 18 May 2022 09:29:45 +0800
Message-ID: <CAMA88TqDQH4c-wohARJbXN-jUHZYtFaFpbJ3dLzxG_HxvGuj5A@mail.gmail.com>
Subject: Re: [PATCH] binder: fix atomic sleep when get extended error
To:     Carlos Llamas <cmllamas@google.com>
Cc:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
        hridya@google.com, surenb@google.com, linux-kernel@vger.kernel.org,
        syzbot+46fff6434a7f968ecb39@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Llamas <cmllamas@google.com> writes:

> On Wed, May 18, 2022 at 01:52:25AM +0800, Schspa Shi wrote:
>> binder_inner_proc_lock(thread->proc) is a spin lock, copy_to_user can't
>> be called with in this lock.
>>
>> Copy it as a local variable, and check the id to make sure the user space
>> gets the latest error message
>>
>> Reported-by: syzbot+46fff6434a7f968ecb39@syzkaller.appspotmail.com
>> Fixes: bd32889e841c ("binder: add BINDER_GET_EXTENDED_ERROR ioctl")
>> Signed-off-by: Schspa Shi <schspa@gmail.com>
>> ---
>>  drivers/android/binder.c | 13 ++++++++++---
>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
>> index d9253b2a7bd9..5f2e1fa3da74 100644
>> --- a/drivers/android/binder.c
>> +++ b/drivers/android/binder.c
>> @@ -5163,13 +5163,20 @@ static int binder_ioctl_get_extended_error(struct binder_thread *thread,
>>                                         void __user *ubuf)
>>  {
>>      struct binder_extended_error *ee = &thread->ee;
>> +    struct binder_extended_error eeb;
>>
>>      binder_inner_proc_lock(thread->proc);
>> -    if (copy_to_user(ubuf, ee, sizeof(*ee))) {
>> -            binder_inner_proc_unlock(thread->proc);
>> +retry:
>> +    eeb = *ee;
>> +    binder_inner_proc_unlock(thread->proc);
>> +    if (copy_to_user(ubuf, &eeb, sizeof(eeb)))
>>              return -EFAULT;
>> -    }
>>
>> +    binder_inner_proc_lock(thread->proc);
>> +    if (eeb.id != ee->id) {
>> +            /* retry to get newest error info */
>> +            goto retry;
>> +    }
>>      ee->id = 0;
>>      ee->command = BR_OK;
>>      ee->param = 0;
>> --
>> 2.24.3 (Apple Git-128)
>>
>
> Oops! Thank you for your patch. In this case the local copy would be
> enough, no need for the retry logic as this is already taken care of.
> You could also leverage the binder_set_extended_error() to reset the
> thread->ee. Would you mind sending these updates? I was thinking
> something like this:

Yes, I have sent a v2 patch for this, please review it.


>
>  drivers/android/binder.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 83facfa1a5c3..f92021cd384b 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -5163,19 +5163,16 @@ static int binder_ioctl_get_freezer_info(
>  static int binder_ioctl_get_extended_error(struct binder_thread *thread,
>                                          void __user *ubuf)
>  {
> -     struct binder_extended_error *ee = &thread->ee;
> +     struct binder_extended_error ee;
>
>       binder_inner_proc_lock(thread->proc);
> -     if (copy_to_user(ubuf, ee, sizeof(*ee))) {
> -             binder_inner_proc_unlock(thread->proc);
> -             return -EFAULT;
> -     }
> -
> -     ee->id = 0;
> -     ee->command = BR_OK;
> -     ee->param = 0;
> +     ee = thread->ee;
> +     binder_set_extended_error(&thread->ee, 0, BR_OK, 0);
>       binder_inner_proc_unlock(thread->proc);
>
> +     if (copy_to_user(ubuf, &ee, sizeof(ee)))
> +             return -EFAULT;
> +
>       return 0;
>  }

--
BRs
Schspa Shi
