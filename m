Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1817495FE9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 14:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380725AbiAUNpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 08:45:42 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4437 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbiAUNpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 08:45:40 -0500
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JgLH45q46z67P7p;
        Fri, 21 Jan 2022 21:45:20 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Fri, 21 Jan 2022 14:45:37 +0100
Received: from localhost (10.47.75.29) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Fri, 21 Jan
 2022 13:45:36 +0000
Date:   Fri, 21 Jan 2022 13:45:31 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Caleb Connolly <caleb.connolly@linaro.org>
CC:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Lee Jones" <lee.jones@linaro.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <sumit.semwal@linaro.org>,
        <amit.pundir@linaro.org>, <john.stultz@linaro.org>
Subject: Re: [PATCH v3 3/7] iio: adc: qcom-spmi-rradc: introduce round robin
 adc
Message-ID: <20220121134531.00006a7b@Huawei.com>
In-Reply-To: <d0d42804-f437-e964-1c0d-4eb65e76db6c@linaro.org>
References: <20220106173131.3279580-1-caleb.connolly@linaro.org>
        <20220106173131.3279580-4-caleb.connolly@linaro.org>
        <20220109172948.76dbb1fa@jic23-huawei>
        <d0d42804-f437-e964-1c0d-4eb65e76db6c@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.75.29]
X-ClientProxiedBy: lhreml702-chm.china.huawei.com (10.201.108.51) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022 17:42:51 +0000
Caleb Connolly <caleb.connolly@linaro.org> wrote:

> On 09/01/2022 17:29, Jonathan Cameron wrote:
> > On Thu,  6 Jan 2022 17:31:27 +0000
> > Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >   
> >> The Round Robin ADC is responsible for reading data about the rate of
> >> charge from the USB or DC in jacks, it can also read the battery
> >> ID (resistence) and some temperatures. It is found on the PMI8998 and
> >> PM660 Qualcomm PMICs.
> >>
> >> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>  
> > Hi Calib,  
> Hi Jonathan,
> 
> I've spent some time on this and mostly reworked things, thanks a lot for
> your feedback, it's been quite interesting to learn about IIO. :)
> 
> Quite a few of the channels fit well into the (adc_code + offset) * scale format,
> however the one you commented on "rradc_post_process_chg_temp()" doesn't seem to
> fit, it requires multiple steps of applying offsets and scale and I haven't been
> able to re-arrange it to work sensibly.

I had a go below. Not trivial but may still be worth doing.  It seems to be linear
though the maths is a bit nasty!  This depends on that fab_coeff() returning
a constant value for a particular part which I haven't checked.

> 
> I noticed the calibbias properties which seems like something I should expose
> for "rradc_get_fab_coeff()"?
calibbias is usually an internal tweak factor that in hardware corrects for
inaccuracies - something like a DAC tweaking something in the analog front end.

Here it doesn't feel like it's useful to expose a software tweak to userspace
as it would have no idea what to do with it.

> 
> Could you point me in the right direction here? For reference my WIP tree can be
> found here: https://github.com/aospm/linux/commits/upstreaming/spmi-rradc
> 
> I also tried switching to labels, but I found that when I drop the extend_name
> property the driver fails to probe because multiple channels end up with the same
> name in sysfs (e.g. "in_temp_raw"). I've read through the docs and looked at a few
> other drivers but I wasn't able to find out what I'm missing for this to work.

Set channel and indexed for the channel. You should have in_temp0_raw, in_temp1_raw etc
Extend name was never meant to replace the index as it isn't visible in things
like event codes if you ever need to implement that stuff.  So they should all
have and unique index values anyway.

