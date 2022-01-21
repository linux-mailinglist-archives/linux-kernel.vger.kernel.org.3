Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98CF4958E1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 05:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245363AbiAUERy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 23:17:54 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:54346
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233924AbiAUERx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 23:17:53 -0500
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0A2E03FFD0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 04:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642738672;
        bh=rXudac+Sy8gwrxo8njPKo3h/K3k2Za30HGB7xZ6nK5I=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ZDJhLfyLHl3AtmyYr8tqXP+AnlZ+ki1WcJ3cdOp/Np9uUr/LOGH0wzppaTRxrTqnM
         Gtiz9cXjmOOEGDHpFQh0nxl25NbGvQ5oQn4gvDntnAX1OSNHJaTOTjorWs9Nz6jgqZ
         jUjXnstFY4/uwM6U2mRa9ejKdJzxEzBJ8upK5lTREqra2Zv7kUQC7uen1fdYiwKV+L
         bIYAtmJBSLJ9EmFqJQbwjUn84MevVFnB8D9sJ4NFgijwTn3q2Q7CL+PtOMd30C1p/d
         XiC6atH+tKhEgsciRFtCZrIRydhb7HX9dz8Dx2s8lRupeGK5CCQfMkcdzENp1MR6YL
         YgYv9I5Cb6nqg==
Received: by mail-oi1-f198.google.com with SMTP id p131-20020acabf89000000b002c6dcda3435so5189433oif.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 20:17:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rXudac+Sy8gwrxo8njPKo3h/K3k2Za30HGB7xZ6nK5I=;
        b=O1aHUS0iLUBmZ/AW11rX5wHKPgs9Soj1wyGQrtC6IpIgV+M+y4wmeirxcOQU/BL0re
         ZyigR9aGMdaTJ3tsN5UD8UP9WtK/3QAKiLCSPf8nO9JwnmmPUNvVBb2W7lgOkzUpn+Yk
         8Ei6nQNNKyF7PjVXnzap/wS7PaWZx6DN+KdzckvBb0qYZ/LUn4cRbJWzuWNLY9hrXsWI
         JauKoKE+UsfizQ37s58UGlsgWa5LuSt5i1QarRvHdE4TCt0ywci9bUXlb0Ki4wprdV03
         nICMVqjw5S+EhVGBE+4GCnRAcVWONxhoVpmMTYahtatHwQKhrgw5Pj0SQDJA/KGmiZdJ
         ThKA==
X-Gm-Message-State: AOAM532lfdZYrjOZYdtDEbM+IO4wSpN5hSiWW2Qvg+i4bVrEmajQxRPP
        5JzmXeoB0BerfW0aLYcjlpwj0W7h9s+SCfvYgv5mshjqcuRSxFd5Bl4fK4XJ0/oDxXvX5vi+kjM
        4dFMl3T7OpJP5d2YNV+iV4z3AdtLwKEK975BlC/YJVTpJRbaFJ6C4EXHoSg==
X-Received: by 2002:a05:6808:19a9:: with SMTP id bj41mr10494935oib.98.1642738670823;
        Thu, 20 Jan 2022 20:17:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyOrLwi9RZcS8M47Ek2+NQZR15nmipLLUkmtqVXb9RcR7kqU7sa1x3Iwu2t9ht5yfl2W4/7N/SizngmbYA0r2E=
X-Received: by 2002:a05:6808:19a9:: with SMTP id bj41mr10494921oib.98.1642738670520;
 Thu, 20 Jan 2022 20:17:50 -0800 (PST)
MIME-Version: 1.0
References: <20220120145006.1682014-2-kai.heng.feng@canonical.com>
 <20220121014039.1693208-1-kai.heng.feng@canonical.com> <e757387774234b678f6a38e004179c99@realtek.com>
 <CAAd53p7Ek3xjsnXPbrrigGfyjnAz0OpHqYT7A3q8MWFrfZnuXg@mail.gmail.com> <21c1e92840b44a059dbbed714c84150b@realtek.com>
