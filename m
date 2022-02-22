Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E6B4BF1E8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 07:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiBVGKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 01:10:33 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiBVGK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 01:10:29 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E586C3311
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 22:10:04 -0800 (PST)
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 849633F33A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 06:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645510195;
        bh=huIedNqEyNtgpBFwuKIL8ad4PsagazTVLKhw+bRZNss=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ArTdG86PWgeRgF0daU/Ojjdkag1SqZq8GL7V4ba9ZYwcoFVUYDgcKPe7VvvTlbLIo
         OVnzdjBO2UmPrDhwpaQKEO6gLLhOO/8EZEJ7HHQAsj9FSyTtGFCvr17WGZYe7y/mFz
         umPeK0xhJVJ1wY5QULgV8Q3mdxN4F9Z/PmUiexjkup4HbILMyozz/D6SaeSg7epFet
         yNWtcmpwdH4p0ji4GqmEWKklE6YZoKhKR97l5tIGilDDwZCo6m53NeFD152rXYm/O5
         YLODWcvT0UbOYyO2L3rdYjn+PAQBYXRudw0snoJj3CPst13RgTt2+jf4s0taRgitMc
         I/GLisN169zaQ==
Received: by mail-oo1-f71.google.com with SMTP id a22-20020a4a8dd6000000b0031c074ab4b1so6404708ool.14
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 22:09:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=huIedNqEyNtgpBFwuKIL8ad4PsagazTVLKhw+bRZNss=;
        b=pb/2nGoRwm6XgK7XVDZOFgY+oAH7I8oe2AnHDhSiOnWrhxpgwb8+EtLGnPNPqpJIlT
         uxrsedxw3eaUytbn6fHJC4xGlNkNPtpEWVtjJkS69wi4tFzWBlEmZjqi/dnBPS8OX/+o
         AlTbRVCrxKU1KAJZGBjx+m8OnyPflcM3ZLs+tJ5BbLdglAzl0SkFHeSkP9O77IfQvWkO
         K0gaH7Ve/7Od6UmL7z/8KvgNSRJCw0U1sd158Y7ITFdu5tmfB5qJqd/F3k5wxf+pRUTT
         Lv25cIrEm4h/Ui9L9RQsjCMdNO5JRzx5ufVR/v+8cpOfbljlOdDgtUUQcjAao1AqJwcK
         ddYA==
X-Gm-Message-State: AOAM530lvovGMtLG9sUkJP2vC4JUG/YtM9CB4aP/lCCwbog+gJpWtK7c
        /orHf94IrJHUi+sdnbumf5ds8N6JcKK9ed1LB2CYDdNwzDnL2eW1NCDIQyodOccrHHXIml+alYy
        LPsUmSYF+m/x3sHeszowgFQH681xaFlbalCfpc++g/iflWovS0mOQGHZZsA==
X-Received: by 2002:a05:6808:168e:b0:2d3:a93f:317e with SMTP id bb14-20020a056808168e00b002d3a93f317emr1227349oib.57.1645510194286;
        Mon, 21 Feb 2022 22:09:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwzHx4DTN8SAoX/xDqbLivGqVC2SEUh4ZBwOGIPBLrBKDo3TBxLEiMw8BTYhuT6PKzyO7dI+3sOndA9nlEt6/E=
X-Received: by 2002:a05:6808:168e:b0:2d3:a93f:317e with SMTP id
 bb14-20020a056808168e00b002d3a93f317emr1227340oib.57.1645510193550; Mon, 21
 Feb 2022 22:09:53 -0800 (PST)
