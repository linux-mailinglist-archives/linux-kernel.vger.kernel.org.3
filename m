Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4190851C6A2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382951AbiEESBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 14:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382941AbiEESBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:01:22 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E7611C36;
        Thu,  5 May 2022 10:57:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 416F7CE2F54;
        Thu,  5 May 2022 17:57:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39AD6C385A8;
        Thu,  5 May 2022 17:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651773458;
        bh=CXgvnZVu0rwEM0ACvUhkHVFy8LvlpA+vkKO1Hu87/OY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kqo51bgwhbaxDJ2jGEqRneRMCLEY6acJI2GErjjdVUF9aBaJxGCug2WFcGraBKuei
         Hsdr2h9XW580LBQ80eUepJUXEexRuaPRWiRbOqyHd9iZavkcQgnqfjSz52uIVmg11t
         rLJ7JVRCuXahgxMzyFsq8Pz9b/LZAoEvZGuZyVRs=
Date:   Thu, 5 May 2022 19:57:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Frank Wunderlich <linux@fw-web.de>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC v1] opp: add config option for debug
Message-ID: <YnQQEZ7eoa/ZbmEj@kroah.com>
References: <20220504174823.156709-1-linux@fw-web.de>
 <YnLEwEIOqnLGxFjJ@kroah.com>
 <E08A9747-2F96-42A7-A427-0E00D4075CF0@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E08A9747-2F96-42A7-A427-0E00D4075CF0@public-files.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 07:50:56PM +0200, Frank Wunderlich wrote:
> Hi,
> 
> Am 4. Mai 2022 20:24:00 MESZ schrieb Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> >On Wed, May 04, 2022 at 07:48:23PM +0200, Frank Wunderlich wrote:
> >> From: Frank Wunderlich <frank-w@public-files.de>
> >> 
> >> Currently OPP debug is enabled by DEBUG_DRIVER option. This is
> >generic
> >> driver debug and opp floods serial console. This is annoying if opp
> >is
> >> not needed so give it an additional config-key.
> >> 
> >> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> >> ---
> >>  drivers/base/Kconfig | 1 +
> >>  drivers/opp/Kconfig  | 7 +++++++
> >>  drivers/opp/Makefile | 2 +-
> >>  3 files changed, 9 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> >> index 6f04b831a5c0..8ae826c95d5f 100644
> >> --- a/drivers/base/Kconfig
> >> +++ b/drivers/base/Kconfig
> >> @@ -130,6 +130,7 @@ config DEV_COREDUMP
> >>  config DEBUG_DRIVER
> >>  	bool "Driver Core verbose debug messages"
> >>  	depends on DEBUG_KERNEL
> >> +	imply DEBUG_OPP
> >
> >This should not be needed, otherwise we would have to do that for all
> >random driver subsystem in the kernel.
> 
> Have added this to have same behaviour if anyone sets DEBUG_DRIVER via defconfig. Else this is disabled by default.
> 
> >>  	help
> >>  	  Say Y here if you want the Driver core to produce a bunch of
> >>  	  debug messages to the system log. Select this if you are having a
> >> diff --git a/drivers/opp/Kconfig b/drivers/opp/Kconfig
> >> index e8ce47b32735..6a2d2c6c1143 100644
> >> --- a/drivers/opp/Kconfig
> >> +++ b/drivers/opp/Kconfig
> >> @@ -12,3 +12,10 @@ config PM_OPP
> >>  	  representing individual voltage domains and provides SOC
> >>  	  implementations a ready to use framework to manage OPPs.
> >>  	  For more information, read <file:Documentation/power/opp.rst>
> >> +
> >> +menu "Operating Performance Points (OPP)"
> >> +config DEBUG_OPP
> >> +	bool "Debug Operating Performance Points"
> >> +	help
> >> +	  enable opp debugging
> >> +endmenu
> >> diff --git a/drivers/opp/Makefile b/drivers/opp/Makefile
> >> index f65ed5985bb4..2589915eef95 100644
> >> --- a/drivers/opp/Makefile
> >> +++ b/drivers/opp/Makefile
> >> @@ -1,5 +1,5 @@
> >>  # SPDX-License-Identifier: GPL-2.0-only
> >> -ccflags-$(CONFIG_DEBUG_DRIVER)	:= -DDEBUG
> >> +ccflags-$(CONFIG_DEBUG_OPP)	:= -DDEBUG
> >
> >This feels wrong, you shouldn't need a -DDEBUG for anything if all is
> >going correctly.  Why is opp so odd this way?  Just use the normal
> >dev_dbg() macros and all will be fine, nothing special should be needed
> >at all.
> 
> I have looked more into it,just wanted to get driver debug (probing/binding) and dev_dbg messages without the opp spam (floods serial console).
> 
> >And don't use a config option for it either, no one will turn it on, it
> >needs to "just work" for all systems.
> 
> Config option is to enable if needed and not via driver-debug.

Please do not do that, you should never need subsystem/driver Kconfig
options like this.  Distros will never enable them and you can't ask a
user to rebuild their kernel easily.  Just rely on the same
infrastructure like all other subsystems do please.

thanks,

greg k-h
