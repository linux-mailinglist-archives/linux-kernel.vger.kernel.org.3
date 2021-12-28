Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344CD480C46
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 19:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236861AbhL1SA5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Dec 2021 13:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235998AbhL1SAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 13:00:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F6BC061574;
        Tue, 28 Dec 2021 10:00:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2AF0BB812A5;
        Tue, 28 Dec 2021 18:00:54 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 1497BC36AED;
        Tue, 28 Dec 2021 18:00:48 +0000 (UTC)
Date:   Tue, 28 Dec 2021 18:06:33 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        "Felipe Balbi (Intel)" <balbi@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>
Subject: Re: [PATCH v2 08/23] counter: intel-qep: Convert to counter_priv()
 wrapper
Message-ID: <20211228180633.090d618c@jic23-huawei>
In-Reply-To: <20211227094526.698714-9-u.kleine-koenig@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
        <20211227094526.698714-9-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021 10:45:11 +0100
Uwe Kleine-König         <u.kleine-koenig@pengutronix.de> wrote:

> This is a straight forward conversion to the new counter_priv() wrapper.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/counter/intel-qep.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
> index 0924d16de6e2..8f84a48508ac 100644
> --- a/drivers/counter/intel-qep.c
> +++ b/drivers/counter/intel-qep.c
> @@ -109,7 +109,7 @@ static void intel_qep_init(struct intel_qep *qep)
>  static int intel_qep_count_read(struct counter_device *counter,
>  				struct counter_count *count, u64 *val)
>  {
> -	struct intel_qep *const qep = counter->priv;
> +	struct intel_qep *const qep = counter_priv(counter);
>  
>  	pm_runtime_get_sync(qep->dev);
>  	*val = intel_qep_readl(qep, INTEL_QEPCOUNT);
> @@ -176,7 +176,7 @@ static struct counter_synapse intel_qep_count_synapses[] = {
>  static int intel_qep_ceiling_read(struct counter_device *counter,
>  				  struct counter_count *count, u64 *ceiling)
>  {
> -	struct intel_qep *qep = counter->priv;
> +	struct intel_qep *qep = counter_priv(counter);
>  
>  	pm_runtime_get_sync(qep->dev);
>  	*ceiling = intel_qep_readl(qep, INTEL_QEPMAX);
> @@ -188,7 +188,7 @@ static int intel_qep_ceiling_read(struct counter_device *counter,
>  static int intel_qep_ceiling_write(struct counter_device *counter,
>  				   struct counter_count *count, u64 max)
>  {
> -	struct intel_qep *qep = counter->priv;
> +	struct intel_qep *qep = counter_priv(counter);
>  	int ret = 0;
>  
>  	/* Intel QEP ceiling configuration only supports 32-bit values */
> @@ -213,7 +213,7 @@ static int intel_qep_ceiling_write(struct counter_device *counter,
>  static int intel_qep_enable_read(struct counter_device *counter,
>  				 struct counter_count *count, u8 *enable)
>  {
> -	struct intel_qep *qep = counter->priv;
> +	struct intel_qep *qep = counter_priv(counter);
>  
>  	*enable = qep->enabled;
>  
> @@ -223,7 +223,7 @@ static int intel_qep_enable_read(struct counter_device *counter,
>  static int intel_qep_enable_write(struct counter_device *counter,
>  				  struct counter_count *count, u8 val)
>  {
> -	struct intel_qep *qep = counter->priv;
> +	struct intel_qep *qep = counter_priv(counter);
>  	u32 reg;
>  	bool changed;
>  
> @@ -256,7 +256,7 @@ static int intel_qep_spike_filter_ns_read(struct counter_device *counter,
>  					  struct counter_count *count,
>  					  u64 *length)
>  {
> -	struct intel_qep *qep = counter->priv;
> +	struct intel_qep *qep = counter_priv(counter);
>  	u32 reg;
>  
>  	pm_runtime_get_sync(qep->dev);
> @@ -277,7 +277,7 @@ static int intel_qep_spike_filter_ns_write(struct counter_device *counter,
>  					   struct counter_count *count,
>  					   u64 length)
>  {
> -	struct intel_qep *qep = counter->priv;
> +	struct intel_qep *qep = counter_priv(counter);
>  	u32 reg;
>  	bool enable;
>  	int ret = 0;
> @@ -326,7 +326,7 @@ static int intel_qep_preset_enable_read(struct counter_device *counter,
>  					struct counter_count *count,
>  					u8 *preset_enable)
>  {
> -	struct intel_qep *qep = counter->priv;
> +	struct intel_qep *qep = counter_priv(counter);
>  	u32 reg;
>  
>  	pm_runtime_get_sync(qep->dev);
> @@ -341,7 +341,7 @@ static int intel_qep_preset_enable_read(struct counter_device *counter,
>  static int intel_qep_preset_enable_write(struct counter_device *counter,
>  					 struct counter_count *count, u8 val)
>  {
> -	struct intel_qep *qep = counter->priv;
> +	struct intel_qep *qep = counter_priv(counter);
>  	u32 reg;
>  	int ret = 0;
>  

