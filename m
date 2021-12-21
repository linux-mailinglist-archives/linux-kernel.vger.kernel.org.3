Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF34047BD13
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbhLUJmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbhLUJm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:42:28 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D934C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 01:42:28 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id o12so8770743lfk.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 01:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1dLg+x0Sz8xrK3ADDdjg5mR6nu4GSu+J1s7FBuJugdw=;
        b=iuLNC4S5SKTyRRFWOIWEzGZnR5oAkXlS4GXFZoxiw3WbQ8RFitS+YlvN1H2x3B/LV0
         msH+NqrRs7MmKvKZGWhM8R8GCCtDWJXhI4fsDFMRhzwqeDSQHPqLj6K9sgIXM3LZ6H7j
         vsp6lqxnpfv6dMzvZOo4TUrHiX9Z46FzzTQ93LgEOIXmkdAoENOIAjfTNClSvA8pMnPw
         v0UpjdO5/q+hbMOF27W92lSNDZ9lXugxcKBv+ktTfZ/KxTeO7xwu+vZrYQx/fw5y02FH
         mPPlMGIeDSYK4HOnXL0mFE+TjOrxsZui7re09yVGVsxvJHFslUWXbwuSl8srBG46+QUh
         VyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1dLg+x0Sz8xrK3ADDdjg5mR6nu4GSu+J1s7FBuJugdw=;
        b=7l8LjzQDN4fgvRvCtW0NkJKAfINYZiV82hJcJl0ndunh4RgA5EgOOkxstPH1LUz9su
         uk6rZPAEVW1bcrVaVgPr/SoBVJkTXmNwjv5IIyupSFO4WtpS9Pyn9y5FypGuDPiXy098
         tuG4RU5xiKkst+pk0h/F1hW18VWzgpazCRF9iy4jTR4YyrcgC2tBuNkcyoRnnQjG4B9l
         F7BQ42IyZALdOH5v/CHTH3YGvy1LxsqfiZ1X4qIBNi6GgBKc42kTWXnuY4Sm8LchX0Ci
         suR18ne5GeElp8OWUbisM0FNwpMZ2sagQAhnCXcNISI+RTYIifOS4ghNPuxnjPvKcCEF
         NVjw==
X-Gm-Message-State: AOAM533hhahBtzDFy4eZ+Aj/CRjfWMP9aJdzzoU/p+pgeDIV546Hv9me
        xX5cOxCaoF8aobSurfcLQB1jCnyWLpK7hBUEhZVWfsNBAuI=
X-Google-Smtp-Source: ABdhPJyr2R5P9isvwi2aRczPwcQ/5Esh2BNJU/5EvLsau7dBAL7hSQ/9AKyE5serKWE81gvGbRqBbGWpVjaQIXc7gWU=
X-Received: by 2002:a05:6512:3bb:: with SMTP id v27mr2362529lfp.71.1640079746195;
 Tue, 21 Dec 2021 01:42:26 -0800 (PST)
MIME-Version: 1.0
References: <1f9363e146084ba7867f4086f7669198@realtek.com>
In-Reply-To: <1f9363e146084ba7867f4086f7669198@realtek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 21 Dec 2021 10:41:49 +0100
Message-ID: <CAPDyKFpQwmmv09+Fwg1A2A9ZTK6+iCTyxn163-EZ6EVYNtq+Dw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: rtsx: improve performance for multi block rw
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Dec 2021 at 08:33, Ricky WU <ricky_wu@realtek.com> wrote:
>
> Improving performance for the CMD is multi-block read/write
> and the data is sequential.
> sd_check_multi_seq() to distinguish multi-block RW (CMD 18/25)
> or normal RW (CMD 17/24) if the CMD is multi-block and the data is
> sequential then call to sd_rw_multi_seq()

This still doesn't explain what the change really does. How, exactly,
do you improve performance? Are you skipping some commands to be sent
or is the improvement solely based upon how the SD/(e)MMC card behaves
internally?

Of course, I can read the code below and I have a reasonably good idea
of what you want to do. However, the level of complexity for the new
code deserves a better description. Moreover, there is not a single
line of comment being added along the new code, so it's not always
obvious what goes on.

