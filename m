Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DB352DAA0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 18:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240680AbiESQvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 12:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236304AbiESQvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 12:51:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFB64F9C0
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 09:51:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EAB560F77
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C653C385AA;
        Thu, 19 May 2022 16:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652979076;
        bh=Dq2xAokO+cKevSATu0fROdkBmvuXWkljBiG/Ddw+xyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fQre84O8gPlJdBQYKMlD0X2Je4SnTW+xyZu9evMETwf9qx0eEfCmEJ49likIWy2Yo
         IpZXCskBsbuS1BClkV9meWkbCMXAV0o2E59WiK5UJtNF7hx66cMaNrLNh1htM5AXZI
         myqAKhpG2F33pUD4oY70EkDxNb3xKB17+zblnerY=
Date:   Thu, 19 May 2022 18:51:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Won Chung <wonchung@google.com>
Cc:     Yu Watanabe <watanabe.yu@gmail.com>, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] driver core: location: Free struct acpi_pld_info *pld
Message-ID: <YoZ1gZQHdTnmiQOS@kroah.com>
References: <20220509173135.3515126-1-wonchung@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509173135.3515126-1-wonchung@google.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 05:31:35PM +0000, Won Chung wrote:
> After struct acpi_pld_info *pld is used to fill in physical location
> values, it should be freed to prevent memleak.
> 
> Suggested-by: Yu Watanabe <watanabe.yu@gmail.com>
> Signed-off-by: Won Chung <wonchung@google.com>
> ---
>  drivers/base/physical_location.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/base/physical_location.c b/drivers/base/physical_location.c
> index fbd9f9839e92..617ada542b00 100644
> --- a/drivers/base/physical_location.c
> +++ b/drivers/base/physical_location.c
> @@ -32,6 +32,7 @@ bool dev_add_physical_location(struct device *dev)
>  	dev->physical_location->dock = pld->dock;
>  	dev->physical_location->lid = pld->lid;
>  
> +	ACPI_FREE(pld);
>  	return true;
>  }
>  
> -- 
> 2.36.0.512.ge40c2bad7a-goog
> 

What commit id does this fix?  Please add that and resend.

thanks,
greg k-h
