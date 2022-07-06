Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D13568E74
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 17:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiGFP47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 11:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiGFP46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 11:56:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6FC2F4;
        Wed,  6 Jul 2022 08:56:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA325B81DA8;
        Wed,  6 Jul 2022 15:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2897BC3411C;
        Wed,  6 Jul 2022 15:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657123014;
        bh=lTSwJ5wODwZqrldSHc5BFPXMnZHNUb/6g50d+0FvaWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ynSskVbRdSidHqLkwrL6tnVYL50v5wTp3hBw1MgBHRbb0iMuE9lC3Rr+eLJYFXAxT
         fH04Vql5k9Zn5YflQoGZnEkHeqERNgrnTVI7DPHyIIDyjGTzbl/VliT8exm0ooicSQ
         Q/9Y/aIOR7vY+gKo9Gwfkk7Kmo0Hn4Oy1vsvySCk=
Date:   Wed, 6 Jul 2022 17:56:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v2] driver core: Fix repeated device_is_dependent check for
 same link
Message-ID: <YsWww/WJH0gv+dbf@kroah.com>
References: <20220706155347.778762-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706155347.778762-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 06:53:47PM +0300, Abel Vesa wrote:
> In case of a cyclic dependency, if the supplier is not yet available,
> the parent of the supplier is checked for dependency. But if there are
> more than one suppliers with the same parent, the first check returns
> true while the next ones skip that specific link entirely because of
> having DL_FLAG_MANAGED and DL_FLAG_SYNC_STATE_ONLY set, which is what
> the relaxing of the link does. But if we check for the target being
> a consumer before the check for those flags, we can check as many
> times as needed the same link and it will always return true, This is
> safe to do, since the relaxing of the link will be done only once
> because those flags will be set and it will bail early.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/base/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 753e7cca0f40..2c3b860dfe80 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -297,13 +297,13 @@ int device_is_dependent(struct device *dev, void *target)
>  		return ret;
> 
>  	list_for_each_entry(link, &dev->links.consumers, s_node) {
> +		if (link->consumer == target)
> +			return 1;
> +
>  		if ((link->flags & ~DL_FLAG_INFERRED) ==
>  		    (DL_FLAG_SYNC_STATE_ONLY | DL_FLAG_MANAGED))
>  			continue;
> 
> -		if (link->consumer == target)
> -			return 1;
> -
>  		ret = device_is_dependent(link->consumer, target);
>  		if (ret)
>  			break;
> --
> 2.34.3
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
