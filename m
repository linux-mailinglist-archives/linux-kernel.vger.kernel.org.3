Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BE0563124
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbiGAKPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbiGAKPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:15:39 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA0C76942;
        Fri,  1 Jul 2022 03:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656670538; x=1688206538;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tjB+YWtXrkSRn425vyGQBHRy7XsCGQmbQOkFimaKvD8=;
  b=mGlH6Ehl4+p81Okw+KAPIJ8ISKWWOor6jcsuLgWeklkjkPq/S4mFaAR7
   zW7HxKB5YTd2mklPt2aAyW01+GOomRDxHWRnR4att7T+0rqTCKiKFdkye
   kVFOylkjldrDHyuhz+A0ya4u0RQMaipMPq/cfv8811uBEo4P+PKztL7fK
   8=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 01 Jul 2022 03:15:37 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 03:15:36 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 1 Jul 2022 03:15:36 -0700
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 1 Jul 2022 03:15:30 -0700
Date:   Fri, 1 Jul 2022 15:45:26 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Doug Anderson <dianders@chromium.org>,
        "Mathias Nyman" <mathias.nyman@intel.com>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_vpulyala@quicinc.com>
Subject: Re: [PATCH v20 2/5] usb: dwc3: core: Host wake up support from
 system suspend
Message-ID: <20220701101526.GA30468@hu-pkondeti-hyd.qualcomm.com>
References: <Yqd9IHQEj3Ex+FcF@google.com>
 <YqjLHyUVEjf7I3MI@google.com>
 <20220616091110.GA24114@hu-pkondeti-hyd.qualcomm.com>
 <YqtlRQOwb3t6Xtd0@google.com>
 <20220620085415.GA13744@hu-pkondeti-hyd.qualcomm.com>
 <CAE-0n52bq9feA6BVdAp791SWQtT1Yj4M2ppg3o_KOaRFO8r+0Q@mail.gmail.com>
 <20220628053148.GA21797@hu-pkondeti-hyd.qualcomm.com>
 <CAE-0n50PGw_XSZ0-iV7gem6+-LENoq6ZVOwX3f+0XjkrHg-rLw@mail.gmail.com>
 <c16a1c37-9183-8d0c-a5ad-39b897a0ab24@quicinc.com>
 <Yr5JmrSaus8xKpM9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yr5JmrSaus8xKpM9@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 06:10:50PM -0700, Matthias Kaehlcke wrote:
> > > dwc3-qcom should wait for dwc3 core to call component_add() and then do
> > > whatever needs to be done once the dwc3 core is registered in the
> > > dwc3-qcom bind callback. Honestly this may all be a little overkill if
> > > there's only two drivers here, dwc3-qcom and dwc3 core. It could
> > > probably just be some callback from dwc3 core at the end of probe that
> > > calls some function in dwc3-qcom.
> > Since the issue we are facing is that the ssphy device links are not ready
> > causing the dwc3 probe not being invoked, can we add an API as Pavan
> > suggested
> > to check if deferred_probe listfor dwc3 device is empty or not andbased on
> > that we can choose to defer our qcomprobe ? In this case, we don't need to
> > touch the dwc3 core driver and would be making changesonly in qcom glue
> > driver.
> 
> As mentioned above, it shouldn't be necessary to add component support to
> all the glue drivers. An API to check for deferred probing is an option,
> however there is a possible race condition: When the dwc3-qcom driver checks
> for a deferred probe the core could still be probing, in that situation the
> glue would proceed before the core driver is ready. That could be avoided
> with the component based approach.

The race can happen only if asynchronous probe is enabled, otherwise the
child's probe happens synchronously in of_platform_populate() 

OTOH, would the below condition suffice for our needs here? if our device
is not bounded to a driver, we check the state of initcalls and return
either error or -EPROBE_DEFER

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 7b6eff5..519a503 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -722,6 +722,9 @@ static int dwc3_qcom_of_register_core(struct platform_device *pdev)
 		dev_err(dev, "failed to get dwc3 platform device\n");
 	}
 
+	if (!qcom->dwc3->dev.driver)
+		return driver_deferred_probe_check_state(&qcom->dwc3->dev);
+
 node_put:
 	of_node_put(dwc3_np);
 
Thanks,
Pavan
