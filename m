Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E648447F89F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 20:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbhLZT4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 14:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhLZT4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 14:56:15 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D27C06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 11:56:14 -0800 (PST)
Received: from dslb-188-097-047-111.188.097.pools.vodafone-ip.de ([188.97.47.111] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n1Zcm-0000Fz-0L; Sun, 26 Dec 2021 20:56:08 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 00/21] staging: r8188eu: simplify the led layer
Date:   Sun, 26 Dec 2021 20:55:35 +0100
Message-Id: <20211226195556.159471-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set starts to clean up the led handling.

Apart from removing unused code and defines, it merges the led code
from the hal layer with the led handling in rtw_led.c and tries to
simplify the code for blinking.

Martin Kaiser (21):
  staging: r8188eu: switch the led off during deinit
  staging: r8188eu: move SwLedOn and SwLedOff into rtw_led.c
  staging: r8188eu: move (de)init functions from hal to rtw_led
  staging: r8188eu: merge InitLed871x and rtl8188eu_InitSwLeds
  staging: r8188eu: merge DeInitLed871x and rtl8188eu_DeInitSwLeds
  staging: r8188eu: make ResetLedStatus static
  staging: r8188eu: clean up the blink worker code
  staging: r8188eu: clean up blinking macros
  staging: r8188eu: remove unused blink mode defines
  staging: r8188eu: bLedStartToLinkBlinkInProgress is set but not used
  staging: r8188eu: make blink interval defines internal
  staging: r8188eu: use bool for boolean values
  staging: r8188eu: remove obsolete comments
  staging: r8188eu: remove LedControlHandler
  staging: r8188eu: LED_CTL_POWER_ON is not used
  staging: r8188eu: LED_CTL_START_WPS_BOTTON is not used
  staging: r8188eu: remove bStopBlinking
  staging: r8188eu: summarize some BlinkingLedState
  staging: r8188eu: merge blink_work and SwLedBlink1
  staging: r8188eu: merge rtw_led_control and SwLedControlMode1
  staging: r8188eu: rfoff_reason is never initialised

 drivers/staging/r8188eu/Makefile              |   1 -
 drivers/staging/r8188eu/core/rtw_led.c        | 188 +++++++++---------
 drivers/staging/r8188eu/hal/rtl8188eu_led.c   |  62 ------
 drivers/staging/r8188eu/hal/usb_halinit.c     |   1 -
 drivers/staging/r8188eu/include/hal_intf.h    |   6 -
 .../staging/r8188eu/include/rtl8188e_led.h    |  16 --
 drivers/staging/r8188eu/include/rtw_led.h     |  68 ++-----
 drivers/staging/r8188eu/include/rtw_pwrctrl.h |   1 -
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |   2 +-
 drivers/staging/r8188eu/os_dep/os_intfs.c     |   2 +-
 10 files changed, 103 insertions(+), 244 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/hal/rtl8188eu_led.c
 delete mode 100644 drivers/staging/r8188eu/include/rtl8188e_led.h

-- 
2.30.2

