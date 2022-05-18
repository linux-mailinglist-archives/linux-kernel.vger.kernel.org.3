Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EFA52B338
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiERHTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiERHTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:19:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29441116D7;
        Wed, 18 May 2022 00:19:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32053612B7;
        Wed, 18 May 2022 07:19:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667EAC385AA;
        Wed, 18 May 2022 07:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652858348;
        bh=UXWz6D3Zwmn9H6FOYGxCt9ZshmaaEUHF1r8ufbfHFmM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FY69pe6QTiP3ifpkkLUY1UXmEMze6rlhPtyljVRTXLKJGOdTDeCXIVboNHgmUyUVr
         cyuHxNJryle2KK1G/6XBkY7wW7JsI32SJyoIgNhhVzLETyWdyf9NizTi9dFe7I/kBf
         a8N50aaaqVSxvFZMeQV3kDOo7vhSC279ZuqQJQ7hKNRvqFFQHqOMVtXn/ox61tLedT
         0WEqJ3ewLfrnLHTm8lD31rfj6ZsiGLhvo38o2cPp/pD/fOeAIDXsjsN+hWVrclXxFd
         ZGQwJyN6w+C0NTGewwXDYUoiWHjpLyD5YWpCPnphpegrg6IheF68c5Vjl8r4cXDm/1
         JffpS2BmJZRGA==
Date:   Wed, 18 May 2022 15:19:04 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-doc@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Benson Leung <bleung@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH 1/2] platform/chrome: Use tables for values lists of
 ChromeOS ACPI sysfs ABI
Message-ID: <YoSd6NQBvX41y7Fb@google.com>
References: <20220518031750.21923-1-bagasdotme@gmail.com>
 <20220518031750.21923-2-bagasdotme@gmail.com>
 <YoRp/49OA9tqMd9N@google.com>
 <2816e961-08f9-407b-e8f8-b63f844d864c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2816e961-08f9-407b-e8f8-b63f844d864c@gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 01:50:26PM +0700, Bagas Sanjaya wrote:
> On 5/18/22 10:37, Tzung-Bi Shih wrote:
> > On Wed, May 18, 2022 at 10:17:50AM +0700, Bagas Sanjaya wrote:
> >>  What:		/sys/bus/platform/devices/GGL0001:*/CHSW
> >>  Date:		May 2022
> >>  KernelVersion:	5.19
> >>  Description:
> >>  		This file shows the switch position for the Chrome OS specific
> >> -		hardware switches.
> >> -		  * 0   - No changes.
> >> -		  * 2   - Recovery button was pressed when firmware booted.
> >> -		  * 4   - Recovery button was pressed when EC firmware booted.
> >> -		  * 32  - Developer switch was enabled when firmware booted.
> >> -		  * 512 - Firmware write protection was disabled when firmware
> >> -			  booted.
> >> +		hardware switches when the firmare is booted.
> > 
> > s/firmare/firmware/.
> > 
> > Could you fix it in v2 and also Cc to <chrome-platform@lists.linux.dev>?
> 
> OK, but regarding the schedule, we are on -rc7 (official mainline release
> will be imminent). Maybe I can send the v2 immediately, or should I wait
> for a day?

I think either way is fine.  The patch introduced the sphinx warning is still
in chrome-platform's for-next branch[1].  And it should send to mainline when 
the next merge window opens.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git/commit/?h=for-next&id=0a4cad9c11ad46662ede48d94f08ecb7cd9f6916
