Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD14B4F4FCD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1457600AbiDFBCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343827AbiDEKjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:39:41 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311B3220F6;
        Tue,  5 Apr 2022 03:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649154288; x=1680690288;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J5OhItcfZ7s0QhVBdaUU7HK9am4d/gzJWy/eu7nY64Y=;
  b=aFrbyF588NqioHnv9max5BgVlxQyR5SMBFf0EAaDQAn5TDyEB5ocK6q2
   wgLq7ECcK5AsS3QOUZGQbFUyL3v91EkxSR/KYmdsG7Y4jsUsGEqA+exUR
   lhBIBaXfo43rojydNGjJK9zMrrcHGIEqWc3JrB8PpaJk8ZNfLHBLVb/kL
   Jpr+In3MVweSbNce/03vqGeBejxY4m3EQumS7z6LLkF96DGL7sb+2d42o
   EekJcC9WI+6/q1i3dkk/g3GMlVo+MAE7G4hPzKClLyh5fprSDKRC+aDh4
   999Z/RUiKvDKPy6O8+ZOB+zj5sMBmd5KjhBHJQmeHEB8u5CuDRginvXxV
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="321409175"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="321409175"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 03:24:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="569821958"
Received: from ksprzacz-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.41.245])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 03:24:44 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Gilles Buloz <gilles.buloz@kontron.com>,
        Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/2] tty/serial: Process XON/XOFF robustly
Date:   Tue,  5 Apr 2022 13:24:35 +0300
Message-Id: <20220405102437.4842-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XON/XOFF are used for software flow-control on serial lines.
XON and XOFF appear as characters within the stream but should
be processed as soon as possible.

The characters received by the UART drivers are in intermediate
buffers until TTY receives them. In the case where the TTY is
not read from, the characters may get stuck into those
intermediate buffers until user-space reads from the TTY. Among
the characters stuck in the buffers, can also be those XON/XOFF
flow control characters. A stuck flow-control character is not
very useful. 

This patch series addresses the issue by checking if TTY is slow
to process characters, that is, eats less than the given amount.
If TTY is slow, a lookahead is invoked for the characters that
remain in the intermediate buffer(s).

Then at a later time, receive_buf needs to ensure the
flow-control actions are not retaken when those same characters
get pushed to TTY. The necessary guards for that are added by
the first patch of the series.

This patch series fixes an issue but I'm not able to pinpoint to
a specific commit id to provide a Fixes tag.

Ilpo Järvinen (2):
  tty: Add lookahead param to receive_buf
  tty: Implement lookahead to process XON/XOFF timely

 drivers/accessibility/speakup/spk_ttyio.c |  2 +-
 drivers/bluetooth/hci_ldisc.c             |  2 +-
 drivers/char/pcmcia/synclink_cs.c         |  2 +-
 drivers/input/serio/serport.c             |  2 +-
 drivers/isdn/capi/capi.c                  |  2 +-
 drivers/misc/ti-st/st_core.c              |  2 +-
 drivers/net/caif/caif_serial.c            |  4 +-
 drivers/net/can/slcan.c                   |  2 +-
 drivers/net/hamradio/6pack.c              |  2 +-
 drivers/net/hamradio/mkiss.c              |  2 +-
 drivers/net/mctp/mctp-serial.c            |  2 +-
 drivers/net/ppp/ppp_async.c               |  2 +-
 drivers/net/ppp/ppp_synctty.c             |  2 +-
 drivers/net/slip/slip.c                   |  2 +-
 drivers/tty/n_gsm.c                       |  2 +-
 drivers/tty/n_hdlc.c                      |  2 +-
 drivers/tty/n_null.c                      |  2 +-
 drivers/tty/n_tty.c                       | 85 ++++++++++++++++-------
 drivers/tty/serdev/serdev-ttyport.c       |  3 +-
 drivers/tty/synclink_gt.c                 |  2 +-
 drivers/tty/tty_buffer.c                  | 68 ++++++++++++++----
 drivers/tty/tty_io.c                      |  2 +-
 drivers/tty/tty_port.c                    | 27 ++++++-
 drivers/tty/vt/selection.c                |  2 +-
 include/linux/tty_buffer.h                |  1 +
 include/linux/tty_flip.h                  |  2 +-
 include/linux/tty_ldisc.h                 |  6 +-
 include/linux/tty_port.h                  |  3 +-
 net/nfc/nci/uart.c                        |  2 +-
 sound/soc/codecs/cx20442.c                |  2 +-
 sound/soc/ti/ams-delta.c                  |  2 +-
 31 files changed, 174 insertions(+), 69 deletions(-)

-- 
2.30.2

