Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B1B55A59A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 02:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbiFYAlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 20:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiFYAlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 20:41:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9453D77049
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 17:41:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FA42B82D2D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 00:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF338C34114;
        Sat, 25 Jun 2022 00:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656117660;
        bh=lU23NS8nQUbjGYr2lzn5fx8XEUUBMrQ76dRDXjq9je8=;
        h=Date:From:To:Cc:Subject:From;
        b=DPZaIOLGXmUemkb1VVJqcZO5brXgDTBRmYtI/Sk0XpBS9/btQ750gYD6uV6h/AcmF
         A4rg/Gtz8uNXkPsAU8ac3pGth/vsfCRrrWoHBPe1Oc7MV+FQROs2qX/DBd1YzugyhP
         nXrBR1kXY0zgNjWGhJBo5+meV7vrHza2Q7hKG2nSKx1lPCfogy+VObvX2U/LrhSNGb
         QBHf3y/HT4qW+5N2XVDfBkqFvC/akrJIMA6WbVHW6/e2O+UIrJeNl3AJ/wBhNEPMTA
         fqxaWmjo5xhW/iCwtT0F98KlntsITJJNyVsvOnLEV/DDRfgsZ1G0hN+1M4+LEFvhre
         FcQxNO6erzS0w==
Date:   Fri, 24 Jun 2022 17:40:58 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: [GIT PULL] f2fs fix for 5.19-rc4
Message-ID: <YrZZmp8qBSDM28iy@google.com>
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

Hi Linus,

Could you please consider this pull request?

Thanks,

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.19-rc4

for you to fetch changes up to 82c7863ed95d0914f02c7c8c011200a763bc6725:

  f2fs: do not count ENOENT for error case (2022-06-21 08:29:56 -0700)

----------------------------------------------------------------
f2fs-fix-5.19

This includes some urgent fixes to avoid generating corrupted inodes
caused by compressed and inline_data files. In addition, another patch
tries to avoid wrong error report which prevents a roll-forward
recovery.

----------------------------------------------------------------
Daeho Jeong (1):
      f2fs: fix iostat related lock protection

Jaegeuk Kim (2):
      f2fs: attach inline_data after setting compression
      f2fs: do not count ENOENT for error case

 fs/f2fs/iostat.c | 31 ++++++++++++++++++-------------
 fs/f2fs/namei.c  | 17 +++++++++++------
 fs/f2fs/node.c   |  4 +++-
 3 files changed, 32 insertions(+), 20 deletions(-)
