Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB91252DB48
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242693AbiESR2a convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 May 2022 13:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243067AbiESR0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:26:16 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4F83E5C0
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:25:56 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id e78so10159465ybc.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1p7cU7b8qz6i860wpR3X62w6Sx8yiR8QDIbRQYHlwIQ=;
        b=Prd/HQPFlhvog7ZVm5mppKaI114CCscEukhbV9IcZZZsHxSvz8KFzKqvPiUjSHxq3O
         qtfUiD6ceGVfXiOjqIvdDddnsrkzVrmVlv3YyIW6XXYU2QLlowdM1Mdlo3F5biIpjf+r
         HrTV4+bCD/A3fbS8LD263tiATnP+t/20njIP5sQzeBn9e1okO4zKJ/hHZmOWFa0SOm+L
         Pg40nBLva/2x/G9zMN0rCgg06fhpXTZSvfAs/XA+9mkx2nOMw8hBH7A2hHYdOsiId+kv
         DFjn+3kn27NH/Lds9IgRzoKHMl26IqfKsifWcqbuiWfq+jxcsbLgPIqBaI7UEm2csk+R
         aeVA==
X-Gm-Message-State: AOAM53175m5+3pfgykJhCq8A+8SNZA8WPI4VNtXw/NQ+QT4ejV+j1uti
        sALYJf+kvrx3YtnphkRYKlVbzzcV8t+1qq0t18k=
X-Google-Smtp-Source: ABdhPJwTxwEMQxUK35mCWaWi1cm/VjIPoKb/m6rnKE+9e0oVua5zcI6AUSs1yV7gVP1z00eB7CUn/8MYpCt0mLJePcQ=
X-Received: by 2002:a25:d687:0:b0:64e:3a41:8d5 with SMTP id
 n129-20020a25d687000000b0064e3a4108d5mr5431430ybg.622.1652981155848; Thu, 19
 May 2022 10:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220519110232.1198823-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20220519110232.1198823-1-dmitry.osipenko@collabora.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 May 2022 19:25:45 +0200
Message-ID: <CAJZ5v0gu7nOX=FPdVJkfCVXvKKKgSew2rMigudB2qNviAhE_Bw@mail.gmail.com>
Subject: Re: [PATCH v10] notifier: Add atomic_notifier_call_chain_is_empty()
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 1:02 PM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Add atomic_notifier_call_chain_is_empty() that returns true if given
> atomic call chain is empty.
>
> The first user of this new notifier API function will be the kernel
> power-off core code that will support power-off call chains. The core
> code will need to check whether there is a power-off handler registered
> at all in order to decide whether to halt machine or power it off.
>
> Reviewed-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>
> Changelog:
>
> v10: - Corrected another doc-comment typo s/atomicnotifier/atomic_notifier/.
>
> v9: - Extended commit message with a usage example.
>
>     - Corrected doc-comment with s/blocking/atomic/.
>
>  include/linux/notifier.h |  2 ++
>  kernel/notifier.c        | 13 +++++++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/include/linux/notifier.h b/include/linux/notifier.h
> index 87069b8459af..95e2440037de 100644
> --- a/include/linux/notifier.h
> +++ b/include/linux/notifier.h
> @@ -173,6 +173,8 @@ extern int blocking_notifier_call_chain_robust(struct blocking_notifier_head *nh
>  extern int raw_notifier_call_chain_robust(struct raw_notifier_head *nh,
>                 unsigned long val_up, unsigned long val_down, void *v);
>
> +extern bool atomic_notifier_call_chain_is_empty(struct atomic_notifier_head *nh);
> +
>  #define NOTIFY_DONE            0x0000          /* Don't care */
>  #define NOTIFY_OK              0x0001          /* Suits me */
>  #define NOTIFY_STOP_MASK       0x8000          /* Don't call further */
> diff --git a/kernel/notifier.c b/kernel/notifier.c
> index ba005ebf4730..137b902c985b 100644
> --- a/kernel/notifier.c
> +++ b/kernel/notifier.c
> @@ -204,6 +204,19 @@ int atomic_notifier_call_chain(struct atomic_notifier_head *nh,
>  EXPORT_SYMBOL_GPL(atomic_notifier_call_chain);
>  NOKPROBE_SYMBOL(atomic_notifier_call_chain);
>
> +/**
> + *     atomic_notifier_call_chain_is_empty - Check whether notifier chain is empty
> + *     @nh: Pointer to head of the atomic notifier chain
> + *
> + *     Checks whether notifier chain is empty.
> + *
> + *     Returns true is notifier chain is empty, false otherwise.
> + */
> +bool atomic_notifier_call_chain_is_empty(struct atomic_notifier_head *nh)
> +{
> +       return !rcu_access_pointer(nh->head);
> +}
> +
>  /*
>   *     Blocking notifier chain routines.  All access to the chain is
>   *     synchronized by an rwsem.
> --

Applied as 5.19 material, thanks!