In-Reply-To: <21c1e92840b44a059dbbed714c84150b@realtek.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 21 Jan 2022 12:17:39 +0800
Message-ID: <CAAd53p6PeiLLEy9MXdJJcGKJ=hHZGNUY=-NhR_8kGjHvvDW6Ew@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] misc: rtsx: Rework runtime power management flow
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Yang Li <yang.lee@linux.alibaba.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 12:15 PM Ricky WU <ricky_wu@realtek.com> wrote:
>
> > -----Original Message-----
> > From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > Sent: Friday, January 21, 2022 12:08 PM
> > To: Ricky WU <ricky_wu@realtek.com>
> > Cc: arnd@arndb.de; gregkh@linuxfoundation.org; ulf.hansson@linaro.org;
> > linux-pm@vger.kernel.org; Christophe JAILLET
> > <christophe.jaillet@wanadoo.fr>; Yang Li <yang.lee@linux.alibaba.com>;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v2 2/4] misc: rtsx: Rework runtime power management
> > flow
> >
> > On Fri, Jan 21, 2022 at 11:57 AM Ricky WU <ricky_wu@realtek.com> wrote:
> > >
> > > > -----Original Message-----
> > > > From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > > Sent: Friday, January 21, 2022 9:41 AM
> > > > To: arnd@arndb.de; gregkh@linuxfoundation.org;
> > > > ulf.hansson@linaro.org
> > > > Cc: linux-pm@vger.kernel.org; Kai-Heng Feng
> > > > <kai.heng.feng@canonical.com>; Ricky WU <ricky_wu@realtek.com>;
> > > > Christophe JAILLET <christophe.jaillet@wanadoo.fr>; Yang Li
> > > > <yang.lee@linux.alibaba.com>; linux-kernel@vger.kernel.org
> > > > Subject: [PATCH v2 2/4] misc: rtsx: Rework runtime power management
> > > > flow
> > > >
> > > > Commit 5b4258f6721f ("misc: rtsx: rts5249 support runtime PM") uses
> > > > "rtd3_work" and "idle_work" to manage it's own runtime PM state
> > machine.
> > > >
> > > > When its child device, rtsx_pci_sdmmc, uses runtime PM refcount
> > > > correctly, all the additional works can be managed by generic runtime PM
> > helpers.
> > > >
> > > > So consolidate "idle_work" and "rtd3_work" into generic runtime idle
> > > > callback and runtime suspend callback, respectively.
> > > >
> > >
> > > This idle_work is not runtime_idle, this is for aspm setting Not only
> > > for support RPM, so this idle_work can not be remove....
> >
> > rtsx_pm_power_saving() is called inside rtsx_pci_runtime_idle(), when the
> > usage refcount becomes zero, before runtime suspend routine.
> >
> > >
> > > Our original Idle_work is a power saveing function, It is a delay_work
> > > for 200 msec  , If no work comes in 200 msec than go to idle_work to set
> > power saveing setting.....
> >
> > Have you tested it locally? rtsx_pci_runtime_idle() really does the same thing.
> >
>
> We are testing...
> RTD3 is not available on all platforms....
> We use a values (rtd3_en) to judge rtd3 enable or not
>
> Aspm is for all platform but RTD3 is not

Thanks! I get it now.
Let me send v3 to address the issue.

Kai-Heng

