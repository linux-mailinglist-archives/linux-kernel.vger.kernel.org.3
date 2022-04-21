Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26766509CF1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387964AbiDUJ7N convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 21 Apr 2022 05:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358094AbiDUJ7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:59:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4743D21250
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 02:56:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nhTXh-0003ZT-V5; Thu, 21 Apr 2022 11:56:06 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nhTXf-004KoC-Qh; Thu, 21 Apr 2022 11:56:02 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nhTXd-0006Qn-Nd; Thu, 21 Apr 2022 11:56:01 +0200
Message-ID: <9b2b9460e46d8544867589ce61d380265f42cd04.camel@pengutronix.de>
Subject: Re: [PATCH V4] mmc: sdhci-msm: Reset GCC_SDCC_BCR register for SDHC
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     "Sajida Bhanu (Temp)" <quic_c_sbhanu@quicinc.com>,
        adrian.hunter@intel.com, agross@kernel.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        chris@printf.net, venkatg@codeaurora.org, gdjakov@mm-sol.com,
        quic_asutoshd@quicinc.com
Cc:     linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com
Date:   Thu, 21 Apr 2022 11:56:01 +0200
In-Reply-To: <fb6480f6-f004-c02d-09fe-92a64785a0c5@quicinc.com>
References: <1649759983-22035-1-git-send-email-quic_c_sbhanu@quicinc.com>
         <1ee3b0619ee976eaf88e7207318770d441418c94.camel@pengutronix.de>
         <1943a5fb-cf6c-f358-9e27-408792a458ce@quicinc.com>
         <dc2252f03db5881dbb17006c910dfca54c7d2fee.camel@pengutronix.de>
         <fb6480f6-f004-c02d-09fe-92a64785a0c5@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Do, 2022-04-21 at 10:32 +0530, Sajida Bhanu (Temp) wrote:
> Hi,
> 
> Thanks for the review.
> 
> Please find the inline comments.
> 
> Thanks,
> 
> Sajida
> 
> On 4/19/2022 12:52 PM, Philipp Zabel wrote:
> > Hi Sajida,
> > 
> > On Di, 2022-04-19 at 11:46 +0530, Sajida Bhanu (Temp) wrote:
> > [...]
> > > > > +static int sdhci_msm_gcc_reset(struct device *dev, struct sdhci_host *host)
> > > > > +{
> > > > > +	struct reset_control *reset;
> > > > > +	int ret = 0;
> > > > No need to initialize ret.
> > > > 
> > > > > +
> > > > > +	reset = reset_control_get_optional_exclusive(dev, NULL);
> > > > > +	if (IS_ERR(reset))
> > > > > +		return dev_err_probe(dev, PTR_ERR(reset),
> > > > > +				"unable to acquire core_reset\n");
> > > > > +
> > > > > +	if (!reset)
> > > > > +		return ret;
> > > Here we are returning ret directly if reset is NULL , so ret
> > > initialization is required.
> > You are right. I would just "return 0;" here, but this is correct as
> > is.
> Ok
> > > > > +
> > > > > +	ret = reset_control_assert(reset);
> > > > > +	if (ret)
> > > > > +		return dev_err_probe(dev, ret, "core_reset assert failed\n");
> > > > Missing reset_control_put(reset) in the error path.
> > > Sure will add
> > > > > +
> > > > > +	/*
> > > > > +	 * The hardware requirement for delay between assert/deassert
> > > > > +	 * is at least 3-4 sleep clock (32.7KHz) cycles, which comes to
> > > > > +	 * ~125us (4/32768). To be on the safe side add 200us delay.
> > > > > +	 */
> > > > > +	usleep_range(200, 210);
> > > > > +
> > > > > +	ret = reset_control_deassert(reset);
> > > > > +	if (ret)
> > > > > +		return dev_err_probe(dev, ret, "core_reset deassert failed\n");
> > > > Same as above. Maybe make both ret = dev_err_probe() and goto ...
> > > In both cases error message is different so I think goto not good idea here.
> > You could goto after the error message. Either way is fine.
> 
> Sorry didn't get this ..can  you please help

I meant you could either use goto after the error messages:

+static int sdhci_msm_gcc_reset(struct device *dev, struct sdhci_host *host)
+{
[...]
+	ret = reset_control_assert(reset);
+	if (ret) {
+		dev_err_probe(dev, ret, "core_reset assert failed\n");
+		goto out_reset_put;
+	}
[...]
+	ret = reset_control_deassert(reset);
+	if (ret) {
+		dev_err_probe(dev, ret, "core_reset deassert failed\n");
+		goto out_reset_put;
+	}
+
+	usleep_range(200, 210);
+
+out_reset_put:
+	reset_control_put(reset);
+
+	return ret;
+}

Or not use goto and copy the reset_control_put() into each error path:

+static int sdhci_msm_gcc_reset(struct device *dev, struct sdhci_host *host)
+{
[...]
+	ret = reset_control_assert(reset);
+	if (ret) {
+		reset_control_put(reset);
+		return dev_err_probe(dev, ret, "core_reset assert failed\n");
+	}
[...]
+	ret = reset_control_deassert(reset);
+	if (ret) {
+		reset_control_put(reset);
+		return dev_err_probe(dev, ret, "core_reset deassert failed\n");
+	}
+
+	usleep_range(200, 210);
+	reset_control_put(reset);
+
+	return 0;
+}

regards
Philipp
> 
