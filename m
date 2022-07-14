Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A5C574E75
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239583AbiGNM6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiGNM6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:58:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7C76528AC;
        Thu, 14 Jul 2022 05:58:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1739613D5;
        Thu, 14 Jul 2022 05:58:01 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.26.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BD193F73D;
        Thu, 14 Jul 2022 05:57:58 -0700 (PDT)
Date:   Thu, 14 Jul 2022 13:57:50 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: FVP: kernel BUG at arch/arm64/kernel/traps.c:497 - Internal
 error: Oops - BUG: 0
Message-ID: <YtASzuHo1MXe5LJH@FVFF77S0Q05N.cambridge.arm.com>
References: <CA+G9fYtOX-6=f70FA5PuDVA=kX=2L4spXKXS8=LHkUphafXowg@mail.gmail.com>
 <Ys1g8PH4M2W7Z50U@sirena.org.uk>
 <CA+G9fYu7mJ6X3_xhboODP_cjABE4QTJCON_NMduQ60x4Z7N78Q@mail.gmail.com>
 <Ys/9TSV5muvKXN6W@FVFF77S0Q05N>
 <YtABEDylGJkYLXrJ@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtABEDylGJkYLXrJ@sirena.org.uk>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 12:42:08PM +0100, Mark Brown wrote:
> On Thu, Jul 14, 2022 at 12:26:05PM +0100, Mark Rutland wrote:
> 
> > I note that your log has:
> 
> > | Hit any key to stop autoboot:  1  0 
> > | smh_open: ERROR fd -1 for file 'boot.img'
> > | smh_open: ERROR fd -1 for file 'Image'
> > | smh_open: ERROR fd -1 for file 'devtree.dtb'
> > | smh_open: ERROR fd -1 for file 'ramdisk.img'
> 
> ...
> 
> > | Hit any key to stop autoboot:  0   
> > | smh_open: ERROR fd -1 for file 'boot.img'
> > | loaded file Image from 80080000 to 82F299FF, 02EA9A00 bytes
> > | smh_open: ERROR fd -1 for file 'devtree.dtb'
> > | smh_open: ERROR fd -1 for file 'ramdisk.img'
> > | fdt - flattened device tree utility commands
> 
> > ... and I wonder if that has something to do with it, given it appears that
> > your Image is corrupted somehow.
> 
> Naresh's command line is putting Image directly into RAM with
> 
>     --data cluster0.cpu0=/tuxrun-r4_1075p-lava-1/Image@0x80080000

Likewise in mine:

	--data cluster0.cpu0=/mnt/data/models/fvp/naresh/Image@0x80080000

... as I'm using the same command line, just with paths altered.

Mark.
