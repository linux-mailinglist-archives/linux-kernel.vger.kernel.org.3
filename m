Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85159588006
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 18:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237824AbiHBQMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 12:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237769AbiHBQMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 12:12:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0385850052;
        Tue,  2 Aug 2022 09:10:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 307A2B81F3C;
        Tue,  2 Aug 2022 16:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A2EC433C1;
        Tue,  2 Aug 2022 16:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659456616;
        bh=Nkv50wjEjwjvKeT/CT9Bw+rEyYj4hlT2HtGPgfNDiLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ShiYKZZll/TUcf/6YOoavTXXFuv6UfUKJ2oZKkZDCc6SdXS05rIqn1MbTzJF2xR9b
         cWIArTjsMIBb4kDksZsEUYg+bg8b6TYq7LT5uaRQ0udeyISEXDWRY1Tr0dLMDctFxR
         rp7GUPOmwY7xN8bE/Zom87JjderUmY9BplnxM6D+8hy4FR5svQ5/EKqvvoOqcRAOqm
         Oifc5PLfGRdNqO0s7gBTIOEKIVRl4Ek4boSZuhMvfMINDI4mZLwP8rytd2LV9xrBWi
         XhqBzMg+8LWWV89V3HMUIZ0ZJ5+CPI/DjC3UqRXT8MeJg9Hl7mWS7DwqPD1D8cSdHe
         5ak6OA9XmTRcg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oIuTY-0002II-Dw; Tue, 02 Aug 2022 18:10:33 +0200
Date:   Tue, 2 Aug 2022 18:10:32 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: dwc3: qcom: Defer dwc3-qcom probe if dwc3 isn't
 probed properly
Message-ID: <YulMeEngNyoBOGBP@hovoldconsulting.com>
References: <1657891312-21748-1-git-send-email-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1657891312-21748-1-git-send-email-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 06:51:52PM +0530, Krishna Kurapati wrote:
> On SC7180 devices, it is observed that dwc3 probing is deferred
> because device_links_check_suppliers() finds that '88e3000.phy'
> isn't ready yet.
> 
> As a part of its probe call, dwc3-qcom driver checks if dwc3 core
> is wakeup capable or not. If the dwc3 core is wakeup capable, driver
> configures dwc-qcom's power domain to be always ON. Also it configures
> dp/dm interrupts accordingly to support wakeup from system suspend.
> 
> More info regarding the same can be found at:
> commit d9be8d5c5b03 ("usb: dwc3: qcom: Keep power domain on to retain controller status")
> commit 6895ea55c385 ("usb: dwc3: qcom: Configure wakeup interrupts during suspend")
> 
> In the event, dwc3 probe gets deferred and is processed after dwc3-qcom
> probe, driver ends up reading the wakeup capability of dwc3 core as false
> leading to instability in suspend/resume path.
> 
> To avoid this scenario, ensure dwc3_probe is successful by checking
> if appropriate driver is assigned to it or not after the of_platform_populate
> call. If it isn't then defer dwc3-qcom probe as well.
> 
> Fixes: 649f5c842ba3 ("usb: dwc3: core: Host wake up support from system suspend")
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
> v2: Set return value to EPROBE_DEFER to drop reference to dwc3 node
> 
>  drivers/usb/dwc3/dwc3-qcom.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 7703655..6676b39 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -722,6 +722,9 @@ static int dwc3_qcom_of_register_core(struct platform_device *pdev)
>  		dev_err(dev, "failed to get dwc3 platform device\n");
>  	}
>  
> +	if (!qcom->dwc3->dev.driver)
> +		ret = -EPROBE_DEFER;
> +
>  node_put:
>  	of_node_put(dwc3_np);

NAK.

We should not be adding hacks like this to the driver.

There are other ways to avoid this, but please take a look at the
following series which makes the problem identified by this patch go
away first:

	https://lore.kernel.org/all/20220802151404.1797-1-johan+linaro@kernel.org

Johan
