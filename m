Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B352B48D6B6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 12:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbiAMLdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 06:33:09 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:51828
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230283AbiAMLdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 06:33:08 -0500
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 22224402A3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 11:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642073582;
        bh=/H7sSpV1ho7ORl23zoH5JeBHAevjr3OPeF5p6F+1dLg=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=IK5UL1oDha5OKGxqSngMZBZ6YfJwBPv8KBmJJVAbyMFKbxC5Lei0g3DZbvV/dB+h/
         a8D++hoyDVlKocqyWZUkhufKcNW8RbMBe0xt6gNRMRvl6RjcCwaVL51aXU0c6gJx/r
         eaQMJhhnzV8RyYxsQu5vZ6qQjFBZaB07BJdiB2smGrfWWgrl10eEcrmH0vtK6hJP4L
         oxvdY1h2fhHaKy4+9EUpu770mXAqZ72nP6Px/vd8pGBGDk18cZJdoPTpk1t0M2aKQj
         Hqw9cRVKKWK2LEXTwX572PHUxhORWcjzyTFhj9MwSOPI6c5oNFMfXDue2NCc2HhKgW
         9gi/qP40GvUWg==
Received: by mail-oo1-f70.google.com with SMTP id e14-20020a4ab98e000000b002ddacfb7b12so3864506oop.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 03:33:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/H7sSpV1ho7ORl23zoH5JeBHAevjr3OPeF5p6F+1dLg=;
        b=Ldnsl3umBVfiV7huev0AxkTFITgMBKK+9J3hbPk0mnBnBgP6HX0wR3wOiH/PrLOSpt
         rEn8H/P87ItXL0/dJi8EUw7JCbmiYZ4Tso4IojvFwDHcoXJlooZ/kcuV1pkEHIwNzGau
         vIfJpKLrsPPf+x+eD2+lLj0Ayz8JDGNongdBfz/o4F8OGlXYUgy0QSZhdnuluL6h9euR
         /oPGh03pv3TYE41X9+OvsjeX1LUqp9VEou1tRXl34iKyCUu/VU6regLw+jZqoepeLtwU
         EpjJk6jqGA9Y1eBBVzwsxoyTaBO0KPesa5gP8sAZdT6i2gJjE3qCfkbLwTuPssA4IMhZ
         Xc2Q==
X-Gm-Message-State: AOAM531N3KU06XnxGSUkew4loVlYUjwnYW4Jj7HIG01bQXfHJX/NJtq2
        URZtSGBCt7Kt8PX04EfUi7r4j01Layq3St9sVCjGQ0/TkmpMjwpqVrJNW2bwbkmV0FymvkqlFFF
        5E7sJ1B2TM1pHLut/ntvAKPMxSRm863H4n9bRoVRqI395kKKmAUEwClFfXA==
X-Received: by 2002:a05:6830:1f3a:: with SMTP id e26mr2780007oth.233.1642073580908;
        Thu, 13 Jan 2022 03:33:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz1yNU7Pnr8u+efiUubqC2SEHzlwFOBjDlzv/I3puxmc6T5qvlfMIxgoZtOetjUd1tyNKOAa0lzgDFKlGMbFy4=
X-Received: by 2002:a05:6830:1f3a:: with SMTP id e26mr2779996oth.233.1642073580585;
 Thu, 13 Jan 2022 03:33:00 -0800 (PST)
