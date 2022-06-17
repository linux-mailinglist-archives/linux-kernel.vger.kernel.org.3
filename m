Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FD354F299
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380663AbiFQIPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 04:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380002AbiFQIPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:15:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C7460A83
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:15:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B597861FA8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 08:15:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2F0C3411B;
        Fri, 17 Jun 2022 08:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655453714;
        bh=VNrHOYlngN9BjqwFqVMKldZsuLMNEh+W1VBvqJXopb4=;
        h=Date:From:To:Cc:Subject:From;
        b=sa7mM+OLUzN4SbCus82sNM5VOFI99u3yN2xrG3NDmm1dVdF/LT2Yxl/pu2sV2TbI6
         vB2QTQx4U0RhvqHbcReQxRZ/hrfM4Y2XDnZGRakfiESMBtNfNd0iD1Dms8lyN4Iu2W
         nS25MABDLlZUpIUJoXSmPgsQOGrRrLuoBXyHRFmM=
Date:   Fri, 17 Jun 2022 10:15:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver fixes for 5.19-rc3
Message-ID: <Yqw4DynMEtAcZVim@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.19-rc3

for you to fetch changes up to cd756dafd86ee3a4969906086f3c2537e0c6d9d0:

  staging: Also remove the Unisys visorbus.h (2022-06-10 15:36:49 +0200)

----------------------------------------------------------------
Staging driver fixes for 5.19-rc3

Here are some small staging driver fixes for 5.19-rc3 that resolve
reported issues:
	- remove visorbus.h which was forgotten in the -rc1 merge where
	  the code that used it was removed
	- olpc_dcon: mark as broken to allow the DRM developers to
	  evolve the fbdev api properly without having to deal with this
	  obsolete driver.  It will be removed soon if no one steps up
	  to adopt it and fix the issues with it.
	- rtl8723bs driver fix
	- r8188eu driver fix to resolve many reports of the driver being
	  broken with -rc1.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Javier Martinez Canillas (1):
      staging: olpc_dcon: mark driver as broken

Kees Cook (1):
      staging: rtl8723bs: Allocate full pwep structure

Larry Finger (1):
      staging: r8188eu: Fix warning of array overflow in ioctl_linux.c

Peter Robinson (1):
      staging: Also remove the Unisys visorbus.h

Phillip Potter (1):
      staging: r8188eu: fix rtw_alloc_hwxmits error detection for now

 drivers/staging/olpc_dcon/Kconfig              |   2 +-
 drivers/staging/r8188eu/core/rtw_xmit.c        |  20 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c   |   2 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c |   6 +-
 include/linux/visorbus.h                       | 344 -------------------------
 5 files changed, 11 insertions(+), 363 deletions(-)
 delete mode 100644 include/linux/visorbus.h
