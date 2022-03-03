Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BFF4CCA1A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 00:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbiCCXhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 18:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237237AbiCCXha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 18:37:30 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1970175841
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 15:36:43 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id w3so8601966edu.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 15:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KvhOfJoZNlT/o74sygCM900WcOV6VdSTq7TVDxqHEUg=;
        b=wRUwB5oon3fpN4PvSnSdVpd8pqzXEeSf08f8SeIvX0H87zvxdzkH8GmfpbbrGSUXaO
         9bHDbpXtukU3WlUrjCcUtAkxw3by8OUw6I4evB2Z07L+8tX1qGgYK4wD82tIM3bFRsCU
         RYP7VRnibqFCF4cKHJu7LhhlmNlWFFag96l3JjCAdIJUX7+o7vCx9dEPzzWphWx8D+Y7
         /yYRb+oVrfDCp7+L9tyNvZx2UXgd1Cms5bAKvGfW3vvRIshCwA2gF0tvo7VauN3CyiAF
         IwbWvWUPg8s99Ad5M9TxiXp6xenMEr7Maj+ugaFymPE/HrITPasLQyEzip8qLEFdpAiM
         FgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KvhOfJoZNlT/o74sygCM900WcOV6VdSTq7TVDxqHEUg=;
        b=J3vk8L84BY4wBcwn6PHT0kJ6+UMO5888sNj5Yl/5Ua2oXVWyejmKT2VuTMz7hGPuIq
         nZCqOnTB4PTAoSlgJGY5TsiTFZEDMecw2oKFmJafRtsm1lh6lMOdby2pfqYoQ2SjGiKR
         gCu0ox2wuLVTota4YdcEmO7FyzL18CLyvb8UKwyLgVqUKwvtfg62PkSb9BD05PlN5nv6
         NodMg2axvM0oMD0tXDVrBTkxIcwwzw4h/wPl0wCsUs5cTNNyJVfjrY2MlfKl541oFW0Z
         1g3xIyN2sQcMArtKg9EKzriEbhj3XXcFpU68ZBDbGqNkEG0uwGeWFSrPpjRoudb6Ldbq
         UgQA==
X-Gm-Message-State: AOAM533Za16J9+U8BBL/vH5nHeBDN2E4B34omLbpLCfguWTYCiS5TC80
        3Wk5IAXYDxCWUcgDBTrACBLSNT504YtZE765WZJx
X-Google-Smtp-Source: ABdhPJzBsPoIX45CExHwwuBV8Cp+mrC7vsk0YcFvz0/nJT1z7aegOLVHgbEonFb2WXEsALpjM5XDLjsW/+Sv7p4uBNE=
X-Received: by 2002:aa7:d494:0:b0:415:a309:7815 with SMTP id
 b20-20020aa7d494000000b00415a3097815mr11752065edr.340.1646350602085; Thu, 03
 Mar 2022 15:36:42 -0800 (PST)
