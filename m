Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921E05A169B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243060AbiHYQXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240457AbiHYQXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:23:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DABAB9435
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661444591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3TCOrkI190jca//AzB8XwVdwI6ckbP/rfXc0pHorkGc=;
        b=TopnEwXsNKZWAyvuz77FFHCOqzB6fYfZw3b+RZSSyJHzDPsO3qZg6bKyD7PYurf8aAHcS3
        fm7EpWRlVZqXWSUToHRV+bHLlYuzcMfqe923hTxC6WEaRRxA5oszA7wztY9o1ekZ/PsnQu
        yD+EYPcQTPd/qgEsjbyndXdJWvv6wQY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-ebGUr0-4OmeY1y9uoGJCCw-1; Thu, 25 Aug 2022 12:23:09 -0400
X-MC-Unique: ebGUr0-4OmeY1y9uoGJCCw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F17993801F5E;
        Thu, 25 Aug 2022 16:23:08 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.22.48.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2ACAE1410DD9;
        Thu, 25 Aug 2022 16:23:07 +0000 (UTC)
Date:   Thu, 25 Aug 2022 12:23:05 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, scorreia@redhat.com,
        omosnace@redhat.com, omoris@redhat.com,
        Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH ghak138] audit: move audit_return_fixup before the filters
Message-ID: <Yweh6QxD6XDbHyt9@madcap2.tricolour.ca>
References: <7cff118972930ccb650bd62fbf0d2e8e452d729a.1661395017.git.rgb@redhat.com>
 <CAHC9VhTzJT4qBtthQ=ynUHEJY=UJNRFr4wD9G56UaLS_6n+pNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTzJT4qBtthQ=ynUHEJY=UJNRFr4wD9G56UaLS_6n+pNg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-25 09:20, Paul Moore wrote:
> On Wed, Aug 24, 2022 at 11:10 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> >
> > The success and return_code are needed by the filters.  Move
> > audit_return_fixup() before the filters.
> >
> > The pid member of struct audit_context is never used.  Remove it.
> >
> > The audit_reset_context() comment about unconditionally resetting
> > "ctx->state" should read "ctx->context".
> >
> > The proctitle is intentionally stored between syscalls.  Only free it in
> > audit_free_context().
> >
> > Be explicit in checking the struct audit_context "context" member  enum
> > value rather than assuming the order of context enum values.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 12c5e81d3fd0 ("audit: prepare audit_context for use in calling contexts beyond syscalls")
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  kernel/audit.h   |  2 +-
> >  kernel/auditsc.c | 12 ++++++------
> >  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> [NOTE: dropped the stable kernel alias from my reply]

NOTE: git send-patch must have added that since I only put it in the body.

> A couple of things:
> 
> * I know you like to CC a lot of people on your patches Richard, but
> just a heads-up that you are likely to get a nastygram back from Greg
> about CC'ing the stable kernel alias directly.  It's probably worth
> re-reading the Documentation/process/stable-kernel-rules.rst docs if
> you haven't done so in a while, it's a quick read and I do it myself
> every few months.

See above...  I'll let you add the stable CC...  maybe I should put this
in a patch comment *after* the --- separator after the patch description.

> * I generally ask that people *not* directly add the 'Cc: stable@...`
> tag to patches they send to the list, I prefer to add/remove those as
> needed.  It's not a hard rule, just something I prefer (and don't
> respin patches *only* to remove the tag, but keep this in mind for
> future submissions/respins).  If there is ever any concern about the
> stable tag I bring that up for discussion on-list, although that has
> only ever happened once (twice?) that I can recall; it's usually
> pretty obvious.

This audit_return_fixup() was pretty obvious, but there is other stuff
in there that isn't so urgent.

> * Despite what I said about the stable tagging, please continue to add
> the 'Fixes: ...' tags for serious bugs, those are good and welcome.
> 
> * The audit_return_fixup() is definitely -rc/stable material, which
> means it should be split into its own patch.
> 
> * The proctitle free change *might* be stable worthy, but I'd like to
> hear some more justification of this from you either in a reply on
> this thread or in a commit description.  Regardless, just like the
> return fix, this should be in a separate patch.
> 
> * The enum comparison should be its own patch, with an appropriate
> 'Fixes:' tag in case the -stable folks want to merge it, but as we
> haven't seen any problems with it (and they aren't likely) I wouldn't
> tag this for -stable.
> 
> * I would suggest the audit_context::pid removal and the comment fix
> be separate patches as well.  I would also suggest omitting a 'Fixes:'
> tag here as these are far from critical, and things with a fixes tag
> tend to get pulled into -stable kernels which I believe would be a
> mistake here.

