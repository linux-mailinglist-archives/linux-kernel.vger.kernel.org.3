Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEE94DD9A0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 13:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbiCRMUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 08:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236198AbiCRMUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 08:20:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C91B2E1A9D;
        Fri, 18 Mar 2022 05:18:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFD356188D;
        Fri, 18 Mar 2022 12:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E54C340E8;
        Fri, 18 Mar 2022 12:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647605935;
        bh=C1Hrt3y8LhUH20tkjH6OEVg2ScebEqMD1BqUmzUmnfs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IR8aeS46dgm+RNzCB4GB4aOxjyKN/hBVsugUOXs81ZPxHyExHBGhhv9MwUP4X0YAz
         feQM8Mm4eWFCGpjeo8cYIK0K60r/WJvkY2xQgLjWjnz0pbBPvULsi3HlrbP4CcK7UI
         zuUGpMqmhe2WRuZ4nWeoMhemiyrWXnup+ncMUwVE=
Date:   Fri, 18 Mar 2022 13:01:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Pawel Laszczak <pawell@cadence.com>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com
Subject: Re: [PATCH v2 2/3] usb: xhci: Remove unwanted header inclusion
Message-ID: <YjR0gNPdeI5FTBGs@kroah.com>
References: <1646130507-26796-1-git-send-email-quic_c_sanm@quicinc.com>
 <1646130507-26796-3-git-send-email-quic_c_sanm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646130507-26796-3-git-send-email-quic_c_sanm@quicinc.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 03:58:26PM +0530, Sandeep Maheswaram wrote:
> Remove the header file and forward declare struct usb_hcd.

Why?

> 
> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> ---
>  include/linux/usb/xhci-plat.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/usb/xhci-plat.h b/include/linux/usb/xhci-plat.h
> index 906e907..576e400 100644
> --- a/include/linux/usb/xhci-plat.h
> +++ b/include/linux/usb/xhci-plat.h
> @@ -9,7 +9,8 @@
>  #define _XHCI_PLAT_H
>  
>  #include <linux/types.h>
> -#include <linux/usb/hcd.h>
> +
> +struct usb_hcd;
>  
>  struct xhci_plat_priv {
>  	const char *firmware_name;
> -- 
> 2.7.4
> 

Where did this come from?  Is this fixing a build breakage from a
previous patch?  If not, why is this needed?

confused,

greg k-h
