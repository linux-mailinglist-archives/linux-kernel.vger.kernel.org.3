Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E0A4E3AC2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbiCVIiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiCVIhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:37:51 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E25A6A425;
        Tue, 22 Mar 2022 01:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647938183; x=1679474183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MLCHjvjC7DXa1W6IGRIWN8bCkLHwxY4LHy2UaTCMmBM=;
  b=zp4KdkDbWQ9+do98AxpmRZZnjTUTtcez9rKT+17iUI1Ktm6TY7nxfFV+
   P8nt+NLMWmnfMA+KCe6V/n07ezgia03GzAJ/qtxiotY3DUYh5zYmZ4Q0U
   rUlDQjPWSBwEWmzxrRvAvq4y+O9bBroQhhoj8MrIoei7TrR6MvnpcreaV
   k=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 Mar 2022 01:36:23 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 01:36:22 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 22 Mar 2022 01:36:22 -0700
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 22 Mar 2022 01:36:18 -0700
Date:   Tue, 22 Mar 2022 14:06:14 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>
Subject: Re: [PATCH v11 4/5] usb: dwc3: qcom: Configure wakeup interrupts
 during suspend
Message-ID: <20220322083614.GL23316@hu-pkondeti-hyd.qualcomm.com>
References: <1647932876-23249-1-git-send-email-quic_c_sanm@quicinc.com>
 <1647932876-23249-5-git-send-email-quic_c_sanm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1647932876-23249-5-git-send-email-quic_c_sanm@quicinc.com>
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

Hi Sandeep,

On Tue, Mar 22, 2022 at 12:37:55PM +0530, Sandeep Maheswaram wrote:
> Configure interrupts based on hs_phy_mode to avoid triggering of
> interrupts during system suspend and suspend the device successfully.
> 
The changelog is not clear and confusing. Can you elaborate please?

> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 7352124..9804a19 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -316,22 +316,36 @@ static void dwc3_qcom_disable_wakeup_irq(int irq)
>  
>  static void dwc3_qcom_disable_interrupts(struct dwc3_qcom *qcom)
>  {
> -	dwc3_qcom_disable_wakeup_irq(qcom->hs_phy_irq);
> +	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
>  
> -	dwc3_qcom_disable_wakeup_irq(qcom->dp_hs_phy_irq);
> +	dwc3_qcom_disable_wakeup_irq(qcom->hs_phy_irq);
>  
> -	dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq);
> +	if (dwc->hs_phy_mode & PHY_MODE_USB_HOST_LS) {
> +		dwc3_qcom_disable_wakeup_irq(qcom->dp_hs_phy_irq);
> +	} else if (dwc->hs_phy_mode & PHY_MODE_USB_HOST_HS) {
> +		dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq);
> +	} else {
> +		dwc3_qcom_disable_wakeup_irq(qcom->dp_hs_phy_irq);
> +		dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq);
> +	}

Thanks,
Pavan
