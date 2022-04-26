Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A0750FA01
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343564AbiDZKUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348687AbiDZKSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:18:45 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B4214DE92;
        Tue, 26 Apr 2022 02:42:11 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A73BB5C006E;
        Tue, 26 Apr 2022 05:42:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 26 Apr 2022 05:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1650966130; x=1651052530; bh=ZXIFxQmM8x
        nC3dx69+7lQNWkGy08x70TLQHlCMHjAQo=; b=EKkTH73OKNUaepKXuBocm2gAex
        vK5DVg5upcYAUfHb2FHMVZ8Bhq4VLxeGFZGM0rDMfPMXo/sH51PbiewkvgHhHLPk
        lEpjxSB/wNdvW7s4kRvAv76+5bj1Qd1O1y3MoAp3ctRDhSvxegYcMIectk8eDYru
        N289LqzLMELjuSl74Qh5kcxmaSsil/jc9oSYzP29QZsYrTV5XyCK3VlBHj8NNrVv
        4SX1MaiLLE2jeHPJDZGxpMIwBNBq7PUV1AiMm1qaIyTDXl1GCq3HOAIA1HOp+8qD
        t03GZz50dANfPMnvpT9U9P+IAoEpOA+Jd6cPkPqn84H1MkFX9f/uevlq0mhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1650966130; x=
        1651052530; bh=ZXIFxQmM8xnC3dx69+7lQNWkGy08x70TLQHlCMHjAQo=; b=R
        Zi9/fXFQqx4jsAIJVC78UaJEJRpo4TQNJRufNCe476BQUHsHUC5w1ZOIM7qNd9X0
        zGt43tOPWVGMCncbJw2f4kij632qRo5+/l73FepTPp+TE9G5TyOMGWwGZhqXbhZi
        GwUw+7SRszYPyrWnOcBmv7e83dzTqIphTeD6QoAQh/eTEhWZ76hf3TANN7IXB5MB
        x6ljZb6EITyg6t0jB4Pag8LQemEwZO6gBTbzoseHFggcwbmCZQNnotJJUgaifv/C
        GdUcjPpaJj+wYJqxQKg9Z1Ftxqc3DMwUe96ZyK0K6L+mu3EFFhWNuZQxz+QcAVxf
        tLZrbUDS7U0I0UxTgjglg==
X-ME-Sender: <xms:cr5nYtDfIUS6p9gwkF7pZ-uecpgLMyIevtfd1-Dtz4l4pKtNNOuxWw>
    <xme:cr5nYrhHN21xFoN2DRFXTdupEqNT7RIyIaakv4DQHCpoL4NXHjXPT2yljlTcKC128
    OIIMvBBWJZUWg>
X-ME-Received: <xmr:cr5nYokx-c_hmQr3GnE3vG37vH3__3kU0fs3EM5JeHLYhgyS3ZKRYlRTiTsdZgoWC-uWi-B822bxEY7hla9NAcXUq_eMk2Ju>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefgdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvve
    dvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:cr5nYnyZyizuxEXmc0eL6pCM4dKBDVX5XYLBH2MTJuaMDebW0dfRpg>
    <xmx:cr5nYiSGvFo9kWhc_CW_JCBnH5HqEQoxfAsF0pN8hxATIon5O09-VA>
    <xmx:cr5nYqYR4GQS1UqITdg2eYwznp667hKG6bFuEs_j9zkUSjB1vqoTQQ>
    <xmx:cr5nYnLpoFuTKwYv1ZQbjaA2r8vN6lSOqLZ4SJL77U2dwNGjAlgEbg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Apr 2022 05:42:09 -0400 (EDT)
Date:   Tue, 26 Apr 2022 11:42:08 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the extcon tree with the usb tree
Message-ID: <Yme+cFpA19sWT2+g@kroah.com>
References: <20220426152739.62f6836e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426152739.62f6836e@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 03:27:39PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the extcon tree got a conflict in:
> 
>   drivers/usb/dwc3/drd.c
> 
> between commit:
> 
>   0f0101719138 ("usb: dwc3: Don't switch OTG -> peripheral if extcon is present")
> 
> from the usb tree and commit:
> 
>   88490c7f43c4 ("extcon: Fix extcon_get_extcon_dev() error handling")
> 
> from the extcon tree.
> 
> I fixed it up (the former moved the code modified by the latter, so I
> used the former version of this files and added the following merge fix
> patch) and can carry the fix as necessary. This is now fixed as far as
> linux-next is concerned, but any non trivial conflicts should be
> mentioned to your upstream maintainer when your tree is submitted for
> merging.  You may also want to consider cooperating with the maintainer
> of the conflicting tree to minimise any particularly complex conflicts.
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 26 Apr 2022 15:24:04 +1000
> Subject: [PATCH] fixup for "usb: dwc3: Don't switch OTG -> peripheral if extcon is present"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/usb/dwc3/core.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 2345a54b848b..950e238c65bf 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1649,13 +1649,8 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
>  	 * This device property is for kernel internal use only and
>  	 * is expected to be set by the glue code.
>  	 */
> -	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0) {
> -		edev = extcon_get_extcon_dev(name);
> -		if (!edev)
> -			return ERR_PTR(-EPROBE_DEFER);
> -
> -		return edev;
> -	}
> +	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0)
> +		return extcon_get_extcon_dev(name);
>  
>  	/*
>  	 * Try to get an extcon device from the USB PHY controller's "port"
> -- 
> 2.35.1
> 
> -- 
> Cheers,
> Stephen Rothwell



Resolution looks good to me, thanks!

greg k-h
