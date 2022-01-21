Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCBD496230
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 16:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381631AbiAUPij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 10:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344436AbiAUPih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 10:38:37 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD25CC06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 07:38:36 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id x11so34698495lfa.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 07:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AL6/cs+2SZHd0eXG1xsLv7TDu9wlVf2AS233FoN1tVM=;
        b=k95TyfgFxA1S1h98LVKTqO6BygKxT/3giWVa3WMZ2m0uQ5quAkl4CKDU/MaSsMjIzf
         q17lfo6wQLmrckqxE+8FXVXuuXdj+4MMc298DWoTvbIg/kGS6r1OhWBf98e9KED1TVzD
         dIiNpajBpKAjNuClyO6lZer7UFAGJ7vylfLtzNaP2cCIRXxafx0U0wC2bk1bvOshLJ/g
         t0RxobwzXgNVGyrBqXeD32XrjMhP0hkI/oX6YTtx2lRAxarOvJFxBEPZZgkgerMZ9HNw
         r1FJLGX/NcWOgtsmQgCzJrYo6c3ewEsEdN0g53KZ71JWZ9gLwk5UB3XNm1cixlwTKqVz
         O0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AL6/cs+2SZHd0eXG1xsLv7TDu9wlVf2AS233FoN1tVM=;
        b=1GATsknl+h/KWi3b+8s3k1UTu9jU1DAM+I1eHo13FkWeV4diGASJW6WLux1yVr22Ss
         wvpbHM/BesjkprPeEpbL0wu74rJZX3GD/a0sMbYMWlL0RPriv55SI8W4hdHZpuhxFuht
         jp3xkUFkxp6PeAYJpjw31g032uTF4VkOCNjMaHw7q0n9I3Irk5stP3VJRbujMlFNx83w
         S0Bi9uYw5vNS4nf2NmHKBxrQ2H61/t6w5eljvqEkyfN5RFxhrruCFFttxubeFSJFuNHy
         G3PmO+yC7fQzYXeHFdbzHi5mbD2c8GBkuj563Dn7PfhCv/cU7aH8CPYFMGIhdDdkIGz/
         E2xg==
X-Gm-Message-State: AOAM532/RLXBkIylGAW9fN4usTKCX1XTJEoMjDSfikfk85R6PDuWP6J6
        UwKWb70DlYd5ZV2tTzJN6owoh3BqGGflxRpDstDcwfwwxvE=
X-Google-Smtp-Source: ABdhPJyWXahADUaKkEvVUQVNIFPee5BgrlnfmRE0ESaWazw3E6FpXjLgHxAMhKjTo25n/+AjvLkz4YDPR3CDoE+0fHA=
X-Received: by 2002:a05:6512:2ea:: with SMTP id m10mr4027573lfq.254.1642779514195;
 Fri, 21 Jan 2022 07:38:34 -0800 (PST)
MIME-Version: 1.0
References: <20220121110909.104-1-chevron.li@bayhubtech.com> <20220121110909.104-2-chevron.li@bayhubtech.com>
In-Reply-To: <20220121110909.104-2-chevron.li@bayhubtech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 21 Jan 2022 16:37:57 +0100
Message-ID: <CAPDyKFqq5zd1k-cyUH4F1D41KyScKHuMnn5ysW25VX4kZBqJDw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc:sdhci-bayhub:provide a solution to improve sd
 host card compatibility
To:     Chevron Li <chevron.li@bayhubtech.com>
Cc:     adrian.hunter@intel.com, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        shirley.her@bayhubtech.com, fred.ai@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com, shaper.liu@bayhubtech.com,
        bruce.yang@bayhubtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2022 at 12:09, Chevron Li <chevron.li@bayhubtech.com> wrote:
>
> Improve the signal integrity for long SD bus trace with GGC SD host redri=
ver chip
> 1.GGC is a SD bus signal re-timing IC that has been paired with the SC718=
0 sometimes.
> 2.The key points as below:
>  2.1 GGC chip is initialized during SD initialization
>  2.2 GGC special tuning flow is used to re-timing SD bus signal.
>  2.3 GGC power signal control should follow sd host power signal control.
> 3.The function of the patch is already verified on Chrome OS, and Google =
request us to submit the patch to Linux for them future use.
> 4.GGC can work with any other standard SDHCI controller to improve SD sig=
nal SI and Timing.
> 5.GGC has cooperated with Intel/Qualcomm/MTK/SPRD sd host already and wor=
k well.
> 6.This file is created for collecting the GGC chip support APIs and varia=
bles
> This patch depends on patch:
> mmc:sdhci-msm:fix Qualcomm sd host 7180 SD card compatibility issue
>
> Signed-off-by: Chevron Li <chevron.li@bayhubtech.com>
> ---
> Changes:
> 1.Implement the sdhci_bht_host structure
> 2.Implement the functions used at sdhci-msm.c
> ---
>  drivers/mmc/host/sdhci-bayhub.c | 3374 ++++++++++++++++++++++++++++++-
>  1 file changed, 3370 insertions(+), 4 deletions(-)

It didn't sounded like you needed an entirely new driver to support to
this, according to what you stated in the commit message at least? Or
maybe this isn't a driver?

In any case, I am not sure I am willing to spend time to review a
patch with 3370 inserted lines, without first getting a better
understanding of what this really is.

>
> diff --git a/drivers/mmc/host/sdhci-bayhub.c b/drivers/mmc/host/sdhci-bay=
hub.c
> index 867d465ce848..622c4c05b2e4 100644
> --- a/drivers/mmc/host/sdhci-bayhub.c
> +++ b/drivers/mmc/host/sdhci-bayhub.c
> @@ -5,30 +5,3396 @@
>   *
>   * Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
>   */
> +#include <linux/of_gpio.h>
> +#include "../core/sdio_ops.h"
> +#include "../core/sd.c"
> +#include "../core/pwrseq.h"

No, this is hack. Host drivers should not use core headers like this.

> +
> +#define        SD_FNC_AM_SDR50         0x2
> +#define        SD_FNC_AM_SDR104        0x3
> +#define BIT_PASS_MASK  (0x7ff)
> +#define SDR104_MANUAL_INJECT 0x3ff
> +#define SDR50_MANUAL_INJECT  0x77f
> +
> +#define        TUNING_RING_IDX(x)  ((x) % TUNING_PHASE_SIZE)
> +#define        GET_IDX_VALUE(tb, x)  (tb & (1 << (x)))
> +#define        GENERATE_IDX_VALUE(x)  (1 << (x))
> +#define        GET_TUNING_RING_IDX_VALUE(tb, x) \
> +       (tb & (1 << TUNING_RING_IDX(x)))
> +#define        GENERATE_TUNING_RING_IDX_VALUE(x) \
> +       (1 << TUNING_RING_IDX(x))
> +#define        MAX_CFG_BIT_VAL (383)
> +
> +/*
> + * This part define the GGC used structure
> + * The GGC chip can work with standard SD host controller
> + * GGC is the chip IC name and it's a SD bus signal re-timing IC
> + * Aim at high-speed SD mode(ex.SDR104) and long wire of SD signals
> + */
> +#define TUNING_PHASE_SIZE      11
> +static const u32 ggc_cfg_data[16] =3D {
> +       0x07000000, 0x07364022, 0x01015412, 0x01062400,
> +       0x10400076, 0x00025432, 0x01046076, 0x62011000,
> +       0x30503106, 0x64141711, 0x10057513, 0x00336200,
> +       0x00020006, 0x40000400, 0x12200310, 0x3A314177
> +};
> +
> +struct ggc_bus_mode_cfg {
> +       u32 tx_selb_tb[TUNING_PHASE_SIZE];
> +       u32 all_selb_tb[TUNING_PHASE_SIZE];
> +       u32 tx_selb_failed_history;
> +       int bus_mode;
> +       int default_sela;
> +       int default_selb;
> +       u32 default_delaycode;
> +       u32 dll_voltage_unlock_cnt[4];
> +       u32 max_delaycode;
> +       u32 min_delaycode;
> +       u32 delaycode_narrowdown_index;
> +       u32 fail_phase;
> +};
> +
> +enum tuning_state {
> +       NO_TUNING =3D 0,
> +       OUTPUT_PASS_TYPE =3D 1,
> +       SET_PHASE_FAIL_TYPE =3D 2,
> +       TUNING_FAIL_TYPE =3D 3,
> +       READ_STATUS_FAIL_TYPE =3D 4,
> +       TUNING_CMD7_TIMEOUT =3D 5,
> +       RETUNING_CASE =3D 6,
> +};
> +
> +
> +struct ggc_reg_op {
> +       u32 ofs;
> +       u32 mask;
> +       u32 value;
> +};
> +
> +static const char *const op_dbg_str[] =3D {
> +       "no tuning",
> +       "pass",
> +       "set_phase_fail",
> +       "tuning fail",
> +       "read status fail",
> +       "tuning CMD7 timeout",
> +       "retuning case"
> +};
>
>  struct sdhci_bht_host {
> +       struct ggc_bus_mode_cfg sdr50;
> +       struct ggc_bus_mode_cfg sdr104;
> +       struct ggc_bus_mode_cfg *cur_bus_mode;
> +
> +       struct ggc_reg_op pha_stas_rx_low32;
> +       struct ggc_reg_op pha_stas_rx_high32;
> +       struct ggc_reg_op pha_stas_tx_low32;
> +       struct ggc_reg_op pha_stas_tx_high32;
> +       struct ggc_reg_op dll_sela_after_mask;
> +       struct ggc_reg_op dll_selb_after_mask;
> +
> +       struct ggc_reg_op dll_delay_100m_backup;
> +       struct ggc_reg_op dll_delay_200m_backup;
> +
> +       struct ggc_reg_op dll_sela_100m_cfg;
> +       struct ggc_reg_op dll_sela_200m_cfg;
> +       struct ggc_reg_op dll_selb_100m_cfg;
> +       struct ggc_reg_op dll_selb_200m_cfg;
> +       struct ggc_reg_op dll_selb_100m_cfg_en;
> +       struct ggc_reg_op dll_selb_200m_cfg_en;
> +       struct ggc_reg_op internl_tuning_en_100m;
> +       struct ggc_reg_op internl_tuning_en_200m;
> +       struct ggc_reg_op cmd19_cnt_cfg;
> +
> +       struct ggc_reg_op inject_failure_for_tuning_enable_cfg;
> +       struct ggc_reg_op inject_failure_for_200m_tuning_cfg;
> +       struct ggc_reg_op inject_failure_for_100m_tuning_cfg;
> +
> +       int def_sela_100m;
> +       int def_sela_200m;
> +       int def_selb_100m;
> +       int def_selb_200m;
> +
> +       u32 gg_reg_cur[16];
> +       u8 cur_read_buf[512];
> +
> +       bool dll_unlock_reinit_flg;
> +       u8 driver_strength_reinit_flg;
> +       bool tuning_cmd7_timeout_reinit_flg;
> +       u32 tuning_cmd7_timeout_reinit_cnt;
> +       u32 ggc_cur_sela;
> +       bool selx_tuning_done_flag;
> +       u32 ggc_cmd_tx_selb_failed_range;
> +       int ggc_sw_selb_tuning_first_selb;
> +       enum tuning_state ggc_sela_tuning_result[11];
> +       int dll_voltage_scan_map[4];
> +       int cur_dll_voltage_idx;
> +       int sdr50_notuning_sela_inject_flag;
> +       int sdr50_notuning_crc_error_flag;
> +       u32 sdr50_notuning_sela_rx_inject;
> +       u32 bh201_sdr50_sela_sw_inject;
> +       u32 bh201_sdr50_selb_hw_inject;
> +       u32 bh201_sdr104_selb_hw_inject;
> +       u32 bh201_drive_strength;
> +       bool tuning_in_progress;
> +       int pwr_gpio; /* External power enable pin for Redriver IC */
> +       int det_gpio;
>  };

Really? What is all this? No, I can't continue to review this - as I
expect this will just waste of my time. Sorry.

Kind regards
Uffe

