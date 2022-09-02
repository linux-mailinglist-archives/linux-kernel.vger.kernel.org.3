Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D565AB585
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbiIBPnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237283AbiIBPml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:42:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28315192B9
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 08:31:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28AFB61F77
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 15:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181A7C433C1;
        Fri,  2 Sep 2022 15:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662132666;
        bh=tM2eqJiYPWb7lcDlwLvfUFbp8YVcivmRe6MBD8X0j9g=;
        h=Date:From:To:Cc:Subject:From;
        b=aBN6WO/bLRRNCIVKtVUyMoM9TEXwzyiFubgMpi38oO8WsKNRIbtpesLELG1lIetbx
         DUNOM6TTR9lsXPxt5vhEr7UdquUAfkyJ7hU+VPjQA1FXSgsI6h+BR4P9KvYe3cZ7pq
         IxIEXN3FH/VL5KL1k1Gfgrkr+KdnKAtfqSDp2QZA=
Date:   Fri, 2 Sep 2022 17:31:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core fixes for 6.0-rc4
Message-ID: <YxIht+ev+gXsF6ZD@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1c23f9e627a7b412978b4e852793c5e3c3efc555:

  Linux 6.0-rc2 (2022-08-21 17:32:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.0-rc4

for you to fetch changes up to 789bba82f63c3e81dce426ba457fc7905b30ac6e:

  firmware_loader: Fix memory leak in firmware upload (2022-09-01 17:47:27 +0200)

----------------------------------------------------------------
Driver core fixes for 6.0-rc4

Here are some small driver core fixes for some oft-reported problems in
6.0-rc1.  They include:
  - a bunch of reverts to handle driver_deferred_probe_check_state()
    problems that were part of the 6.0-rc1 merge.
  - firmware_loader bugfixes now that the code is being properly tested
    and used by others
  - arch_topology fix
  - deferred driver probe bugfix to solve a long-suffering amba bus
    problem that many people have reported.

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Florian Fainelli (1):
      arch_topology: Silence early cacheinfo errors when non-existent

Isaac J. Manjarres (1):
      driver core: Don't probe devices after bus_type.match() probe deferral

Russ Weight (2):
      firmware_loader: Fix use-after-free during unregister
      firmware_loader: Fix memory leak in firmware upload

Saravana Kannan (4):
      Revert "driver core: Delete driver_deferred_probe_check_state()"
      Revert "net: mdio: Delete usage of driver_deferred_probe_check_state()"
      Revert "PM: domains: Delete usage of driver_deferred_probe_check_state()"
      Revert "iommu/of: Delete usage of driver_deferred_probe_check_state()"

 drivers/base/arch_topology.c                |  2 +-
 drivers/base/dd.c                           | 40 +++++++++++++++++++++++++++++
 drivers/base/firmware_loader/sysfs.c        |  7 +++--
 drivers/base/firmware_loader/sysfs.h        |  5 ++++
 drivers/base/firmware_loader/sysfs_upload.c | 12 ++++++++-
 drivers/base/power/domain.c                 |  2 +-
 drivers/iommu/of_iommu.c                    |  2 +-
 drivers/net/mdio/fwnode_mdio.c              |  4 ++-
 include/linux/device/driver.h               |  1 +
 9 files changed, 66 insertions(+), 9 deletions(-)
