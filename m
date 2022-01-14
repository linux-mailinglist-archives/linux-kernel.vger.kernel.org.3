Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3176A48E4DD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 08:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236800AbiANH3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 02:29:16 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:60270
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229719AbiANH3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 02:29:15 -0500
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 18D6B3F1EC
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642145354;
        bh=zyQ1Xn9WkymPM9uwh1xkeuoAlg4fQkG5Hxn0x0HRRc4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=hh3sMtzl40Awzi+2aPUWaRia2cnIi49thH4w+Ya0zbMiDZvQeHxbGNKGPQKSGJfMP
         QF+adbX883+TX49EnosE47I9ks4y7mpQasJVHYqx5gKEtehzPBngkb4FjuQ7Kh+F3v
         EWOhlrSy9HUTtaWD95lXsJaasPGjTj8hHTr10zdwWvMWN37VI8BQvNSFcWTUbIjM2Q
         84H4d6UptPEMhzq1elHAcSMrB1DZTIKK1MNj63w8xeHjoTylRf2aTqHmcHpPCL74jd
         Vbm8QqTotGWy2eibdBZFktyQxShV076tGGVE4EQ5hG5nY8HvwNRWPPFuASNet3HCiN
         uDZAVeYzJil2w==
Received: by mail-oo1-f69.google.com with SMTP id r25-20020a4ae5d9000000b002c9ad00c5a5so5424316oov.22
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 23:29:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zyQ1Xn9WkymPM9uwh1xkeuoAlg4fQkG5Hxn0x0HRRc4=;
        b=fQLEptCSOcJAE282D5ts6MPCrZzhPbHacvTO0Ws1KpH3l9tXkpbHyDq9nRim9vqt1d
         a5j92AddfxSdO/e8x6Q9fu1y6aLvgm/xBOmm7qW/VsL/oMDH4A0E9H0JqoxfZ1TJXdbU
         9g14Sb1PQII7m6BrSudih8M7ni2fdjZ4ksCB4rL90f23W+caoHuHcCHOlwhmloNTJlS3
         pHg1XkPYA90vn5kMbhQ4ghioiFeFnJ76p3Emagtfo9J0sNJFGS67NMWDFtQeKftWtJrl
         dJW9XkRahZeZDgRppuDH21LNO0EYbcTg5N5D11WKKLGxBVPVlvqnyEHIyWpJAnfxtKGi
         GvRw==
X-Gm-Message-State: AOAM5310iUfd+2ZeB3s2CDsqXWcthkSftGJycE8IlWnokuwfLRb/duOA
        MJo1AZi+JpBbZZlOI8paGlpFw7SS6h7AYFSCFnbRDCXorZgTNtqZHuP/dWjht6cBGtHYtYKDLWd
        O8/UHJBek5jcdHisUROgL01cF82gesQInEDyxKIuVETbYFg+XZxBsZpzMoA==
X-Received: by 2002:a9d:7e84:: with SMTP id m4mr2436280otp.269.1642145352671;
        Thu, 13 Jan 2022 23:29:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwfjDjwBPxvgN9qgDZT2hDkbCL0sBPLf6zjSufVfWdgawQg20Rt4FASxfPMiiGH9Z23qkzIaMzDcDGMuGuZDiM=
X-Received: by 2002:a9d:7e84:: with SMTP id m4mr2436269otp.269.1642145352356;
 Thu, 13 Jan 2022 23:29:12 -0800 (PST)
MIME-Version: 1.0
References: <c4525b4738f94483b9b8f8571fc80646@realtek.com> <CAAd53p6gzZVNov0L-abZ_N=FoD-JpfWp2W096SrVva=FfEv=aw@mail.gmail.com>
 <3bae27438b4b4d1eb367baefa7898060@realtek.com>
In-Reply-To: <3bae27438b4b4d1eb367baefa7898060@realtek.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 14 Jan 2022 15:29:01 +0800
Message-ID: <CAAd53p6GFqMbp-xMDf0qufxfpb8wes8S8VVdghZnNdV5Mr4s7w@mail.gmail.com>
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

