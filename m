Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0295951C664
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345063AbiEERpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382810AbiEERny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:43:54 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C885D643;
        Thu,  5 May 2022 10:40:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E52BACE2F17;
        Thu,  5 May 2022 17:40:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B9FC385AE;
        Thu,  5 May 2022 17:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651772402;
        bh=LadALzBO76IZIhY8zk7doDAmtjAq+INNAF1NnnHxrUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sLInGr2tnnXgxO0ZV1wLnKBiMXljVidKippK7tkX/zrESqFVJoJrClIjABzah4W4x
         6gk6Vwq/4H24PlAitI9jgsfJP0Xmz9QVv5maunm9tFX4ysmjxLZSnqWBTnbcbH7WI3
         VOLyqDWhObxI9s5nHH0Bhx6JEHzL0hT2yg4pubIw=
Date:   Thu, 5 May 2022 19:38:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Frank Wunderlich <linux@fw-web.de>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: Aw: Re: [RFC v1] opp: add config option for debug
Message-ID: <YnQLkBwMyIDdjbL0@kroah.com>
References: <20220504174823.156709-1-linux@fw-web.de>
 <20220505055857.bqjm72qkzwcbuvuh@vireshk-i7>
 <trinity-6a6249b9-69eb-459c-96f1-dbf8f031a86f-1651766058085@3c-app-gmx-bs47>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-6a6249b9-69eb-459c-96f1-dbf8f031a86f-1651766058085@3c-app-gmx-bs47>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 05:54:18PM +0200, Frank Wunderlich wrote:
> Hi,
> 
> > Gesendet: Donnerstag, 05. Mai 2022 um 07:58 Uhr
> > Von: "Viresh Kumar" <viresh.kumar@linaro.org>
> > An: "Frank Wunderlich" <linux@fw-web.de>
> > Cc: linux-pm@vger.kernel.org, "Frank Wunderlich" <frank-w@public-files.de>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Viresh Kumar" <vireshk@kernel.org>, "Nishanth Menon" <nm@ti.com>, "Stephen Boyd" <sboyd@kernel.org>, linux-kernel@vger.kernel.org
> > Betreff: Re: [RFC v1] opp: add config option for debug
> >
> > On 04-05-22, 19:48, Frank Wunderlich wrote:
> > > From: Frank Wunderlich <frank-w@public-files.de>
> > >
> > > Currently OPP debug is enabled by DEBUG_DRIVER option. This is generic
> > > driver debug and opp floods serial console. This is annoying if opp is
> > > not needed so give it an additional config-key.
> > >
> > > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > > ---
> > >  drivers/base/Kconfig | 1 +
> > >  drivers/opp/Kconfig  | 7 +++++++
> > >  drivers/opp/Makefile | 2 +-
> > >  3 files changed, 9 insertions(+), 1 deletion(-)
> >
> > Isn't something like Dynamic Debug helpful here ?
> 
> you mean something like this:
> 
> https://www.kernel.org/doc/html/v5.17/admin-guide/dynamic-debug-howto.html#debug-messages-during-boot-process
> 
> so enabling debug only with cmdline-param...
> 
> have you a simple example how to implement it? have not done anything with dynamic-debug yet...seems mighty but not trivial to implement.
> 
> currently dev_dbg() is used for the messages that i try to disable...but show others from driver_debug at debug level.
> 
> What needs to be changed to filter it via DYNAMIC_DEBUG?
> 
> found this, but i'm not sure if i interpret it the right way...
> 
> https://elixir.bootlin.com/linux/v5.18-rc5/source/drivers/acpi/utils.c#L495
> defines __acpi_handle_debug
> called via acpi_handle_debug macro
> https://elixir.bootlin.com/linux/v5.18-rc5/source/include/linux/acpi.h#L1136
> 
> so basicly convert dev_dbg to __dynamic_pr_debug

Ick, no, just stick with all dev_dbg() calls and do not add any Makefile
changes and all should be fine.  And drop the Kconfig option, should not
be needed for a subsystem/driver at all.

thanks,

greg k-h
