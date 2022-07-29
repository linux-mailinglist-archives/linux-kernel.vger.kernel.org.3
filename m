Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C86B585446
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 19:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237977AbiG2RPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 13:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237951AbiG2RPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 13:15:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD797B7C5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 10:15:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F3CE61EF2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 17:15:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DB0C433D6;
        Fri, 29 Jul 2022 17:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659114927;
        bh=VAkEGQMytpddlsQ64xfJjyOEeyWtSq4kkkEs8HNbh64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t+jw/oEvzQ0ZS7d4yPWHfkE5ZHKpFe7S0xEGGznHHgssCeJ3xgB9KSWWVWJCujN9A
         2sHRVGnfsZfr2yJhE9BOdyuSbzIfoC+ZhfYLmlqM1P26pF6lbzIwFizPma1tNUsrmL
         ijDjWmXEXDkDJSiQpIJMzYGqoTLujQ3bDBW4PGMI=
Date:   Fri, 29 Jul 2022 19:15:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        linux-kernel@vger.kernel.org, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 2/5] soundwire: sysfs: cleanup the logic for creating the
 dp0 sysfs attributes
Message-ID: <YuQVrLEqPMu1V0zJ@kroah.com>
References: <20220729135041.2285908-1-gregkh@linuxfoundation.org>
 <20220729135041.2285908-2-gregkh@linuxfoundation.org>
 <9365e038-2146-98f8-f989-02827f221c34@linux.intel.com>
 <YuP0Ffs3G7ZBR0AC@kroah.com>
 <cfacb124-a9ff-0a93-8f92-93d164b15966@linux.intel.com>
 <YuP2pjhyKTTfpXQq@kroah.com>
 <5caffe2a-f5a6-e312-a564-5fe29c4e2323@linux.intel.com>
 <YuQMYRYFo9gTk1yL@kroah.com>
 <701aa1ba-9b25-51eb-8bd7-2389b501d79c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <701aa1ba-9b25-51eb-8bd7-2389b501d79c@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 11:46:32AM -0500, Pierre-Louis Bossart wrote:
> 
> >>>>> That should be fine, tools should just be looking for the attributes,
> >>>>> not the existance of a directory, right?
> >>>>
> >>>> The idea what that we would only expose ports that actually exist.
> >>>> That's helpful information anyone with a basic knowledge of the
> >>>> SoundWire specification would understand.
> >>>
> >>> Is "dp0" a port?  If so, why isn't it a real device?
> >>
> >> The SoundWire spec defines the concept of 'data port'. The valid ranges
> >> are 1..14, but in all existing devices the number of data ports is way
> >> smaller, typically 2 to 4. Data ports (DPn) are source or sink, and
> >> there's no firm rule that data ports needs to be contiguous.
> >>
> >> DP0 is a 'special case' where the data transport is used for control
> >> information, e.g. programming large set of registers or firmware
> >> download. DP0 is completely optional in hardware, and not handled in
> >> Linux for now.
> >>
> >> DP0 and DPn expose low-level transport registers, which define how the
> >> contents of a FIFO will be written or read from the bus. Think of it as
> >> a generalization of the concept of TDM slots, where instead of having a
> >> fixed slot per frame the slot position/repetition/runlength can be
> >> programmed.
> >>
> >> The data ports could be as simple as 1-bit PDM, or support 8ch PCM
> >> 24-bits. That's the sort of information reported in attributes.
> > 
> > Why not make them a real device like we do for USB endpoints?
> 
> I don't see what adding another layer of hierarchy would bring. In their
> simplest configuration, there are 6 registers 8-bit exposed. And the
> port registers, when present, are accessed with a plain vanilla offset.

Who uses these registers?

> > What uses these sysfs files today that would be confused about an empty
> > directory?
> 
> That's a good question. I am not aware of any tools making use of those
> attributes. To a large degree, they are helpful only for debug and
> support, all these read-only attributes could be moved to debugfs. That
> could be a way to simplify everyone's life....

That would be much nicer, put it all in a single debugfs file and it
would be so simple.

What attributes could we do that for?

thanks,

greg k-h
