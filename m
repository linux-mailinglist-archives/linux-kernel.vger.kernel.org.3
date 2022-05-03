Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E9C518956
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 18:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239165AbiECQLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 12:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239024AbiECQLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 12:11:31 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9452B24C
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 09:07:57 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j15so24070136wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 09:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h9qkGkLhyYVuP5NA+EyqoC9Fx6dLw0IZC0J4czMcE3s=;
        b=Q3kJ8dp+glqL6hrMCvTstBZwmmJPz/CaYGwV/d2xk6xJBAeFfuS9shb832MfGT6Fuq
         vl08vQTfs4UHQQYYc2UqZf11rgvLU2YvesaMJS5RhCFvNtiW/pwTuiUcPd8Peko6upbq
         bHB3lt95E7lnHd4R9BBM5jhWGwQ/hlmhJJyqo5l7uNoZQ+IFVLKmDYf5sL+TXof0K0zA
         JQG/IG5XHWr2bomNbJy5JvGUXC9dBXVhCJnoETdpR6S/zBanM7P/cWxwq81aSLeonEYq
         /e3VP5qHvXG7fDN198EXXI2Gl3Pfu9oKifURmXEGQHlInf/4en50cV/cARyn9fdyaYs0
         0PKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h9qkGkLhyYVuP5NA+EyqoC9Fx6dLw0IZC0J4czMcE3s=;
        b=ZtIMUPOf92Jp1p4nDIK7wtKiukDnMf5h3VJbykCJudYqD/X2q6T1pxP20i7l0zlU1b
         ln/547G2g17b+WysWXPt9Ckci7OTaHvoMMFlSKhGtg8Hy5b7GQRfaK7DkVeVJd1bezja
         eeQP1uupinld8my+ZH0cCYPmND8dTktA3dEF106aXQpsfjxYHIQftTyHIAu+fKM5Q7SX
         u3oBbDD0xmrA5uwKpog40y2R4TIkZ3KIt/KJkYPzDdjWLveKzvVn2RNhWsy3uYFCblWq
         Os1eFmolOATAqK0SFRVT1F5gMeC2wIJzGSDoctjTYJ/Bj0GW6wr2DgC530ifzrrMvcRq
         kKXA==
X-Gm-Message-State: AOAM533m6c0b6cF0Sx3YBtmeCs0a0hDZCDmGs/ISFYZGYVN04syWWdXr
        xG2LMU8XB4FrToHBmYRcW0DY2qFJDEErrbOV2uCD
X-Google-Smtp-Source: ABdhPJybVow9Pu2mDV8hRgGZZILEuK6b9eT5oZLMJZzrGb8IbCTHvuar2Z5/Ftf+TBLoXXGDuX6+xSauHFiv5ehLslM=
X-Received: by 2002:a05:6000:80e:b0:20c:5b45:a700 with SMTP id
 bt14-20020a056000080e00b0020c5b45a700mr9669529wrb.662.1651594076393; Tue, 03
 May 2022 09:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220503090212.1322050-1-svens@linux.ibm.com>
In-Reply-To: <20220503090212.1322050-1-svens@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 3 May 2022 12:07:45 -0400
Message-ID: <CAHC9VhQ=Lvvy=tOorGQA0FZwggCPkpEk0dFxWQZPkTLn0K2c4g@mail.gmail.com>
Subject: Re: [PATCH 1/2] audit: add call argument to socketcall auditing
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 3, 2022 at 5:02 AM Sven Schnelle <svens@linux.ibm.com> wrote:
>
> socketcall auditing misses the call argument:
>
> type=SOCKETCALL msg=audit: nargs=3 a0=10 a1=3 a2=c
>
> which renders socketcall auditing (almost) useless. Add the call
> argument so it is possible to decode the actual syscall from the
> audit log:
>
> type=SOCKETCALL msg=audit: call=1 nargs=3 a0=10 a1=3 a2=c
>
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  include/linux/audit.h | 10 +++++-----
>  kernel/audit.h        |  1 +
>  kernel/auditsc.c      |  6 ++++--
>  net/compat.c          |  2 +-
>  net/socket.c          |  2 +-
>  5 files changed, 12 insertions(+), 9 deletions(-)

