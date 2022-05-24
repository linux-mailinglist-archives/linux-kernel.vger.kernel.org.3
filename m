Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7D3532BC6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 15:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237993AbiEXN5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 09:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiEXN5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 09:57:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4646187A01;
        Tue, 24 May 2022 06:57:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6667615FD;
        Tue, 24 May 2022 13:57:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E74FC385AA;
        Tue, 24 May 2022 13:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653400663;
        bh=7EPAVyGw4FJEo+Mq2KYGYXHGHQj1HBWBkXyw+Zrf6ZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WyjH87XhmyYaPHMnfIiS7A+kpm/hM+RKzsovZO1jOXTFgwzqkQJfzzoKfwYzm24v3
         IWek3evaJdi1j5RKfLE2taJsalyjewq7F5NjTwdgvMEmmjq1DpHHLRaX9enic9J87O
         MeD8p1t+4yREHV5oY/NqNx2caN6JMrv3yyxuz8dVw2oK691PPpGKGDXfWmvXiTqsx7
         xDce7Kldw7/3y6iZSVO3mFGXL48DSDQFSCu+2+02VFGVKGbXskCwJ5KhK1hTpVx4qh
         pHi6NMW+3bD0c4OgG55/A7b4mW210d/8SgTrcjsCKMkPoI9bE61UU8B9WZqp+nQTRT
         xFHmOG+AabMhQ==
Date:   Tue, 24 May 2022 19:27:35 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Sibi Sankar <quic_sibis@quicinc.com>, bjorn.andersson@linaro.org,
        jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        Prasad Sodagudi <quic_psodagud@quicinc.com>
Subject: Re: [PATCH v3] mailbox: qcom-ipcc: Log the pending interrupt during
 resume
Message-ID: <20220524135735.GD5745@thinkpad>
References: <1652784180-10142-1-git-send-email-quic_sibis@quicinc.com>
 <20220524134825.GA4188122@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220524134825.GA4188122@roeck-us.net>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 06:48:25AM -0700, Guenter Roeck wrote:
> On Tue, May 17, 2022 at 04:13:00PM +0530, Sibi Sankar wrote:
> > From: Prasad Sodagudi <quic_psodagud@quicinc.com>
> > 
> > Enable logging of the pending interrupt that triggered device wakeup. This
> > logging information helps to debug IRQs that cause periodic device wakeups
> > by printing the detailed information of pending IPCC interrupts.
> > 
> > Scenario: Device wakeup caused by Modem crash
> > Logs:
> > qcom-ipcc mailbox: virq: 182 triggered client-id: 2; signal-id: 2
> > 
> > >From the IPCC bindings it can further be understood that the client here is
> > IPCC_CLIENT_MPSS and the signal was IPCC_MPROC_SIGNAL_SMP2P.
> > 
> > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > Signed-off-by: Prasad Sodagudi <quic_psodagud@quicinc.com>
> > Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> > ---
> > 
> > V3:
> >  * Use pm_sleep_ptr and convert info to dbg [Mani]
> 
> Unfortunately, this results in
> 
> drivers/mailbox/qcom-ipcc.c:258:12: error: 'qcom_ipcc_pm_resume' defined but not used
> 
> on builds with PM disabled, as seen in next-20220524.
> 

Yep, I missed it during review :(

But the fix has been submitted:
https://patchwork.kernel.org/project/linux-arm-msm/patch/20220523224702.2002652-1-nathan@kernel.org/

Thanks,
Mani

> Guenter
> 
> >  * Fixup commit message
> > 
> > V2:
> >  * Fix build error when ipcc is a module [Kernel Test Bot]
> > 
> >  drivers/mailbox/qcom-ipcc.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> > 
> > diff --git a/drivers/mailbox/qcom-ipcc.c b/drivers/mailbox/qcom-ipcc.c
> > index c5d963222014..5a42bc2a1083 100644
> > --- a/drivers/mailbox/qcom-ipcc.c
> > +++ b/drivers/mailbox/qcom-ipcc.c
> > @@ -254,6 +254,24 @@ static int qcom_ipcc_setup_mbox(struct qcom_ipcc *ipcc,
> >  	return devm_mbox_controller_register(dev, mbox);
> >  }
> >  
> > +static int qcom_ipcc_pm_resume(struct device *dev)
> > +{
> > +	struct qcom_ipcc *ipcc = dev_get_drvdata(dev);
> > +	u32 hwirq;
> > +	int virq;
> > +
> > +	hwirq = readl(ipcc->base + IPCC_REG_RECV_ID);
> > +	if (hwirq == IPCC_NO_PENDING_IRQ)
> > +		return 0;
> > +
> > +	virq = irq_find_mapping(ipcc->irq_domain, hwirq);
> > +
> > +	dev_dbg(dev, "virq: %d triggered client-id: %ld; signal-id: %ld\n", virq,
> > +		FIELD_GET(IPCC_CLIENT_ID_MASK, hwirq), FIELD_GET(IPCC_SIGNAL_ID_MASK, hwirq));
> > +
> > +	return 0;
> > +}
> > +
> >  static int qcom_ipcc_probe(struct platform_device *pdev)
> >  {
> >  	struct qcom_ipcc *ipcc;
> > @@ -324,6 +342,10 @@ static const struct of_device_id qcom_ipcc_of_match[] = {
> >  };
> >  MODULE_DEVICE_TABLE(of, qcom_ipcc_of_match);
> >  
> > +static const struct dev_pm_ops qcom_ipcc_dev_pm_ops = {
> > +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(NULL, qcom_ipcc_pm_resume)
> > +};
> > +
> >  static struct platform_driver qcom_ipcc_driver = {
> >  	.probe = qcom_ipcc_probe,
> >  	.remove = qcom_ipcc_remove,
> > @@ -331,6 +353,7 @@ static struct platform_driver qcom_ipcc_driver = {
> >  		.name = "qcom-ipcc",
> >  		.of_match_table = qcom_ipcc_of_match,
> >  		.suppress_bind_attrs = true,
> > +		.pm = pm_sleep_ptr(&qcom_ipcc_dev_pm_ops),
> >  	},
> >  };
> >  
> > -- 
> > 2.7.4
> > 

-- 
மணிவண்ணன் சதாசிவம்
