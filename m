Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5809508317
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376593AbiDTIEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376433AbiDTIEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:04:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57333C4B0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:01:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86DB8B81D71
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:01:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477A7C385A0;
        Wed, 20 Apr 2022 08:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650441707;
        bh=Ge7E9HICwWwQG131Jf3ckANSQzLOy8iKlQ7ubnvSwOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JeS89kslXNeoe/14aNyZVhJNwoHZm7zO/0Qe4YxeS5ihEUYcUZBsaCF4mp/zu44jS
         ndMvssJfmJ9NDK3dZYYBR2uHzoWQOOY3BQK2lHTPNY16I9OODhd0H9ueB77dYkYesM
         vH1SrAc4BF/gJE0NjoJuulld6oUXfnmCDexHnc2NyK/Np+2O7Mw9mmbFFW2vrTNqVL
         lgBKnwj46pTrvcJTRbGkt8VrN5Lkdr3a23ezVilfISqvfnZ0iVJG67QhRqXy7xw9Gj
         iwr2og4EHlQ1GjqAQ6g/AAGaaM3zjh/K4yaaUtp7jZvSHD1tkoBYWccyyH7JWBwy0I
         COxD2cbd1Qt4A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nh5HP-0006ca-HS; Wed, 20 Apr 2022 10:01:39 +0200
Date:   Wed, 20 Apr 2022 10:01:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     cgel.zte@gmail.com
Cc:     elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] greybus: using pm_runtime_resume_and_get to simplify the
 code
Message-ID: <Yl+948unOoDFdLe2@hovoldconsulting.com>
References: <20220420030658.2575942-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420030658.2575942-1-chi.minghao@zte.com.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 03:06:58AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>

Why are you sending patches from a random non-personal gmail address?

> Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
> pm_runtime_put_noidle. This change is just to simplify the code, no
> actual functional changes.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>

And why is this here?

> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/greybus/core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/greybus/core.c b/drivers/greybus/core.c
> index e546c6431877..434aa5d9dd47 100644
> --- a/drivers/greybus/core.c
> +++ b/drivers/greybus/core.c
> @@ -174,11 +174,9 @@ static int greybus_probe(struct device *dev)
>  	if (!id)
>  		return -ENODEV;
>  
> -	retval = pm_runtime_get_sync(&bundle->intf->dev);
> -	if (retval < 0) {
> -		pm_runtime_put_noidle(&bundle->intf->dev);
> +	retval = pm_runtime_resume_and_get(&bundle->intf->dev);
> +	if (retval < 0)
>  		return retval;
> -	}

NAK.

Greybus is using the pm_runtime_get_sync() consistently and mixing it up
with the new helper that uses a different naming scheme is just
confusing.

Use the new helper for your own code if you prefer, but there's really
no need to go around submitting this automatic conversions for code
that's already in the tree.

>  	retval = gb_control_bundle_activate(bundle->intf->control, bundle->id);
>  	if (retval) {

Johan
