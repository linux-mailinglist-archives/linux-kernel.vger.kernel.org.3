Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEAA57DE2A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 11:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbiGVJLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235277AbiGVJLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:11:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08251A0246
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:09:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7962D61F05
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 09:09:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9E2C341CE;
        Fri, 22 Jul 2022 09:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658480972;
        bh=QQARAL8ZRGtJnkmOAlwG2vpBW61GGATrU3fd8wEd2E8=;
        h=Date:From:To:Subject:From;
        b=FSBam89IHk8yTHAJd/n7DMeV0qmZaPp4kvWnoB7uNRhSGYYzserkXXqea0tgQ7EIr
         orVXe7hHXRnseEA6ygiBE4FeVlBgsKUZEdoXn2Km81wxhWYHh89G3RPyDKdQErt09+
         fn1qt+AbPGWO+6pvnpkJWc6XFSJ9bP3xt3/Wqt7QN7hZJbfa2G6VoqaP5eBBjpUtT3
         /c8FRieKurNl+ajzEq/43SmyxuHc1nD4EaRrvlN/49LQse4vQRrLskB+h9bdUYtsEH
         EU2hOkkdUVNEpE1za3GLh6Zd9LiAhv7VclsJAt+B+M926bd9LXiJIIVWN+GGKE9qAs
         OFXmHSLa5SjUQ==
Received: by pali.im (Postfix)
        id 99A2920A2; Fri, 22 Jul 2022 11:09:29 +0200 (CEST)
Date:   Fri, 22 Jul 2022 11:09:29 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Regression: Linux v5.15+ does not boot on Freescale P2020
Message-ID: <20220722090929.mwhmxxdd7yioxqpz@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Trying to boot mainline Linux kernel v5.15+, including current version
from master branch, on Freescale P2020 does not work. Kernel does not
print anything to serial console, seems that it does not work and after
timeout watchdog reset the board.

I run git bisect and it found following commit:

9401f4e46cf6965e23738f70e149172344a01eef is the first bad commit
commit 9401f4e46cf6965e23738f70e149172344a01eef
Author: Christophe Leroy <christophe.leroy@csgroup.eu>
Date:   Tue Mar 2 08:48:11 2021 +0000

    powerpc: Use lwarx/ldarx directly instead of PPC_LWARX/LDARX macros

    Force the eh flag at 0 on PPC32.

    Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
    Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
    Link: https://lore.kernel.org/r/1fc81f07cabebb875b963e295408cc3dd38c8d85.1614674882.git.christophe.leroy@csgroup.eu

:040000 040000 fe6747e45736dfcba74914a9445e5f70f5120600 96358d08b65d3200928a973efb5b969b3d45f2b0 M      arch


If I revert this commit then kernel boots correctly. It also boots fine
if I revert this commit on top of master branch.

Freescale P2020 has two 32-bit e500 powerpc cores.

Any idea why above commit is causing crash of the kernel? And why it is
needed? Could eh flag set to 0 cause deadlock?

I have looked into e500 Reference Manual for lwarx instruction (page 562)
https://www.nxp.com/files-static/32bit/doc/ref_manual/EREF_RM.pdf and
both 0 and 1 values for EH flag should be supported.
