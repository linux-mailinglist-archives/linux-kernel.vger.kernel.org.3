Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDB35572B4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 07:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiFWFxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 01:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiFWFxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 01:53:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702D4289A8;
        Wed, 22 Jun 2022 22:53:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 321ABB81C06;
        Thu, 23 Jun 2022 05:53:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED570C3411B;
        Thu, 23 Jun 2022 05:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655963596;
        bh=+dwqV4PAgK5J2lEv4HZ59RAQhecD1+pVhEDVmu51YPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ofxAoRknTRV81Hfq2JfL9mzab2Q4CVeLOj253hcI2LTzLfm3lq4y7nEQ4bkcSfTD7
         Pzfkt8QiufuOmMOoFkpEv6hd/z9zI1qTn0mGHp+9ZftXav0zVKNw5VDA8jsa6vaQoQ
         Hus9Wp9N5kTjCHI5VCBpwe+rRSlNYwAZS1PRAMQX4bh0bcKFGYHH662aS0YUsa+crV
         u0TOGCgozKWv5woTJuVop1Fpko/7OTOkO66y0kCLcw83VSOGUbYGZSAWOWRi0/Kt3S
         o88NanLB85dmnFDzHrokj69DJ/WHq8Rp9Z+wrFNx6PQmPFJtdGB6q9K3qztMrTvX28
         ZyG4SGwChCqmA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o4FmC-0001J3-E3; Thu, 23 Jun 2022 07:53:12 +0200
Date:   Thu, 23 Jun 2022 07:53:12 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Input: usbtouchscreen - suppress empty array warnings
Message-ID: <YrP/yOkM0q877HGu@hovoldconsulting.com>
References: <20220620084628.20894-1-johan@kernel.org>
 <20220620084628.20894-2-johan@kernel.org>
 <YrOkIMJK3G3VkhLk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrOkIMJK3G3VkhLk@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 04:22:08PM -0700, Dmitry Torokhov wrote:
> Hi Johan,
> 
> On Mon, Jun 20, 2022 at 10:46:27AM +0200, Johan Hovold wrote:
> > When compile-testing the USB touchscreen driver without enabling any of
> > the device type options the usbtouch_dev_info array ends up being empty,
> > something which triggers compiler warning with -Warray-bounds
> > (gcc-11.3.0).
> > 
> > drivers/input/touchscreen/usbtouchscreen.c: In function 'usbtouch_probe':
> > drivers/input/touchscreen/usbtouchscreen.c:1668:16:warning: array subscript <unknown> is outside array bounds of 'struct usbtouch_device_info[0]' [-Warray-bounds]
> >  1668 |         type = &usbtouch_dev_info[id->driver_info];
> > 
> > Suppress the warnings by making sure that the array is always non-empty.
> 
> Does it still warn if you add a check for type, something like
> 
> 	if (type >= ARRAY_SIZE(usbtouch_device_info))
> 		return -ENODEV;
> 
> ?

It seems 

	if (id->driver_info >= ARRAY_SIZE(usbtouch_dev_info))
                return -ENODEV;

indeed does the trick. I'll send a v2.

Johan
