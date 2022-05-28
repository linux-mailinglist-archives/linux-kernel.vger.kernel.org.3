Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76A0536963
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 02:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355262AbiE1A0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 20:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245666AbiE1A0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 20:26:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C926F59D;
        Fri, 27 May 2022 17:26:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A09F9B82655;
        Sat, 28 May 2022 00:26:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA5EC385A9;
        Sat, 28 May 2022 00:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653697594;
        bh=v97sikmwzDyAsEzqE9wN8Xw6wJ6O7aw4Guu8y1BBzCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z/baBl8wZ6FycigoHdy9I/Xm92oP5Ku7LvlZtmd46lBpML5Mtk61WZwXDY3MDCrQM
         fn40TtaqoJeW3zwa31G20nWpx6lZWgbcIE9aUitvgoZOQmoNEVXqVo7S7AzaECVfeX
         7Hh+a1YFDGrR+U2kYyfeR7ZURDo9DM3bM2ej77PmGjh+tYZhl2cWbmgH/xLN9QMLw4
         pni/z9FcoJrZGC9N89MTQ3r+FrURKDIJiWP2Xxv2YsYSC67HhEEAVbuRaPCO1bdz9t
         qOh9/iRm7X2FpVu8n6vqb3vaaQMVtwdAt6ShaLq5HMywVsCeQFS816KZItagq4jLVU
         PmTcNMJHgWBLw==
Date:   Fri, 27 May 2022 17:26:32 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] f2fs: add sysfs entry to avoid FUA
Message-ID: <YpFsOLz/GScXvhkb@google.com>
References: <20220527205955.3251982-1-jaegeuk@kernel.org>
 <YpFDw3mQjN1LBd2j@gmail.com>
 <20220527235509.GW1098723@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527235509.GW1098723@dread.disaster.area>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/28, Dave Chinner wrote:
> On Fri, May 27, 2022 at 09:33:55PM +0000, Eric Biggers wrote:
> > [+Cc linux-block for FUA, and linux-xfs for iomap]
> 
> linux-fsdevel should really be used for iomap stuff...
> 
> > 
> > On Fri, May 27, 2022 at 01:59:55PM -0700, Jaegeuk Kim wrote:
> > > Some UFS storage gives slower performance on FUA than write+cache_flush.
> > > Let's give a way to manage it.
> > > 
> > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > 
> > Should the driver even be saying that it has FUA support in this case?  If the
> > driver didn't claim FUA support, that would also solve this problem.
> 
> Agreed, this is a hardware problem that need to addressed with a
> driver quirk to stop it advertising FUA support. The high level
> fs/iomap code should always issue FUA writes where possible and
> the lower layers tell the block layer whether to issue the FUA as
> a FUA or write+cache flush pair.

I was thinking to turn off FUA in driver side quickly tho, one concern
was the bandwidth vs. latency. What if the device can support FUA having
short latency while giving low bandwidth? In that case, we still have
a room to utilize FUA for small-sized  writes such as filesystem metadata
writes, but avoid DIO w/ FUA for sequential write stream. Is this just
HW problem? Or, does SW need to use FUA more efficiently?

> 
> And, quite frankly, exposing this sort of "hardware needs help" knob
> as a sysfs variable is exactly the sort of thing we should never do.
> 
> Users have no idea how to tune stuff like this correctly (even if
> they knew it existed!), yet we know exactly what hardware has this
> problem and the kernel already has mechanisms that would allow it to
> just Do The Right Thing. IOWs, we can fix this without the user even
> having to know that they have garbage hardware that needs special
> help....
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
