Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F784C4BD9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243539AbiBYRQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbiBYRQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:16:36 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245EE1BB707;
        Fri, 25 Feb 2022 09:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645809364; x=1677345364;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d82XZA2/evL6z4Q1q/SvLwPu9W9fK10IO/w6ZJFsHio=;
  b=q5QqyfiCcUGxSqgdQhp9juiHNWZBZpYn3t4pV6P5NgewX3iH5Pw9c8GU
   Fup2YTjU40hfJGS7PzIDx03SA0M0SuMivXf5Pc82YjuK7KDMJ1ttDie2U
   qDMXJILjrQSo0SZUQpM//xWWwxDYfL4iySjVwVPqq1pKVoDOM76DHsHc3
   o=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 25 Feb 2022 09:16:03 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 09:16:03 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 25 Feb 2022 09:16:03 -0800
Received: from jackp-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 25 Feb 2022 09:16:02 -0800
Date:   Fri, 25 Feb 2022 09:16:01 -0800
From:   Jack Pham <quic_jackp@quicinc.com>
To:     Peter Geis <pgwipeout@gmail.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bin Yang <yangbin@rock-chips.com>,
        "Heiko Stuebner" <heiko@sntech.de>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH v1 4/8] usb: dwc3: core: do not use 3.0 clock when
 operating in 2.0 mode
Message-ID: <20220225171601.GF13801@jackp-linux.qualcomm.com>
References: <20220225145432.422130-1-pgwipeout@gmail.com>
 <20220225145432.422130-5-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220225145432.422130-5-pgwipeout@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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

+Thinh

Hi Peter,

On Fri, Feb 25, 2022 at 09:54:27AM -0500, Peter Geis wrote:
> From: Bin Yang <yangbin@rock-chips.com>
> 
> In the 3.0 device core, if the core is programmed to operate in
> 2.0 only, then setting the GUCTL1.DEV_FORCE_20_CLK_FOR_30_CLK makes
> the internal 2.0(utmi/ulpi) clock to be routed as the 3.0 (pipe)
> clock. Enabling this feature allows the pipe3 clock to be not-running
> when forcibly operating in 2.0 device mode.
> 
> Signed-off-by: Bin Yang <yangbin@rock-chips.com>
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  drivers/usb/dwc3/core.c | 4 ++++
>  drivers/usb/dwc3/core.h | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 18adddfba3da..032d40794fae 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1167,6 +1167,10 @@ static int dwc3_core_init(struct dwc3 *dwc)
>  		if (dwc->parkmode_disable_ss_quirk)
>  			reg |= DWC3_GUCTL1_PARKMODE_DISABLE_SS;
>  
> +		if (dwc->maximum_speed == USB_SPEED_HIGH ||
> +		    dwc->maximum_speed == USB_SPEED_FULL)
> +			reg |= DWC3_GUCTL1_DEV_FORCE_20_CLK_FOR_30_CLK;
> +

I doubt this is applicable to all revisions of the DWC_usb3x IP cores?
For instance in the programming guide for DWC_usb31 1.90a bit 26 of
GUCTL1 is 'Reserved'.  While I do see it in the DWC_usb3 databook,
table 4-8 entry "Remove pipe_clk mux for 2.0 mode?" mentions this
feature was only added in v2.90a.

So this setting at least needs a revision check to make sure we're not
causing unexpected behavior.  Something like

	DWC3_VER_IS_WITHIN(DWC3, 290A, ANY)

Jack

>  		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
>  	}
>  
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index eb9c1efced05..ea3ca04406bb 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -259,6 +259,7 @@
>  /* Global User Control 1 Register */
>  #define DWC3_GUCTL1_DEV_DECOUPLE_L1L2_EVT	BIT(31)
>  #define DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS	BIT(28)
> +#define DWC3_GUCTL1_DEV_FORCE_20_CLK_FOR_30_CLK	BIT(26)
>  #define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW		BIT(24)
>  #define DWC3_GUCTL1_PARKMODE_DISABLE_SS		BIT(17)
>  
> -- 
> 2.25.1
> 
