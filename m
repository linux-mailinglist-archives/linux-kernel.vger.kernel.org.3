Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22AA535C90
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350491AbiE0JEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 05:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350852AbiE0JAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:00:46 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D00D108AAD;
        Fri, 27 May 2022 01:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653641837; x=1685177837;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cz0az1bh7WDnZV2yku+ue+sCkR00jjhrmoI17Su6PQ4=;
  b=I6SA6TdD/TDx9TN8xWS73h69+5XWUTNWdGGDj2cBAnE9/qEDWFju6YFO
   ycrLYH2v+YpbwVZjoYe2nUt3he8PQXwQzyCkg3+TkHnoHJD/bYrfRFpRh
   1lSJTVOyQsPt1IcUuNsP2UGWqRlU3CmiFYQo9hXwthATjnAQ7aTKCoUDC
   M=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 27 May 2022 01:57:17 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 01:57:01 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 27 May 2022 01:56:40 -0700
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 27 May 2022 01:56:38 -0700
Date:   Fri, 27 May 2022 14:26:33 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Prashanth K <quic_prashk@quicinc.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: common: usb-conn-gpio: Allow wakeup from system
 suspend
Message-ID: <20220527085633.GB17518@hu-pkondeti-hyd.qualcomm.com>
References: <1653634146-12215-1-git-send-email-quic_prashk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1653634146-12215-1-git-send-email-quic_prashk@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

On Fri, May 27, 2022 at 12:19:06PM +0530, Prashanth K wrote:
> Currently the VBUS/ID detection interrupts are disabled during system
> suspend. So the USB cable connect/disconnect event can't wakeup the
> system from low power mode. To allow this, we keep these interrupts
> enabled and configure them as wakeup capable. This behavior can be
> controlled through device wakeup source policy by the user space.
> 
> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
> ---
>  drivers/usb/common/usb-conn-gpio.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
> index 395f9bb..b39c9f1c 100644
> --- a/drivers/usb/common/usb-conn-gpio.c
> +++ b/drivers/usb/common/usb-conn-gpio.c
> @@ -257,6 +257,7 @@ static int usb_conn_probe(struct platform_device *pdev)
>  	}
>  
>  	platform_set_drvdata(pdev, info);
> +	device_set_wakeup_capable(&pdev->dev, true);
>  
>  	/* Perform initial detection */
>  	usb_conn_queue_dwork(info, 0);
> @@ -286,6 +287,14 @@ static int __maybe_unused usb_conn_suspend(struct device *dev)
>  {
>  	struct usb_conn_info *info = dev_get_drvdata(dev);
>  
> +	if (device_may_wakeup(dev)) {
> +		if (info->id_gpiod)
> +			enable_irq_wake(info->id_irq);
> +		if (info->vbus_gpiod)
> +			enable_irq_wake(info->vbus_irq);
> +		return 0;
> +	}
> +
>  	if (info->id_gpiod)
>  		disable_irq(info->id_irq);
>  	if (info->vbus_gpiod)
> @@ -300,6 +309,14 @@ static int __maybe_unused usb_conn_resume(struct device *dev)
>  {
>  	struct usb_conn_info *info = dev_get_drvdata(dev);
>  
> +	if (device_may_wakeup(dev)) {
> +		if (info->id_gpiod)
> +			disable_irq_wake(info->id_irq);
> +		if (info->vbus_gpiod)
> +			disable_irq_wake(info->vbus_irq);
> +		return 0;
> +	}
> +
>  	pinctrl_pm_select_default_state(dev);
>  
>  	if (info->id_gpiod)

Looks good to me.

Thanks,
Pavan
