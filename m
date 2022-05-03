Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67AA25186D5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 16:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237142AbiECOk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 10:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237127AbiECOkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 10:40:25 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596252AE32;
        Tue,  3 May 2022 07:36:53 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id E17A5320094C;
        Tue,  3 May 2022 10:36:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 03 May 2022 10:36:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1651588611; x=1651675011; bh=wr1yEbLhma
        vCHn4YSc6slYBn0rcn1MuXeUqJmQnuax0=; b=RslftU20R/juV/ALfzf3oGCJSZ
        QESr632f4o07zZh+Pbth4vcSXsmv7+9SUYRTg/CeSFhFXYU125KB72Igwi4ZYsK6
        8oslyn6TUrsAekDjk1Az0gV9JFkpiC+qJ6W4PhJpFSQXXl+V36te5vVLiqDz8tkM
        fW8yznmVaTyNeK8fxOHJ85upJ2KdKl2J0idxWaSmcDYvbx95ah6RbOrSPuOqZmp1
        J4a8nKuiq1I0Dsarf5thOxjxGIMFjbX+UyPuOsvVra1p9Bj4fcgNXBLDg4PwfADH
        ieJKBOlC4tINlTGJ+0nUmi0U0Yix9Khs0CjSoxRXWfcI5OGmLZfDPamlWxvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1651588611; x=
        1651675011; bh=wr1yEbLhmavCHn4YSc6slYBn0rcn1MuXeUqJmQnuax0=; b=t
        87Uz7VKSJFjqm0z5f8OEV36+lst3ZW9L5d+5mwYsceXRLDi2YtvxZe24eFxeA+M0
        KXM0V+ydauwI4srYW9GBTauMap5+5Y7SLFbioVVgIvk1UdS3YVHPM1/BwmuYltMd
        Jsg04Mq6vgEc8fmwo+9I01sr4CBqPppO/jTaNiuS3NTwjr17n1OoQVWawkb1fMu8
        A4CipH60iWcEGzr6TSh/tniLqNpUYsooPH6VW/ftKsFCkDio0XL9KKf1+3q4RgyO
        gvvWNso4EZ3QFOeIEDTxsIr/TG8T2ZpTz9E0T/WzQtwGVWw+Y1HrVo74vfeJPCQ9
        UfNBEh+Av7Eggl5MsVtrg==
X-ME-Sender: <xms:Aj5xYpUQUiJc5hXGBP1Y6de-XjaDkx61sK89iioPad0JpcPmv56cAA>
    <xme:Aj5xYpkJKR_5WbUY1vs5FfzXdyxAF31_CM-B-s_2vWskVReWo3PyXlbi-3tEZ2Mrk
    QZ4XiuVC9IrYQ>
X-ME-Received: <xmr:Aj5xYlbkhKHgfW9rtdS-Bw7V9AaOevoe4Ew19j_Zo2GGwejKkRvi_JUYMayX2JguJR4fHKfKW4B1OJTdtajo3khXo4RR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejgdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvve
    dvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:Aj5xYsXo5YJ8VJIwfy6Z_tnaSukvBZmzIoG2veha1Lh7B1b4d-mUag>
    <xmx:Aj5xYjne5PLYxCzoEooJh2NZ9-sHTye5bZaL96dwRpJjbw2cKpYuqA>
    <xmx:Aj5xYpdwjNas8iWccbS90AF343uwPghE1jsZXp-aGWetDc61tdaVQA>
    <xmx:Az5xYl6OLfuPgOm26kLGvmwnb7GTtsfsirZWnYMYpdb00Mv6tCashg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 May 2022 10:36:50 -0400 (EDT)
Date:   Tue, 3 May 2022 16:36:48 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sven Peter <sven@svenpeter.dev>
Subject: Re: linux-next: manual merge of the usb tree with the usb.current
 tree
Message-ID: <YnE+ABsiKpUFbZUo@kroah.com>
References: <20220426150842.473be40e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426150842.473be40e@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 03:08:42PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the usb tree got a conflict in:
> 
>   drivers/usb/dwc3/drd.c
> 
> between commit:
> 
>   ab7aa2866d29 ("usb: dwc3: Try usb-role-switch first in dwc3_drd_init")
> 
> from the usb.current tree and commit:
> 
>   0f0101719138 ("usb: dwc3: Don't switch OTG -> peripheral if extcon is present")
> 
> from the usb tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc drivers/usb/dwc3/drd.c
> index 8cad9e7d3368,f277bebdaa09..000000000000
> --- a/drivers/usb/dwc3/drd.c
> +++ b/drivers/usb/dwc3/drd.c
> @@@ -585,14 -539,11 +539,10 @@@ int dwc3_drd_init(struct dwc3 *dwc
>   	int ret, irq;
>   
>   	if (ROLE_SWITCH &&
>  -	    device_property_read_bool(dwc->dev, "usb-role-switch")) {
>  -		ret = dwc3_setup_role_switch(dwc);
>  -		if (ret < 0)
>  -			return ret;
>  -	} else if (dwc->edev) {
>  +	    device_property_read_bool(dwc->dev, "usb-role-switch"))
>  +		return dwc3_setup_role_switch(dwc);
>  +
> - 	dwc->edev = dwc3_get_extcon(dwc);
> - 	if (IS_ERR(dwc->edev))
> - 		return PTR_ERR(dwc->edev);
> - 
>  +	if (dwc->edev) {
>   		dwc->edev_nb.notifier_call = dwc3_drd_notifier;
>   		ret = extcon_register_notifier(dwc->edev, EXTCON_USB_HOST,
>   					       &dwc->edev_nb);

This should now be resolved in my tree, thanks!

greg k-h
