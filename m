Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB0446B715
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbhLGJdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 04:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhLGJdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:33:53 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D8CC061574;
        Tue,  7 Dec 2021 01:30:23 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id u11so9024198plf.3;
        Tue, 07 Dec 2021 01:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XsBAupUFXIUKIpyXODAMGy9jW4cjeYL8L/e8t5OihEc=;
        b=PVX7ncs9rsBPmGK5jqZ33db/boszED9T1ZffCvooNnKYdJPamsGVYHzbgmwG3XYN9C
         pJhzBdBGUpY0OXe/m5zW1i5LvRg/x7dixXOT5DAGP3hfto5G9t9JTYGIQ+PzRpz0gbWM
         wVduv5AzT5seaoPZ+jtNtAM7Lnl2deEawJWSrYCtL5KquD+TA393sv/FP5RJQfWSdYr5
         fZPpAs3W2D9RprdoLd05BTLlWGGRioo0C7ItiuBx4fDzd8o9lllguJgI8qJ30hG/2yQD
         7pRhd16IMRAFfJDB2ZFYfhfNCX3wp0F+m6va/P93hPhi28g5mHkpcrS85b0E+/vxMJmZ
         k4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XsBAupUFXIUKIpyXODAMGy9jW4cjeYL8L/e8t5OihEc=;
        b=vjSjuOsTNy3zp+hLbXPocv+FTgD0ntRwM6OalQ95trXhlE8YZkX0pc8E4ISmKeAove
         L9/xUsEw/f1n1HMUFjWf+nRDKbRGOYdFtiN/xXPYm8vefQ3uko9lNOEhZLFEDHcqU11U
         hvs9CHb2xJI5x8wpW2uATwnQ35SuglbreOj+8WAYaWNxvSJFBMrdYWKgdkZt3gttFCjd
         OUM8XAfSKm68oTOlzj7IucwM02tYuyu5tURT1xnmAGPx050CEkB24txwU5TkjAIn96ew
         Pqo3cReWZyiuBiEiW4SIBfxt+n7aUu5wef03IGWdb48TpdJN6CntofyE2NUy87RGBRVc
         sMRQ==
X-Gm-Message-State: AOAM532267WhcFhQY7+2RjNeFDQjoJc3dhlb/1+5QnUoolDO8fip5iMO
        l2l1VQsQA2KqP8brLhrLPC4=
X-Google-Smtp-Source: ABdhPJzOfP5dwCVtS+XtgDbhwxsskeBKoRhSviJJc81kK76QDtriGt9JZzv3/8GTUPuoNHArALM2cQ==
X-Received: by 2002:a17:90b:3758:: with SMTP id ne24mr5205552pjb.59.1638869423086;
        Tue, 07 Dec 2021 01:30:23 -0800 (PST)
Received: from nishad ([2406:7400:61:6687:fd10:b36d:bcea:520])
        by smtp.gmail.com with ESMTPSA id f21sm16977512pfc.191.2021.12.07.01.30.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Dec 2021 01:30:22 -0800 (PST)
Date:   Tue, 7 Dec 2021 15:00:11 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bean Huo <beanhuo@micron.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Huijin Park <huijin.park@samsung.com>,
        Yue Hu <huyue2@yulong.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Christian =?utf-8?B?TMO2aGxl?= <CLoehle@hyperstone.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nishadkamdar@gmail.com
Subject: Re: [PATCH] mmc: core: Add support for the eMMC RTC feature in
 mmc_ops
Message-ID: <20211207093009.GA11794@nishad>
References: <20211205191009.32454-1-nishadkamdar@gmail.com>
 <DM6PR04MB657527FCF325EA9760032DA5FC6E9@DM6PR04MB6575.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR04MB657527FCF325EA9760032DA5FC6E9@DM6PR04MB6575.namprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 08:28:42AM +0000, Avri Altman wrote:
>  
> > This patch adds support to set the RTC information in
> > the eMMC device. This is based on the JEDEC specification.
> > 
> > There is no way however, to read the RTC time from the
> > device. Hence we rely on the response of the CMD49 to
> > confirm the completion of the operation.
> > 
> > This patch has been tested successfully with the ioctl
> > interface. This patch has also been tested suceessfully
> > with all the three RTC_INFO_TYPEs.
> If this is triggered from user-space via ioctl anyway,
> Why do we need this command to be implemented in the kernel?
> Why not just add this to mmc-utils?
> 
> Thanks,
> Avri
As per the spec, B51: Section 6.6.35:
Providing RTC info may be useful for internal maintainance operations.
And the host should send it on the following events:
- power-up
- wake-up
- Periodically
Hence IMO, the Kernel would be the right place of peforming this
operation.

