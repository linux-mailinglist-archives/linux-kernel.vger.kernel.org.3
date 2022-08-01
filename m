Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC985862E0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 04:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239444AbiHAC6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 22:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238241AbiHAC6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 22:58:42 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964FCDEFC;
        Sun, 31 Jul 2022 19:58:41 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bq11so10184777lfb.5;
        Sun, 31 Jul 2022 19:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=4PUW35Z98Oz3GKgcOUm+Y7kv0FX17sX3vwCDCp2HW74=;
        b=XiXlx6p8Um99lzIHizjEqBOBY3WY5XMxC2b6+HjzF4cozzUWdTyzmK2AHSD6K6S+7I
         0047Tv6qHYK2KCJ1a8ke1ALewQ/Rv/scuGG4b4gxCzzdKjx8MP3akB0coQg/gerxqmzU
         OSC8e5CEbR1NxTUNFFhmKvnxBoG+kMBpZwDapX0Jr6TGriN5GGRa2p7ShQcL+8EPjrOx
         LmJNQDmFQ8iomSKarCsys/XZqZOXUwRvXxfeLISBVZrmLNi1bzS5iDOyzAlAOu7gZtPE
         1oJTkThe0sWsLoUA1fjeCt4d9C0eR5gtfQuLAMl7SlkvnSBV+gvnPeXlFjqKm9PGwT3R
         VKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=4PUW35Z98Oz3GKgcOUm+Y7kv0FX17sX3vwCDCp2HW74=;
        b=6ipEtFxtHLjsuLasq4wGqIRPVTFoHTc54yr7vcuQbrybzs7xlVexcOuW1KdNv4/iuj
         9RR4RK8mLT3DrO/0V0kloEvHLjDzpveJqH66WQALvOqL4o2oVgYW6EWfDomZXaH7TaJs
         GIb+mLKMFl2/Ddl/jZ28KTHLEg+yTbllEANH2Ae8hJKat5TSpYt16Ot5RogrB3/xUrOW
         quh96BA0KroI7t9LgDpJZ35rkyoWTHa+zl8Zgte17r94dNm8yNHqXxdLrkDBqoMuADk3
         iR0pScgKCSKvn1JKO6Dt0/jcyj10MExe8kZf4bjM0d29LLGafuvYgOOfotuW/aLykjGd
         7CZQ==
X-Gm-Message-State: AJIora9/E9KPUkYIAfMB25wlF9qxK7qGEppI6T/XLZDtw/huuwB9GGBC
        20xp52OcwKa0xFzNuR7WI7bGtwlCvwpURBJkdrk=
X-Google-Smtp-Source: AGRyM1uc8D+MSD46tu2Un7YpdehzU3bq/0FFaNSuxHlDhg0Je/WlITUI5E/e59ZGLRo0vmXUJ+RGnzaDdEIGpaXgnKk=
X-Received: by 2002:a05:6512:1319:b0:482:b8ce:a278 with SMTP id
 x25-20020a056512131900b00482b8cea278mr5121005lfu.8.1659322719820; Sun, 31 Jul
 2022 19:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220725030605.1808710-1-klimov.linux@gmail.com>
 <573466e4-e836-d053-d1b9-dc04c6a046e5@roeck-us.net> <CALW4P+JjO5zxEP4aLGzzcvK2QO0Ea_uYACjuOV6GZEMfh3Q5RA@mail.gmail.com>
 <20220726032425.GA1331080@roeck-us.net>
In-Reply-To: <20220726032425.GA1331080@roeck-us.net>
From:   Alexey Klimov <klimov.linux@gmail.com>
Date:   Mon, 1 Aug 2022 03:58:28 +0100
Message-ID: <CALW4P+LmMJAm=3PWQfiEgYS7d_q0M0rdSJVhpZw9x9w3fQQMRA@mail.gmail.com>
Subject: Re: [PATCH v5] watchdog: add driver for StreamLabs USB watchdog device
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Oliver Neukum <oneukum@suse.com>, linux-watchdog@vger.kernel.org,
        wim@linux-watchdog.org, USB list <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        atishp@rivosinc.com, atishp@atishpatra.org,
        Yury Norov <yury.norov@gmail.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Aaron Tomlin <atomlin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 4:24 AM Guenter Roeck <linux@roeck-us.net> wrote:
>

[...]

> > > > +
> > > > +     streamlabs_wdt->intf = intf;
> > > > +     usb_set_intfdata(intf, &streamlabs_wdt->wdt_dev);
> > > > +     watchdog_set_drvdata(&streamlabs_wdt->wdt_dev, streamlabs_wdt);
> > > > +     watchdog_set_nowayout(&streamlabs_wdt->wdt_dev, nowayout);
> > > > +
> > > > +     retval = usb_streamlabs_wdt_stop(&streamlabs_wdt->wdt_dev);
> > > > +     if (retval)
> > > > +             return -ENODEV;
> > > > +
> > >
> > > A comment explaining why the watchdog is explicitly stopped when running
> > > might be useful.
> >
> > What do you mean by saying "when running"?
> > Everytime during my testing the initial state is "stopped" on
> > boot/power on/after reset, so not sure what you mean by saying "when
> > running".
>
> Should I have used the term "active" ? "started" ?
>
> > There is a comment above that explains the stop command but I will
> > add/change comments that explain things better.
> > The point of executing "stop" command here is to check that device
> > being probed behaves like we expect it to. This is a bit paranoid
> > check since I am a not 100% sure that all devices with such USB ids
> > are watchdogs -- that's why additional checks for usbdev->product and
> > usbdev->manufacturer and this stop command that doesn't change the
> > initial state. In theory, I can remove this stop command at all.
> >
>
> Normally one does not want a watchdog to stop if it is running (started ?
> active ? pick your term) when the device is instantiated to avoid gaps
> in watchdog coverage. The watchdog core provides a flag, WDOG_HW_RUNNING,
> for this purpose (sorry, there is the 'running' term again). It is used
> by many drivers, and ensures that the time from loading the Linux kernel
> to opening the watchdog device is protected by the watchdog.
>
> Calling the stop function during probe suggests that you at least
> considered the possibility that the watchdog may be running/started/active.
> Per your explanation, you still want it to stop explicitly if/when that
> happens.  All I am asking you is to add a comment explaining why this is
> not needed/wanted/relevant/supported for this driver. One explanation
> might, for example, be that the state can not be detected reliably.

Thanks for the explanation. I was confused initially by the phrase
"explicitly stopped when running" since in reality it is "explicitly
stopped when stopped" (or not active, not running).
On the second thought, I can issue a start command and indicate to the
watchdog core via set_bit(WDOG_HW_RUNNING, &wdd->status) that it is
running or return -ENODEV if the start fails instead of stopping the
watchdog. I just would like to have a command sent to the device in
->probe() that checks that the device behaves like expected. If there
are no objects I'll change it like this.

Best regards,
Alexey
