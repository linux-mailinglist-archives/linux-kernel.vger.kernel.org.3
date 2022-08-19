Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC385997C3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347636AbiHSIiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347522AbiHSIhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:37:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5D824963;
        Fri, 19 Aug 2022 01:36:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AE1761736;
        Fri, 19 Aug 2022 08:36:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19F9C433D6;
        Fri, 19 Aug 2022 08:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660898185;
        bh=37pTA/oFRMsALSTQ50ISevTazTRGybq+TCbIbtOvcrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BpZwiSe9p3y0Om5R2ul7ilZ5MrO+dprUGIxtu0Vv8WCkI0OMx0u6H+2rDRKNT+P6j
         L910bdZXZ07GoRnvrcvioW9J1ET9UO9Tcb36kg+ZkU4W441DV//8vNiCHL7N2MuC3N
         o7U11RVI9Fy+QtslZwguShifYWf4jlMXWXrcq+YA=
Date:   Fri, 19 Aug 2022 10:36:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrey Strachuk <strochuk@ispras.ru>
Cc:     Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH v2] usb: cdns3: change place of NULL check in
 cdns3_gadget_ep_enable()
Message-ID: <Yv9LhgZgDCdA0hG8@kroah.com>
References: <16589929667170@kroah.com>
 <20220728163014.247082-1-strochuk@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728163014.247082-1-strochuk@ispras.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 07:30:14PM +0300, Andrey Strachuk wrote:
> If 'ep' is NULL, result of ep_to_cdns3_ep(ep) is invalid and
> priv_ep->cdns3_dev causes panic.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Andrey Strachuk <strochuk@ispras.ru>
> Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
> ---
>  drivers/usb/cdns3/cdns3-gadget.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

No information on what changed from v1 to v2 :(

> 
> diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> index 5c15c48952a6..51de7457a3b8 100644
> --- a/drivers/usb/cdns3/cdns3-gadget.c
> +++ b/drivers/usb/cdns3/cdns3-gadget.c
> @@ -2284,11 +2284,14 @@ static int cdns3_gadget_ep_enable(struct usb_ep *ep,
>  	int ret = 0;
>  	int val;
>  
> +	if (!ep)
> +		return -EINVAL;

How can ep ever be NULL at all?  Why does this need to be checked?

thanks,

greg k-h