MIME-Version: 1.0
References: <c4525b4738f94483b9b8f8571fc80646@realtek.com>
In-Reply-To: <c4525b4738f94483b9b8f8571fc80646@realtek.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 13 Jan 2022 19:32:49 +0800
Message-ID: <CAAd53p6gzZVNov0L-abZ_N=FoD-JpfWp2W096SrVva=FfEv=aw@mail.gmail.com>
Subject: Re: [PATCH] misc: rtsx: modify rtd3 flow
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "yang.lee@linux.alibaba.com" <yang.lee@linux.alibaba.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 6:50 PM Ricky WU <ricky_wu@realtek.com> wrote:
>
> move pm_runtime_get() to _runtime_resume
> when System enter S3, do not have sd_request and do not
> call start_run to pm_runtime_get() cause is_runtime_suspended status
> not correct
>
> set more register in power_down flow to make plugin or unplug
> card do not wake up system when system is at S3
>
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> ---
>  drivers/misc/cardreader/rts5249.c  | 31 ++++++++++++++++++++++++++++--
>  drivers/misc/cardreader/rtsx_pcr.c | 17 ++++++++--------
>  drivers/misc/cardreader/rtsx_pcr.h |  1 +
>  3 files changed, 38 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/misc/cardreader/rts5249.c b/drivers/misc/cardreader/rts5249.c
> index 53f3a1f45c4a..69e32f075ca9 100644
> --- a/drivers/misc/cardreader/rts5249.c
> +++ b/drivers/misc/cardreader/rts5249.c
> @@ -74,7 +74,8 @@ static void rtsx_base_fetch_vendor_settings(struct rtsx_pcr *pcr)
>         pci_read_config_dword(pdev, PCR_SETTING_REG2, &reg);
>         pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", PCR_SETTING_REG2, reg);
>
> -       pcr->rtd3_en = rtsx_reg_to_rtd3_uhsii(reg);
> +       if (CHK_PCI_PID(pcr, PID_524A) || CHK_PCI_PID(pcr, PID_525A))
> +               pcr->rtd3_en = rtsx_reg_to_rtd3_uhsii(reg);
>
>         if (rtsx_check_mmc_support(reg))
>                 pcr->extra_caps |= EXTRA_CAPS_NO_MMC;
> @@ -143,6 +144,27 @@ static int rts5249_init_from_hw(struct rtsx_pcr *pcr)
>         return 0;
>  }
>
> +static void rts52xa_force_power_down(struct rtsx_pcr *pcr, u8 pm_state)
> +{
> +       /* Set relink_time to 0 */
> +       rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 1, MASK_8_BIT_DEF, 0);
> +       rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 2, MASK_8_BIT_DEF, 0);
> +       rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 3,
> +                               RELINK_TIME_MASK, 0);
> +
> +       rtsx_pci_write_register(pcr, RTS524A_PM_CTRL3,
> +                       D3_DELINK_MODE_EN, D3_DELINK_MODE_EN);
> +
> +       if (!pcr->is_runtime_suspended) {
> +               rtsx_pci_write_register(pcr, RTS524A_AUTOLOAD_CFG1,
> +                               CD_RESUME_EN_MASK, 0);
> +               rtsx_pci_write_register(pcr, RTS524A_PM_CTRL3, 0x01, 0x00);
> +               rtsx_pci_write_register(pcr, RTS524A_PME_FORCE_CTL, 0x30, 0x20);
> +       }
> +
> +       rtsx_pci_write_register(pcr, FPDCTL, ALL_POWER_DOWN, ALL_POWER_DOWN);
> +}
> +
>  static void rts52xa_save_content_from_efuse(struct rtsx_pcr *pcr)
>  {
>         u8 cnt, sv;
> @@ -281,8 +303,11 @@ static int rts5249_extra_init_hw(struct rtsx_pcr *pcr)
>
>         rtsx_pci_send_cmd(pcr, CMD_TIMEOUT_DEF);
>
> -       if (CHK_PCI_PID(pcr, PID_524A) || CHK_PCI_PID(pcr, PID_525A))
> +       if (CHK_PCI_PID(pcr, PID_524A) || CHK_PCI_PID(pcr, PID_525A)) {
>                 rtsx_pci_write_register(pcr, REG_VREF, PWD_SUSPND_EN, PWD_SUSPND_EN);
> +               rtsx_pci_write_register(pcr, RTS524A_AUTOLOAD_CFG1,
> +                       CD_RESUME_EN_MASK, CD_RESUME_EN_MASK);
> +       }
>
>         if (pcr->rtd3_en) {
>                 if (CHK_PCI_PID(pcr, PID_524A) || CHK_PCI_PID(pcr, PID_525A)) {
> @@ -724,6 +749,7 @@ static const struct pcr_ops rts524a_pcr_ops = {
>         .card_power_on = rtsx_base_card_power_on,
>         .card_power_off = rtsx_base_card_power_off,
>         .switch_output_voltage = rtsx_base_switch_output_voltage,
> +       .force_power_down = rts52xa_force_power_down,
>         .set_l1off_cfg_sub_d0 = rts5250_set_l1off_cfg_sub_d0,
>  };
>
> @@ -841,6 +867,7 @@ static const struct pcr_ops rts525a_pcr_ops = {
>         .card_power_on = rts525a_card_power_on,
>         .card_power_off = rtsx_base_card_power_off,
>         .switch_output_voltage = rts525a_switch_output_voltage,
> +       .force_power_down = rts52xa_force_power_down,
>         .set_l1off_cfg_sub_d0 = rts5250_set_l1off_cfg_sub_d0,
>  };
>
> diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
> index 6ac509c1821c..a83adfb122dc 100644
> --- a/drivers/misc/cardreader/rtsx_pcr.c
> +++ b/drivers/misc/cardreader/rtsx_pcr.c
> @@ -152,12 +152,6 @@ void rtsx_pci_start_run(struct rtsx_pcr *pcr)
>         if (pcr->remove_pci)
>                 return;
>
> -       if (pcr->rtd3_en)
> -               if (pcr->is_runtime_suspended) {
> -                       pm_runtime_get(&(pcr->pci->dev));
> -                       pcr->is_runtime_suspended = false;
> -               }
> -
>         if (pcr->state != PDEV_STAT_RUN) {
>                 pcr->state = PDEV_STAT_RUN;
>                 if (pcr->ops->enable_auto_blink)
> @@ -1597,6 +1591,7 @@ static int rtsx_pci_probe(struct pci_dev *pcidev,
>         pcr->host_sg_tbl_addr = pcr->rtsx_resv_buf_addr + HOST_CMDS_BUF_LEN;
>         pcr->card_inserted = 0;
>         pcr->card_removed = 0;
> +       pcr->rtd3_en = 0;
>         INIT_DELAYED_WORK(&pcr->carddet_work, rtsx_pci_card_detect);
>         INIT_DELAYED_WORK(&pcr->idle_work, rtsx_pci_idle_work);
>
> @@ -1796,17 +1791,16 @@ static int rtsx_pci_runtime_suspend(struct device *device)
>         pcr = handle->pcr;
>         dev_dbg(&(pcidev->dev), "--> %s\n", __func__);
>
> +       pcr->is_runtime_suspended = true;
> +
>         cancel_delayed_work(&pcr->carddet_work);
>         cancel_delayed_work(&pcr->rtd3_work);
>         cancel_delayed_work(&pcr->idle_work);
>
>         mutex_lock(&pcr->pcr_mutex);
>         rtsx_pci_power_off(pcr, HOST_ENTER_S3);
> -
>         mutex_unlock(&pcr->pcr_mutex);
>
> -       pcr->is_runtime_suspended = true;
> -
>         return 0;
>  }
>
> @@ -1820,6 +1814,11 @@ static int rtsx_pci_runtime_resume(struct device *device)
>         pcr = handle->pcr;
>         dev_dbg(&(pcidev->dev), "--> %s\n", __func__);
>
> +       if (pcr->is_runtime_suspended) {
> +               pm_runtime_get(&(pcr->pci->dev));
> +               pcr->is_runtime_suspended = false;
> +       }

If the runtime resume routine is called for system wide suspend, the
runtime suspend isn't allowed during the period.
So I don't quite understand what this patch is for.

Kai-Heng

> +
>         mutex_lock(&pcr->pcr_mutex);
>
>         rtsx_pci_write_register(pcr, HOST_SLEEP_STATE, 0x03, 0x00);
> diff --git a/drivers/misc/cardreader/rtsx_pcr.h b/drivers/misc/cardreader/rtsx_pcr.h
> index daf057c4eea6..b93975268e6d 100644
> --- a/drivers/misc/cardreader/rtsx_pcr.h
> +++ b/drivers/misc/cardreader/rtsx_pcr.h
> @@ -25,6 +25,7 @@
>  #define REG_EFUSE_POWEROFF             0x00
>  #define RTS5250_CLK_CFG3               0xFF79
>  #define RTS525A_CFG_MEM_PD             0xF0
> +#define RTS524A_AUTOLOAD_CFG1  0xFF7C
>  #define RTS524A_PM_CTRL3               0xFF7E
>  #define RTS525A_BIOS_CFG               0xFF2D
>  #define RTS525A_LOAD_BIOS_FLAG 0x01
> --
> 2.25.1
