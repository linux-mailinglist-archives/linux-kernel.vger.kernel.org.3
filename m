Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C856950D72B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 04:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240465AbiDYCwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 22:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiDYCwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 22:52:10 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33526E4CE;
        Sun, 24 Apr 2022 19:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650854948; x=1682390948;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lt7d0D8HFzqruaBD/gXwgUjsYO2oRO7TeES1RHdfgc0=;
  b=kkf39t2mBxYphBUJ2G2MP9CgxtT07WM3WX9JJp/FlZB+3HBV0cNbDaql
   5SXabtNZ+InVAps7wJavGLU3OL/0+t0NHmjzrIeW6ZptHNzrIVIpuaxnz
   5/Hz5VvUdemBgtfVGCJrPEFT2yJxAAmpJ/6K+I5rOfuL1bLa5vDI4qJyk
   U=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 24 Apr 2022 19:49:08 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2022 19:49:08 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 24 Apr 2022 19:49:07 -0700
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 24 Apr 2022 19:49:02 -0700
Date:   Mon, 25 Apr 2022 08:18:58 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "Doug Anderson" <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_kriskura@quicinc.com>, <quic_vpulyala@quicinc.com>
Subject: Re: [PATCH v4 0/3] Skip phy initialization for DWC3 USB Controllers
Message-ID: <20220425024858.GA7052@hu-pkondeti-hyd.qualcomm.com>
References: <1650517255-4871-1-git-send-email-quic_c_sanm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1650517255-4871-1-git-send-email-quic_c_sanm@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathias,

On Thu, Apr 21, 2022 at 10:30:52AM +0530, Sandeep Maheswaram wrote:
> Runtime suspend of phy drivers was failing from DWC3 driver as
> runtime usage value is 2 because the phy is initialized from
> DWC3 core and HCD core.
> Some controllers like DWC3 and CDNS3 manage phy in their core drivers.
> This property can be set to avoid phy initialization in HCD core.
> 
> v4:
> Added the device tree binding patch in the series.
> 
> v3:
> Coming back to this series based on discussion at below thread
> https://patchwork.kernel.org/project/linux-arm-msm/patch/1648103831-12347-4-git-send-email-quic_c_sanm@quicinc.com/
> Dropped the dt bindings PATCH 1/3 in v2
> https://patchwork.kernel.org/project/linux-arm-msm/cover/1636353710-25582-1-git-send-email-quic_c_sanm@quicinc.com/ 
> 
> v2:
> Updated the commit descriptions.
> Changed subject prefix from dwc to dwc3.
> Increased props array size.
> 
> 
> Sandeep Maheswaram (3):
>   dt-bindings: usb: usb-xhci: Add bindings for usb-skip-phy-init
>     property
>   usb: host: xhci-plat: Add device property to set XHCI_SKIP_PHY_INIT
>     quirk
>   usb: dwc3: host: Set the property usb-skip-phy-init
> 
>  Documentation/devicetree/bindings/usb/usb-xhci.yaml | 4 ++++
>  drivers/usb/dwc3/host.c                             | 4 +++-
>  drivers/usb/host/xhci-plat.c                        | 3 +++
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 

This is the latest series with bindings added as per Greg's comment. Can you
please pick up this series if you don't have any further comments.

Thanks,
Pavan
