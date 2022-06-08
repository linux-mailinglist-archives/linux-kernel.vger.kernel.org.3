Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B4D542FB4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238628AbiFHMEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 08:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238650AbiFHMES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:04:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4899D253337;
        Wed,  8 Jun 2022 05:04:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 167F361856;
        Wed,  8 Jun 2022 12:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255BEC34116;
        Wed,  8 Jun 2022 12:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654689851;
        bh=wRG0t8jqNnmeI5840IsJAuMQIqk8QFPMFoOfaPItciY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YF050R6H/ODB3BEIvYVKdRZqzCN9F84sfIzy+ci328O8gQxg1j9dtuISJMbxefeIJ
         90ncuG7HiRYRZtyfBBOdmPRHGmdB9Fan5IB7s6bojRujvZc35F66tkSRQAClkMZscx
         o6SvoafiGSEGFrC0EdZBbzK2QegOAy/2seA1CluM=
Date:   Wed, 8 Jun 2022 14:04:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] driver core: Introduce device_find_first_child()
 helper
Message-ID: <YqCQOAy64heA3GPM@kroah.com>
References: <20220607202058.8304-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gmO-BDyurQtG4sU5KLfe2mjs7vm5kpJQoAaxYxF57t3g@mail.gmail.com>
 <YqCNuJ3RQX3jIy59@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqCNuJ3RQX3jIy59@smile.fi.intel.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 02:53:28PM +0300, Andy Shevchenko wrote:
> On Wed, Jun 08, 2022 at 01:29:08PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Jun 7, 2022 at 10:22 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> 
> ...
> 
> > I would define it as
> > 
> > static int match_first(struct device *dev, void *)
> > {
> >        return 1;
> > }
> > 
> > struct device *device_find_first_child(struct device *parent)
> > {
> >         return device_find_first_child(parent, NULL, match_first);
> > }
> > EXPORT_SYMBOL_GPL(device_find_first_child);
> > 
> > which is not that much more overhead.
> 
> With this we actually may simply provide a match function and it will make the
> clean ups (like patch 2 in the series) almost the same without introducing a
> device core call.
> 
> Something like
> 
> int device_match_any_for_find(struct device *dev, void *unused)
> {
> 	return 1;
> }
> 
> As I replied to Greg it's pity we can't use device_match_any()...

	int device_match_any(struct device *dev, const void *unused)

How is that not ok to use here?

thanks,

greg k-h
