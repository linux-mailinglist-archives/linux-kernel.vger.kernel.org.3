Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8035A11DD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242510AbiHYNVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241005AbiHYNVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:21:07 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895F2861EC
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:21:05 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id g5-20020a4ac4c5000000b0044af7c8c4b3so3325634ooq.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=RYfcE0fHbsYfCm925mmzXTeOyIgSjTH+lzz/HesrSwE=;
        b=pXlh8cnISVMRKbifEbB9amx8hAOt4i1RjAnztyXNY5c8RijPqY+YmKt/4uUTlvrTvi
         mU4m2p2ILH8JGMmRKvPHr60RMKah9/zpF4DQ5kic8Xr2tmAInrPYCwXMZ8twWPISJGFI
         HgmvI/PfzRHA2gVBKRWQvcgx//9CmbuozN9qzbRrwmp2D7MLjGL94dYoQdELivYY3sdy
         D8W1Dh6EQeucw1mWCkuXjgih1U4ByXzFmmKmgvzzPShmLBAZE9WKaUjGmokZZyClRkBP
         X+UUS0LHF1MOEM03BqTIIP4WoQ1ZSVlIyTAc6e1Ix3ByquHIJSP3eSxmAItTTt6ILsrf
         dnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=RYfcE0fHbsYfCm925mmzXTeOyIgSjTH+lzz/HesrSwE=;
        b=t5VMqp6hr24VHpAQ+m3q3Eb9b8wmAb7u/X39ewjewsk9tDGpsozFXAnJE4sA3756XO
         P9rAMWU6IW1/7x7JNaaMR3HYqZUQCWL8uOahrq1VZST/BNELT9Z9tsCX3W8+esXGYj9W
         4ufocCgMinVV4KMZ1nKnVE5mv6Z/jOoUdGFgrXgwUlQjgXHAV8oRdrgTTxbFzOB+shO/
         9XBjaKn07azR178O/NE/LyCujMAfMjPfuIP1IpigCPcg2rFMN7DVzYomp5LPQBX2cNLY
         LtFunl1uUJhdrlsVcQln+H6wEr4i+YgC23QHm24iJA/HA8MlIC+MsPqabbYBAcmuNORQ
         Nleg==
X-Gm-Message-State: ACgBeo28B9UPQU6qjgUy7UXvnkOY2hJaiyY//56Z2BeWuLhCYQDxnbBW
        mjZcMlLzrjYA62LpcKqreN4686xFwXFcAOvVpDOt
X-Google-Smtp-Source: AA6agR7wMiMhHe1IemPPRVMhRwOnfZzrbmmR2q5jE/SChnxUxqGq5obVgbFDptTfHH0b7S5ABAynadwsc3q9jfG1x7s=
X-Received: by 2002:a05:6820:508:b0:44a:abd8:6d59 with SMTP id
 m8-20020a056820050800b0044aabd86d59mr1270145ooj.11.1661433664375; Thu, 25 Aug
 2022 06:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <7cff118972930ccb650bd62fbf0d2e8e452d729a.1661395017.git.rgb@redhat.com>
In-Reply-To: <7cff118972930ccb650bd62fbf0d2e8e452d729a.1661395017.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 25 Aug 2022 09:20:53 -0400
Message-ID: <CAHC9VhTzJT4qBtthQ=ynUHEJY=UJNRFr4wD9G56UaLS_6n+pNg@mail.gmail.com>
Subject: Re: [PATCH ghak138] audit: move audit_return_fixup before the filters
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, scorreia@redhat.com,
        omosnace@redhat.com, omoris@redhat.com,
        Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 11:10 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> The success and return_code are needed by the filters.  Move
> audit_return_fixup() before the filters.
>
> The pid member of struct audit_context is never used.  Remove it.
>
> The audit_reset_context() comment about unconditionally resetting
> "ctx->state" should read "ctx->context".
>
> The proctitle is intentionally stored between syscalls.  Only free it in
> audit_free_context().
>
> Be explicit in checking the struct audit_context "context" member  enum
> value rather than assuming the order of context enum values.
>
> Cc: stable@vger.kernel.org
> Fixes: 12c5e81d3fd0 ("audit: prepare audit_context for use in calling contexts beyond syscalls")
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/audit.h   |  2 +-
>  kernel/auditsc.c | 12 ++++++------
>  2 files changed, 7 insertions(+), 7 deletions(-)

[NOTE: dropped the stable kernel alias from my reply]

A couple of things:

* I know you like to CC a lot of people on your patches Richard, but
just a heads-up that you are likely to get a nastygram back from Greg
about CC'ing the stable kernel alias directly.  It's probably worth
re-reading the Documentation/process/stable-kernel-rules.rst docs if
you haven't done so in a while, it's a quick read and I do it myself
every few months.

