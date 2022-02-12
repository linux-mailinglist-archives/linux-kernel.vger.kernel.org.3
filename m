Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECF04B364E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 17:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbiBLQRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 11:17:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236934AbiBLQRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 11:17:53 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EF0181
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 08:17:50 -0800 (PST)
Received: from dslb-188-097-215-215.188.097.pools.vodafone-ip.de ([188.97.215.215] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nIv5k-0007YM-8o; Sat, 12 Feb 2022 17:17:44 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 00/10] remove rf register access for path b
Date:   Sat, 12 Feb 2022 17:17:27 +0100
Message-Id: <20220212161737.381841-1-martin@kaiser.cx>
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

This patch set removes rf register access to the registers of rf path b.

The r8188eu driver seems to use only rf path a. The private ioctls were
the only way to access rf path b registers. We limit these ioctls to rf
path a and we can then remove the code to read and write path b registers.

Martin Kaiser (10):
  staging: r8188eu: set path a explicitly
  staging: r8188eu: write only path a registers in rtw_dbg_port
  staging: r8188eu: remove path parameter from rtl8188e_PHY_SetRFReg
  staging: r8188eu: remove path parameter from phy_RFSerialWrite
  staging: r8188eu: clarify that bb_reg_dump uses only path a
  staging: r8188eu: limit rtw_wx_read_rf to path a
  staging: r8188eu: limit rtw_dbg_port to path a
  staging: r8188eu: remove path parameter from rtl8188e_PHY_QueryRFReg
  staging: r8188eu: remove path parameter from phy_RFSerialRead
  staging: r8188eu: we only need one struct bb_reg_def for path a

 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  | 34 ++++----
 drivers/staging/r8188eu/hal/odm.c             |  2 +-
 .../staging/r8188eu/hal/odm_RegConfig8188E.c  |  2 +-
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 85 ++++++-------------
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c |  6 +-
 drivers/staging/r8188eu/hal/usb_halinit.c     |  2 +-
 .../staging/r8188eu/include/Hal8188EPhyCfg.h  |  6 +-
 .../staging/r8188eu/include/rtl8188e_hal.h    |  2 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  | 27 ++++--
 9 files changed, 72 insertions(+), 94 deletions(-)

-- 
2.30.2