Hi Sven,

Thanks for catching this, my only guess is that the original code
assumed that a0 held the socket call number.  In addition to the
kernel test robot errors that need fixing, I've made some comments
inline with the patch below ...

> diff --git a/kernel/audit.h b/kernel/audit.h
> index 58b66543b4d5..34e53b6f0ebb 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -153,6 +153,7 @@ struct audit_context {
>         int type;
>         union {
>                 struct {
> +                       int call;
>                         int nargs;
>                         long args[6];

Not your code, but while you are making changes, perhaps make @args[6]
and unsigned long to match the network stack's code.

>                 } socketcall;
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index ea2ee1181921..c856893041c9 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1399,8 +1399,9 @@ static void show_special(struct audit_context *context, int *call_panic)
>         switch (context->type) {
>         case AUDIT_SOCKETCALL: {
>                 int nargs = context->socketcall.nargs;
> +               int call = context->socketcall.call;
>
> -               audit_log_format(ab, "nargs=%d", nargs);
> +               audit_log_format(ab, "call=%d nargs=%d", call, nargs);
>                 for (i = 0; i < nargs; i++)
>                         audit_log_format(ab, " a%d=%lx", i,
>                                 context->socketcall.args[i]);

The approach we take when adding new fields to existing audit records
is to add them to the end of the record.  Using your example in the
patch description, we would want to see the following record format
for SOCKETCALL:

  type=SOCKETCALL msg=audit: nargs=3 a0=10 a1=3 a2=c call=1

> @@ -2684,13 +2685,14 @@ void __audit_bprm(struct linux_binprm *bprm)
>   * @args: args array
>   *
>   */
> -int __audit_socketcall(int nargs, unsigned long *args)
> +int __audit_socketcall(int call, int nargs, unsigned long *args)
>  {
>         struct audit_context *context = audit_context();
>
>         if (nargs <= 0 || nargs > AUDITSC_ARGS || !args)
>                 return -EINVAL;
>         context->type = AUDIT_SOCKETCALL;
> +       context->socketcall.call = call;
>         context->socketcall.nargs = nargs;
>         memcpy(context->socketcall.args, args, nargs * sizeof(unsigned long));
>         return 0;
> diff --git a/net/compat.c b/net/compat.c
> index 210fc3b4d0d8..0df955019ecc 100644
> --- a/net/compat.c
> +++ b/net/compat.c
> @@ -437,7 +437,7 @@ COMPAT_SYSCALL_DEFINE2(socketcall, int, call, u32 __user *, args)
>         if (copy_from_user(a, args, len))
>                 return -EFAULT;
>
> -       ret = audit_socketcall_compat(len / sizeof(a[0]), a);
> +       ret = audit_socketcall_compat(call, len / sizeof(a[0]), a);

See my note below for the non-compat version of socketcall(2).

> diff --git a/net/socket.c b/net/socket.c
> index 6887840682bb..ff71f28c96f7 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -2921,7 +2921,7 @@ SYSCALL_DEFINE2(socketcall, int, call, unsigned long __user *, args)
>         if (copy_from_user(a, args, len))
>                 return -EFAULT;
>
> -       err = audit_socketcall(nargs[call] / sizeof(unsigned long), a);
> +       err = audit_socketcall(call, nargs[call] / sizeof(unsigned long), a);

I recognize that this isn't your code, but I think it might be better
to cleanup the arg count calculation passed as the second parameter.
Something like this not only looks cleaner, but it should be a bit
more robust against other kernel changes:

  err = audit_socketcall(call, len / AL(1), a);

... it may also help resolve some of the kernel test robot errors you
are seeing.

-- 
paul-moore.com
