Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666B450E4AE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236401AbiDYPuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240505AbiDYPuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:50:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AED114817
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:47:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB72C611B2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 15:47:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD159C385A9;
        Mon, 25 Apr 2022 15:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650901659;
        bh=WdBpjD1yXyhDqEeK8iUgg7PB1JkPjFb/f8Rj8q1+YVA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GufuiX2xN4lpzB8yU5JWUuH6udR+3LpyuyBAxrtcJGeslF/K+R6tnD/rcP4uhYv+S
         qb91942DVN08p8ZOPuCmLeUO89IYRyTelLeG4q3p0Gfq8M5N8CwN2MISEMv7TZ8TYM
         xN1hzAsqXkG1QEl0vZs4t46N9n/+ZLW7Kox25LwA=
Date:   Mon, 25 Apr 2022 17:47:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ian Cowan <ian@linux.cowan.aero>
Cc:     Sven Van Asbroeck <TheSven73@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fieldbus: remove unnecessary double negation
Message-ID: <YmbClxXo5lwgHYxo@kroah.com>
References: <20220425145440.146891-1-ian@linux.cowan.aero>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425145440.146891-1-ian@linux.cowan.aero>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 10:54:40AM -0400, Ian Cowan wrote:
> Remove the double negation (!!) from the code since this does nothing
> and may create confusion on whether or not those values are negated.
> 
> Signed-off-by: Ian Cowan <ian@linux.cowan.aero>
> ---
>  drivers/staging/fieldbus/dev_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/fieldbus/dev_core.c b/drivers/staging/fieldbus/dev_core.c
> index 5aab734606ea..6766b2b13482 100644
> --- a/drivers/staging/fieldbus/dev_core.c
> +++ b/drivers/staging/fieldbus/dev_core.c
> @@ -28,7 +28,7 @@ static ssize_t online_show(struct device *dev, struct device_attribute *attr,
>  {
>  	struct fieldbus_dev *fb = dev_get_drvdata(dev);
>  
> -	return sprintf(buf, "%d\n", !!fb->online);
> +	return sprintf(buf, "%d\n", fb->online);
>  }
>  static DEVICE_ATTR_RO(online);
>  
> @@ -39,7 +39,7 @@ static ssize_t enabled_show(struct device *dev, struct device_attribute *attr,
>  
>  	if (!fb->enable_get)
>  		return -EINVAL;
> -	return sprintf(buf, "%d\n", !!fb->enable_get(fb));
> +	return sprintf(buf, "%d\n", fb->enable_get(fb));

This is a common pattern to turn any value into a boolean (0/1).  The
fact that this is a boolean to start with makes this change not affect
anything.  So you should say that in the changelog, the values are
obviously not negated.

thanks,

greg k-h
