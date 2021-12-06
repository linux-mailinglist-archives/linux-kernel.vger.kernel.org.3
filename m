Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85DA7468F5D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 03:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbhLFCtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 21:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbhLFCtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 21:49:03 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635C8C061359
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 18:45:35 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id l25so36808986eda.11
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 18:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gpFcj1uUZYTNq0+KmLnzmL35K736w79jGUcUQG+j0+4=;
        b=TEFlHWEQTHdyXsexdSs/rCzUwNtGbKZys0hfRMniE+H1e+0lKMTxgggMB1oTe9OUCv
         DcenEaj6jut/2kjLO+mgIa0fQ5zYF+dmvyrhxp7ecuPeSq8kkJyEA6pgjvDhzmHCGtqE
         bG8ZWxbwbtYpAtUkyz2txFgXoX0M4BLxnyAeHb2rg2lLTADwtVbOGn2AIUnSVSOvKZ3l
         TjP6/Hzni7Xpl9C9sv6eixR5+po55Xy8O2TkADnUREkVYBgeGKIwixPcgZyh+PO5INLk
         RHYmvEpIAZK4tls7VMKzUaazrEz+2OvFYwBAyb57LIAX6sHYK2Dr3J0uiZZoxupUPUoS
         o5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gpFcj1uUZYTNq0+KmLnzmL35K736w79jGUcUQG+j0+4=;
        b=xmUu5xUIqyjtR7OUUOWZfFDgLq78s8jBI2u8ipomy1zrZ+ftJqqA2RBRxMvbHCXWfs
         vbR0x9VRbG6kH12jadbhrMeQwH++aFpH4AC+d9NH7Lj/4FCIc7Q7UPvh+hdWuYj6Xh95
         lzDEx9fG22kZg6baUPtm7m+0i5hRXOw2+BUnOv1PxjKVeZxamKlQnqsbGGncHsuPBuVj
         1QIfk8sQx+a7XP9qcGKIYN3Vsmj2z/fHCdgGwDUfh3p/l/jlIZ0lxfGIgmnCfsFQAe41
         raW/l+qYLg2XdXhnGy5cIUEV17OAoIz3jCHVAl/uwxCdBpcc8O+s0D6ZPMnYBxgCeGZI
         olXw==
X-Gm-Message-State: AOAM532iQeXdmB/i88zLLesJw3uRDavmT2cgxNkmrctGXCdv8xNLITWK
        Ik5+qggKN5R8ENOUECZ64dM7hUhr3edbCmhcZuHGqcQeCw==
X-Google-Smtp-Source: ABdhPJyiHNaMyVS5PZYMibcIrBXPL0EeazoGYH7BTBz49n1/LTfHIDjvW+a3ZvHguWuXDXri2ZZVdc+BfdO+UUfzUTs=
X-Received: by 2002:a05:6402:34cd:: with SMTP id w13mr49333749edc.112.1638758733909;
 Sun, 05 Dec 2021 18:45:33 -0800 (PST)
