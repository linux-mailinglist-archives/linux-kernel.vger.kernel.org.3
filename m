Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0414E486635
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 15:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240224AbiAFOla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 09:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237699AbiAFOl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 09:41:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937EDC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 06:41:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 352A361A44
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 14:41:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45634C36AE3;
        Thu,  6 Jan 2022 14:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641480087;
        bh=4A5jxm0CCzUdRAl/8OlHfnUswpeNB4MsuonVeh3xHwQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W0vMK+tJT7H2AQDIdP9R8+Vbyb/g94WOshGL9jE1Sp+j4eTeqz/VjRE9wu0GgsgFf
         fieGpwErg9hwWoAmZt0V/kJQkyCeJhtXYSdBMCYGksQHABud/A9wg5UQrHTVct+Z7V
         P2x/mIs9rY+Ti2R3rSSv+jelqGdJhll0yn8Do2CE=
Date:   Thu, 6 Jan 2022 15:41:25 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Aswath Govindraju <a-govindraju@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] mux: add missing mux_state_get
Message-ID: <Ydb/lQMPxw3/IDIF@kroah.com>
References: <94ab71e1-2e68-def2-95b8-33162172f65c@axentia.se>
 <90c40462-9672-949a-14cd-e13e440fe177@axentia.se>
 <YdLvGge5SbuhAi3N@kroah.com>
 <08a48424-a8e6-f08a-63d3-b00aa5cd33f2@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08a48424-a8e6-f08a-63d3-b00aa5cd33f2@axentia.se>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2022 at 06:26:21PM +0100, Peter Rosin wrote:
> Hi!
> 
> On 2022-01-03 13:42, Greg Kroah-Hartman wrote:
> > On Sun, Jan 02, 2022 at 11:38:36PM +0100, Peter Rosin wrote:
> >> From: Peter Rosin <peda@axentia.se>
> >>
> >> And implement devm_mux_state_get in terms of the new function.
> >>
> >> Tested-by: Aswath Govindraju <a-govindraju@ti.com>
> >> Signed-off-by: Peter Rosin <peda@axentia.se>
> >> ---
> >>  drivers/mux/core.c           | 41 ++++++++++++++++++++++++++----------
> >>  include/linux/mux/consumer.h |  1 +
> >>  2 files changed, 31 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/drivers/mux/core.c b/drivers/mux/core.c
> >> index 7d38e7c0c02e..90073ce01539 100644
> >> --- a/drivers/mux/core.c
> >> +++ b/drivers/mux/core.c
> >> @@ -673,6 +673,33 @@ struct mux_control *devm_mux_control_get(struct device *dev,
> >>  }
> >>  EXPORT_SYMBOL_GPL(devm_mux_control_get);
> >>  
> >> +/**
> >> + * mux_state_get() - Get the mux-state for a device.
> >> + * @dev: The device that needs a mux-state.
> >> + * @mux_name: The name identifying the mux-state.
> >> + *
> >> + * Return: A pointer to the mux-state, or an ERR_PTR with a negative errno.
> >> + */
> >> +struct mux_state *mux_state_get(struct device *dev, const char *mux_name)
> >> +{
> >> +	struct mux_state *mstate;
> >> +
> >> +	mstate = kzalloc(sizeof(*mstate), GFP_KERNEL);
> >> +	if (!mstate)
> >> +		return ERR_PTR(-ENOMEM);
> >> +
> >> +	mstate->mux = mux_get(dev, mux_name, &mstate->state);
> > 
> > will this build?  I haven't applied it but mux_get() in my tree right
> > now is defined as:
> > 	static inline void mux_get(struct gsm_mux *gsm)
> 
> Yes it builds. As mentioned in the cover letter, the patches have been
> in -next for a couple of weeks. The static definition you are pointing
> at is from n_gsm.c (which does not seem to be #included by any other
> file). This definition of mux_get is again static and in a .c file
> (which is not #included by anything). Surely not a conflict?

If it's static, no, it's fine, but I don't see it in this commit either?

I'm confused now, can you resend the remaining changes and I will review
them again?

thanks,

greg k-h
