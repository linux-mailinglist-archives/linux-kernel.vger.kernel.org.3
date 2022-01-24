Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F1D497883
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 06:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240300AbiAXF1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 00:27:01 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:54118
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239492AbiAXF05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 00:26:57 -0500
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 78F4E3FE09
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 05:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643002016;
        bh=bhp3UXAXpSdY1ysj6mir72TVcjCsn3vBfsNqUgxOt8U=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=a5O+RnQ7KW10rWSSbzsimnLoSJNptskY/qIGJ0UnnCOivp7HELLiU+RIM0dSbZVqd
         tSXiDqxwNqSu75j/dDZ96Nei4Q41RwfWkIol1xOmlsnpY4JuljLcjmUGgHrOg9wJqV
         GvQaM7o9WM7/zTI5sdji/nn0REcORpK5NV1PM3AwfN2CmE7jsLyl26KUKM7zllzTjT
         49ioBdT2i7/fWeXIhFoInhom7hvy4LxWmY2HBQ9LEljnPL8z9pzQRn115IsAMEwNjt
         sAhTmtNuZTT+SN57ixM5fs7ffuZG/nUB1aPUnzz/Uy2sULLTfTh8/Hv1ZnEChxxk4A
         q8bt/6LOXjumA==
Received: by mail-oo1-f71.google.com with SMTP id v67-20020a4a5a46000000b002c9c5da9902so4433129ooa.16
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 21:26:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bhp3UXAXpSdY1ysj6mir72TVcjCsn3vBfsNqUgxOt8U=;
        b=e1jsKB/0py8Y04UNk1Vdadtav34NZF8OgdW9phVWl8SHiaJ2FwJhOxuRRbNWChsh1F
         UrAToIQfSJPDLinxp9TCTMQIHQZiFHzoUqlAhOE1j2m6c6mvEXDTTUDnmRMfnzUDtXkB
         cViODeObOfYxbbiWLf3HvcSwHI1P2xhJVLZcKNEprcncoR0On5vdqcqqrbsMMNFkydn1
         0ujqveZt/wnS/zRhFjwMRkLLzPJDN973TUx/xtWrREKhHixqPbvRyioOLShUCVFpbhBg
         pVNWgb2u/3XjcbKSILEHJq+zWC7hgoU58C+bNZevmp0Ap99SGwvVkE9HSGM2eW1T8Zp/
         TLDw==
X-Gm-Message-State: AOAM5336EEuvMyWhZFBgQO9F8ew9BR0hcz4K5o5/aBuXAmEAfWNYqXuI
        KXwQwyvmjkLpMbCfSTUW7bWRgMxU0KXj549ZeH4lMxxbbNSKsltyU6xgTvAUiMiwy5sJwYXdRIG
        q9wjqtCWFhuVhGGMpM93uvHox0etkN+fKhEAWvYaqzt2pmbSlo7BsW75Dpw==
X-Received: by 2002:a9d:480e:: with SMTP id c14mr10598469otf.233.1643002015203;
        Sun, 23 Jan 2022 21:26:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzbMB9Ogn2srCmGe4aBnru5WNaqkjTDxbYJOH99iMeYxlBYl+KDCHWXu9v47RAE6/7G+6x93d2UxfvxklTnVo8=
X-Received: by 2002:a9d:480e:: with SMTP id c14mr10598457otf.233.1643002014902;
 Sun, 23 Jan 2022 21:26:54 -0800 (PST)
MIME-Version: 1.0
References: <20220121014039.1693208-1-kai.heng.feng@canonical.com>
 <20220121063138.1723616-1-kai.heng.feng@canonical.com> <3616f18533d34481a994d3450ecd8d85@realtek.com>
 <CAAd53p7eJFjEv8TmR+HRUFDfueQ1z_E-8beXkaUk7cMaaaWP2w@mail.gmail.com>
 <eedbb24de20d45888763625269a4a246@realtek.com> <CAAd53p7tjtV7N=5ArjNfZ3KjZVVRpiWp8AXvGcELMVgu0stn+A@mail.gmail.com>
 <a4616f9c0c924a4d8e0a15444438ef26@realtek.com>