MIME-Version: 1.0
References: <20211124014332.36128-1-casey@schaufler-ca.com> <20211124014332.36128-26-casey@schaufler-ca.com>
In-Reply-To: <20211124014332.36128-26-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 5 Dec 2021 21:45:23 -0500
Message-ID: <CAHC9VhTYudezmRyZxEGRL=ivwSDBmeh4nZ_qBkBZR9+LJxC8xg@mail.gmail.com>
Subject: Re: [PATCH v30 25/28] Audit: Add record for multiple task security contexts
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 9:11 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Create a new audit record AUDIT_MAC_TASK_CONTEXTS.
> An example of the MAC_TASK_CONTEXTS (1420) record is:
>
>     type=UNKNOWN[1420]
>     msg=audit(1600880931.832:113)
>     subj_apparmor="=unconfined"
>     subj_smack="_"
>
> When an audit event includes a AUDIT_MAC_TASK_CONTEXTS record
> the "subj=" field in other records in the event will be "subj=?".
> A AUDIT_MAC_TASK_CONTEXTS record is supplied when the system has
> multiple security modules that may make access decisions based
> on a subject security context.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/security.h   |  9 ++++++
>  include/uapi/linux/audit.h |  1 +
>  kernel/audit.c             | 66 ++++++++++++++++++++++++++++++++------
>  3 files changed, 67 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 763dca314c00..b98545d2ae04 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -231,6 +231,15 @@ static inline bool lsmblob_equal(struct lsmblob *bloba, struct lsmblob *blobb)
>  extern int lsm_name_to_slot(char *name);
>  extern const char *lsm_slot_to_name(int slot);
>
> +static inline bool lsm_multiple_contexts(void)
> +{
> +#ifdef CONFIG_SECURITY
> +       return lsm_slot_to_name(1) != NULL;
> +#else
> +       return false;
> +#endif
> +}
> +
>  /**
>   * lsmblob_value - find the first non-zero value in an lsmblob structure.
>   * @blob: Pointer to the data
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index 9176a095fefc..86ad3da4f0d4 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -143,6 +143,7 @@
>  #define AUDIT_MAC_UNLBL_STCDEL 1417    /* NetLabel: del a static label */
>  #define AUDIT_MAC_CALIPSO_ADD  1418    /* NetLabel: add CALIPSO DOI entry */
>  #define AUDIT_MAC_CALIPSO_DEL  1419    /* NetLabel: del CALIPSO DOI entry */
> +#define AUDIT_MAC_TASK_CONTEXTS        1420    /* Multiple LSM task contexts */
>
>  #define AUDIT_FIRST_KERN_ANOM_MSG   1700
>  #define AUDIT_LAST_KERN_ANOM_MSG    1799
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 2b22498d3532..6c93545a14f3 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -197,6 +197,9 @@ static struct audit_ctl_mutex {
>  struct audit_context_entry {
>         struct list_head        list;
>         int                     type;   /* Audit record type */
> +       union {
> +               struct lsmblob  mac_task_context;

The name "mac_task_context" is awfully long, why not something like
"lsm_subjs" or similar?

> +       };
>  };
>
>  /* The audit_buffer is used when formatting an audit record.  The caller
> @@ -2139,6 +2142,21 @@ void audit_log_key(struct audit_buffer *ab, char *key)
>                 audit_log_format(ab, "(null)");
>  }
>
> +static int audit_add_aux_task(struct audit_buffer *ab, struct lsmblob *blob)
> +{
> +       struct audit_context_entry *ace;
> +
> +       ace = kzalloc(sizeof(*ace), GFP_KERNEL);

Instead of using GFP_KERNEL I would recommend using ab->gfp_mask to
ensure we don't run into allocation problems depending on the calling
context.

> +       if (!ace)
> +               return -ENOMEM;
> +
> +       INIT_LIST_HEAD(&ace->list);
> +       ace->type = AUDIT_MAC_TASK_CONTEXTS;

I would suggest one of the following:

A) Add a "type" parameter to the function and use it here so that this
function truly generic.
B) Leave the ace->type assignment alone and change the function name
to audit_add_mac_task_contexts().
C) Fold this entire function into audit_log_task_context().

Of the three, I think choice B makes the least amount of sense; if
this is a dedicated AUDIT_MAC_TASK_CONTEXTS function then it should
probably just live inside audit_log_task_context() (choice C).
Choosing between A and C is really a matter of deciding if you are
going to use this function elsewhere, and it doesn't appear that you
do so in this patchset.  Sure, other patchsets might make use of this
someday (or not), but if they do they can also extract it back out
into a separate function (if needed).

> +       ace->mac_task_context = *blob;
> +       list_add(&ace->list, &ab->aux_records);
> +       return 0;
> +}
> +
>  int audit_log_task_context(struct audit_buffer *ab)
>  {
>         int error;
> @@ -2149,16 +2167,22 @@ int audit_log_task_context(struct audit_buffer *ab)
>         if (!lsmblob_is_set(&blob))
>                 return 0;
>
> -       error = security_secid_to_secctx(&blob, &context, LSMBLOB_FIRST);
> -       if (error) {
> -               if (error != -EINVAL)
> -                       goto error_path;
> +       if (!lsm_multiple_contexts()) {
> +               error = security_secid_to_secctx(&blob, &context,
> +                                                LSMBLOB_FIRST);
> +               if (error) {
> +                       if (error != -EINVAL)
> +                               goto error_path;
> +                       return 0;
> +               }
> +               audit_log_format(ab, " subj=%s", context.context);
> +               security_release_secctx(&context);
>                 return 0;
>         }
> -
> -       audit_log_format(ab, " subj=%s", context.context);
> -       security_release_secctx(&context);
> -       return 0;
> +       audit_log_format(ab, " subj=?");
> +       error = audit_add_aux_task(ab, &blob);
> +       if (!error)
> +               return 0;

This is very bikeshed-y, but from a style perspective I would prefer
to see something like this:

  if (!lsm_multiple_contexts()) {
    /* existing, single LSM code */
  } else {
    /* new, multiple LSM code */
  }
  return error;

IMO it makes it a bit more clear that each code path is equally likely
and neither is an exception.

>  error_path:
>         audit_panic("error in audit_log_task_context");
> @@ -2419,9 +2443,12 @@ void audit_log_end(struct audit_buffer *ab)
>         struct audit_context_entry *entry;
>         struct audit_context mcontext;
>         struct audit_context *mctx;
> +       struct lsmcontext lcontext;
>         struct audit_buffer *mab;
>         struct list_head *l;
>         struct list_head *n;
> +       int rc;
> +       int i;
>
>         if (!ab)
>                 return;
> @@ -2448,7 +2475,28 @@ void audit_log_end(struct audit_buffer *ab)
>                         continue;
>                 }
>                 switch (entry->type) {
> -               /* Don't know of any quite yet. */
> +               case AUDIT_MAC_TASK_CONTEXTS:
> +                       for (i = 0; i < LSMBLOB_ENTRIES; i++) {
> +                               if (entry->mac_task_context.secid[i] == 0)
> +                                       continue;
> +                               rc = security_secid_to_secctx(
> +                                               &entry->mac_task_context,
> +                                               &lcontext, i);
> +                               if (rc) {
> +                                       if (rc != -EINVAL)
> +                                               audit_panic("error in audit_log_end");
> +                                       audit_log_format(mab, "%ssubj_%s=\"?\"",

I don't believe you need the quotes around the question mark here, you
should be able to treat it just like it was "subj=?".

> +                                                        i ? " " : "",
> +                                                        lsm_slot_to_name(i));
> +                               } else {
> +                                       audit_log_format(mab, "%ssubj_%s=\"%s\"",

Same as above.

> +                                                        i ? " " : "",
> +                                                        lsm_slot_to_name(i),
> +                                                        lcontext.context);
> +                                       security_release_secctx(&lcontext);
> +                               }
> +                       }
> +                       break;
>                 default:
>                         audit_panic("Unknown type in audit_log_end");
>                         break;
> --
> 2.31.1

--
paul moore
www.paul-moore.com