On Fri, Jan 14, 2022 at 2:56 PM Ricky WU <ricky_wu@realtek.com> wrote:
>
> > -----Original Message-----
> > From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > Sent: Thursday, January 13, 2022 7:33 PM
> > To: Ricky WU <ricky_wu@realtek.com>
> > Cc: arnd@arndb.de; gregkh@linuxfoundation.org;
> > christophe.jaillet@wanadoo.fr; yang.lee@linux.alibaba.com;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] misc: rtsx: modify rtd3 flow
> >
> > On Thu, Jan 13, 2022 at 6:50 PM Ricky WU <ricky_wu@realtek.com> wrote:
> > >
> > > move pm_runtime_get() to _runtime_resume when System enter S3, do not
> > > have sd_request and do not call start_run to pm_runtime_get() cause
> > > is_runtime_suspended status not correct
> > >
> > > set more register in power_down flow to make plugin or unplug card do
> > > not wake up system when system is at S3
> > >
> > > Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> > > ---
> > >  drivers/misc/cardreader/rts5249.c  | 31
> > > ++++++++++++++++++++++++++++--  drivers/misc/cardreader/rtsx_pcr.c |
> > > 17 ++++++++--------  drivers/misc/cardreader/rtsx_pcr.h |  1 +
> > >  3 files changed, 38 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/misc/cardreader/rts5249.c
> > > b/drivers/misc/cardreader/rts5249.c
> > > index 53f3a1f45c4a..69e32f075ca9 100644
> > > --- a/drivers/misc/cardreader/rts5249.c
> > > +++ b/drivers/misc/cardreader/rts5249.c
> > > @@ -74,7 +74,8 @@ static void rtsx_base_fetch_vendor_settings(struct
> > rtsx_pcr *pcr)
> > >         pci_read_config_dword(pdev, PCR_SETTING_REG2, &reg);
> > >         pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", PCR_SETTING_REG2, reg);
> > >
> > > -       pcr->rtd3_en =3D rtsx_reg_to_rtd3_uhsii(reg);
> > > +       if (CHK_PCI_PID(pcr, PID_524A) || CHK_PCI_PID(pcr, PID_525A))
> > > +               pcr->rtd3_en =3D rtsx_reg_to_rtd3_uhsii(reg);
> > >
> > >         if (rtsx_check_mmc_support(reg))
> > >                 pcr->extra_caps |=3D EXTRA_CAPS_NO_MMC; @@ -143,6
> > > +144,27 @@ static int rts5249_init_from_hw(struct rtsx_pcr *pcr)
> > >         return 0;
> > >  }
> > >
> > > +static void rts52xa_force_power_down(struct rtsx_pcr *pcr, u8
> > > +pm_state) {
> > > +       /* Set relink_time to 0 */
> > > +       rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 1,
> > MASK_8_BIT_DEF, 0);
> > > +       rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 2,
> > MASK_8_BIT_DEF, 0);
> > > +       rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 3,
> > > +                               RELINK_TIME_MASK, 0);
> > > +
> > > +       rtsx_pci_write_register(pcr, RTS524A_PM_CTRL3,
> > > +                       D3_DELINK_MODE_EN,
> > D3_DELINK_MODE_EN);
> > > +
> > > +       if (!pcr->is_runtime_suspended) {
> > > +               rtsx_pci_write_register(pcr, RTS524A_AUTOLOAD_CFG1,
> > > +                               CD_RESUME_EN_MASK, 0);
> > > +               rtsx_pci_write_register(pcr, RTS524A_PM_CTRL3, 0x01,
> > 0x00);
> > > +               rtsx_pci_write_register(pcr, RTS524A_PME_FORCE_CTL,
> > 0x30, 0x20);
> > > +       }
> > > +
> > > +       rtsx_pci_write_register(pcr, FPDCTL, ALL_POWER_DOWN,
> > > +ALL_POWER_DOWN); }
> > > +
> > >  static void rts52xa_save_content_from_efuse(struct rtsx_pcr *pcr)  {
> > >         u8 cnt, sv;
> > > @@ -281,8 +303,11 @@ static int rts5249_extra_init_hw(struct rtsx_pcr
> > > *pcr)
> > >
> > >         rtsx_pci_send_cmd(pcr, CMD_TIMEOUT_DEF);
> > >
> > > -       if (CHK_PCI_PID(pcr, PID_524A) || CHK_PCI_PID(pcr, PID_525A))
> > > +       if (CHK_PCI_PID(pcr, PID_524A) || CHK_PCI_PID(pcr, PID_525A))
> > > + {
> > >                 rtsx_pci_write_register(pcr, REG_VREF,
> > PWD_SUSPND_EN,
> > > PWD_SUSPND_EN);
> > > +               rtsx_pci_write_register(pcr, RTS524A_AUTOLOAD_CFG1,
> > > +                       CD_RESUME_EN_MASK,
> > CD_RESUME_EN_MASK);
> > > +       }
> > >
> > >         if (pcr->rtd3_en) {
> > >                 if (CHK_PCI_PID(pcr, PID_524A) || CHK_PCI_PID(pcr,
> > > PID_525A)) { @@ -724,6 +749,7 @@ static const struct pcr_ops
> > rts524a_pcr_ops =3D {
> > >         .card_power_on =3D rtsx_base_card_power_on,
> > >         .card_power_off =3D rtsx_base_card_power_off,
> > >         .switch_output_voltage =3D rtsx_base_switch_output_voltage,
> > > +       .force_power_down =3D rts52xa_force_power_down,
> > >         .set_l1off_cfg_sub_d0 =3D rts5250_set_l1off_cfg_sub_d0,  };
> > >
> > > @@ -841,6 +867,7 @@ static const struct pcr_ops rts525a_pcr_ops =3D {
> > >         .card_power_on =3D rts525a_card_power_on,
> > >         .card_power_off =3D rtsx_base_card_power_off,
> > >         .switch_output_voltage =3D rts525a_switch_output_voltage,
> > > +       .force_power_down =3D rts52xa_force_power_down,
> > >         .set_l1off_cfg_sub_d0 =3D rts5250_set_l1off_cfg_sub_d0,  };
> > >
> > > diff --git a/drivers/misc/cardreader/rtsx_pcr.c
> > > b/drivers/misc/cardreader/rtsx_pcr.c
> > > index 6ac509c1821c..a83adfb122dc 100644
> > > --- a/drivers/misc/cardreader/rtsx_pcr.c
> > > +++ b/drivers/misc/cardreader/rtsx_pcr.c
> > > @@ -152,12 +152,6 @@ void rtsx_pci_start_run(struct rtsx_pcr *pcr)
> > >         if (pcr->remove_pci)
> > >                 return;
> > >
> > > -       if (pcr->rtd3_en)
> > > -               if (pcr->is_runtime_suspended) {
> > > -                       pm_runtime_get(&(pcr->pci->dev));
> > > -                       pcr->is_runtime_suspended =3D false;
> > > -               }
> > > -
> > >         if (pcr->state !=3D PDEV_STAT_RUN) {
> > >                 pcr->state =3D PDEV_STAT_RUN;
> > >                 if (pcr->ops->enable_auto_blink) @@ -1597,6 +1591,7
> > @@
> > > static int rtsx_pci_probe(struct pci_dev *pcidev,
> > >         pcr->host_sg_tbl_addr =3D pcr->rtsx_resv_buf_addr +
> > HOST_CMDS_BUF_LEN;
> > >         pcr->card_inserted =3D 0;
> > >         pcr->card_removed =3D 0;
> > > +       pcr->rtd3_en =3D 0;
> > >         INIT_DELAYED_WORK(&pcr->carddet_work,
> > rtsx_pci_card_detect);
> > >         INIT_DELAYED_WORK(&pcr->idle_work, rtsx_pci_idle_work);
> > >
> > > @@ -1796,17 +1791,16 @@ static int rtsx_pci_runtime_suspend(struct
> > device *device)
> > >         pcr =3D handle->pcr;
> > >         dev_dbg(&(pcidev->dev), "--> %s\n", __func__);
> > >
> > > +       pcr->is_runtime_suspended =3D true;
> > > +
> > >         cancel_delayed_work(&pcr->carddet_work);
> > >         cancel_delayed_work(&pcr->rtd3_work);
> > >         cancel_delayed_work(&pcr->idle_work);
> > >
> > >         mutex_lock(&pcr->pcr_mutex);
> > >         rtsx_pci_power_off(pcr, HOST_ENTER_S3);
> > > -
> > >         mutex_unlock(&pcr->pcr_mutex);
> > >
> > > -       pcr->is_runtime_suspended =3D true;
> > > -
> > >         return 0;
> > >  }
> > >
> > > @@ -1820,6 +1814,11 @@ static int rtsx_pci_runtime_resume(struct devi=
ce
> > *device)
> > >         pcr =3D handle->pcr;
> > >         dev_dbg(&(pcidev->dev), "--> %s\n", __func__);
> > >
> > > +       if (pcr->is_runtime_suspended) {
> > > +               pm_runtime_get(&(pcr->pci->dev));
> > > +               pcr->is_runtime_suspended =3D false;
> > > +       }
> >
> > If the runtime resume routine is called for system wide suspend, the ru=
ntime
> > suspend isn't allowed during the period.
> > So I don't quite understand what this patch is for.
> >
>
> We don=E2=80=99t want to entry D3 frequently
> So we need to call pm_runtime_get() at start
> And call pm_runtime_put() in delay-work (rtd3_work)

Maybe use 'cancel_delayed_work(&pcr->rtd3_work)' like what
rtsx_pci_runtime_suspend() does?
And for this case maybe cancel_delayed_work_sync() is more preferred.

>
> But we found If we keep this if statement in start_run
> if (pcr->is_runtime_suspended) {
>   pm_runtime_get(&(pcr->pci->dev));
>   pcr->is_runtime_suspended =3D false;
> }
> pcr->is_runtime_suspended this status are not correct when enter S3
> because enter S3 not call start_run()

Maybe because the driver is trying to trick the runtime PM core on its
real power status?
I.e. the driver is maintaining its own PM state machine. Fully
cooperating the driver with PM core should solve the issue.

Kai-Heng

>
> > Kai-Heng
> >
> > > +
> > >         mutex_lock(&pcr->pcr_mutex);
> > >
> > >         rtsx_pci_write_register(pcr, HOST_SLEEP_STATE, 0x03, 0x00);
> > > diff --git a/drivers/misc/cardreader/rtsx_pcr.h
> > > b/drivers/misc/cardreader/rtsx_pcr.h
> > > index daf057c4eea6..b93975268e6d 100644
> > > --- a/drivers/misc/cardreader/rtsx_pcr.h
> > > +++ b/drivers/misc/cardreader/rtsx_pcr.h
> > > @@ -25,6 +25,7 @@
> > >  #define REG_EFUSE_POWEROFF             0x00
> > >  #define RTS5250_CLK_CFG3               0xFF79
> > >  #define RTS525A_CFG_MEM_PD             0xF0
> > > +#define RTS524A_AUTOLOAD_CFG1  0xFF7C
> > >  #define RTS524A_PM_CTRL3               0xFF7E
> > >  #define RTS525A_BIOS_CFG               0xFF2D
> > >  #define RTS525A_LOAD_BIOS_FLAG 0x01
> > > --
> > > 2.25.1
> > ------Please consider the environment before printing this e-mail.
