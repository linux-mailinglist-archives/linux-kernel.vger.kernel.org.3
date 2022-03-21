Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360C74E2123
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 08:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344805AbiCUHTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 03:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344804AbiCUHTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 03:19:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9996E1CFD4;
        Mon, 21 Mar 2022 00:18:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3509460F99;
        Mon, 21 Mar 2022 07:18:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D5BC340E8;
        Mon, 21 Mar 2022 07:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647847102;
        bh=Pwp6sQixtqzl3bOa6QAUaAOxQIEUFhK8JMtjcBpVpDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ObaljEBIIt36s6lvN7hITTGlBx6XdVdueWqQ1pdTDqhtiBnreYLviOEp7OAZsyeuQ
         p5I/Gt9Ee38ymaoYIPT1SaoO2+f1TBcAy9SFKBxaDs5PrmZ8uAi1OW4zZHebbQmXrs
         CdDiJ1bj3ebW6LVPHL90zh2xEnG41SIGhhKbrIbI8TJ/zzDfkP8Zy4oa9OPdw0qKeg
         HO8SgYBTrxTc8iz9ABjAwZYZr5aHgQuK2fS55/qtO6/cw2nKoK4+r6RoptXY47pNLa
         TjXSxXGHdqvOJAwikDYoOgWFvh3LYXn/wvbU3BV5AOf6gq+634JGBh5M/1fSkZtCi/
         8yS4Y8VeDtDNg==
Date:   Mon, 21 Mar 2022 15:18:18 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     bleung@chromium.org, groeck@chromium.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] platform/chrome: cros_kbd_led_backlight: support
 EC PWM backend
Message-ID: <Yjgmut/HndnYsPVE@google.com>
References: <20220314090835.3822093-1-tzungbi@kernel.org>
 <20220314090835.3822093-6-tzungbi@kernel.org>
 <20220318170751.GA687500@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318170751.GA687500@roeck-us.net>
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 10:07:51AM -0700, Guenter Roeck wrote:
> On Mon, Mar 14, 2022 at 05:08:35PM +0800, Tzung-Bi Shih wrote:
> > @@ -142,6 +142,12 @@ config CROS_KBD_LED_BACKLIGHT_ACPI
> >  	help
> >  	  ChromeOS keyboard backlight ACPI backend.
> >  
> > +config CROS_KBD_LED_BACKLIGHT_EC_PWM
> > +	tristate "ChromeOS keyboard backlight EC PWM backend"
> 
> This is not a standa-alone module and should therefore be bool,
> not tristate.

Ack.

> > @@ -123,34 +130,122 @@ static const struct keyboard_led_drvdata keyboard_led_drvdata_acpi = {
> >  
> >  #endif /* IS_ENABLED(CONFIG_CROS_KBD_LED_BACKLIGHT_ACPI) */
> >  
> > +#if IS_ENABLED(CONFIG_CROS_KBD_LED_BACKLIGHT_EC_PWM)
> 
> #ifdef (with bool) should do.

Ack.  Will apply the fix for CONFIG_CROS_KBD_LED_BACKLIGHT_ACPI too.
