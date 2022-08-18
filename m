Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F280D5986BA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343954AbiHRPBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343943AbiHRPAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:00:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFFB32BA4;
        Thu, 18 Aug 2022 08:00:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D302B821CE;
        Thu, 18 Aug 2022 15:00:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E77C433D7;
        Thu, 18 Aug 2022 15:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660834846;
        bh=w6/ETLvl6ZG2+0UlR1OeUzSwR5sjy2rVzbgpetE7Jao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jyemUVkbI7r0kIO7aSwt8dj+8DwO9ot3ryBxDCUv3IuhyBu7QbX65Dj2DoBUJ1aRA
         IfTgDRH5H5dfm0lkURf6lstrZgWK2sl1EOE9JhkVrS5pkqvYeaNAjcc/Bnorgjord9
         ZMme4Z1TfbRACGT2vZdJ12ucPykQdtRzPaslvb/c=
Date:   Thu, 18 Aug 2022 17:00:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 0/9] fw_devlink improvements
Message-ID: <Yv5UHLOk9jh8KB6c@kroah.com>
References: <20220810060040.321697-1-saravanak@google.com>
 <YvYiF36M09dX9ASm@atomide.com>
 <CAGETcx-t0O0B+5i0FWwm5w2=ccOD5zVAaUvgQoP8PT9SOT_btw@mail.gmail.com>
 <Yvog4K0barAvvVeb@atomide.com>
 <CAGETcx-k+ca5uG42XvW5yiK8RWDYfeRs9va5boqnp33s45AGRg@mail.gmail.com>
 <Yv3kqoMo3R/7onlw@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv3kqoMo3R/7onlw@atomide.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 10:05:14AM +0300, Tony Lindgren wrote:
> Hi,
> 
> * Saravana Kannan <saravanak@google.com> [220815 18:16]:
> > On Mon, Aug 15, 2022 at 3:33 AM Tony Lindgren <tony@atomide.com> wrote:
> > >
> > > * Saravana Kannan <saravanak@google.com> [220813 00:45]:
> > > > On Fri, Aug 12, 2022 at 2:49 AM Tony Lindgren <tony@atomide.com> wrote:
> > > > >
> > > > > * Saravana Kannan <saravanak@google.com> [220810 05:54]:
> > > > > > Tony,
> > > > > >
> > > > > > This should handle the odd case of the child being the supplier of the
> > > > > > parent. Can you please give this a shot? I want to make sure the cycle
> > > > > > detection code handles this properly and treats it like it's NOT a cycle.
> > > > >
> > > > > Yup, this series works for me, so feel free to add:
> > > > >
> > > > > Tested-by: Tony Lindgren <tony@atomide.com>
> > > >
> > > > Thanks for testing!
> > > >
> > > > Btw, out of curiosity, how many different boards did you test this on?
> > > > IIRC you had an issue only in one board, right? Not to say I didn't
> > > > break anything else, I'm just trying to see how much confidence we
> > > > have on this series so far. I'm hoping the rest of the folks I listed
> > > > in the email will get around to testing this series.
> > >
> > > Sorry if I was not clear earlier. The issue affects several generations
> > > of TI 32-bit SoCs at least, not just one board.
> > 
> > But this series fixes the issues for all of them or are you still
> > seeing some broken boot with this series?
> 
> Yes. However, I'm now getting confused what exactly you're proposing to fix
> the regressions for v6.0-rc series.

So am I :(

> I'd like to see just the fixes series for v6.0-rc series. With proper fixes
> tags, and possibly reverts.

Agreed, that would help out a lot here.

> Then discussing patches for Linux next can be done based on the fixes :)

Agreed.

I'll drop this whole series from my queue now and wait for a new one.

thanks,

greg k-h
