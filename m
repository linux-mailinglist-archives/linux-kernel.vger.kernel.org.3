Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4EF5107C1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245538AbiDZTAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 15:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238868AbiDZTAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 15:00:32 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF841815EE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:57:23 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e24so6862941wrc.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YN5oTnEIU4pNM1Sb3nJpdAjaA/oJ2IQFujs0Jps+a9Y=;
        b=wLkjVxHZBMNNlQ2eMzOmdi1zhi+QqAFf+qfqGanndpXHHK75T5Cx2XtBpV7WJONo0S
         57Cpy0vv21O9fGFIcYxOaBYK8k8eV9IFefO3gIygGNNkgS49Gfao934wDIvokwr9hdAt
         KW2KmfNAhdgDVR0tQFIvPnO15AKL+CACbKUkYK+7lChrZwwOX6jUJ3QGhXfVKjcqA7pQ
         reufn4qSO3+brh0bYiIUAPCuM2Vj05+ca4vWXdmUkNb40B4+uJ6tTP7GXurmfLeAOrBm
         84Jn+HdJBdzMjFxMRaVqchrseSdroyGzVAIMuLwWWbHR4HC5ZkzJxdEW5h+KdjkupYQH
         tZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YN5oTnEIU4pNM1Sb3nJpdAjaA/oJ2IQFujs0Jps+a9Y=;
        b=31hYURHaGd7tyZdxtFKbRfzYy98wwEr++Dm4v3vUFyZD/pbVANka7a7nFAaPIntKEH
         Zp71XjAThyr8XHB5v+Q+zHQJXM/XXDT1J77bpibqNYVzSFnXrvXVrUxyzDWsCaNwL9Hj
         SwDYTlJMR+PRvmVgb3+Flh9c6anU/6h2THLF2Jz7WF6y8PM+BhT+c++TA6OjrSsnsub1
         ZqTCe5w/JdyrsaHc0vR59LCbYBQv7T2AvRkUZlfn+2fH4NU6Vkl3I7YU/jerH33Rj2tZ
         4TY0t814pGQIrA6A0xyxzUPm1GA+8SfIQFzfI1EM8q6aiQxYWaXlDoh23MedZ+QldWYU
         4icg==
X-Gm-Message-State: AOAM531C86Sx/QwfUh9LtGLZ+Xfclz1+Zucv2nRYuh1XnlBMmYFxq9+d
        J+Bxpvlr6Z8bglCJQ9mIAxS5bUR71zloUYWvDS6H
X-Google-Smtp-Source: ABdhPJzCoqSO0HOFjAxjiYwi8hx2T3JoRbTDOzldL2FbJ+czUtRSK699iRUtzHvdC/Nq1+fZFD2YroJ1E21D9zBEv9U=
X-Received: by 2002:a5d:590d:0:b0:20a:c3eb:2584 with SMTP id
 v13-20020a5d590d000000b0020ac3eb2584mr18774084wrd.18.1650999442153; Tue, 26
 Apr 2022 11:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220418145945.38797-1-casey@schaufler-ca.com>
 <20220418145945.38797-28-casey@schaufler-ca.com> <f2186f22-5bcd-d962-7e49-c816fc5fbd07@canonical.com>
In-Reply-To: <f2186f22-5bcd-d962-7e49-c816fc5fbd07@canonical.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 26 Apr 2022 14:57:11 -0400
Message-ID: <CAHC9VhTXgBTH+7ny-fcMP_HC1ojA1ass38PGHS2tJny0bCGXzA@mail.gmail.com>
Subject: Re: [PATCH v35 27/29] Audit: Add record for multiple object contexts
To:     John Johansen <john.johansen@canonical.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 11:38 PM John Johansen
<john.johansen@canonical.com> wrote:
> On 4/18/22 07:59, Casey Schaufler wrote:
> > Create a new audit record AUDIT_MAC_OBJ_CONTEXTS.
> > An example of the MAC_OBJ_CONTEXTS (1421) record is:
> >
> >     type=MAC_OBJ_CONTEXTS[1421]
> >     msg=audit(1601152467.009:1050):
> >     obj_selinux=unconfined_u:object_r:user_home_t:s0
> >
> > When an audit event includes a AUDIT_MAC_OBJ_CONTEXTS record
> > the "obj=" field in other records in the event will be "obj=?".
> > An AUDIT_MAC_OBJ_CONTEXTS record is supplied when the system has
> > multiple security modules that may make access decisions based
> > on an object security context.
> >
> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > ---
> >  include/linux/audit.h      |  5 +++
> >  include/uapi/linux/audit.h |  1 +
> >  kernel/audit.c             | 47 +++++++++++++++++++++++
> >  kernel/auditsc.c           | 79 ++++++++++++--------------------------
> >  4 files changed, 77 insertions(+), 55 deletions(-)

