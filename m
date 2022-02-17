Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB594BA9C5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245170AbiBQT1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:27:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243277AbiBQT07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:26:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258EFE0AFC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:26:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B98EA6172B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 19:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AED3C340E8;
        Thu, 17 Feb 2022 19:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645126004;
        bh=+GbxhSGLzwmU1NtyRldCXItdnvRFCwidru7MjEV9s9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YmhwJXVCJ4d6qu6l7uDUhvZunhZtjhor06UZWQf8d3iGcpaA6HVHREYiU2F4K9LVi
         pxjQqnAZG8dDh0hbia26X4YryPPB135FbUrs0C4xZbDM35AEpAFmG+HI+3fO75S/SG
         d49dxFKeG3z6GnWeN5P/cXX1rkhQBang4SrQD5OM=
Date:   Thu, 17 Feb 2022 20:26:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Husni Faiz <ahamedhusni73@gmail.com>
Cc:     pure.logic@nexus-software.ie, elder@kernel.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: loopback: Fix Coding Style Error
Message-ID: <Yg6hcX6XK4Eu0KOR@kroah.com>
References: <20220217190722.44894-1-ahamedhusni73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217190722.44894-1-ahamedhusni73@gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 12:37:22AM +0530, Husni Faiz wrote:
> Macros with multiple statements should be enclosed in a do - while
> block.
> 
> Signed-off-by: Husni Faiz <ahamedhusni73@gmail.com>
> ---
>  drivers/staging/greybus/loopback.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
> index 2471448ba42a..33666a49e0a8 100644
> --- a/drivers/staging/greybus/loopback.c
> +++ b/drivers/staging/greybus/loopback.c
> @@ -162,10 +162,12 @@ static ssize_t name##_avg_show(struct device *dev,		\
>  }									\
>  static DEVICE_ATTR_RO(name##_avg)
>  
> -#define gb_loopback_stats_attrs(field)				\
> -	gb_loopback_ro_stats_attr(field, min, u);		\
> -	gb_loopback_ro_stats_attr(field, max, u);		\
> -	gb_loopback_ro_avg_attr(field)
> +#define gb_loopback_stats_attrs(field)					\
> +	do {												\
> +		gb_loopback_ro_stats_attr(field, min, u);		\
> +		gb_loopback_ro_stats_attr(field, max, u);		\
> +		gb_loopback_ro_avg_attr(field)					\
> +	} while (0)
>  
>  #define gb_loopback_attr(field, type)					\
>  static ssize_t field##_show(struct device *dev,				\
> -- 
> 2.25.1
> 
> 

Did you try to build this change?
