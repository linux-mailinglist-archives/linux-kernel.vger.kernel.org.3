Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395F852EA7C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348365AbiETLIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345351AbiETLIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:08:04 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5D705E150;
        Fri, 20 May 2022 04:08:03 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 55FD592009C; Fri, 20 May 2022 13:08:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 5282D92009B;
        Fri, 20 May 2022 12:08:02 +0100 (BST)
Date:   Fri, 20 May 2022 12:08:02 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Paul Cercueil <paul@crapouillou.net>
cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips <linux-mips@vger.kernel.org>
Subject: Re: arch/mips/include/asm/checksum.h:195:9: error: unsupported inline
 asm: input with type 'unsigned long' matching output with type '__wsum' (aka
 'unsigned int')
In-Reply-To: <OB55CR.QAT1J8A48BK21@crapouillou.net>
Message-ID: <alpine.DEB.2.21.2205200510350.52080@angie.orcam.me.uk>
References: <202205200128.layu7VXF-lkp@intel.com> <OB55CR.QAT1J8A48BK21@crapouillou.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2022, Paul Cercueil wrote:

> About the real issue: Maybe the last "addu" in csum_tcpudp_nofold() should be
> a "daddu"?

 It doesn't matter whether there is ADDU or DADDU anymore, given that 
commit 198688edbf77 ("MIPS: Fix inline asm input/output type mismatch in 
checksum.h used with Clang") has added a redundant 32-bit sign-extension 
operation right afterwards, regressing size/performance by an extra 
instruction in this performance-critical code as a workaround for a stupid 
compiler.

 I'm not sure though why the bot has been verifying old commit 
c434b9f80b09 ("MIPS: Kconfig: add MIPS_GENERIC_KERNEL symbol") instead, 
which predates the workaround.  Perhaps current master also fails to build 
in this file for one reason or another and bisection has misled the bot 
into an unrelated commit?

  Maciej
