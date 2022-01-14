Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13B448E9B4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 13:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235551AbiANMKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 07:10:48 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:33120
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235042AbiANMJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 07:09:42 -0500
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C66C93F1AF
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 12:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642162171;
        bh=nx2SfehiFhMJ49inCJOjqiXDfOhn3s9YnvwXH3Vtd2w=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Hib9Ny+4t1k1+FlZ3Hy3ogJP6B4AzvxQkXWqD1zJHV9QBRl1O6MYakRFTBK29fxio
         0AwVIKf1vE72c8Ct59C+KkTbUNFZphcu2HjqxDHr+gBdShzHk45AuyMReGIPvYXbN0
         Zt5tDq8fcGfKwWU+tTShKrLUavSGnmZQvpiaLvnKDY6glEHvk+VlOCM938h1D1TjTd
         SfRKvwkEIxqr+3F5vbNeNsAuexWwAYI5C9Hwgf/CBoGkWrZOgRh+52gkUsBxDAFH72
         PAVEi62d6UQBQdUnF0+4jy+4vcKpsf0RM9xJRQmdz/6FHPcdvppYWlN6Y0v89yb/ib
         bL8WncxrqB/wg==
Received: by mail-oi1-f198.google.com with SMTP id d205-20020aca36d6000000b002c890f38d80so5944432oia.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 04:09:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nx2SfehiFhMJ49inCJOjqiXDfOhn3s9YnvwXH3Vtd2w=;
        b=608nJ88mB/+U0Km7xMXSR31CRDHk6FPtUtLba5J6BeTeo0z+Asx0dbwJs6eFacQ7HU
         82wV1eTxNFBprb/MrOabr3WoAp5DvUkhnWsb0ywpPCMvevXdFnuxZlN9ZqIbzWqNy0rp
         bPiXtW2C/yhEE7Zr2Jg4sQ80SBrI/q6E3h12KHneSbDCCtNJltnCmGc625PIG2kf/lli
         hHEjZ0By6N9EoHyn/qqJ+MJ5+jF+yVUYoF8aFX7A00XLbQRPIx/vVMvHrrAQOqSrUMJQ
         DixAPTY1R6kKuBXyrGZthoBPs+OUnciIUNjnLYWciOMGL6J19P3KFcVCrKbavaLfmVDw
         GAOQ==
X-Gm-Message-State: AOAM530WoBKvK62VaclLQYseM/ZFh9tST8LE8rBajjL+9BhQgInl0Yfq
        BjNlB3iyBUQV6KDswPJgfWCoMarBGtbV13HYTgMOIhldSD7hfdtcolGtRzukrWwNgDhkKgCD6/5
        7j2qRKKPwhkMiwqpUnQg1dqzARUy/rOjL/LUkB2IyA8ogeATEw0BGWWnZug==
X-Received: by 2002:a05:6808:1985:: with SMTP id bj5mr561675oib.146.1642162170321;
        Fri, 14 Jan 2022 04:09:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZ+rPPNfojPvMV2jHkMma3Pd6xc/dAmc+h10RLGhKH1owN7VstHwwAOJRELP29v3fiXfRhMheSDLbOCXPDC4c=
X-Received: by 2002:a05:6808:1985:: with SMTP id bj5mr561646oib.146.1642162169760;
 Fri, 14 Jan 2022 04:09:29 -0800 (PST)
MIME-Version: 1.0
References: <c4525b4738f94483b9b8f8571fc80646@realtek.com> <CAAd53p6gzZVNov0L-abZ_N=FoD-JpfWp2W096SrVva=FfEv=aw@mail.gmail.com>
 <3bae27438b4b4d1eb367baefa7898060@realtek.com> <CAAd53p6GFqMbp-xMDf0qufxfpb8wes8S8VVdghZnNdV5Mr4s7w@mail.gmail.com>
 <ccb30393c86e42f489c2d7445e3534a9@realtek.com>
In-Reply-To: <ccb30393c86e42f489c2d7445e3534a9@realtek.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 14 Jan 2022 20:09:18 +0800
Message-ID: <CAAd53p7nHqaKcZx7+asZz5k2jRJK-nJeCM21Nhvw6AeVE3=Qpw@mail.gmail.com>
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