Finally, it would be nice to understand how much of improvement you
get with this change. I suggest you run some benchmarking tool, before
and after the change and provide that data as a part of the commit
message too.

Kind regards
Uffe

>
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> ---
> v2:
> make commit message more clarity
> change function name for more clarity
> ---
>  drivers/mmc/host/rtsx_pci_sdmmc.c | 185 +++++++++++++++++++++++++++++-
>  1 file changed, 180 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
> index 58cfaffa3c2d..ee2b0eec6422 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -22,6 +22,8 @@
>  #include <asm/unaligned.h>
>  #include <linux/pm_runtime.h>
>
> +enum RW_MODE   {NORMAL_RW, SEQ_RW};
> +
>  struct realtek_pci_sdmmc {
>         struct platform_device  *pdev;
>         struct rtsx_pcr         *pcr;
> @@ -31,6 +33,7 @@ struct realtek_pci_sdmmc {
>
>         struct work_struct      work;
>         struct mutex            host_mutex;
> +       struct delayed_work             rw_idle_work;
>
>         u8                      ssc_depth;
>         unsigned int            clock;
> @@ -46,6 +49,12 @@ struct realtek_pci_sdmmc {
>         s32                     cookie;
>         int                     cookie_sg_count;
>         bool                    using_cookie;
> +
> +       enum RW_MODE            rw_mode;
> +       u8              prev_dir;
> +       u8              cur_dir;
> +       u64             prev_sec_addr;
> +       u32             prev_sec_cnt;
>  };
>
>  static int sdmmc_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios);
> @@ -226,6 +235,14 @@ static void sd_send_cmd_get_rsp(struct realtek_pci_sdmmc *host,
>         dev_dbg(sdmmc_dev(host), "%s: SD/MMC CMD %d, arg = 0x%08x\n",
>                         __func__, cmd_idx, arg);
>
> +       if (cmd_idx == MMC_SEND_STATUS && host->rw_mode == SEQ_RW) {
> +               cmd->resp[0] = R1_READY_FOR_DATA | (R1_STATE_TRAN << 9);
> +               goto out;
> +       }
> +
> +       if (!mmc_op_multi(cmd->opcode))
> +               host->rw_mode = NORMAL_RW;
> +
>         rsp_type = sd_response_type(cmd);
>         if (rsp_type < 0)
>                 goto out;
> @@ -542,6 +559,93 @@ static int sd_write_long_data(struct realtek_pci_sdmmc *host,
>         return 0;
>  }
>
> +static int sd_rw_multi_seq(struct realtek_pci_sdmmc *host, struct mmc_request *mrq)
> +{
> +       struct rtsx_pcr *pcr = host->pcr;
> +       struct mmc_host *mmc = host->mmc;
> +       struct mmc_card *card = mmc->card;
> +       struct mmc_data *data = mrq->data;
> +       int uhs = mmc_card_uhs(card);
> +       u8 cfg2;
> +       int err;
> +       size_t data_len = data->blksz * data->blocks;
> +
> +       cfg2 = SD_NO_CALCULATE_CRC7 | SD_CHECK_CRC16 |
> +               SD_NO_WAIT_BUSY_END | SD_NO_CHECK_CRC7 | SD_RSP_LEN_0;
> +
> +       if (!uhs)
> +               cfg2 |= SD_NO_CHECK_WAIT_CRC_TO;
> +
> +       rtsx_pci_init_cmd(pcr);
> +       sd_cmd_set_data_len(pcr, data->blocks, data->blksz);
> +       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, IRQSTAT0,
> +                       DMA_DONE_INT, DMA_DONE_INT);
> +       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, DMATC3,
> +               0xFF, (u8)(data_len >> 24));
> +       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, DMATC2,
> +               0xFF, (u8)(data_len >> 16));
> +       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, DMATC1,
> +               0xFF, (u8)(data_len >> 8));
> +       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, DMATC0, 0xFF, (u8)data_len);
> +
> +       if (host->cur_dir == DMA_DIR_FROM_CARD)
> +               rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, DMACTL,
> +                       0x03 | DMA_PACK_SIZE_MASK,
> +                       DMA_DIR_FROM_CARD | DMA_EN | DMA_512);
> +       else
> +               rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, DMACTL,
> +                       0x03 | DMA_PACK_SIZE_MASK,
> +                       DMA_DIR_TO_CARD | DMA_EN | DMA_512);
> +
> +       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CARD_DATA_SOURCE,
> +                       0x01, RING_BUFFER);
> +       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SD_CFG2, 0xFF, cfg2);
> +
> +       if (host->cur_dir == DMA_DIR_FROM_CARD)
> +               rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SD_TRANSFER, 0xFF,
> +                               SD_TRANSFER_START | SD_TM_AUTO_READ_3);
> +       else
> +               rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SD_TRANSFER, 0xFF,
> +                               SD_TRANSFER_START | SD_TM_AUTO_WRITE_3);
> +
> +       rtsx_pci_add_cmd(pcr, CHECK_REG_CMD, SD_TRANSFER,
> +                       SD_TRANSFER_END, SD_TRANSFER_END);
> +       rtsx_pci_send_cmd_no_wait(pcr);
> +
> +       if (host->cur_dir == DMA_DIR_FROM_CARD)
> +               err = rtsx_pci_dma_transfer(pcr, data->sg, host->sg_count, 1, 10000);
> +       else
> +               err = rtsx_pci_dma_transfer(pcr, data->sg, host->sg_count, 0, 10000);
> +
> +       if (err < 0) {
> +               sd_clear_error(host);
> +               return err;
> +       }
> +
> +       return 0;
> +}
> +
> +static int sd_stop_rw_multi_seq(struct realtek_pci_sdmmc *host, struct mmc_request *mrq)
> +{
> +       struct rtsx_pcr *pcr = host->pcr;
> +       struct mmc_command *cmd;
> +
> +       cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
> +
> +       cmd->opcode = MMC_STOP_TRANSMISSION;
> +       cmd->arg = 0;
> +       cmd->busy_timeout = 0;
> +       if (host->cur_dir == DMA_DIR_FROM_CARD)
> +               cmd->flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
> +       else
> +               cmd->flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
> +       sd_send_cmd_get_rsp(host, cmd);
> +       udelay(50);
> +       rtsx_pci_write_register(pcr, RBCTL, RB_FLUSH, RB_FLUSH);
> +       kfree(cmd);
> +       return 0;
> +}
> +
>  static inline void sd_enable_initial_mode(struct realtek_pci_sdmmc *host)
>  {
>         rtsx_pci_write_register(host->pcr, SD_CFG1,
> @@ -796,6 +900,45 @@ static inline int sd_rw_cmd(struct mmc_command *cmd)
>                 (cmd->opcode == MMC_WRITE_BLOCK);
>  }
>
> +static void sd_rw_idle_work(struct work_struct *work)
> +{
> +       struct delayed_work *dwork = to_delayed_work(work);
> +       struct realtek_pci_sdmmc *host = container_of(dwork,
> +                       struct realtek_pci_sdmmc, rw_idle_work);
> +       struct mmc_command *cmd;
> +
> +       cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
> +
> +       cmd->opcode = MMC_STOP_TRANSMISSION;
> +       cmd->arg = 0;
> +       cmd->busy_timeout = 0;
> +       if (host->cur_dir == DMA_DIR_FROM_CARD)
> +               cmd->flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
> +       else
> +               cmd->flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
> +
> +       sd_send_cmd_get_rsp(host, cmd);
> +       host->rw_mode = NORMAL_RW;
> +       kfree(cmd);
> +}
> +
> +static int sd_check_multi_seq(struct realtek_pci_sdmmc *host, struct mmc_request *mrq)
> +{
> +       struct mmc_command *cmd = mrq->cmd;
> +       struct mmc_data *data = mrq->data;
> +
> +       if (!mmc_op_multi(cmd->opcode))
> +               return 0;
> +
> +       if (host->prev_dir != host->cur_dir)
> +               return 0;
> +
> +       if ((host->prev_sec_addr + host->prev_sec_cnt) != data->blk_addr)
> +               return 0;
> +
> +       return 1;
> +}
> +
>  static void sd_request(struct work_struct *work)
>  {
>         struct realtek_pci_sdmmc *host = container_of(work,
> @@ -841,12 +984,36 @@ static void sd_request(struct work_struct *work)
>         if (!data_size) {
>                 sd_send_cmd_get_rsp(host, cmd);
>         } else if (sd_rw_cmd(cmd) || sdio_extblock_cmd(cmd, data)) {
> -               cmd->error = sd_rw_multi(host, mrq);
> -               if (!host->using_cookie)
> -                       sdmmc_post_req(host->mmc, host->mrq, 0);
> +               /* Check multi-block and seq function*/
> +               if (data->flags & MMC_DATA_READ)
> +                       host->cur_dir = DMA_DIR_FROM_CARD;
> +               else
> +                       host->cur_dir = DMA_DIR_TO_CARD;
> +
> +               if (host->rw_mode == SEQ_RW) {
> +                       cancel_delayed_work(&host->rw_idle_work);
> +                       if (!sd_check_multi_seq(host, mrq)) {
> +                               sd_stop_rw_multi_seq(host, mrq);
> +                               host->rw_mode = NORMAL_RW;
> +                       }
> +               }
> +
> +               if (host->rw_mode == SEQ_RW)
> +                       cmd->error = sd_rw_multi_seq(host, mrq);
> +               else {
> +                       if (mmc_op_multi(cmd->opcode))
> +                               host->rw_mode = SEQ_RW;
> +                       cmd->error = sd_rw_multi(host, mrq);
> +                       if (!host->using_cookie)
> +                               sdmmc_post_req(host->mmc, host->mrq, 0);
> +               }
> +
> +               if (cmd->error)
> +                       host->rw_mode = NORMAL_RW;
> +
> +               if (mmc_op_multi(cmd->opcode) && host->rw_mode == SEQ_RW)
> +                       mod_delayed_work(system_wq, &host->rw_idle_work, msecs_to_jiffies(150));
>
> -               if (mmc_op_multi(cmd->opcode) && mrq->stop)
> -                       sd_send_cmd_get_rsp(host, mrq->stop);
>         } else {
>                 sd_normal_rw(host, mrq);
>         }
> @@ -867,6 +1034,11 @@ static void sd_request(struct work_struct *work)
>         }
>
>         mutex_lock(&host->host_mutex);
> +       if (sd_rw_cmd(cmd) || sdio_extblock_cmd(cmd, data)) {
> +               host->prev_dir = host->cur_dir;
> +               host->prev_sec_addr = data->blk_addr;
> +               host->prev_sec_cnt = data->blocks;
> +       }
>         host->mrq = NULL;
>         mutex_unlock(&host->host_mutex);
>
> @@ -1457,6 +1629,7 @@ static void rtsx_pci_sdmmc_card_event(struct platform_device *pdev)
>         struct realtek_pci_sdmmc *host = platform_get_drvdata(pdev);
>
>         host->cookie = -1;
> +       host->rw_mode = NORMAL_RW;
>         mmc_detect_change(host->mmc, 0);
>  }
>
> @@ -1487,6 +1660,7 @@ static int rtsx_pci_sdmmc_drv_probe(struct platform_device *pdev)
>         host->cookie = -1;
>         host->power_state = SDMMC_POWER_OFF;
>         INIT_WORK(&host->work, sd_request);
> +       INIT_DELAYED_WORK(&host->rw_idle_work, sd_rw_idle_work);
>         platform_set_drvdata(pdev, host);
>         pcr->slots[RTSX_SD_CARD].p_dev = pdev;
>         pcr->slots[RTSX_SD_CARD].card_event = rtsx_pci_sdmmc_card_event;
> @@ -1526,6 +1700,7 @@ static int rtsx_pci_sdmmc_drv_remove(struct platform_device *pdev)
>                 pm_runtime_disable(&pdev->dev);
>         }
>
> +       cancel_delayed_work_sync(&host->rw_idle_work);
>         cancel_work_sync(&host->work);
>
>         mutex_lock(&host->host_mutex);
> --
> 2.25.1
