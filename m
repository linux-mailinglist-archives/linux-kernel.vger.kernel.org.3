Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F097458A2C3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 23:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbiHDVd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 17:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiHDVdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 17:33:23 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7A7248F5
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 14:33:22 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id j17so1007191pgl.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 14:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vYaDvUJ9r4UGTKuVjXopXRfBzot6ijDWJtz0uXFMHR0=;
        b=ePBy7JgHhVbC+RePbrVuQPX/dxKFpEjwEmLw2ZtraZ5KywxyBhQA/joyWGIVB6wHqr
         X077mRmwc3K8nu8o0V0kqlMTH+xBvNO6ILDnWa6JuME4DIE5iEL0gQDjURwpeICnbvyo
         QYEkiP5WupoXHL5SUPBs8+Ya+lgjEzDm+LoNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vYaDvUJ9r4UGTKuVjXopXRfBzot6ijDWJtz0uXFMHR0=;
        b=xX8TAGEbtI64qGYe8j1RHMpE0pc4u4Pdadq/iOdceOVO763zSUhUoCKRLuMzsQ/YFL
         k+xTfV7yKHoq34TZ6mVXXjeXvTDlSNwji7n7OZicbQisZccCdsApv476AKgAtWT1zJXA
         GDVFw/Huzv2WfC7stl698TBXzYfxU/MwXubidA0Lt4Wbp/x3zf7uWoqKxK2ib+zPPabj
         kEmei7G2oZSZyzwqGgKw3iCO13GqJI1DYUyc3G0lV76khtz7gyTDN/9o01x5s4gfLXgq
         XPlDtRJ+axv/VU4gW/dlReBN71bkyJxrLvZTv6XjCXIolaZuxVxNdtXNC+4wc2xCGGJl
         L4xw==
X-Gm-Message-State: ACgBeo2oaoKVfM0hlOANErP82rXci2mwUbks4Q4PumKyk0IHVy3ZEWDE
        NPxyQT0ghpEPhGuHuEBKzPhHFQ==
X-Google-Smtp-Source: AA6agR4McsMJc49mlH9ZdYiVvmgISwj1z95oxvo8/NlEocMn1wQgsswTty3yaXNEf8y/pXmasLLEfA==
X-Received: by 2002:a63:1245:0:b0:41a:29a3:aa31 with SMTP id 5-20020a631245000000b0041a29a3aa31mr2976612pgs.583.1659648801911;
        Thu, 04 Aug 2022 14:33:21 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:87c4:32ca:84b6:e942])
        by smtp.gmail.com with UTF8SMTPSA id h4-20020a170902f7c400b0016d5e4d29f8sm1474596plw.9.2022.08.04.14.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 14:33:21 -0700 (PDT)
Date:   Thu, 4 Aug 2022 14:33:19 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v5 3/3] PCI: qcom: Add retry logic for link to be stable
 in L1ss
Message-ID: <Yuw7HyoFX4jk6eOE@google.com>
References: <1659526134-22978-1-git-send-email-quic_krichai@quicinc.com>
 <1659526134-22978-4-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1659526134-22978-4-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 04:58:54PM +0530, Krishna chaitanya chundru wrote:
> Some specific devices are taking time to settle the link in L1ss.
> So added a retry logic before returning from the suspend op.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index f7dd5dc..f3201bd 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1829,15 +1829,30 @@ static int __maybe_unused qcom_pcie_pm_suspend(struct device *dev)
>  {
>  	struct qcom_pcie *pcie = dev_get_drvdata(dev);
>  	u32 val;
> +	ktime_t timeout, start;
>  
>  	if (!pcie->cfg->supports_system_suspend)
>  		return 0;
>  
> -	/* if the link is not in l1ss don't turn off clocks */
> -	val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
> -	if (!(val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
> -		dev_warn(dev, "Link is not in L1ss\n");
> -		return 0;
> +	start = ktime_get();
> +	/* Wait max 100 ms */
> +	timeout = ktime_add_ms(start, 100);

In my tests 100 ms is ample margin for most NVMe models (it's often 0 and
generally < 10), however with one model I saw delays of up to 150 ms, so
this should probably be 200 ms or so (it's a long time, but most of the
time the actual delay is significantly lower

> +	while (1) {
> +		bool timedout = ktime_after(ktime_get(), timeout);

'timedout' looks very similar to the other local variable 'timeout'
in this function. Actually why not just do without the new variable and
put this after reading the register.

   		if (ktime_after(ktime_get(), timeout)) {
			dev_warn(dev, "Link is not in L1ss\n");
 			return 0;
		}

> +
> +		/* if the link is not in l1ss don't turn off clocks */
> +		val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
> +		if ((val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
> +			dev_info(dev, "Link enters L1ss after %d ms\n",
> +					ktime_to_ms(ktime_get() - start));


Probably this should be dev_dbg() to avoid cluttering the kernel log that
isn't relevant most of the time.

> +			break;
> +		}
> +
> +		if (timedout) {
> +			dev_warn(dev, "Link is not in L1ss\n");
> +			return 0;
> +		}
> +		usleep_range(1000, 1200);

You could use fsleep() instead of specifying a range.

Based on my testing I think a slightly higher delay like 5ms wouldn't hurt.
That would result in less 'busy looping' for slower NVMes and would still
be reasonable fast for those that need 10 ms or so.

Actually you could replace the entire loop with something like this:

	if (readl_poll_timeout(pcie->parf + PCIE20_PARF_PM_STTS, val,
	    val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB, 5000, 200000) {
	    dev_warn(dev, "Link is not in L1ss\n");
	    return 0;
	}
