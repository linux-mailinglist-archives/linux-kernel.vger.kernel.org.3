Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81C94AD763
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245719AbiBHLdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356822AbiBHLIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:08:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B95BC03FEC0;
        Tue,  8 Feb 2022 03:08:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4D4561583;
        Tue,  8 Feb 2022 11:08:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556ACC004E1;
        Tue,  8 Feb 2022 11:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644318489;
        bh=qu25s2pI0bef9usPCks0SF20/3lcuZT4+ajSE0ondkM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=arp1QXgJJRaO2ZgwEBCS04YXmhnkX1AoGwN+4Tef0YqIynclXCGBiDrpdd4BdIWaj
         PbQLX9uUhQ4ue0sJOaRlbObuQi9wsuUf9ZHPoiyAR2anjm1+9fWCPYaLs9QChXea+a
         qFd9pTBvdmy4LuNlg+WxYMkSefPhAXBTpmkDc8y0=
Date:   Tue, 8 Feb 2022 12:08:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Iwona Winiarska <iwona.winiarska@intel.com>
Cc:     linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Borislav Petkov <bp@alien8.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zev Weiss <zweiss@equinix.com>,
        David Muller <d.mueller@elsoft.ch>,
        Dave Hansen <dave.hansen@intel.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>
Subject: Re: [PATCH v7 07/13] peci: Add sysfs interface for PECI bus
Message-ID: <YgJPFlr18AmWiTRY@kroah.com>
References: <20220202144838.163875-1-iwona.winiarska@intel.com>
 <20220202144838.163875-8-iwona.winiarska@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202144838.163875-8-iwona.winiarska@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 03:48:32PM +0100, Iwona Winiarska wrote:
> PECI devices may not be discoverable at the time when PECI controller is
> being added (e.g. BMC can boot up when the Host system is still in S5).
> Since we currently don't have the capabilities to figure out the Host
> system state inside the PECI subsystem itself, we have to rely on
> userspace to do it for us.
> 
> In the future, PECI subsystem may be expanded with mechanisms that allow
> us to avoid depending on userspace interaction (e.g. CPU presence could
> be detected using GPIO, and the information on whether it's discoverable
> could be obtained over IPMI).
> Unfortunately, those methods may ultimately not be available (support
> will vary from platform to platform), which means that we still need
> platform independent method triggered by userspace.
> 
> Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-peci | 16 +++++
>  drivers/peci/Makefile                    |  2 +-
>  drivers/peci/core.c                      |  3 +-
>  drivers/peci/device.c                    |  1 +
>  drivers/peci/internal.h                  |  5 ++
>  drivers/peci/sysfs.c                     | 82 ++++++++++++++++++++++++
>  6 files changed, 107 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-peci
>  create mode 100644 drivers/peci/sysfs.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-peci b/Documentation/ABI/testing/sysfs-bus-peci
> new file mode 100644
> index 000000000000..56c2b2216bbd
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-peci
> @@ -0,0 +1,16 @@
> +What:		/sys/bus/peci/rescan
> +Date:		July 2021
> +KernelVersion:	5.15

5.15 was a long time ago :(


Other than this nit, these all look semi-sane to me.  What tree are you
wanting these to go through, mine?  If so, can you fix this up (both
places in this file) and resend?

thanks,

greg k-h
