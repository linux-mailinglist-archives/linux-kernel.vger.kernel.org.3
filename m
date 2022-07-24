Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14ED57F587
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 16:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiGXOq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 10:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiGXOqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 10:46:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C7810562;
        Sun, 24 Jul 2022 07:46:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B9E6B80D2E;
        Sun, 24 Jul 2022 14:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5EC5C3411E;
        Sun, 24 Jul 2022 14:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658674011;
        bh=puU8YqjFpRQ/Pdae2Mkw+tfbNoOrVhW9hFqKqO1Zng0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GvycWdcVWM2u3eH6ngQ/JqSS8VK6I3+6JxgX+lpKiaJbpAi4dvq3R+DuicDFxlPH0
         TP5czSa7NvrrMVkpDyxvBZ/qV2s4ftezAZGA/0QQVa//Igmo/8JVctvQof0Wm7YsGW
         ENq6j5Gix7R/Gkuy0G10IaKm1midWjXUfMlTONpfQR/FENrL8pIYxQvv0oOh6agpZo
         2C/mZG2wR3NwqScZ+6J9cnhUDqUubU8omPckvRHU1Y8o+6iPu6/4rrr6Qd8bdRJUJC
         lRP43RB083wJ1/Q//AgnUgp9GNC6C7LSOWwewKuGzWLPvsw6djWgl0OHWvkhprHjAn
         VE1T+pX8DkPyw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oFcsl-0003O4-Rd; Sun, 24 Jul 2022 16:47:00 +0200
Date:   Sun, 24 Jul 2022 16:46:59 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yan Xinyu <sdlyyxy@bupt.edu.cn>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] USB: serial: usb_wwan: replace DTR/RTS magic numbers
 with macros
Message-ID: <Yt1bY74PirDyuYcu@hovoldconsulting.com>
References: <20220722085040.704885-1-sdlyyxy@bupt.edu.cn>
 <Yt0MfqQQTwe4ztuN@hovoldconsulting.com>
 <Yt1OPKNlWZuMrZv4@kroah.com>
 <Yt1SFXlwbW1JCohE@hovoldconsulting.com>
 <Yt1UG058Qjsngps6@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt1UG058Qjsngps6@kroah.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 04:15:55PM +0200, Greg Kroah-Hartman wrote:
> On Sun, Jul 24, 2022 at 04:07:17PM +0200, Johan Hovold wrote:
> > On Sun, Jul 24, 2022 at 03:50:52PM +0200, Greg Kroah-Hartman wrote:

> > > I think Yan should write a patch series to unify these and make it
> > > right, instead of just papering over it all.
> > 
> > Ok, I just fear it will be more work for us since that involves
> > decisions like whether it should be added to the uapi header, and then
> > we get into naming, etc. But we're in no rush.
> > 
> > > Also this "../" stuff in a
> > > #include directive is not ok, I wouldn't recommend this change be taken
> > > as-is.
> > 
> > That was never an option, but I'd be ok with taking the v2 which added
> > defines for the constants directly in the driver.
> 
> These are global defines, in a public spec, and they should all just be
> in one place in the kernel.  What's wrong with include/uapi/linux/cdc.h
> which is where the other ACM defined values are at?

Nothing. We'd just need to figure out how best to name them if they're
going to become UAPI, that's all (e.g. at least use a USB_CDC_ prefix to
match the other defines).

And the in-tree users would need to be updated to match.

And it's not just the control lines. We have the state notification bits
as well. Someone would need to dig out the spec.

So we go from accepting a small clean-up patch to some non-trivial
tree-wide work and review. But sure, bring it on.

Johan
