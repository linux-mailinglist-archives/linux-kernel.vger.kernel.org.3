Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B7B59CCD2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 02:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238904AbiHWAHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 20:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbiHWAG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 20:06:59 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0EF56BAD
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 17:06:58 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id d18-20020a9d72d2000000b0063934f06268so2040957otk.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 17:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Z0Z8pTvNaMFtlpNxD7BbRoXuDRkf/ip9i0bXCGDUYgo=;
        b=G4RWh+HmaCOJWDu3SjDE/zvXFdf7TrayP9v9np3wC546dux+lBDsbmmJ6PDkzNmTdF
         eoooXdpk4elxWSqVmkjTbGuevFbAA0JQPR4lcoqvIZxl5AvPfu+cibaB9N0BiD9LnxhS
         NofWnduWy/xvkmWKSZgj46NibRG0ZpGH6xx7qxd+mp4j9/5BZyL0ZZ+o7GAiww92D/jQ
         VsLG/qlcaXo2G+TN9DGFwh8Y4sSiMaWB5i8gxPviXA+Ux/nnaVEjq+kAQdfSctu9Yqzu
         6cOXSJXV+I8C6DN8qzH0NQhxttdiJqA1DsBZCYSq6Yp9HSzuJOeefGi+RY3GiksR6HUR
         UM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Z0Z8pTvNaMFtlpNxD7BbRoXuDRkf/ip9i0bXCGDUYgo=;
        b=mv8K5zswdMjUmvcj+f5lgf6ihSKzc76I5v0NwjiRWC3POPaCTaMA8glCvor0CfMXDp
         ZdYlgQBi0LAG2G/03xHAO2YC1YrDPgqNvu6y1kMgXqHTe9KENqyoBuxqDdaeRESJ1b7i
         W4rhMn0Ai49NKflP8EMjCD3rhajN6FIIXsnmzlqD2A4PBQ5hJykuPRuRf571f5pMt/Dy
         GOpPFpHq46eAxLGcL4G+2Zn6SPBsdidm69Y4V57zEiz6pwzQqLAYwijSnunjo8u3yEnR
         T1ifTlRYqlt1vI72s6GkMyx2y1T3ug8Eh3X79eENpkeqnDRuE9FSUb0Lv4Dd3ZneWc3Z
         /mHw==
X-Gm-Message-State: ACgBeo0XzzCikKRCEkBcN5zh+7rdvqRBdguWBwPv1Hn5p2C4qCfHiOAG
        JdKA3BorYMrUFneaB1o9xpLAz2OMrwC99w/SvRsV
X-Google-Smtp-Source: AA6agR5qwXMgEyPfxkcnSn9mnofQdPNcPO8ontUm+fULsmnY5I6RDB9xuPKqn5upSQ3nJH+n81rdTP6drdpYSFnXwSo=
X-Received: by 2002:a05:6830:449e:b0:638:c72b:68ff with SMTP id
 r30-20020a056830449e00b00638c72b68ffmr8483526otv.26.1661213217372; Mon, 22
 Aug 2022 17:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <TY0PR03MB627527D223A19E65A5DA14E8A36E9@TY0PR03MB6275.apcprd03.prod.outlook.com>
In-Reply-To: <TY0PR03MB627527D223A19E65A5DA14E8A36E9@TY0PR03MB6275.apcprd03.prod.outlook.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 22 Aug 2022 20:06:46 -0400
Message-ID: <CAHC9VhTHF0vhm=1H6ywiZwW3U-eWQZnK8do5o7yCFQ5ykTrCYA@mail.gmail.com>
Subject: Re: [PATCH next] audit: printk before dropping logs in audit_log_end
To:     Ecronic <ecronic@outlook.com>
Cc:     eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 21, 2022 at 10:22 AM Ecronic <ecronic@outlook.com> wrote:
>
> If the log rate of audit exceeds audit_rate_limit, audit_log_end
> will drop the audit logs. Printk before dropping them may be a
> better choice.
>
> Signed-off-by: Ecronic <ecronic@outlook.com>
> ---
>  kernel/audit.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Hi Ecronic,

I'm not sure this is the right approach; if we're hitting a rate
limit, printing the record to the console is likely the last thing we
want to do.  Are you currently hitting a problem with the rate
limiting, or is this simply something you found via code inspection?

> diff --git a/kernel/audit.c b/kernel/audit.c
> index a75978ae38ad..3f5be93447cb 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2415,10 +2415,10 @@ void audit_log_end(struct audit_buffer *ab)
>         if (!ab)
>                 return;
>
> -       if (audit_rate_check()) {
> -               skb = ab->skb;
> -               ab->skb = NULL;
> +       skb = ab->skb;
> +       ab->skb = NULL;
>
> +       if (audit_rate_check()) {
>                 /* setup the netlink header, see the comments in
>                  * kauditd_send_multicast_skb() for length quirks */
>                 nlh = nlmsg_hdr(skb);
> @@ -2427,8 +2427,11 @@ void audit_log_end(struct audit_buffer *ab)
>                 /* queue the netlink packet and poke the kauditd thread */
>                 skb_queue_tail(&audit_queue, skb);
>                 wake_up_interruptible(&kauditd_wait);
> -       } else
> +       } else {
> +               kauditd_printk_skb(skb);
> +               kfree_skb(skb);
>                 audit_log_lost("rate limit exceeded");
> +       }
>
>         audit_buffer_free(ab);
>  }
> --
> 2.30.0

-- 
paul-moore.com
