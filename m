Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76A657801A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 12:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbiGRKsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 06:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbiGRKsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 06:48:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B40A1CB24
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 03:48:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26D3FB8107E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 10:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD243C341C0;
        Mon, 18 Jul 2022 10:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658141294;
        bh=JAyGeINuZXCg47n62w2E/ixYwa1Du2XE/Y1lWIoSMdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rW0/T4C6bZMKvYq43tVe+QU8x4NRLisHaxlfXXShlGDeEIGVVBk2C9gkENolyJE3x
         ny1EttvNgNb4PgvIymkjkAWl6IcIgndnfFLJnaX9eJFNI5zl47QBo2c7ByJPoobTiX
         lhA61sVJBVTaxHMuT11ZJCdCwr91ysfSQzJU7wQ40SrZaWPtKCU5l6GznQnZ0s8VJd
         JWhHLqq5XslVJd6Yww7/lrBF+Actmd3Rf5QuLjT0RuNbWHbdYFF9GWpRysSXqNyGEQ
         T+ZjULCo7+XoWM3ze1rElnBtDFWrVRRmxakjthoT/8q7oSDY1OoY3s8GjVUKVAv8tP
         /7e1Ahui+YoFA==
Date:   Mon, 18 Jul 2022 10:48:11 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Guenter Roeck <groeck@google.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:CHROME HARDWARE PLATFORM SUPPORT" 
        <chrome-platform@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] platform/chrome: cros_kbd_led_backlight: fix build
 warning
Message-ID: <YtU6a+bIpgpyScsL@google.com>
References: <20220718061608.2303425-1-tzungbi@kernel.org>
 <CABXOdTeH-q=17QBnCn5NGT5V0QA5SOaTnrWaK+g5F3j4mVp8cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXOdTeH-q=17QBnCn5NGT5V0QA5SOaTnrWaK+g5F3j4mVp8cA@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2022 at 11:54:31PM -0700, Guenter Roeck wrote:
> On Sun, Jul 17, 2022 at 11:16 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
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
> 
> Have you tried the following ?
>     CONFIG_ACPI=y
>     CONFIG_CROS_EC=n
>     CONFIG_OF=y
> 
> That should be possible, but with your patch it should now result in a
> build error because keyboard_led_drvdata_ec_pwm is no longer defined.

Hmm, just got another lkp robot's warning about the undeclared symbol.  Will
fix it by using __maybe_unused in next version.

> Also, with your patch, CONFIG_CROS_EC=y, CONFIG_ACPI=y, and
> CONFIG_OF=n (ie Intel/AMD systems) would result in the code not being
> compiled, which would be wrong.

Intel and AMD systems rely on `keyboard_led_drvdata_acpi` but not
`keyboard_led_drvdata_ec_pwm` for now.  They shouldn't be affected by the
patch.

In any cases, let's use __maybe_unused in next version.
