Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74CE53D1EF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 20:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239425AbiFCSyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 14:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347797AbiFCSyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 14:54:44 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D787289B6;
        Fri,  3 Jun 2022 11:54:43 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id w2so15280118ybi.7;
        Fri, 03 Jun 2022 11:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lsii2M/Z+BjHQ59FvjJ8av50zu7xha2i5JDwxAF3srs=;
        b=t8bCVTdhcprieEQdJqIg2y/nndA5I93jpd4sgMYDrpi0xnbz68kQ3f22fOUNCihCS4
         bsBKSnzsY8N9oXEFh56UMQHiB403GhHct9GUtes7r9myu57fujIyFdO3aHdyd5jzoWxR
         hJ27eomJTdKNWG7nplj85e+z4kiH7lcxLWeipm/bVVWtBMZYPr7/+Df3q+QJEpx/L4DF
         MP51hrfN/0b4cqaqzXDELAoOk15lxsxCqqc73i3QQLV6BXzxUQUYMYj/ELFf6BPNSOAL
         1jPhgv/1VR3v3D02ZqXl8pzecLeydTsk9/cf9OqT0PGhLUtxrh8t5ipzF30dS4Q8tDk3
         BTNw==
X-Gm-Message-State: AOAM530U3en2oYbr2wPTkRgzun5OUUbFwQyVn/a1yTPXs3Q9JkoOrz8M
        8W0OMU1ItXFDMOMqIpIKRy7aL69BDbsUdrTKQgg=
X-Google-Smtp-Source: ABdhPJxB4pVovVskOU85j4HEBytnIdMzJtv/l+nGCWtbsux7xavEE6caGgyM1Qro50zwzIcWaOennN+kqEZC0EQP+vo=
X-Received: by 2002:a25:2004:0:b0:650:740:f31d with SMTP id
 g4-20020a252004000000b006500740f31dmr12046953ybg.81.1654282482815; Fri, 03
 Jun 2022 11:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <YpnwZ/Q5yTKRDBOD@kroah.com> <20220603113138.2689444-1-gregkh@linuxfoundation.org>
In-Reply-To: <20220603113138.2689444-1-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 3 Jun 2022 20:54:31 +0200
Message-ID: <CAJZ5v0hJ_uPakb8s8v4VJw86ShsN8Y0Hnk2NZ4ta7GKGQeW8pg@mail.gmail.com>
Subject: Re: [PATCH 1/2] driver core: Fix wait_for_device_probe() &
 deferred_probe_timeout interaction
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>,
        John Stultz <jstultz@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Basil Eljuse <Basil.Eljuse@arm.com>,
        Ferry Toth <fntoth@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 3, 2022 at 1:32 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> From: Saravana Kannan <saravanak@google.com>
>
> Mounting NFS rootfs was timing out when deferred_probe_timeout was
> non-zero [1].  This was because ip_auto_config() initcall times out
> waiting for the network interfaces to show up when
> deferred_probe_timeout was non-zero. While ip_auto_config() calls
> wait_for_device_probe() to make sure any currently running deferred
> probe work or asynchronous probe finishes, that wasn't sufficient to
> account for devices being deferred until deferred_probe_timeout.
>
> Commit 35a672363ab3 ("driver core: Ensure wait_for_device_probe() waits
> until the deferred_probe_timeout fires") tried to fix that by making
> sure wait_for_device_probe() waits for deferred_probe_timeout to expire
> before returning.
>
> However, if wait_for_device_probe() is called from the kernel_init()
> context:
>
> - Before deferred_probe_initcall() [2], it causes the boot process to
>   hang due to a deadlock.
>
> - After deferred_probe_initcall() [3], it blocks kernel_init() from
>   continuing till deferred_probe_timeout expires and beats the point of
>   deferred_probe_timeout that's trying to wait for userspace to load
>   modules.
>
> Neither of this is good. So revert the changes to
> wait_for_device_probe().
>
> [1] - https://lore.kernel.org/lkml/TYAPR01MB45443DF63B9EF29054F7C41FD8C60@TYAPR01MB4544.jpnprd01.prod.outlook.com/
> [2] - https://lore.kernel.org/lkml/YowHNo4sBjr9ijZr@dev-arch.thelio-3990X/
> [3] - https://lore.kernel.org/lkml/Yo3WvGnNk3LvLb7R@linutronix.de/
>
> Fixes: 35a672363ab3 ("driver core: Ensure wait_for_device_probe() waits until the deferred_probe_timeout fires")
> Cc: John Stultz <jstultz@google.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
> Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: Basil Eljuse <Basil.Eljuse@arm.com>
> Cc: Ferry Toth <fntoth@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Anders Roxell <anders.roxell@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: John Stultz <jstultz@google.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Link: https://lore.kernel.org/r/20220526034609.480766-2-saravanak@google.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/dd.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 2fc8507f59ee..91f63cd33b12 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -263,7 +263,6 @@ int driver_deferred_probe_timeout;
>  #endif
>
>  EXPORT_SYMBOL_GPL(driver_deferred_probe_timeout);
> -static DECLARE_WAIT_QUEUE_HEAD(probe_timeout_waitqueue);
>
>  static int __init deferred_probe_timeout_setup(char *str)
>  {
> @@ -318,7 +317,6 @@ static void deferred_probe_timeout_work_func(struct work_struct *work)
>         list_for_each_entry(p, &deferred_probe_pending_list, deferred_probe)
>                 dev_info(p->device, "deferred probe pending\n");
>         mutex_unlock(&deferred_probe_mutex);
> -       wake_up_all(&probe_timeout_waitqueue);
>  }
>  static DECLARE_DELAYED_WORK(deferred_probe_timeout_work, deferred_probe_timeout_work_func);
>
> @@ -736,9 +734,6 @@ int driver_probe_done(void)
>   */
>  void wait_for_device_probe(void)
>  {
> -       /* wait for probe timeout */
> -       wait_event(probe_timeout_waitqueue, !driver_deferred_probe_timeout);
> -
>         /* wait for the deferred probe workqueue to finish */
>         flush_work(&deferred_probe_work);
>
> --
> 2.36.1
>
