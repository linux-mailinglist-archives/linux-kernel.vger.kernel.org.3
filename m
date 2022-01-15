Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30BED48F6F1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 14:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiAONAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 08:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiAONAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 08:00:52 -0500
Received: from balrog.mythic-beasts.com (balrog.mythic-beasts.com [IPv6:2a00:1098:0:82:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FCBC061574;
        Sat, 15 Jan 2022 05:00:52 -0800 (PST)
Received: from [81.101.6.87] (port=35384 helo=jic23-huawei)
        by balrog.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1n8ifi-000779-8I; Sat, 15 Jan 2022 13:00:46 +0000
Date:   Sat, 15 Jan 2022 13:06:26 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, sumit.semwal@linaro.org,
        amit.pundir@linaro.org, john.stultz@linaro.org
Subject: Re: [PATCH v3 1/7] mfd: qcom-spmi-pmic: expose the PMIC revid
 information to clients
Message-ID: <20220115130626.2c018335@jic23-huawei>
In-Reply-To: <53e76d68-3e47-f221-b5c4-5e29a958c5fc@linaro.org>
References: <20220106173131.3279580-1-caleb.connolly@linaro.org>
        <20220106173131.3279580-2-caleb.connolly@linaro.org>
        <20220109165743.7e01e226@jic23-huawei>
        <53e76d68-3e47-f221-b5c4-5e29a958c5fc@linaro.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 19
X-Spam-Status: No, score=1.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2022 11:46:39 +0000
Caleb Connolly <caleb.connolly@linaro.org> wrote:

> On 09/01/2022 16:57, Jonathan Cameron wrote:
> > On Thu,  6 Jan 2022 17:31:25 +0000
> > Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >   
> >> Some PMIC functions such as the RRADC need to be aware of the PMIC
> >> chip revision information to implement errata or otherwise adjust
> >> behaviour, export the PMIC information to enable this.
> >>
> >> This is specifically required to enable the RRADC to adjust
> >> coefficients based on which chip fab the PMIC was produced in,
> >> this can vary per unique device and therefore has to be read at
> >> runtime.
> >>
> >> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>  
> > Hi Caleb,
> > 
> > Some comments inline.  
> Hi Jonathan,
> 
> Thanks for the feedback, I had a question about one of your points below.

Miss read on my part.


> >>   
> >>   static const struct regmap_config spmi_regmap_config = {
> >> @@ -144,22 +122,38 @@ static const struct regmap_config spmi_regmap_config = {
> >>   static int pmic_spmi_probe(struct spmi_device *sdev)
> >>   {
> >>   	struct regmap *regmap;
> >> +	struct qcom_spmi_pmic *pmic;
> >>   
> >>   	regmap = devm_regmap_init_spmi_ext(sdev, &spmi_regmap_config);
> >>   	if (IS_ERR(regmap))
> >>   		return PTR_ERR(regmap);
> >>   
> >> +	pmic = devm_kzalloc(&sdev->dev, sizeof(*pmic), GFP_KERNEL);
> >> +	if (!pmic)
> >> +		return -ENOMEM;  
> > 
> > Within the code visible here, why can't this just be on the stack?  
> I allocated on the heap beacuse the data has to be read by other drivers 
> (it's handed over in spmi_device_set_drvdata() below). I don't have a 
> whole lot of C experience so please forgive the potentially ignorant 
> questions - is it ok to allocate on the stack if the object needs to 
> have a lifetime longer than the function?

You are of course correct. I just missed the set_drvdata call when reading this
and thought it was just being used for the print!  Oops.