> 
> I've snipped to the relevant bits below.
> 
> Kind regards,
> Caleb
> > 
> > Various things inline but biggest is probably that in IIO we prefer
> > if possible to make application of offsets and scales a job for the caller,
> > either userspace or in kernel callers. This allows them to maintain precision
> > better if they need to further transform the data.
> > 
> > Jonathan
> >   
> >> ---
> >>   drivers/iio/adc/Kconfig           |   13 +
> >>   drivers/iio/adc/Makefile          |    1 +
> >>   drivers/iio/adc/qcom-spmi-rradc.c | 1070 +++++++++++++++++++++++++++++
> >>   3 files changed, 1084 insertions(+)
> >>   create mode 100644 drivers/iio/adc/qcom-spmi-rradc.c
> >>  
> 
> [snip]
> 
> >> +static int rradc_post_process_chg_temp(struct rradc_chip *chip, u16 adc_code,
> >> +				       int *result_millidegc)
> >> +{
> >> +	int64_t uv, offset, slope;
> >> +	int ret;
> >> +
> >> +	ret = rradc_get_fab_coeff(chip, &offset, &slope);
> >> +	if (ret < 0) {
> >> +		dev_err(chip->dev, "Unable to get fab id coefficients\n");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	uv = ((int64_t)adc_code * RR_ADC_TEMP_FS_VOLTAGE_NUM);
> >> +	uv = div64_s64(uv,
> >> +		       (RR_ADC_TEMP_FS_VOLTAGE_DEN * RR_ADC_CHAN_MAX_VALUE));
> >> +	uv = offset - uv;
> >> +	uv = div64_s64((uv * MILLI), slope);
> >> +	uv += RR_ADC_CHG_TEMP_OFFSET_MILLI_DEGC;
> >> +	*result_millidegc = (int)uv;  
> > 
> > Marginally harder than the one below, but this is still looking like it can
> > be well expressed as an offset + scale.  Thus making the tedious maths
> > userspaces or callers problem.  I'm working backwards hence won't comment on
> > similar before this point. Key is to transform whatever maths you have into
> > 
> > (adc_code + offset) * scale then expose offset and scale as well as the
> > raw value.  The right maths will get done for in kernel users and
> > userspace can do it nicely with floating point.

So I think this is: 

([fab_offset - (adc_code * FS_N )/ (FS_DEN * MAX_VAL)] * MILI / fab_slope + offset

Let A= FS_N/(FS_N * MAX_VAL)
    B = MILLI/fab_slope

= (fab_ofset - adc_code * A)*B + offset
= [((fab_offset / A - adc_code)*A + (offset / B)] * B
= [fab_offset/A - adc_code + offset / AB] * AB
= [adc_code - fab_offset/A - offset/AB]* -AB
= (a + offset) * scale)

where a is the adc_code,
offset = - fab_offset * FS_N * MAX_VAL/ FS_N - offset * FS_N * MAX_VAL * fab_slow / (MILLI  * FS_N)
scale = (FS_N * MILLI) / (FS_N * MAX_VAL * FAB_SLOPE)

So I think it can can done.  Quest then becomes whether sufficient precision can be
maintained for it to make sense to do the fixed point maths in the kernel to establish
those two coefficients and push it out to userspace as a constant that can then be
applied to the channel.

Note this assume that rradc_get_fab_coeff() returns a fixed value for a given device.

> >   
> >> +
> >> +	return 0;
> >> +}  
> 
> [snip]
> 
> >> +static const struct iio_chan_spec rradc_iio_chans[RR_ADC_CHAN_MAX] = {
> >> +	{
> >> +		.extend_name = "batt_id",  
> > 
> > We recently introduced channel labels to try and avoid the need for
> > extend_name.  The problem with extend_name is that generic software then
> > has trouble parsing the resulting sysfs files as they can have very
> > freeform naming.  Moving it to label makes that much easier.  Note that
> > there is code to give a default label of extend_name to work around
> > this problem for older drivers.
> >   
> >> +		.type = IIO_RESISTANCE,
> >> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> >> +		.address = RR_ADC_BATT_ID,
> >> +	},  
> 
> > 
> > Thanks,
> > 
> > Jonathan  
> 

