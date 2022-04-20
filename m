Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FECA508C4A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380304AbiDTPjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241579AbiDTPjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:39:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D487244A2E;
        Wed, 20 Apr 2022 08:37:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7038761935;
        Wed, 20 Apr 2022 15:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E28C385A1;
        Wed, 20 Apr 2022 15:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650469020;
        bh=JwmBf4+7OEAn/XREoeP03puiOCgIPDxxr8CYYqQk6K8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dZWoShivWdHJD6Gn5Dj+zmaHwZwr7inX3+MHcdZwqNo/+UkBxxyUe0qZbpSaz4j39
         FSYF33AHIlxdBppUKE0aDjTy2UbcrdSmsNr9ZaEf21Vm4UsVlVbJNUHGwxyyadBJ4I
         JNrD3s9lgpHEDWkH1XToesxcy7k9ZvgRj0ehb3PM=
Date:   Wed, 20 Apr 2022 17:36:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_kriskura@quicinc.com,
        quic_vpulyala@quicinc.com
Subject: Re: [PATCH v3 1/2] usb: host: xhci-plat: Add device property to set
 XHCI_SKIP_PHY_INIT quirk
Message-ID: <YmAomYeH181GGSZc@kroah.com>
References: <1649323888-12420-1-git-send-email-quic_c_sanm@quicinc.com>
 <1649323888-12420-2-git-send-email-quic_c_sanm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649323888-12420-2-git-send-email-quic_c_sanm@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 03:01:27PM +0530, Sandeep Maheswaram wrote:
> Add device property usb-skip-phy-init to check and set XHCI_SKIP_PHY_INIT
> quirk.
> Runtime suspend of phy drivers was failing from DWC3 driver as
> runtime usage value is 2 because the phy is initialized from
> DWC3 core and HCD core.
> Some controllers like DWC3 and CDNS3 manage phy in their core drivers.
> This property can be set to avoid phy initialization in HCD core.
> 
> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> ---
>  drivers/usb/host/xhci-plat.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 649ffd8..7624ed9 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -305,6 +305,9 @@ static int xhci_plat_probe(struct platform_device *pdev)
>  		if (device_property_read_bool(tmpdev, "quirk-broken-port-ped"))
>  			xhci->quirks |= XHCI_BROKEN_PORT_PED;
>  
> +		if (device_property_read_bool(tmpdev, "usb-skip-phy-init"))
> +			xhci->quirks |= XHCI_SKIP_PHY_INIT;

You forgot to document this new property.  Without that, we can not
accept this :(

