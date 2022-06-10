Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994AF546EF8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 23:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350801AbiFJVE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 17:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350765AbiFJVEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 17:04:52 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272D7245A0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 14:04:50 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id g205so449719pfb.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 14:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SiLCrAL53VdiLKOXfLPLunTsPwo2FINx12xxld+VcU4=;
        b=bFQVTO6kUj6C9eZqt3ASwH3yDJCd8h4+qHqP1I+aPVsKQAS8QoEkX82JRGy9ooQDC2
         MR8htAsandvUIN3h90FZvL04oRvRshPFFbdKJ1A29ojwxreeu/mqSzweWjeNRGmGx7xK
         Vs/O8fPBaQaYpevC/OBloET2GC9ejXJDZpiNRsmSGIxlYWF9RIQEu1Gf6dmrhl7I17o0
         RB5a0RHCLeFhu3WcZSBQtNm0A6dj5SnN2ZdpmFi2FYl4qCF/bRV7JG8Su4HSu+8+sCZH
         2eeIIsuAeOG5yJwagorVIKfbV+8tCYLs/V4UtEdtzjxCBKK+8VbpEUb2vw187EbIm1YC
         t1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SiLCrAL53VdiLKOXfLPLunTsPwo2FINx12xxld+VcU4=;
        b=NZCV2c6Kvr/c9e4unsL+fHcp2GaCWAehJ4eEbrspSWcLbyBFZb3s0zSSfazhDKhc5p
         5GY7WhV9y5gwBY0PH4CAv2imPpa8SG+nFgBZLU0EY2zVHs1C7x8M7Si/yg76en2k/09+
         qeJEn3FfKJCd+dZEiMDSrid8cSFi/iLJmYwzjONRlKd0N4i3iKYQZYlarFoaehp4+/+f
         k7yvS11zIDFP8AXZ6kOWLxppMpT5DHedc06Qxmaog2MzxWZFpsYhWh1pRNPikJzwmYtE
         dvDHjlfUheXwH7Eae3sUStLYGBLQIHkT2MbuyBLyAcskIA9piefMx+FRlGqGye0LVkk2
         vPgg==
X-Gm-Message-State: AOAM530ZkqZQ0Ard2GT8Aa7iqRJkPguk3t4Ec3vsQPLqm+Ygw4E8w+AQ
        YdJ+/WiG4rmlmfPz8+uuELbXa76zNyiJaJjmV2kD
X-Google-Smtp-Source: ABdhPJwNdRdVzr3QMEopSyl6AGpCfiZgxW6A683tU/g0pcw8EZpJjU6kRe3OUp1IJyJkmTxwo6rWP/C3gyWE88D/3OI=
X-Received: by 2002:a62:868c:0:b0:51b:bd62:4c87 with SMTP id
 x134-20020a62868c000000b0051bbd624c87mr47036124pfd.83.1654895089650; Fri, 10
 Jun 2022 14:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220609230146.319210-1-casey@schaufler-ca.com> <20220609230146.319210-27-casey@schaufler-ca.com>
In-Reply-To: <20220609230146.319210-27-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Jun 2022 17:04:38 -0400
Message-ID: <CAHC9VhT-qo=N4k7fWvZNELNLTGDWuE4kDXEOYwMBgZGRQu8f7w@mail.gmail.com>
Subject: Re: [PATCH v36 26/33] Audit: Allow multiple records in an audit_buffer
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 9, 2022 at 7:15 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Replace the single skb pointer in an audit_buffer with
> a list of skb pointers. Add the audit_stamp information
> to the audit_buffer as there's no guarantee that there
> will be an audit_context containing the stamp associated
> with the event. At audit_log_end() time create auxiliary
> records (none are currently defined) as have been added
> to the list. Functions are created to manage the skb list
> in the audit_buffer.
>
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  kernel/audit.c | 113 +++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 90 insertions(+), 23 deletions(-)

...

> diff --git a/kernel/audit.c b/kernel/audit.c
> index 6b6c089512f7..987740374dfa 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1784,8 +1789,12 @@ static struct audit_buffer *audit_buffer_alloc(struct audit_context *ctx,
>         ab->skb = nlmsg_new(AUDIT_BUFSIZ, gfp_mask);
>         if (!ab->skb)
>                 goto err;
> +
> +       skb_queue_head_init(&ab->skb_list);
> +       skb_queue_tail(&ab->skb_list, ab->skb);
> +
>         if (!nlmsg_put(ab->skb, 0, 0, type, 0, 0))
> -               goto err;
> +               kfree_skb(ab->skb);
>
>         ab->ctx = ctx;
>         ab->gfp_mask = gfp_mask;

I didn't notice this in v35, but if the nlmsg_put() fails I think you
need to preserve the 'goto err;' since the skb hasn't been properly
initialized.  The good news is that I don't think you need to worry
about the 'kfree_skb(ab->skb);' in the error handler as it's already
been placed on the audit_buffer:skb_list list and will be freed when
audit_buffer_alloc()'s error handling code calls audit_buffer_free().

-- 
paul-moore.com
