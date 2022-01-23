Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7A449709B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 09:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbiAWImv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 03:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235977AbiAWImu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 03:42:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839B0C06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 00:42:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 224DF60023
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 08:42:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828D3C340E2;
        Sun, 23 Jan 2022 08:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642927369;
        bh=p1YezHuKnp+Wn0QGyQfRK0Q8G9AqnjEjKZORFtbRB7A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xh/+9VWDk78WFxQHbXuWRNRfDH8OucSJFvxQZtp+Q5mKiRhIGX7HSxzQh4yqtV5fc
         DMYdVw8wzt9AM9jmhri1RFiIeQ4ISFw5TIzGq/ucku7OIR+Ua3AvrmCQbXqcBUjBLf
         OBbbztQuxUwoI2xKOrUOAtM2sZwb1PBUzMIEqUKimzuWeuGug75WjNOunRMEesMyVi
         fwoMpm4lrhB/chGw8sGt+BLSSRPSXyQjZQRrli7OFRpy9iupj2+T808W+CFqSIeFG6
         s5u/SYNsBoe6k/eIGv+23g7zzklAoUAXBiTww9BH6n9Oo6oNRa30b/xajtuIP0zu0q
         Vg4G4T1n+B1hA==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nBYSV-002BGf-Jj; Sun, 23 Jan 2022 08:42:47 +0000
MIME-Version: 1.0
Date:   Sun, 23 Jan 2022 08:42:47 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: ld.lld: error: undefined symbol: cpus_booted_once_mask
In-Reply-To: <202201230454.RAEWzGlV-lkp@intel.com>
References: <202201230454.RAEWzGlV-lkp@intel.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <2833d0cdeedecacd674d68493cbb10cb@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: lkp@intel.com, valentin.schneider@arm.com, llvm@lists.linux.dev, kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-22 21:52, kernel test robot wrote:
> tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> master
> head:   1c52283265a462a100ae63ddf58b4e5884acde86
> commit: 835f442fdbce33a47a6bde356643fd7e3ef7ec1b irqchip/gic-v3-its:
> Limit memreserve cpuhp state lifetime
> date:   5 weeks ago
> config: arm-randconfig-r035-20220122
> (https://download.01.org/0day-ci/archive/20220123/202201230454.RAEWzGlV-lkp@intel.com/config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project
> 7b3d30728816403d1fd73cc5082e9fb761262bce)
> reproduce (this is a W=1 build):
>         wget
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         #
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=835f442fdbce33a47a6bde356643fd7e3ef7ec1b
>         git remote add linus
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 835f442fdbce33a47a6bde356643fd7e3ef7ec1b
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1
> O=build_dir ARCH=arm SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> ld.lld: error: undefined symbol: cpus_booted_once_mask
>    >>> referenced by irq-gic-v3-its.c
>    >>>               irqchip/irq-gic-v3-its.o:(its_cpu_memreserve_lpi)
> in archive drivers/built-in.a

Fixed by [1], which is already queued.

         M.

[1] https://lore.kernel.org/r/20220122151614.133766-1-ardb@kernel.org
-- 
Jazz is not dead. It just smells funny...