I'll separate these into four patches...

> > diff --git a/kernel/audit.h b/kernel/audit.h
> > index 58b66543b4d5..d6eb7b59c791 100644
> > --- a/kernel/audit.h
> > +++ b/kernel/audit.h
> > @@ -133,7 +133,7 @@ struct audit_context {
> >         struct sockaddr_storage *sockaddr;
> >         size_t sockaddr_len;
> >                                 /* Save things to print about task_struct */
> > -       pid_t               pid, ppid;
> > +       pid_t               ppid;
> >         kuid_t              uid, euid, suid, fsuid;
> >         kgid_t              gid, egid, sgid, fsgid;
> >         unsigned long       personality;
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 9226746dcf0a..9f8c05228d6d 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -965,7 +965,7 @@ static void audit_reset_context(struct audit_context *ctx)
> >         if (!ctx)
> >                 return;
> >
> > -       /* if ctx is non-null, reset the "ctx->state" regardless */
> > +       /* if ctx is non-null, reset the "ctx->context" regardless */
> >         ctx->context = AUDIT_CTX_UNUSED;
> >         if (ctx->dummy)
> >                 return;
> > @@ -1002,7 +1002,7 @@ static void audit_reset_context(struct audit_context *ctx)
> >         kfree(ctx->sockaddr);
> >         ctx->sockaddr = NULL;
> >         ctx->sockaddr_len = 0;
> > -       ctx->pid = ctx->ppid = 0;
> > +       ctx->ppid = 0;
> >         ctx->uid = ctx->euid = ctx->suid = ctx->fsuid = KUIDT_INIT(0);
> >         ctx->gid = ctx->egid = ctx->sgid = ctx->fsgid = KGIDT_INIT(0);
> >         ctx->personality = 0;
> > @@ -1016,7 +1016,6 @@ static void audit_reset_context(struct audit_context *ctx)
> >         WARN_ON(!list_empty(&ctx->killed_trees));
> >         audit_free_module(ctx);
> >         ctx->fds[0] = -1;
> > -       audit_proctitle_free(ctx);
> >         ctx->type = 0; /* reset last for audit_free_*() */
> >  }
> >
> > @@ -1077,6 +1076,7 @@ static inline void audit_free_context(struct audit_context *context)
> >  {
> >         /* resetting is extra work, but it is likely just noise */
> >         audit_reset_context(context);
> > +       audit_proctitle_free(context);
> >         free_tree_refs(context);
> >         kfree(context->filterkey);
> >         kfree(context);
> > @@ -1940,6 +1940,7 @@ void __audit_uring_exit(int success, long code)
> >                 goto out;
> >         }
> >
> > +       audit_return_fixup(ctx, success, code);
> >         if (ctx->context == AUDIT_CTX_SYSCALL) {
> >                 /*
> >                  * NOTE: See the note in __audit_uring_entry() about the case
> > @@ -1981,7 +1982,6 @@ void __audit_uring_exit(int success, long code)
> >         audit_filter_inodes(current, ctx);
> >         if (ctx->current_state != AUDIT_STATE_RECORD)
> >                 goto out;
> > -       audit_return_fixup(ctx, success, code);
> >         audit_log_exit();
> >
> >  out:
> > @@ -2065,13 +2065,13 @@ void __audit_syscall_exit(int success, long return_code)
> >         if (!list_empty(&context->killed_trees))
> >                 audit_kill_trees(context);
> >
> > +       audit_return_fixup(context, success, return_code);
> >         /* run through both filters to ensure we set the filterkey properly */
> >         audit_filter_syscall(current, context);
> >         audit_filter_inodes(current, context);
> > -       if (context->current_state < AUDIT_STATE_RECORD)
> > +       if (context->current_state != AUDIT_STATE_RECORD)
> >                 goto out;
> >
> > -       audit_return_fixup(context, success, return_code);
> >         audit_log_exit();
> >
> >  out:
> > --
> > 2.27.0
> 
> -- 
> paul-moore.com
> 

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

