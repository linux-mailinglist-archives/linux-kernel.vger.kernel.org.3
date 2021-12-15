Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7344757A9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242061AbhLOLT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237168AbhLOLTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:19:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40411C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 03:19:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F27D5B81ED1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 11:19:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A529C34606;
        Wed, 15 Dec 2021 11:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639567162;
        bh=9YbZVrtooYfGPQXuXtD4hoAby2ouwQOl8IzEpQHTazg=;
        h=Date:From:To:Cc:Subject:From;
        b=pnw5hMhpLuoXzxNqlnUEA/0Uu/01g8ZV0siffkXEc0tJqRbcI3eu0wWvQApnCtg1T
         idIUYl+71C+K60s6MXe9J1cOeHMpcUcnZJlPjBISRgUrwQvBqeepKADfd95rfUdrUD
         s+s9wY5pASa0nl8+yLD/6RxY/BQraXMSplK3LYD/voR00vR4fifvl02fp5/sqEe2kW
         sDNPKBcJyWWFUcVWkMNaC9wvJMs16kIoWG4EnQVlORpGnDf2RNW3Q5/0/oBnodf81u
         8JxuHtsrRsbCy8M9sgwu93m7lHoZ+Ya/fjkG1rsrP3l/rF+8DZFHWrnC43zN56lzie
         /xS4MOJwsAtHw==
Date:   Wed, 15 Dec 2021 11:19:18 +0000
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc6
Message-ID: <20211215111917.GB16765@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this pair of arm64 fixes for -rc6. There's a fix for missing
locking around kernel page-table allocation causing a crash with
virtio-mem and a fix for a smatch warning in the kexec code where we
would return 0 on the error path.

With any luck, that's us done for the year.

Cheers,

Will

--->8

The following changes since commit 35b6b28e69985eafb20b3b2c7bd6eca452b56b53:

  arm64: ftrace: add missing BTIs (2021-12-02 10:18:32 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 4bfe24b6beb3f2d9426f8ee7b1946dc967a9d0a9:

  arm64: kexec: Fix missing error code 'ret' warning in load_other_segments() (2021-12-13 16:27:57 +0000)

----------------------------------------------------------------
arm64 fixes for -rc6

- Fix fixmap race when creating kernel page-tables

- Fix missing error code on kexec failure path

----------------------------------------------------------------
Jianyong Wu (1):
      arm64/mm: Avoid fixmap race condition when creating pud mappings

Lakshmi Ramasubramanian (1):
      arm64: kexec: Fix missing error code 'ret' warning in load_other_segments()

 arch/arm64/kernel/machine_kexec_file.c | 1 +
 arch/arm64/mm/mmu.c                    | 7 +++++++
 2 files changed, 8 insertions(+)
