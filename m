Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C83480C64
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 19:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236941AbhL1SOa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Dec 2021 13:14:30 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55740 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbhL1SO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 13:14:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32EB2612B1;
        Tue, 28 Dec 2021 18:14:29 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id AD404C36AEC;
        Tue, 28 Dec 2021 18:14:24 +0000 (UTC)
Date:   Tue, 28 Dec 2021 18:20:09 +0000
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
Subject: Re: [PATCH v2 17/23] counter: intel-qep: Convert to new counter
 registration
Message-ID: <20211228182009.5e2841ab@jic23-huawei>
In-Reply-To: <20211227094526.698714-18-u.kleine-koenig@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
        <20211227094526.698714-18-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021 10:45:20 +0100
Uwe Kleine-König         <u.kleine-koenig@pengutronix.de> wrote:

> This fixes device lifetime issues where it was possible to free a live
> struct device.
> 
> Fixes: b711f687a1c1 ("counter: Add support for Intel Quadrature Encoder Peripheral")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
FWIW given these are all more or less the same...

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/counter/intel-qep.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
> index 8f84a48508ac..47a6a9dfc9e8 100644
> --- a/drivers/counter/intel-qep.c
> +++ b/drivers/counter/intel-qep.c
> @@ -63,7 +63,6 @@
>  #define INTEL_QEP_CLK_PERIOD_NS		10
>  
>  struct intel_qep {
> -	struct counter_device counter;
>  	struct mutex lock;
>  	struct device *dev;
>  	void __iomem *regs;
> @@ -392,14 +391,16 @@ static struct counter_count intel_qep_counter_count[] = {
>  
>  static int intel_qep_probe(struct pci_dev *pci, const struct pci_device_id *id)
>  {
> +	struct counter_device *counter;
>  	struct intel_qep *qep;
>  	struct device *dev = &pci->dev;
>  	void __iomem *regs;
>  	int ret;
>  
> -	qep = devm_kzalloc(dev, sizeof(*qep), GFP_KERNEL);
> -	if (!qep)
> +	counter = devm_counter_alloc(dev, sizeof(*qep));
> +	if (!counter)
>  		return -ENOMEM;
> +	qep = counter_priv(counter);
>  
>  	ret = pcim_enable_device(pci);
>  	if (ret)
> @@ -422,20 +423,23 @@ static int intel_qep_probe(struct pci_dev *pci, const struct pci_device_id *id)
>  	intel_qep_init(qep);
>  	pci_set_drvdata(pci, qep);
>  
> -	qep->counter.name = pci_name(pci);
> -	qep->counter.parent = dev;
> -	qep->counter.ops = &intel_qep_counter_ops;
> -	qep->counter.counts = intel_qep_counter_count;
> -	qep->counter.num_counts = ARRAY_SIZE(intel_qep_counter_count);
> -	qep->counter.signals = intel_qep_signals;
> -	qep->counter.num_signals = ARRAY_SIZE(intel_qep_signals);
> -	qep->counter.priv = qep;
> +	counter->name = pci_name(pci);
> +	counter->parent = dev;
> +	counter->ops = &intel_qep_counter_ops;
> +	counter->counts = intel_qep_counter_count;
> +	counter->num_counts = ARRAY_SIZE(intel_qep_counter_count);
> +	counter->signals = intel_qep_signals;
> +	counter->num_signals = ARRAY_SIZE(intel_qep_signals);
>  	qep->enabled = false;
>  
>  	pm_runtime_put(dev);
>  	pm_runtime_allow(dev);
>  
> -	return devm_counter_register(&pci->dev, &qep->counter);
> +	ret = devm_counter_add(&pci->dev, counter);
> +	if (ret < 0)
> +		return dev_err_probe(&pci->dev, ret, "Failed to add counter\n");
> +
> +	return 0;
>  }
>  
>  static void intel_qep_remove(struct pci_dev *pci)

