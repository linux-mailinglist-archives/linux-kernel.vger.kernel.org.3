Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203C957923C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 06:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbiGSEyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 00:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiGSEyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 00:54:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEADF3A4B2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 21:54:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76C93614DA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 04:54:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A456DC341C6;
        Tue, 19 Jul 2022 04:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658206446;
        bh=POBZ+V3s/+Alqu6QmjA0CCc+h9dtrLwxTS48V/98veA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EYgbuzBCpCycH4ZX55YSMhL2/1eSQzzOwtl9O7p+HsVRSVkxwUd2PwYI+s2iGEkoM
         Jliq/+h6e36gQbEz0d/sy1yoxv0U26GyI5AbHcI7MJ2QuqsATBGxZwFulgW3WbLBwN
         LNrxcn0XjM0Ds1wMhxfr4rlCzwkbgDWh+hoDHTsIsewEI3rv/1suhoaVfKK/VdKz0R
         Fk2mrNySVFuixG513EzCD51JSSQf0+Hm7G6DEyLwQuPsWbqu4DUkB4m0m/CGN7Nz+C
         O2cz5Lsst62Vtgj9irmUcGkNJCPAEr3kl3TTvSkNJqmhEH74njsa8fgBUWoyv9A8kL
         nvDYNmJQv8YlA==
Date:   Tue, 19 Jul 2022 04:54:03 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Guenter Roeck <groeck@google.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:CHROME HARDWARE PLATFORM SUPPORT" 
        <chrome-platform@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] platform/chrome: cros_kbd_led_backlight: fix build
 warning
Message-ID: <YtY460lI465ne00L@google.com>
References: <20220718105047.2356542-1-tzungbi@kernel.org>
 <CABXOdTdKpqsqajhQzQ1aEp6bsa96ONN6nz9EWZv6jGSuN0_LTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXOdTdKpqsqajhQzQ1aEp6bsa96ONN6nz9EWZv6jGSuN0_LTA@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 06:28:22AM -0700, Guenter Roeck wrote:
> On Mon, Jul 18, 2022 at 3:51 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> >
> > drivers/platform/chrome/cros_kbd_led_backlight.c got a new build warning
> > when using the randconfig in [1]:
> > >>> warning: unused variable 'keyboard_led_drvdata_ec_pwm'
> >
> > The warning happens when CONFIG_CROS_EC is set but CONFIG_OF is not set.
> > Reproduce:
> > - mkdir build_dir
> > - wget [1] -O build_dir/.config
> > - COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 \
> >   O=build_dir ARCH=s390 SHELL=/bin/bash drivers/platform/chrome/
> >
> > Fix the warning by using __maybe_unused.  Also use IS_ENABLED() because
> > CROS_EC is a tristate.
> 
> Is that sufficient ? What happens if CROS_KBD_LED_BACKLIGHT=y and
> CROS_EC=m ? I suspect you might need IS_REACHABLE() instead of
> IS_ENABLED().

For current code, it's impossible to set CROS_KBD_LED_BACKLIGHT=y and
CROS_EC=m without setting ACPI=y.  Given that the dependencies:
CHROME_PLATFORMS [=y] && LEDS_CLASS [=y] && (ACPI [=n] || CROS_EC [=m]).

$ ./scripts/kconfig/merge_config.sh -n <(cat <<EOF
CONFIG_MODULES=y

CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y

CONFIG_CHROME_PLATFORMS=y
CONFIG_CROS_EC=m
CONFIG_CROS_KBD_LED_BACKLIGHT=y
EOF
)
[...]
Value requested for CONFIG_CROS_KBD_LED_BACKLIGHT not in final .config
Requested value:  CONFIG_CROS_KBD_LED_BACKLIGHT=y
Actual value:     CONFIG_CROS_KBD_LED_BACKLIGHT=m


However, when ACPI=y, `keyboard_led_drvdata_ec_pwm` is unused.  Instead, it
uses `keyboard_led_drvdata_acpi` for current code.

I guess IS_ENABLED() is sufficient.  Does it make sense?
