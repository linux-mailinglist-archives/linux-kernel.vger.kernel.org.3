Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B04B4D52F6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 21:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244740AbiCJURD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 15:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiCJURA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 15:17:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3F515C1AC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 12:15:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A0A1B826EE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 20:15:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3363BC340E9;
        Thu, 10 Mar 2022 20:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646943356;
        bh=ak+v21TU0T7xdjHzfC5DTvQ+6ElifXCS3gGz+2uZCu0=;
        h=Date:From:To:Cc:Subject:From;
        b=xFw9q3PUtkr/fx+2yGAem7DF31e/ARSI3GJye80gNtF1h0m1NZ+KJDIY+VjUSbQRZ
         5Y7mpNVZQqbTzLkjRtOs/tGrNyjD9RJdw+mPknuHeCs7gtzc9IoM2V3FXAa9PwbwGK
         WKejIqhJv1ZxKnMWlpZ+q2LO9122Za5c1f5vYMbA=
Date:   Thu, 10 Mar 2022 21:15:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver fixes for 5.17-rc8
Message-ID: <YipceDbnLhoJKnWW@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3:

  Linux 5.17-rc6 (2022-02-27 14:36:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.17-rc8

for you to fetch changes up to 342e7c6ea58200e45bcaa9bdd8402a5531c4777e:

  staging: rtl8723bs: Improve the comment explaining the locking rules (2022-03-02 16:38:24 +0100)

----------------------------------------------------------------
Staging driver fixes for 5.17-rc8

Here are 3 small fixes for staging drivers for 5.17-rc8 or -final, which
ever comes next.

They resolve some reported problems:
	- rtl8723bs wifi driver deadlock fix for reported problem that
	  is a revert of a previous patch.  Also a documentation fix is
	  added so that the same problem hopefully can not come back
	  again.
	- gdm724x driver use-after-free fix for a reported problem.

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Dan Carpenter (1):
      staging: gdm724x: fix use after free in gdm_lte_rx()

Hans de Goede (2):
      staging: rtl8723bs: Fix access-point mode deadlock
      staging: rtl8723bs: Improve the comment explaining the locking rules

 drivers/staging/gdm724x/gdm_lte.c              |  5 +++--
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c  |  7 +++++--
 drivers/staging/rtl8723bs/core/rtw_recv.c      | 10 +++++++---
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c   | 22 ++++++++++------------
 drivers/staging/rtl8723bs/core/rtw_xmit.c      | 16 +++++++++-------
 drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c |  2 ++
 drivers/staging/rtl8723bs/include/rtw_mlme.h   |  8 ++++++--
 7 files changed, 42 insertions(+), 28 deletions(-)
