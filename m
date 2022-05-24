Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2981533361
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 00:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242089AbiEXWPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 18:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiEXWPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 18:15:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E91E5E153;
        Tue, 24 May 2022 15:15:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A364B81A2E;
        Tue, 24 May 2022 22:15:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C34DC34115;
        Tue, 24 May 2022 22:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653430531;
        bh=A9MhQ1zdr/PKqFxd0NDOhzZqxPvlwBFI325zkFI2P4M=;
        h=Date:From:To:Cc:Subject:From;
        b=Ej79J1Zbj5LNO5TpxQ8nlvqwYMJkFjI0FR5ieUnmYR7Vsp6wWEPsF4eGkGsQrdi9P
         b/Mj8r5Qd6IEsaR8SRoIk8AaZMGz9Uz/vvoCyhsWxrTRku45PprUdAFIb9a/Az54iV
         aEqqU6wVk7cIOz3RIuxlb9Z67ruTGkg68ViaXk3kYXMyC9G4IwZDTSlDmY155X0m7q
         qnKMx1BL1XCk/HxnNXlMNd0ROddwj/wkGGcHnOo1Neo8z/WD6bYUmGN3aeLJQrBw/U
         s4tZ8MmEEi5GsXr2SK8haWRW0E6dU1NyCge4qgjnmiwboVFjpX9kED7c35IG3tE0Zc
         djvA9Gs+bp0Ig==
Date:   Tue, 24 May 2022 17:25:05 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [GIT PULL] -Wstringop-overflow fixes for 5.19-rc1
Message-ID: <20220524222505.GA7242@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e:

  Linux 5.18-rc2 (2022-04-10 14:21:36 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/Wstringop-overflow-fixes-5.19-rc1

for you to fetch changes up to 336feb502a715909a8136eb6a62a83d7268a353b:

  drm/i915: Fix -Wstringop-overflow warning in call to intel_read_wm_latency() (2022-05-04 14:59:26 -0500)

----------------------------------------------------------------
Wstringop-overflow fixes for 5.19-rc1

Hi Linus,

Please, pull the following patches that fix some -Wstringop-overflow
warnings when building with GCC-11. All the patches have been in
linux-next during the last development cycle.

This is part of the ongoing efforts to globally enable
-Wstringop-overflow.

Thanks
--
Gustavo

----------------------------------------------------------------
Gustavo A. R. Silva (3):
      scsi: fcoe: Fix Wstringop-overflow warnings in fcoe_wwn_from_mac()
      drm/amd/display: Fix Wstringop-overflow warnings in dc_link_dp.c
      drm/i915: Fix -Wstringop-overflow warning in call to intel_read_wm_latency()

 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 4 ++--
 drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h  | 4 ++--
 drivers/gpu/drm/i915/intel_pm.c                  | 2 +-
 drivers/scsi/fcoe/fcoe_ctlr.c                    | 2 +-
 include/scsi/libfcoe.h                           | 3 ++-
 5 files changed, 8 insertions(+), 7 deletions(-)
