Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDEF35612C3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 08:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbiF3GyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 02:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiF3GyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 02:54:11 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DBD20BF5;
        Wed, 29 Jun 2022 23:54:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7049ECE2A65;
        Thu, 30 Jun 2022 06:54:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5F2C34115;
        Thu, 30 Jun 2022 06:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656572047;
        bh=AoZZBIOZ6lxp4R1mhcbQkpMM8z6raWKSubTBxc3uKjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JdCXLXAFdIVNttvrE3zYW5gc495EVxTjSxKY3PzJbtg3xdpmjqtTQH9IioyspcVZZ
         +Ur+l2PNgwu/YRulMcltk2W2KqOP8/zvvDM3bif4NooRhihc2IzocSGAbvFKOjjE/9
         pqK9K2B7S2w/DbcFADGiZMhG1fjVZEzAxxzOlhdE=
Date:   Thu, 30 Jun 2022 08:54:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebin Sebastian <mailmesebin00@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Neal Liu <neal_liu@aspeedtech.com>,
        Felipe Balbi <balbi@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] usb: gadget: dereference before null check
Message-ID: <Yr1IjFBe6JjrDq8n@kroah.com>
References: <20220630044706.10772-1-mailmesebin00@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630044706.10772-1-mailmesebin00@gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 10:17:06AM +0530, Sebin Sebastian wrote:
> Fix coverity warning dereferencing before null check. _ep and desc is
> dereferenced on all paths until the check for null. Move the
> initializations after the check for null.

How can those values ever be NULL?

> Coverity issue: 1518209
> 
> Reported-by: kernel test robot <lkp@intel.com>

kernel test robot did not find this issue.

> Signed-off-by: Sebin Sebastian <mailmesebin00@gmail.com>

What commit id does this change fix?

> ---
>  Changes since v1: Fix the build errors and warnings due to first patch.
>  Fix the undeclared 'ep' and 'maxpacket' error. Fix the ISO C90 warning.
> 
>  drivers/usb/gadget/udc/aspeed_udc.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
> index d75a4e070bf7..a43cf8dde2a8 100644
> --- a/drivers/usb/gadget/udc/aspeed_udc.c
> +++ b/drivers/usb/gadget/udc/aspeed_udc.c
> @@ -341,26 +341,33 @@ static void ast_udc_stop_activity(struct ast_udc_dev *udc)
>  static int ast_udc_ep_enable(struct usb_ep *_ep,
>  			     const struct usb_endpoint_descriptor *desc)
>  {
> -	u16 maxpacket = usb_endpoint_maxp(desc);
> -	struct ast_udc_ep *ep = to_ast_ep(_ep);

checking that ep is NULL here is an impossible thing on its own.  You
did change this so that you didn't check this anymore, which is odd as
you did not mention that in the changelog text :(

> -	struct ast_udc_dev *udc = ep->udc;
> -	u8 epnum = usb_endpoint_num(desc);
>  	unsigned long flags;
>  	u32 ep_conf = 0;
>  	u8 dir_in;
>  	u8 type;
> +	u16 maxpacket;
> +	struct ast_udc_ep *ep;
> +	struct ast_udc_dev *udc;
> +	u8 epnum;

Why did you reorder these?

>  
> -	if (!_ep || !ep || !desc || desc->bDescriptorType != USB_DT_ENDPOINT ||
> -	    maxpacket == 0 || maxpacket > ep->ep.maxpacket) {
> +	if (!_ep || !desc || desc->bDescriptorType != USB_DT_ENDPOINT) {
>  		EP_DBG(ep, "Failed, invalid EP enable param\n");
>  		return -EINVAL;
>  	}
> -

Why did you remove this line?

Also, your To: line is messed up somehow, please fix your email
client...

thanks,

gre gk-h
