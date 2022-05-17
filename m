Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382045296DF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 03:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237409AbiEQBnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 21:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiEQBnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 21:43:08 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DC145ACA
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 18:43:07 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v191-20020a1cacc8000000b00397001398c0so542987wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 18:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hi9XAMIUva8PYVoM4ASCm/WWoKNxiCR5dujAiZRLNMg=;
        b=cwaldFagj0bYiI4V6pIbONuNs1XGR5aGLxIKtTfxOiEY2Cx6JjEd84CdiBuwuzNE4c
         vftNt5iTn5vOS9+NvhUnZG0Yk0gZagcbvEg1EUpPFbPuXW7Id5wqNQ2WUGzJl314SovB
         iZ01f/Oxh0GRbgj0+5PQfnqVUbXNiLfz3GEJSUiH6fjfef5qLs9++I6K/WzXwVZCKk9e
         o3PhgAEtT7Sqs2J2YKiHG/p+Vv377z23OCKx+EGUpOWNJ86+EwiyTwvrwT9azDP1OudF
         DatRUYWSK2yHzM8+oF18sQm44s16pNPD8/kRM73G5shblRh6MedU108/KTVqXiYAd0+u
         Pd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hi9XAMIUva8PYVoM4ASCm/WWoKNxiCR5dujAiZRLNMg=;
        b=29Z90GG8++agdPSBvq0Vuvmi4TC8Lo4GXQ3QLoGnqcqt1n4ZbShptQFS8T+JIhpksy
         zX/rL1qz/NhbrokrJPHoL86KqyHiJCsB8uov6roqOEtiR0EuZg4BRvxo8s559hYi6USW
         zz39tPHKz9HAyWYQ7iimh44zeo6t6aqUYknJQ/Z166FgEpCUaCu9poZSk9ezPZhIq924
         KxqKtUhwIZRBLeAxNRjSSp8t/d13DnmrUIhgTk9OdBDmLHWiPZwWkbfXYHnt+UWmavMh
         CB/p5IJuqsly+Uv0pmSMoPbopyuRznpcUrxdSJp+aObtzKRMPLK8w9J6bKStY857EnO+
         m/zw==
X-Gm-Message-State: AOAM531e77fd+c58mXypC7Vyqq6lYRr+JA0y5bmhny38bHktQjoPttCD
        C+pB9L5Ng9nMrbTxgYyHkBtiAGZ7usz90ECLRwND
X-Google-Smtp-Source: ABdhPJy5yfG2djBmHYBye+k28zX32hoDwji6J+Y1t09CcsDkJQe0j0gI/s/aaLtSInbN2dJvYDJTcu7tsJfUT8sBq4w=
X-Received: by 2002:a7b:cf02:0:b0:393:fbb0:7189 with SMTP id
 l2-20020a7bcf02000000b00393fbb07189mr18520107wmg.197.1652751786116; Mon, 16
 May 2022 18:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1652730821.git.rgb@redhat.com> <81264e038b7b1e0d8fd8bafb25452fb777cd664a.1652730821.git.rgb@redhat.com>
In-Reply-To: <81264e038b7b1e0d8fd8bafb25452fb777cd664a.1652730821.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 16 May 2022 21:42:55 -0400
Message-ID: <CAHC9VhSZNbQoFfStWp96G18_pdEtV1orKRvQ0reXfD7L4TiUHA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] fanotify: Allow audit to use the full permission
 event response
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 4:22 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> This patch passes the full value so that the audit function can use all
> of it. The audit function was updated to log the additional information in
> the AUDIT_FANOTIFY record. The following is an example of the new record
> format:
>
> type=FANOTIFY msg=audit(1600385147.372:590): resp=2 fan_type=1 fan_ctx=17
>
> Suggested-by: Steve Grubb <sgrubb@redhat.com>
> Link: https://lore.kernel.org/r/3075502.aeNJFYEL58@x2
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  fs/notify/fanotify/fanotify.c |  4 +++-
>  include/linux/audit.h         |  9 +++++----
>  kernel/auditsc.c              | 18 +++++++++++++++---
>  3 files changed, 23 insertions(+), 8 deletions(-)

...

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 6973be0bf6c9..cb93c6ed07cd 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2893,10 +2894,21 @@ void __audit_log_kern_module(char *name)
>         context->type = AUDIT_KERN_MODULE;
>  }
>
> -void __audit_fanotify(u32 response)
> +void __audit_fanotify(u32 response, u32 type, union fanotify_response_extra *info)
>  {
> -       audit_log(audit_context(), GFP_KERNEL,
> -               AUDIT_FANOTIFY, "resp=%u", response);
> +       switch (type) {
> +       case FAN_RESPONSE_INFO_AUDIT_RULE:
> +               audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
> +                         "resp=%u fan_type=%u fan_ctx=%u",
> +                         response, type, info->audit_rule);
> +               break;
> +       case FAN_RESPONSE_INFO_NONE:
> +       default:
> +               audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
> +                         "resp=%u fan_type=%u fan_ctx=?",
> +                         response, type);
> +               break;
> +       }
>  }

Two things:

* Instead of "fan_ctx=", would it make sense to call it "fan_extra="
to better match the UAPI struct?  I don't feel strongly either way,
but it did occur to me just now while looking at the code so I thought
I would mention it.
* I'm also wondering if there is a way to be a bit proactive about
future proofing this field.  Since we already hex encode some fields
with "bad" characters, would it make sense to hex encode this field
too?  Not for the "bad" character reason, but more as a way of
marshalling the fanotify_response_extra union into an audit record.  I
can't see far enough into the future to know if this would be a good
idea or not, but like the other point above, it popped into my head
while looking at the code so I thought I would put it in the email :)

--
paul-moore.com
