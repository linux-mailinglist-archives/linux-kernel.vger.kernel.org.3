Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238E449010A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 06:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbiAQFLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 00:11:30 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:58466
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231854AbiAQFL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 00:11:28 -0500
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AD2B93F1C7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 05:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642396286;
        bh=CaDvYb2u0IuPfJsT3Lvs2F9uIf6IDyFmwlObOSMc36M=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=RAuwgmHSHjv59wEtOzEE28gm5GsQu9DMauByBrY6tBZox8QhjhF90CmWe8Mf6J98z
         6lGMD4TYtn4Vxc7oFY1RgNBvnXUpWqH0HFjgBKkHLM8nCSfQgnspwLDzDUTJrIyaPe
         DUuiP1fXwtYmfZFzWq7v8z0wFAGcrlPsNAQTxrt2nP0tmg29VdzqPNMl+q/7gObZ+F
         vNxd/QsH3OVeqb8d/Go/WEXyPXvCQ8WPThL4T/Hg24ViQXkwGL06zF9WFb93BWAsDZ
         U3tZPyuKBzCzqYhumIPuP95DWSflDmowqBIyeAPU2QXL++8MyF1NP6FVvi0r3M9qzN
         VFd1p/hOjydQw==
Received: by mail-ot1-f71.google.com with SMTP id v21-20020a05683018d500b00590a3479c4eso5338787ote.11
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 21:11:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CaDvYb2u0IuPfJsT3Lvs2F9uIf6IDyFmwlObOSMc36M=;
        b=2sMDJE3wdO1C5CZVVZxQT86cBEmF66530EkexYwiAT+/2X0PZ+stavSsI4l+iJn/QF
         Sj92d5n1y7hQf7d+XIQBzV5YwnnDyltll0x49mGXNhJxzIp3Q0r1D4Q54QulWv/QnPxo
         02dL8a9PI7acPSsNgbI5+R0S7rnUexpUS5UW+vbi/mMfzOpo0N8lLO6tnBxALXcqmzEh
         WjQyqE+6aKC50XZtbWs1KFh0k+/5V5GD3tV0iPRy0jtvHf3MvN5J4+Eat3tOKmfOCNV8
         tKHwq7rRoMW55OwSl+r0TZuSzVLFGkyxMjvBypw0NE7BY+c/Rzfyo7MjRSWSbH8GufwP
         M5CQ==
X-Gm-Message-State: AOAM530VVSDOlUxJroD6FcXOqNAQ7nviFpuvc0+6jifgfvcizWAPVQSM
        Bz0AnlTBAfhxfmhZ4QeT6fvAntwgrX89E+JcVjHR24GNTENZTfMEMyHhOpJ/FQkithRL1Gkhgep
        VY8QQdtL5U3U0czrIU3t06hr7ZKpuUylagoxaI5fE3u3aeermf1B1vAHsdg==
X-Received: by 2002:a9d:6f0e:: with SMTP id n14mr924273otq.269.1642396285462;
        Sun, 16 Jan 2022 21:11:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJysDaTJNJhxRYfCwlHLSjq8OZ4ngsUmA//ZU9jwG5jw05tk8fjmB/c/m33CCCjbt6hgTIDWYaXeYJD/G66Pda4=
X-Received: by 2002:a9d:6f0e:: with SMTP id n14mr924250otq.269.1642396285162;
 Sun, 16 Jan 2022 21:11:25 -0800 (PST)
MIME-Version: 1.0
References: <c4525b4738f94483b9b8f8571fc80646@realtek.com> <CAAd53p6gzZVNov0L-abZ_N=FoD-JpfWp2W096SrVva=FfEv=aw@mail.gmail.com>
 <3bae27438b4b4d1eb367baefa7898060@realtek.com> <CAAd53p6GFqMbp-xMDf0qufxfpb8wes8S8VVdghZnNdV5Mr4s7w@mail.gmail.com>
 <ccb30393c86e42f489c2d7445e3534a9@realtek.com> <CAAd53p7nHqaKcZx7+asZz5k2jRJK-nJeCM21Nhvw6AeVE3=Qpw@mail.gmail.com>
 <443ba7631c234a73822990fc8bf5fee5@realtek.com>