MIME-Version: 1.0
References: <20220202235323.23929-1-casey@schaufler-ca.com> <20220202235323.23929-25-casey@schaufler-ca.com>
In-Reply-To: <20220202235323.23929-25-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 3 Mar 2022 18:36:31 -0500
Message-ID: <CAHC9VhS6An9L7LavYTP57QXdOugQf62NCjDmS4kQq3wk+yemcg@mail.gmail.com>
Subject: Re: [PATCH v32 24/28] Audit: Add framework for auxiliary records
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 2, 2022 at 7:20 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Add a list for auxiliary record data to the audit_buffer structure.
> Add the audit_stamp information to the audit_buffer as there's no
> guarantee that there will be an audit_context containing the stamp
> associated with the event. At audit_log_end() time create auxiliary
> records (none are currently defined) as have been added to the list.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  kernel/audit.c | 84 ++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 74 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/audit.c b/kernel/audit.c
> index f012c3786264..559fb14e0380 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -191,15 +191,25 @@ static struct audit_ctl_mutex {
>   * should be at least that large. */
>  #define AUDIT_BUFSIZ 1024
>
> +/* The audit_context_entry contains data required to create an
> + * auxiliary record.
> + */
> +struct audit_context_entry {
> +       struct list_head        list;
> +       int                     type;   /* Audit record type */
> +};

Looking at how this ends up being used later in the patchset I think
we would be better off if we stored a fully formed audit_buffer in the
struct above instead of data fields which we would use to generate an
audit_buffer in audit_log_end().  This helps tie the buffer generation
logic in with the existing code with which it is most closely related,
it allows us to report errors back to the caller as audit_log_end()
doesn't historically return an error code, and it helps us get ahead
of any future data lifetime issues we might run into by storing the
data in this audit struct.

This would also simplify things with respect to the audit_buffer
struct.  Instead of having a dedicated struct for the aux data, you
could simply leverage the existing sk_buff list mechanisms:

  struct audit_buffer {
    struct sk_buff *skb;  /* part of @skb_list, kept for audit_log funcs */
    struct sk_buff_head skb_list;
    struct audit_context *ctx;
    struct audit_stamp stamp;
    gfp_t gfp_mask;
  }

The only sneaky bit in the struct above is that we likely want to
preserve audit_buffer::skb as a dedicated skb pointer so we don't have
to modify all of the audit_log_*() functions; you could of course, but
I'm guessing there is little appetite for that in the context of this
patchset.

Adding a new aux record would involve calling some private audit
function (no one outside of the audit subsystem should need access)
that would allocate a new skb similar to what we do in
audit_buffer_alloc() and add it to the end of the sk_buff_head list
via skb_queue_tail() and resetting audit_buffer::skb to point to the
newly allocated skb.  This would allow all of the existing
audit_log*() functions to work correctly, and when you are done you
can restore the "main" skb with skb_peek().  If for some reason you
need to fail the new aux record mid-creation you just dequeue the list
tail, free the skb, and skb_peek() the "main" skb back into place.

>  /* The audit_buffer is used when formatting an audit record.  The caller
>   * locks briefly to get the record off the freelist or to allocate the
>   * buffer, and locks briefly to send the buffer to the netlink layer or
>   * to place it on a transmit queue.  Multiple audit_buffers can be in
>   * use simultaneously. */
>  struct audit_buffer {
> -       struct sk_buff       *skb;      /* formatted skb ready to send */
> -       struct audit_context *ctx;      /* NULL or associated context */
> -       gfp_t                gfp_mask;
> +       struct sk_buff          *skb;   /* formatted skb ready to send */
> +       struct audit_context    *ctx;   /* NULL or associated context */
> +       struct list_head        aux_records;    /* aux record data */
> +       struct audit_stamp      stamp;  /* event stamp */
> +       gfp_t                   gfp_mask;
>  };

...

> @@ -2408,6 +2418,60 @@ void audit_log_end(struct audit_buffer *ab)
>                 wake_up_interruptible(&kauditd_wait);
>         } else
>                 audit_log_lost("rate limit exceeded");
> +}
> +
> +/**
> + * audit_log_end - end one audit record
> + * @ab: the audit_buffer
> + *
> + * Let __audit_log_end() handle the message while the buffer housekeeping
> + * is done here.
> + * If there are other records that have been deferred for the event
> + * create them here.
> + */
> +void audit_log_end(struct audit_buffer *ab)
> +{
> +       struct audit_context_entry *entry;
> +       struct audit_context mcontext;
> +       struct audit_context *mctx;
> +       struct audit_buffer *mab;
> +       struct list_head *l;
> +       struct list_head *n;
> +
> +       if (!ab)
> +               return;
> +
> +       __audit_log_end(ab);
> +
> +       if (list_empty(&ab->aux_records)) {
> +               audit_buffer_free(ab);
> +               return;
> +       }
> +
> +       if (ab->ctx == NULL) {
> +               mcontext.stamp = ab->stamp;
> +               mctx = &mcontext;
> +       } else
> +               mctx = ab->ctx;
> +
> +       list_for_each_safe(l, n, &ab->aux_records) {
> +               entry = list_entry(l, struct audit_context_entry, list);
> +               mab = audit_log_start(mctx, ab->gfp_mask, entry->type);
> +               if (!mab) {
> +                       audit_panic("alloc error in audit_log_end");
> +                       continue;
> +               }
> +               switch (entry->type) {
> +               /* Don't know of any quite yet. */
> +               default:
> +                       audit_panic("Unknown type in audit_log_end");
> +                       break;
> +               }
> +               __audit_log_end(mab);
> +               audit_buffer_free(mab);
> +               list_del(&entry->list);
> +               kfree(entry);
> +       }
>
>         audit_buffer_free(ab);
>  }

This would also allow you to simplify audit_log_end() greatly, I'm
sure I'm missing a detail or two, but I suspect it would end up
looking something like this:

  void __audit_log_end(skb)
  {
    /* ... current audit_log_end() but with only the sk_buff ... */
  }

  void audit_log_end(ab)
  {
    if (!ab)
      return;
    while ((skb = skb_dequeue(ab->skb_list)))
      __audit_log_end(skb);
    audit_buffer_free(ab);
  }


--
paul-moore.com