>
> +/*
> + * The APIs used to initialization GGC chip and structure
> + */
> +static void cfg_bit_2_byte(int max_bit, int tar, int *byt, int *bit)
> +{
> +       u8 cfg_bit_map[6] =3D {6, 5, 4, 2, 1, 0};
> +
> +       *byt =3D (max_bit - tar) / 6;
> +       *bit =3D cfg_bit_map[(max_bit - tar) % 6];
> +}
> +
> +static u32 cfg_read_bits_ofs_mask(u8 *cfg, struct ggc_reg_op *bits)
> +{
> +       u32 rv =3D 0;
> +       u32 mask =3D bits->mask;
> +       int byte =3D 0, bit =3D 0;
> +       int i =3D 0;
> +
> +       while (mask) {
> +               cfg_bit_2_byte(MAX_CFG_BIT_VAL, bits->ofs + i, &byte, &bi=
t);
> +               if (cfg[byte] & (1 << bit))
> +                       rv |=3D 1 << i;
> +
> +               i++;
> +               mask >>=3D 1;
> +       };
> +       return rv;
> +}
> +
> +static void get_default_setting(struct sdhci_host *host, u8 *data)
> +{
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D sdhci_pltfm_priv(pltfm_hos=
t);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +
> +       ggc->def_sela_100m =3D
> +               cfg_read_bits_ofs_mask(data, &ggc->dll_sela_100m_cfg);
> +       ggc->def_sela_200m =3D
> +               cfg_read_bits_ofs_mask(data, &ggc->dll_sela_200m_cfg);
> +       ggc->def_selb_100m =3D
> +               cfg_read_bits_ofs_mask(data, &ggc->dll_sela_100m_cfg);
> +       ggc->def_selb_200m =3D
> +               cfg_read_bits_ofs_mask(data, &ggc->dll_sela_200m_cfg);
> +}
> +
> +static void cfg_write_bits_ofs_mask(u8 *cfg,
> +               struct ggc_reg_op *bits, u32 write_value)
> +{
> +       u32 wv =3D write_value & bits->mask;
> +       u32 mask =3D bits->mask;
> +       int byte =3D 0, bit =3D 0;
> +       int i =3D 0;
> +
> +       while (mask) {
> +               cfg_bit_2_byte(MAX_CFG_BIT_VAL, bits->ofs + i, &byte, &bi=
t);
> +               if (wv & 1)
> +                       cfg[byte] |=3D (u8) (1 << bit);
> +               else
> +                       cfg[byte] &=3D (u8) (~(1 << bit));
> +
> +               i++;
> +               wv >>=3D 1;
> +               mask >>=3D 1;
> +       };
> +}
> +
> +/* Use to get byte offset and bit offset */
> +static void ram_bit_2_bt(int tar, int *byt, int *bit)
> +{
> +       *byt =3D tar / 8;
> +       *bit =3D tar % 8;
> +}
> +
> +static void set_gg_reg_cur_val(struct sdhci_bht_host  *ggc,
> +       u8 *data, u8 len)
> +{
> +       memcpy(&ggc->gg_reg_cur[0], data, len);
> +}
> +
> +static void get_gg_reg_cur_val(struct sdhci_bht_host  *ggc,
> +       u8 *data, u8 len)
> +{
> +       memcpy(data, &ggc->gg_reg_cur[0], len);
> +}
> +
> +static u32 read_ram_bits_ofs_mask(u8 *cfg, struct ggc_reg_op *bits)
> +{
> +       u32 rv =3D 0;
> +       u32 mask =3D bits->mask;
> +       int byte =3D 0, bit =3D 0;
> +       int i =3D 0;
> +
> +       while (mask) {
> +               /* No replace interface at bitmap
> +                * The read out address maybe not align at byte
> +                */
> +               ram_bit_2_bt(bits->ofs + i, &byte, &bit);
> +               if (cfg[byte] & (1 << bit))
> +                       rv |=3D 1 << i;
> +
> +               i++;
> +               mask >>=3D 1;
> +       };
> +       return rv;
> +}
> +
> +static void ggc_dll_voltage_init(struct sdhci_host *host)
> +{
> +       int i =3D 0;
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D
> +                                               sdhci_pltfm_priv(pltfm_ho=
st);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +
> +       for (i =3D 0; i < 4; i++) {
> +               ggc->dll_voltage_scan_map[i] =3D 0;
> +               ggc->sdr50.dll_voltage_unlock_cnt[i] =3D 0;
> +               ggc->sdr104.dll_voltage_unlock_cnt[i] =3D 0;
> +       }
> +}
> +
> +static void ggc_chip_init(struct sdhci_host *host)
> +{
> +       u8 data[512];
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D
> +                                               sdhci_pltfm_priv(pltfm_ho=
st);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +
> +       memcpy(data, ggc_cfg_data, sizeof(ggc_cfg_data));
> +       get_default_setting(host, data);
> +       set_gg_reg_cur_val(ggc, data, 64);
> +}
> +
> +static void driver_send_command7(struct sdhci_host *host)
> +{
> +       struct mmc_host *mmc =3D host->mmc;
> +       struct mmc_command cmd =3D {0};
> +
> +       cmd.opcode =3D MMC_SELECT_CARD;
> +       cmd.arg =3D 0;
> +       cmd.flags =3D MMC_RSP_NONE | MMC_CMD_AC;
> +       mmc_wait_for_cmd(mmc, &cmd, 3);
> +}
> +
> +static void driver_send_command24(struct sdhci_host *host,
> +               u32 *cfg_data, int data_len)
> +{
> +       struct mmc_host *mmc =3D host->mmc;
> +       struct mmc_request mrq =3D {0};
> +       struct mmc_command cmd =3D { 0 };
> +       struct mmc_data data =3D { 0 };
> +       struct scatterlist sg;
> +       u8 *data1 =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
> +
> +       if (!data1)
> +               return;
> +
> +       memcpy(data1, (u8 *)&(cfg_data[0]), data_len);
> +       sg_init_one(&sg, data1, 512);
> +
> +       cmd.opcode =3D MMC_WRITE_BLOCK;
> +       cmd.arg =3D 0;
> +       cmd.flags =3D MMC_RSP_R1 | MMC_CMD_ADTC;
> +       data.blksz =3D 512;
> +       data.blocks =3D 1;
> +       data.flags =3D MMC_DATA_WRITE;
> +       data.timeout_ns =3D 1000 * 1000 * 1000;
> +       data.sg =3D &sg;
> +       data.sg_len =3D 1;
> +       mrq.cmd =3D &cmd;
> +       mrq.data =3D &data;
> +       mrq.stop =3D NULL;
> +
> +       mmc_wait_for_req(mmc, &mrq);
> +       kfree(data1);
> +}
> +
> +static void bht_update_cfg(struct mmc_host *mmc_host,
> +       struct mmc_card *card, u32 *cfg_data, int data_len)
> +{
> +       struct sdhci_host *host;
> +
> +       host =3D mmc_priv(mmc_host);
> +       mmc_set_bus_width(mmc_host, MMC_BUS_WIDTH_4);
> +       if (host->ops->reset)
> +               host->ops->reset(host, SDHCI_RESET_CMD|SDHCI_RESET_DATA);
> +
> +       driver_send_command7(host);
> +       driver_send_command24(host, cfg_data, data_len);
> +       driver_send_command7(host);
> +
> +       mmc_set_bus_width(mmc_host, MMC_BUS_WIDTH_1);
> +}
> +
> +
> +static void tx_selb_failed_tb_reset(struct sdhci_host *host)
> +{
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D
> +                                               sdhci_pltfm_priv(pltfm_ho=
st);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +
> +       memset(&ggc->sdr104.tx_selb_tb, 0xff,
> +                       sizeof(ggc->sdr104.tx_selb_tb));
> +       memset(&ggc->sdr50.tx_selb_tb, 0xff,
> +                       sizeof(ggc->sdr50.tx_selb_tb));
> +}
> +
> +static void all_selb_failed_tb_reset(struct sdhci_host *host)
> +{
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D
> +                                               sdhci_pltfm_priv(pltfm_ho=
st);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +
> +       memset(&ggc->sdr104.all_selb_tb, 0xff,
> +                       sizeof(ggc->sdr104.all_selb_tb));
> +       memset(&ggc->sdr50.all_selb_tb, 0xff,
> +                       sizeof(ggc->sdr50.all_selb_tb));
> +}
> +
> +static void tx_selb_failed_history_reset(struct sdhci_host *host)
> +{
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D
> +                                               sdhci_pltfm_priv(pltfm_ho=
st);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +
> +       ggc->sdr50.tx_selb_failed_history =3D BIT_PASS_MASK;
> +       ggc->sdr104.tx_selb_failed_history =3D BIT_PASS_MASK;
> +}
> +
> +static void ggc_reset_selx_failed_tb(struct sdhci_host *host)
> +{
> +       tx_selb_failed_tb_reset(host);
> +       all_selb_failed_tb_reset(host);
> +       tx_selb_failed_history_reset(host);
> +}
> +
> +static void _ggc_reset_sela_tuning_result(
> +                       struct sdhci_msm_host *host)
> +{
> +       int i =3D 0;
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(host);
> +
> +       for (i =3D 0; i < TUNING_PHASE_SIZE; i++)
> +               ggc->ggc_sela_tuning_result[i] =3D NO_TUNING;
> +}
> +
> +static void _ggc_reset_tuning_result_for_dll(struct sdhci_host *host)
> +{
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D
> +                                               sdhci_pltfm_priv(pltfm_ho=
st);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +
> +       ggc_reset_selx_failed_tb(host);
> +       ggc->ggc_cmd_tx_selb_failed_range =3D BIT_PASS_MASK;
> +       ggc->selx_tuning_done_flag =3D 0;
> +       _ggc_reset_sela_tuning_result(vendor_host);
> +}
> +
> +static void ggc_tuning_result_reset(struct sdhci_host *host)
> +{
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D
> +                                               sdhci_pltfm_priv(pltfm_ho=
st);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +
> +       _ggc_reset_tuning_result_for_dll(host);
> +
> +       ggc->sdr50.bus_mode =3D SD_FNC_AM_SDR50;
> +       ggc->sdr104.bus_mode =3D SD_FNC_AM_SDR104;
> +       ggc->driver_strength_reinit_flg =3D 0;
> +       ggc->cur_bus_mode =3D NULL;
> +       ggc->dll_unlock_reinit_flg =3D 0;
> +       ggc->tuning_cmd7_timeout_reinit_flg =3D 0;
> +       ggc->tuning_cmd7_timeout_reinit_cnt =3D 0;
> +       ggc->sdr50_notuning_sela_inject_flag =3D 1;
> +       ggc->sdr50_notuning_crc_error_flag =3D 0;
> +       ggc->sdr50_notuning_sela_rx_inject =3D
> +                                               ggc->bh201_sdr50_sela_sw_=
inject;
> +}
> +
> +static void bht_load_hw_inject(struct mmc_host *mmc_host,
> +       struct mmc_card *card, u32 *cfg_data, int data_len,
> +       u32 sel200, u32 sel100)
> +{
> +       struct sdhci_host *host =3D mmc_priv(mmc_host);
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D
> +                                               sdhci_pltfm_priv(pltfm_ho=
st);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +       u32 gg_hw_inj[16];
> +
> +       memcpy(gg_hw_inj, ggc_cfg_data, sizeof(ggc_cfg_data));
> +       gg_hw_inj[1] =3D 0x7364032;
> +       gg_hw_inj[11] =3D ggc->bh201_sdr104_selb_hw_inject;
> +       gg_hw_inj[12] =3D ggc->bh201_sdr50_selb_hw_inject;
> +       gg_hw_inj[15] =3D ggc->bh201_drive_strength;
> +
> +       bht_update_cfg(mmc_host, card, gg_hw_inj, data_len);
> +}
> +
> +static void bht_load(struct mmc_host *mmc_host, struct mmc_card *card)
> +{
> +       struct sdhci_host *host =3D mmc_priv(mmc_host);
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D
> +                                               sdhci_pltfm_priv(pltfm_ho=
st);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +       u8 driver_strength_reinit_flg =3D
> +                               ggc->driver_strength_reinit_flg;
> +       int cur_dll_voltage_idx =3D ggc->cur_dll_voltage_idx;
> +       u32 i =3D 0;
> +       u32 reg;
> +       u32 gg_sw_def[16];
> +       u8 data[512];
> +       static const int s_dll_voltage_cfg[4][2] =3D {
> +               {0x30503106, 0x64141711},
> +               {0x31503106, 0x64141711},
> +               {0x30503106, 0x64141751},
> +               {0x31503106, 0x64141751},
> +       };
> +
> +       memcpy(gg_sw_def, ggc_cfg_data, sizeof(ggc_cfg_data));
> +
> +       pr_debug("%s: Load BHT patch\n", mmc_hostname(mmc_host));
> +
> +       mmc_send_relative_addr(mmc_host, &card->rca);
> +       mmc_host->card =3D card;
> +       if (ggc->dll_unlock_reinit_flg) {
> +               pr_debug("dll unlock reinit: idx=3D%d\n",
> +                               cur_dll_voltage_idx);
> +               ggc_tuning_result_reset(host);
> +               gg_sw_def[8] =3D s_dll_voltage_cfg[cur_dll_voltage_idx][0=
];
> +               gg_sw_def[9] =3D s_dll_voltage_cfg[cur_dll_voltage_idx][1=
];
> +       }
> +       if (ggc->driver_strength_reinit_flg) {
> +               pr_debug("%s: driver strength should be init to %d\n",
> +                       mmc_hostname(mmc_host), driver_strength_reinit_fl=
g);
> +               ggc_tuning_result_reset(host);
> +               if (ggc->driver_strength_reinit_flg <=3D 7) {
> +                       gg_sw_def[15] &=3D 0x0f0fffff;
> +                       gg_sw_def[15] |=3D (driver_strength_reinit_flg <<=
 28)
> +                                       | (driver_strength_reinit_flg << =
20);
> +               }
> +       }
> +       driver_send_command7(host);
> +       if (ggc->tuning_cmd7_timeout_reinit_flg =3D=3D 0
> +                               && ggc->selx_tuning_done_flag =3D=3D 0) {
> +               bht_load_hw_inject(mmc_host, card, gg_sw_def,
> +                       sizeof(gg_sw_def), 0x3ff, 0x77f);
> +               bht_update_cfg(mmc_host, card, gg_sw_def, sizeof(gg_sw_de=
f));
> +               set_gg_reg_cur_val(ggc, (u8 *)gg_sw_def, sizeof(gg_sw_def=
));
> +       } else {
> +               if (ggc->selx_tuning_done_flag)
> +                       pr_debug("%s: skip load default configuration for=
 tuning done\n",
> +                               mmc_hostname(mmc_host));
> +               if (ggc->tuning_cmd7_timeout_reinit_flg) {
> +                       pr_debug("%s: write previous inject results to bh=
201 for cmd7 timeout flag is set\n",
> +                               mmc_hostname(mmc_host));
> +                       get_gg_reg_cur_val(ggc, data, sizeof(gg_sw_def));
> +
> +                       pr_debug("%s: dump config data before write to bh=
201\n", __func__);
> +                       for (i =3D 0; i < 128; i++) {
> +                               memcpy(&reg, data+i*sizeof(u32), sizeof(u=
32));
> +                               pr_debug("ggc_reg32[%03d]=3D0x%08x\n", i,=
 reg);
> +                       }
> +                       bht_update_cfg(mmc_host, card, (u32 *)data, sizeo=
f(data));
> +               }
> +       }
> +}
> +
>  static void bht_signal_voltage_on_off(struct sdhci_host *host, u32 on_of=
f)
>  {
> +       int card_present_status =3D 0;
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D sdhci_pltfm_priv(pltfm_hos=
t);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +
> +       if (gpio_is_valid(ggc->det_gpio)) {
> +               card_present_status =3D gpio_get_value(ggc->det_gpio);
> +               pr_debug("%s: detect_gpio pin %d status is %d\n",
> +               mmc_hostname(host->mmc), ggc->det_gpio, card_present_stat=
us);
> +       } else {
> +               pr_err("%s: no det_gpio provided\n", mmc_hostname(host->m=
mc));
> +       }
> +
> +       if (on_off) {
> +               pr_debug("%s: apply bht power on patch\n", mmc_hostname(h=
ost->mmc));
> +
> +               ggc_dll_voltage_init(host);
> +
> +               ggc_chip_init(host);
> +
> +               if (gpio_is_valid(ggc->pwr_gpio)) {
> +                       gpio_direction_output(ggc->pwr_gpio, 1);
> +                       msleep(100);
> +                       pr_debug("%s: pwr_gpio pin %d status is %d\n",
> +                               mmc_hostname(host->mmc), ggc->pwr_gpio,
> +                               gpio_get_value(ggc->pwr_gpio));
> +               } else {
> +                       pr_err("%s: no pwr_gpio provided\n", mmc_hostname=
(host->mmc));
> +               }
> +       } else {
> +               pr_debug("%s: apply bht power off patch\n", mmc_hostname(=
host->mmc));
> +
> +               ggc_dll_voltage_init(host);
> +
> +               if (card_present_status <=3D 0) {
> +                       pr_debug("%s: clear tuning result for power off a=
nd card removed\n",
> +                               mmc_hostname(host->mmc));
> +                       ggc_tuning_result_reset(host);
> +               }
> +               ggc_chip_init(host);
> +
> +               if (gpio_is_valid(ggc->pwr_gpio)) {
> +                       gpio_direction_output(ggc->pwr_gpio, 0);
> +                       pr_debug("%s: pwr_gpio pin %d status is %d\n",
> +                       mmc_hostname(host->mmc), ggc->pwr_gpio,
> +                       gpio_get_value(ggc->pwr_gpio));
> +               } else {
> +                       pr_err("%s: no pwr_gpio provided\n", mmc_hostname=
(host->mmc));
> +               }
> +       }
>  }
>
>  static void sdhci_bht_parse(struct mmc_host *mmc_host)
>  {
> +       struct sdhci_host *host =3D mmc_priv(mmc_host);
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D sdhci_pltfm_priv(pltfm_hos=
t);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +       struct device_node *np =3D vendor_host->pdev->dev.of_node;
> +       struct ggc_reg_op index_array[] =3D {
> +               { 14, 0xffffffff, 0 }, { 46, 0xffffffff, 0 },
> +               { 205, 0xffffffff, 0 }, { 237, 0xffffffff, 0 },
> +               { 141, 0xf, 0 }, { 145, 0xf, 0 },
> +               { 83, 0xfff, 0 }, { 95, 0xfff, 0 },
> +               { 126, 0xf, 0 }, { 130, 0xf, 0 },
> +               { 140, 0xf, 0 }, { 144, 0xf, 0 },
> +               { 183, 0x1, 0 }, { 184, 0x1, 0 },
> +               { 171, 0x1, 0 }, { 172, 0x1, 0 },
> +               { 173, 0x3f, 0 }, { 357, 0x1, 0 },
> +               { 93, 0x7ff, 0 }, { 81, 0x7ff, 0 },
> +       };
> +
> +       memcpy(&ggc->pha_stas_rx_low32, &index_array[0],
> +               sizeof(struct ggc_reg_op));
> +       memcpy(&ggc->pha_stas_rx_high32, &index_array[1],
> +               sizeof(struct ggc_reg_op));
> +       memcpy(&ggc->pha_stas_tx_low32, &index_array[2],
> +               sizeof(struct ggc_reg_op));
> +       memcpy(&ggc->pha_stas_tx_high32, &index_array[3],
> +               sizeof(struct ggc_reg_op));
> +       memcpy(&ggc->dll_sela_after_mask, &index_array[4],
> +               sizeof(struct ggc_reg_op));
> +       memcpy(&ggc->dll_selb_after_mask, &index_array[5],
> +               sizeof(struct ggc_reg_op));
> +
> +       memcpy(&ggc->dll_delay_100m_backup, &index_array[6],
> +               sizeof(struct ggc_reg_op));
> +       memcpy(&ggc->dll_delay_200m_backup, &index_array[7],
> +               sizeof(struct ggc_reg_op));
> +
> +       memcpy(&ggc->dll_sela_100m_cfg, &index_array[8],
> +               sizeof(struct ggc_reg_op));
> +       memcpy(&ggc->dll_sela_200m_cfg, &index_array[9],
> +               sizeof(struct ggc_reg_op));
> +       memcpy(&ggc->dll_selb_100m_cfg, &index_array[10],
> +               sizeof(struct ggc_reg_op));
> +       memcpy(&ggc->dll_selb_200m_cfg, &index_array[11],
> +               sizeof(struct ggc_reg_op));
> +       memcpy(&ggc->dll_selb_100m_cfg_en, &index_array[12],
> +               sizeof(struct ggc_reg_op));
> +       memcpy(&ggc->dll_selb_200m_cfg_en, &index_array[13],
> +               sizeof(struct ggc_reg_op));
> +       memcpy(&ggc->internl_tuning_en_100m, &index_array[14],
> +               sizeof(struct ggc_reg_op));
> +       memcpy(&ggc->internl_tuning_en_200m, &index_array[15],
> +               sizeof(struct ggc_reg_op));
> +       memcpy(&ggc->cmd19_cnt_cfg, &index_array[16],
> +               sizeof(struct ggc_reg_op));
> +
> +       memcpy(&ggc->inject_failure_for_tuning_enable_cfg,
> +       &index_array[17], sizeof(struct ggc_reg_op));
> +       memcpy(&ggc->inject_failure_for_200m_tuning_cfg,
> +       &index_array[18], sizeof(struct ggc_reg_op));
> +       memcpy(&ggc->inject_failure_for_100m_tuning_cfg,
> +       &index_array[19], sizeof(struct ggc_reg_op));
> +
> +       ggc->bh201_drive_strength =3D 0x3A314177;
> +       ggc->bh201_sdr50_sela_sw_inject =3D 0x47F;
> +       ggc->bh201_sdr50_selb_hw_inject =3D 0x00725777;
> +       ggc->bh201_sdr104_selb_hw_inject =3D 0x57336200;
> +       host->flags |=3D SDHCI_SDR50_NEEDS_TUNING;
> +       host->mmc_host_ops.init_card =3D bht_load;
> +
> +       if (of_find_property(np, "bh201_drive_strength", NULL))
> +               of_property_read_u32_index(np, "bh201_drive_strength", 0,
> +                       &ggc->bh201_drive_strength);
> +       if (of_find_property(np, "bh201_sdr50_sela_sw_inject", NULL))
> +               of_property_read_u32_index(np, "bh201_sdr50_sela_sw_injec=
t", 0,
> +                       &ggc->bh201_sdr50_sela_sw_inject);
> +       if (of_find_property(np, "bh201_sdr50_selb_hw_inject", NULL))
> +               of_property_read_u32_index(np, "bh201_sdr50_selb_hw_injec=
t", 0,
> +                       &ggc->bh201_sdr50_selb_hw_inject);
> +       if (of_find_property(np, "bh201_sdr104_selb_hw_inject", NULL))
> +               of_property_read_u32_index(np, "bh201_sdr104_selb_hw_inje=
ct", 0,
> +                       &ggc->bh201_sdr104_selb_hw_inject);
> +
> +       ggc->pwr_gpio =3D of_get_named_gpio(np, "pwr-gpios", 0);
> +       if (!gpio_is_valid(ggc->pwr_gpio))
> +               dev_err(&vendor_host->pdev->dev, "no pwr-gpio provided !\=
n");
> +       else
> +               dev_info(&vendor_host->pdev->dev, "pwr-gpio provided\n");
> +
> +       ggc->det_gpio =3D of_get_named_gpio(np, "det-gpios", 0);
> +       if (!gpio_is_valid(ggc->det_gpio))
> +               dev_err(&vendor_host->pdev->dev, "no det-gpio provided !\=
n");
> +       else
> +               dev_info(&vendor_host->pdev->dev, "det-gpio provided\n");
> +
> +       if (gpio_is_valid(ggc->pwr_gpio)) {
> +               devm_gpio_request_one(&vendor_host->pdev->dev, ggc->pwr_g=
pio,
> +                       GPIOF_OUT_INIT_LOW, "sprd-1-pwr");
> +               pr_debug("%s: detect_gpio pin %d\n",
> +                       mmc_hostname(host->mmc), ggc->pwr_gpio);
> +       } else {
> +               pr_err("%s: no detect_gpio provided\n",
> +                       mmc_hostname(host->mmc));
> +       }
> +
> +       if (gpio_is_valid(ggc->det_gpio)) {
> +               devm_gpio_request_one(&vendor_host->pdev->dev, ggc->det_g=
pio,
> +               GPIOF_DIR_IN, "sprd-1-det");
> +               pr_debug("%s: detect_gpio pin %d\n",
> +                       mmc_hostname(host->mmc), ggc->det_gpio);
> +       } else {
> +               pr_err("%s: no detect_gpio provided\n",
> +                       mmc_hostname(host->mmc));
> +       }
>  }
>
>  static void sdhci_bht_resource_free(struct sdhci_msm_host *vendor_host)
>  {
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +       struct platform_device *pdev =3D vendor_host->pdev;
> +
> +       if (gpio_is_valid(ggc->det_gpio))
> +               devm_gpio_free(&pdev->dev, ggc->det_gpio);
> +       if (gpio_is_valid(ggc->pwr_gpio))
> +               devm_gpio_free(&pdev->dev, ggc->pwr_gpio);
>  }
>
> -static void mmc_rescan_bht(struct work_struct *work)
> +/*
> + * The code porting from mmc/core start
> + * We need to porting the code from mmc/core for below reasons:
> + * 1.ACMD42 should be added between Bus width switch and transfer mode s=
witch
> + * 2.Bus width switch should at front of transfer mode switch during mod=
e switch stage
> + * 3.If above two points can be patched to sd.c directly, we can decreas=
e much redundant code
> + * 4.Above changes match with SD host spec, but don=E2=80=99t match with=
 current sd initialazation flow
> + */
> +static const unsigned int freqs[] =3D { 400000, 300000, 200000, 100000 }=
;
> +
> +static int mmc_wait_for_app_cmd(struct mmc_host *host, struct mmc_card *=
card,
> +                               struct mmc_command *cmd)
>  {
> +       struct mmc_request mrq =3D {};
> +       int i, err =3D -EIO;
> +
> +       /*
> +        * We have to resend MMC_APP_CMD for each attempt so
> +        * we cannot use the retries field in mmc_command.
> +        */
> +       for (i =3D 0; i <=3D MMC_CMD_RETRIES; i++) {
> +               err =3D mmc_app_cmd(host, card);
> +               if (err) {
> +                       /* no point in retrying; no APP commands allowed =
*/
> +                       if (mmc_host_is_spi(host)) {
> +                               if (cmd->resp[0] & R1_SPI_ILLEGAL_COMMAND=
)
> +                                       break;
> +                       }
> +                       continue;
> +               }
> +
> +               memset(&mrq, 0, sizeof(struct mmc_request));
> +
> +               memset(cmd->resp, 0, sizeof(cmd->resp));
> +               cmd->retries =3D 0;
> +
> +               mrq.cmd =3D cmd;
> +               cmd->data =3D NULL;
> +
> +               mmc_wait_for_req(host, &mrq);
> +
> +               err =3D cmd->error;
> +               if (!cmd->error)
> +                       break;
> +
> +               /* no point in retrying illegal APP commands */
> +               if (mmc_host_is_spi(host)) {
> +                       if (cmd->resp[0] & R1_SPI_ILLEGAL_COMMAND)
> +                               break;
> +               }
> +       }
> +
> +       return err;
>  }
>
> -static int sdhci_bht_execute_tuning(struct mmc_host *mmc, u32 opcode)
> +static int mmc_app_set_clr_card_detect(struct mmc_card *card)
>  {
> -       int ret =3D 0;
> +       struct mmc_command cmd =3D {};
>
> -       return ret;
> +       cmd.opcode =3D 42;
> +       cmd.flags =3D MMC_RSP_R1 | MMC_CMD_AC;
> +
> +       return mmc_wait_for_app_cmd(card->host, card, &cmd);
> +}
> +/*
> + * UHS-I specific initialization procedure
> + */
> +static int mmc_sd_init_uhs_card_bayhub(struct mmc_card *card)
> +{
> +       int err;
> +       u8 *status;
> +
> +       if (!(card->csd.cmdclass & CCC_SWITCH))
> +               return 0;
> +
> +       status =3D kmalloc(64, GFP_KERNEL);
> +       if (!status)
> +               return -ENOMEM;
> +
> +       /* Set 4-bit bus width */
> +       err =3D mmc_app_set_bus_width(card, MMC_BUS_WIDTH_4);
> +       if (err)
> +               goto out;
> +
> +       mmc_set_bus_width(card->host, MMC_BUS_WIDTH_4);
> +
> +       /*
> +        * Select the bus speed mode depending on host
> +        * and card capability.
> +        */
> +       sd_update_bus_speed_mode(card);
> +
> +       /* GGC chip need this command to switch mode */
> +       mmc_app_set_clr_card_detect(card);
> +
> +       /* Set the driver strength for the card */
> +       err =3D sd_select_driver_type(card, status);
> +       if (err)
> +               goto out;
> +
> +       /* Set current limit for the card */
> +       err =3D sd_set_current_limit(card, status);
> +       if (err)
> +               goto out;
> +
> +       /* Set bus speed mode of the card */
> +       err =3D sd_set_bus_speed_mode(card, status);
> +       if (err)
> +               goto out;
> +
> +       /*
> +        * SPI mode doesn't define CMD19 and tuning is only valid for SDR=
50 and
> +        * SDR104 mode SD-cards. Note that tuning is mandatory for SDR104=
.
> +        */
> +       if (!mmc_host_is_spi(card->host) &&
> +               (card->host->ios.timing =3D=3D MMC_TIMING_UHS_SDR50 ||
> +                card->host->ios.timing =3D=3D MMC_TIMING_UHS_DDR50 ||
> +                card->host->ios.timing =3D=3D MMC_TIMING_UHS_SDR104)) {
> +               err =3D mmc_execute_tuning(card);
> +
> +               /*
> +                * As SD Specifications Part1 Physical Layer Specificatio=
n
> +                * Version 3.01 says, CMD19 tuning is available for unloc=
ked
> +                * cards in transfer state of 1.8V signaling mode. The sm=
all
> +                * difference between v3.00 and 3.01 spec means that CMD1=
9
> +                * tuning is also available for DDR50 mode.
> +                */
> +               if (err && card->host->ios.timing =3D=3D MMC_TIMING_UHS_D=
DR50) {
> +                       pr_warn("%s: ddr50 tuning failed\n",
> +                               mmc_hostname(card->host));
> +                       err =3D 0;
> +               }
> +       }
> +
> +out:
> +       kfree(status);
> +
> +       return err;
> +}
> +
> +/*
> + * Handle the detection and initialisation of a card.
> + *
> + * In the case of a resume, "oldcard" will contain the card
> + * we're trying to reinitialise.
> + */
> +static int mmc_sd_init_card_bayhub(struct mmc_host *host, u32 ocr,
> +       struct mmc_card *oldcard)
> +{
> +       struct mmc_card *card;
> +       int err;
> +       u32 cid[4];
> +       u32 rocr =3D 0;
> +       bool v18_fixup_failed =3D false;
> +
> +       WARN_ON(!host->claimed);
> +retry:
> +       err =3D mmc_sd_get_cid(host, ocr, cid, &rocr);
> +       if (err)
> +               return err;
> +
> +       if (oldcard) {
> +               if (memcmp(cid, oldcard->raw_cid, sizeof(cid)) !=3D 0) {
> +                       pr_debug("%s: Perhaps the card was replaced\n",
> +                               mmc_hostname(host));
> +                       return -ENOENT;
> +               }
> +
> +               card =3D oldcard;
> +       } else {
> +               /*
> +                * Allocate card structure.
> +                */
> +               card =3D mmc_alloc_card(host, &sd_type);
> +               if (IS_ERR(card))
> +                       return PTR_ERR(card);
> +
> +               card->ocr =3D ocr;
> +               card->type =3D MMC_TYPE_SD;
> +               memcpy(card->raw_cid, cid, sizeof(card->raw_cid));
> +       }
> +
> +       /*
> +        * Call the optional HC's init_card function to handle quirks.
> +        */
> +       if (host->ops->init_card)
> +               host->ops->init_card(host, card);
> +
> +       /*
> +        * For native busses:  get card RCA and quit open drain mode.
> +        */
> +       if (!mmc_host_is_spi(host)) {
> +               err =3D mmc_send_relative_addr(host, &card->rca);
> +               if (err)
> +                       goto free_card;
> +       }
> +
> +       if (!oldcard) {
> +               err =3D mmc_sd_get_csd(card);
> +               if (err)
> +                       goto free_card;
> +
> +               mmc_decode_cid(card);
> +       }
> +
> +       /*
> +        * handling only for cards supporting DSR and hosts requesting
> +        * DSR configuration
> +        */
> +       if (card->csd.dsr_imp && host->dsr_req)
> +               mmc_set_dsr(host);
> +
> +       /*
> +        * Select card, as all following commands rely on that.
> +        */
> +       if (!mmc_host_is_spi(host)) {
> +               err =3D mmc_select_card(card);
> +               if (err)
> +                       goto free_card;
> +       }
> +
> +       err =3D mmc_sd_setup_card(host, card, oldcard !=3D NULL);
> +       if (err)
> +               goto free_card;
> +
> +       /*
> +        * If the card has not been power cycled, it may still be using 1=
.8V
> +        * signaling. Detect that situation and try to initialize a UHS-I=
 (1.8V)
> +        * transfer mode.
> +        */
> +       if (!v18_fixup_failed && !mmc_host_is_spi(host) && mmc_host_uhs(h=
ost) &&
> +           mmc_sd_card_using_v18(card) &&
> +           host->ios.signal_voltage !=3D MMC_SIGNAL_VOLTAGE_180) {
> +               /*
> +                * Re-read switch information in case it has changed sinc=
e
> +                * oldcard was initialized.
> +                */
> +               if (oldcard) {
> +                       err =3D mmc_read_switch(card);
> +                       if (err)
> +                               goto free_card;
> +               }
> +               if (mmc_sd_card_using_v18(card)) {
> +                       if (mmc_host_set_uhs_voltage(host) ||
> +                           mmc_sd_init_uhs_card_bayhub(card)) {
> +                               v18_fixup_failed =3D true;
> +                               mmc_power_cycle(host, ocr);
> +                               if (!oldcard)
> +                                       mmc_remove_card(card);
> +                               goto retry;
> +                       }
> +                       goto done;
> +               }
> +       }
> +
> +       /* Initialization sequence for UHS-I cards */
> +       if (rocr & SD_ROCR_S18A && mmc_host_uhs(host)) {
> +               err =3D mmc_sd_init_uhs_card_bayhub(card);
> +               if (err)
> +                       goto free_card;
> +       } else {
> +               /*
> +                * Switch to wider bus (if supported).
> +                * Bayhub patch move mmc_app_set_bus_width in front of mm=
c_sd_switch_hs
> +                */
> +               if ((host->caps & MMC_CAP_4_BIT_DATA) &&
> +                       (card->scr.bus_widths & SD_SCR_BUS_WIDTH_4)) {
> +                       err =3D mmc_app_set_bus_width(card, MMC_BUS_WIDTH=
_4);
> +                       if (err)
> +                               goto free_card;
> +
> +                       mmc_set_bus_width(host, MMC_BUS_WIDTH_4);
> +               }
> +
> +               /* GGC chip need this command to switch mode */
> +               mmc_app_set_clr_card_detect(card);
> +
> +               /*
> +                * Attempt to change to high-speed (if supported)
> +                */
> +               err =3D mmc_sd_switch_hs(card);
> +               if (err > 0)
> +                       mmc_set_timing(card->host, MMC_TIMING_SD_HS);
> +               else if (err)
> +                       goto free_card;
> +
> +               /*
> +                * Set bus speed.
> +                */
> +               mmc_set_clock(host, mmc_sd_get_max_clock(card));
> +       }
> +
> +       if (!oldcard) {
> +               /* Read/parse the extension registers. */
> +               err =3D sd_read_ext_regs(card);
> +               if (err)
> +                       goto free_card;
> +       }
> +
> +       /* Enable internal SD cache if supported. */
> +       if (card->ext_perf.feature_support & SD_EXT_PERF_CACHE) {
> +               err =3D sd_enable_cache(card);
> +               if (err)
> +                       goto free_card;
> +       }
> +
> +       if (host->cqe_ops && !host->cqe_enabled) {
> +               err =3D host->cqe_ops->cqe_enable(host, card);
> +               if (!err) {
> +                       host->cqe_enabled =3D true;
> +                       host->hsq_enabled =3D true;
> +                       pr_info("%s: Host Software Queue enabled\n",
> +                               mmc_hostname(host));
> +               }
> +       }
> +
> +       if (host->caps2 & MMC_CAP2_AVOID_3_3V &&
> +           host->ios.signal_voltage =3D=3D MMC_SIGNAL_VOLTAGE_330) {
> +               pr_err("%s: Host failed to negotiate down from 3.3V\n",
> +                       mmc_hostname(host));
> +               err =3D -EINVAL;
> +               goto free_card;
> +       }
> +done:
> +       host->card =3D card;
> +       return 0;
> +
> +free_card:
> +       if (!oldcard)
> +               mmc_remove_card(card);
> +
> +       return err;
> +}
> +
> +static int mmc_sd_hw_reset_bayhub(struct mmc_host *host)
> +{
> +       mmc_power_cycle(host, host->card->ocr);
> +       return mmc_sd_init_card_bayhub(host, host->card->ocr, host->card)=
;
> +}
> +
> +static const struct mmc_bus_ops mmc_sd_ops_bayhub =3D {
> +       .remove =3D mmc_sd_remove,
> +       .detect =3D mmc_sd_detect,
> +       .runtime_suspend =3D mmc_sd_runtime_suspend,
> +       .runtime_resume =3D mmc_sd_runtime_resume,
> +       .suspend =3D mmc_sd_suspend,
> +       .resume =3D mmc_sd_resume,
> +       .alive =3D mmc_sd_alive,
> +       .shutdown =3D mmc_sd_suspend,
> +       .hw_reset =3D mmc_sd_hw_reset_bayhub,
> +       .cache_enabled =3D sd_cache_enabled,
> +       .flush_cache =3D sd_flush_cache,
> +};
> +
> +/*
> + * Starting point for SD card init.
> + */
> +static int mmc_attach_sd_bayhub(struct mmc_host *host)
> +{
> +       int err;
> +       u32 ocr, rocr;
> +
> +       WARN_ON(!host->claimed);
> +
> +       err =3D mmc_send_app_op_cond(host, 0, &ocr);
> +       if (err)
> +               return err;
> +
> +       mmc_attach_bus(host, &mmc_sd_ops_bayhub);
> +
> +       if (host->ocr_avail_sd)
> +               host->ocr_avail =3D host->ocr_avail_sd;
> +
> +       /*
> +        * We need to get OCR a different way for SPI.
> +        */
> +       if (mmc_host_is_spi(host)) {
> +               mmc_go_idle(host);
> +
> +               err =3D mmc_spi_read_ocr(host, 0, &ocr);
> +               if (err)
> +                       goto err;
> +       }
> +
> +       /*
> +        * Some SD cards claims an out of spec VDD voltage range. Let's t=
reat
> +        * these bits as being in-valid and especially also bit7.
> +        */
> +       ocr &=3D ~0x7FFF;
> +
> +       rocr =3D mmc_select_voltage(host, ocr);
> +
> +       /*
> +        * Can we support the voltage(s) of the card(s)?
> +        */
> +       if (!rocr) {
> +               err =3D -EINVAL;
> +               goto err;
> +       }
> +
> +       /*
> +        * Detect and init the card.
> +        */
> +       err =3D mmc_sd_init_card_bayhub(host, rocr, NULL);
> +       if (err)
> +               goto err;
> +
> +       mmc_release_host(host);
> +       err =3D mmc_add_card(host->card);
> +       if (err)
> +               goto remove_card;
> +
> +       mmc_claim_host(host);
> +       return 0;
> +
> +remove_card:
> +       mmc_remove_card(host->card);
> +       host->card =3D NULL;
> +       mmc_claim_host(host);
> +err:
> +       mmc_detach_bus(host);
> +
> +       pr_err("%s: error %d whilst initialising SD card\n",
> +               mmc_hostname(host), err);
> +
> +       return err;
> +}
> +
> +static int mmc_schedule_delayed_work(struct delayed_work *work,
> +                                    unsigned long delay)
> +{
> +       /*
> +        * We use the system_freezable_wq, because of two reasons.
> +        * First, it allows several works (not the same work item) to be
> +        * executed simultaneously. Second, the queue becomes frozen when
> +        * userspace becomes frozen during system PM.
> +        */
> +       return queue_delayed_work(system_freezable_wq, work, delay);
> +}
> +
> +static void mmc_hw_reset_for_init(struct mmc_host *host)
> +{
> +       mmc_pwrseq_reset(host);
> +
> +       if (!(host->caps & MMC_CAP_HW_RESET) || !host->ops->hw_reset)
> +               return;
> +       host->ops->hw_reset(host);
> +}
> +
> +static int mmc_rescan_try_freq(struct mmc_host *host, unsigned int freq)
> +{
> +       host->f_init =3D freq;
> +
> +       pr_debug("%s: %s: trying to init card at %u Hz\n",
> +               mmc_hostname(host), __func__, host->f_init);
> +
> +       mmc_power_up(host, host->ocr_avail);
> +
> +       /*
> +        * Some eMMCs (with VCCQ always on) may not be reset after power =
up, so
> +        * do a hardware reset if possible.
> +        */
> +       mmc_hw_reset_for_init(host);
> +
> +       /*
> +        * sdio_reset sends CMD52 to reset card.  Since we do not know
> +        * if the card is being re-initialized, just send it.  CMD52
> +        * should be ignored by SD/eMMC cards.
> +        * Skip it if we already know that we do not support SDIO command=
s
> +        */
> +       if (!(host->caps2 & MMC_CAP2_NO_SDIO))
> +               sdio_reset(host);
> +
> +       mmc_go_idle(host);
> +
> +       if (!(host->caps2 & MMC_CAP2_NO_SD)) {
> +               if (mmc_send_if_cond_pcie(host, host->ocr_avail))
> +                       goto out;
> +               if (mmc_card_sd_express(host))
> +                       return 0;
> +       }
> +
> +       /* Order's important: probe SDIO, then SD, then MMC */
> +       if (!(host->caps2 & MMC_CAP2_NO_SDIO))
> +               if (!mmc_attach_sdio(host))
> +                       return 0;
> +
> +       if (!(host->caps2 & MMC_CAP2_NO_SD))
> +               if (!mmc_attach_sd_bayhub(host))
> +                       return 0;
> +
> +       if (!(host->caps2 & MMC_CAP2_NO_MMC))
> +               if (!mmc_attach_mmc(host))
> +                       return 0;
> +
> +out:
> +       mmc_power_off(host);
> +       return -EIO;
>  }
>
> +static void mmc_rescan_bht(struct work_struct *work)
> +{
> +       struct mmc_host *host =3D
> +               container_of(work, struct mmc_host, detect.work);
> +       int i;
> +
> +       if (host->rescan_disable)
> +               return;
> +
> +       /* If there is a non-removable card registered, only scan once */
> +       if (!mmc_card_is_removable(host) && host->rescan_entered)
> +               return;
> +       host->rescan_entered =3D 1;
> +
> +       if (host->trigger_card_event && host->ops->card_event) {
> +               mmc_claim_host(host);
> +               host->ops->card_event(host);
> +               mmc_release_host(host);
> +               host->trigger_card_event =3D false;
> +       }
> +
> +       /* Verify a registered card to be functional, else remove it. */
> +       if (host->bus_ops)
> +               host->bus_ops->detect(host);
> +
> +       host->detect_change =3D 0;
> +
> +       /* if there still is a card present, stop here */
> +       if (host->bus_ops !=3D NULL)
> +               goto out;
> +
> +       mmc_claim_host(host);
> +       if (mmc_card_is_removable(host) && host->ops->get_cd &&
> +                       host->ops->get_cd(host) =3D=3D 0) {
> +               mmc_power_off(host);
> +               mmc_release_host(host);
> +               goto out;
> +       }
> +
> +       /* If an SD express card is present, then leave it as is. */
> +       if (mmc_card_sd_express(host)) {
> +               mmc_release_host(host);
> +               goto out;
> +       }
> +
> +       for (i =3D 0; i < ARRAY_SIZE(freqs); i++) {
> +               unsigned int freq =3D freqs[i];
> +
> +               if (freq > host->f_max) {
> +                       if (i + 1 < ARRAY_SIZE(freqs))
> +                               continue;
> +                       freq =3D host->f_max;
> +               }
> +               if (!mmc_rescan_try_freq(host, max(freq, host->f_min)))
> +                       break;
> +               if (freqs[i] <=3D host->f_min)
> +                       break;
> +       }
> +       mmc_release_host(host);
> +
> + out:
> +       if (host->caps & MMC_CAP_NEEDS_POLL)
> +               mmc_schedule_delayed_work(&host->detect, HZ);
> +}
> +
> +/* The code porting from mmc/core end */
> +
> +/*
> + * The APIs used to select good timing and configure GGC chip
> + */
> +static int card_deselect_card(struct sdhci_host *host)
> +{
> +       int ret =3D -1;
> +       int err;
> +       struct mmc_host *mmc =3D host->mmc;
> +       struct mmc_command cmd =3D { 0 };
> +
> +       cmd.opcode =3D MMC_SELECT_CARD;
> +       cmd.arg =3D 0;
> +       cmd.flags =3D MMC_RSP_NONE | MMC_CMD_AC;
> +
> +       err =3D mmc_wait_for_cmd(mmc, &cmd, 3);
> +       if (err)
> +               pr_err("BHT ERR: CMD7 FAIL: err =3D %d\n", err);
> +       else
> +               ret =3D 0;
> +
> +       return ret;
> +}
> +
> +static bool enter_exit_emulator_mode(struct sdhci_host *host, bool b_ent=
er)
> +{
> +       bool ret =3D false;
> +       u8 times =3D b_enter ? 2 : 1;
> +       u8 i =3D 0;
> +
> +       for (i =3D 0; i < times; i++) {
> +               ret =3D card_deselect_card(host);
> +               if (ret)
> +                       break;
> +       }
> +       return ret;
> +}
> +
> +static bool _gg_emulator_read_only(struct sdhci_host *host,
> +                                  u8 *in_data, u32 datalen)
> +{
> +       struct mmc_host *mmc =3D host->mmc;
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D sdhci_pltfm_priv(pltfm_hos=
t);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +       int rc =3D 0;
> +       u8 *data1 =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
> +       struct mmc_request mrq =3D { 0 };
> +       struct mmc_command cmd =3D { 0 };
> +       struct mmc_data data =3D { 0 };
> +       struct scatterlist sg;
> +
> +       if (!data1) {
> +               pr_err("BHT MSG:gg read no memory\n");
> +               rc =3D -ENOMEM;
> +               goto out;
> +       }
> +
> +       sg_init_one(&sg, data1, 512);
> +
> +       cmd.opcode =3D MMC_READ_SINGLE_BLOCK;
> +       cmd.arg =3D 0;
> +       cmd.flags =3D MMC_RSP_R1 | MMC_CMD_ADTC;
> +       data.blksz =3D 512;
> +       data.blocks =3D 1;
> +       data.flags =3D MMC_DATA_READ;
> +       data.timeout_ns =3D 1000 * 1000 * 1000;
> +       data.sg =3D &sg;
> +       data.sg_len =3D 1;
> +       mrq.cmd =3D &cmd;
> +       mrq.data =3D &data;
> +       mrq.stop =3D NULL;
> +
> +       mmc_wait_for_req(mmc, &mrq);
> +       memcpy(in_data, data1, datalen);
> +
> +       kfree(data1);
> +
> +       if ((cmd.error =3D=3D -EILSEQ) || (data.error =3D=3D -EILSEQ))
> +               ggc->sdr50_notuning_crc_error_flag =3D 1;
> +
> +       if (cmd.error || data.error)
> +               rc =3D -1;
> +out:
> +       return rc;
> +}
> +
> +static void host_cmddat_line_reset(struct sdhci_host *host)
> +{
> +       if (host->ops->reset)
> +               host->ops->reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA=
);
> +}
> +
> +static int gg_select_card_spec(struct sdhci_host *host)
> +{
> +       int err;
> +       struct mmc_command cmd =3D { 0 };
> +       struct mmc_card *card =3D host->mmc->card;
> +
> +       cmd.opcode =3D MMC_SELECT_CARD;
> +
> +       if (card) {
> +               cmd.arg =3D card->rca << 16;
> +               cmd.flags =3D MMC_RSP_R1 | MMC_CMD_AC;
> +       } else {
> +               cmd.arg =3D 0;
> +               cmd.flags =3D MMC_RSP_NONE | MMC_CMD_AC;
> +       }
> +
> +       err =3D mmc_wait_for_cmd(host->mmc, &cmd, 0);
> +       if (err =3D=3D -EILSEQ) {
> +               host_cmddat_line_reset(host);
> +
> +               memset(&cmd, 0, sizeof(struct mmc_command));
> +               cmd.opcode =3D 5;
> +               cmd.arg =3D 0;
> +               cmd.flags =3D
> +                       MMC_RSP_SPI_R4 | MMC_RSP_R4 | MMC_CMD_BCR;
> +
> +               mmc_wait_for_cmd(host->mmc, &cmd, 0);
> +
> +               pr_err("BHT ERR:%s: CMD7 CRC\n", __func__);
> +               host_cmddat_line_reset(host);
> +               return 0;
> +       }
> +       if (err =3D=3D -ETIMEDOUT) {
> +               pr_err("BHT ERR:%s: CMD7 timeout\n", __func__);
> +               host_cmddat_line_reset(host);
> +               return err;
> +       }
> +       return 0;
> +}
> +
> +static bool gg_emulator_read_ext(struct sdhci_host *host, bool *card_sta=
tus,
> +                                       bool *read_status, u8 *data, u32 =
datalen)
> +{
> +       bool ret =3D false;
> +       bool card_ret =3D true;
> +       bool rd_ret =3D false;
> +
> +       if (enter_exit_emulator_mode(host, true) =3D=3D 0)
> +               ret =3D true;
> +       else
> +               ret =3D false;
> +       if (!ret)
> +               goto exit;
> +
> +       if (_gg_emulator_read_only(host, data, datalen) =3D=3D 0)
> +               rd_ret =3D true;
> +       else
> +               rd_ret =3D false;
> +
> +       if (enter_exit_emulator_mode(host, false) =3D=3D 0)
> +               ret =3D true;
> +       else
> +               ret =3D false;
> +
> +       if (!ret)
> +               goto exit;
> +
> +       if (gg_select_card_spec(host) =3D=3D 0)
> +               card_ret =3D true;
> +       else
> +               card_ret =3D false;
> +
> +       if (!rd_ret)
> +               pr_err("BHT ERR:GGC read status error\n");
> +
> +exit:
> +       if (!card_ret) {
> +               pr_err("BHT ERR:GGC Emulator exit Fail!!\n");
> +               ret =3D false;
> +       }
> +
> +       if (card_status)
> +               *card_status =3D ret;
> +
> +       if (read_status)
> +               *read_status =3D rd_ret;
> +
> +       if (rd_ret && !ret)
> +               pr_err("BHT ERR:data read ok, but exit NG\n");
> +       else if (!rd_ret && ret)
> +               pr_err("BHT ERR:data read NG, but exit ok\n");
> +
> +       return ret;
> +}
> +
> +static void _status_bit_2_bt(int tar, int *byt, int *bit)
> +{
> +       *byt =3D tar / 8;
> +       *bit =3D tar % 8;
> +}
> +
> +static u32 _read_status_data_read_register(u8 *cfg, struct ggc_reg_op *b=
ts)
> +{
> +       u32 rv =3D 0;
> +       u32 msk =3D bts->mask;
> +       int byt =3D 0, bit =3D 0;
> +       int i =3D 0;
> +
> +       do {
> +               _status_bit_2_bt(bts->ofs + i, &byt, &bit);
> +               if (cfg[byt] & (1 << bit))
> +                       rv |=3D 1 << i;
> +
> +               i++;
> +               msk >>=3D 1;
> +               if (msk =3D=3D 0)
> +                       break;
> +       } while (1);
> +       return rv;
> +}
> +
> +static bool ggc_read_registers_ext(struct sdhci_host *host,
> +               bool *card_status, bool *read_status,
> +               struct ggc_reg_op *gg_reg_arr, u8 num)
> +{
> +       u8 get_idx =3D 0;
> +       bool ret =3D false;
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D sdhci_pltfm_priv(pltfm_hos=
t);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +
> +       if (read_status)
> +               *read_status =3D false;
> +       if (card_status)
> +               *card_status =3D false;
> +
> +       memset(ggc->cur_read_buf, 0, 512);
> +       ret =3D gg_emulator_read_ext(host, card_status, read_status, ggc-=
>cur_read_buf, 512);
> +       if (read_status =3D=3D false)
> +               goto exit;
> +
> +       for (get_idx =3D 0; get_idx < num; get_idx++)
> +               (gg_reg_arr + get_idx)->value =3D
> +                       _read_status_data_read_register(ggc->cur_read_buf=
, (gg_reg_arr + get_idx));
> +
> +exit:
> +       return ret;
> +}
> +
> +static bool gg_emulator_read(struct sdhci_host *host, u8 *data, u32 data=
len)
> +{
> +       bool ret =3D false;
> +       bool rd_ret =3D false;
> +
> +       ret =3D enter_exit_emulator_mode(host, true);
> +       if (ret)
> +               goto exit;
> +
> +       rd_ret =3D _gg_emulator_read_only(host, data, datalen);
> +
> +       ret =3D enter_exit_emulator_mode(host, false);
> +       if (ret)
> +               goto exit;
> +
> +       ret =3D gg_select_card_spec(host);
> +
> +exit:
> +       if (rd_ret)
> +               pr_err("BHT ERR:GGC read status error\n");
> +
> +       if (ret)
> +               pr_err("BHT ERR:GGC Emulator exit Fail!!\n");
> +
> +       if (rd_ret =3D=3D 0 && ret) {
> +               pr_err("BHT ERR:data read ok, but exit NG\n");
> +               ret =3D 0;
> +       }
> +
> +       if (rd_ret && ret =3D=3D 0) {
> +               pr_err("BHT ERR:data read NG, but exit ok\n");
> +               ret =3D -1;
> +       }
> +
> +       return ret ? false : true;
> +}
> +
> +static bool _ggc_emulator_write_only(struct sdhci_host *host,
> +                                    u8 *in_data, u32 datalen)
> +{
> +       struct mmc_host *mmc =3D host->mmc;
> +       int rc =3D 0;
> +       u8 *data1 =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
> +       struct mmc_request mrq =3D { 0 };
> +       struct mmc_command cmd =3D { 0 };
> +       struct mmc_data data =3D { 0 };
> +       struct scatterlist sg;
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D sdhci_pltfm_priv(pltfm_hos=
t);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +
> +       if (!data1) {
> +               pr_err("BHT MSG:gg write no memory\n");
> +               rc =3D -ENOMEM;
> +               goto out;
> +       }
> +
> +       memcpy(data1, in_data, datalen);
> +       sg_init_one(&sg, data1, 512);
> +
> +       cmd.opcode =3D MMC_WRITE_BLOCK;
> +       cmd.arg =3D 0;
> +       cmd.flags =3D MMC_RSP_R1 | MMC_CMD_ADTC;
> +       data.blksz =3D 512;
> +       data.blocks =3D 1;
> +       data.flags =3D MMC_DATA_WRITE;
> +       data.timeout_ns =3D 1000 * 1000 * 1000;
> +       data.sg =3D &sg;
> +       data.sg_len =3D 1;
> +       mrq.cmd =3D &cmd;
> +       mrq.data =3D &data;
> +       mrq.stop =3D NULL;
> +
> +       mmc_wait_for_req(mmc, &mrq);
> +
> +       if (cmd.error =3D=3D -EILSEQ)
> +               ggc->sdr50_notuning_crc_error_flag =3D 1;
> +
> +       kfree(data1);
> +out:
> +       return rc;
> +}
> +
> +static bool gg_emulator_write(struct sdhci_host *host, u8 *data, u32 dat=
alen)
> +{
> +       bool ret =3D false;
> +       bool wr_ret =3D false;
> +       u32 i =3D 0;
> +       u32 reg;
> +
> +       ret =3D enter_exit_emulator_mode(host, true);
> +       if (ret)
> +               goto exit;
> +
> +       pr_debug("BHT MSG: dump config data\n");
> +       for (i =3D 0; i < (datalen/sizeof(u32)); i++)     {
> +               memcpy(&reg, data+i*sizeof(u32), sizeof(u32));
> +               pr_debug("BHT MSG:\tggc_reg32[%03d]=3D0x%08x\n", i, reg);
> +       }
> +
> +       _ggc_emulator_write_only(host, data, datalen);
> +       wr_ret =3D true;
> +
> +       ret =3D enter_exit_emulator_mode(host, false);
> +       if (ret)
> +               goto exit;
> +
> +       ret =3D gg_select_card_spec(host);
> +
> +exit:
> +       if (wr_ret =3D=3D false)
> +               ret =3D false;
> +
> +       if (ret =3D=3D false)
> +               pr_err("BHT ERR:%s: GGC Emulator Write Fail!!\n", __func_=
_);
> +
> +       return ret;
> +}
> +
> +static bool get_gg_reg_cur(struct sdhci_host *host, u8 *data,
> +                   struct ggc_reg_op *gg_reg_arr, u8 num)
> +{
> +       u8 get_idx =3D 0;
> +       bool ret =3D false;
> +
> +       /* read ggc register */
> +       memset(data, 0, 512);
> +       ret =3D gg_emulator_read(host, data, 512);
> +
> +       if (ret =3D=3D false)
> +               goto exit;
> +
> +       /* read the offset bits value */
> +       for (get_idx =3D 0; get_idx < num; get_idx++) {
> +               (gg_reg_arr + get_idx)->value =3D
> +                   read_ram_bits_ofs_mask(data, (gg_reg_arr + get_idx));
> +       }
> +exit:
> +       return ret;
> +}
> +
> +static void chg_gg_reg_cur_val(struct sdhci_bht_host  *ggc, u8 *data,
> +       struct ggc_reg_op *gg_reg_arr, u8 num, bool b_sav_chg)
> +{
> +       u8 chg_idx =3D 0;
> +
> +       for (chg_idx =3D 0; chg_idx < num; chg_idx++) {
> +               /* modify the ggc register bit value */
> +               cfg_write_bits_ofs_mask(data, (gg_reg_arr + chg_idx),
> +                                       (gg_reg_arr + chg_idx)->value);
> +       }
> +
> +       if (b_sav_chg)
> +               set_gg_reg_cur_val(ggc, data, 64);
> +}
> +
> +static void log_bin(u32 n)
> +{
> +       int i =3D 0;
> +       u8 tb[33] =3D { 0 };
> +
> +       for (i =3D 0; i < 32; i++) {
> +               if (n & (1 << i))
> +                       tb[i] =3D '1';
> +               else
> +                       tb[i] =3D '0';
> +       }
> +       pr_debug("BHT MSG:bin:%s\n", tb);
> +}
> +
> +static void phase_str(u8 *tb, u32 n)
> +{
> +       int i =3D 0;
> +
> +       for (i =3D 0; i < TUNING_PHASE_SIZE; i++) {
> +               if (n & (1 << i))
> +                       tb[i] =3D '1';
> +               else
> +                       tb[i] =3D '0';
> +       }
> +       tb[TUNING_PHASE_SIZE] =3D 0;
> +}
> +
> +static int get_bit_number(u32 n)
> +{
> +       int i =3D 0;
> +       int cnt =3D 0;
> +
> +       for (i =3D 0; i < TUNING_PHASE_SIZE; i++) {
> +               if (n & (1 << i))
> +                       cnt++;
> +       }
> +       return cnt;
> +}
> +
> +static bool gg_emulator_write_ext(struct sdhci_host *host, bool *card_st=
atus, u8 *data, u32 datalen)
> +{
> +       bool ret =3D false;
> +       bool wr_ret =3D false;
> +
> +       ret =3D enter_exit_emulator_mode(host, true);
> +       if (ret)
> +               goto exit;
> +
> +       _ggc_emulator_write_only(host, data, datalen);
> +       wr_ret =3D true;
> +
> +       ret =3D enter_exit_emulator_mode(host, false);
> +       if (ret)
> +               goto exit;
> +
> +       ret =3D (gg_select_card_spec(host) =3D=3D 0) ? true : false;
> +       if (ret =3D=3D false) {
> +               if (card_status)
> +                       *card_status =3D false;
> +       }
> +
> +exit:
> +       if (wr_ret =3D=3D false)
> +               ret =3D false;
> +
> +       if (ret =3D=3D false)
> +               pr_err("BHT ERR:%s: GGC Emulator Write Fail!!\n", __func_=
_);
> +
> +       return ret;
> +}
> +
> +static bool ggc_set_output_tuning_phase_ext(struct sdhci_host *host,
> +               bool *card_status, int sela, int selb)
> +{
> +       bool ret =3D true;
> +       u8 data[512] =3D { 0 };
> +       struct ggc_reg_op gg_reg_arr[8];
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D sdhci_pltfm_priv(pltfm_hos=
t);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +
> +       get_gg_reg_cur_val(ggc, data, 64);
> +       memcpy(&gg_reg_arr[0], &ggc->dll_sela_100m_cfg,
> +                       sizeof(struct ggc_reg_op));
> +       memcpy(&gg_reg_arr[1], &ggc->dll_sela_200m_cfg,
> +                       sizeof(struct ggc_reg_op));
> +       memcpy(&gg_reg_arr[2], &ggc->dll_selb_100m_cfg,
> +                       sizeof(struct ggc_reg_op));
> +       memcpy(&gg_reg_arr[3], &ggc->dll_selb_200m_cfg,
> +                       sizeof(struct ggc_reg_op));
> +       memcpy(&gg_reg_arr[4], &ggc->dll_selb_100m_cfg_en,
> +                       sizeof(struct ggc_reg_op));
> +       memcpy(&gg_reg_arr[5], &ggc->dll_selb_200m_cfg_en,
> +                       sizeof(struct ggc_reg_op));
> +       memcpy(&gg_reg_arr[6], &ggc->internl_tuning_en_100m,
> +                 sizeof(struct ggc_reg_op));
> +       memcpy(&gg_reg_arr[7], &ggc->internl_tuning_en_200m,
> +                 sizeof(struct ggc_reg_op));
> +       gg_reg_arr[0].value =3D sela;
> +       gg_reg_arr[1].value =3D sela;
> +       gg_reg_arr[2].value =3D selb;
> +       gg_reg_arr[3].value =3D selb;
> +       gg_reg_arr[4].value =3D 1;
> +       gg_reg_arr[5].value =3D 1;
> +       gg_reg_arr[6].value =3D 1;
> +       gg_reg_arr[7].value =3D 1;
> +       if (card_status)
> +               *card_status =3D true;
> +       chg_gg_reg_cur_val(ggc, data, gg_reg_arr, 8, true);
> +       ret =3D gg_emulator_write_ext(host, card_status, data, 512);
> +       return ret;
> +}
> +
> +static bool gg_fix_output_tuning_phase(struct sdhci_host *host, int sela=
, int selb)
> +{
> +       u8 data[512] =3D { 0 };
> +       struct ggc_reg_op gg_reg_arr[10];
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D sdhci_pltfm_priv(pltfm_hos=
t);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +
> +       pr_debug("BHT MSG: %s - sela dll: %x, selb dll: %x\n", __func__, =
sela,
> +               selb);
> +
> +       get_gg_reg_cur_val(ggc, data, 64);
> +
> +       memcpy(&gg_reg_arr[0], &ggc->dll_sela_100m_cfg,
> +                       sizeof(struct ggc_reg_op));
> +       memcpy(&gg_reg_arr[1], &ggc->dll_sela_200m_cfg,
> +                       sizeof(struct ggc_reg_op));
> +       memcpy(&gg_reg_arr[2], &ggc->dll_selb_100m_cfg,
> +                       sizeof(struct ggc_reg_op));
> +       memcpy(&gg_reg_arr[3], &ggc->dll_selb_200m_cfg,
> +                       sizeof(struct ggc_reg_op));
> +       memcpy(&gg_reg_arr[4], &ggc->dll_selb_100m_cfg_en,
> +                       sizeof(struct ggc_reg_op));
> +       memcpy(&gg_reg_arr[5], &ggc->dll_selb_200m_cfg_en,
> +                       sizeof(struct ggc_reg_op));
> +       memcpy(&gg_reg_arr[6], &ggc->internl_tuning_en_100m,
> +                 sizeof(struct ggc_reg_op));
> +       memcpy(&gg_reg_arr[7], &ggc->internl_tuning_en_200m,
> +                 sizeof(struct ggc_reg_op));
> +       gg_reg_arr[0].value =3D sela;
> +       gg_reg_arr[1].value =3D sela;
> +       gg_reg_arr[2].value =3D selb;
> +       gg_reg_arr[3].value =3D selb;
> +       gg_reg_arr[4].value =3D 1;
> +       gg_reg_arr[5].value =3D 1;
> +       gg_reg_arr[6].value =3D 0;
> +       gg_reg_arr[7].value =3D 0;
> +
> +       chg_gg_reg_cur_val(ggc, data, gg_reg_arr, 8, true);
> +
> +       return gg_emulator_write(host, data, 512);
> +}
> +
> +static void gen_array_data(u32 low32, u32 high32, u32 *ptw)
> +{
> +       u8 tu_res_per[6][TUNING_PHASE_SIZE];
> +       u8 i =3D 0, j =3D 0;
> +       u8 i_mode =3D 0;
> +       u32 tw =3D 0;
> +
> +       memset(tu_res_per, 1, sizeof(tu_res_per));
> +       for (i =3D 0; i < 64; i++) {
> +               u32 tmp_data =3D (i < 32) ? low32 : high32;
> +
> +               tu_res_per[i / TUNING_PHASE_SIZE][i % TUNING_PHASE_SIZE] =
=3D
> +                   (tmp_data & (1 << (i % 32))) >> (i % 32);
> +       }
> +
> +       for (i_mode =3D 0; i_mode < TUNING_PHASE_SIZE; i_mode++) {
> +               for (j =3D 0; j < 6; j++) {
> +                       if (tu_res_per[j][i_mode] !=3D 0)
> +                               tw |=3D (1 << i_mode);
> +                       else {
> +                               tw &=3D ~(1 << i_mode);
> +                               break;
> +                       }
> +               }
> +       }
> +       if (ptw)
> +               *ptw =3D tw;
> +}
> +
> +static bool sw_calc_tuning_result(struct sdhci_host *host, u32 *tx_selb,
> +                          u32 *all_selb, u64 *raw_tx_selb)
> +{
> +       bool ret =3D false;
> +       u8 data[512] =3D { 0 };
> +       u32 selb_status_tx_low32 =3D 0, selb_status_tx_high32 =3D 0;
> +       u32 selb_status_ggc_low32 =3D 0, selb_status_ggc_high32 =3D 0;
> +       struct ggc_reg_op gg_reg_arr[6];
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D sdhci_pltfm_priv(pltfm_hos=
t);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +
> +       memcpy(&gg_reg_arr[0], &ggc->pha_stas_tx_low32, sizeof(struct ggc=
_reg_op));
> +       memcpy(&gg_reg_arr[1], &ggc->pha_stas_tx_high32, sizeof(struct gg=
c_reg_op));
> +       memcpy(&gg_reg_arr[2], &ggc->pha_stas_rx_low32, sizeof(struct ggc=
_reg_op));
> +       memcpy(&gg_reg_arr[3], &ggc->pha_stas_rx_high32, sizeof(struct gg=
c_reg_op));
> +       memcpy(&gg_reg_arr[4], &ggc->dll_sela_after_mask, sizeof(struct g=
gc_reg_op));
> +       memcpy(&gg_reg_arr[5], &ggc->dll_selb_after_mask, sizeof(struct g=
gc_reg_op));
> +
> +       ret =3D get_gg_reg_cur(host, data, gg_reg_arr, 6);
> +
> +       if (ret =3D=3D true) {
> +               selb_status_tx_low32 =3D gg_reg_arr[0].value;
> +               pr_debug("BHT MSG:[205-236]:\n");
> +               log_bin(selb_status_tx_low32);
> +               selb_status_tx_high32 =3D gg_reg_arr[1].value;
> +               pr_debug("BHT MSG:[237-268]:\n");
> +               log_bin(selb_status_tx_high32);
> +               selb_status_ggc_low32 =3D gg_reg_arr[2].value;
> +               pr_debug("BHT MSG:[14-45]:\n");
> +               log_bin(selb_status_ggc_low32);
> +               selb_status_ggc_high32 =3D gg_reg_arr[3].value;
> +               pr_debug("BHT MSG:[46-77]:\n");
> +               log_bin(selb_status_ggc_high32);
> +               pr_debug("BHT MSG:dll sela after mask=3D%xh\n", gg_reg_ar=
r[4].value);
> +               pr_debug("BHT MSG:dll selb after mask=3D%xh\n", gg_reg_ar=
r[5].value);
> +
> +               if (raw_tx_selb) {
> +                       *raw_tx_selb =3D gg_reg_arr[1].value;
> +                       (*raw_tx_selb) <<=3D 32;
> +                       *raw_tx_selb +=3D gg_reg_arr[0].value;
> +                       pr_debug("BHT MSG:raw_tx_selb:%llxh\n", *raw_tx_s=
elb);
> +               }
> +
> +               if (tx_selb) {
> +                       gen_array_data(gg_reg_arr[0].value, gg_reg_arr[1]=
.value,
> +                                      tx_selb);
> +                       pr_debug("BHT MSG:tx_selb:%xh\n", *tx_selb);
> +               }
> +               if (all_selb) {
> +                       gen_array_data(gg_reg_arr[2].value, gg_reg_arr[3]=
.value,
> +                                      all_selb);
> +                       pr_debug("BHT MSG:all_selb:%xh\n", *all_selb);
> +               }
> +       }
> +
> +       return ret;
> +}
> +
> +static bool gg_tuning_result(struct sdhci_host *host, u32 *tx_selb, u32 =
*all_selb,
> +                       u64 *raw_tx_selb)
> +{
> +       host_cmddat_line_reset(host);
> +       return sw_calc_tuning_result(host, tx_selb, all_selb, raw_tx_selb=
);
> +}
> +
> +static u64 GENERATE_64_IDX_VALUE(int sft)
> +{
> +       u64 val =3D 1;
> +
> +       return val << sft;
> +}
> +
> +static bool is_bus_mode_sdr104(struct sdhci_host *host)
> +{
> +       bool ret =3D false;
> +
> +       if (host->timing =3D=3D MMC_TIMING_UHS_SDR104)
> +               ret =3D true;
> +
> +       return ret;
> +}
> +
> +static bool _check_bus_mode(struct sdhci_host *host)
> +{
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D sdhci_pltfm_priv(pltfm_hos=
t);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +
> +       if (is_bus_mode_sdr104(host))
> +               ggc->cur_bus_mode =3D &ggc->sdr104;
> +       else
> +               ggc->cur_bus_mode =3D &ggc->sdr50;
> +
> +       return true;
> +}
> +
> +static void tx_selb_failed_history_update(struct sdhci_host *host, u32 v=
al)
> +{
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D sdhci_pltfm_priv(pltfm_hos=
t);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +
> +       _check_bus_mode(host);
> +
> +       ggc->cur_bus_mode->tx_selb_failed_history &=3D val;
> +}
> +
> +static u32 tx_selb_failed_history_get(struct sdhci_host *host)
> +{
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D sdhci_pltfm_priv(pltfm_hos=
t);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +
> +       _check_bus_mode(host);
> +
> +       return ggc->cur_bus_mode->tx_selb_failed_history;
> +}
> +
> +static void tx_selb_failed_tb_update(struct sdhci_host *host, int sela, =
u32 val)
> +{
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D sdhci_pltfm_priv(pltfm_hos=
t);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +
> +       _check_bus_mode(host);
> +       ggc->cur_bus_mode->tx_selb_tb[sela] &=3D val;
> +}
> +
> +static u32 tx_selb_failed_tb_get(struct sdhci_host *host, int sela)
> +{
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D sdhci_pltfm_priv(pltfm_hos=
t);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +       u32 value =3D 0;
> +
> +       _check_bus_mode(host);
> +
> +       if (is_bus_mode_sdr104(host))
> +               value =3D ggc->sdr104.tx_selb_tb[sela];
> +       else
> +               value =3D ggc->sdr50.tx_selb_tb[sela];
> +
> +       return value;
> +}
> +
> +static void all_selb_failed_tb_update(struct sdhci_host *host, int sela,=
 u32 val)
> +{
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D sdhci_pltfm_priv(pltfm_hos=
t);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +
> +       _check_bus_mode(host);
> +       ggc->cur_bus_mode->all_selb_tb[sela] &=3D val;
> +}
> +
> +static u32 all_selb_failed_tb_get(struct sdhci_host *host, int sela)
> +{
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D sdhci_pltfm_priv(pltfm_hos=
t);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +       u32 val;
> +
> +       _check_bus_mode(host);
> +
> +       val =3D ggc->cur_bus_mode->all_selb_tb[sela];
> +
> +       return val;
> +}
> +
> +static void chk_phase_window(u8 *tuning_win, u8 *mid_val, u8 *max_pass_w=
in)
> +{
> +       u8 tuning_pass[TUNING_PHASE_SIZE + 32];
> +       u8 tuning_pass_start[TUNING_PHASE_SIZE + 32];
> +       u8 tuning_pass_num_max =3D 0;
> +       u8 first_0 =3D 0;
> +       u8 i =3D 0, j =3D 0;
> +       u8 i_mode =3D 0, selb_mode =3D 0;
> +
> +       memset(tuning_pass, 1, sizeof(tuning_pass));
> +       memset(tuning_pass_start, 1, sizeof(tuning_pass_start));
> +
> +       for (i =3D 0; i < TUNING_PHASE_SIZE; i++) {
> +               if (tuning_win[i] =3D=3D 0) {
> +                       first_0 =3D i;
> +                       break;
> +               }
> +       }
> +
> +       for (i =3D 0; i < TUNING_PHASE_SIZE; i++) {
> +               i_mode =3D (first_0 + i) % TUNING_PHASE_SIZE;
> +               if (tuning_win[i_mode] =3D=3D 1)
> +                       tuning_pass[j]++;
> +               else if (tuning_pass[j])
> +                       j++;
> +               if (tuning_pass[j] =3D=3D 1)
> +                       tuning_pass_start[j] =3D i_mode;
> +       }
> +
> +       for (i =3D 0; i < TUNING_PHASE_SIZE; i++) {
> +               if (tuning_pass_num_max < tuning_pass[i]) {
> +                       tuning_pass_num_max =3D tuning_pass[i];
> +                       i_mode =3D i;
> +               }
> +       }
> +
> +       if (tuning_pass_num_max =3D=3D 0)
> +               pr_err
> +                   ("Get max pass window fail, there is no any pass phas=
e!!\n");
> +       else {
> +               *max_pass_win =3D tuning_pass_num_max - 1;
> +               tuning_pass_num_max /=3D 2;
> +               selb_mode =3D tuning_pass_start[i_mode] + tuning_pass_num=
_max;
> +               if ((*max_pass_win % 2 =3D=3D 0))
> +                       selb_mode +=3D 1;
> +               selb_mode %=3D TUNING_PHASE_SIZE;
> +       }
> +
> +       *mid_val =3D selb_mode;
> +}
> +
> +static void dump_array(u8 *tb)
> +{
> +       int i =3D 0;
> +       u8 str[12] =3D { 0 };
> +
> +       for (i =3D 0; i < TUNING_PHASE_SIZE; i++)
> +               str[i] =3D tb[i] + '0';
> +}
> +
> +static void bits_generate_array(u8 *tb, u32 v)
> +{
> +       int i =3D 0;
> +
> +       for (i =3D 0; i < TUNING_PHASE_SIZE; i++) {
> +               if ((v & (1 << i)))
> +                       tb[i] =3D 1;
> +               else
> +                       tb[i] =3D 0;
> +       }
> +       dump_array(tb);
> +}
> +
> +static int ggc_get_selx_weight(u32 val)
> +{
> +       int i =3D 0;
> +       int cnt =3D 0;
> +
> +       for (i =3D 0; i < TUNING_PHASE_SIZE; i++) {
> +               if (GET_IDX_VALUE(val, i))
> +                       cnt++;
> +       }
> +       return cnt;
> +}
> +
> +static void tx_selb_calculate_valid_phase_range(u32 val, int *start,
> +                                               int *pass_cnt)
> +{
> +       int i =3D 0, flg =3D 0;
> +
> +       *pass_cnt =3D ggc_get_selx_weight(val);
> +       for (i =3D 0; i < (TUNING_PHASE_SIZE * 2); i++) {
> +               if ((GET_TUNING_RING_IDX_VALUE(val, i)) =3D=3D 0 && (flg =
=3D=3D 0))
> +                       flg =3D 1;
> +               if ((flg =3D=3D 1) && GET_TUNING_RING_IDX_VALUE(val, i)) =
{
> +                       *start =3D TUNING_RING_IDX(i);
> +                       break;
> +               }
> +       }
> +}
> +
> +static bool ggc_update_default_selb_phase_tuning_cnt(struct sdhci_host *=
host, int selb,
> +                                             int tuning_cnt)
> +{
> +       struct ggc_reg_op gg_reg_arr[3];
> +       u8 data[512];
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D sdhci_pltfm_priv(pltfm_hos=
t);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +
> +       get_gg_reg_cur_val(ggc, data, 64);
> +
> +       pr_debug("BHT MSG: selb:%xh,tuning_cnt:%xh\n", selb,
> +                tuning_cnt);
> +       memcpy(&gg_reg_arr[0], &ggc->dll_selb_100m_cfg,
> +               sizeof(struct ggc_reg_op));
> +       memcpy(&gg_reg_arr[1], &ggc->dll_selb_200m_cfg,
> +               sizeof(struct ggc_reg_op));
> +       memcpy(&gg_reg_arr[2], &ggc->cmd19_cnt_cfg,
> +               sizeof(struct ggc_reg_op));
> +
> +       gg_reg_arr[0].value =3D selb;
> +       gg_reg_arr[1].value =3D selb;
> +       gg_reg_arr[2].value =3D tuning_cnt;
> +       chg_gg_reg_cur_val(ggc, data, gg_reg_arr, 3, true);
> +
> +       return true;
> +}
> +
> +static void _ggc_update_cur_setting_for_sw_selb_tuning(struct sdhci_host=
 *host,
> +                                                      u32 val)
> +{
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D sdhci_pltfm_priv(pltfm_hos=
t);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +       int start =3D 0, pass_cnt =3D 0;
> +
> +       tx_selb_calculate_valid_phase_range(val, &start, &pass_cnt);
> +       pr_debug("BHT MSG:%s %x %x %x\n", __func__, val, start, pass_cnt)=
;
> +       ggc_update_default_selb_phase_tuning_cnt(host, start, pass_cnt); =
       //update
> +       ggc->ggc_sw_selb_tuning_first_selb =3D start;
> +}
> +
> +static int sdhci_bht_sdr50_execute_tuning(struct sdhci_host *host, u32 o=
pcode)
> +{
> +
> +       u8 phase, *data_buf;
> +       int size =3D 64;
> +       int rc =3D 0;
> +       struct mmc_host *mmc =3D host->mmc;
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D sdhci_pltfm_priv(pltfm_hos=
t);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +
> +       pr_debug("%s: Enter %s\n", mmc_hostname(mmc), __func__);
> +
> +       data_buf =3D kmalloc(size, GFP_KERNEL);
> +
> +       phase =3D 0;
> +       do {
> +               struct mmc_command cmd =3D { 0 };
> +               struct mmc_data data =3D { 0 };
> +               struct mmc_request mrq =3D {
> +                       .cmd =3D &cmd,
> +                       .data =3D &data
> +               };
> +               struct scatterlist sg;
> +
> +               cmd.opcode =3D opcode;
> +               cmd.flags =3D MMC_RSP_R1 | MMC_CMD_ADTC;
> +
> +               data.blksz =3D size;
> +               data.blocks =3D 1;
> +               data.flags =3D MMC_DATA_READ;
> +               data.timeout_ns =3D 30 * 1000 * 1000;     /* 30ms */
> +
> +               data.sg =3D &sg;
> +               data.sg_len =3D 1;
> +               sg_init_one(&sg, data_buf, size);
> +               memset(data_buf, 0, size);
> +               host_cmddat_line_reset(host);
> +               mmc_wait_for_req(mmc, &mrq);
> +
> +               if (cmd.error) {
> +                       if (cmd.error =3D=3D -EILSEQ)
> +                               ggc->sdr50_notuning_crc_error_flag =3D 1;
> +                       if (cmd.error =3D=3D -ETIMEDOUT && phase =3D=3D 0=
) {
> +                               pr_err("BHT ERR:cmd19 timeout\n");
> +                               rc =3D -ETIMEDOUT;
> +                               goto kfree;
> +                       }
> +               }
> +
> +               if (data.error) {
> +                       if (data.error =3D=3D -EILSEQ)
> +                               ggc->sdr50_notuning_crc_error_flag =3D 1;
> +               }
> +       } while (++phase < 16);
> +
> +kfree:
> +       kfree(data_buf);
> +
> +       return rc;
> +}
> +
> +static int get_config_sela_setting(struct sdhci_host *host)
> +{
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D sdhci_pltfm_priv(pltfm_hos=
t);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +
> +       if (is_bus_mode_sdr104(host))
> +               return ggc->def_sela_200m;
> +       else
> +               return ggc->def_sela_100m;
> +}
> +
> +static int get_config_selb_setting(struct sdhci_host *host)
> +{
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D sdhci_pltfm_priv(pltfm_hos=
t);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +
> +       if (is_bus_mode_sdr104(host))
> +               return ggc->def_selb_200m;
> +       else
> +               return ggc->def_selb_100m;
> +}
> +
> +static int get_left_one_sel(int base)
> +{
> +       if (base =3D=3D 0)
> +               return 0xa;
> +       else
> +               return base - 1;
> +}
> +
> +static int get_right_one_sel(int base)
> +{
> +       if (base =3D=3D 0xa)
> +               return 0x0;
> +       else
> +               return base + 1;
> +}
> +
> +static int update_selb(struct sdhci_host *host, int target_selb)
> +{
> +       return target_selb;
> +}
> +
> +static int ggc_get_10case_0_index(u32 val)
> +{
> +       int i =3D 0;
> +
> +       for (i =3D 0; i < TUNING_PHASE_SIZE; i++) {
> +               if (GET_IDX_VALUE(val, i) =3D=3D 0
> +                   && GET_IDX_VALUE(val,
> +                                    TUNING_RING_IDX(i + TUNING_PHASE_SIZ=
E -
> +                                                     1))) {
> +                       return i;
> +               }
> +       }
> +
> +       return -1;
> +}
> +
> +static u32 ggc_get_01case_0_index(u32 val)
> +{
> +       int i =3D 0;
> +
> +       for (i =3D 0; i < TUNING_PHASE_SIZE; i++) {
> +               if (GET_IDX_VALUE(val, i) =3D=3D 0
> +                   && GET_IDX_VALUE(val, TUNING_RING_IDX(i + 1))) {
> +                       return i;
> +               }
> +       }
> +
> +       return -1;
> +}
> +
> +static int ggc_get_next_1_index(u32 val, int pos)
> +{
> +       int i =3D 0;
> +
> +       pos =3D pos % TUNING_PHASE_SIZE;
> +       for (i =3D 0; i < TUNING_PHASE_SIZE; i++) {
> +               if (GET_IDX_VALUE(val, (pos+i)%TUNING_PHASE_SIZE))
> +                       break;
> +       }
> +       if (GET_IDX_VALUE(val, (pos+i)%TUNING_PHASE_SIZE))
> +               return (pos+i)%TUNING_PHASE_SIZE;
> +       else
> +               return -1;
> +}
> +
> +static u32 ggc_get_01case_1_index(u32 val)
> +{
> +       int i =3D 0;
> +
> +       for (i =3D 0; i < TUNING_PHASE_SIZE; i++) {
> +               if (GET_IDX_VALUE(val, i) =3D=3D 0
> +                       && GET_IDX_VALUE(val, TUNING_RING_IDX(i + 1))) {
> +                       return TUNING_RING_IDX(i + 1);
> +               }
> +       }
> +
> +       return -1;
> +}
> +
> +static int ggc_get_first_0_index(u32 val)
> +{
> +       int i =3D 0;
> +
> +       for (i =3D 0; i < TUNING_PHASE_SIZE; i++) {
> +               if (GET_IDX_VALUE(val, i) =3D=3D 0)
> +                       return i;
> +       }
> +       pr_debug("BHT MSG:oops-not find 0 index\n");
> +       return 0;
> +}
> +
> +static int _tx_selb_inject_policy(int tx_selb, int org_selb)
> +{
> +       int group_pos[TUNING_PHASE_SIZE+1][3];
> +       int group_cnt =3D 0;
> +       int max_len_group =3D 0;
> +       int max_len =3D 0;
> +       int i, j, cnt;
> +       int zero_start, zero_end, sel;
> +
> +       if ((org_selb & BIT_PASS_MASK) !=3D BIT_PASS_MASK) {
> +               sel =3D tx_selb;
> +               zero_start =3D ggc_get_10case_0_index(sel);
> +               sel &=3D
> +                   ~GENERATE_TUNING_RING_IDX_VALUE(get_left_one_sel
> +                                                    (zero_start));
> +               zero_end =3D ggc_get_01case_0_index(sel);
> +               sel &=3D
> +                   ~GENERATE_TUNING_RING_IDX_VALUE(get_right_one_sel
> +                                                    (zero_end));
> +               if (sel !=3D (sel & tx_selb)) {
> +                       pr_err
> +                           ("tx selb reinject exception case :not adjace=
nt phase\n");
> +                       pr_err("BHT ERR:selb_failed range:%xh  ,new tx_se=
lb:%x\n",
> +                              org_selb, tx_selb);
> +               }
> +               org_selb &=3D tx_selb;
> +       } else {
> +               cnt =3D ggc_get_selx_weight(~tx_selb);
> +               pr_debug("BHT MSG:%d\n", cnt);
> +               switch (cnt) {
> +               case 1:
> +                       i =3D ggc_get_first_0_index(tx_selb);
> +                       tx_selb &=3D
> +                           ~GENERATE_TUNING_RING_IDX_VALUE(get_right_one=
_sel
> +                                                            (i));
> +                       tx_selb &=3D
> +                           ~GENERATE_TUNING_RING_IDX_VALUE(get_left_one_=
sel
> +                                                            (i));
> +
> +                       break;
> +               case 2:
> +                       i =3D ggc_get_10case_0_index(tx_selb);
> +                       tx_selb &=3D
> +                           ~GENERATE_TUNING_RING_IDX_VALUE(get_left_one_=
sel
> +                                                            (i));
> +                       i =3D ggc_get_01case_0_index(tx_selb);
> +                       tx_selb &=3D
> +                           ~GENERATE_TUNING_RING_IDX_VALUE(get_right_one=
_sel
> +                                                            (i));
> +                       break;
> +               default:
> +                       pr_debug("BHT MSG:>=3D 3 point case\n");
> +               }
> +               org_selb &=3D tx_selb;
> +       }
> +
> +       pr_debug("BHT MSG:will check continuous 0bits: 0x%x\n", org_selb)=
;
> +
> +       memset(group_pos, 0, sizeof(group_pos));
> +       for (i =3D ggc_get_01case_1_index(org_selb);
> +               i < TUNING_PHASE_SIZE && i >=3D 0 && group_cnt < TUNING_P=
HASE_SIZE;) {
> +               for (j =3D 1; j < TUNING_PHASE_SIZE; j++) {
> +                       if (GET_TUNING_RING_IDX_VALUE(org_selb, i+j) !=3D=
 0)
> +                               continue;
> +                       else
> +                               break;
> +               }
> +               group_pos[group_cnt][0] =3D i;
> +               group_pos[group_cnt][1] =3D (i + j - 1) % TUNING_PHASE_SI=
ZE;
> +               group_pos[group_cnt][2] =3D j;
> +               group_cnt++;
> +               if (group_pos[group_cnt-1][0] > group_pos[group_cnt-1][1]=
)
> +                       break;
> +               i =3D ggc_get_next_1_index(org_selb, (i+j)%TUNING_PHASE_S=
IZE);
> +               for (j =3D 0; j < group_cnt; j++) {
> +                       if (i =3D=3D group_pos[j][0])
> +                               break;
> +               }
> +               if (j < group_cnt)
> +                       break;
> +       }
> +
> +       if (group_cnt > 1) {
> +               pr_err("BHT ERR:After inject, selb 0x%x has %d continuous=
 0 bits\n",
> +                               org_selb, group_cnt);
> +
> +               for (i =3D 0; i < group_cnt; i++) {
> +                       if (max_len < group_pos[i][2]) {
> +                               max_len =3D group_pos[i][2];
> +                               max_len_group =3D i;
> +                       }
> +               }
> +               for (i =3D (group_pos[max_len_group][1] + 1) % TUNING_PHA=
SE_SIZE;
> +                       i !=3D group_pos[max_len_group][0]; i =3D (i+1)%T=
UNING_PHASE_SIZE) {
> +                       org_selb &=3D ~(1 << i);
> +               }
> +               pr_err("BHT ERR:After merge incontious 0 group, selb chan=
ged to 0x%x\n", org_selb);
> +       } else if (group_cnt > 0) {
> +               pr_err("BHT ERR:After merge incontious 0 group, selb =3D =
0x%x\n", org_selb);
> +       } else {
> +               pr_err("BHT ERR:selb 0x%x has no bit is 0\n", org_selb);
> +       }
> +
> +       return org_selb;
> +}
> +
> +static void tx_selb_inject_policy(struct sdhci_host *host, int tx_selb)
> +{
> +
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D sdhci_pltfm_priv(pltfm_hos=
t);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +
> +       pr_debug("BHT MSG:before inject, failed ragen 0x%x, tx_selb 0x%x\=
n",
> +                       ggc->ggc_cmd_tx_selb_failed_range, tx_selb);
> +       ggc->ggc_cmd_tx_selb_failed_range =3D
> +               _tx_selb_inject_policy(tx_selb, ggc->ggc_cmd_tx_selb_fail=
ed_range);
> +       tx_selb_failed_history_update(host, ggc->ggc_cmd_tx_selb_failed_r=
ange);
> +       pr_debug("BHT MSG:after inject %xh range:%xh\n", tx_selb,
> +                ggc->ggc_cmd_tx_selb_failed_range);
> +       if (is_bus_mode_sdr104(host))
> +               ggc->sdr104.fail_phase =3D ggc->ggc_cmd_tx_selb_failed_ra=
nge;
> +       else
> +               ggc->sdr50.fail_phase =3D ggc->ggc_cmd_tx_selb_failed_ran=
ge;
> +}
> +
> +static int get_selb_failure_point(int start, u64 raw_tx_selb, int tuning=
_cnt)
> +{
> +       int last =3D start + (tuning_cnt - 1);
> +       int i =3D 0;
> +       int j =3D 0;
> +       int phase =3D start;
> +       int vct =3D BIT_PASS_MASK;
> +
> +       pr_debug("BHT MSG:%s start:%d tuning_cnt:%d\n", __func__, start,
> +                        tuning_cnt);
> +
> +       for (i =3D 0; i < tuning_cnt; i++) {
> +               if ((raw_tx_selb & GENERATE_64_IDX_VALUE(last - i)) =3D=
=3D 0)
> +                       break;
> +       }
> +       if (i =3D=3D tuning_cnt) {
> +               phase =3D last % TUNING_PHASE_SIZE;
> +               vct &=3D (~(1 << phase));
> +               goto exit;
> +       }
> +
> +       for (i =3D 0; i < tuning_cnt; i++) {
> +               if ((raw_tx_selb & GENERATE_64_IDX_VALUE(last - i)) !=3D =
0)
> +                       break;
> +       }
> +       for (j =3D i - 2; j >=3D 0; j--)
> +               raw_tx_selb |=3D (1 << (last - j));
> +
> +       for (j =3D 0; j < tuning_cnt; j++) {
> +               if (0 =3D=3D (raw_tx_selb & GENERATE_64_IDX_VALUE(last - =
j)))
> +                       vct &=3D (~(1 << (last-j)));
> +       }
> +
> +exit:
> +       pr_debug("BHT MSG:%s: after adjust raw_tx_selb: 0x%llx, vct 0x%x\=
n",
> +                        __func__, raw_tx_selb, vct);
> +
> +       return vct;
> +}
> +
> +static bool selx_failure_point_exist(u32 val)
> +{
> +       return (val & BIT_PASS_MASK) !=3D BIT_PASS_MASK;
> +}
> +
> +static int _bits_vct_get_left_index(int base)
> +{
> +       return TUNING_RING_IDX(base + TUNING_PHASE_SIZE - 1);
> +}
> +
> +static int _get_best_window_phase(u32 vct, int *pmax_pass_win, int shif_=
left_flg)
> +{
> +       u8 tuning_win[TUNING_PHASE_SIZE] =3D { 0 };
> +       u8 tuning_pass[TUNING_PHASE_SIZE];
> +       int tuning_pass_start[TUNING_PHASE_SIZE];
> +       int tuning_pass_num_max =3D 0;
> +       int first_0 =3D 0;
> +       int i =3D 0, j =3D 0;
> +       int i_mode =3D 0, selb_mode =3D 0;
> +
> +       memset(tuning_pass, 0, sizeof(tuning_pass));
> +       memset(tuning_pass_start, 0, sizeof(tuning_pass_start));
> +
> +       for (i =3D 0; i < TUNING_PHASE_SIZE; i++) {
> +               if (GET_IDX_VALUE(vct, i))
> +                       tuning_win[i] =3D 1;
> +               else
> +                       tuning_win[i] =3D 0;
> +       }
> +
> +       for (i =3D 0; i < TUNING_PHASE_SIZE; i++) {
> +               if (tuning_win[i] =3D=3D 0) {
> +                       first_0 =3D i;
> +                       break;
> +               }
> +       }
> +
> +       for (i =3D 0; i < TUNING_PHASE_SIZE; i++) {
> +               i_mode =3D TUNING_RING_IDX(first_0 + i);
> +               if (tuning_win[i_mode] =3D=3D 1)
> +                       tuning_pass[j]++;
> +               else if (tuning_pass[j])
> +                       j++;
> +               if (tuning_pass[j] =3D=3D 1)
> +                       tuning_pass_start[j] =3D i_mode;
> +       }
> +
> +       for (i =3D 0; i < TUNING_PHASE_SIZE; i++) {
> +               if (tuning_pass_num_max < tuning_pass[i]) {
> +                       tuning_pass_num_max =3D tuning_pass[i];
> +                       i_mode =3D i;
> +               }
> +       }
> +
> +       if (tuning_pass_num_max =3D=3D 0) {
> +               pr_err("BHT ERR:Get max pass window fail, there is no any=
 pass phase!!\n");
> +               selb_mode =3D 0;
> +       } else {
> +               if (tuning_pass_num_max % 2)    {
> +                       selb_mode =3D tuning_pass_start[i_mode] + (tuning=
_pass_num_max - 1) / 2;
> +               } else {
> +                       selb_mode =3D tuning_pass_start[i_mode] + (tuning=
_pass_num_max) / 2;
> +                       if (shif_left_flg) {
> +                               selb_mode =3D _bits_vct_get_left_index(se=
lb_mode);
> +                               pr_debug("BHT MSG:shift left index\n");
> +                       }
> +               }
> +               selb_mode =3D TUNING_RING_IDX(selb_mode);
> +       }
> +       if (pmax_pass_win)
> +               *pmax_pass_win =3D tuning_pass_num_max;
> +
> +       return selb_mode;
> +}
> +
> +
> +static int get_best_window_phase(u32 vct, int *pmax_pass_win)
> +{
> +       return _get_best_window_phase(vct, pmax_pass_win, 0);
> +}
> +
> +static int _ggc_get_suitable_selb_for_next_tuning(struct sdhci_host *hos=
t)
> +{
> +       int selb =3D 0;
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D sdhci_pltfm_priv(pltfm_hos=
t);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +       u32 inj_tx_selb =3D BIT_PASS_MASK;
> +
> +       if (selx_failure_point_exist(ggc->ggc_cmd_tx_selb_failed_range)) =
{
> +               selb =3D ggc->ggc_sw_selb_tuning_first_selb;
> +       } else {
> +               pr_debug("BHT MSG:manual inject for all pass case\n");
> +               if (is_bus_mode_sdr104(host))
> +                       inj_tx_selb &=3D SDR104_MANUAL_INJECT;
> +               else
> +                       inj_tx_selb &=3D SDR50_MANUAL_INJECT;
> +
> +               pr_debug("BHT MSG:manual inject for all pass case, inj_tx=
_selb=3D0x%x\n",
> +                               inj_tx_selb);
> +               selb =3D get_best_window_phase(inj_tx_selb, NULL);
> +               pr_debug("BHT MSG:select selb %d for all pass case\n", se=
lb);
> +       }
> +       return selb;
> +}
> +
> +static int ggc_get_tuning_cnt_from_buffer(struct sdhci_host *host)
> +{
> +       int cnt =3D 0;
> +       u8 data[512];
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D sdhci_pltfm_priv(pltfm_hos=
t);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +
> +       get_gg_reg_cur_val(ggc, data, 64);
> +       cnt =3D (int)cfg_read_bits_ofs_mask(data, &ggc->cmd19_cnt_cfg);
> +
> +       pr_debug("BHT MSG:tuning cnt=3D%d\n", cnt);
> +       return cnt;
> +}
> +
> +static bool ggc_hw_inject_ext(struct sdhci_host *host, bool *card_status=
,
> +                       u32 sel200, u32 sel100, bool writetobh201)
> +{
> +       bool ret =3D true;
> +       u8 data[512];
> +       struct ggc_reg_op gg_reg_arr[10];
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D sdhci_pltfm_priv(pltfm_hos=
t);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +       u32 i =3D 0;
> +       u32 reg;
> +
> +       pr_debug("BHT MSG:%s sel200:%xh,sel100:%xh\n", __func__, sel200, =
sel100);
> +       get_gg_reg_cur_val(ggc, data, 64);
> +       memcpy(&gg_reg_arr[0], &ggc->inject_failure_for_tuning_enable_cfg=
,
> +                               sizeof(struct ggc_reg_op));
> +       memcpy(&gg_reg_arr[1], &ggc->inject_failure_for_200m_tuning_cfg,
> +                               sizeof(struct ggc_reg_op));
> +       memcpy(&gg_reg_arr[2], &ggc->inject_failure_for_100m_tuning_cfg,
> +                               sizeof(struct ggc_reg_op));
> +       gg_reg_arr[0].value =3D 1;
> +       gg_reg_arr[1].value =3D sel200;
> +       gg_reg_arr[2].value =3D sel100;
> +
> +       chg_gg_reg_cur_val(ggc, data, gg_reg_arr, 3, true);
> +       if (writetobh201)
> +               ret =3D gg_emulator_write_ext(host, card_status, data, 51=
2);
> +       else {
> +               pr_debug("BHT MSG:%s: dump config data instead write to b=
h201\n", __func__);
> +               for (i =3D 0; i < 128; i++) {
> +                       memcpy(&reg, data+i*sizeof(u32), sizeof(u32));
> +                       pr_debug("BHT MSG:    ggc_reg32[%03d]=3D0x%08x\n"=
, i, reg);
> +               }
> +       }
> +       return ret;
> +}
> +
> +static bool _ggc_hw_inject_may_recursive(struct sdhci_host *host, u32 se=
l200,
> +                       u32 sel100, int max_recur, bool writetobh201)
> +{
> +       bool ret =3D true, card_status =3D true;
> +       int selb =3D BIT_PASS_MASK;
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D sdhci_pltfm_priv(pltfm_hos=
t);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +
> +       ret =3D ggc_hw_inject_ext(host, &card_status, ggc->ggc_cmd_tx_sel=
b_failed_range,
> +                       ggc->ggc_cmd_tx_selb_failed_range, writetobh201);
> +       pr_debug("BHT MSG:ret:%x\n", ret);
> +       if ((ret =3D=3D false) && (card_status =3D=3D false)) {
> +               pr_debug("BHT MSG:inject again when hw inject\n");
> +               selb &=3D ~GENERATE_IDX_VALUE(ggc->ggc_sw_selb_tuning_fir=
st_selb);
> +               tx_selb_inject_policy(host, selb);
> +               _ggc_update_cur_setting_for_sw_selb_tuning(host,
> +                       ggc->ggc_cmd_tx_selb_failed_range);
> +
> +               if (((11 - get_bit_number(ggc->ggc_cmd_tx_selb_failed_ran=
ge)) >=3D 5)) {
> +                       pr_err("BHT ERR:pass windows too small,reinit rec=
ursive\n");
> +                       return false;
> +               }
> +
> +               if (max_recur--)
> +                       return _ggc_hw_inject_may_recursive(host,
> +                       ggc->ggc_cmd_tx_selb_failed_range,
> +                       ggc->ggc_cmd_tx_selb_failed_range, max_recur, wri=
tetobh201);
> +               else
> +                       return false;
> +       } else
> +               return true;
> +}
> +
> +static bool ggc_hw_inject_may_recursive(struct sdhci_host *host, u32 sel=
200,
> +                       u32 sel100, bool writetobh201)
> +{
> +       return _ggc_hw_inject_may_recursive(host, sel200, sel100, 4, writ=
etobh201);
> +}
> +
> +static bool get_next_dll_voltage(int cur, int *next, u32 *dll_voltage_un=
lock_cnt,
> +                       int *dll_voltage_scan_map)
> +{
> +       int min_idx =3D 0, cur_cnt =3D 0, next_cnt =3D 0;
> +       int cur_flg =3D 0;
> +       int i =3D 0;
> +       u8 ret =3D 0;
> +
> +       pr_warn("BHT WARN:dll_voltage_unlock_cnt:%x %x %x %x\n",
> +                       dll_voltage_unlock_cnt[0], dll_voltage_unlock_cnt=
[1],
> +                       dll_voltage_unlock_cnt[2], dll_voltage_unlock_cnt=
[3]);
> +       pr_warn("BHT WARN:dll_voltage_scan_map:%x %x %x %x\n",
> +                       dll_voltage_scan_map[0], dll_voltage_scan_map[1],
> +                       dll_voltage_scan_map[2], dll_voltage_scan_map[3])=
;
> +       for (i =3D 1; i < 4; i++) {
> +               if (cur_flg =3D=3D 0) {
> +                       if (dll_voltage_scan_map[(cur + i) % 4] !=3D 0)
> +                               continue;
> +                       cur_cnt =3D dll_voltage_unlock_cnt[(cur + i) % 4]=
;
> +                       cur_flg =3D 1;
> +                       min_idx =3D (cur + i) % 4;
> +                       continue;
> +               } else {
> +                       if (dll_voltage_scan_map[(cur + i) % 4] !=3D 0)
> +                               continue;
> +                       next_cnt =3D dll_voltage_unlock_cnt[(cur + i) % 4=
];
> +                       if (cur_cnt > next_cnt) {
> +                               cur_cnt =3D next_cnt;
> +                               min_idx =3D (cur + i) % 4;
> +                       }
> +               }
> +       }
> +       if (cur_flg =3D=3D 0) {
> +               pr_err("BHT ERR:no find available voltage\n");
> +               ret =3D false;
> +       } else {
> +               *next =3D min_idx;
> +               pr_err("BHT ERR:next available voltage %d\n", min_idx);
> +               ret =3D true;
> +       }
> +       return ret;
> +}
> +
> +static bool ggc_sw_calc_tuning_result(struct sdhci_host *host, bool *car=
d_status,
> +                              bool *read_status, u32 *tx_selb, u32 *all_=
selb, u64 *raw_tx_selb)
> +{
> +       bool ret =3D false;
> +       bool card_ret =3D false;
> +       bool read_ret =3D false;
> +       u32 selb_status_tx_low32 =3D 0, selb_status_tx_high32 =3D 0;
> +       u32 selb_status_ggc_low32 =3D 0, selb_status_ggc_high32 =3D 0;
> +       struct ggc_reg_op gg_reg_arr[8] =3D {{0}};
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D sdhci_pltfm_priv(pltfm_hos=
t);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +
> +       memcpy(&gg_reg_arr[0], &ggc->pha_stas_tx_low32,
> +               sizeof(struct ggc_reg_op));
> +       memcpy(&gg_reg_arr[1], &ggc->pha_stas_tx_high32,
> +               sizeof(struct ggc_reg_op));
> +       memcpy(&gg_reg_arr[2], &ggc->pha_stas_rx_low32,
> +               sizeof(struct ggc_reg_op));
> +       memcpy(&gg_reg_arr[3], &ggc->pha_stas_rx_high32,
> +               sizeof(struct ggc_reg_op));
> +       memcpy(&gg_reg_arr[4], &ggc->dll_sela_after_mask,
> +               sizeof(struct ggc_reg_op));
> +       memcpy(&gg_reg_arr[5], &ggc->dll_selb_after_mask,
> +               sizeof(struct ggc_reg_op));
> +       memcpy(&gg_reg_arr[6], &ggc->dll_delay_100m_backup,
> +               sizeof(struct ggc_reg_op));
> +       memcpy(&gg_reg_arr[7], &ggc->dll_delay_200m_backup,
> +               sizeof(struct ggc_reg_op));
> +
> +       ret =3D ggc_read_registers_ext(host, &card_ret, &read_ret, gg_reg=
_arr, 8);
> +       if (read_ret =3D=3D true) {
> +               selb_status_tx_low32 =3D gg_reg_arr[0].value;
> +               pr_debug("BHT MSG:[205-236]:\n");
> +               log_bin(selb_status_tx_low32);
> +               selb_status_tx_high32 =3D gg_reg_arr[1].value;
> +               pr_debug("BHT MSG:[237-268]:\n");
> +               log_bin(selb_status_tx_high32);
> +               selb_status_ggc_low32 =3D gg_reg_arr[2].value;
> +               pr_debug("BHT MSG:[14-45]:\n");
> +               log_bin(selb_status_ggc_low32);
> +               selb_status_ggc_high32 =3D gg_reg_arr[3].value;
> +               pr_debug("BHT MSG:[46-77]:\n");
> +               log_bin(selb_status_ggc_high32);
> +               pr_debug("BHT MSG:dll  sela after mask=3D%xh", gg_reg_arr=
[4].value);
> +               pr_debug("BHT MSG:dll  selb after mask=3D%xh", gg_reg_arr=
[5].value);
> +
> +               if (raw_tx_selb) {
> +                       *raw_tx_selb =3D gg_reg_arr[1].value;
> +                       (*raw_tx_selb) <<=3D 32;
> +                       *raw_tx_selb +=3D gg_reg_arr[0].value;
> +                       pr_debug("BHT MSG:raw_tx_selb:%llxh\n", *raw_tx_s=
elb);
> +               }
> +
> +               if (tx_selb) {
> +                       gen_array_data(gg_reg_arr[0].value, gg_reg_arr[1]=
.value,
> +                                      tx_selb);
> +                       pr_debug("BHT MSG:tx_selb:%xh\n", *tx_selb);
> +               }
> +               if (all_selb) {
> +                       gen_array_data(gg_reg_arr[2].value, gg_reg_arr[3]=
.value,
> +                                      all_selb);
> +                       pr_debug("BHT MSG:all_selb:%xh\n", *all_selb);
> +               }
> +       }
> +
> +       if (read_status)
> +               (*read_status) =3D read_ret;
> +       if (card_status)
> +               (*card_status) =3D card_ret;
> +
> +       if (card_status && read_status)
> +               pr_debug("BHT MSG:card_status,read_status:%x %x\n", *card=
_status, *read_status);
> +       return ret;
> +}
> +
> +static bool _ggc_calc_cur_sela_tuning_result(struct sdhci_host *host, in=
t cur_sela, int start_selb)
> +{
> +       bool read_status =3D false;
> +       bool card_status =3D false;
> +       bool ret =3D true;
> +       u32 tx_selb, all_selb;
> +       u64 raw_tx_selb =3D 0;
> +       bool retuning_flg =3D false;
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D sdhci_pltfm_priv(pltfm_hos=
t);
> +       int selb;
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +       enum tuning_state *psela_tuning_result =3D ggc->ggc_sela_tuning_r=
esult;
> +
> +       ret =3D ggc_sw_calc_tuning_result(host, &card_status,
> +                       &read_status, &tx_selb, &all_selb, &raw_tx_selb);
> +
> +       if (card_status =3D=3D false) {
> +               if (read_status =3D=3D true) {
> +                       selb =3D get_selb_failure_point(start_selb, raw_t=
x_selb,
> +                                       ggc_get_tuning_cnt_from_buffer(ho=
st));
> +                       pr_debug("BHT MSG:inject selb %03x for CMD7 read =
timeout\n", selb);
> +                       tx_selb_inject_policy(host, selb);
> +               } else {
> +                       pr_debug("BHT MSG:%s dll:%xh read status failed\n=
",
> +                                       __func__, cur_sela);
> +               }
> +               ret =3D false;
> +               goto exit;
> +       } else {
> +               if (read_status =3D=3D true) {
> +                       if (selx_failure_point_exist(tx_selb)) {
> +                               if ((11-get_bit_number(tx_selb)) <=3D 3) =
{
> +                                       tx_selb_inject_policy(host, tx_se=
lb);
> +                                       all_selb_failed_tb_update(host, c=
ur_sela, all_selb);
> +                                       tx_selb_failed_tb_update(host, cu=
r_sela, tx_selb);
> +                                       tx_selb_failed_history_update(hos=
t, tx_selb);
> +                               } else if (get_bit_number(tx_selb) =3D=3D=
 0) {
> +                                       selb =3D get_selb_failure_point(s=
tart_selb, raw_tx_selb,
> +                                                       ggc_get_tuning_cn=
t_from_buffer(host));
> +                                       tx_selb_inject_policy(host, selb)=
;
> +                                       all_selb_failed_tb_update(host, c=
ur_sela, all_selb);
> +                                       tx_selb_failed_tb_update(host, cu=
r_sela, selb);
> +                                       tx_selb_failed_history_update(hos=
t, selb);
> +                                       retuning_flg =3D true;
> +                               } else {
> +                                       tx_selb_inject_policy(host, tx_se=
lb);
> +                                       all_selb_failed_tb_update(host, c=
ur_sela, all_selb);
> +                                       tx_selb_failed_tb_update(host, cu=
r_sela, tx_selb);
> +                                       tx_selb_failed_history_update(hos=
t, tx_selb);
> +                                       retuning_flg =3D true;
> +                               }
> +
> +                               _ggc_update_cur_setting_for_sw_selb_tunin=
g(host,
> +                                               ggc->ggc_cmd_tx_selb_fail=
ed_range);
> +                               ggc_hw_inject_may_recursive(host, ggc->gg=
c_cmd_tx_selb_failed_range,
> +                                               ggc->ggc_cmd_tx_selb_fail=
ed_range, true);
> +                       } else {
> +                               all_selb_failed_tb_update(host, cur_sela,=
 all_selb);
> +                               tx_selb_failed_tb_update(host, cur_sela, =
tx_selb);
> +                               tx_selb_failed_history_update(host, tx_se=
lb);
> +                       }
> +
> +                       if (retuning_flg =3D=3D true) {
> +                               pr_debug("BHT MSG: %s dll:%xh need retuni=
ng\n",
> +                                               __func__, cur_sela);
> +                               psela_tuning_result[cur_sela] =3D RETUNIN=
G_CASE;
> +                       } else {
> +                               pr_debug("BHT MSG: %s dll:%xh pass\n",
> +                                               __func__, cur_sela);
> +                               psela_tuning_result[cur_sela] =3D OUTPUT_=
PASS_TYPE;
> +                       }
> +               } else {
> +                       psela_tuning_result[cur_sela] =3D READ_STATUS_FAI=
L_TYPE;
> +                       all_selb_failed_tb_update(host, cur_sela, 0);
> +                       pr_debug("BHT MSG:=3D=3D %s dll:%xh read status f=
ailed =3D=3D\n",
> +                                       __func__, cur_sela);
> +               }
> +       }
> +exit:
> +       return ret;
> +}
> +static int sdhci_bht_sdr104_execute_tuning(struct sdhci_host *host, u32 =
opcode)
> +{
> +       struct mmc_host *mmc =3D host->mmc;
> +
> +       return sdhci_msm_execute_tuning(mmc, opcode);
> +}
> +
> +static int sd_tuning_sw(struct sdhci_host *host)
> +{
> +       int ret =3D 0;
> +
> +       if (is_bus_mode_sdr104(host))
> +               ret =3D sdhci_bht_sdr104_execute_tuning(host, 0x13);
> +       else
> +               ret =3D sdhci_bht_sdr50_execute_tuning(host, 0x13);
> +
> +       return ret;
> +}
> +
> +static bool sd_gg_tuning_status(struct sdhci_host *host,
> +                        u32 *tx_selb, u32 *all_selb, u64 *raw_tx_selb,
> +                        bool *status_ret, bool *first_cmd19_status)
> +{
> +       bool ret =3D true;
> +       int err =3D sd_tuning_sw(host);
> +
> +       ret =3D err =3D=3D 0 ? true : false;
> +       if (err =3D=3D -ETIMEDOUT) {
> +               ret =3D false;
> +               if (first_cmd19_status)
> +                       *first_cmd19_status =3D false;
> +               goto exit;
> +       }
> +
> +       if (status_ret) {
> +               *status_ret =3D
> +                       gg_tuning_result(host, tx_selb, all_selb,
> +                                               raw_tx_selb);
> +       } else {
> +               gg_tuning_result(host, 0, 0, 0);
> +       }
> +
> +exit:
> +       return ret;
> +}
> +
> +static bool ggc_sd_tuning(struct sdhci_host *host,
> +                        bool *first_cmd19_status)
> +{
> +       bool ret =3D true;
> +       int err =3D sd_tuning_sw(host);
> +
> +       ret =3D err =3D=3D 0 ? true : false;
> +       if (err =3D=3D -ETIMEDOUT) {
> +               ret =3D false;
> +               if (first_cmd19_status)
> +                       *first_cmd19_status =3D false;
> +               goto exit;
> +       }
> +
> +exit:
> +       return ret;
> +}
> +
> +static bool _ggc_output_tuning(struct sdhci_host *host, u8 *selb_pass_wi=
n)
> +{
> +       int cur_sela =3D 0, dll_sela_cnt =3D 0;
> +       int dll_sela_basis =3D 0;
> +       bool ret =3D false;
> +       u8 win_tb[12] =3D { 0 };
> +       u8 win_mid =3D 0;
> +       u8 win_max =3D 0;
> +       u32 tx_tmp =3D 0;
> +       int target_sela =3D 0;
> +       int target_selb =3D 0;
> +       u32 all_sela, tx_selb, all_selb;
> +       u64 raw_tx_selb;
> +       bool status_ret =3D false;
> +       int cur_selb =3D 0;
> +       int tuning_error_type[16] =3D { 0 };
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D sdhci_pltfm_priv(pltfm_hos=
t);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +       enum tuning_state *psela_tuning_result =3D ggc->ggc_sela_tuning_r=
esult;
> +       int i =3D 0;
> +       u32 idx_r, idx_c;
> +       u32 min_pos =3D 0;
> +       u32 all_selb_ar[TUNING_PHASE_SIZE] =3D { 0 };
> +       u32 pass_cnt[TUNING_PHASE_SIZE] =3D { 0 };
> +       u32 cfg =3D 0;
> +       int rescan_selb_cnt =3D 0;
> +       int returning_selb_cnt =3D 0;
> +       bool first_cmd19_sta =3D true;
> +       int next =3D 0;
> +       bool card_status =3D true;
> +       int selb =3D      BIT_PASS_MASK;
> +       u8 all_str[TUNING_PHASE_SIZE + 1], tx_str[TUNING_PHASE_SIZE + 1];
> +
> +       ggc->driver_strength_reinit_flg =3D 0;
> +       ggc->dll_unlock_reinit_flg =3D 0;
> +       dll_sela_basis =3D get_config_sela_setting(host);
> +       cur_selb =3D get_config_selb_setting(host);
> +
> +       if (ggc->tuning_cmd7_timeout_reinit_flg) {
> +               ggc->tuning_cmd7_timeout_reinit_flg =3D 0;
> +               dll_sela_basis =3D ggc->ggc_cur_sela;
> +               cur_selb =3D ggc->ggc_sw_selb_tuning_first_selb;
> +               pr_debug
> +               ("BHT MSG:Tuning start sela: 0x%x, selb: 0x%x where CMD7 =
timeout\n",
> +                               dll_sela_basis, cur_selb);
> +       }
> +
> +       for (dll_sela_cnt =3D 0; dll_sela_cnt < TUNING_PHASE_SIZE; dll_se=
la_cnt++) {
> +               cur_sela =3D
> +                               (dll_sela_cnt + dll_sela_basis) % TUNING_=
PHASE_SIZE;
> +               ggc->ggc_cur_sela =3D cur_sela;
> +               pr_debug("BHT MSG: %s select sela dll: %x, selb dll: %x\n=
",
> +                               __func__, cur_sela, cur_selb);
> +               if (psela_tuning_result[cur_sela] !=3D NO_TUNING) {
> +                       pr_debug("BHT MSG:sela tuning=3D%d already tuning=
,so skip it\n", cur_sela);
> +                       continue;
> +               }
> +rescan_selb:
> +               host_cmddat_line_reset(host);
> +
> +               if (dll_sela_cnt =3D=3D 0) {
> +                       if (!selx_failure_point_exist
> +                                       (ggc->ggc_cmd_tx_selb_failed_rang=
e)) {
> +                               rescan_selb_cnt =3D 3;
> +                               pr_debug("BHT MSG:no need rescan case\n")=
;
> +                       }
> +                       status_ret =3D false;
> +                       ret =3D ggc_sd_tuning(host, &first_cmd19_sta);
> +
> +                       if (first_cmd19_sta =3D=3D false) {
> +                               _check_bus_mode(host);
> +                               ggc->cur_bus_mode->dll_voltage_unlock_cnt
> +                                                       [ggc->cur_dll_vol=
tage_idx]++;
> +                               ggc->dll_voltage_scan_map[ggc->cur_dll_vo=
ltage_idx] =3D 1;
> +                               if (get_next_dll_voltage(ggc->cur_dll_vol=
tage_idx, &next,
> +                                       ggc->cur_bus_mode->dll_voltage_un=
lock_cnt,
> +                                       ggc->dll_voltage_scan_map) =3D=3D=
 true)
> +                                       ggc->cur_dll_voltage_idx =3D next=
;
> +                               else
> +                                       ggc->cur_dll_voltage_idx =3D
> +                                                       (ggc->cur_dll_vol=
tage_idx + 1) % 4;
> +
> +                               pr_err("BHT ERR:first cmd19 timeout\n");
> +                               ggc->dll_unlock_reinit_flg =3D 1;
> +                               _ggc_reset_tuning_result_for_dll(host);
> +                               ret =3D false;
> +                               goto exit;
> +                       }
> +               } else if ((is_bus_mode_sdr104(host) =3D=3D false)
> +                               && ggc->sdr50_notuning_sela_inject_flag =
=3D=3D 1
> +                               && !GET_IDX_VALUE(ggc->sdr50_notuning_sel=
a_rx_inject,
> +                               cur_sela)) {
> +                       pr_debug("BHT MSG:skip %d\n", cur_sela);
> +                       tuning_error_type[cur_sela] =3D READ_STATUS_FAIL_=
TYPE;
> +                       goto cur_sela_failed;
> +               } else {
> +                       ret =3D ggc_set_output_tuning_phase_ext(host, &ca=
rd_status,
> +                               cur_sela, update_selb(host, cur_selb));
> +                       if (ret =3D=3D false || card_status =3D=3D false)=
 {
> +                               pr_err
> +                               ("BHT ERR: output_tuning fail at phase %d=
,ret=3D%d,card_status=3D%d\n",
> +                                               cur_sela, ret, card_statu=
s);
> +                               if (card_status =3D=3D false) {
> +                                       selb &=3D ~GENERATE_IDX_VALUE(cur=
_selb);
> +                                       pr_err("BHT ERR:inject selb %d fo=
r update sela/selb fail\n",
> +                                                       selb);
> +                                       tx_selb_inject_policy(host, selb)=
;
> +                                       _ggc_update_cur_setting_for_sw_se=
lb_tuning(host,
> +                                               ggc->ggc_cmd_tx_selb_fail=
ed_range);
> +                                       ggc_hw_inject_may_recursive(host,
> +                                                       ggc->ggc_cmd_tx_s=
elb_failed_range,
> +                                                       ggc->ggc_cmd_tx_s=
elb_failed_range, true);
> +
> +                                       if (((11 - get_bit_number(
> +                                               ggc->ggc_cmd_tx_selb_fail=
ed_range))     >=3D 5)) {
> +                                               u8 current_ds =3D (u8)(gg=
c->gg_reg_cur[15] >> 28);
> +
> +                                               pr_err("BHT ERR:pass wind=
ows too small\n");
> +
> +                                               ggc->driver_strength_rein=
it_flg  =3D
> +                                               current_ds < 7 ? current_=
ds + 1 : 7;
> +
> +                                               ggc->gg_reg_cur[15] &=3D =
0x0F0FFFFF;
> +                                               ggc->gg_reg_cur[15] |=3D
> +                                               (ggc->driver_strength_rei=
nit_flg << 28)
> +                                               | (ggc->driver_strength_r=
einit_flg << 20);
> +                                               ret =3D false;
> +
> +                                               goto exit;
> +                                       }
> +                                       cur_selb =3D _ggc_get_suitable_se=
lb_for_next_tuning(host);
> +                               }
> +                               psela_tuning_result[cur_sela] =3D RETUNIN=
G_CASE;
> +                               goto retuning_case;
> +                       }
> +                       ret =3D ggc_sd_tuning(host, NULL);
> +               }
> +
> +               if (ret =3D=3D false) {
> +                       pr_err("BHT ERR:Error when output_tuning, fail at=
 phase %d\n",
> +                                       cur_sela);
> +                       psela_tuning_result[cur_sela] =3D TUNING_FAIL_TYP=
E;
> +                       all_selb_failed_tb_update(host, cur_sela, 0);
> +                       continue;
> +               }
> +
> +               ret =3D _ggc_calc_cur_sela_tuning_result(host, cur_sela, =
cur_selb);
> +
> +               if ((11 - get_bit_number(ggc->ggc_cmd_tx_selb_failed_rang=
e)) >=3D 5) {
> +                       u8 current_ds =3D (u8)(ggc->gg_reg_cur[15] >> 28)=
;
> +
> +                       pr_err("BHT ERR:pass windows too small after resu=
lt calculate, reinit\n");
> +                       if (current_ds < 7)
> +                               ggc->driver_strength_reinit_flg =3D curre=
nt_ds + 1;
> +                       else
> +                               ggc->driver_strength_reinit_flg =3D 7;
> +
> +                       ggc->gg_reg_cur[15] &=3D 0x0F0FFFFF;
> +                       ggc->gg_reg_cur[15] |=3D
> +                               (ggc->driver_strength_reinit_flg << 28)
> +                               | (ggc->driver_strength_reinit_flg << 20)=
;
> +                       ret =3D false;
> +                       pr_err("BHT ERR:will change driver strength from =
%d to %d\n",
> +                                                current_ds,
> +                                                ggc->driver_strength_rei=
nit_flg);
> +                       goto exit;
> +               }
> +
> +               if (ret =3D=3D false) {
> +                       pr_err("BHT ERR:cmd7 timeout fail,reinit\n");
> +                       ggc->tuning_cmd7_timeout_reinit_flg =3D 1;
> +
> +                       _ggc_update_cur_setting_for_sw_selb_tuning(host,
> +                                                       ggc->ggc_cmd_tx_s=
elb_failed_range);
> +                       ggc_hw_inject_may_recursive(host, ggc->ggc_cmd_tx=
_selb_failed_range,
> +                                                       ggc->ggc_cmd_tx_s=
elb_failed_range, false);
> +                       if ((11 - get_bit_number(ggc->ggc_cmd_tx_selb_fai=
led_range))
> +                                                                        =
       >=3D 5) {
> +                               u8 current_ds =3D (u8)(ggc->gg_reg_cur[15=
] >> 28);
> +
> +                               pr_err("BHT ERR:pass windows too small, d=
river strength reinit\n");
> +
> +                               ggc->tuning_cmd7_timeout_reinit_flg =3D 0=
;
> +
> +                               ggc->driver_strength_reinit_flg  =3D
> +                                               current_ds < 7 ? current_=
ds + 1 : 7;
> +
> +                               ggc->gg_reg_cur[15] &=3D 0x0F0FFFFF;
> +                               ggc->gg_reg_cur[15] |=3D
> +                                       (ggc->driver_strength_reinit_flg =
<< 28)
> +                                       | (ggc->driver_strength_reinit_fl=
g << 20);
> +                               ret =3D false;
> +                               pr_err("BHT ERR:will change driver streng=
th from %d to %d\n",
> +                                               current_ds,
> +                                               ggc->driver_strength_rein=
it_flg);
> +                               goto exit;
> +                       }
> +                       goto exit;
> +               }
> +
> +               cur_selb =3D _ggc_get_suitable_selb_for_next_tuning(host)=
;
> +
> +               pr_debug("BHT MSG: output sela:%xh pass\n", cur_sela);
> +               rescan_selb_cnt++;
> +               if ((rescan_selb_cnt < 3) &&
> +                       (selx_failure_point_exist(ggc->ggc_cmd_tx_selb_fa=
iled_range))) {
> +                       pr_debug("BHT MSG:rescan cnt %d, ggc_cmd_tx_selb_=
failed_range=3D0x%x\n",
> +                                               rescan_selb_cnt,
> +                                               ggc->ggc_cmd_tx_selb_fail=
ed_range);
> +                       goto rescan_selb;
> +               }
> +
> +retuning_case:
> +               if (psela_tuning_result[cur_sela] =3D=3D RETUNING_CASE) {
> +                       returning_selb_cnt++;
> +                       if (returning_selb_cnt < 3) {
> +                               rescan_selb_cnt =3D 0;
> +                               pr_debug("BHT MSG:retuning %d\n", rescan_=
selb_cnt);
> +                               goto rescan_selb;
> +                       } else {
> +                               psela_tuning_result[cur_sela] =3D SET_PHA=
SE_FAIL_TYPE;
> +                               all_selb_failed_tb_update(host, cur_sela,=
 0);
> +                               continue;
> +                       }
> +               }
> +
> +               goto next_dll_sela;
> +
> +cur_sela_failed:
> +               pr_debug("BHT MSG:read status failedB\n");
> +               all_selb =3D 0;
> +               all_selb_failed_tb_update(host, cur_sela, all_selb);
> +               pr_debug("BHT MSG: output sela:%xh failed =3D=3D=3D\n", c=
ur_sela);
> +next_dll_sela:
> +               if ((is_bus_mode_sdr104(host) =3D=3D false)
> +                               && ggc->sdr50_notuning_crc_error_flag) {
> +                       u32 fp =3D 0;
> +
> +                       fp =3D GENERATE_IDX_VALUE(cur_sela);
> +                       fp |=3D GENERATE_IDX_VALUE((cur_sela + 1) % TUNIN=
G_PHASE_SIZE);
> +                       fp |=3D GENERATE_IDX_VALUE((cur_sela + 10) % TUNI=
NG_PHASE_SIZE);
> +                       ggc->sdr50_notuning_sela_rx_inject &=3D ~fp;
> +                       ggc->sdr50_notuning_sela_inject_flag =3D 1;
> +                       pr_debug("BHT MSG:sdr50_notuning_sela_rx_inject:%=
x\n",
> +                                               ggc->sdr50_notuning_sela_=
rx_inject);
> +                       ret =3D false;
> +                       goto exit;
> +               };
> +       }
> +
> +       for (i =3D 0; i < TUNING_PHASE_SIZE; i++) {
> +               phase_str(all_str, all_selb_failed_tb_get(host, i));
> +               phase_str(tx_str, tx_selb_failed_tb_get(host, i));
> +               pr_debug
> +                               ("BHT MSG:DLL sela[%x]  all selb: %s   tx=
 selb: %s [%xh,%xh] %s\n",
> +                                       i, all_str, tx_str,
> +                                       all_selb_failed_tb_get(host, i),
> +                                       tx_selb_failed_tb_get(host, i),
> +                                       op_dbg_str[tuning_error_type[i]])=
;
> +
> +       }
> +
> +       /* remove margin passed all selb phase */
> +       for (i =3D 0; i < TUNING_PHASE_SIZE; i++)
> +               all_selb_ar[i] =3D all_selb_failed_tb_get(host, i);
> +
> +       /* calculate cumulation of diagonal bits */
> +       for (idx_c =3D 0; idx_c < TUNING_PHASE_SIZE; idx_c++) {
> +               for (idx_r =3D 0; idx_r < TUNING_PHASE_SIZE;
> +                                       idx_r++) {
> +                       pass_cnt[idx_c] +=3D      ((all_selb_ar[idx_r] >>
> +                                       ((idx_r + idx_c) % TUNING_PHASE_S=
IZE)) & 0x01);
> +               }
> +               if (idx_c =3D=3D 0)
> +                       min_pos =3D 0;
> +               else if (pass_cnt[idx_c] < pass_cnt[min_pos])
> +                       min_pos =3D idx_c;
> +       }
> +       for (i =3D 0; i < TUNING_PHASE_SIZE; i++) {
> +               all_selb_ar[i] &=3D ~(1 << (min_pos + i) % TUNING_PHASE_S=
IZE);
> +               all_selb_failed_tb_update(host, i, all_selb_ar[i]);
> +       }
> +
> +       tx_selb =3D tx_selb_failed_history_get(host);
> +
> +       pr_debug("inject sw selb & merge tx_selb failed point to all_selb=
\n");
> +       for (i =3D 0; i < TUNING_PHASE_SIZE; i++)
> +               all_selb_failed_tb_update(host, i, tx_selb);
> +
> +       pr_debug("BHT MSG:inject sw sela failed point to all_selb\n");
> +       if (is_bus_mode_sdr104(host))
> +               cfg =3D 0x7ff;
> +       else
> +               cfg =3D 0x7ff;
> +
> +       for (i =3D 0; i < TUNING_PHASE_SIZE; i++) {
> +               if (GET_IDX_VALUE(cfg, i) =3D=3D 0)
> +                       all_selb_failed_tb_update(host, i, 0);
> +       }
> +
> +       for (i =3D 0; i < TUNING_PHASE_SIZE; i++) {
> +               phase_str(all_str, all_selb_failed_tb_get(host, i));
> +               phase_str(tx_str, tx_selb_failed_tb_get(host, i));
> +               pr_debug("BHT MSG:DLL sela[%x]  all selb: %s tx selb: %s =
[%xh,%xh] %s\n",
> +                               i, all_str, tx_str,
> +                               all_selb_failed_tb_get(host, i),
> +                               tx_selb_failed_tb_get(host, i),
> +                               op_dbg_str[tuning_error_type[i]]);
> +       }
> +
> +       tx_selb =3D tx_selb_failed_history_get(host);
> +       tx_selb &=3D 0x7ff;
> +       tx_tmp =3D tx_selb;
> +
> +       pr_debug("BHT MSG:---selb merge---\n");
> +       if ((tx_selb&0x7ff) =3D=3D 0x7ff) {
> +               if (is_bus_mode_sdr104(host)) {
> +                       u32 cfg =3D SDR104_MANUAL_INJECT;
> +
> +                       tx_selb &=3D cfg;
> +                       pr_debug("tx selb:%xh SDR104 inject:%xh merge tx_=
selb:%xh\n",
> +                                               tx_tmp, cfg, tx_selb);
> +               } else {
> +                       u32 cfg =3D SDR50_MANUAL_INJECT;
> +
> +                       tx_selb &=3D cfg;
> +                       pr_debug("tx selb:%xh SDR50 inject:%xh merge tx_s=
elb:%xh\n",
> +                                               tx_tmp, cfg, tx_selb);
> +               }
> +       }
> +
> +       if (tx_selb =3D=3D 0) {
> +               pr_err("all failed, force fixed phase sela selb to defaul=
t\n");
> +               target_selb =3D
> +                               get_config_selb_setting(host);
> +               target_sela =3D
> +                               get_config_sela_setting(host);
> +               goto final;
> +       }
> +       phase_str(win_tb, tx_selb);
> +       pr_debug("BHT MSG: tx selb[%xh] 11 bit: %s\n",
> +                                               tx_selb, win_tb);
> +       bits_generate_array(win_tb, tx_selb);
> +       chk_phase_window(win_tb, &win_mid, &win_max);
> +       target_selb =3D win_mid;
> +
> +       all_sela =3D 0;
> +
> +       for (i =3D 0; i < TUNING_PHASE_SIZE; i++) {
> +               u32 all_selb =3D all_selb_failed_tb_get(host, i);
> +
> +               phase_str(win_tb, all_selb);
> +               pr_debug("BHT MSG: all_selb[%xh] 11 bit: %s\n",
> +                               all_selb, win_tb);
> +               bits_generate_array(win_tb, all_selb);
> +               chk_phase_window(win_tb, &win_mid,
> +                                       &win_max);
> +               *selb_pass_win =3D win_max;
> +               if (all_selb & (1 << target_selb))
> +                       all_sela |=3D 1 << i;
> +       }
> +
> +       phase_str(win_tb, all_sela);
> +       pr_debug("BHT MSG: all_sela[%xh] 11 bit: %s\n",
> +                       all_sela, win_tb);
> +       bits_generate_array(win_tb, all_sela);
> +       chk_phase_window(win_tb, &win_mid, &win_max);
> +       target_sela =3D win_mid;
> +
> +final:
> +
> +       gg_fix_output_tuning_phase(host, target_sela,
> +                                               target_selb);
> +
> +       ret =3D sd_gg_tuning_status(host, &tx_selb,
> +                       &all_selb, &raw_tx_selb, &status_ret, NULL);
> +       if (ret =3D=3D false) {
> +               pr_err("Error when output_tuning,  sd_tuning fail\n");
> +               ret =3D false;
> +               goto exit;
> +       }
> +
> +       /* use final pass windows */
> +       phase_str(win_tb, all_selb);
> +       pr_debug("BHT MSG: all_selb[%xh] 11 bit: %s\n",
> +                       all_selb, win_tb);
> +       bits_generate_array(win_tb, all_selb);
> +       chk_phase_window(win_tb, &win_mid, &win_max);
> +       *selb_pass_win =3D win_max;
> +
> +       ggc->selx_tuning_done_flag =3D 1;
> +
> +exit:
> +       pr_debug("BHT MSG:exit:%s  %d\n", __func__, ret);
> +       return ret;
> +}
> +
> +static int sdhci_bht_execute_tuning(struct mmc_host *mmc, u32 opcode)
> +{
> +       struct sdhci_host *host =3D mmc_priv(mmc);
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *vendor_host =3D sdhci_pltfm_priv(pltfm_hos=
t);
> +       struct sdhci_bht_host *ggc =3D sdhci_msm_priv(vendor_host);
> +       u8 tw =3D 0;
> +       int ret =3D 0;
> +
> +       pr_debug("BHT MSG:enter bht tuning\n");
> +       if (host->clock < CORE_FREQ_100MHZ) {
> +               pr_debug("BHT MSG:%d less 100Mhz,no tuning\n", host->cloc=
k);
> +               return 0;
> +       }
> +
> +       if (ggc->tuning_in_progress) {
> +               pr_debug("BHT MSG:tuning_in_progress\n");
> +               return 0;
> +       }
> +       ggc->tuning_in_progress =3D true;
> +
> +       if (ggc->selx_tuning_done_flag) {
> +               pr_debug("BHT MSG:GGC tuning is done, just do vendor host=
 tuning");
> +               if (is_bus_mode_sdr104(host))
> +                       ret =3D sdhci_bht_sdr104_execute_tuning(host, 0x1=
3);
> +               else
> +                       ret =3D sdhci_bht_sdr50_execute_tuning(host, 0x13=
);
> +       } else {
> +               ret =3D !_ggc_output_tuning(host, &tw);
> +       }
> +       ggc->tuning_in_progress =3D false;
> +       return ret;
> +}
> --
> 2.32.0
>
