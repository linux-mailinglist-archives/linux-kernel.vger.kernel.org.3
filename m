Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA61599A02
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 12:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348198AbiHSKd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 06:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348042AbiHSKdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 06:33:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AB463BB;
        Fri, 19 Aug 2022 03:33:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A664616EC;
        Fri, 19 Aug 2022 10:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1841CC433D7;
        Fri, 19 Aug 2022 10:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660905195;
        bh=P0ohKSkFshdhJ/jP9vFwkBZFmB+9KCEud3AFiAiMbmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zjJfROVURJQxCvUOeg4Nkgxqx9luhmsRP5yzv95BZBWKg4eJHf5UGpZQb5Ret5hrk
         lhdlelPhJ0Ez06/6q+3qZRWsC9vfsWVf123a+7H1SnfCDqDWABG+2Z1naBXTnNuzPH
         av3xOcUd2jLMnbAe1GsPmTTaBWHErkYy0dNegwt0=
Date:   Fri, 19 Aug 2022 12:33:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Utkarsh Patel <utkarsh.h.patel@intel.com>,
        rajmohan.mani@intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/6] ACPI: New helper function
 acpi_dev_get_memory_resources() and a new ACPI ID
Message-ID: <Yv9m6LSGKXvnnBSY@kroah.com>
References: <20220816101629.69054-1-heikki.krogerus@linux.intel.com>
 <Yv6PLl4aLPzHTJTQ@kroah.com>
 <Yv9ftg2MVx+okmzC@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv9ftg2MVx+okmzC@kuha.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 01:02:30PM +0300, Heikki Krogerus wrote:
> Hi,
> 
> On Thu, Aug 18, 2022 at 09:12:46PM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Aug 16, 2022 at 01:16:23PM +0300, Heikki Krogerus wrote:
> > > Hi,
> > > 
> > > The helper function returns all memory resources described for a
> > > device regardless of the ACPI descriptor type (as long as it's
> > > memory), but the first patch introduces new ACPI ID for the IOM
> > > controller on Intel Meteor Lake and also separately modifies the
> > > driver so that it can get the memory resource from Address Space
> > > Resource Descriptor.
> > > 
> > > An alternative would have been to introduce that helper function first
> > > so we would not need to modify the driver when the new ID is added,
> > > but then the helper would also need to be applied to the stable kernel
> > > releases, and that does not feel necessary or appropriate in this
> > > case, at least not IMO.
> > > 
> > > So that's why I'm proposing here that we first add the ID, and only
> > > after that introduce the helper, and only for mainline. That way the
> > > patch introducing the ID is the only that goes to the stable releases.
> > > 
> > > If that's okay, and these don't have any other problems, I assume it's
> > > OK if Rafael takes all of these, including the ID?
> > 
> > I took the id now, for 6.0-final as it seems to be totally independant
> > of the other commits (otherwise you would not have tagged it for the
> > stable tree.)
> > 
> > The remainder should probably be resent and send through the acpi tree.
> 
> Okay. The last patch depends on that ID patch, so Rafael, you need to
> handle that conflict with immutable branch I guess. Or should we just
> skip that patch for now?

You can wait for -rc3 or so which should have that commit in it.

thanks,

greg k-h