In-Reply-To: <a4616f9c0c924a4d8e0a15444438ef26@realtek.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 24 Jan 2022 13:26:43 +0800
Message-ID: <CAAd53p4dM7K47tc1ww5jYiiiQS+7oit2_zawLKXwxiJ79P3QPA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] misc: rtsx: Rework runtime power management flow
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Yang Li <yang.lee@linux.alibaba.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 1:11 PM Ricky WU <ricky_wu@realtek.com> wrote:
>
> > -----Original Message-----
> > From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > Sent: Monday, January 24, 2022 12:54 PM
> > To: Ricky WU <ricky_wu@realtek.com>
> > Cc: arnd@arndb.de; gregkh@linuxfoundation.org; ulf.hansson@linaro.org;
> > linux-pm@vger.kernel.org; Christophe JAILLET
> > <christophe.jaillet@wanadoo.fr>; Yang Li <yang.lee@linux.alibaba.com>;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v3 2/4] misc: rtsx: Rework runtime power management
> > flow
> >
> > On Mon, Jan 24, 2022 at 11:27 AM Ricky WU <ricky_wu@realtek.com> wrote:
> > >
> > > > -----Original Message-----
> > > > From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > > Sent: Friday, January 21, 2022 8:39 PM
> > > > To: Ricky WU <ricky_wu@realtek.com>
> > > > Cc: arnd@arndb.de; gregkh@linuxfoundation.org;
> > > > ulf.hansson@linaro.org; linux-pm@vger.kernel.org; Christophe JAILLE=
T
> > > > <christophe.jaillet@wanadoo.fr>; Yang Li
> > > > <yang.lee@linux.alibaba.com>; linux-kernel@vger.kernel.org
> > > > Subject: Re: [PATCH v3 2/4] misc: rtsx: Rework runtime power
> > > > management flow
> > > >
> > > > On Fri, Jan 21, 2022 at 5:59 PM Ricky WU <ricky_wu@realtek.com> wro=
te:
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > > > > Sent: Friday, January 21, 2022 2:32 PM
> > > > > > To: arnd@arndb.de; gregkh@linuxfoundation.org;
> > > > > > ulf.hansson@linaro.org
> > > > > > Cc: linux-pm@vger.kernel.org; Kai-Heng Feng
> > > > > > <kai.heng.feng@canonical.com>; Ricky WU <ricky_wu@realtek.com>;
> > > > > > Christophe JAILLET <christophe.jaillet@wanadoo.fr>; Yang Li
> > > > > > <yang.lee@linux.alibaba.com>; linux-kernel@vger.kernel.org
> > > > > > Subject: [PATCH v3 2/4] misc: rtsx: Rework runtime power
> > > > > > management flow
> > > > > >
> > > > > > Commit 5b4258f6721f ("misc: rtsx: rts5249 support runtime PM")
> > > > > > uses "rtd3_work" and "idle_work" to manage it's own runtime PM
> > > > > > state
> > > > machine.
> > > > > >
> > > > > > When its child device, rtsx_pci_sdmmc, uses runtime PM refcount
> > > > > > correctly, all the additional works can be managed by generic
> > > > > > runtime PM
> > > > helpers.
> > > > > >
> > > > > > So consolidate "idle_work" and "rtd3_work" into generic runtime
> > > > > > idle callback and runtime suspend callback, respectively.
> > > > >
> > > > >
> > > > > Original idle_work is for aspm delay time is 200 msec, because
> > > > > Aspm can quick in and out to save more power Now this patch need
> > > > > to wait 5 sec
> > > > because set autosuspend time set to 5 sec in sdmmc,... this time
> > > > need to set to
> > > > 200 msec.
> > > >
> > > > OK, will change it to 200ms.
> > > >
> > > > >
> > > > > But it will get another question, the question is the host(sdmmc)
> > > > > caps has set MMC_CAP_AGGRESSIVE_PM when rtd3_en is set, It will
> > > > > make card power off when sdmmc go to suspend, 200 msec will cause
> > > > > card power off and on frequently
> > > > >
> > > > > Need to remove this flag in caps, and then change card power off
> > > > > to
> > > > rtsx_pci_runtime_suspend()....
> > > >
> > > > You are right, since rtsx_pci_sdmmc behaves like a virtual device o=
f
> > > > rtsx_pci, so we should let the latter handle all the PM work.
> > > > Will drop MMC_CAP_AGGRESSIVE_PM in next iteration.
> > > >
> > >
> > > We found another problem when we removed MMC_CAP_AGGRESSIVE_PM
> > We call
> > > rtsx_sd_power_off_card3v3 in rtsx_pci_runtime_suspend, we found mmc
> > > core doesn't call from CMD 0 when resume back
> >
> > Yes, MMC_CAP_AGGRESSIVE_PM needs to be kept to power on the card on
> > runtime resume.
> > Also, I don't see the frequent powering on/off issue you describe in pr=
evious
> > mail. Can you please elaborate more on the issue?
> >
>
> We think keep MMC_CAP_AGGRESSIVE_PM exist Is better for now
> Also keep the rtsx_pci_sdmmc autsuspend 5 Sec is well
> After 5 Sec idle and then power off the card we think this behavior is no=
t a problem

