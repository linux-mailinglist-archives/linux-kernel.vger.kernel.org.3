Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B51526F30
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbiENFr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 01:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbiENFrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 01:47:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F51114C;
        Fri, 13 May 2022 22:47:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E561B81D4F;
        Sat, 14 May 2022 05:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F21C340EE;
        Sat, 14 May 2022 05:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652507240;
        bh=vf2oLc0MEqjD1BilnbgV6Jliq+/poCm2Ji1IcvG5qhI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TnBQ3gW3Mgy4xSLlzsQVY2FkVHtJnnEKuaXFFByUIkHP/U0KYDC3ezH/tkBPNSMBO
         BFBY23Gepo3P6EzjbmtkfdRwN2K0WI+iqfsrna0jSQNHaqca8aRP6WcRvgUPO1gr6B
         WRHWuZ6uq/ARgsBKCsKy8g4GnZ0dzbvypbowjpcM=
Date:   Sat, 14 May 2022 07:47:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] device property: Fix recent breakage of
 fwnode_get_next_parent_dev()
Message-ID: <Yn9CY99u4HkPGHDa@kroah.com>
References: <20220429164325.1.I2a3b980ea051e59140227999f0f0ca16f1125768@changeid>
 <CAHp75VdqbXCYoEwxMt7xG55QDu2mXHbnpwdnHb6ktm8NdVPJnQ@mail.gmail.com>
 <CAJZ5v0hKrnRznpTjTyb8ANGN=REaukAbqQNB_14i_NwAA84=uA@mail.gmail.com>
 <CAGETcx_9MNGBi1avOzYoOOaed0CVHa03dfTxYpQuOErtpiisLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx_9MNGBi1avOzYoOOaed0CVHa03dfTxYpQuOErtpiisLg@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 08:58:12PM -0700, Saravana Kannan wrote:
> On Thu, May 5, 2022 at 5:21 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Sun, May 1, 2022 at 9:50 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > >
> > > On Sat, Apr 30, 2022 at 3:00 PM Douglas Anderson <dianders@chromium.org> wrote:
> > > >
> > > > Due to a subtle typo, instead of commit 87ffea09470d ("device
> > > > property: Introduce fwnode_for_each_parent_node()") being a no-op
> > > > change, it ended up causing the display on my sc7180-trogdor-lazor
> > > > device from coming up unless I added "fw_devlink=off" to my kernel
> > > > command line. Fix the typo.
> > >
> > > Sorry and merci pour la fix!
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >
> > Applied, thanks!
> 
> Has this been picked up by one of the driver-core branches yet? I was
> poking around that
> git repo and didn't see any commit with this title. This breaks
> fw_devlink in a severe manner, so I want to make sure it gets into
> 5.18.

Look in linux-next:
	117ef574074d ("device property: Fix recent breakage of fwnode_get_next_parent_dev()")

Rafael's tree is not my tree :)

thanks,

greg k-h
