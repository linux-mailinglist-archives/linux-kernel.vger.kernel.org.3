Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522644ACAB4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 21:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbiBGUsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 15:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242356AbiBGUea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 15:34:30 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9F2C0401DA;
        Mon,  7 Feb 2022 12:34:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C16CCCE10EF;
        Mon,  7 Feb 2022 20:34:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DEFCC004E1;
        Mon,  7 Feb 2022 20:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644266064;
        bh=giICZhsUziDvrYvWPDA2iU8E3nSJhUa1SWMle+KbYf4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J4oxgbIZYAH0XKXdNuXYrGxmlls6u7UM9dUOH2MBlhwsE7uHTUb62VjVynFNtvRr7
         o1bm0sfcKr4DSQlWxQpB4g6e7TjHqc6HqLylLA0b44pCDUvCm781PgUOMuPGjh/BSY
         XW1mukZecLRbqrv4mYhePJKyO2zx/ERi4Y+S7DuYCdc5tq1PargQHz8/bN4gLacy4V
         EfvWLJC84eZ/4GJ7vD2lLxu8KC0CBLCgUs/MIKvazViPFdIMnQjmUyyl+GhgrVhMqn
         h0TQzebY4IbBP3wWaru1/6PRWtfmbs8LB8YQY4UnMgu1KWVaudeR3ji0oy00TLevCg
         NfTtDRp65ZbWw==
Date:   Mon, 7 Feb 2022 20:40:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: cpcap-adc: remove redundant assignment to
 variable cal_data_diff
Message-ID: <20220207204059.67f0f1e8@jic23-huawei>
In-Reply-To: <20220207135943.340629-1-colin.i.king@gmail.com>
References: <20220207135943.340629-1-colin.i.king@gmail.com>
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

On Mon,  7 Feb 2022 13:59:43 +0000
Colin Ian King <colin.i.king@gmail.com> wrote:

> The variable cal_data_diff is being assigned a value that is never read,
> it is being re-assigned later on with a new value in both paths of an
> if statement. The assignment is redundant, so remove it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/cpcap-adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/cpcap-adc.c b/drivers/iio/adc/cpcap-adc.c
> index 40e59f4c95bc..b6c4ef70484e 100644
> --- a/drivers/iio/adc/cpcap-adc.c
> +++ b/drivers/iio/adc/cpcap-adc.c
> @@ -474,7 +474,7 @@ static int cpcap_adc_calibrate_one(struct cpcap_adc *ddata,
>  	for (i = 0; i < CPCAP_ADC_MAX_RETRIES; i++) {
>  		calibration_data[0]  = 0;
>  		calibration_data[1]  = 0;
> -		cal_data_diff = 0;
> +
>  		cpcap_adc_setup_calibrate(ddata, channel);
>  		error = regmap_read(ddata->reg, calibration_register,
>  				    &calibration_data[0]);

