Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565FF50A4BB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390332AbiDUP4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244480AbiDUP4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:56:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5629515722;
        Thu, 21 Apr 2022 08:54:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 159A8B82427;
        Thu, 21 Apr 2022 15:54:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3D0C385A5;
        Thu, 21 Apr 2022 15:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650556439;
        bh=SPGqcsm/mPwauQNxS2M/UVf4wunx/J8ixR6fXQi/vgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ay6LPA6X8qf16TL6LPrVDn82pO394X1oys0Gg86eGgMOUBFHPdE7kbPEmagMSDVKk
         KtMKJWvM+bPeCDzG93MJlYzItvrfr4lDAYKbSaXO1iCJhyYXx7TVvusObmjjpAzEqC
         C/H5vbcG+IegQVh0FegjgBnNYH0flpf4c6cxi4M8=
Date:   Thu, 21 Apr 2022 17:53:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH] topology/sysfs: Fix allnoconfig build breakage.
Message-ID: <YmF+FTxgu2U4/oPA@kroah.com>
References: <20220421152645.3a849198@canb.auug.org.au>
 <YmD+geU9CmjoVnN9@kroah.com>
 <YmF8Hrq5kgDdfvtS@agluck-desk3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmF8Hrq5kgDdfvtS@agluck-desk3.sc.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 08:45:34AM -0700, Luck, Tony wrote:
> drivers/base/topology.c: In function 'topology_is_visible':
> drivers/base/topology.c:158:24: warning: unused variable 'dev' [-Wunused-variable]
>   158 |         struct device *dev = kobj_to_dev(kobj);
> 
> This is because the topology_ppin(dev->id) macro expands to:
> 
> 	(cpu_data(dev->id).ppin)
> 
> and with CONFIG_SMP=n the cpu_data() macro expands to boot_cpu_data
> (ignoring its argument) with the end result:
> 
> 	boot_cpu_data.ppin
> 
> My CPP-fu wasn't up to a modification to topology_ppin(), so I added a
> (probably redundant) check for "dev" being a NULL pointer.
> 
> Fixes: c3702a746ff5 ("topology/sysfs: Hide PPIN on systems that do not support it.")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> 
> ---
> Better fixes with clever CPP macro tricks gratefully welcomed
> ---
>  drivers/base/topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/topology.c b/drivers/base/topology.c
> index 706dbf8bf249..31fae51fd340 100644
> --- a/drivers/base/topology.c
> +++ b/drivers/base/topology.c
> @@ -157,7 +157,7 @@ static umode_t topology_is_visible(struct kobject *kobj,
>  {
>  	struct device *dev = kobj_to_dev(kobj);
>  
> -	if (attr == &dev_attr_ppin.attr && !topology_ppin(dev->id))
> +	if (!dev || (attr == &dev_attr_ppin.attr && !topology_ppin(dev->id)))

!dev is impossible to ever hit, that's the sign that the code is wrong
and needs to be fixed :(

Sorry, this is not going to be an acceptable change.

greg k-h
