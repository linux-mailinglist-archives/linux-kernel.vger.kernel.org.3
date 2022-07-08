Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B7C56B38B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237413AbiGHH0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237541AbiGHH0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:26:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB63B1837B;
        Fri,  8 Jul 2022 00:26:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85A4A62573;
        Fri,  8 Jul 2022 07:26:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C0BC341C0;
        Fri,  8 Jul 2022 07:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657265175;
        bh=QdvPGPSzMNSg9331rSs6uqhsyZcyL0jGteXXpQTEB54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eQpH3wwn/LMkE/zE1L6/QVSe2SW+7eP99yr6bduwIXYsXehxUIblhDiThhWU+HDob
         8HSMfy3fkaLzxj9YpXXGxnDFRb5rvabUFzB0Uh4X2Rq9OHFJb0e8/8ePL3t53pYk4n
         Vwnk/2vgWmp0/yVxfz/G6Z2tyf63Ad7nyYYWLZi8=
Date:   Fri, 8 Jul 2022 09:26:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: Re: [PATCH 1/5] usb: mtu3: fix coverity of string buffer
Message-ID: <YsfcFXtkDxe6ndFT@kroah.com>
References: <20220708071903.25752-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708071903.25752-1-chunfeng.yun@mediatek.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 03:18:59PM +0800, Chunfeng Yun wrote:
> Use snprintf instead of sprintf which could cause buffer overflow.

How can it cause an overflow?

> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/usb/mtu3/mtu3.h         | 4 +++-
>  drivers/usb/mtu3/mtu3_debugfs.c | 2 +-
>  drivers/usb/mtu3/mtu3_gadget.c  | 4 ++--
>  3 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
> index 8408e1b1a24a..9893dd1bafbb 100644
> --- a/drivers/usb/mtu3/mtu3.h
> +++ b/drivers/usb/mtu3/mtu3.h
> @@ -92,6 +92,8 @@ struct mtu3_request;
>  
>  #define BULK_CLKS_CNT	4
>  
> +#define MTU3_EP_NAME_LEN	12
> +
>  /* device operated link and speed got from DEVICE_CONF register */
>  enum mtu3_speed {
>  	MTU3_SPEED_INACTIVE = 0,
> @@ -272,7 +274,7 @@ struct ssusb_mtk {
>   */
>  struct mtu3_ep {
>  	struct usb_ep ep;
> -	char name[12];
> +	char name[MTU3_EP_NAME_LEN];
>  	struct mtu3 *mtu;
>  	u8 epnum;
>  	u8 type;
> diff --git a/drivers/usb/mtu3/mtu3_debugfs.c b/drivers/usb/mtu3/mtu3_debugfs.c
> index d27de647c86a..a6f72494b819 100644
> --- a/drivers/usb/mtu3/mtu3_debugfs.c
> +++ b/drivers/usb/mtu3/mtu3_debugfs.c
> @@ -132,7 +132,7 @@ static void mtu3_debugfs_regset(struct mtu3 *mtu, void __iomem *base,
>  	if (!mregs)
>  		return;
>  
> -	sprintf(mregs->name, "%s", name);
> +	snprintf(mregs->name, MTU3_DEBUGFS_NAME_LEN, "%s", name);

Where does name come from?  It looks like you control this string, so
there is no overflow anywhere.

>  	regset = &mregs->regset;
>  	regset->regs = regs;
>  	regset->nregs = nregs;
> diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
> index 30999b4debb8..a751e0533c2d 100644
> --- a/drivers/usb/mtu3/mtu3_gadget.c
> +++ b/drivers/usb/mtu3/mtu3_gadget.c
> @@ -635,8 +635,8 @@ static void init_hw_ep(struct mtu3 *mtu, struct mtu3_ep *mep,
>  
>  	INIT_LIST_HEAD(&mep->req_list);
>  
> -	sprintf(mep->name, "ep%d%s", epnum,
> -		!epnum ? "" : (is_in ? "in" : "out"));
> +	snprintf(mep->name, MTU3_EP_NAME_LEN, "ep%d%s", epnum,
> +		 !epnum ? "" : (is_in ? "in" : "out"));

Same here, you already control this string size, so where is the issue?

thanks,

greg k-h
