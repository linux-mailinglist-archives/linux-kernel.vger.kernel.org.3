Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEF94C572E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 18:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbiBZRzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 12:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiBZRzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 12:55:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8035AA024;
        Sat, 26 Feb 2022 09:54:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64793B80947;
        Sat, 26 Feb 2022 17:54:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924F5C340E8;
        Sat, 26 Feb 2022 17:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645898062;
        bh=FCbTWnkvqcY+p5LVWDDYg6OE7PvWK1uaWEp7papnCU4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vIGp7sNDgCk9r7szjI366/IOTTQAHJILLA8/mt83rclKu4HnyZhUgSd8lWs3sjVSh
         7UwU4bnpr/D7jgX4yjc3N/3Cw0GUJFWflbyCYcGlUM9ljSiEKCIo527P/8RzqsBdDB
         e0s7qK7d0GHTGu9+UZ66Qxe60bw3pG7ddevMohAxwXlJCVDS9crng7+VpNtFA8ygXV
         RYofOSs9Fjvw/3HZtP141Vx5bRS96R+NX7cI2/RFxJa9YW0hDuDhnDP3t380+5J2IW
         peN6f0Zu6D0vcYXYIDmWivWYh3sNBqlcq9EtE/AN9Cdgk9KteHVtvDl3pCsIPkyCjg
         Dr8ypLa5v+PvA==
Date:   Sat, 26 Feb 2022 18:01:24 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Colin King (gmail)" <colin.i.king@gmail.com>
Cc:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: iio:adc:ad7280a: Move out of staging
Message-ID: <20220226180124.175f6162@jic23-huawei>
In-Reply-To: <69aeef03-69ba-07f4-2506-31e481f86c76@gmail.com>
References: <69aeef03-69ba-07f4-2506-31e481f86c76@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2022 22:56:20 +0000
"Colin King (gmail)" <colin.i.king@gmail.com> wrote:

> Hi,
> 
> Static analysis with clang scan picked up a potential issue with 
> drivers/iio/adc/ad7280a.c in function ad7280a_write_thresh, the analysis 
> is as follows:
> 
>          switch (chan->type) {
>          case IIO_VOLTAGE:
>                  value = ((val - 1000) * 100) / 1568; /* LSB 15.68mV */
>                  value = clamp(value, 0L, 0xFFL);
> 
>                  ^^
> Note: variable value is being assigned a value
> 
>                  switch (dir) {
>                  case IIO_EV_DIR_RISING:
>                          addr = AD7280A_CELL_OVERVOLTAGE_REG;
>                          ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, 
> addr,
>                                             1, val);
>                          if (ret)
>                                  break;
>                          st->cell_threshhigh = value;
> 
> ..and value is being used here ^^
> 
>                          break;
>                  case IIO_EV_DIR_FALLING:
>                          addr = AD7280A_CELL_UNDERVOLTAGE_REG;
>                          ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, 
> addr,
>                                             1, val);
>                          if (ret)
>                                  break;
>                          st->cell_threshlow = value;
> 
> and value is being used here ^^
> 
>                          break;
>                  default:
>                          ret = -EINVAL;
>                          goto err_unlock;
>                  }
>                  break;
> 
> However for the IIO_TEMP case:
> 
>          case IIO_TEMP:
>                  value = (val * 10) / 196; /* LSB 19.6mV */
>                  value = clamp(value, 0L, 0xFFL);
> 
>                  ^^
> Note: variable value is being assigned a value
> 
>                  switch (dir) {
>                  case IIO_EV_DIR_RISING:
>                          addr = AD7280A_AUX_ADC_OVERVOLTAGE_REG;
>                          ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, 
> addr,
>                                             1, val);
>                          if (ret)
>                                  break;
>                          st->aux_threshhigh = val;
>                                               ^^
> But val is being used here rather than value
> 
>                          break;
>                  case IIO_EV_DIR_FALLING:
>                          addr = AD7280A_AUX_ADC_UNDERVOLTAGE_REG;
>                          ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, 
> addr,
>                                             1, val);
>                          if (ret)
>                                  break;
>                          st->aux_threshlow = val;
>                                              ^^
> and val us being used here rather than value too
> 
> 
> So for the IIO_TEMP case either the assignment to value is redundant or 
> the setting of st->aux_threshhigh or st->auxthreashlow is incorrect.

Good spot Colin.

There is clearly something wrong here. Looking back at the patch where
I refactored this it looks to me like I messed up a variable rename
and all those writes + setting of aux_threshlow and similar should be using
value, not val.
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=togreg&id=112bf4aa4afb5608d77ac9208758528bcdfae70d

The modeling we used to verify that particular feature 'worked'
was rather minimal so missed this.

I'll roll a patch an send out shortly.  No huge rush as fix can go in during
the rc phase of 5.18 if we don't get it reviewed fast enough to make the
merge window.

Thanks,

Jonathan



> 
> Colin