...

> > diff --git a/kernel/audit.c b/kernel/audit.c
> > index 8ed2d717c217..a8c3ec6ba60b 100644
> > --- a/kernel/audit.c
> > +++ b/kernel/audit.c
> > @@ -2226,6 +2226,53 @@ static void audit_buffer_aux_end(struct audit_buffer *ab)
> >       ab->skb = skb_peek(&ab->skb_list);
> >  }
> >
> > +void audit_log_object_context(struct audit_buffer *ab, struct lsmblob *blob)
> > +{
> > +     int i;
> > +     int error;
> > +     struct lsmcontext context;
> > +
> > +     if (!lsm_multiple_contexts()) {
> > +             error = security_secid_to_secctx(blob, &context, LSMBLOB_FIRST);
> > +             if (error) {
> > +                     if (error != -EINVAL)
> > +                             goto error_path;
> > +                     return;
> > +             }
> > +             audit_log_format(ab, " obj=%s", context.context);
> > +             security_release_secctx(&context);
> > +     } else {
> > +             audit_log_format(ab, " obj=?");
> > +             error = audit_buffer_aux_new(ab, AUDIT_MAC_OBJ_CONTEXTS);
> > +             if (error)
> > +                     goto error_path;
> > +
> > +             for (i = 0; i < LSMBLOB_ENTRIES; i++) {
> > +                     if (blob->secid[i] == 0)
> > +                             continue;
> > +                     error = security_secid_to_secctx(blob, &context, i);
> > +                     if (error) {
> > +                             audit_log_format(ab, "%sobj_%s=?",
> > +                                              i ? " " : "",
> > +                                              lsm_slot_to_name(i));
> > +                             if (error != -EINVAL)
> > +                                     audit_panic("error in audit_log_object_context");
> > +                     } else {
> > +                             audit_log_format(ab, "%sobj_%s=%s",
> > +                                              i ? " " : "",
> > +                                              lsm_slot_to_name(i),
> > +                                              context.context);
> > +                             security_release_secctx(&context);
> > +                     }
> > +             }
> > +
> > +             audit_buffer_aux_end(ab);
> > +     }
> > +     return;
> > +
> > +error_path:
> > +     audit_panic("error in audit_log_object_context");
>
> This moves the audit_panic around, so certain operations are not
> done before the call. I am currently not sure of the implications.

Short version: It's okay.

Longer version: The audit_panic() call is either going to panic the
kernel (NOT the default), do a pr_err(), or essentially be a no-op.
In the case of the full blown kernel panic we don't really care, the
system is going to die before there is any chance of this record in
progress getting logged.  In the case of a pr_err() or no-op the key
part is making sure we leave the audit_buffer in a consistent state so
that we preserve whatever information is already present.  In the
!lsm_multiple_contexts case we simply return without making any
changes to the audit_buffer so we're good there; in the multiple LSM
case we always end the aux record properly (using a "?" when
necessary) if an aux record has been successfully created.

Feel free to point out a specific scenario that you think looks wrong
- I may have missed it - but I believe this code to be correct.

> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 557713954a69..04bf3c04ef3d 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -1420,18 +1409,10 @@ static void show_special(struct audit_context *context, int *call_panic)
>
> If pushing audit_panic into audit_log_object_context() is acceptable then this call_panic arg is
> no longer needed. The same goes for the call_panic arg in audit_log_name(). And call_panic can
> be dropped from audit_log_exit()

Good catch.

I suspect this is a vestige from when audit_log_end() used to do the
record's skb write to userspace, meaning it was possible that you
might get some of the records written to userspace before the system
killed itself.  Now with all of the queuing involved it's less likely
that this would be the case, and even if it does happen in some cases,
it's basically a toss up depending on how the system is loaded, the
scheduler, etc.

-- 
paul-moore.com
