Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA464E3A30
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiCVIL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiCVILQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:11:16 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998249FD4;
        Tue, 22 Mar 2022 01:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647936588; x=1679472588;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2llnKuEBORghekHbMacPXqVHp+OZKNMd38Z8tDZ1r0s=;
  b=nx8YVAERfbWWkAZ1WqspbLWZwjaTR7TfoifRHjHXKa13BtS8HXufPiNu
   YG1pP8gJdMXxKfgiDJemIm1eU35UWiib2UtsmSC3LsJFt4CHRsbcSGzv8
   JScIomhbEwouN9X7xDmzoU+pT1EdMO9Nd1yPASVhvzh2DR6kLE6jRm0Ne
   A=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 22 Mar 2022 01:09:47 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 01:09:46 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 22 Mar 2022 01:09:46 -0700
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 22 Mar 2022 01:09:41 -0700
Date:   Tue, 22 Mar 2022 13:39:37 +0530
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
        <quic_ppratap@quicinc.com>, <quic_kriskura@quicinc.com>
Subject: Re: [PATCH v11 1/5] usb: dwc3: core: Add HS phy mode variable and
 phy poweroff flag
Message-ID: <20220322080937.GI23316@hu-pkondeti-hyd.qualcomm.com>
References: <1647932876-23249-1-git-send-email-quic_c_sanm@quicinc.com>
 <1647932876-23249-2-git-send-email-quic_c_sanm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1647932876-23249-2-git-send-email-quic_c_sanm@quicinc.com>
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

On Tue, Mar 22, 2022 at 12:37:52PM +0530, Sandeep Maheswaram wrote:
> Add variables in dwc3 structure to check HS phy mode which is
> used to configure interrupts and phy poweroff flag to check
> the phy status during system resume.
> 
> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> ---
>  drivers/usb/dwc3/core.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 5c9d467..f11a60c 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -1154,6 +1154,9 @@ struct dwc3 {
>  
>  	bool			phys_ready;
>  
> +	unsigned int            hs_phy_mode;
> +	bool			phy_power_off;
> +
>  	struct ulpi		*ulpi;
>  	bool			ulpi_ready;
>  
Why adding members in a separate patch? This needs to be squashed with
2/5 patch in the series where these members are used in taking host
mode PM decisions. Please fix this.

Thanks,
Pavan