On Fri, Jan 14, 2022 at 4:51 PM Ricky WU <ricky_wu@realtek.com> wrote:
[snip]
> > >
> > > We don=E2=80=99t want to entry D3 frequently
> > > So we need to call pm_runtime_get() at start And call pm_runtime_put(=
)
> > > in delay-work (rtd3_work)
> >
> > Maybe use 'cancel_delayed_work(&pcr->rtd3_work)' like what
> > rtsx_pci_runtime_suspend() does?
> > And for this case maybe cancel_delayed_work_sync() is more preferred.
> >
>
> I think you misunderstand what I means
> This delay_work() is for not enter D3 <-> D0 frequently

This is doable with current pm_runtime_*() helpers.

> That delay is we need, we don=E2=80=99t want to power_on and power_off fr=
equently on our device

Is this to avoid the pm_runtime_resume() call before system suspend?
IOW, to avoid D3 -> D0 -> D3 for S3?

>
> This patch want to solve pcr->is_runtime_suspended this value
> because we need to set more register at power_down flow when Device suppo=
rt D3 and System going to S3

So is it possible to introduce a new parameter for force_power_down()
and get rid of is_runtime_suspended completely?

>
> > >
> > > But we found If we keep this if statement in start_run if
> > > (pcr->is_runtime_suspended) {
> > >   pm_runtime_get(&(pcr->pci->dev));
> > >   pcr->is_runtime_suspended =3D false;
> > > }
> > > pcr->is_runtime_suspended this status are not correct when enter S3
> > > because enter S3 not call start_run()
> >
> > Maybe because the driver is trying to trick the runtime PM core on its =
real
> > power status?
> > I.e. the driver is maintaining its own PM state machine. Fully cooperat=
ing the
> > driver with PM core should solve the issue.
> >
>
> System not call start_run() because do not have any sd_request at that ti=
me,
> so we need to update value(pcr->is_runtime_suspended) at rtsx_pci_runtime=
_resume
> but if we only update value here not to call pm_runtime_get(), the if-sta=
tement always be FALSE at start_run()

Sounds like the RPM refcount goes to zero so it was runtime suspended again=
.
The correct usage should be merging rtsx_pci_start_run() with
rtsx_pci_runtime_resume(), then guard each op of mmc_host_ops with
pm_runtime_get_sync() at the beginning and pm_runtime_idle() at and
end of each ops.

Increase the RPM refcount in runtime resume routine to prevent the
driver from suspending doesn't really make sense to me.

Kai-Heng

> that is why we move this if-statement from start_run() to rtsx_pci_runtim=
e_resume()
>
> > > >
> > > > > +
> > > > >         mutex_lock(&pcr->pcr_mutex);
> > > > >
> > > > >         rtsx_pci_write_register(pcr, HOST_SLEEP_STATE, 0x03,
> > > > > 0x00); diff --git a/drivers/misc/cardreader/rtsx_pcr.h
> > > > > b/drivers/misc/cardreader/rtsx_pcr.h
> > > > > index daf057c4eea6..b93975268e6d 100644
> > > > > --- a/drivers/misc/cardreader/rtsx_pcr.h
> > > > > +++ b/drivers/misc/cardreader/rtsx_pcr.h
> > > > > @@ -25,6 +25,7 @@
> > > > >  #define REG_EFUSE_POWEROFF             0x00
> > > > >  #define RTS5250_CLK_CFG3               0xFF79
> > > > >  #define RTS525A_CFG_MEM_PD             0xF0
> > > > > +#define RTS524A_AUTOLOAD_CFG1  0xFF7C
> > > > >  #define RTS524A_PM_CTRL3               0xFF7E
> > > > >  #define RTS525A_BIOS_CFG               0xFF2D
> > > > >  #define RTS525A_LOAD_BIOS_FLAG 0x01
> > > > > --
> > > > > 2.25.1
> > > > ------Please consider the environment before printing this e-mail.
