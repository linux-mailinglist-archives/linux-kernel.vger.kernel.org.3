Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E1E510668
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350425AbiDZSQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350505AbiDZSQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:16:15 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9884D6D182
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:12:56 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b19so26569835wrh.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V8eK/38S7nXsJDHDuFBJHT2DHw6X25gLGYO4O8kog9s=;
        b=u35R0UN3dU32TrIh0qvJzhptZTfQg3iXdiYRwFzb6PgosVUkEoBsHIY3z64LRyagQs
         BBxFEKx9Qx7FIuNXcc3PTKV05MXUWxximDOybDKGH1D3+pSEiYhpphRYDUsQ7rq9yYkL
         ORs9z4rn0E9uCIrRqFHH4Ecg0UfhSLZLQryYuRJObs/A8QBmVoz293wKJH7ilzbiHeRY
         chyixo48s9kXy3GAKZnGE2dgQe0YrpeHmYYeDnlRGurYd6Y8GYhfOW/N5o7nyK94G3uC
         Gxcw572F44belh9kBNq/e1DOLzvZi5jXnRnWR4uUEb1sVHTcAF8OIkrcCafbePYC/1aK
         ZcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V8eK/38S7nXsJDHDuFBJHT2DHw6X25gLGYO4O8kog9s=;
        b=E3GQJzMmfVjurLAtsVUQffl/Mg4cDLz1SNtfc7G7mQZKhzQp68rT7RENLUVPc0ipR9
         vWbs6Y5AM/NNuX57psy4omdyf8ccLOrbUB2A7vYbV/qDkh6m/7Tr81dCly9VSSsqiEDM
         nGZid8oD6DCo//l7I3zPLtN4OwDE0auIeLOeVS1/s9hFkPv1ITc6HkWWd4UteY0dKVbC
         TGnSZJJIYDxZUlPLyG1va5cIhK0hXho5j1aZWmMWGANpnu9wCly8cT8hx5OOnFn4dJbD
         +iVjegzyhFb+Y/DakDlWjrmC6plsEpLhjK+QmCzhj2Fo8Blr0+vcwvMGVZInvKKNMjE4
         5LNA==
X-Gm-Message-State: AOAM532KB8ucrQ6/D7RmeVd4hwC76GEqwDPDxqmzo0P/XFSdsLFTAAmo
        OFvrGKQYzMfrAad+KQPDbijOdZkMON4EGLAmc4gX
X-Google-Smtp-Source: ABdhPJzC/aok+/X4UxTlSHwTZ9c3xGE41Q/Yz8+L76+xsOb0WAkCx3IdYAHkix0GlibQRLeng1JBWcVxp7TyiTMh2h8=
X-Received: by 2002:a5d:6c6d:0:b0:20a:7614:bf77 with SMTP id
 r13-20020a5d6c6d000000b0020a7614bf77mr19585388wrz.662.1650996774977; Tue, 26
 Apr 2022 11:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220418145945.38797-1-casey@schaufler-ca.com>
 <20220418145945.38797-26-casey@schaufler-ca.com> <81c9f88f-7e8f-0ca6-56b8-049571af6809@canonical.com>
In-Reply-To: <81c9f88f-7e8f-0ca6-56b8-049571af6809@canonical.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 26 Apr 2022 14:12:44 -0400
Message-ID: <CAHC9VhRX+VSw+-PsCwhHceQ9MpE4E-D-OnaO0CGqar44xc3a1w@mail.gmail.com>
Subject: Re: [PATCH v35 25/29] Audit: Allow multiple records in an audit_buffer
To:     John Johansen <john.johansen@canonical.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 9:06 PM John Johansen
<john.johansen@canonical.com> wrote:
> On 4/18/22 07:59, Casey Schaufler wrote:
> > Replace the single skb pointer in an audit_buffer with
> > a list of skb pointers. Add the audit_stamp information
> > to the audit_buffer as there's no guarantee that there
> > will be an audit_context containing the stamp associated
> > with the event. At audit_log_end() time create auxiliary
> > records (none are currently defined) as have been added
> > to the list.
> >
> > Suggested-by: Paul Moore <paul@paul-moore.com>
> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>
> I agree with Paul that audit_buffer_aux_new() and
> audit_buffer_aux_end() belong in this patch
>
>
> > ---
> >  kernel/audit.c | 62 +++++++++++++++++++++++++++++++-------------------
> >  1 file changed, 39 insertions(+), 23 deletions(-)
> >
> > diff --git a/kernel/audit.c b/kernel/audit.c
> > index 6b6c089512f7..4d44c05053b0 100644
> > --- a/kernel/audit.c
> > +++ b/kernel/audit.c
> > @@ -197,8 +197,10 @@ static struct audit_ctl_mutex {
> >   * to place it on a transmit queue.  Multiple audit_buffers can be in
> >   * use simultaneously. */
> >  struct audit_buffer {
> > -     struct sk_buff       *skb;      /* formatted skb ready to send */
> > +     struct sk_buff       *skb;      /* the skb for audit_log functions */
> > +     struct sk_buff_head  skb_list;  /* formatted skbs, ready to send */
> >       struct audit_context *ctx;      /* NULL or associated context */
> > +     struct audit_stamp   stamp;     /* audit stamp for these records */
> >       gfp_t                gfp_mask;
> >  };
> >
> > @@ -1765,10 +1767,13 @@ __setup("audit_backlog_limit=", audit_backlog_limit_set);
> >
> >  static void audit_buffer_free(struct audit_buffer *ab)
> >  {
> > +     struct sk_buff *skb;
> > +
> >       if (!ab)
> >               return;
> >
> > -     kfree_skb(ab->skb);
> > +     while((skb = skb_dequeue(&ab->skb_list)))
> > +             kfree_skb(skb);
>
> we still have and ab->skb can we have a debug check that its freed by walking the queue?

By definition ab->skb is always going to point at something on the
list, if it doesn't we are likely to have failures elsewhere.  The
structure definition is private to kernel/audit.c and the
allocation/creation is handled by an allocator function which always
adds the new skb to the list so I think we're okay.

We could add additional checks, but with audit performance already a
hot topic I would prefer to draw the debug-check line at input coming
from outside the audit subsystem.

-- 
paul-moore.com
