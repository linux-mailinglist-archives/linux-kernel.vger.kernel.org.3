Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68954D8D96
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 20:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244788AbiCNT7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 15:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244837AbiCNT6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 15:58:06 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947B71128;
        Mon, 14 Mar 2022 12:56:55 -0700 (PDT)
Received: from apollo.. (unknown [IPv6:2a02:810b:4340:43bf:4685:ff:fe12:5967])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2CA7622175;
        Mon, 14 Mar 2022 20:51:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1647287510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FsPSXYNf65u9lGXlMuwSK06aDtqt8nh3mUbWWnhzEfU=;
        b=Vn/QbwOwzy6e02taXzUWU1C0W6Pxpd5fmMSm9y7vOmRThcH6VGbwWjsDjImTzcvLJpuYfr
        RqUW6GJG/9lQhhYXKSQoqFnQ4n4gTVxm/t4K7gFh6Zpdumk0DjXpSW7DKTQ6rIQ/SM2Ydq
        iPX4EGdS0zuMnaZ/4BQE9/igYxusDGo=
From:   Michael Walle <michael@walle.cc>
To:     andriy.shevchenko@linux.intel.com
Cc:     djrscally@gmail.com, gregkh@linuxfoundation.org,
        heikki.krogerus@linux.intel.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        nuno.sa@analog.com, rafael@kernel.org,
        sakari.ailus@linux.intel.com, Russell King <linux@armlinux.org.uk>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v4 1/1] device property: Allow error pointer to be passed to fwnode APIs
Date:   Mon, 14 Mar 2022 20:51:37 +0100
Message-Id: <20220314195138.20036-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220308123712.18613-1-andriy.shevchenko@linux.intel.com>
References: <20220308123712.18613-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

> Some of the fwnode APIs might return an error pointer instead of NULL
> or valid fwnode handle. The result of such API call may be considered
> optional and hence the test for it is usually done in a form of
> 
> 	fwnode = fwnode_find_reference(...);
> 	if (IS_ERR(fwnode))
> 		...error handling...
> 
> Nevertheless the resulting fwnode may have bumped the reference count
> and hence caller of the above API is obliged to call fwnode_handle_put().
> Since fwnode may be not valid either as NULL or error pointer the check
> has to be performed there. This approach uglifies the code and adds
> a point of making a mistake, i.e. forgetting about error point case.
> 
> To prevent this, allow an error pointer to be passed to the fwnode APIs.
> 
> Fixes: 83b34afb6b79 ("device property: Introduce fwnode_find_reference()")
> Reported-by: Nuno Sá <nuno.sa@analog.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Nuno Sá <nuno.sa@analog.com>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Acked-by: Nuno Sá <nuno.sa@analog.com>

This breaks SFP/phylink (using the lan966x switch) on my board. See below
for more details.

[..]

> @@ -480,15 +485,16 @@ int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
>  {
>  	int ret;
>  
> +	if (IS_ERR_OR_NULL(fwnode))
> +		return -ENOENT;
> +
>  	ret = fwnode_call_int_op(fwnode, get_reference_args, prop, nargs_prop,
>  				 nargs, index, args);
> +	if (ret == 0)

Should this be "if (ret == 0 || IS_ERR_OR_NULL(fwnode->secondary))" ?

> +		return ret;
>  
> -	if (ret < 0 && !IS_ERR_OR_NULL(fwnode) &&
> -	    !IS_ERR_OR_NULL(fwnode->secondary))
> -		ret = fwnode_call_int_op(fwnode->secondary, get_reference_args,
> -					 prop, nargs_prop, nargs, index, args);
> -
> -	return ret;
> +	return fwnode_call_int_op(fwnode->secondary, get_reference_args, prop, nargs_prop,
> +				  nargs, index, args);
>  }
>  EXPORT_SYMBOL_GPL(fwnode_property_get_reference_args);

What happens before this patch is that sfp_bus_find_fwnode() will call
fwnode_property_get_reference_args() and the first calls return -ENOENT
which sfp_bus_find_fwnode() will handle in a special way. After your
patch, -EINVAL is returned, because fwnode_call_int_op() on
fwnode->secondary is always called regardless of the return value of
the original fwnode.

-michael
