Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CADA4A71ED
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344435AbiBBNse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiBBNsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:48:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E880C06173D;
        Wed,  2 Feb 2022 05:48:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F56461785;
        Wed,  2 Feb 2022 13:48:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755E7C340ED;
        Wed,  2 Feb 2022 13:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643809712;
        bh=XjTJem+30ZyIBwh4Nkm1WxzMwfFDFgfZ62ha20UK10c=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=VbC/Pd7AddMBKKCY3dFEPFxZqDASVrLnoXy+LqbP1fEMUKfIQuFJwYTwTqWPfSYkK
         k/xosadkPqb/Ql9BBpyY99i9c/wGmGC5QlpdS/3Xe3TB/1zdyMt83k6qrdu3bxEo5l
         LpqpL9+Mpxtt555O1kdceLfTMPjgfFdSmv9lp8CdcyCqOqNWLwLU76b37naN6HQavS
         JNX/d925kXDEvXyWUKKM9DjQ0CRPun2UE4RQSB0V5BrWphvxuvZcnwvtDoaXtFNXe+
         UkROIpaZ74UELCi/I3u14GR2i6wIjsdGeTMbBxA5M07jFxuU3yLqviiGhefitu+4oy
         BCCBFDbmVKviw==
Date:   Wed, 2 Feb 2022 14:48:29 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] HID: i2c-hid: goodix: Fix a lockdep splat
In-Reply-To: <CAD=FV=VpQoYkTiKVmC7hMX=bWVYW0rkHWMKU7CqyW_2tanPEpQ@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2202021448060.11721@cbobk.fhfr.pm>
References: <20220128174625.321750-1-daniel.thompson@linaro.org> <CAD=FV=VpQoYkTiKVmC7hMX=bWVYW0rkHWMKU7CqyW_2tanPEpQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2022, Doug Anderson wrote:

> > I'm was on the receiving end of a lockdep splat from this driver and after
> > scratching my head I couldn't be entirely sure it was a false positive
> > given we would also have to think about whether the regulator locking is
> > safe (since the notifier is called whilst holding regulator locks which
> > are also needed for regulator_is_enabled() ).
[ ... snip ... ]
> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > ---
> >  drivers/hid/i2c-hid/i2c-hid-of-goodix.c | 28 +++++++++++--------------
> >  1 file changed, 12 insertions(+), 16 deletions(-)
> 
> Yes, this seems like a reasonable solution, thanks! Probably want:
> 
> Fixes: 18eeef46d359 ("HID: i2c-hid: goodix: Tie the reset line to true
> state of the regulator")
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks, queued for 5.17.

-- 
Jiri Kosina
SUSE Labs

