Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F77958B80C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 21:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbiHFTz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 15:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiHFTzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 15:55:55 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A7F261E
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 12:55:54 -0700 (PDT)
Received: from dslb-188-097-043-167.188.097.pools.vodafone-ip.de ([188.97.43.167] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oKPtk-0004Tu-QR; Sat, 06 Aug 2022 21:55:48 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 00/13] staging: r8188eu: simplify endpoint configuration
Date:   Sat,  6 Aug 2022 21:55:27 +0200
Message-Id: <20220806195540.777390-1-martin@kaiser.cx>
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

This series contains cleanups for rtl8188eu_interface_configure and the
functions that it calls. I tried to fix the error handling and to
summarize small functions and common code.

Martin Kaiser (13):
  staging: r8188eu: Hal_MappingOutPipe should return an int
  staging: r8188eu: process HalUsbSetQueuePipeMapping8188EUsb's return
    value
  staging: r8188eu: merge two small functions
  staging: r8188eu: move endpoint init functions to usb_halinit.c
  staging: r8188eu: summarize endpoint-related settings
  staging: r8188eu: remove OutEpNumber
  staging: r8188eu: remove comments about endpoint mapping
  staging: r8188eu: summarize common Queue2Pipe settings
  staging: r8188eu: simplify three_out_pipe
  staging: r8188eu: simplify two_out_pipe
  staging: r8188eu: remove _InitNormalChipOneOutEpPriority
  staging: r8188eu: we always use HQ and NQ for two endpoints
  staging: r8188eu: simplify _InitNormalChipTwoOutEpPriority

 drivers/staging/r8188eu/hal/hal_com.c         | 110 -------------
 drivers/staging/r8188eu/hal/usb_halinit.c     | 152 ++++++++----------
 drivers/staging/r8188eu/include/hal_com.h     |   2 -
 drivers/staging/r8188eu/include/hal_intf.h    |   2 +-
 .../staging/r8188eu/include/rtl8188e_hal.h    |   1 -
 drivers/staging/r8188eu/os_dep/usb_intf.c     |   4 +-
 6 files changed, 75 insertions(+), 196 deletions(-)

-- 
2.30.2

