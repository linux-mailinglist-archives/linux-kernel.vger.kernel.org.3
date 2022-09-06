Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3BC5AE745
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238894AbiIFMJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbiIFMJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:09:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F000725E88;
        Tue,  6 Sep 2022 05:09:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E651614EE;
        Tue,  6 Sep 2022 12:09:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA27C433D6;
        Tue,  6 Sep 2022 12:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662466190;
        bh=iyqVMJPhK+tQYXol3SdlnQX/Wq3CY3/5910c5MgIFkM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jf8C5cn8ePaHmimwqNqj9ZEfsAFvnGf5vRmDNRvcLdnBWHCsuaJZ83qsoSh2b7mkH
         sr5r8y7CcwGDQpkqYlqUgpFbCT/jEJtOMtO6E6LFLvyYjIo6VJdy3svhYpJpj5ffXK
         X7kd9rJUoVr8HJ9JE7/bjrDIJWpPkLNaBhlGus0Ne49FhAkXozB24O1rlGrp7ISk+s
         YZd8urlY3xdI3DAfWAZy2ai2KFd9c8bWZ2kfGGt/nYJ/o2I5GKbMCoroAO7iOO1bmR
         CfzfzlvLe/zb4Q2RBBW0Lj+GsWh+zRT1GJ9xD1f5hNKgikjch6rkdbttap6dzDAnSZ
         TJzcQXoBEK3zA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oVXOs-00051W-1W; Tue, 06 Sep 2022 14:09:54 +0200
Date:   Tue, 6 Sep 2022 14:09:54 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>, stable-commits@vger.kernel.org,
        johan+linaro@kernel.org, Felipe Balbi <balbi@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Patch "usb: dwc3: qcom: fix peripheral and OTG suspend" has been
 added to the 5.19-stable tree
Message-ID: <Yxc4kn0fZU5wIpEq@hovoldconsulting.com>
References: <YxX15QkMDV+0amk8@hovoldconsulting.com>
 <YxX29eiH0qyyRk9x@sashalap>
 <YxX4QT6eeRiatmX+@hovoldconsulting.com>
 <YxX7R/EAynZC/iGr@sashalap>
 <YxYO+u0rAg029yNl@hovoldconsulting.com>
 <YxYrS3z/nYFYzoTh@sashalap>
 <YxbfJqPb8x0WjmqR@hovoldconsulting.com>
 <YxbsvTeuodsiMiop@kroah.com>
 <YxbwMJkMuz7PDX1l@hovoldconsulting.com>
 <YxctgOXYI3FcXv4H@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxctgOXYI3FcXv4H@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 01:22:40PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Sep 06, 2022 at 09:01:04AM +0200, Johan Hovold wrote:

> > The only dwc3 fix that should be needed is the one mentioned above:
> > 
> > 	a872ab303d5d ("usb: dwc3: qcom: fix use-after-free on runtime-PM wakeup")
> > 
> > which is self-contained, even if the context (as in unrelated functions
> > following the helper) may need to be adjusted.
> 
> Ok, I've tried to apply the dwc3 patches that were tagged for stable
> now, and you should have some FAILED emails showing what did not apply.

Yeah, there are some trivial conflicts due to changes in context. I've
just sent you backports to 5.15, which will hopefully apply to older
trees as well.

Johan
