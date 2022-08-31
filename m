Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F165A7BC5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 12:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiHaKzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 06:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiHaKzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:55:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E594819298
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 03:55:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8826AB82000
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:55:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F13AC433D6;
        Wed, 31 Aug 2022 10:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661943307;
        bh=mQ+vP0khgVt2cfBh+0A4KU46mUN0VhCpiZcKn24psr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n+pf2gGfnlfjeX1xE4Z08fviRhtoHn0NMu+d52yBD9j1hKTvFV+Jjno1+0d2say1L
         oQK9ewUnXBdZIPixw1BDbJsdhPZK9bFtPixuuqvQDFpdx/1yDacTZ9EXWdnqpMrl43
         Ls4mo+6RTP141ikxL/aT6EMCX13Ogff3VAWZ3ZKpNzm9EjHR2y2TP5PLBdhFxQKk+K
         NYGhGhDaj65AHOVivbnRTEfu+1zG/k4E/kKDJKUzn0FjgRmPT8yOtZIllRLyT8PHtA
         oa/ykLTbC7FwuoTug/wiG45hyuNRUIAtml2itIoxwSWfdeukLAaBH311yYjEYtTmQW
         Ah8qq3fYUzCmQ==
Date:   Wed, 31 Aug 2022 13:54:45 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Wang Kefeng <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        Victor Hassan <victor@allwinnertech.com>
Subject: Re: arch/arm/mm/init.o: in function `arm_memblock_init':
 init.c:(.init.text+0xc8): undefined reference to `phys_initrd_start'
Message-ID: <Yw899e/S6wuo4EX6@kernel.org>
References: <CA+G9fYt6831htScyAHTk9w1PMLU-kLPvQRqJt73t9=NHLM5qOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYt6831htScyAHTk9w1PMLU-kLPvQRqJt73t9=NHLM5qOA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 02:26:36PM +0530, Naresh Kamboju wrote:
> The following arm builds failed on Linux next-20220831.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Regressions found on arm:
>    - build-clang-14-allnoconfig
>    - build-gcc-11-tinyconfig
>    - build-clang-11-tinyconfig
>    - build-gcc-9-tinyconfig
>    - build-gcc-11-orion5x_defconfig
>    - build-gcc-10-allnoconfig
>    - build-clang-nightly-orion5x_defconfig
>    - build-gcc-8-orion5x_defconfig
>    - build-clang-11-allnoconfig
>    - build-gcc-8-tinyconfig
>    - build-clang-11-orion5x_defconfig
>    - build-clang-nightly-tinyconfig
>    - build-clang-13-allnoconfig
>    - build-gcc-9-allnoconfig
>    - build-clang-13-tinyconfig
>    - build-clang-14-orion5x_defconfig
>    - build-clang-13-orion5x_defconfig
>    - build-clang-14-tinyconfig
>    - build-gcc-8-allnoconfig
>    - build-gcc-9-orion5x_defconfig
>    - build-clang-12-tinyconfig
>    - build-clang-nightly-allnoconfig
>    - build-gcc-10-orion5x_defconfig
>    - build-clang-12-orion5x_defconfig
>    - build-gcc-10-tinyconfig
>    - build-clang-12-allnoconfig
>    - build-gcc-11-allnoconfig
>    
> Build error:
> ------------
> arm-linux-gnueabihf-ld: arch/arm/mm/init.o: in function `arm_memblock_init':
> init.c:(.init.text+0xc8): undefined reference to `phys_initrd_start'
> make[1]: *** [/builds/linux/Makefile:1250: vmlinux] Error 1

Looks like this is because of 
Fixes: b35b2736b43d ("ARM: 9230/1: Support initrd with address in boot alias region")
that uses phys_initrd_start regardless of CONFIG_BLK_DEV_INITRD
 
> Build log link:
> https://builds.tuxbuild.com/2E6pMzczzw7tLMxz7WFjaPgQ9Io/
> 
> Steps to reproduce:
> -------------------
> # To install tuxmake on your system globally:
> # sudo pip3 install -U tuxmake
> 
> tuxmake --runtime podman --target-arch arm --toolchain gcc-11 --kconfig
> tinyconfig
> 
> --
> Linaro LKFT
> https://lkft.linaro.org

-- 
Sincerely yours,
Mike.
