Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2EA652DAA1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 18:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241968AbiESQvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 12:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236304AbiESQvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 12:51:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F415A172
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 09:51:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EE0860B8F
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14B4C385AA;
        Thu, 19 May 2022 16:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652979108;
        bh=LuK3ZmidX0cuWE1khNLjrTkNT3jkyQYbrGT/Q/UQVww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t/DDrk80rvv+zoD4GcdbFrafFXT7dQ1PbmR0/aMhFmzvJ5leo+RaYHWgKaLFnRViG
         OB+8B2YLe+Pi5JGpvUBDVOoRQsHhnSlp84DMDUbepjcxIuOxqbBPCYb5clz1D8wDBS
         sCmIwrn83QfShFb1gX4edobaaU+gI4KeTkzcJumA=
Date:   Thu, 19 May 2022 18:51:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Won Chung <wonchung@google.com>
Cc:     Yu Watanabe <watanabe.yu@gmail.com>, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] driver core: location: Free struct acpi_pld_info *pld
Message-ID: <YoZ1oY7/lhUjcs04@kroah.com>
References: <20220509173135.3515126-1-wonchung@google.com>
 <YoZ1gZQHdTnmiQOS@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoZ1gZQHdTnmiQOS@kroah.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 06:51:13PM +0200, Greg Kroah-Hartman wrote:
> On Mon, May 09, 2022 at 05:31:35PM +0000, Won Chung wrote:
> > After struct acpi_pld_info *pld is used to fill in physical location
> > values, it should be freed to prevent memleak.
> > 
> > Suggested-by: Yu Watanabe <watanabe.yu@gmail.com>
> > Signed-off-by: Won Chung <wonchung@google.com>
> > ---
> >  drivers/base/physical_location.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/base/physical_location.c b/drivers/base/physical_location.c
> > index fbd9f9839e92..617ada542b00 100644
> > --- a/drivers/base/physical_location.c
> > +++ b/drivers/base/physical_location.c
> > @@ -32,6 +32,7 @@ bool dev_add_physical_location(struct device *dev)
> >  	dev->physical_location->dock = pld->dock;
> >  	dev->physical_location->lid = pld->lid;
> >  
> > +	ACPI_FREE(pld);
> >  	return true;
> >  }
> >  
> > -- 
> > 2.36.0.512.ge40c2bad7a-goog
> > 
> 
> What commit id does this fix?  Please add that and resend.
> 
> thanks,
> greg k-h

Nevermind, I'll take it as-is.
