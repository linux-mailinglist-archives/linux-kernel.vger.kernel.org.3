Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F5C50C96D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 12:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbiDWK4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 06:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbiDWK4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 06:56:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE7320D62D
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 03:53:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A965B80A7C
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 10:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0E3C385A0;
        Sat, 23 Apr 2022 10:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650711185;
        bh=0u/mceG99EHgoghWwdSWZQ50NwptBEddcg6cYThSrw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GkClU9x5qYy7RWJ0SoiQHYw0jFOX7qkYqb1YJsHLz+O6Jq8dJS4K/ffMrgzwK9cho
         /x6N2fH3+fmdULkusx0UybVAcXBuNnsebB8G107d6zwTq1NYU05cay9b4SJfsRoVy/
         KkchlyM0HcBAJox88K18IiteiMOr7NkG6tK5Wbr4=
Date:   Sat, 23 Apr 2022 12:53:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] topology: Fix up build warning in topology_is_visible()
Message-ID: <YmPajtfsCL8Idw4h@kroah.com>
References: <20220422062653.3899972-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422062653.3899972-1-gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 08:26:53AM +0200, Greg Kroah-Hartman wrote:
> Commit aa63a74d4535 ("topology/sysfs: Hide PPIN on systems that do not
> support it.") caused a build warning on some configurations:
> 
> drivers/base/topology.c: In function 'topology_is_visible':
> drivers/base/topology.c:158:24: warning: unused variable 'dev' [-Wunused-variable]
>   158 |         struct device *dev = kobj_to_dev(kobj);
> 
> Fix this up by getting rid of the variable entirely.
> 
> Fixes: aa63a74d4535 ("topology/sysfs: Hide PPIN on systems that do not support it.")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/base/topology.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/base/topology.c b/drivers/base/topology.c
> index 706dbf8bf249..ac6ad9ab67f9 100644
> --- a/drivers/base/topology.c
> +++ b/drivers/base/topology.c
> @@ -155,9 +155,7 @@ static struct attribute *default_attrs[] = {
>  static umode_t topology_is_visible(struct kobject *kobj,
>  				   struct attribute *attr, int unused)
>  {
> -	struct device *dev = kobj_to_dev(kobj);
> -
> -	if (attr == &dev_attr_ppin.attr && !topology_ppin(dev->id))
> +	if (attr == &dev_attr_ppin.attr && !topology_ppin(kobj_to_dev(kobj)->id))
>  		return 0;
>  
>  	return attr->mode;
> -- 
> 2.36.0
> 

Given no comments that this is a bad idea, I'll go apply this now.

thanks,

greg k-h
