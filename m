Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A904F6B58
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbiDFUZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234336AbiDFUWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:22:35 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E479B6;
        Wed,  6 Apr 2022 11:05:27 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 3AD0F22238;
        Wed,  6 Apr 2022 20:05:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1649268324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WdgHMqtZeDUd5XPK4vCIN6iJKSacplbl+ZaR8H3HTk0=;
        b=rsYbwnuW4AOU7D9+KaZMBH9acTHHKc0Om1r37bVxzrwHU/b4WROuV0asprVyHrhWd13H39
        s/K2X0e9remuuDCeMCmjkGKTZhu8/0dBT/755enE087oRelQ4PGQvsoApkb1wenEFdWQLn
        3RYthhiq0VmlxIaonky4wAfVHYkNjiE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 06 Apr 2022 20:05:23 +0200
From:   Michael Walle <michael@walle.cc>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Subject: Re: [PATCH v5 1/4] device property: Allow error pointer to be passed
 to fwnode APIs
In-Reply-To: <20220406130552.30930-1-andriy.shevchenko@linux.intel.com>
References: <20220406130552.30930-1-andriy.shevchenko@linux.intel.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <df3a78036864716fbeecf3cd94dbcbbe@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -480,15 +485,19 @@ int fwnode_property_get_reference_args(const
> struct fwnode_handle *fwnode,
>  {
>  	int ret;
> 
> +	if (IS_ERR_OR_NULL(fwnode))
> +		return -ENOENT;
> +
>  	ret = fwnode_call_int_op(fwnode, get_reference_args, prop, 
> nargs_prop,
>  				 nargs, index, args);
> +	if (ret == 0)
> +		return ret;
> 
> -	if (ret < 0 && !IS_ERR_OR_NULL(fwnode) &&
> -	    !IS_ERR_OR_NULL(fwnode->secondary))
> -		ret = fwnode_call_int_op(fwnode->secondary, get_reference_args,
> -					 prop, nargs_prop, nargs, index, args);
> +	if (IS_ERR_OR_NULL(fwnode->secondary))
> +		return -ENOENT;

Doesn't this mean you overwrite any return code != 0 with -ENOENT?
Is this intended?

In any case:
Tested-by: Michael Walle <michael@walle.cc>

-michael
