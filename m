Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D154256CACD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 19:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiGIRKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 13:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiGIRKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 13:10:21 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B8C120A6
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 10:10:21 -0700 (PDT)
Received: from dslb-188-096-144-007.188.096.pools.vodafone-ip.de ([188.96.144.7] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oADy7-0005n0-U8; Sat, 09 Jul 2022 19:10:12 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 00/14] clean up efuse reading
Date:   Sat,  9 Jul 2022 19:09:46 +0200
Message-Id: <20220709171000.180481-1-martin@kaiser.cx>
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

Simplify the code that reads config data from the efuses.

Martin Kaiser (14):
  staging: r8188eu: remove unused eeprom defines
  staging: r8188eu: remove EepromOrEfuse from struct eeprom_priv
  staging: r8188eu: remove eeprom function prototypes
  staging: r8188eu: merge EFUSE_ShadowMapUpdate with its caller
  staging: r8188eu: use a local buffer for efuse data
  staging: r8188eu: always initialise efuse buffer with 0xff
  staging: r8188eu: use memcpy for fallback mac address
  staging: r8188eu: merge ReadEFuseByIC into rtl8188e_ReadEFuse
  staging: r8188eu: txpktbuf_bndy is always 0
  staging: r8188eu: offset is always 0 in rtl8188e_ReadEFuse
  staging: r8188eu: offset is always 0 in iol_read_efuse
  staging: r8188eu: _offset is always 0 in efuse_phymap_to_logical
  staging: r8188eu: efuse_utilized is never read
  staging: r8188eu: the bcnhead parameter is always 0

 drivers/staging/r8188eu/core/rtw_efuse.c      | 30 ------------
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 47 ++++---------------
 drivers/staging/r8188eu/hal/usb_halinit.c     | 33 +++++++------
 drivers/staging/r8188eu/include/hal_intf.h    |  4 +-
 .../staging/r8188eu/include/rtl8188e_spec.h   |  6 ---
 drivers/staging/r8188eu/include/rtw_eeprom.h  | 10 ----
 drivers/staging/r8188eu/include/rtw_efuse.h   |  2 -
 7 files changed, 29 insertions(+), 103 deletions(-)

-- 
2.30.2

