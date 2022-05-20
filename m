Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD53B52EB39
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348801AbiETLxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348806AbiETLxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:53:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B1C15E63E
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:52:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF67761DFD
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F6BC385A9;
        Fri, 20 May 2022 11:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653047576;
        bh=oZptL5fsiNONqFwTONEq/Jg0O0BcJkaM8ZR8aQVYHw4=;
        h=Date:From:To:Cc:Subject:From;
        b=NtuVB4/dpuMPVCP7hjFnA+Ne8bqpDeYDpI+3rdn3jCTMNF0NPixWIwh3VcLLTFHRN
         LddOGNcKKjnQUDJ8vZ2kcJVOdCoqZ/QV3aGEqlFhx6B2FuNjkPZl6eZ0gWvo9/4fgp
         wyioSp+1oxxorwkwYLZuY/pZ+yuMAK9HqaVUKM2KpF2NiqIHauVwR4pxLLY5nu8hIk
         TIbZ7QcX0CU/ba0+mem3JCvQeolLkNjsFbjOMkhiCOR5wTqOhzVSsZukeYQLtqSKpb
         yr8GHpmD9cAfHkjhO4yR3Dtfh+JH/PEwdLI7MXx7Q+TaWGUYas269qynKBYP9D43cp
         mJ4vb2Vga84RA==
Date:   Fri, 20 May 2022 12:52:51 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc8/final
Message-ID: <20220520115250.GA6700@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these three arm64 fixes for -rc8/final. The MTE and stolen
time fixes have been doing the rounds for a little while, but review
and testing feedback was ongoing until earlier this week. The kexec fix
showed up on Monday and addresses a failure observed under Qemu.

Summary in the tag. Cheers,

Will

--->8

The following changes since commit 51f559d66527e238f9a5f82027bff499784d4eac:

  arm64: Enable repeat tlbi workaround on KRYO4XX gold CPUs (2022-05-12 13:15:38 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 1d0cb4c8864addc362bae98e8ffa5500c87e1227:

  arm64: mte: Ensure the cleared tags are visible before setting the PTE (2022-05-17 14:29:51 +0100)

----------------------------------------------------------------
arm64 fixes for -rc8/final

- Add missing write barrier to publish MTE tags before a pte update

- Fix kexec relocation clobbering its own data structures

- Fix stolen time crash if a timer IRQ fires during CPU hotplug

----------------------------------------------------------------
Catalin Marinas (1):
      arm64: mte: Ensure the cleared tags are visible before setting the PTE

Mark Rutland (1):
      arm64: kexec: load from kimage prior to clobbering

Prakruthi Deepak Heragu (1):
      arm64: paravirt: Use RCU read locks to guard stolen_time

 arch/arm64/kernel/mte.c             |  3 +++
 arch/arm64/kernel/paravirt.c        | 29 +++++++++++++++++++++--------
 arch/arm64/kernel/relocate_kernel.S | 22 +++++++++++++++-------
 3 files changed, 39 insertions(+), 15 deletions(-)