Thanks, I'll send next version to mailing list.

>
>
> > >
> > > > >
> > > > > What do you think?
> > > >
> > > > Thanks for your testing and review.
> > > >
> > > > One question though, regarding to the memstick virtual driver. The
> > > > memstick support was silently dropped by "misc: rtsx: Add support
> > > > for RTS5261", as RTSX_MS_CARD was removed from MFD cells.
> > > >
> > > > Is there any memstick device in the wild? If there is, we should ad=
d
> > > > it back to the MFD cells to avoid regression.
> > > > And I guess starting from rts5261, only MMC is supported?
> > > >
> > >
> > > Yes, from rts5261 only support SD...
> > > But we removed MS main result is...
> > > 1. Memstick card was disappeared about 10 year
> >
> > 10 years isn't that long.
> >
> > > 2. Our guest do not use combo socket, only use SD card socket so we
> > > removed MS event
> >
> > So we should add the memstick support back for chips other than rts5261=
.
> >
>
> We didn=E2=80=99t have guest to use combo socket (SD and MS),
> so we think support MS is unnecessary

For newer hardware, yes the support is redundant.

But what about old hardwares? Was there any memstick hardware shipped?
Maybe there are still some users?

Kai-Heng

>
> > Kai-Heng
> >
> > >
> > > Ricky
> > > >
> > > > >
> > > > > >
> > > > > > Fixes: 5b4258f6721f ("misc: rtsx: rts5249 support runtime PM")
> > > > > > Cc: Ricky WU <ricky_wu@realtek.com>
> > > > > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > > > > ---
> > > > > > v3:
> > > > > >  - Allow runtime PM for all devices, but only schedule runtime
> > suspend
> > > > > >    for devices with rtd3_en flagged.
> > > > > >
> > > > > > v2:
> > > > > >  - Remove unused idle_work and rtd3_work from rtsx_pcr.
> > > > > >
> > > > > >  drivers/misc/cardreader/rtsx_pcr.c | 118 ++++++++++-----------=
--------
> > > > > >  include/linux/rtsx_pci.h           |   3 -
> > > > > >  2 files changed, 39 insertions(+), 82 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/misc/cardreader/rtsx_pcr.c
> > > > > > b/drivers/misc/cardreader/rtsx_pcr.c
> > > > > > index 6ac509c1821c9..f919290f01192 100644
> > > > > > --- a/drivers/misc/cardreader/rtsx_pcr.c
> > > > > > +++ b/drivers/misc/cardreader/rtsx_pcr.c
> > > > > > @@ -152,20 +152,12 @@ void rtsx_pci_start_run(struct rtsx_pcr *=
pcr)
> > > > > >       if (pcr->remove_pci)
> > > > > >               return;
> > > > > >
> > > > > > -     if (pcr->rtd3_en)
> > > > > > -             if (pcr->is_runtime_suspended) {
> > > > > > -                     pm_runtime_get(&(pcr->pci->dev));
> > > > > > -                     pcr->is_runtime_suspended =3D false;
> > > > > > -             }
> > > > > > -
> > > > > >       if (pcr->state !=3D PDEV_STAT_RUN) {
> > > > > >               pcr->state =3D PDEV_STAT_RUN;
> > > > > >               if (pcr->ops->enable_auto_blink)
> > > > > >                       pcr->ops->enable_auto_blink(pcr);
> > > > > >               rtsx_pm_full_on(pcr);
> > > > > >       }
> > > > > > -
> > > > > > -     mod_delayed_work(system_wq, &pcr->idle_work,
> > > > msecs_to_jiffies(200));
> > > > > >  }
> > > > > >  EXPORT_SYMBOL_GPL(rtsx_pci_start_run);
> > > > > >
> > > > > > @@ -1094,40 +1086,6 @@ static void rtsx_pm_power_saving(struct
> > > > > > rtsx_pcr
> > > > > > *pcr)
> > > > > >       rtsx_comm_pm_power_saving(pcr);  }
> > > > > >
> > > > > > -static void rtsx_pci_rtd3_work(struct work_struct *work) -{
> > > > > > -     struct delayed_work *dwork =3D to_delayed_work(work);
> > > > > > -     struct rtsx_pcr *pcr =3D container_of(dwork, struct rtsx_=
pcr,
> > > > rtd3_work);
> > > > > > -
> > > > > > -     pcr_dbg(pcr, "--> %s\n", __func__);
> > > > > > -     if (!pcr->is_runtime_suspended)
> > > > > > -             pm_runtime_put(&(pcr->pci->dev));
> > > > > > -}
> > > > > > -
> > > > > > -static void rtsx_pci_idle_work(struct work_struct *work) -{
> > > > > > -     struct delayed_work *dwork =3D to_delayed_work(work);
> > > > > > -     struct rtsx_pcr *pcr =3D container_of(dwork, struct rtsx_=
pcr,
> > > > idle_work);
> > > > > > -
> > > > > > -     pcr_dbg(pcr, "--> %s\n", __func__);
> > > > > > -
> > > > > > -     mutex_lock(&pcr->pcr_mutex);
> > > > > > -
> > > > > > -     pcr->state =3D PDEV_STAT_IDLE;
> > > > > > -
> > > > > > -     if (pcr->ops->disable_auto_blink)
> > > > > > -             pcr->ops->disable_auto_blink(pcr);
> > > > > > -     if (pcr->ops->turn_off_led)
> > > > > > -             pcr->ops->turn_off_led(pcr);
> > > > > > -
> > > > > > -     rtsx_pm_power_saving(pcr);
> > > > > > -
> > > > > > -     mutex_unlock(&pcr->pcr_mutex);
> > > > > > -
> > > > > > -     if (pcr->rtd3_en)
> > > > > > -             mod_delayed_work(system_wq, &pcr->rtd3_work,
> > > > > > msecs_to_jiffies(10000));
> > > > > > -}
> > > > > > -
> > > > > >  static void rtsx_base_force_power_down(struct rtsx_pcr *pcr, u=
8
> > > > > > pm_state) {
> > > > > >       /* Set relink_time to 0 */ @@ -1598,7 +1556,6 @@ static
> > > > > > int rtsx_pci_probe(struct pci_dev *pcidev,
> > > > > >       pcr->card_inserted =3D 0;
> > > > > >       pcr->card_removed =3D 0;
> > > > > >       INIT_DELAYED_WORK(&pcr->carddet_work,
> > rtsx_pci_card_detect);
> > > > > > -     INIT_DELAYED_WORK(&pcr->idle_work, rtsx_pci_idle_work);
> > > > > >
> > > > > >       pcr->msi_en =3D msi_en;
> > > > > >       if (pcr->msi_en) {
> > > > > > @@ -1623,20 +1580,14 @@ static int rtsx_pci_probe(struct pci_de=
v
> > > > *pcidev,
> > > > > >               rtsx_pcr_cells[i].pdata_size =3D sizeof(*handle);
> > > > > >       }
> > > > > >
> > > > > > -     if (pcr->rtd3_en) {
> > > > > > -             INIT_DELAYED_WORK(&pcr->rtd3_work,
> > > > rtsx_pci_rtd3_work);
> > > > > > -             pm_runtime_allow(&pcidev->dev);
> > > > > > -             pm_runtime_enable(&pcidev->dev);
> > > > > > -             pcr->is_runtime_suspended =3D false;
> > > > > > -     }
> > > > > > -
> > > > > >
> > > > > >       ret =3D mfd_add_devices(&pcidev->dev, pcr->id, rtsx_pcr_c=
ells,
> > > > > >                       ARRAY_SIZE(rtsx_pcr_cells), NULL, 0,
> > NULL);
> > > > > >       if (ret < 0)
> > > > > >               goto free_slots;
> > > > > >
> > > > > > -     schedule_delayed_work(&pcr->idle_work,
> > msecs_to_jiffies(200));
> > > > > > +     pm_runtime_allow(&pcidev->dev);
> > > > > > +     pm_runtime_put(&pcidev->dev);
> > > > > >
> > > > > >       return 0;
> > > > > >
> > > > > > @@ -1668,11 +1619,11 @@ static void rtsx_pci_remove(struct
> > > > > > pci_dev
> > > > > > *pcidev)
> > > > > >       struct pcr_handle *handle =3D pci_get_drvdata(pcidev);
> > > > > >       struct rtsx_pcr *pcr =3D handle->pcr;
> > > > > >
> > > > > > -     if (pcr->rtd3_en)
> > > > > > -             pm_runtime_get_noresume(&pcr->pci->dev);
> > > > > > -
> > > > > >       pcr->remove_pci =3D true;
> > > > > >
> > > > > > +     pm_runtime_get_sync(&pcidev->dev);
> > > > > > +     pm_runtime_forbid(&pcidev->dev);
> > > > > > +
> > > > > >       /* Disable interrupts at the pcr level */
> > > > > >       spin_lock_irq(&pcr->lock);
> > > > > >       rtsx_pci_writel(pcr, RTSX_BIER, 0); @@ -1680,9 +1631,6 @@
> > > > > > static void rtsx_pci_remove(struct pci_dev *pcidev)
> > > > > >       spin_unlock_irq(&pcr->lock);
> > > > > >
> > > > > >       cancel_delayed_work_sync(&pcr->carddet_work);
> > > > > > -     cancel_delayed_work_sync(&pcr->idle_work);
> > > > > > -     if (pcr->rtd3_en)
> > > > > > -             cancel_delayed_work_sync(&pcr->rtd3_work);
> > > > > >
> > > > > >       mfd_remove_devices(&pcidev->dev);
> > > > > >
> > > > > > @@ -1700,11 +1648,6 @@ static void rtsx_pci_remove(struct
> > > > > > pci_dev
> > > > > > *pcidev)
> > > > > >       idr_remove(&rtsx_pci_idr, pcr->id);
> > > > > >       spin_unlock(&rtsx_pci_lock);
> > > > > >
> > > > > > -     if (pcr->rtd3_en) {
> > > > > > -             pm_runtime_disable(&pcr->pci->dev);
> > > > > > -             pm_runtime_put_noidle(&pcr->pci->dev);
> > > > > > -     }
> > > > > > -
> > > > > >       kfree(pcr->slots);
> > > > > >       kfree(pcr);
> > > > > >       kfree(handle);
> > > > > > @@ -1726,7 +1669,6 @@ static int __maybe_unused
> > > > > > rtsx_pci_suspend(struct device *dev_d)
> > > > > >       pcr =3D handle->pcr;
> > > > > >
> > > > > >       cancel_delayed_work(&pcr->carddet_work);
> > > > > > -     cancel_delayed_work(&pcr->idle_work);
> > > > > >
> > > > > >       mutex_lock(&pcr->pcr_mutex);
> > > > > >
> > > > > > @@ -1760,8 +1702,6 @@ static int __maybe_unused
> > > > > > rtsx_pci_resume(struct device *dev_d)
> > > > > >       if (ret)
> > > > > >               goto out;
> > > > > >
> > > > > > -     schedule_delayed_work(&pcr->idle_work,
> > msecs_to_jiffies(200));
> > > > > > -
> > > > > >  out:
> > > > > >       mutex_unlock(&pcr->pcr_mutex);
> > > > > >       return ret;
> > > > > > @@ -1786,6 +1726,33 @@ static void rtsx_pci_shutdown(struct
> > > > > > pci_dev
> > > > > > *pcidev)
> > > > > >               pci_disable_msi(pcr->pci);  }
> > > > > >
> > > > > > +static int rtsx_pci_runtime_idle(struct device *device) {
> > > > > > +     struct pci_dev *pcidev =3D to_pci_dev(device);
> > > > > > +     struct pcr_handle *handle =3D pci_get_drvdata(pcidev);
> > > > > > +     struct rtsx_pcr *pcr =3D handle->pcr;
> > > > > > +
> > > > > > +     dev_dbg(device, "--> %s\n", __func__);
> > > > > > +
> > > > > > +     mutex_lock(&pcr->pcr_mutex);
> > > > > > +
> > > > > > +     pcr->state =3D PDEV_STAT_IDLE;
> > > > > > +
> > > > > > +     if (pcr->ops->disable_auto_blink)
> > > > > > +             pcr->ops->disable_auto_blink(pcr);
> > > > > > +     if (pcr->ops->turn_off_led)
> > > > > > +             pcr->ops->turn_off_led(pcr);
> > > > > > +
> > > > > > +     rtsx_pm_power_saving(pcr);
> > > > > > +
> > > > > > +     mutex_unlock(&pcr->pcr_mutex);
> > > > > > +
> > > > > > +     if (pcr->rtd3_en)
> > > > > > +             pm_schedule_suspend(device, 5000);
> > > > > > +
> > > > > > +     return -EBUSY;
> > > > > > +}
> > > > > > +
> > > > > >  static int rtsx_pci_runtime_suspend(struct device *device)  {
> > > > > >       struct pci_dev *pcidev =3D to_pci_dev(device); @@ -1794,3=
1
> > > > > > +1761,26 @@ static int rtsx_pci_runtime_suspend(struct device
> > > > > > *device)
> > > > > >
> > > > > >       handle =3D pci_get_drvdata(pcidev);
> > > > > >       pcr =3D handle->pcr;
> > > > > > -     dev_dbg(&(pcidev->dev), "--> %s\n", __func__);
> > > > > >
> > > > > > -     cancel_delayed_work(&pcr->carddet_work);
> > > > > > -     cancel_delayed_work(&pcr->rtd3_work);
> > > > > > -     cancel_delayed_work(&pcr->idle_work);
> > > > > > +     dev_dbg(device, "--> %s\n", __func__);
> > > > > > +
> > > > > > +     cancel_delayed_work_sync(&pcr->carddet_work);
> > > > > >
> > > > > >       mutex_lock(&pcr->pcr_mutex);
> > > > > >       rtsx_pci_power_off(pcr, HOST_ENTER_S3);
> > > > > >
> > > > > >       mutex_unlock(&pcr->pcr_mutex);
> > > > > >
> > > > > > -     pcr->is_runtime_suspended =3D true;
> > > > > > -
> > > > > >       return 0;
> > > > > >  }
> > > > > >
> > > > > >  static int rtsx_pci_runtime_resume(struct device *device)  {
> > > > > >       struct pci_dev *pcidev =3D to_pci_dev(device);
> > > > > > -     struct pcr_handle *handle;
> > > > > > -     struct rtsx_pcr *pcr;
> > > > > > +     struct pcr_handle *handle =3D pci_get_drvdata(pcidev);
> > > > > > +     struct rtsx_pcr *pcr =3D handle->pcr;
> > > > > >
> > > > > > -     handle =3D pci_get_drvdata(pcidev);
> > > > > > -     pcr =3D handle->pcr;
> > > > > > -     dev_dbg(&(pcidev->dev), "--> %s\n", __func__);
> > > > > > +     dev_dbg(device, "--> %s\n", __func__);
> > > > > >
> > > > > >       mutex_lock(&pcr->pcr_mutex);
> > > > > >
> > > > > > @@ -1834,8 +1796,6 @@ static int rtsx_pci_runtime_resume(struct
> > > > > > device
> > > > > > *device)
> > > > > >
> > pcr->slots[RTSX_SD_CARD].p_dev);
> > > > > >       }
> > > > > >
> > > > > > -     schedule_delayed_work(&pcr->idle_work,
> > msecs_to_jiffies(200));
> > > > > > -
> > > > > >       mutex_unlock(&pcr->pcr_mutex);
> > > > > >       return 0;
> > > > > >  }
> > > > > > @@ -1850,7 +1810,7 @@ static int rtsx_pci_runtime_resume(struct
> > > > > > device
> > > > > > *device)
> > > > > >
> > > > > >  static const struct dev_pm_ops rtsx_pci_pm_ops =3D {
> > > > > >       SET_SYSTEM_SLEEP_PM_OPS(rtsx_pci_suspend,
> > rtsx_pci_resume)
> > > > > > -     SET_RUNTIME_PM_OPS(rtsx_pci_runtime_suspend,
> > > > > > rtsx_pci_runtime_resume, NULL)
> > > > > > +     SET_RUNTIME_PM_OPS(rtsx_pci_runtime_suspend,
> > > > > > rtsx_pci_runtime_resume,
> > > > > > +rtsx_pci_runtime_idle)
> > > > > >  };
> > > > > >
> > > > > >  static struct pci_driver rtsx_pci_driver =3D { diff --git
> > > > > > a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h index
> > > > > > 4ab7bfc675f11..89b7d34e25b63 100644
> > > > > > --- a/include/linux/rtsx_pci.h
> > > > > > +++ b/include/linux/rtsx_pci.h
> > > > > > @@ -1201,8 +1201,6 @@ struct rtsx_pcr {
> > > > > >       unsigned int                    card_exist;
> > > > > >
> > > > > >       struct delayed_work             carddet_work;
> > > > > > -     struct delayed_work             idle_work;
> > > > > > -     struct delayed_work             rtd3_work;
> > > > > >
> > > > > >       spinlock_t                      lock;
> > > > > >       struct mutex                    pcr_mutex;
> > > > > > @@ -1212,7 +1210,6 @@ struct rtsx_pcr {
> > > > > >       unsigned int                    cur_clock;
> > > > > >       bool                            remove_pci;
> > > > > >       bool                            msi_en;
> > > > > > -     bool                            is_runtime_suspended;
> > > > > >
> > > > > >  #define EXTRA_CAPS_SD_SDR50          (1 << 0)
> > > > > >  #define EXTRA_CAPS_SD_SDR104         (1 << 1)
> > > > > > --
> > > > > > 2.33.1
> > > > >
> > > > ------Please consider the environment before printing this e-mail.