In-Reply-To: <443ba7631c234a73822990fc8bf5fee5@realtek.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 17 Jan 2022 13:11:13 +0800
Message-ID: <CAAd53p4xkWKe4DPhzNep93QZGa4VzkEz9hdnd6=r0jnC6KBe8g@mail.gmail.com>
Subject: Re: [PATCH] misc: rtsx: modify rtd3 flow
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "yang.lee@linux.alibaba.com" <yang.lee@linux.alibaba.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 11:34 AM Ricky WU <ricky_wu@realtek.com> wrote:
>
> > -----Original Message-----
> > From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > Sent: Friday, January 14, 2022 8:09 PM
> > To: Ricky WU <ricky_wu@realtek.com>
> > Cc: arnd@arndb.de; gregkh@linuxfoundation.org;
> > christophe.jaillet@wanadoo.fr; yang.lee@linux.alibaba.com;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] misc: rtsx: modify rtd3 flow
> >
> > On Fri, Jan 14, 2022 at 4:51 PM Ricky WU <ricky_wu@realtek.com> wrote:
> > [snip]
> > > > >
> > > > > We don=E2=80=99t want to entry D3 frequently So we need to call
> > > > > pm_runtime_get() at start And call pm_runtime_put() in delay-work
> > > > > (rtd3_work)
> > > >
> > > > Maybe use 'cancel_delayed_work(&pcr->rtd3_work)' like what
> > > > rtsx_pci_runtime_suspend() does?
> > > > And for this case maybe cancel_delayed_work_sync() is more preferre=
d.
> > > >
> > >
> > > I think you misunderstand what I means This delay_work() is for not
> > > enter D3 <-> D0 frequently
> >
> > This is doable with current pm_runtime_*() helpers.
> >
> > > That delay is we need, we don=E2=80=99t want to power_on and power_of=
f
> > > frequently on our device
> >
> > Is this to avoid the pm_runtime_resume() call before system suspend?
> > IOW, to avoid D3 -> D0 -> D3 for S3?
> >
>
> No, this only for make sure our device D0 -> D3 at least 10 sec, this onl=
y about device status
> not affect System suspend (S3)
> You can see the current code rtsx_pci_idle_work(struct work_struct *work)
>
> System suspend (S3) flow is different it will call rtsx_pci_suspend()
>
> > >
> > > This patch want to solve pcr->is_runtime_suspended this value because
> > > we need to set more register at power_down flow when Device support D=
3
> > > and System going to S3
> >
> > So is it possible to introduce a new parameter for force_power_down() a=
nd get
> > rid of is_runtime_suspended completely?
> >
>
> This just distinguish 524a, 525a go to the new power down flow
> Add more register setting for RTD3 enable
>
> > >
> > > > >
> > > > > But we found If we keep this if statement in start_run if
> > > > > (pcr->is_runtime_suspended) {
> > > > >   pm_runtime_get(&(pcr->pci->dev));
> > > > >   pcr->is_runtime_suspended =3D false; }
> > > > > pcr->is_runtime_suspended this status are not correct when enter
> > > > > pcr->S3
> > > > > because enter S3 not call start_run()
> > > >
> > > > Maybe because the driver is trying to trick the runtime PM core on
> > > > its real power status?
> > > > I.e. the driver is maintaining its own PM state machine. Fully
> > > > cooperating the driver with PM core should solve the issue.
> > > >
> > >
> > > System not call start_run() because do not have any sd_request at tha=
t
> > > time, so we need to update value(pcr->is_runtime_suspended) at
> > > rtsx_pci_runtime_resume but if we only update value here not to call
> > > pm_runtime_get(), the if-statement always be FALSE at start_run()
> >
> > Sounds like the RPM refcount goes to zero so it was runtime suspended a=
gain.
> > The correct usage should be merging rtsx_pci_start_run() with
> > rtsx_pci_runtime_resume(), then guard each op of mmc_host_ops with
> > pm_runtime_get_sync() at the beginning and pm_runtime_idle() at and end=
 of
> > each ops.
> >
> > Increase the RPM refcount in runtime resume routine to prevent the driv=
er
> > from suspending doesn't really make sense to me.
> >
> > Kai-Heng
>
>
> We want to control the interval time between D0->D3
> This is for good user experience and more stable for our device.
> And this completely unaffected System suspend, because System want to ent=
er S3
> need to make sure Device back to D0 and then go to S3 and put Device to D=
3 if Device support D3

Everything can become easier to incorporate the state machine to
pm_runtime_*() helpers directly.
Let me work on a patch to achieve it.

Kai-Heng

>
>
> >
> > > that is why we move this if-statement from start_run() to
> > > rtsx_pci_runtime_resume()
> > >
> > > > > >
> > > > > > > +
> > > > > > >         mutex_lock(&pcr->pcr_mutex);
> > > > > > >
> > > > > > >         rtsx_pci_write_register(pcr, HOST_SLEEP_STATE, 0x03,
> > > > > > > 0x00); diff --git a/drivers/misc/cardreader/rtsx_pcr.h
> > > > > > > b/drivers/misc/cardreader/rtsx_pcr.h
> > > > > > > index daf057c4eea6..b93975268e6d 100644
> > > > > > > --- a/drivers/misc/cardreader/rtsx_pcr.h
> > > > > > > +++ b/drivers/misc/cardreader/rtsx_pcr.h
> > > > > > > @@ -25,6 +25,7 @@
> > > > > > >  #define REG_EFUSE_POWEROFF             0x00
> > > > > > >  #define RTS5250_CLK_CFG3               0xFF79
> > > > > > >  #define RTS525A_CFG_MEM_PD             0xF0
> > > > > > > +#define RTS524A_AUTOLOAD_CFG1  0xFF7C
> > > > > > >  #define RTS524A_PM_CTRL3               0xFF7E
> > > > > > >  #define RTS525A_BIOS_CFG               0xFF2D
> > > > > > >  #define RTS525A_LOAD_BIOS_FLAG 0x01
> > > > > > > --
> > > > > > > 2.25.1
> > > > > > ------Please consider the environment before printing this e-ma=
il.
