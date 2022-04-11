Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186264FB87D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244173AbiDKJyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344741AbiDKJv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:51:58 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CAE41608;
        Mon, 11 Apr 2022 02:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649670550; x=1681206550;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lOvhs1gLn3Chz4uDvWH7ydj7JGaX1rFO0gXpagJqwfk=;
  b=GwQ80Wp7ZLrOG8nuesbuuIbF9YZjMZfKnygN1w2/9eCCKgKKO4YT5ebv
   vKbK9bUyNdJOcLH/im/AO6crfGsCurhDD3fEV7Gv9Wsnuf8pm9U79+WnD
   ixd2ZVcx1uyeh33ufX1yBmPldM1dYot2wnf8VEC/PutFGyX5OHTIjii3B
   lmtHLwXw5Qe5iSoJnqhNtvs7NZi/ehuRHQ/jmkbjbjrZekXp3udgnY0kN
   Wq1zynWuRgiob8wvrow1YYk3PCum2w4L+G0XpB5y2yHTlwoHuFbpuFQ4p
   fesJm2D7Dw98GhWPouBC0vbeYzhlZMDSK68cpPqfLs6OddYTaQRiacci2
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="242014180"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="242014180"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 02:49:10 -0700
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="572053756"
Received: from azahoner-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.232])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 02:49:07 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Gilles Buloz <gilles.buloz@kontron.com>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 0/5] tty/serial: Process XON/XOFF robustly
Date:   Mon, 11 Apr 2022 12:48:54 +0300
Message-Id: <20220411094859.10894-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
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
the second patch of the series.

This patch series fixes an issue but I'm not able to pinpoint to
a specific commit id to provide a Fixes tag. The last patch of
the series is not needed for minimal fix (and has a small chance
of regression too), thus that patch shouldn't be sent to stable.

v1 -> v2:
- Add flow ctrl char funcs in separate change & rework logic a bit.
  I believe it's now cleaner than it would have been with the
  suggestions during v1 review, please recheck.
- Renamed n_tty_lookahead_special to n_tty_lookahead_flow_ctrl
- Fixed logic for START_CHAR == STOP_CHAR case
- Use unsigned int for lookahead_count in receive_buf call chain
- Use consistent types in lookahead call chain
- Improved indentation & line splits for function params
- Corrected tty_ldisc.h comments documenting tty_ldisc_ops
- Tweaked comment format

v2 -> v3:
- Split preparatory patch moving/rearranging code to two
- Fix closing path giving change for ... || xx to execute
  instead of skipping the flow-control char
- Use the same flow-control char function on closing path
  (just a cleanup, non-fix as last patch, a small change of
  regression exists)

Ilpo Järvinen (5):
  tty: Add function for handling flow control chars
  tty: Simplify receive flow control char logic
  tty: Add lookahead param to receive_buf
  tty: Implement lookahead to process XON/XOFF timely
  tty: Use flow-control char function on closing path

 drivers/accessibility/speakup/spk_ttyio.c |   2 +-
 drivers/bluetooth/hci_ldisc.c             |   2 +-
 drivers/char/pcmcia/synclink_cs.c         |   2 +-
 drivers/input/serio/serport.c             |   4 +-
 drivers/isdn/capi/capi.c                  |   2 +-
 drivers/misc/ti-st/st_core.c              |   2 +-
 drivers/net/caif/caif_serial.c            |   4 +-
 drivers/net/can/slcan.c                   |   2 +-
 drivers/net/hamradio/6pack.c              |   4 +-
 drivers/net/hamradio/mkiss.c              |   2 +-
 drivers/net/mctp/mctp-serial.c            |   2 +-
 drivers/net/ppp/ppp_async.c               |   2 +-
 drivers/net/ppp/ppp_synctty.c             |   2 +-
 drivers/net/slip/slip.c                   |   2 +-
 drivers/tty/n_gsm.c                       |   2 +-
 drivers/tty/n_hdlc.c                      |   2 +-
 drivers/tty/n_null.c                      |   2 +-
 drivers/tty/n_tty.c                       | 102 +++++++++++++++-------
 drivers/tty/serdev/serdev-ttyport.c       |   3 +-
 drivers/tty/synclink_gt.c                 |   2 +-
 drivers/tty/tty_buffer.c                  |  67 +++++++++++---
 drivers/tty/tty_io.c                      |   2 +-
 drivers/tty/tty_port.c                    |  26 +++++-
 drivers/tty/vt/selection.c                |   2 +-
 include/linux/tty_buffer.h                |   1 +
 include/linux/tty_flip.h                  |   2 +-
 include/linux/tty_ldisc.h                 |  31 +++++--
 include/linux/tty_port.h                  |   5 +-
 net/nfc/nci/uart.c                        |   2 +-
 sound/soc/codecs/cx20442.c                |   2 +-
 sound/soc/ti/ams-delta.c                  |   2 +-
 31 files changed, 205 insertions(+), 84 deletions(-)

-- 
2.30.2