MIME-Version: 1.0
References: <dace32f573a445908fec0a10482c394c@realtek.com>
In-Reply-To: <dace32f573a445908fec0a10482c394c@realtek.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 22 Feb 2022 14:09:42 +0800
Message-ID: <CAAd53p5HBthAXc=LOn3_fC3n17YDfEHWkDjsvRxvFfiwRq8eXA@mail.gmail.com>
Subject: Re: [PATCH] misc: rtsx: rts522a rts5228 rts5261 support Runtime PM
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 7:20 PM Ricky WU <ricky_wu@realtek.com> wrote:
>
> rts522a, rts5228, rts5261
> add extra init flow for rtd3
> add more power_down setting for avoid being woken up
> by plugging or unplugging card when system in S3
>
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>

This can fix an issue that rts522a cannot detect card under D3.

Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

> ---
>  drivers/misc/cardreader/rts5227.c  | 47 ++++++++++++++++++++++++++++++
>  drivers/misc/cardreader/rts5228.c  | 21 +++++++++++--
>  drivers/misc/cardreader/rts5261.c  | 33 +++++++++++++++++++--
>  drivers/misc/cardreader/rtsx_pcr.h |  2 ++
>  4 files changed, 98 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/misc/cardreader/rts5227.c b/drivers/misc/cardreader/rts5227.c
> index 4bcfbc9afbac..d676cf63a966 100644
> --- a/drivers/misc/cardreader/rts5227.c
> +++ b/drivers/misc/cardreader/rts5227.c
> @@ -72,6 +72,8 @@ static void rts5227_fetch_vendor_settings(struct rtsx_pcr *pcr)
>
>         pci_read_config_dword(pdev, PCR_SETTING_REG2, &reg);
>         pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", PCR_SETTING_REG2, reg);
> +       if (CHK_PCI_PID(pcr, 0x522A))
> +               pcr->rtd3_en = rtsx_reg_to_rtd3(reg);
>         if (rtsx_check_mmc_support(reg))
>                 pcr->extra_caps |= EXTRA_CAPS_NO_MMC;
>         pcr->sd30_drive_sel_3v3 = rtsx_reg_to_sd30_drive_sel_3v3(reg);
> @@ -171,6 +173,28 @@ static int rts5227_extra_init_hw(struct rtsx_pcr *pcr)
>         else
>                 rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PETXCFG, 0x30, 0x00);
>
> +       if (CHK_PCI_PID(pcr, 0x522A))
> +               rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, RTS522A_AUTOLOAD_CFG1,
> +                       CD_RESUME_EN_MASK, CD_RESUME_EN_MASK);
> +
> +       if (pcr->rtd3_en) {
> +               if (CHK_PCI_PID(pcr, 0x522A)) {
> +                       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, RTS522A_PM_CTRL3, 0x01, 0x01);
> +                       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, RTS522A_PME_FORCE_CTL, 0x30, 0x30);
> +               } else {
> +                       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PM_CTRL3, 0x01, 0x01);
> +                       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PME_FORCE_CTL, 0xFF, 0x33);
> +               }
> +       } else {
> +               if (CHK_PCI_PID(pcr, 0x522A)) {
> +                       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, RTS522A_PM_CTRL3, 0x01, 0x00);
> +                       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, RTS522A_PME_FORCE_CTL, 0x30, 0x20);
> +               } else {
> +                       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PME_FORCE_CTL, 0xFF, 0x30);
> +                       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PM_CTRL3, 0x01, 0x00);
> +               }
> +       }
> +
>         if (option->force_clkreq_0)
>                 rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PETXCFG,
>                                 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_LOW);
> @@ -438,6 +462,28 @@ static int rts522a_switch_output_voltage(struct rtsx_pcr *pcr, u8 voltage)
>         return rtsx_pci_send_cmd(pcr, 100);
>  }
>
> +static void rts522a_force_power_down(struct rtsx_pcr *pcr, u8 pm_state, bool runtime)
> +{
> +       /* Set relink_time to 0 */
> +       rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 1, MASK_8_BIT_DEF, 0);
> +       rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 2, MASK_8_BIT_DEF, 0);
> +       rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 3,
> +                               RELINK_TIME_MASK, 0);
> +
> +       rtsx_pci_write_register(pcr, RTS522A_PM_CTRL3,
> +                       D3_DELINK_MODE_EN, D3_DELINK_MODE_EN);
> +
> +       if (!runtime) {
> +               rtsx_pci_write_register(pcr, RTS522A_AUTOLOAD_CFG1,
> +                               CD_RESUME_EN_MASK, 0);
> +               rtsx_pci_write_register(pcr, RTS522A_PM_CTRL3, 0x01, 0x00);
> +               rtsx_pci_write_register(pcr, RTS522A_PME_FORCE_CTL, 0x30, 0x20);
> +       }
> +
> +       rtsx_pci_write_register(pcr, FPDCTL, ALL_POWER_DOWN, ALL_POWER_DOWN);
> +}
> +
> +
>  static void rts522a_set_l1off_cfg_sub_d0(struct rtsx_pcr *pcr, int active)
>  {
>         struct rtsx_cr_option *option = &pcr->option;
> @@ -473,6 +519,7 @@ static const struct pcr_ops rts522a_pcr_ops = {
>         .card_power_on = rts5227_card_power_on,
>         .card_power_off = rts5227_card_power_off,
>         .switch_output_voltage = rts522a_switch_output_voltage,
> +       .force_power_down = rts522a_force_power_down,
>         .cd_deglitch = NULL,
>         .conv_clk_and_div_n = NULL,
>         .set_l1off_cfg_sub_d0 = rts522a_set_l1off_cfg_sub_d0,
> diff --git a/drivers/misc/cardreader/rts5228.c b/drivers/misc/cardreader/rts5228.c
> index ffe3afbf8bfe..af581f4f74d1 100644
> --- a/drivers/misc/cardreader/rts5228.c
> +++ b/drivers/misc/cardreader/rts5228.c
> @@ -102,6 +102,14 @@ static void rts5228_force_power_down(struct rtsx_pcr *pcr, u8 pm_state, bool run
>         rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3,
>                         D3_DELINK_MODE_EN, D3_DELINK_MODE_EN);
>
> +       if (!runtime) {
> +               rtsx_pci_write_register(pcr, RTS5228_AUTOLOAD_CFG1,
> +                               CD_RESUME_EN_MASK, 0);
> +               rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, 0x01, 0x00);
> +               rtsx_pci_write_register(pcr, RTS5228_REG_PME_FORCE_CTL,
> +                               FORCE_PM_CONTROL | FORCE_PM_VALUE, FORCE_PM_CONTROL);
> +       }
> +
>         rtsx_pci_write_register(pcr, FPDCTL,
>                 SSC_POWER_DOWN, SSC_POWER_DOWN);
>  }
> @@ -480,9 +488,18 @@ static int rts5228_extra_init_hw(struct rtsx_pcr *pcr)
>                                  FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_HIGH);
>
>         rtsx_pci_write_register(pcr, PWD_SUSPEND_EN, 0xFF, 0xFB);
> -       rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, 0x10, 0x00);
> +
> +       if (pcr->rtd3_en) {
> +               rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, 0x01, 0x01);
>         rtsx_pci_write_register(pcr, RTS5228_REG_PME_FORCE_CTL,
> -                       FORCE_PM_CONTROL | FORCE_PM_VALUE, FORCE_PM_CONTROL);
> +                               FORCE_PM_CONTROL | FORCE_PM_VALUE,
> +                               FORCE_PM_CONTROL | FORCE_PM_VALUE);
> +       } else {
> +               rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, 0x01, 0x00);
> +               rtsx_pci_write_register(pcr, RTS5228_REG_PME_FORCE_CTL,
> +                               FORCE_PM_CONTROL | FORCE_PM_VALUE, FORCE_PM_CONTROL);
> +       }
> +       rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, D3_DELINK_MODE_EN, 0x00);
>
>         return 0;
>  }
> diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
> index 64333347c14a..a77585ab0f30 100644
> --- a/drivers/misc/cardreader/rts5261.c
> +++ b/drivers/misc/cardreader/rts5261.c
> @@ -103,6 +103,24 @@ static void rts5261_force_power_down(struct rtsx_pcr *pcr, u8 pm_state, bool run
>                 rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3,
>                                         D3_DELINK_MODE_EN, D3_DELINK_MODE_EN);
>
> +       if (!runtime) {
> +               rtsx_pci_write_register(pcr, RTS5261_AUTOLOAD_CFG1,
> +                               CD_RESUME_EN_MASK, 0);
> +               rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, 0x01, 0x00);
> +               rtsx_pci_write_register(pcr, RTS5261_REG_PME_FORCE_CTL,
> +                               FORCE_PM_CONTROL | FORCE_PM_VALUE, FORCE_PM_CONTROL);
> +
> +       } else {
> +               rtsx_pci_write_register(pcr, RTS5261_REG_PME_FORCE_CTL,
> +                               FORCE_PM_CONTROL | FORCE_PM_VALUE, 0);
> +
> +               rtsx_pci_write_register(pcr, RTS5261_FW_CTL,
> +                               RTS5261_INFORM_RTD3_COLD, RTS5261_INFORM_RTD3_COLD);
> +               rtsx_pci_write_register(pcr, RTS5261_AUTOLOAD_CFG4,
> +                               RTS5261_FORCE_PRSNT_LOW, RTS5261_FORCE_PRSNT_LOW);
> +
> +       }
> +
>         rtsx_pci_write_register(pcr, RTS5261_REG_FPDCTL,
>                 SSC_POWER_DOWN, SSC_POWER_DOWN);
>  }
> @@ -536,9 +554,18 @@ static int rts5261_extra_init_hw(struct rtsx_pcr *pcr)
>                                  FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_HIGH);
>
>         rtsx_pci_write_register(pcr, PWD_SUSPEND_EN, 0xFF, 0xFB);
> -       rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, 0x10, 0x00);
> -       rtsx_pci_write_register(pcr, RTS5261_REG_PME_FORCE_CTL,
> -                       FORCE_PM_CONTROL | FORCE_PM_VALUE, FORCE_PM_CONTROL);
> +
> +       if (pcr->rtd3_en) {
> +               rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, 0x01, 0x01);
> +               rtsx_pci_write_register(pcr, RTS5261_REG_PME_FORCE_CTL,
> +                               FORCE_PM_CONTROL | FORCE_PM_VALUE,
> +                               FORCE_PM_CONTROL | FORCE_PM_VALUE);
> +       } else {
> +               rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, 0x01, 0x00);
> +               rtsx_pci_write_register(pcr, RTS5261_REG_PME_FORCE_CTL,
> +                               FORCE_PM_CONTROL | FORCE_PM_VALUE, FORCE_PM_CONTROL);
> +       }
> +       rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, D3_DELINK_MODE_EN, 0x00);
>
>         /* Clear Enter RTD3_cold Information*/
>         rtsx_pci_write_register(pcr, RTS5261_FW_CTL,
> diff --git a/drivers/misc/cardreader/rtsx_pcr.h b/drivers/misc/cardreader/rtsx_pcr.h
> index aa0ebd667227..37d1f316ae17 100644
> --- a/drivers/misc/cardreader/rtsx_pcr.h
> +++ b/drivers/misc/cardreader/rtsx_pcr.h
> @@ -15,6 +15,8 @@
>  #define MIN_DIV_N_PCR          80
>  #define MAX_DIV_N_PCR          208
>
> +#define RTS522A_PME_FORCE_CTL  0xFF78
> +#define RTS522A_AUTOLOAD_CFG1  0xFF7C
>  #define RTS522A_PM_CTRL3               0xFF7E
>
>  #define RTS524A_PME_FORCE_CTL          0xFF78
> --
> 2.25.1
