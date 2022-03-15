Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674B44DA666
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 00:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352616AbiCOXtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 19:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348320AbiCOXtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 19:49:02 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC4126D9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 16:47:48 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id hw13so830240ejc.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 16:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rytjyPZ9RNxi/avIuivSs6xI7PnvqvUQtVccmZitEKI=;
        b=gAazJfXI5UKMUFXIaLVmR4ut6nyHRO1MbFHm2xIVfKwZjvF9UpO93tabuvO5mNS4cq
         GekKVQ+O/gYxc//atQNwW86Fl6+OHtxy1l3hP1VfXU425AoJ7WbzCPl1pEewLwo4VSc4
         I1iXvR6ObDSmwwjCvdhvq3dorv/rcAqR5aWuraEVlNxDnO3zZ0sgoz2p+7GXgYZ2p6tg
         GZjyKJpZYfErbiMJx/9y6xZ56/GhuLRpGfIeTo4PgPXd7OQsdKSfo4whGJzD5P+tS4oJ
         lMYaFxmBznvGAs6E5Tqk9XtKXF7N1r+XUtmIfvKgQy6jMvRckCQxvSATJUiNu8CXSRpT
         MJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rytjyPZ9RNxi/avIuivSs6xI7PnvqvUQtVccmZitEKI=;
        b=gHiVAjX8y4gmEHIJgk2R5unZkF1OL1Z7UOE65Su5D5tnD5HBjz0MQKInT+sobS8wru
         BbIOPMnTyinHiHyAEOQvXS5bB/GCevBaK0XgNKme2NzpAS5e8uVRBbZBVTd4WKudlNy+
         hM0eL6Dzm98sSFeOX5zhl56e7g/BqCjAPx81OgwPHqDX9ls3zmS945rC0Fw7xnsd6rkL
         hRniQwxITGdkmNTr9URvgaByukdl1MgfdSUZmkjQFCuoG1/n815QhIw0dm8bPQRVW7r2
         9j5GAfHF1zQ/oiXxs2lwVekKkdYJoD4DJV2bTI2CopMqcyEgS9ucfHvuJkZ54TuPCAOw
         u/0Q==
X-Gm-Message-State: AOAM531y49AuHx98s5xb/gmwrLdr/+YzzDRMtNcnRu5xu+6uLy4gjuS3
        cwHJHJAW76E6WpeOVWQm17mUMtehwlyHsr/6szLzokUgvA==
X-Google-Smtp-Source: ABdhPJzQyi5HuX+wXvfaijMiHF1MOswzJSHw7vqFltYTNxOMEDQ5dBxEcxUIifpqaIwrQ2yGc8SzMlAwcA4wIGxQyfM=
X-Received: by 2002:a17:907:1b09:b0:6d8:faa8:4a06 with SMTP id
 mp9-20020a1709071b0900b006d8faa84a06mr24602944ejc.701.1647388067190; Tue, 15
 Mar 2022 16:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220310234632.16194-1-casey@schaufler-ca.com> <20220310234632.16194-26-casey@schaufler-ca.com>
In-Reply-To: <20220310234632.16194-26-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 15 Mar 2022 19:47:36 -0400
Message-ID: <CAHC9VhTkXaJ6nsJU9hf9KO22bGSpyr8EeBQKef-f6jhy_6OEkA@mail.gmail.com>
Subject: Re: [PATCH v33 25/29] Audit: Allow multiple records in an audit_buffer
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 6:59 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Replace the single skb pointer in an audit_buffer with
> a list of skb pointers. Add the audit_stamp information
> to the audit_buffer as there's no guarantee that there
> will be an audit_context containing the stamp associated
> with the event. At audit_log_end() time create auxiliary
> records (none are currently defined) as have been added
> to the list.
>
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  kernel/audit.c | 53 +++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 35 insertions(+), 18 deletions(-)
>
> diff --git a/kernel/audit.c b/kernel/audit.c
> index f012c3786264..4713e66a12af 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -197,8 +197,10 @@ static struct audit_ctl_mutex {
>   * to place it on a transmit queue.  Multiple audit_buffers can be in
>   * use simultaneously. */
>  struct audit_buffer {
> -       struct sk_buff       *skb;      /* formatted skb ready to send */
> +       struct sk_buff       *skb;      /* the skb for audit_log functions */
> +       struct sk_buff_head  skb_list;  /* formatted skbs, ready to send */
>         struct audit_context *ctx;      /* NULL or associated context */
> +       struct audit_stamp   stamp;     /* audit stamp for these records */
>         gfp_t                gfp_mask;
>  };
>
> @@ -1744,7 +1746,6 @@ static void audit_buffer_free(struct audit_buffer *ab)
>         if (!ab)
>                 return;
>
> -       kfree_skb(ab->skb);

I like the safety in knowing that audit_buffer_free() would free the
ab->skb memory, I'm not sure I want to get rid of that.  With the
understanding that ab->skb is always going to be present somewhere in
ab->skb_list, any reason not to do something like this?

  while ((skb = skb_dequeue(&ab->skb_list)))
    kfree_skb(skb);

>         kmem_cache_free(audit_buffer_cache, ab);
>  }
>
> @@ -1760,11 +1761,15 @@ static struct audit_buffer *audit_buffer_alloc(struct audit_context *ctx,
>         ab->skb = nlmsg_new(AUDIT_BUFSIZ, gfp_mask);
>         if (!ab->skb)
>                 goto err;
> -       if (!nlmsg_put(ab->skb, 0, 0, type, 0, 0))
> +       if (!nlmsg_put(ab->skb, 0, 0, type, 0, 0)) {
> +               kfree_skb(ab->skb);
>                 goto err;
> +       }

Assuming we restore the audit_buffer_free() functionality as mentioned
above, if we move the ab->skb_list init and enqueue calls before we
attempt the nlmsg_put() we can drop the kfree_skb() call and just use
the existing audit_buffer_free() call at the err target.


>         ab->ctx = ctx;
>         ab->gfp_mask = gfp_mask;
> +       skb_queue_head_init(&ab->skb_list);
> +       skb_queue_tail(&ab->skb_list, ab->skb);
>
>         return ab;
>

--
paul-moore.com
