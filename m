Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7EB5A0ABD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236203AbiHYHxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbiHYHxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:53:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F4D9E8B6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:53:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02E8FB81B80
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328A6C433C1;
        Thu, 25 Aug 2022 07:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661413980;
        bh=w2+CDzxpLXzinHv/LpItV/WhSldf7eSUvIqt6KGdQzw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fnzCVtKHNpcY0e2qXAOg73IGB7exSoP5+NySASktbYFpo6bN8+f3rtzSpollWmKut
         qzr8x7OWCCE5dkMO4gyxAjO7tMD351Jl0EcdKONjp+8KbAxJkq9fvNnixCFf0zxCfV
         Vzk4v0S/ryUSSAtcCPODZNuWUnQZovrtkXCNj4yg=
Date:   Thu, 25 Aug 2022 09:52:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] sysfs: do not create empty directories if no
 attributes are present
Message-ID: <YwcqWaAX8yv3wyoi@kroah.com>
References: <20220824135951.3604059-1-gregkh@linuxfoundation.org>
 <fb3a66c6-a8b3-02db-4170-5d5c521165e2@linux.intel.com>
 <YwZCPdPl2T+ndzjU@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwZCPdPl2T+ndzjU@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 05:22:37PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Aug 24, 2022 at 05:17:44PM +0200, Pierre-Louis Bossart wrote:
> > 
> > 
> > On 8/24/22 15:59, Greg Kroah-Hartman wrote:
> > > When creating an attribute group, if it is named a subdirectory is
> > > created and the sysfs files are placed into that subdirectory.  If no
> > > files are created, normally the directory would still be present, but it
> > > would be empty.  Clean this up by removing the directory if no files
> > > were successfully created in the group at all.
> > > 
> > > Cc: Vinod Koul <vkoul@kernel.org>
> > > Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
> > > Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > Cc: Sanyog Kale <sanyog.r.kale@intel.com>
> > > Cc: alsa-devel@alsa-project.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > > v2: new patch
> > > 
> > > Note, totally untested!  The following soundwire patches will need this,
> > > if a soundwire developer could test this out, it would be most
> > > apreciated.
> > 
> > Not able to see the kernel boot with this first patch. The device is
> > stuck with the cursor not even blinking. It seems our CI test devices
> > are also stuck.
> > 
> > This is completely beyond my comfort zone but I can run more tests to
> > root cause this.
> 
> Ick, ok, so much for sending out untested patches :(
> 
> I'll test and debug this tomorrow and resend a correct version, thanks
> for helping out here, sorry it didn't work.

I have run out of time to work on this for this week, I'll try to pick
it up next week.  Don't worry about the soundwire changes for now, I'll
resend them when I get this all working properly.

thanks,

greg k-h
