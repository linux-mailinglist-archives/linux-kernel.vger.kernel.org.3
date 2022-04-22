Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757FF50B09F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444373AbiDVGab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbiDVGaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:30:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9073150B0E;
        Thu, 21 Apr 2022 23:27:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29F4B61E84;
        Fri, 22 Apr 2022 06:27:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FFCBC385A0;
        Fri, 22 Apr 2022 06:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650608849;
        bh=0LmX9onb0fLejpzUdnIanuBPF8QPvttRJ09VDidwsGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h8KDDC86T6Z7XLFA3NVQa8DjEIQgAfefqBfq3z0ME+UlRMfKtJxGmU3pEw3MAGCpL
         XeX/WZR08AI1H7uhePs2voBbuDiijrEKOIKGrCTTR9nSPRYvC41vTy2U3t1GT9LBj3
         N6tpcarPtLJjWbbqTLFqcseWZm2lKocH8QOU542s=
Date:   Fri, 22 Apr 2022 08:27:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH v2] topology/sysfs: Fix allnoconfig build breakage.
Message-ID: <YmJKzgG9tNY5c6RP@kroah.com>
References: <20220421152645.3a849198@canb.auug.org.au>
 <YmD+geU9CmjoVnN9@kroah.com>
 <YmF8Hrq5kgDdfvtS@agluck-desk3.sc.intel.com>
 <YmF+FTxgu2U4/oPA@kroah.com>
 <YmGEL2klp4S97UiH@agluck-desk3.sc.intel.com>
 <20220422092247.5c638079@canb.auug.org.au>
 <90d0e2c9b4a74c92bcdd5fc4313a7629@intel.com>
 <20220422100054.74cadded@canb.auug.org.au>
 <YmIYFjI/B+33PQn+@agluck-desk3.sc.intel.com>
 <YmJEkoVGCnCXb5Ff@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmJEkoVGCnCXb5Ff@kroah.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 08:00:50AM +0200, Greg KH wrote:
> On Thu, Apr 21, 2022 at 07:51:02PM -0700, Luck, Tony wrote:
> > On Fri, Apr 22, 2022 at 10:00:54AM +1000, Stephen Rothwell wrote:
> > > I assume that there is some good reason that topology_ppin() is not
> > > implemented as a static inline function?
> > 
> > I don't think so. I just cut & pasted how all the other topology_*()
> > things were implemented.
> > 
> > Making it a static inline appears to fix this problem. But before
> > embarrassing myself with a third broken version I'll let zero day
> > crunch on:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git hide_ppin
> > 
> > to see if there is some subtle config or arch where the inline trick
> > doesn't work.
> > 
> > Thanks for the idea! :-)
> 
> Why not just do the following, which passes my build tests here:
> 
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

I've sent this as real patch now.

thanks,

greg k-h