>
> >
> > >
> > > > Fixes: 5b4258f6721f ("misc: rtsx: rts5249 support runtime PM")
> > > > Cc: Ricky WU <ricky_wu@realtek.com>
> > > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > > ---
> > > > v2:
> > > >  - Remove unused idle_work and rtd3_work from rtsx_pcr.
> > > >
> > > >  drivers/misc/cardreader/rtsx_pcr.c | 123 +++++++++++------------------
> > > >  include/linux/rtsx_pci.h           |   3 -
> > > >  2 files changed, 44 insertions(+), 82 deletions(-)
> > > >
> > > > diff --git a/drivers/misc/cardreader/rtsx_pcr.c
> > > > b/drivers/misc/cardreader/rtsx_pcr.c
> > > > index 6ac509c1821c9..1dcf98b597569 100644
> > > > --- a/drivers/misc/cardreader/rtsx_pcr.c
> > > > +++ b/drivers/misc/cardreader/rtsx_pcr.c
> > > > @@ -152,20 +152,12 @@ void rtsx_pci_start_run(struct rtsx_pcr *pcr)
> > > >       if (pcr->remove_pci)
> > > >               return;
> > > >
> > > > -     if (pcr->rtd3_en)
> > > > -             if (pcr->is_runtime_suspended) {
> > > > -                     pm_runtime_get(&(pcr->pci->dev));
> > > > -                     pcr->is_runtime_suspended = false;
> > > > -             }
> > > > -
> > > >       if (pcr->state != PDEV_STAT_RUN) {
> > > >               pcr->state = PDEV_STAT_RUN;
> > > >               if (pcr->ops->enable_auto_blink)
> > > >                       pcr->ops->enable_auto_blink(pcr);
> > > >               rtsx_pm_full_on(pcr);
> > > >       }
> > > > -
> > > > -     mod_delayed_work(system_wq, &pcr->idle_work,
> > msecs_to_jiffies(200));
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(rtsx_pci_start_run);
> > > >
> > > > @@ -1094,40 +1086,6 @@ static void rtsx_pm_power_saving(struct
> > > > rtsx_pcr
> > > > *pcr)
> > > >       rtsx_comm_pm_power_saving(pcr);  }
> > > >
> > > > -static void rtsx_pci_rtd3_work(struct work_struct *work) -{
> > > > -     struct delayed_work *dwork = to_delayed_work(work);
> > > > -     struct rtsx_pcr *pcr = container_of(dwork, struct rtsx_pcr,
> > rtd3_work);
> > > > -
> > > > -     pcr_dbg(pcr, "--> %s\n", __func__);
> > > > -     if (!pcr->is_runtime_suspended)
> > > > -             pm_runtime_put(&(pcr->pci->dev));
> > > > -}
> > > > -
> > > > -static void rtsx_pci_idle_work(struct work_struct *work) -{
> > > > -     struct delayed_work *dwork = to_delayed_work(work);
> > > > -     struct rtsx_pcr *pcr = container_of(dwork, struct rtsx_pcr,
> > idle_work);
> > > > -
> > > > -     pcr_dbg(pcr, "--> %s\n", __func__);
> > > > -
> > > > -     mutex_lock(&pcr->pcr_mutex);
> > > > -
> > > > -     pcr->state = PDEV_STAT_IDLE;
> > > > -
> > > > -     if (pcr->ops->disable_auto_blink)
> > > > -             pcr->ops->disable_auto_blink(pcr);
> > > > -     if (pcr->ops->turn_off_led)
> > > > -             pcr->ops->turn_off_led(pcr);
> > > > -
> > > > -     rtsx_pm_power_saving(pcr);
> > > > -
> > > > -     mutex_unlock(&pcr->pcr_mutex);
> > > > -
> > > > -     if (pcr->rtd3_en)
> > > > -             mod_delayed_work(system_wq, &pcr->rtd3_work,
> > > > msecs_to_jiffies(10000));
> > > > -}
> > > > -
> > > >  static void rtsx_base_force_power_down(struct rtsx_pcr *pcr, u8
> > > > pm_state) {
> > > >       /* Set relink_time to 0 */
> > > > @@ -1598,7 +1556,6 @@ static int rtsx_pci_probe(struct pci_dev *pcidev,
> > > >       pcr->card_inserted = 0;
> > > >       pcr->card_removed = 0;
> > > >       INIT_DELAYED_WORK(&pcr->carddet_work, rtsx_pci_card_detect);
> > > > -     INIT_DELAYED_WORK(&pcr->idle_work, rtsx_pci_idle_work);
> > > >
> > > >       pcr->msi_en = msi_en;
> > > >       if (pcr->msi_en) {
> > > > @@ -1623,20 +1580,16 @@ static int rtsx_pci_probe(struct pci_dev
> > *pcidev,
> > > >               rtsx_pcr_cells[i].pdata_size = sizeof(*handle);
> > > >       }
> > > >
> > > > -     if (pcr->rtd3_en) {
> > > > -             INIT_DELAYED_WORK(&pcr->rtd3_work,
> > rtsx_pci_rtd3_work);
> > > > -             pm_runtime_allow(&pcidev->dev);
> > > > -             pm_runtime_enable(&pcidev->dev);
> > > > -             pcr->is_runtime_suspended = false;
> > > > -     }
> > > > -
> > > >
> > > >       ret = mfd_add_devices(&pcidev->dev, pcr->id, rtsx_pcr_cells,
> > > >                       ARRAY_SIZE(rtsx_pcr_cells), NULL, 0, NULL);
> > > >       if (ret < 0)
> > > >               goto free_slots;
> > > >
> > > > -     schedule_delayed_work(&pcr->idle_work, msecs_to_jiffies(200));
> > > > +     if (pcr->rtd3_en) {
> > > > +             pm_runtime_allow(&pcidev->dev);
> > > > +             pm_runtime_put(&pcidev->dev);
> > > > +     }
> > > >
> > > >       return 0;
> > > >
> > > > @@ -1668,10 +1621,11 @@ static void rtsx_pci_remove(struct pci_dev
> > > > *pcidev)
> > > >       struct pcr_handle *handle = pci_get_drvdata(pcidev);
> > > >       struct rtsx_pcr *pcr = handle->pcr;
> > > >
> > > > -     if (pcr->rtd3_en)
> > > > -             pm_runtime_get_noresume(&pcr->pci->dev);
> > > > -
> > > >       pcr->remove_pci = true;
> > > > +     if (pcr->rtd3_en) {
> > > > +             pm_runtime_get_sync(&pcidev->dev);
> > > > +             pm_runtime_forbid(&pcidev->dev);
> > > > +     }
> > > >
> > > >       /* Disable interrupts at the pcr level */
> > > >       spin_lock_irq(&pcr->lock);
> > > > @@ -1680,9 +1634,6 @@ static void rtsx_pci_remove(struct pci_dev
> > *pcidev)
> > > >       spin_unlock_irq(&pcr->lock);
> > > >
> > > >       cancel_delayed_work_sync(&pcr->carddet_work);
> > > > -     cancel_delayed_work_sync(&pcr->idle_work);
> > > > -     if (pcr->rtd3_en)
> > > > -             cancel_delayed_work_sync(&pcr->rtd3_work);
> > > >
> > > >       mfd_remove_devices(&pcidev->dev);
> > > >
> > > > @@ -1700,11 +1651,6 @@ static void rtsx_pci_remove(struct pci_dev
> > > > *pcidev)
> > > >       idr_remove(&rtsx_pci_idr, pcr->id);
> > > >       spin_unlock(&rtsx_pci_lock);
> > > >
> > > > -     if (pcr->rtd3_en) {
> > > > -             pm_runtime_disable(&pcr->pci->dev);
> > > > -             pm_runtime_put_noidle(&pcr->pci->dev);
> > > > -     }
> > > > -
> > > >       kfree(pcr->slots);
> > > >       kfree(pcr);
> > > >       kfree(handle);
> > > > @@ -1726,7 +1672,6 @@ static int __maybe_unused
> > > > rtsx_pci_suspend(struct device *dev_d)
> > > >       pcr = handle->pcr;
> > > >
> > > >       cancel_delayed_work(&pcr->carddet_work);
> > > > -     cancel_delayed_work(&pcr->idle_work);
> > > >
> > > >       mutex_lock(&pcr->pcr_mutex);
> > > >
> > > > @@ -1760,8 +1705,6 @@ static int __maybe_unused
> > > > rtsx_pci_resume(struct device *dev_d)
> > > >       if (ret)
> > > >               goto out;
> > > >
> > > > -     schedule_delayed_work(&pcr->idle_work, msecs_to_jiffies(200));
> > > > -
> > > >  out:
> > > >       mutex_unlock(&pcr->pcr_mutex);
> > > >       return ret;
> > > > @@ -1786,6 +1729,32 @@ static void rtsx_pci_shutdown(struct pci_dev
> > > > *pcidev)
> > > >               pci_disable_msi(pcr->pci);  }
> > > >
> > > > +static int rtsx_pci_runtime_idle(struct device *device) {
> > > > +     struct pci_dev *pcidev = to_pci_dev(device);
> > > > +     struct pcr_handle *handle = pci_get_drvdata(pcidev);
> > > > +     struct rtsx_pcr *pcr = handle->pcr;
> > > > +
> > > > +     dev_dbg(device, "--> %s\n", __func__);
> > > > +
> > > > +     mutex_lock(&pcr->pcr_mutex);
> > > > +
> > > > +     pcr->state = PDEV_STAT_IDLE;
> > > > +
> > > > +     if (pcr->ops->disable_auto_blink)
> > > > +             pcr->ops->disable_auto_blink(pcr);
> > > > +     if (pcr->ops->turn_off_led)
> > > > +             pcr->ops->turn_off_led(pcr);
> > > > +
> > > > +     rtsx_pm_power_saving(pcr);
> > > > +
> > > > +     mutex_unlock(&pcr->pcr_mutex);
> > > > +
> > > > +     pm_schedule_suspend(device, 5000);
> > > > +
> > > > +     return -EBUSY;
> > > > +}
> > > > +
> > > >  static int rtsx_pci_runtime_suspend(struct device *device)  {
> > > >       struct pci_dev *pcidev = to_pci_dev(device); @@ -1794,31
> > > > +1763,29 @@ static int rtsx_pci_runtime_suspend(struct device
> > > > *device)
> > > >
> > > >       handle = pci_get_drvdata(pcidev);
> > > >       pcr = handle->pcr;
> > > > -     dev_dbg(&(pcidev->dev), "--> %s\n", __func__);
> > > >
> > > > -     cancel_delayed_work(&pcr->carddet_work);
> > > > -     cancel_delayed_work(&pcr->rtd3_work);
> > > > -     cancel_delayed_work(&pcr->idle_work);
> > > > +     if (!pcr->rtd3_en)
> > > > +             return -EBUSY;
> > > > +
> > > > +     dev_dbg(device, "--> %s\n", __func__);
> > > > +
> > > > +     cancel_delayed_work_sync(&pcr->carddet_work);
> > > >
> > > >       mutex_lock(&pcr->pcr_mutex);
> > > >       rtsx_pci_power_off(pcr, HOST_ENTER_S3);
> > > >
> > > >       mutex_unlock(&pcr->pcr_mutex);
> > > >
> > > > -     pcr->is_runtime_suspended = true;
> > > > -
> > > >       return 0;
> > > >  }
> > > >
> > > >  static int rtsx_pci_runtime_resume(struct device *device)  {
> > > >       struct pci_dev *pcidev = to_pci_dev(device);
> > > > -     struct pcr_handle *handle;
> > > > -     struct rtsx_pcr *pcr;
> > > > +     struct pcr_handle *handle = pci_get_drvdata(pcidev);
> > > > +     struct rtsx_pcr *pcr = handle->pcr;
> > > >
> > > > -     handle = pci_get_drvdata(pcidev);
> > > > -     pcr = handle->pcr;
> > > > -     dev_dbg(&(pcidev->dev), "--> %s\n", __func__);
> > > > +     dev_dbg(device, "--> %s\n", __func__);
> > > >
> > > >       mutex_lock(&pcr->pcr_mutex);
> > > >
> > > > @@ -1834,8 +1801,6 @@ static int rtsx_pci_runtime_resume(struct
> > > > device
> > > > *device)
> > > >                               pcr->slots[RTSX_SD_CARD].p_dev);
> > > >       }
> > > >
> > > > -     schedule_delayed_work(&pcr->idle_work, msecs_to_jiffies(200));
> > > > -
> > > >       mutex_unlock(&pcr->pcr_mutex);
> > > >       return 0;
> > > >  }
> > > > @@ -1850,7 +1815,7 @@ static int rtsx_pci_runtime_resume(struct
> > > > device
> > > > *device)
> > > >
> > > >  static const struct dev_pm_ops rtsx_pci_pm_ops = {
> > > >       SET_SYSTEM_SLEEP_PM_OPS(rtsx_pci_suspend, rtsx_pci_resume)
> > > > -     SET_RUNTIME_PM_OPS(rtsx_pci_runtime_suspend,
> > > > rtsx_pci_runtime_resume, NULL)
> > > > +     SET_RUNTIME_PM_OPS(rtsx_pci_runtime_suspend,
> > > > rtsx_pci_runtime_resume,
> > > > +rtsx_pci_runtime_idle)
> > > >  };
> > > >
> > > >  static struct pci_driver rtsx_pci_driver = { diff --git
> > > > a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h index
> > > > 4ab7bfc675f11..89b7d34e25b63 100644
> > > > --- a/include/linux/rtsx_pci.h
> > > > +++ b/include/linux/rtsx_pci.h
> > > > @@ -1201,8 +1201,6 @@ struct rtsx_pcr {
> > > >       unsigned int                    card_exist;
> > > >
> > > >       struct delayed_work             carddet_work;
> > > > -     struct delayed_work             idle_work;
> > > > -     struct delayed_work             rtd3_work;
> > > >
> > > >       spinlock_t                      lock;
> > > >       struct mutex                    pcr_mutex;
> > > > @@ -1212,7 +1210,6 @@ struct rtsx_pcr {
> > > >       unsigned int                    cur_clock;
> > > >       bool                            remove_pci;
> > > >       bool                            msi_en;
> > > > -     bool                            is_runtime_suspended;
> > > >
> > > >  #define EXTRA_CAPS_SD_SDR50          (1 << 0)
> > > >  #define EXTRA_CAPS_SD_SDR104         (1 << 1)
> > > > --
> > > > 2.33.1
> > >
> > ------Please consider the environment before printing this e-mail.