Thanks for the response,
Nisha
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> >  drivers/mmc/core/mmc_ops.c | 59
> > ++++++++++++++++++++++++++++++++++++++
> >  drivers/mmc/core/mmc_ops.h |  2 ++
> >  include/linux/mmc/mmc.h    |  1 +
> >  3 files changed, 62 insertions(+)
> > 
> > diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> > index d63d1c735335..490372341b3b 100644
> > --- a/drivers/mmc/core/mmc_ops.c
> > +++ b/drivers/mmc/core/mmc_ops.c
> > @@ -1063,3 +1063,62 @@ int mmc_sanitize(struct mmc_card *card,
> > unsigned int timeout_ms)
> >         return err;
> >  }
> >  EXPORT_SYMBOL_GPL(mmc_sanitize);
> > +
> > +int mmc_set_time(struct mmc_card *card, struct mmc_host *host,
> > +                u8 rtc_info_type, u64 seconds)
> > +{
> > +       struct mmc_request mrq = {};
> > +       struct mmc_command cmd = {};
> > +       struct mmc_data data = {};
> > +       struct scatterlist sg;
> > +       int err = 0;
> > +       u8 *data_buf;
> > +
> > +       data_buf = kzalloc(512, GFP_KERNEL);
> > +       if (!data_buf)
> > +               return -ENOMEM;
> > +
> > +       if (rtc_info_type == 0x01 || rtc_info_type == 0x02 ||
> > +           rtc_info_type == 0x03) {
> > +               data_buf[0] = 0x01;
> > +               data_buf[1] = rtc_info_type;
> > +               memcpy(&data_buf[2], &seconds, sizeof(u64));
> > +       } else {
> > +               pr_err("%s: invalid rtc_info_type %d\n",
> > +                      mmc_hostname(host), rtc_info_type);
> > +               kfree(data_buf);
> > +               return -EINVAL;
> > +       }
> > +
> > +       mrq.cmd = &cmd;
> > +       mrq.data = &data;
> > +
> > +       cmd.opcode = MMC_SET_TIME;
> > +       cmd.arg = 0;
> > +       cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
> > +
> > +       data.blksz = 512;
> > +       data.blocks = 1;
> > +       data.flags = MMC_DATA_WRITE;
> > +       data.sg = &sg;
> > +       data.sg_len = 1;
> > +       sg_init_one(&sg, data_buf, 512);
> > +
> > +       mmc_set_data_timeout(&data, card);
> > +
> > +       mmc_wait_for_req(host, &mrq);
> > +
> > +       if (cmd.error) {
> > +               err = cmd.error;
> > +               goto out;
> > +       }
> > +
> > +       if (data.error) {
> > +               err = data.error;
> > +               goto out;
> > +       }
> > +out:
> > +       kfree(data_buf);
> > +       return err;
> > +}
> > +EXPORT_SYMBOL_GPL(mmc_set_time);
> > diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
> > index 9c813b851d0b..0c8695d1b363 100644
> > --- a/drivers/mmc/core/mmc_ops.h
> > +++ b/drivers/mmc/core/mmc_ops.h
> > @@ -55,6 +55,8 @@ void mmc_run_bkops(struct mmc_card *card);
> >  int mmc_cmdq_enable(struct mmc_card *card);
> >  int mmc_cmdq_disable(struct mmc_card *card);
> >  int mmc_sanitize(struct mmc_card *card, unsigned int timeout_ms);
> > +int mmc_set_time(struct mmc_card *card, struct mmc_host *host,
> > +                u8 rtc_info_type, u64 seconds);
> > 
> >  #endif
> > 
> > diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> > index d9a65c6a8816..52a3bf873d50 100644
> > --- a/include/linux/mmc/mmc.h
> > +++ b/include/linux/mmc/mmc.h
> > @@ -64,6 +64,7 @@
> >  #define MMC_WRITE_MULTIPLE_BLOCK 25   /* adtc                    R1  */
> >  #define MMC_PROGRAM_CID          26   /* adtc                    R1  */
> >  #define MMC_PROGRAM_CSD          27   /* adtc                    R1  */
> > +#define MMC_SET_TIME            49   /* adtc                    R1  */
> > 
> >    /* class 6 */
> >  #define MMC_SET_WRITE_PROT       28   /* ac   [31:0] data addr   R1b */
> > --
> > 2.17.1
> 
