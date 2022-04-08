Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D2A4F8C1B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbiDHCCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 22:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiDHCC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 22:02:29 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B641107EC;
        Thu,  7 Apr 2022 19:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649383227; x=1680919227;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yamq1b0OjqKJq3LDS97WN+kdcfPG+REHxMN6xzgAvZk=;
  b=Gmpf/THKr81FEnb6T13R3R/3kBdvOyvUeINH3sBti0K8yKNpD424Dvqs
   wmz9fDxSMezU73nP/ERrAVEHC735WK+gqcpiJtqr80dc0UdAJZtI+cVSC
   qlupdxe9UpI/d0zT2k4NDgwR0wB8g4UkUqCaSse1G7YftH6Azeapf3VNe
   I=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 07 Apr 2022 19:00:27 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 19:00:27 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 7 Apr 2022 19:00:26 -0700
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 7 Apr 2022 19:00:20 -0700
Date:   Fri, 8 Apr 2022 07:30:16 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_kriskura@quicinc.com>, <quic_vpulyala@quicinc.com>
Subject: Re: [PATCH v12 4/6] usb: dwc3: qcom: Keep power domain on to retain
 controller status
Message-ID: <20220408020016.GA26536@hu-pkondeti-hyd.qualcomm.com>
References: <1649321104-31322-1-git-send-email-quic_c_sanm@quicinc.com>
 <1649321104-31322-5-git-send-email-quic_c_sanm@quicinc.com>
 <Yk8nFZhLgdTQsllD@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yk8nFZhLgdTQsllD@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 11:01:57AM -0700, Matthias Kaehlcke wrote:
> On Thu, Apr 07, 2022 at 02:15:02PM +0530, Sandeep Maheswaram wrote:
> > Keep the power domain on in order to retain controller status and
> > to support wakeup from devices.
> > 
> > Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> > ---
> >  drivers/usb/dwc3/dwc3-qcom.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> > index 9804a19..35087cf 100644
> > --- a/drivers/usb/dwc3/dwc3-qcom.c
> > +++ b/drivers/usb/dwc3/dwc3-qcom.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/of_platform.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/phy/phy.h>
> > +#include <linux/pm_domain.h>
> >  #include <linux/usb/of.h>
> >  #include <linux/reset.h>
> >  #include <linux/iopoll.h>
> > @@ -724,6 +725,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
> >  	struct resource		*res, *parent_res = NULL;
> >  	int			ret, i;
> >  	bool			ignore_pipe_clk;
> > +	struct generic_pm_domain *genpd;
> >  
> >  	qcom = devm_kzalloc(&pdev->dev, sizeof(*qcom), GFP_KERNEL);
> >  	if (!qcom)
> > @@ -732,6 +734,8 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
> >  	platform_set_drvdata(pdev, qcom);
> >  	qcom->dev = &pdev->dev;
> >  
> > +	genpd = pd_to_genpd(qcom->dev->pm_domain);
> > +
> >  	if (has_acpi_companion(dev)) {
> >  		qcom->acpi_pdata = acpi_device_get_match_data(dev);
> >  		if (!qcom->acpi_pdata) {
> > @@ -839,6 +843,8 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		goto interconnect_exit;
> >  
> > +	genpd->flags |= GENPD_FLAG_ALWAYS_ON;
> 
> Not sure it really matters, but could this be done conditionally based
> on device_can_wakeup() of the dwc3 core device?

+1. Makes sense to me.

> 
> > +
> >  	device_init_wakeup(&pdev->dev, 1);
> 
> Now that the dwc3 core looks at the wakeup-source property it seems
> this driver should enable wakeup only when it is enabled for the
> core.
> 
> Actually I wonder if it would make sense to leave wakeup for dwc3-qcom
> 'officially' disabled, and just make all wakeup related decisions
> based on the wakeup configuration of the dwc3 core (as
> dwc3_qcom_en/disable_interrupts() already do). The separate wakeup
> policies for dwc3 core and dwc3-qcom are confusing and don't seem to
> add any value.

This suggestion makes sense. Do we foresee any issues by not marking
this parent device not wakeup capable? I don't see any.

Thanks,
Pavan
