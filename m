Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335434FB352
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 07:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244782AbiDKFro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 01:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236240AbiDKFrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 01:47:36 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4249CAE51;
        Sun, 10 Apr 2022 22:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649655923; x=1681191923;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bdbH2FaVrBqCdnW9LxmRejKeF5dA7ZPqvPUJPAhh18w=;
  b=U2puirQwe7wze31noIcWiFYpGb3u2Ism/5jeGSs9J7DO2axsBlgoeLbF
   +GIvZrKxkkO8Tw3F/H3nozO+VgpOwrR+yCCBqLgDemLWAUheGY+2DgHfs
   CMuOi1NEtXq6KJiGfMjl9REVXr9bkAlMKoPBUaz/2B1CRypvZQjguC8oF
   4=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 10 Apr 2022 22:45:22 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 22:45:22 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 10 Apr 2022 22:45:21 -0700
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 10 Apr 2022 22:45:16 -0700
Date:   Mon, 11 Apr 2022 11:15:12 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>
CC:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_kriskura@quicinc.com>, <quic_vpulyala@quicinc.com>
Subject: Re: [PATCH v12 1/6] usb: dwc3: core: Host wake up support from
 system suspend
Message-ID: <20220411054512.GA19703@hu-pkondeti-hyd.qualcomm.com>
References: <1649321104-31322-1-git-send-email-quic_c_sanm@quicinc.com>
 <1649321104-31322-2-git-send-email-quic_c_sanm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1649321104-31322-2-git-send-email-quic_c_sanm@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 02:14:59PM +0530, Sandeep Maheswaram wrote:
> During suspend read the status of all port and set hs phy mode
> based on current speed. Use this hs phy mode to configure wakeup
> interrupts in qcom glue driver.
> 
> Also check during suspend if any wakeup capable devices are
> connected to the controller (directly or through hubs), if there
> are none set a flag to indicate that the PHY is powered
> down during suspend.
> 
> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> ---
>  drivers/usb/dwc3/core.c | 29 ++++++++++++++++++++---------
>  drivers/usb/dwc3/core.h |  4 ++++
>  drivers/usb/dwc3/host.c | 25 +++++++++++++++++++++++++
>  3 files changed, 49 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 1170b80..b102a22 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -32,6 +32,7 @@
>  #include <linux/usb/gadget.h>
>  #include <linux/usb/of.h>
>  #include <linux/usb/otg.h>
> +#include <linux/usb/hcd.h>
>  
>  #include "core.h"
>  #include "gadget.h"
> @@ -1723,6 +1724,7 @@ static int dwc3_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, dwc);
>  	dwc3_cache_hwparams(dwc);
> +	device_init_wakeup(&pdev->dev, of_property_read_bool(dev->of_node, "wakeup-source"));

The current code calls device_init_wakeup(true) in runtime suspend and calls
device_init_wakeup(false) in runtime resume. We don't want that right now
given that we have a this new dT property. can you fix this please?

Thanks,
Pavan
