Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CD24DD996
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 13:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236167AbiCRMUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 08:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbiCRMUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 08:20:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2CB129246;
        Fri, 18 Mar 2022 05:18:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 656F6618BC;
        Fri, 18 Mar 2022 12:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3318EC340EC;
        Fri, 18 Mar 2022 12:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647605927;
        bh=MCYmkxRohmYW2gFo3QiCCs3mmKZej89CCiyoCTUDzI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TKD13QnhxbXoT3As8OndDUAxBHXacoXoSQ/rgbvOa3PVLUR0QwfLEnAs3UqLqwMDC
         3jQ8WyQSaVj+dhVNZIb707iSKzj6Z+lZNO5668fGLQW/bOFNvEbAxjrA9wrChWXs1h
         RjCnKBLxuB7h0h5rP/gjkR4fVEIO95oZMkjfNq90=
Date:   Fri, 18 Mar 2022 12:59:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Sandeep Maheswaram (Temp)" <quic_c_sanm@quicinc.com>
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
Subject: Re: [PATCH v2 0/3] Refactor xhci quirks and plat private data
Message-ID: <YjR0Ne3BDxxMfrxt@kroah.com>
References: <1646130507-26796-1-git-send-email-quic_c_sanm@quicinc.com>
 <ddc86a4f-8d1c-c02c-5600-4fa851568557@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddc86a4f-8d1c-c02c-5600-4fa851568557@quicinc.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 11:17:17AM +0530, Sandeep Maheswaram (Temp) wrote:
> Hi Greg,
> 
> On 3/1/2022 3:58 PM, Sandeep Maheswaram wrote:
> > changes in v2:
> > Added a PATCH 2/3 to remove unwanted header inclusion.
> > Fixed minor nitpicks in PATCH 3/3.
> > 
> > Pavankumar Kondeti (1):
> >    usb: xhci: refactor quirks and plat private data
> > 
> > Sandeep Maheswaram (2):
> >    usb: xhci: Remove unwanted header inclusion
> >    usb: dwc: host: add xhci_plat_priv quirk XHCI_SKIP_PHY_INIT
> > 
> >   drivers/usb/cdns3/host.c        |  2 +-
> >   drivers/usb/dwc3/host.c         | 13 ++++++++
> >   drivers/usb/host/xhci-plat.c    |  3 +-
> >   drivers/usb/host/xhci-plat.h    | 24 ---------------
> >   drivers/usb/host/xhci-rcar.c    |  3 +-
> >   drivers/usb/host/xhci.h         | 60 ++++--------------------------------
> >   include/linux/usb/xhci-plat.h   | 24 +++++++++++++++
> >   include/linux/usb/xhci-quirks.h | 67 +++++++++++++++++++++++++++++++++++++++++
> >   8 files changed, 115 insertions(+), 81 deletions(-)
> >   delete mode 100644 drivers/usb/host/xhci-plat.h
> >   create mode 100644 include/linux/usb/xhci-plat.h
> >   create mode 100644 include/linux/usb/xhci-quirks.h
> 
> Please let me know your opinion about this patch series.

I need the xhci maintainer to review it...

thanks,

greg k-h
