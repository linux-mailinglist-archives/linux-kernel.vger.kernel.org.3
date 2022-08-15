Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FADB592E99
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 14:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbiHOMBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 08:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiHOMBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 08:01:47 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0959D22B3F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 05:01:43 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E338480FB;
        Mon, 15 Aug 2022 11:54:51 +0000 (UTC)
Date:   Mon, 15 Aug 2022 15:01:41 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: drivers/clocksource/timer-ti-dm.c:1039:34: warning:
 'omap_timer_match' defined but not used
Message-ID: <Yvo1pfzCVijXxTlu@atomide.com>
References: <202208150851.T0MUBaQR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202208150851.T0MUBaQR-lkp@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* kernel test robot <lkp@intel.com> [220815 00:34]:
> Hi Tony,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   568035b01cfb107af8d2e4bd2fb9aea22cf5b868
> commit: ab0bbef3ae0f6b5a3b60671cd0124d0fc4fc2567 clocksource/drivers/timer-ti-dm: Make timer selectable for ARCH_K3
> date:   3 weeks ago
> config: x86_64-buildonly-randconfig-r004-20220815 (https://download.01.org/0day-ci/archive/20220815/202208150851.T0MUBaQR-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ab0bbef3ae0f6b5a3b60671cd0124d0fc4fc2567
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout ab0bbef3ae0f6b5a3b60671cd0124d0fc4fc2567
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/clocksource/ drivers/soc/mediatek/ drivers/usb/misc/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/clocksource/timer-ti-dm.c:1039:34: warning: 'omap_timer_match' defined but not used [-Wunused-const-variable=]
>     1039 | static const struct of_device_id omap_timer_match[] = {
>          |                                  ^~~~~~~~~~~~~~~~

Seems this is best fixes with __maybe_unsued for omap_timer_match[], I'll
send a patch.

Regards,

Tony
