Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE5D480C48
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 19:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236869AbhL1SBZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Dec 2021 13:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235998AbhL1SBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 13:01:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB84EC061574;
        Tue, 28 Dec 2021 10:01:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A4F4B80D35;
        Tue, 28 Dec 2021 18:01:23 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 48139C36AED;
        Tue, 28 Dec 2021 18:01:19 +0000 (UTC)
Date:   Tue, 28 Dec 2021 18:07:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>
Subject: Re: [PATCH v2 09/23] counter: ftm-quaddec: Convert to
 counter_priv() wrapper
Message-ID: <20211228180703.64e11e6c@jic23-huawei>
In-Reply-To: <20211227094526.698714-10-u.kleine-koenig@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
        <20211227094526.698714-10-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021 10:45:12 +0100
Uwe Kleine-König         <u.kleine-koenig@pengutronix.de> wrote:

> This is a straight forward conversion to the new counter_priv() wrapper.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/counter/ftm-quaddec.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
> index 9272f7b58beb..f5d92df6a611 100644
> --- a/drivers/counter/ftm-quaddec.c
> +++ b/drivers/counter/ftm-quaddec.c
> @@ -118,7 +118,7 @@ static void ftm_quaddec_disable(void *ftm)
>  static int ftm_quaddec_get_prescaler(struct counter_device *counter,
>  				     struct counter_count *count, u32 *cnt_mode)
>  {
> -	struct ftm_quaddec *ftm = counter->priv;
> +	struct ftm_quaddec *ftm = counter_priv(counter);
>  	uint32_t scflags;
>  
>  	ftm_read(ftm, FTM_SC, &scflags);
> @@ -131,7 +131,7 @@ static int ftm_quaddec_get_prescaler(struct counter_device *counter,
>  static int ftm_quaddec_set_prescaler(struct counter_device *counter,
>  				     struct counter_count *count, u32 cnt_mode)
>  {
> -	struct ftm_quaddec *ftm = counter->priv;
> +	struct ftm_quaddec *ftm = counter_priv(counter);
>  
>  	mutex_lock(&ftm->ftm_quaddec_mutex);
>  
> @@ -162,7 +162,7 @@ static int ftm_quaddec_count_read(struct counter_device *counter,
>  				  struct counter_count *count,
>  				  u64 *val)
>  {
> -	struct ftm_quaddec *const ftm = counter->priv;
> +	struct ftm_quaddec *const ftm = counter_priv(counter);
>  	uint32_t cntval;
>  
>  	ftm_read(ftm, FTM_CNT, &cntval);
> @@ -176,7 +176,7 @@ static int ftm_quaddec_count_write(struct counter_device *counter,
>  				   struct counter_count *count,
>  				   const u64 val)
>  {
> -	struct ftm_quaddec *const ftm = counter->priv;
> +	struct ftm_quaddec *const ftm = counter_priv(counter);
>  
>  	if (val != 0) {
>  		dev_warn(&ftm->pdev->dev, "Can only accept '0' as new counter value\n");

