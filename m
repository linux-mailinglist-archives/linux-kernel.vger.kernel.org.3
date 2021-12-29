Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23DFA480E76
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 02:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238148AbhL2BVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 20:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbhL2BVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 20:21:04 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11A9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 17:21:03 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id f5so80169705edq.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 17:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fMOzYTe1YGoWwY6ZjMC4n7K9XNPYxFqUqiRsJ6N0R4o=;
        b=XWoabuYKxbKqKiBFHLd6iU/Va8CodNTjzHwlnmvaABH1TfRUpII5HqNOClV8QDVpia
         bDkgwg1VCf5BoWwViOsLEfd7DM3StCDA6+MNU9Qb20NvzWy0mB+yG6RfhHlSnMCVGnPG
         HKXgxsikIY4QMdumYWIgW5hhIWRLJPCGdpBwk8ZA+vTUovHldz+jIIcmaPQ6mav9+wn1
         y57ejWysj87HxsPD7nybUdXErtnjXhTfFjWydh+mLfHZibvU9lNE+Iqm5gulCup+PMib
         ZoMjuiUj0bNPPCw3VtO+K9n6WXHBlPXo+K1RGwSrDfsE4SLT2UCES+GPG5VO/9FNZ07B
         XTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fMOzYTe1YGoWwY6ZjMC4n7K9XNPYxFqUqiRsJ6N0R4o=;
        b=IbZq8WteRIkyqCGNFxyWu3xlKlmzgpkwHgLlO1VrrkrktZjvH5vXSr+gipTGDkbAtL
         fAOCl23Flwh2Gbxv46LSd/7GyrgRIWcZdrgfmB0VXtNCO0RAe2d+WBGwW2sIAFMjLpsx
         2+HB5U2N2JhJrwoi3s02xFcYOoAxqNZoXaxrwlIhx+TCe0Pj+DzXAu+gM1RDcIR6Zgq/
         Goq2q83U2WdXh+8YNTfuoC5++KWTec4MUJMcAmiNKNcLDJXbQeh6W+nSQr/KILf/nbaI
         frYbs4iTyjL0bSPlvwyFJeY9xiLGLq5NUam+BD4ddTYcMvKEpPAWbswb+mDaU/yg9C/4
         gFqQ==
X-Gm-Message-State: AOAM533ICXkC/7FIqoSVZHTcFMVxNJT1yftpIkXZ66d4dDCBMcqR2Hdc
        rcq6C1S3JdyWn9m07d1PYEyuX52C648YkqthbYByrzAcUBfH
X-Google-Smtp-Source: ABdhPJy0s5XMEi68RzY4w40Epp8sxIDIRNwPmNOj5KA4XEefq/YuhePUbHCZkOFJs9MNpyBrSdL+fBTcxNhJGr/DrqE=
X-Received: by 2002:a17:906:8241:: with SMTP id f1mr18716095ejx.112.1640740862264;
 Tue, 28 Dec 2021 17:21:02 -0800 (PST)
MIME-Version: 1.0
References: <20211228065023.118744-1-luhuaxin1@huawei.com> <20211228065023.118744-2-luhuaxin1@huawei.com>
In-Reply-To: <20211228065023.118744-2-luhuaxin1@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 28 Dec 2021 20:20:51 -0500
Message-ID: <CAHC9VhR_w6sfKf3uegXkvKg26VNsr7pCJJjxzBoS-C0GmVt-dQ@mail.gmail.com>
Subject: Re: [PATCH -next 1/1] audit: ignore userspace log when backlog limit
 exceeded and backlog_wait_time is 0
To:     luhuaxin <luhuaxin1@huawei.com>
Cc:     eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, fangxiuning@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 1:50 AM luhuaxin <luhuaxin1@huawei.com> wrote:
>
> When the backlog exceed the backlog_limit and backlog_wait_time is set
> to 0, the process will only sleep for a very short time (jiffies). The
> backlog may still exceed backlog_limit in extreme cases.
>
> The more reasonable way to fix this problem is:
>
> 1. If backlog_wait_time is set to zero, ignore the log;
> 2. If backlog_wait_time is set to non-zero, let process sleep for
> backlog_wait_time.
>
> The above log limit logic is also the same as that in the existing
> audit_log_start function.
>
> Fixes: 8f110f530635 ("[PATCH] audit: ensure userspace is penalized the
>   same as the kernel when under pressure")

One quick comment on the "Fixes" tag above: you shouldn't add the
"[PATCH]" string to the commit's subject, you should use the commit
subject that you would see if you typed `git log --oneline`.  It also
shouldn't be word-wrapped, it should be all on one line in your
patch/email.

Regardless of the above, I don't think this is a patch we want to
merge upstream.  I can understand the desire to improve performance,
but this doesn't seem appropriate to me; adjusting the
backlog_wait_time to very low values just so you can drop audit
records is not an approach we want to advocate, or support, upstream.

> Signed-off-by: luhuaxin <luhuaxin1@huawei.com>
> ---
>  kernel/audit.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 249e11628..70450f70a 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1545,7 +1545,8 @@ static void audit_receive(struct sk_buff  *skb)
>
>         /* can't block with the ctrl lock, so penalize the sender now */
>         if (audit_backlog_limit &&
> -           (skb_queue_len(&audit_queue) > audit_backlog_limit)) {
> +           (skb_queue_len(&audit_queue) > audit_backlog_limit) &&
> +           audit_backlog_wait_time) {
>                 DECLARE_WAITQUEUE(wait, current);
>
>                 /* wake kauditd to try and flush the queue */
> @@ -1842,9 +1843,8 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
>          *    while holding the mutex, although we do penalize the sender
>          *    later in audit_receive() when it is safe to block
>          */
> +       long stime = audit_backlog_wait_time;
>         if (!(auditd_test_task(current) || audit_ctl_owner_current())) {
> -               long stime = audit_backlog_wait_time;
> -
>                 while (audit_backlog_limit &&
>                        (skb_queue_len(&audit_queue) > audit_backlog_limit)) {
>                         /* wake kauditd to try and flush the queue */
> @@ -1872,6 +1872,14 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
>                                 return NULL;
>                         }
>                 }
> +       } else if (!stime && audit_backlog_limit &&
> +                  (skb_queue_len(&audit_queue) > audit_backlog_limit)) {
> +               if (audit_rate_check() && printk_ratelimit())
> +                       pr_warn("audit_backlog=%d > audit_backlog_limit=%d\n",
> +                               skb_queue_len(&audit_queue),
> +                               audit_backlog_limit);
> +               audit_log_lost("backlog limit exceeded");
> +               return NULL;
>         }
>
>         ab = audit_buffer_alloc(ctx, gfp_mask, type);
> --
> 2.23.0

-- 
paul moore
www.paul-moore.com
