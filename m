Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63824AA85D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 12:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346833AbiBELiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 06:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344326AbiBELh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 06:37:56 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C84C061348
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 03:37:53 -0800 (PST)
Received: from dslb-188-104-059-100.188.104.pools.vodafone-ip.de ([188.104.59.100] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nGJNy-0005c9-8h; Sat, 05 Feb 2022 12:37:46 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/8] staging: r8188eu: more rf cleanups
Date:   Sat,  5 Feb 2022 12:37:33 +0100
Message-Id: <20220205113741.379070-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's another set with cleanups of the rf configuration code.

The last of the patches is "testing the water". It seems that this driver
uses only RF_PATH_A and we can eventually drop all RF_PATH_B handling. At
the moment, the only way to access RF_PATH_B registers is via private
ioctls. I'd like to restrict them to path A.

As usual, this series was t ested with EdimaxV2 on an arm32 embedded system.

Martin Kaiser (8):
  staging: r8188eu: TXPowercount is set but not used
  staging: r8188eu: TXPowerTrackingCallbackCnt is set but not used
  staging: r8188eu: bTXPowerTrackingInit is set but not used
  staging: r8188eu: bTXPowerTracking is set but not used
  staging: r8188eu: remove constant rf variable
  staging: r8188eu: RfRegChnlVal[1] is set but not used
  staging: r8188eu: use a define for the radio path
  staging: r8188eu: limit rf register writes to path a

 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  | 24 ++++++-------------
 drivers/staging/r8188eu/hal/odm.c             |  3 ---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |  4 ++--
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c |  8 +++----
 drivers/staging/r8188eu/hal/usb_halinit.c     |  3 +--
 drivers/staging/r8188eu/include/odm.h         |  4 ----
 .../staging/r8188eu/include/rtl8188e_hal.h    |  2 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  3 +++
 8 files changed, 18 insertions(+), 33 deletions(-)

-- 
2.30.2

