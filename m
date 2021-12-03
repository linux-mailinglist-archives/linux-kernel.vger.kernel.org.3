Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE07467813
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380350AbhLCNXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:23:19 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48416 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380409AbhLCNXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:23:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C9E662A4B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 13:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C40C53FAD;
        Fri,  3 Dec 2021 13:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638537583;
        bh=LM3IvW6tyw+wXNHiyZ9pLHq/xH80ZhSAffxzn3xw+TA=;
        h=Date:From:To:Cc:Subject:From;
        b=pKuTex03s2Rllks4GEm3EKOJlMGeDJVexpIGR1wsllueJug/HUbPBQplRghv3Ifml
         tAoC6i+VPe+wsn1UTdmhFTxOOedt49F2/1slkSDoIPXF6Z+qyX/29AM3wsAEalQCVS
         4Dkqi2vZJ6hyLUFdm2aRD2Te5tymc+ZYp7zswvKm9IOfW3TyTVUqHxnAysb8Jnpano
         ZdLBgRw78QWgOgqL3gJdIxas87qFC68erwE9S4mAxuON/+iMueYt0l1CX0gBzD1i6J
         snqN2GRSHMPqYsTMWCqzVRGe7GHXi6PYXB1xLGNwY+nAs+zxsN5j4eFDvlEgkAPOz8
         HFFyqzMhOcUmQ==
Date:   Fri, 3 Dec 2021 13:19:38 +0000
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc4
Message-ID: <20211203131937.GA27943@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these three arm64 fixes for -rc4. One of them is just a
trivial documentation fix, whereas the other two address a warning in
the kexec code and a crash in ftrace on systems implementing BTI. The
latter patch has a couple of ugly ifdefs which Mark plans to clean up
separately, but as-is the patch is straightforward for backporting to
stable kernels.

Cheers,

Will

--->8

The following changes since commit 94902d849e85093aafcdbea2be8e2beff47233e6:

  arm64: uaccess: avoid blocking within critical sections (2021-11-24 09:16:26 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 35b6b28e69985eafb20b3b2c7bd6eca452b56b53:

  arm64: ftrace: add missing BTIs (2021-12-02 10:18:32 +0000)

----------------------------------------------------------------
arm64 fixes for -rc4

- Add missing BTI landing instructions to the ftrace*_caller trampolines

- Fix kexec() WARN when DEBUG_VIRTUAL is enabled

- Fix PAC documentation by removing stale references to compiler flags

----------------------------------------------------------------
Kuan-Ying Lee (1):
      arm64: update PAC description for kernel

Mark Rutland (2):
      arm64: kexec: use __pa_symbol(empty_zero_page)
      arm64: ftrace: add missing BTIs

 Documentation/arm64/pointer-authentication.rst | 9 ++++-----
 arch/arm64/kernel/entry-ftrace.S               | 6 ++++++
 arch/arm64/kernel/machine_kexec.c              | 2 +-
 3 files changed, 11 insertions(+), 6 deletions(-)
