Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3284A5249AE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352377AbiELKAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352360AbiELKAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:00:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB34422EA6C;
        Thu, 12 May 2022 03:00:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F33861B33;
        Thu, 12 May 2022 10:00:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01ACDC385B8;
        Thu, 12 May 2022 10:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652349605;
        bh=XNkP7Npy6pX2SH0Nmne+DFuBNntZymDAuAHHzHDASqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uBw3N+BQVKPFafHiToMwccjOEG8B4xX4S7ZNQDinoo333MoIRJX3B4lhP5jZmPhF6
         hH9oB849dsrAZEa/yMxOyWM89ax3591nfvqBSPgbGBykqWgj55RnXfxAWl5fN0TMAw
         +20Q9fWyVuaHpsYVciaNEvol54+gZ72sdgClnsO5WtyqjtEp/XjRzF36fnGpZPS6O5
         554n4LO/9VskxWOGV+h5PsnHMVnB+rTofJIZlX+Xl6+sEsOTN2aEbYvSeleUqSDo+5
         T9qVY+yChC2319/izZgEd8vNOBme3lAs9+FGRp5ODDc049nAmrP5X41sMZa19o2tEC
         DwYgndLv2Sdyw==
Date:   Thu, 12 May 2022 15:29:52 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     bjorn.andersson@linaro.org, jassisinghbrar@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, Prasad Sodagudi <quic_psodagud@quicinc.com>
Subject: Re: [PATCH v2] mailbox: qcom-ipcc: Log the pending interrupt during
 resume
Message-ID: <20220512095952.GB35848@thinkpad>
References: <1652251404-30562-1-git-send-email-quic_sibis@quicinc.com>
 <20220512074312.GA35848@thinkpad>
 <5b8aa653-5af8-a54f-b7bd-4d758eac9019@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b8aa653-5af8-a54f-b7bd-4d758eac9019@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 03:08:43PM +0530, Sibi Sankar wrote:
> Hey Mani,
> 
> Thanks for taking time to review the patch.
> 
> On 5/12/22 1:13 PM, Manivannan Sadhasivam wrote:
> > On Wed, May 11, 2022 at 12:13:24PM +0530, Sibi Sankar wrote:
> > > From: Prasad Sodagudi <quic_psodagud@quicinc.com>
> > > 
> > > Enable logging of the pending interrupt that triggered device wakeup. This
> > > logging information helps to debug IRQs that cause periodic device wakeups
> > > and prints the detailed information of pending IPCC interrupts instead of
> > > the generic "Resume caused by IRQ 17, ipcc".
> > > 
> > > Scenario: Device wakeup caused by Modem crash
> > > Logs:
> > > qcom-ipcc mailbox: virq: 182 triggered client-id: 2; signal-id: 2
> > > 
> > >  From the IPCC bindings it can further understood that the client here is
> > > IPCC_CLIENT_MPSS and the signal was IPCC_MPROC_SIGNAL_SMP2P.
> > > 
> > > Signed-off-by: Prasad Sodagudi <quic_psodagud@quicinc.com>
> > > Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> > > ---
> > > 
> > > V2:
> > >   * Fix build error when ipcc is a module [Kernel Test Bot]
> > > 
> > >   drivers/mailbox/qcom-ipcc.c | 27 +++++++++++++++++++++++++++
> > >   1 file changed, 27 insertions(+)
> > > 
> > > diff --git a/drivers/mailbox/qcom-ipcc.c b/drivers/mailbox/qcom-ipcc.c
> > > index c5d963222014..21c071ec119c 100644
> > > --- a/drivers/mailbox/qcom-ipcc.c
> > > +++ b/drivers/mailbox/qcom-ipcc.c
> > > @@ -254,6 +254,28 @@ static int qcom_ipcc_setup_mbox(struct qcom_ipcc *ipcc,
> > >   	return devm_mbox_controller_register(dev, mbox);
> > >   }
> > > +#ifdef CONFIG_PM_SLEEP
> > 
> > You don't need this guard anymore. Please see below.
> 
> ack
> 
> > 
> > > +static int qcom_ipcc_pm_resume(struct device *dev)
> > > +{
> > > +	struct qcom_ipcc *ipcc = dev_get_drvdata(dev);
> > > +	u32 hwirq;
> > > +	int virq;
> > > +
> > > +	hwirq = readl(ipcc->base + IPCC_REG_RECV_ID);
> > > +	if (hwirq == IPCC_NO_PENDING_IRQ)
> > > +		return 0;
> > > +
> > > +	virq = irq_find_mapping(ipcc->irq_domain, hwirq);
> > > +
> > > +	dev_info(dev, "virq: %d triggered client-id: %ld; signal-id: %ld\n", virq,
> > > +		 FIELD_GET(IPCC_CLIENT_ID_MASK, hwirq), FIELD_GET(IPCC_SIGNAL_ID_MASK, hwirq));
> > > +
> > 
> > Does this really need to be dev_info? This looks like a dev_dbg() material to
> > me.
> 
> The whole point of the log is to catch sporadic issues like random
> wakeups caused by remoteprocs through ipcc. We would just end up with
> a single line identifying the client id during resume if ipcc had indeed
> caused the wakeup else it wouldn't print anything.
> 

Right but that information is only required for debugging the periodic wakeups.
And that's not going to be useful for an end user.

Thanks,
Mani

> -Sibi
> > 
> > > +	return 0;
> > > +}
> > > +#else
> > > +#define qcom_ipcc_pm_resume NULL
> > > +#endif
> > > +
> > >   static int qcom_ipcc_probe(struct platform_device *pdev)
> > >   {
> > >   	struct qcom_ipcc *ipcc;
> > > @@ -324,6 +346,10 @@ static const struct of_device_id qcom_ipcc_of_match[] = {
> > >   };
> > >   MODULE_DEVICE_TABLE(of, qcom_ipcc_of_match);
> > > +static const struct dev_pm_ops qcom_ipcc_dev_pm_ops = {
> > > +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(NULL, qcom_ipcc_pm_resume)
> > > +};
> > > +
> > >   static struct platform_driver qcom_ipcc_driver = {
> > >   	.probe = qcom_ipcc_probe,
> > >   	.remove = qcom_ipcc_remove,
> > > @@ -331,6 +357,7 @@ static struct platform_driver qcom_ipcc_driver = {
> > >   		.name = "qcom-ipcc",
> > >   		.of_match_table = qcom_ipcc_of_match,
> > >   		.suppress_bind_attrs = true,
> > > +		.pm = &qcom_ipcc_dev_pm_ops,
> > 
> > You can use the new pm_sleep_ptr() macro to avoid the PM_SLEEP guard.
> > 
> > 		.pm = pm_sleep_ptr(&qcom_ipcc_dev_pm_ops),
> 
> ack
> 
> > 
> > Thanks,
> > Mani
> > 
> > >   	},
> > >   };
> > > -- 
> > > 2.7.4
> > > 
> > 

-- 
மணிவண்ணன் சதாசிவம்
