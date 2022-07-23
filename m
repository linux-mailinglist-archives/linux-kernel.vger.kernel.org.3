Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3335357EFF1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 17:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237643AbiGWPHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 11:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGWPHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 11:07:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791BD1A384
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 08:07:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3AEC6B8092F
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 15:07:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3318C341C0;
        Sat, 23 Jul 2022 15:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658588826;
        bh=+HKETJLMc2Xs1ShPWHPMXXwggUWe6CW4WtH9rX12gFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N75JiJtW0olAck1Ym3J8gBBKGDY9XEmjFycztcvGjja28NIlXgJcGa9g5gip3ttjh
         wiCzN3CHZjVEnEF9LBuI+upg7zWuIpvJ/ViJJTwXE5sHao5O+TuiLItTLz4LbPdzpJ
         uLBz4ZhzS1JM152be0xZxOg3M4A330eYnhpsrGnfcv21HgNjjgEwbcd8E9Jdc1BT8I
         DRZzz65T9k1DhLoL7SA/yjX3pvpBPtwG7c74OAbKcBXRqoO81Bz9d88ZTE+qHVMHof
         1iQlNwGyu25JEoOGgFr8jLLIyzVyYau88yf3w8+8YaPYOfpmiPGGqscvOF9Fc7lrsB
         q5wCHZ7u8NCkw==
Received: by pali.im (Postfix)
        id E5105CDA; Sat, 23 Jul 2022 17:07:02 +0200 (CEST)
Date:   Sat, 23 Jul 2022 17:07:02 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Regression: Linux v5.15+ does not boot on Freescale P2020
Message-ID: <20220723150702.jecerkhxhy65dgww@pali>
References: <20220722090929.mwhmxxdd7yioxqpz@pali>
 <6b227478-73b8-2a97-1c78-89570d928739@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b227478-73b8-2a97-1c78-89570d928739@csgroup.eu>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Saturday 23 July 2022 14:42:22 Christophe Leroy wrote:
> Hello,
> 
> Le 22/07/2022 à 11:09, Pali Rohár a écrit :
> > Hello!
> > 
> > Trying to boot mainline Linux kernel v5.15+, including current version
> > from master branch, on Freescale P2020 does not work. Kernel does not
> > print anything to serial console, seems that it does not work and after
> > timeout watchdog reset the board.
> 
> Can you provide more information ? Which defconfig or .config, which 
> version of gcc, etc ... ?

I used default defconfig for mpc85xx with gcc 8, compilation for e500
cores.

If you need exact .config content I can send it during week.

> > 
> > I run git bisect and it found following commit:
> > 
> > 9401f4e46cf6965e23738f70e149172344a01eef is the first bad commit
> > commit 9401f4e46cf6965e23738f70e149172344a01eef
> > Author: Christophe Leroy <christophe.leroy@csgroup.eu>
> > Date:   Tue Mar 2 08:48:11 2021 +0000
> > 
> >      powerpc: Use lwarx/ldarx directly instead of PPC_LWARX/LDARX macros
> > 
> >      Force the eh flag at 0 on PPC32.
> > 
> >      Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> >      Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> >      Link: https://lore.kernel.org/r/1fc81f07cabebb875b963e295408cc3dd38c8d85.1614674882.git.christophe.leroy@csgroup.eu
> > 
> > :040000 040000 fe6747e45736dfcba74914a9445e5f70f5120600 96358d08b65d3200928a973efb5b969b3d45f2b0 M      arch
> > 
> > 
> > If I revert this commit then kernel boots correctly. It also boots fine
> > if I revert this commit on top of master branch.
> > 
> > Freescale P2020 has two 32-bit e500 powerpc cores.
> > 
> > Any idea why above commit is causing crash of the kernel? And why it is
> > needed? Could eh flag set to 0 cause deadlock?
> 
> Setting the eh flag to 0 is not supposed to be a change introduced by 
> that commit. Indeed that commit is not supposed to change anything at 
> all in the generated code.

My understanding of that commit is that it changed eh flag parameter
from 1 to 0 for 32-bit powerpc, including also p2020.

> Christophe
> 
> > 
> > I have looked into e500 Reference Manual for lwarx instruction (page 562)
> > https://www.nxp.com/files-static/32bit/doc/ref_manual/EREF_RM.pdf and
> > both 0 and 1 values for EH flag should be supported.
