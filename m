Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48D55A9C50
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbiIAP45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiIAP4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:56:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DEA8000D;
        Thu,  1 Sep 2022 08:56:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 196F861F31;
        Thu,  1 Sep 2022 15:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE578C433C1;
        Thu,  1 Sep 2022 15:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662047813;
        bh=PO3JHixyGeTvQB4eTxI5p4EHFoeyb/XZAm6c6Dd80j0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0T35UNSHQHSgOBUKHNO9VBJ4BCdHZK/qYKZOXB4euigOIxuLMeBeNeQXG2NnGbzPo
         69V1C046Lmbr9BIZXNGGWplxACTZMdvDQnBEiDj1VbhTjK3o3LwT80tPrdv0gf3cx1
         a0eUc2sOlFbPEW6WWLONFhW74FIq5wtbX/tYV468=
Date:   Thu, 1 Sep 2022 17:56:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vimal Kumar <vimal.kumar32@gmail.com>
Cc:     chinmoyghosh2001@gmail.com, Mintu Patel <mintupatel89@gmail.com>,
        Vishal Badole <badolevishal1116@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PM: runtime: Add support to disable wakeup sources
Message-ID: <YxDWQjMlEGQH4yz3@kroah.com>
References: <20220821134533.22901-1-vimal.kumar32@gmail.com>
 <YwI7PM9wVF/H9hQL@kroah.com>
 <20220827114028.GA258@DESKTOP-KA7F9LU.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220827114028.GA258@DESKTOP-KA7F9LU.localdomain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2022 at 05:10:28PM +0530, Vimal Kumar wrote:
> On Sun, Aug 21, 2022 at 04:03:40PM +0200, Greg KH wrote:
> > On Sun, Aug 21, 2022 at 07:15:32PM +0530, Vimal Kumar wrote:
> > > User could find many wakeup sources available in the bsp, which
> > > they won't be using. Currently users can only get the status and
> > > list of enabled wakeup sources, but users can't disable it runtime.
> > > It's very difficult to find the driver for each wakeup sources from
> > > where it's getting enabled and make the changes for disabling it.
> > > 
> > > This will help users to disable any wakeup sources at runtime,
> > > avoiding any code change and re-compilation. A new class attribute
> > > "disable_ws" will be added in the wakeup calss. If user want to disable
> > > any wakeup sources, user need to find the wakeup dev node associated
> > > with the particular wakeup source and write the devnode name to the
> > > class attribute "disable_ws".

What userspace tool will use this new interface?

Who is supposed to interact with it?  Why is this even needed?  Who
would disable this dynamically, shouldn't the kernel handle this all
automatically with no need for usersapce to get involved?

What is the root problem here you are trying to solve?

thanks,

greg k-h
