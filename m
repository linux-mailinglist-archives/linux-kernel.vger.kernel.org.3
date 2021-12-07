Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E5C46B25B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 06:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbhLGFaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 00:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbhLGFa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 00:30:29 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E166DC061746;
        Mon,  6 Dec 2021 21:26:59 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so1033822pjc.4;
        Mon, 06 Dec 2021 21:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9ovNqKLM8DfKM0dll8ggaH/2TM9J/6RL9ZGDKw88N+4=;
        b=f+jCUAm+bCAy+8ipqGWFQ8UZ7oMKbwNiPL6NYNzURwixp/bTFbwtc+JfTfs9EnebMX
         jOhzpRAoqTu8nqDB2OeuH9Q/pb8jOaBTyMiXu8th+pBFg+/7ElvTLhqXbKZMEzQOgLmC
         ZowcQk8RLCLA5qo6bmYx/Sx3FRj5rYuS96QZZqzNyK/urbUAw4V53BR9xuh5tmv/Vbyq
         CinpgBt6pD5uNxTFjCf5xy2+w/0nIHgYdvTaaYZxlCzCyJWpnrwjYlhwgt2Ii0gdqfI5
         +2An7yaVhVVrk1nNjgCH8917qNuicDHGW4rqwhTRsgzZLnQvOvAVm57/0LAyWxo9GC2F
         iQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9ovNqKLM8DfKM0dll8ggaH/2TM9J/6RL9ZGDKw88N+4=;
        b=NfZTtyzbA8s0ZZEE62sLYLaAST9wPYcliuCON6SBV4t1yU2JHwXPmkWIrpWoDmW66h
         QyUUCDD+DOVHXFqibzymr4vdHF7xFmNemSrt+gVy/bVzXcWZcSiWCopzS0gtVXSPMulS
         khU7RKu46QBQI4nP7cBBZr6fKmyTCwSKRboEMoVdGYEItZTTztClp0LqDgkmmjQLv5la
         zH3jipVx879nX//PYyRo3Vox1udfN/rfwJj8a9dOsufv5XjYuZL7YIj/lus9Kn3r+EcZ
         8bbawT1nWa4eVvhuFHPG7OPdmvR8x3zIeBdrcBCKeHYhBCe85bL7uW9tP1EnMkJFgHq/
         HW8w==
X-Gm-Message-State: AOAM530g6YBSb7fc5fpGRsETA8q3Q9eAqcc1TqeXiSySXq5ZvGNgugAV
        lsK/H66HNBIpuBTCez8GHm4=
X-Google-Smtp-Source: ABdhPJyvBMcy8o3j6kEQNUJJKDyOgUfCeelyb/aoKIIPW95tG2vyOX883bN6/QFfi7JpT5cUV5Qv2w==
X-Received: by 2002:a17:902:b7c8:b0:141:9ddb:33e7 with SMTP id v8-20020a170902b7c800b001419ddb33e7mr49141097plz.60.1638854819212;
        Mon, 06 Dec 2021 21:26:59 -0800 (PST)
Received: from nishad ([2406:7400:61:6687:fd10:b36d:bcea:520])
        by smtp.gmail.com with ESMTPSA id e4sm11452187pgi.21.2021.12.06.21.26.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Dec 2021 21:26:58 -0800 (PST)
Date:   Tue, 7 Dec 2021 10:56:48 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Stephen Boyd <swboyd@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bean Huo <beanhuo@micron.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Huijin Park <huijin.park@samsung.com>,
        Yue Hu <huyue2@yulong.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: core: Add support for the eMMC RTC feature in
 mmc_ops
Message-ID: <20211207052647.GA5700@nishad>
References: <20211205191009.32454-1-nishadkamdar@gmail.com>
 <CAE-0n515qDr95A5PgbhpYer+UT053VzbaDKrxe6zjVgAQwpcEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n515qDr95A5PgbhpYer+UT053VzbaDKrxe6zjVgAQwpcEw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 12:44:14PM -0800, Stephen Boyd wrote:
> Quoting Nishad Kamdar (2021-12-05 11:10:08)
> > diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> > index d63d1c735335..490372341b3b 100644
> > --- a/drivers/mmc/core/mmc_ops.c
> > +++ b/drivers/mmc/core/mmc_ops.c
> > @@ -1063,3 +1063,62 @@ int mmc_sanitize(struct mmc_card *card, unsigned int timeout_ms)
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
> 
> Use some #define for 512 because it's used three times in here?
ok, but there is not #define for 512 as it is the variable block size
value. Hence, other functions in the same file like mmc_get_ext_csd() also use
the 512 value directly.

> > +       if (!data_buf)
> > +               return -ENOMEM;
> > +
> > +       if (rtc_info_type == 0x01 || rtc_info_type == 0x02 ||
> > +           rtc_info_type == 0x03) {
> > +               data_buf[0] = 0x01;
> > +               data_buf[1] = rtc_info_type;
> > +               memcpy(&data_buf[2], &seconds, sizeof(u64));
> 
> Use sizeof(seconds) instead?
> 
ok, I will do that.

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
> 
> Why not
> 
> 	if (cmd.error) {
> 		err = cmd.error;
> 	} else if (data.error) {
> 		err = data.error;
> 	} else {
> 		err = 0;
> 	}
> 
> > +out:
> 
> And then drop out: and the assignment of err to 0 up above?
ok, I will do that.

> 
> > +       kfree(data_buf);
> > +       return err;
> > +}
> > +EXPORT_SYMBOL_GPL(mmc_set_time);
