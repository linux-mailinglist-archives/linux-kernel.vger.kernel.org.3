Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2959D51483E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358451AbiD2LhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350409AbiD2LhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:37:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFF256748
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 04:34:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F536B83405
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:34:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB1DC385A4;
        Fri, 29 Apr 2022 11:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651232039;
        bh=ZVDBkHAHQ++GPV+WzTprfM5+WXb+YMUsY27sgqX+kfg=;
        h=Date:From:To:Cc:Subject:From;
        b=aizf64sbkPgnP2BH5d6SJTa3GtUTMUZ2rOyLcV3A094TJAm9mK09EOJ349dJmIz96
         oIdMFg6NBKlnnY58USTe8DemLpOT270ujWWQ6R3EjE0KK7fEit05qYUc48+jdtDcs0
         65VHaaCvWZF54AUwwrTvbj66HCo1/DESpg62BkZqymUhuEuXb6L0cmgVQQa8CqChDl
         8WdtjHSUl6OihLk0mK7NtwapmCZNcmLxL3IYoh/RVuORoVfyhV9tV8l6wRQaMnYGfb
         XXI/YtO+tbXHZ2eB8HbDIYnoPA7cgLgVn6SIL7GwjLS5HoDiOB0KBBBco0eDLT0TpD
         ie9/4ZR1tri6w==
Date:   Fri, 29 Apr 2022 12:33:54 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        luis.machado@arm.com
Subject: [GIT PULL] arm64 fix for -rc5
Message-ID: <20220429113353.GA16032@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this fix to the MTE ELF ABI for a but that was added during
the most recent merge window as part of the coredump support. The issue
is that the value assigned to the new PT_ARM_MEMTAG_MTE segment type has
already been allocated to PT_AARCH64_UNWIND by the ELF ABI, so we've
bumped the value and changed the name of the identifier to be better
aligned with the existing one.

Cheers,

Will

--->8

The following changes since commit 23bc8f69f0eceecbb87c3801d2e48827d2dca92b:

  arm64: mm: fix p?d_leaf() (2022-04-22 11:28:36 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to c35fe2a68f29a0bda15ae994154cacaae5f69791:

  elf: Fix the arm64 MTE ELF segment name and value (2022-04-28 11:37:06 +0100)

----------------------------------------------------------------
arm64 fix for -rc5

- Rename and reallocate the PT_ARM_MEMTAG_MTE ELF segment type

----------------------------------------------------------------
Catalin Marinas (1):
      elf: Fix the arm64 MTE ELF segment name and value

 Documentation/arm64/memory-tagging-extension.rst | 4 ++--
 arch/arm64/kernel/elfcore.c                      | 2 +-
 include/uapi/linux/elf.h                         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)
