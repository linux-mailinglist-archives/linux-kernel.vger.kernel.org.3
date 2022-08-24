Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1213E59FE2B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239471AbiHXPWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiHXPWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:22:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AC298A7F
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 08:22:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E39161865
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 15:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F306C433C1;
        Wed, 24 Aug 2022 15:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661354560;
        bh=Xu7LCdyMGn+McwuXQcjzobThUsINws7xLr2XHKj0nNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lDkZMcwagdoURaR+jm24a+ohs1u+RX+U7TEQbISwiBnOzC3gKi0sLdglVz/S+pPO4
         5eGIb0gqEW3fH6BZ2Qz6BWy5ihyAt97ds6xvqUBcm6xtMEzb+joFOHLLT81kUkuxuP
         dtdWi7a3I85psdFyxh9hLwA+9+b9aAclXhqJvEaU=
Date:   Wed, 24 Aug 2022 17:22:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] sysfs: do not create empty directories if no
 attributes are present
Message-ID: <YwZCPdPl2T+ndzjU@kroah.com>
References: <20220824135951.3604059-1-gregkh@linuxfoundation.org>
 <fb3a66c6-a8b3-02db-4170-5d5c521165e2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb3a66c6-a8b3-02db-4170-5d5c521165e2@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 05:17:44PM +0200, Pierre-Louis Bossart wrote:
> 
> 
> On 8/24/22 15:59, Greg Kroah-Hartman wrote:
> > When creating an attribute group, if it is named a subdirectory is
> > created and the sysfs files are placed into that subdirectory.  If no
> > files are created, normally the directory would still be present, but it
> > would be empty.  Clean this up by removing the directory if no files
> > were successfully created in the group at all.
> > 
> > Cc: Vinod Koul <vkoul@kernel.org>
> > Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
> > Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > Cc: Sanyog Kale <sanyog.r.kale@intel.com>
> > Cc: alsa-devel@alsa-project.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > v2: new patch
> > 
> > Note, totally untested!  The following soundwire patches will need this,
> > if a soundwire developer could test this out, it would be most
> > apreciated.
> 
> Not able to see the kernel boot with this first patch. The device is
> stuck with the cursor not even blinking. It seems our CI test devices
> are also stuck.
> 
> This is completely beyond my comfort zone but I can run more tests to
> root cause this.

Ick, ok, so much for sending out untested patches :(

I'll test and debug this tomorrow and resend a correct version, thanks
for helping out here, sorry it didn't work.

greg k-h
