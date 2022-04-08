Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36814F9450
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 13:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbiDHLmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 07:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiDHLmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:42:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CC739816;
        Fri,  8 Apr 2022 04:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649418006; x=1680954006;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BvS9CZuns0lpFI7GkDa3syT/aVot97NbDMxoh6m25JM=;
  b=fOF4AbrAr1khbMbYvw0U+ziU3Rzeb891KrUyOo9LruOLXgxPFE8O1M/4
   C2ZQ6N5Py/smv8ZmUkm+8blkOkPXI7O89FVcCyEsTuQ0s0+0oeMjsfDUT
   TOhuwIWVm5f+HK7WgUXrT2DKilcSeo2czwUnqIB5ovjrYxecGiqFUerVH
   fVop1QGtYDP457Z7yrpboR6uBUseQXFhTbYGEw32NYDcOA54mJERD2eGg
   mm9Kln+UclK7ieq7ahlqkdwS6vOiPIPNUAdoTUMNyumEnIZ1CJOhMrI41
   4Wucu/xbRFzBl1KlOYkd8n6GiPXqe3iEPVcDFtRBwWC2N0aOppSpNQZYv
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="261749118"
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="261749118"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 04:40:06 -0700
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="571462625"
Received: from aecajiao-mobl.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.48.54])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 04:40:03 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Gilles Buloz <gilles.buloz@kontron.com>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 0/3] tty/serial: Process XON/XOFF robustly
Date:   Fri,  8 Apr 2022 14:39:51 +0300
Message-Id: <20220408113954.9749-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
a specific commit id to provide a Fixes tag.

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

Ilpo Järvinen (3):
  tty: Add functions for handling flow control chars
  tty: Add lookahead param to receive_buf
  tty: Implement lookahead to process XON/XOFF timely

 drivers/accessibility/speakup/spk_ttyio.c |  2 +-
 drivers/bluetooth/hci_ldisc.c             |  2 +-
 drivers/char/pcmcia/synclink_cs.c         |  2 +-
 drivers/input/serio/serport.c             |  4 +-
 drivers/isdn/capi/capi.c                  |  2 +-
 drivers/misc/ti-st/st_core.c              |  2 +-
 drivers/net/caif/caif_serial.c            |  4 +-
 drivers/net/can/slcan.c                   |  2 +-
 drivers/net/hamradio/6pack.c              |  4 +-
 drivers/net/hamradio/mkiss.c              |  2 +-
 drivers/net/mctp/mctp-serial.c            |  2 +-
 drivers/net/ppp/ppp_async.c               |  2 +-
 drivers/net/ppp/ppp_synctty.c             |  2 +-
 drivers/net/slip/slip.c                   |  2 +-
 drivers/tty/n_gsm.c                       |  2 +-
 drivers/tty/n_hdlc.c                      |  2 +-
 drivers/tty/n_null.c                      |  2 +-
 drivers/tty/n_tty.c                       | 99 ++++++++++++++++-------
 drivers/tty/serdev/serdev-ttyport.c       |  3 +-
 drivers/tty/synclink_gt.c                 |  2 +-
 drivers/tty/tty_buffer.c                  | 67 ++++++++++++---
 drivers/tty/tty_io.c                      |  2 +-
 drivers/tty/tty_port.c                    | 26 +++++-
 drivers/tty/vt/selection.c                |  2 +-
 include/linux/tty_buffer.h                |  1 +
 include/linux/tty_flip.h                  |  2 +-
 include/linux/tty_ldisc.h                 | 31 +++++--
 include/linux/tty_port.h                  |  5 +-
 net/nfc/nci/uart.c                        |  2 +-
 sound/soc/codecs/cx20442.c                |  2 +-
 sound/soc/ti/ams-delta.c                  |  2 +-
 31 files changed, 205 insertions(+), 81 deletions(-)

-- 
2.30.2