* I generally ask that people *not* directly add the 'Cc: stable@...`
tag to patches they send to the list, I prefer to add/remove those as
needed.  It's not a hard rule, just something I prefer (and don't
respin patches *only* to remove the tag, but keep this in mind for
future submissions/respins).  If there is ever any concern about the
stable tag I bring that up for discussion on-list, although that has
only ever happened once (twice?) that I can recall; it's usually
pretty obvious.

* Despite what I said about the stable tagging, please continue to add
the 'Fixes: ...' tags for serious bugs, those are good and welcome.

* The audit_return_fixup() is definitely -rc/stable material, which
means it should be split into its own patch.

* The proctitle free change *might* be stable worthy, but I'd like to
hear some more justification of this from you either in a reply on
this thread or in a commit description.  Regardless, just like the
return fix, this should be in a separate patch.

* The enum comparison should be its own patch, with an appropriate
'Fixes:' tag in case the -stable folks want to merge it, but as we
haven't seen any problems with it (and they aren't likely) I wouldn't
tag this for -stable.

* I would suggest the audit_context::pid removal and the comment fix
be separate patches as well.  I would also suggest omitting a 'Fixes:'
tag here as these are far from critical, and things with a fixes tag
tend to get pulled into -stable kernels which I believe would be a
mistake here.

> diff --git a/kernel/audit.h b/kernel/audit.h
> index 58b66543b4d5..d6eb7b59c791 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -133,7 +133,7 @@ struct audit_context {
>         struct sockaddr_storage *sockaddr;
>         size_t sockaddr_len;
>                                 /* Save things to print about task_struct */
> -       pid_t               pid, ppid;
> +       pid_t               ppid;
>         kuid_t              uid, euid, suid, fsuid;
>         kgid_t              gid, egid, sgid, fsgid;
>         unsigned long       personality;
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 9226746dcf0a..9f8c05228d6d 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -965,7 +965,7 @@ static void audit_reset_context(struct audit_context *ctx)
>         if (!ctx)
>                 return;
>
> -       /* if ctx is non-null, reset the "ctx->state" regardless */
> +       /* if ctx is non-null, reset the "ctx->context" regardless */
>         ctx->context = AUDIT_CTX_UNUSED;
>         if (ctx->dummy)
>                 return;
> @@ -1002,7 +1002,7 @@ static void audit_reset_context(struct audit_context *ctx)
>         kfree(ctx->sockaddr);
>         ctx->sockaddr = NULL;
>         ctx->sockaddr_len = 0;
> -       ctx->pid = ctx->ppid = 0;
> +       ctx->ppid = 0;
>         ctx->uid = ctx->euid = ctx->suid = ctx->fsuid = KUIDT_INIT(0);
>         ctx->gid = ctx->egid = ctx->sgid = ctx->fsgid = KGIDT_INIT(0);
>         ctx->personality = 0;
> @@ -1016,7 +1016,6 @@ static void audit_reset_context(struct audit_context *ctx)
>         WARN_ON(!list_empty(&ctx->killed_trees));
>         audit_free_module(ctx);
>         ctx->fds[0] = -1;
> -       audit_proctitle_free(ctx);
>         ctx->type = 0; /* reset last for audit_free_*() */
>  }
>
> @@ -1077,6 +1076,7 @@ static inline void audit_free_context(struct audit_context *context)
>  {
>         /* resetting is extra work, but it is likely just noise */
>         audit_reset_context(context);
> +       audit_proctitle_free(context);
>         free_tree_refs(context);
>         kfree(context->filterkey);
>         kfree(context);
> @@ -1940,6 +1940,7 @@ void __audit_uring_exit(int success, long code)
>                 goto out;
>         }
>
> +       audit_return_fixup(ctx, success, code);
>         if (ctx->context == AUDIT_CTX_SYSCALL) {
>                 /*
>                  * NOTE: See the note in __audit_uring_entry() about the case
> @@ -1981,7 +1982,6 @@ void __audit_uring_exit(int success, long code)
>         audit_filter_inodes(current, ctx);
>         if (ctx->current_state != AUDIT_STATE_RECORD)
>                 goto out;
> -       audit_return_fixup(ctx, success, code);
>         audit_log_exit();
>
>  out:
> @@ -2065,13 +2065,13 @@ void __audit_syscall_exit(int success, long return_code)
>         if (!list_empty(&context->killed_trees))
>                 audit_kill_trees(context);
>
> +       audit_return_fixup(context, success, return_code);
>         /* run through both filters to ensure we set the filterkey properly */
>         audit_filter_syscall(current, context);
>         audit_filter_inodes(current, context);
> -       if (context->current_state < AUDIT_STATE_RECORD)
> +       if (context->current_state != AUDIT_STATE_RECORD)
>                 goto out;
>
> -       audit_return_fixup(context, success, return_code);
>         audit_log_exit();
>
>  out:
> --
> 2.27.0

-- 
paul-moore.com
