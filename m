Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D7E4AC6D9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 18:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383216AbiBGRJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 12:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243051AbiBGQ62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:58:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8780EC0401D1;
        Mon,  7 Feb 2022 08:58:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DEBBB8162C;
        Mon,  7 Feb 2022 16:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F76C340ED;
        Mon,  7 Feb 2022 16:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644253104;
        bh=ZRdo6pBuuxa9P8yx75CNgVwMKpdNus9AHcHyaeZxi2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TO/pPYnITsm40qUyQa01pmiLC4AM9DO/KHFFHqqNouR/edaEcAn9V3UTSHFLAC2wd
         yQ5EiIbU+xeCnykFGZMS9l1AKk5zpwCtdLnJ3KmjVC3YMwkS4Z8lHwB3Fh2JL8FAj7
         qg18M9GWMycYeIIJ5LxlNSxcrWB9eS+jc9dsCgNnjdRADFvOnMGZ33ShfHiPji2VjI
         zPDmUojdDSya+fnUiJ+AQDVWS4EQTdLx1hWHXjEWBU015y91aemghOvJRrD4I8DuPY
         aiwIOmKM1OdgSR8tKdpmSsG5yIFqqNHnJXo6OS8Kul5vdCWa8o5zCPreMrvW8RIU1B
         cQlONZQy3JGYw==
Date:   Mon, 7 Feb 2022 09:58:20 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] thermal: netlink: Fix parameter type of
 thermal_genl_cpu_capability_event() stub
Message-ID: <YgFPrElA4O9P6U/l@dev-arch.archlinux-ax161>
References: <20220207163829.1025904-1-nathan@kernel.org>
 <0d11f34a98e720cb5cf0d37e67a3e130d8275e31.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d11f34a98e720cb5cf0d37e67a3e130d8275e31.camel@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 08:54:41AM -0800, srinivas pandruvada wrote:
> On Mon, 2022-02-07 at 09:38 -0700, Nathan Chancellor wrote:
> > When building with CONFIG_THERMAL_NETLINK=n, there is a spew of
> > warnings
> > along the lines of:
> > 
> >   In file included from drivers/thermal/thermal_core.c:27:
> >   In file included from drivers/thermal/thermal_core.h:15:
> >   drivers/thermal/thermal_netlink.h:113:71: warning: declaration of
> > 'struct cpu_capability' will not be visible outside of this function
> > [-Wvisibility]
> >   static inline int thermal_genl_cpu_capability_event(int count,
> > struct cpu_capability *caps)
> >                                                                      
> >    ^
> >   1 warning generated.
> > 
> > 'struct cpu_capability' is not forward declared anywhere in the
> > header.
> > As it turns out, this should really be 'struct
> > thermal_genl_cpu_caps',
> > which silences the warning and makes the parameter types of the stub
> > match the full function.
> Thanks for sending the patch. I was about to send this change.
> Since this patch target only linux-next, don't we need prefix:
> "[PATCH -next]" instead of "[PATCH]"?

I could probably get better about adding "-next" to the subject prefix
to make it easier for maintainers but I do include the commit that the
patch was based on at the bottom of the patch to accomplish the same
thing.

Thank you for the review!

Cheers,
Nathan

> > 
> > Fixes: e4b1eb24ce5a ("thermal: netlink: Add a new event to notify CPU
> > capabilities change")
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 
> > ---
> >  drivers/thermal/thermal_netlink.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/thermal/thermal_netlink.h
> > b/drivers/thermal/thermal_netlink.h
> > index 04d1adbbc012..1052f523188d 100644
> > --- a/drivers/thermal/thermal_netlink.h
> > +++ b/drivers/thermal/thermal_netlink.h
> > @@ -110,7 +110,7 @@ static inline int thermal_genl_sampling_temp(int
> > id, int temp)
> >         return 0;
> >  }
> >  
> > -static inline int thermal_genl_cpu_capability_event(int count,
> > struct cpu_capability *caps)
> > +static inline int thermal_genl_cpu_capability_event(int count,
> > struct thermal_genl_cpu_caps *caps)
> >  {
> >         return 0;
> >  }
> > 
> > base-commit: 08615cb8c0e1deeca5489d672213fb205fa53c3b
> 
